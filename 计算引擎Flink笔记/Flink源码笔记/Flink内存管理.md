基于 JVM 的大数据处理分析引擎面临的一个问题是，为了高效地处理数据，有大量的数据需要保存在内存中。直接使用 JVM 堆内存来管理这些数据对象是最简单的实现，但是这样会导致一系列问题：首先，在有大量的数据对象不停地创建和失效的情况下，要正常地管理和控制堆内存并非易事，很容易引发 OOM 问题；其次，GC 会严重影响性能，尤其是为了处理海量数据而分配了较大的内存空间，GC 开销很容易就能达到 50% 以上；最后，Java 对象存储本身存在开销，对于那种本身是小对象的数据集而言，对象头、对齐填充这些存储开销非常浪费。

为了解决上述的问题，主流的数据处理引擎如 Spark、Flink 等有一套自己的内存管理机制，这套内存管理机制看上去更贴近 C/C++，接下来我们将分析 Flink 是如何管理内存的。

##  TaskManager 的内存布局

Flink 内部并非直接将对象存储在堆上，而是将对象序列化到一个个预先分配的 `MemorySegment` 中。`MemorySegment` 是一段固定长度的内存（默认32KB），也是 Flink 中最小的内存分配单元。`MemorySegment` 提供了高效的读写方法，它的底层可以是堆上的 byte[], 也可以是堆外（off-heap）ByteBuffer。可以把 `MemorySegment` 看作 Java NIO 中的 ByteBuffer，Flink 还实现了 Java 的 `java.io.DataOutput` 和 `java.io.DataInput` 接口，分别是 `AbstractPagedInputView` 和 `AbstractPagedOutputView`, 可以通过一种逻辑视图的方式来操作连续的多块 `MemorySegment`。

在 Flink 中，TaskManager 负责任务的实际运行，通常一个 TaskManager 对应一个 JVM 进程（非 MiniCluster 模式）。抛开 JVM 内存模型，单从 TaskManager 内存的主要使用方式来看，TaskManager 的内存主要分为三个部分：

- Network Buffers：一定数量的 `MemorySegment`, 主要用于网络传输。在 TaskManager 启动时分配， 通过 `NetworkEnvironment` 和 `NetworkBufferPool` 进行管理
- Managed Memory：由 `MemoryManager` 管理的一组 `MemorySegment` 集合， 主要用于 Batch 模式下的 sorting, hashing, 和 cache 等。
- Remaining JVM heap：余下的堆内存留给 `TaskManager` 的数据结构以及用户代码处理数据时使用。TaskManager 自身的数据结构并不会占用太多内存，因而主要都是供用户代码使用，用户代码创建的对象通常生命周期都较短

需要注意的是，上面所说的三部分的内存并非都是 JVM 堆上的内存，因为 `MemorySegment` 底层的内存可以在堆上，也可以在堆外（不由 JVM 管理）。对于 Network Buffers，这一部分内存就是在堆外（off-heap）进行分配的；对于 Managed Memory，这一部分内存可以配置在堆上，也可以配置在堆外。另外还需要注意的一点是，Managed Memory 主要是在 Batch 模式下使用，在 Streaming 模式下这一部分内存并不会预分配，因而空闲出来的内存其实都是可以给用户自定义函数使用的。

## 通过二进制数据管理对象

我们已经知道，Flink 是通过 `MemorySegment` 来管理数据对象的，因而对象首先需要被序列化保存到 `MemorySegment` 中。在 Java 的生态系统中，已经存在很多现有的序列化框架了，如 Java 自带的序列化机制、Kryo、Avro、Thrift、Protobuf 等，但 Flink 也实现了一套自己的序列化框架。这主要是出于以下考虑：首先，比较和操作二进制数据需要准确了解序列化的布局，针对二进制数据的操作来配置序列化的布局可以显著提升性能；其次，对于 Flink 应用而言，它所处理的数据对象类型通常是完全已知的，由于数据集对象的类型固定，对于数据集可以只保存一份对象 Schema 信息，可以进一步节省存储空间。

Flink 可以处理任意的 Java 或 Scala 对象，而不必实现特定的接口。对于 Java 实现的 Flink 程序，Flink 会通过反射框架获取用户自定义函数返回的类型；而对于 Scala 实现的 Flink 程序，则通过 Scala Compiler 分析用户自定义函数返回的类型。每一种数据类型都对应一个 `TypeInfomation`。

