package org.tyrael.flink.course07

import java.text.SimpleDateFormat

import org.apache.flink.streaming.api.TimeCharacteristic
import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks
import org.apache.flink.streaming.api.scala._
import org.apache.flink.streaming.api.scala.function.WindowFunction
import org.apache.flink.streaming.api.watermark.Watermark
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows
import org.apache.flink.streaming.api.windowing.time.Time
import org.apache.flink.streaming.api.windowing.windows.TimeWindow
import org.apache.flink.util.Collector


object WatermarkTest {
  def main(args: Array[String]): Unit = {
    if (args.length != 2) {
      System.err.println("USAGE:\nSocketWatermarkTest <hostname> <port>")
      return
    }

    println(System.currentTimeMillis())

    /**
     * 设置数据源，接收socket的数据
     */
    val hostname = args(0)
    val port = args(1).toInt

    val env = StreamExecutionEnvironment.getExecutionEnvironment

    /**
     * 设置Flink的时间类型为EventTime
     */
    env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)

    /**
     * 接收socket数据
     */
    val input = env.socketTextStream(hostname, port)

    /**
     * 将每行数据按照字符分隔，每行map成一个tuple类型（code，time）
     */
    val inputMap = input.map(x => {
      val arr = x.split("\\W+")
      val code = arr(0)
      val time = arr(1).toLong
      (code, time)
    })

    /**
     * 抽取timestamp生成watermark。并且打印
     * （code，time，格式化的time，currentMaxTimestamp，currentMaxTimestamp的格式化时间，watermark时间）
     */
    val watermark = inputMap.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks[(String, Long)] {
      var currentMaxTimeStamp = 0L
      val maxOutOfOrderness = 10000L // 最大允许的乱序时间是10s

      var a: Watermark = null

      val format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")

      override def getCurrentWatermark: Watermark = {
        a = new Watermark(currentMaxTimeStamp - maxOutOfOrderness)
        a
      }

      override def extractTimestamp(element: (String, Long), previousElementTimestamp: Long): Long = {
        val timestamp = element._2
        currentMaxTimeStamp = Math.max(timestamp, currentMaxTimeStamp)
        println("timestamp:" + element._1 + "," + element._2 + "|" + format.format(element._2) + "," +"currentMaxTimeStamp:"+ currentMaxTimeStamp + "|" + format.format(currentMaxTimeStamp) + "," + a.toString)
        timestamp
      }
    })

    /**
     * event time每隔3秒触发一次窗口，输出
     * （code，窗口内元素个数，窗口内最早元素的时间，窗口内最晚元素的时间，窗口自身开始时间，窗口自身结束时间）
     */
    val window = watermark.keyBy(_._1).window(TumblingEventTimeWindows.of(Time.seconds(3))).apply(new WindowFunctionTest)

    window.print()

    env.execute("WatermarkTest")
  }

  /**
   * 重新实现了WindowFunction
   */
  class WindowFunctionTest extends WindowFunction[(String,Long),(String, Int,String,String,String,String),String,TimeWindow]{

    override def apply(key: String, window: TimeWindow, input: Iterable[(String, Long)], out: Collector[(String, Int,String,String,String,String)]): Unit = {
      val list = input.toList.sortBy(_._2)
      val format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
      out.collect(key,input.size,format.format(list.head._2),format.format(list.last._2),format.format(window.getStart),format.format(window.getEnd))
    }

  }

}
