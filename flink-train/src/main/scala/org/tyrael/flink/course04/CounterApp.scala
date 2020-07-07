package org.tyrael.flink.course04

import com.sun.corba.se.spi.ior.Writeable
import org.apache.flink.api.common.accumulators.LongCounter
import org.apache.flink.api.common.functions.RichMapFunction
import org.apache.flink.api.java.ExecutionEnvironment
import org.apache.flink.api.java._
import org.apache.flink.configuration.Configuration
import org.apache.flink.core.fs.FileSystem.WriteMode

object CounterApp {

  def main(args: Array[String]): Unit = {

    val env = ExecutionEnvironment.getExecutionEnvironment

    val data = env.fromElements("hadoop", "spark", "flink", "pyspark", "storem")

    //    data.map(new RichMapFunction[String, Long]() {
    //      var counter = 0l;
    //
    //      override def map(value: String): Long = {
    //        counter = counter + 1
    //        println("counter:"+counter)
    //        counter
    //      }
    //    }).setParallelism(3).print()

    //    data.print()

    val info = data.map(new RichMapFunction[String, String]() {

      // step1: 定义计数器
      val counter = new LongCounter()

      override def open(parameters: Configuration): Unit = {

        // step2：注册计数器
        getRuntimeContext.addAccumulator("ele-counts-scala", counter)

      }

      override def map(input: String): String = {
        counter.add(1)
        input
      }
    })
    val filename = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\sink-scala-count-out"
    info.writeAsText(filename, WriteMode.OVERWRITE).setParallelism(5)
    val jobResult = env.execute("CounterApp")

    // 获取计数器
    val num = jobResult.getAccumulatorResult[Long]("ele-counts-scala")
    println("num:" + num)

  }
}