- `BasicTypeInfo`: 基本类型（装箱的）或 String 类型
- `BasicArrayTypeInfo`: 基本类型数组（装箱的）或 String 数组
- `WritableTypeInfo`: 任意 Hadoop Writable 接口的实现类
- `TupleTypeInfo`: 任意的 Flink Tuple 类型 (支持Tuple1 to Tuple25)
- `CaseClassTypeInfo`: 任意的 Scala CaseClass (包括 Scala tuples)
- `PojoTypeInfo`: 任意的 POJO (Java or Scala)，Java对象的所有成员变量，要么是 public 修饰符定义，要么有 getter/setter 方法
- `GenericTypeInfo`: 任意无法匹配之前几种类型的类

通过 `TypeInfomation` 可以获取到对应数据类型的序列化器 `TypeSerializer`。对于 `BasicTypeInfo`，Flink 提供了对应的序列化器；对于 `WritableTypeInfo`, Flink 会将序列化和反序列化操作委托给 Hadoop Writable 接口的 `write()` and `readFields()`；对于 `GenericTypeInfo`， Flink 默认使用 Kyro 进行序列化；而 `TupleTypeInfo`、`CaseClassTypeInfo` 和 `PojoTypeInfo` 是一种组合类型，序列化时分别委托给成员的序列化器进行序列化即可。

对于可以用作 key 的数据类型，`TypeInfomation` 还可以生成 `TypeComparator`，用来直接在序列化后的二进制数据上进行 compare、hash 等操作。

Flink 的类型和序列化系统也可以方便地进行扩展，用户可以提供自定义的序列化器和比较器，具体可以参考 Flink 官方提供的文档 [Data Types & Serialization](https://ci.apache.org/projects/flink/flink-docs-master/dev/types_serialization.html)。

在批处理的场景下，诸如 group, sort, 和 join 等操作都需要访问大量的数据。借助于 MemorySegment 并直接操作二进制数据，Flink 可以高效地完成这些操作，避免了频繁地序列化/反序列化，并且这些操作是缓存友好的。具体可以参考 Flink 团队的文章[Juggling with Bits and Bytes](https://flink.apache.org/news/2015/05/11/Juggling-with-Bits-and-Bytes.html)。

这种基于 `MemorySegment` 和二进制数据直接管理数据对象的方式可以带来如下好处：

- 保证内存安全：由于分配的 MemorySegment 的数量是固定的，因而可以准确地追踪 MemorySegment 的使用情况。在 Batch 模式下，如果 MemorySegment 资源不足，会将一批 MemorySegment 写入磁盘，需要时再重新读取。这样有效地减少了 OOM 的情况。
- 减少了 GC 的压力：因为分配的 MemorySegment 是长生命周期的对象，数据都以二进制形式存放，且 MemorySegment 可以回收重用，所以 MemorySegment 会一直保留在老年代不会被 GC；而由用户代码生成的对象基本都是短生命周期的，Minor GC 可以快速回收这部分对象，尽可能减少 Major GC 的频率。此外，MemorySegment 还可以配置为使用堆外内存，进而避免 GC。
- 节省内存空间：数据对象序列化后以二进制形式保存在 MemorySegment 中，减少了对象存储的开销。
- 高效的二进制操作和缓存友好的计算：可以直接基于二进制数据进行比较等操作，避免了反复进行序列化于反序列；另外，二进制形式可以把相关的值，以及 hash 值，键值和指针等相邻地放进内存中，这使得数据结构可以对高速缓存更友好。

## MemorySegment

前面已经介绍了，`MemorySegment` 是一段固定长度的内存，也是 Flink 中最小的内存分配单元。在早期版本的实现中，`MemorySegment` 使用的都是堆上的内存。尽管 Flink 的内存管理机制已经做了很多优化，但是 Flink 团队仍然加入了对堆外内存的支持。主要是考虑到以下几个方面：

- 启动很大堆内存（100s of GBytes heap memory）的 JVM 需要很长时间，GC 停留时间也会很长（分钟级）。使用堆外内存的话，JVM 只需要分配较少的堆内存（只需要分配 Remaining Heap 那一块）。
- 堆外内存在写磁盘或网络传输时是可以利用 zero-copy 特性，I/O 和网络传输的效率更高。
- 堆外内存是进程间共享的，也就是说，即使 JVM 进程崩溃也不会丢失数据。这可以用来做故障恢复。Flink暂时没有利用起这个，不过未来有可能会利用这个特性。

但是使用堆外内存同样存在一些潜在的问题：

- 堆内存可以很方便地进行监控和分析，相较而言堆外内存则更加难以控制；
- Flink 有时可能需要短生命周期的 MemorySegment，在堆上申请开销会更小；
- 一些操作在堆内存上会更快一些

Flink 将原来的 `MemorySegment` 变成了抽象类，并提供了两个具体的子类：`HeapMemorySegment` 和 `HybridMemorySegment`。前者是用于分配堆内存，后者用来分配堆外内存和堆内存的。

在早期版本中，由于 `MemorySegment` 是只基于堆内存的，因而只需要提供一种类型的 `MemorySegment` 实现即可；而在引入对堆外内存的支持后，按一般的思路是应该在新增一个基于堆外内存的实现即可。但是，这里涉及到一个 JIT 优化的性能问题。在只有一种类型的 `MemorySegment` 的情况下，通过 Class Hierarchy Analysis (CHA)，JIT 编译器能够确定方法调用的具体实现，因而方法调用可以通过去虚化（de-virtualized）和内联（inlined）来提升性能。而一旦有了两种类型的实现，在同时使用两种类型的 `MemorySegment` 的情况下，JIT 编译器就无法进行优化，这大概会导致 2.7 倍的性能差异。因而 Flink 做了这两种优化：1）确保只有一种 `MemorySegment` 的实现被加载；2）提供一种能同时处理管理堆内存和堆外内存的 `MemorySegment` 实现，从而保证频繁调用的 `MemorySegment` 能够被 JIT 优化。详细的解释和性能的评测可以参考 Flink 团队的文章[Off-heap Memory in Apache Flink and the curious JIT compiler](https://flink.apache.org/news/2015/09/16/off-heap-memory.html)。

来看下 `MemorySegment` 的实现：

```java
public abstract class MemorySegment {
	protected final byte[] heapMemory; //堆内存引用
	protected long address; //堆外内存地址

	//基于堆内存创建MemorySegment
	MemorySegment(byte[] buffer, Object owner) {
		if (buffer == null) {
			throw new NullPointerException("buffer");
		}
		this.heapMemory = buffer;
		this.address = BYTE_ARRAY_BASE_OFFSET;
		this.size = buffer.length;
		this.addressLimit = this.address + this.size;
		this.owner = owner;
	}

	//基于堆外内存创建MemorySegment
	MemorySegment(long offHeapAddress, int size, Object owner) {
		if (offHeapAddress <= 0) {
			throw new IllegalArgumentException("negative pointer or size");
		}
		if (offHeapAddress >= Long.MAX_VALUE - Integer.MAX_VALUE) {
			// this is necessary to make sure the collapsed checks are safe against numeric overflows
			throw new IllegalArgumentException("Segment initialized with too large address: " + offHeapAddress
					+ " ; Max allowed address is " + (Long.MAX_VALUE - Integer.MAX_VALUE - 1));
		}
		this.heapMemory = null;
		this.address = offHeapAddress;
		this.addressLimit = this.address + size;
		this.size = size;
		this.owner = owner;
	}

	public boolean isOffHeap() {
		return heapMemory == null;
	}

	public final long getLong(int index) {
		final long pos = address + index;
		if (index >= 0 && pos <= addressLimit - 8) {
			//这是能够在一个实现中同时操作对内存和堆外内存的关键
			return UNSAFE.getLong(heapMemory, pos);
		}
		else if (address > addressLimit) {
			throw new IllegalStateException("segment has been freed");
		}
		else {
			// index is in fact invalid
			throw new IndexOutOfBoundsException();
		}
	}

	//......
}


public final class HybridMemorySegment extends MemorySegment {
	private final ByteBuffer offHeapBuffer;

	//堆外内存初始化
	HybridMemorySegment(ByteBuffer buffer, Object owner) {
		super(checkBufferAndGetAddress(buffer), buffer.capacity(), owner);
		this.offHeapBuffer = buffer;
	}

	//堆内内存初始化
	HybridMemorySegment(byte[] buffer, Object owner) {
		super(buffer, owner);
		this.offHeapBuffer = null;
	}

	//......
}

public final class HeapMemorySegment extends MemorySegment {
	private byte[] memory;

	HeapMemorySegment(byte[] memory, Object owner) {
		super(Objects.requireNonNull(memory), owner);
		this.memory = memory;
	}

	//......
}
```

之所以能够使用同一份代码实现既能够处理堆内存又能够处理堆外内存的效果，其关键点在于 `sun.misc.Unsafe` 的一些方法会根据对象引用表现出不同的行为，例如:

```java
sun.misc.Unsafe.getLong(Object reference, long offset)
```

在 `reference` 不为 null 的情况下，则会取该对象的地址，加上后面的 `offset`，从相对地址处取出 8 字节；而在 `reference` 为 null 的情况下，则 `offset` 就是要操作的绝对地址。所以，通过控制对象引用的值，就可以灵活地管理堆外内存和堆内存。

既然 `HybridMemorySegment` 可以同时管理堆内存和堆外内存，为什么还需要 `HeapMemorySegment` 呢？这是因为假如所有的 `MemorySegment` 都是在堆上分配的，使用 `HeapMemorySegment` 相比于 `HybridMemorySegment` 会有更好的性能。但实际上，由于 Flink 中 Network buffer 使用的 `MemorySegment` 一定是在堆外分配的，`HeapMemorySegment` 在 Flink 中已经不会再使用了，具体可以参考 [FLINK-7310 always use the HybridMemorySegment](https://issues.apache.org/jira/browse/FLINK-7310)。

`MemorySegment` 通常不直接构造，而是通过 `MemorySegmentFactory` 来创建

## MemorySegment 的管理

在 TaskManager 的内存布局中我们说过，TaskManager 的内存主要分为三个部分，其中 Network Buffers 和 Managed Memory 都是一组 `MemorySegment` 的集合。下面就分别介绍下这两块内存是如何管理的。

### Buffer 和 NetworkBufferPool

`Buffer` 接口是对池化的 `MemorySegment` 的包装，带有引用计数，类似与 Netty 的 `ByteBuf`。`Buffer`也使用两个指针分别表示写入的位置和读取的位置。`Buffer` 的具体实现实现类 `NetworkBuffer` 继承自 Netty 的 `AbstractReferenceCountedByteBuf`，这使得它很容易地集成了引用计数和读写指针的功能。同时，在非 Netty 场景下使用时，`Buffer` 也提供了 `java.nio.ByteBuffer` 的包装，但需要手动设置读写指针的位置。`ReadOnlySlicedNetworkBuffer` 则提供了只读模式的 buffer 的包装。

`BufferBuilder` 和 `BufferConsumer` 构成了写入和消费 buffer 的通用模式：通过 `BufferBuilder` 向底层的 `MemorySegment` 写入数据，再通过 `BufferConsumer` 生成只读的 Buffer，读取 `BufferBuilder` 写入的数据。这两个类都不是线程安全的，但可以实现一个线程写入，另一个线程读取的效果。

`BufferPool` 接口继承了 `BufferProvider` 和 `BufferRecycler` 接口，提供了申请以及回收 `Buffer` 的功能。`LocalBufferPool` 是 `BufferPool` 的具体实现，`LocalBufferPool` 中 `Buffer` 的数量是可以动态调整的。

`BufferPoolFactory` 接口是 `BufferPool` 的工厂，用于创建及销毁 `BufferPool`。`NetworkBufferPool` 是 `BufferPoolFactory` 的具体实现类。所以按照 `BufferPoolFactory` -> `BufferPool` -> `Buffer` 这样的结构进行组织。`NetworkBufferPool` 在初始化的时候创建一组 `MemorySegment`，这些 `MemorySegment` 会在所有的 `LocalBufferPool` 之间进行均匀分配。

```java
class NetworkBufferPool implements BufferPoolFactory {
	//所有可用的MemorySegment，阻塞队列
	private final ArrayBlockingQueue<MemorySegment> availableMemorySegments;

	public NetworkBufferPool(int numberOfSegmentsToAllocate, int segmentSize) {
		this.totalNumberOfMemorySegments = numberOfSegmentsToAllocate;
		this.memorySegmentSize = segmentSize;
		final long sizeInLong = (long) segmentSize;

		try {
			this.availableMemorySegments = new ArrayBlockingQueue<>(numberOfSegmentsToAllocate);
		}
		catch (OutOfMemoryError err) {
			throw new OutOfMemoryError("Could not allocate buffer queue of length "
					+ numberOfSegmentsToAllocate + " - " + err.getMessage());
		}
		try {
			for (int i = 0; i < numberOfSegmentsToAllocate; i++) {
				//NetworkBufferPool 使用的 MemorySegment 全是堆外内存
				availableMemorySegments.add(MemorySegmentFactory.allocateUnpooledOffHeapMemory(segmentSize, null));
			}
		}
		catch (OutOfMemoryError err) {
			......
		}
		.......
	}
}
```

### MemoryManager

`MemoryManager` 是管理 Managed Memory 的类，这部分主要是在 Batch 模式下使用，在 Streaming 模式下这一块内存不会分配。`MemoryManager` 主要通过内部接口 `MemoryPool` 来管理所有的 `MemorySegment`。Managed Memory 和管理相比于 Network Buffers 的管理更为简单，因为不需要 Buffer 的那一层封装。直接来看下相关代码：

```java
public class MemoryManager {
	//管理所有的 MemorySegment
	private final MemoryPool memoryPool;


	public MemoryManager(long memorySize, int numberOfSlots, int pageSize,
							MemoryType memoryType, boolean preAllocateMemory) {
		// sanity checks
		......
		this.memoryType = memoryType;
		this.memorySize = memorySize;
		this.numberOfSlots = numberOfSlots;

		// assign page size and bit utilities
		this.pageSize = pageSize;
		this.roundingMask = ~((long) (pageSize - 1));

		final long numPagesLong = memorySize / pageSize;
		if (numPagesLong > Integer.MAX_VALUE) {
			throw new IllegalArgumentException("The given number of memory bytes (" + memorySize
					+ ") corresponds to more than MAX_INT pages.");
		}
		//所有可用的 MemorySegment 数量
		this.totalNumPages = (int) numPagesLong;
		if (this.totalNumPages < 1) {
			throw new IllegalArgumentException("The given amount of memory amounted to less than one page.");
		}

		this.allocatedSegments = new HashMap<Object, Set<MemorySegment>>();
		this.isPreAllocated = preAllocateMemory;

		this.numNonAllocatedPages = preAllocateMemory ? 0 : this.totalNumPages;
		//是否需要预分配内存，Streaming 不会预分配
		final int memToAllocate = preAllocateMemory ? this.totalNumPages : 0;

		switch (memoryType) {
			case HEAP:
			//堆上
				this.memoryPool = new HybridHeapMemoryPool(memToAllocate, pageSize);
				break;
			case OFF_HEAP:
			//堆外
				if (!preAllocateMemory) {
					LOG.warn("It is advisable to set 'taskmanager.memory.preallocate' to true when" +
						" the memory type 'taskmanager.memory.off-heap' is set to true.");
				}
				this.memoryPool = new HybridOffHeapMemoryPool(memToAllocate, pageSize);
				break;
			default:
				throw new IllegalArgumentException("unrecognized memory type: " + memoryType);
		}
	}

	abstract static class MemoryPool {
		abstract int getNumberOfAvailableMemorySegments();
		abstract MemorySegment allocateNewSegment(Object owner);
		abstract MemorySegment requestSegmentFromPool(Object owner);
		abstract void returnSegmentToPool(MemorySegment segment);
		abstract void clear();
	}

	static final class HybridHeapMemoryPool extends MemoryPool {
		private final ArrayDeque<byte[]> availableMemory;

		HybridHeapMemoryPool(int numInitialSegments, int segmentSize) {
			this.availableMemory = new ArrayDeque<>(numInitialSegments);
			this.segmentSize = segmentSize;
			for (int i = 0; i < numInitialSegments; i++) {
				//堆上直接使用byte数组
				this.availableMemory.add(new byte[segmentSize]);
			}
		}
	}

	static final class HybridOffHeapMemoryPool extends MemoryPool {
		private final ArrayDeque<ByteBuffer> availableMemory;

		HybridOffHeapMemoryPool(int numInitialSegments, int segmentSize) {
			this.availableMemory = new ArrayDeque<>(numInitialSegments);
			this.segmentSize = segmentSize;
			//堆外使用 DirectByteBuffer
			for (int i = 0; i < numInitialSegments; i++) {
				this.availableMemory.add(ByteBuffer.allocateDirect(segmentSize));
			}
		}
	}
}
```

##  小结

本文主要介绍了 Flink 内存管理的主要优化机制和实现方式。借助 MemeorySegment，自定义的序列化机制，利用堆外内存等手段，相比于直接在 JVM 堆上创建对象的方式，Flink 可以获得更好的性能表现，并且可以更高效地利用内存。文中还对 TaskManager 内存布局中的 Network Buffers 和 Managed Memory 的管理方式进行了简单的介绍。