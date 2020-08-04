package org.tyrael.flink.project

import java.text.SimpleDateFormat
import java.util
import java.util.{Date, Properties}

import org.apache.flink.api.common.functions.RuntimeContext
import org.apache.flink.api.java.tuple.Tuple
import org.apache.flink.streaming.api.TimeCharacteristic
import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks
import org.apache.flink.streaming.api.functions.co.CoFlatMapFunction
import org.apache.flink.streaming.api.scala.{StreamExecutionEnvironment, _}
import org.apache.flink.streaming.api.scala.function.WindowFunction
import org.apache.flink.streaming.api.watermark.Watermark
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows
import org.apache.flink.streaming.api.windowing.time.Time
import org.apache.flink.streaming.api.windowing.windows.TimeWindow
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.streaming.util.serialization.SimpleStringSchema
import org.apache.flink.util.Collector
import org.slf4j.LoggerFactory

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer

object LogAnalysis02 {

  def main(args: Array[String]): Unit = {
    val logger = LoggerFactory.getLogger("LogAnalysis02")

    val env = StreamExecutionEnvironment.getExecutionEnvironment
    env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)

    val topic = "tyraeltest"
    val properties = new Properties()
    properties.setProperty("bootstrap.servers", "10.40.156.50:9092")
    properties.setProperty("group.id", "test")

    // 接收kafka数据
    val data = env.addSource(new FlinkKafkaConsumer[String](topic, new SimpleStringSchema(), properties))

    val logData = data.map(x => {
      val splits = x.split("\t")
      val level = splits(2)
      val timeStr = splits(3)

      var time = 0l

      try {
        val sourceFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        time = sourceFormat.parse(timeStr).getTime
      } catch {
        case e: Exception => {
          logger.error(s"time parse error: $timeStr" + e.getMessage)
        }
      }
      val domain = splits(5)
      val traffic = splits(6).toLong

      (level, time, domain, traffic)
    }).filter(_._2 != 0).filter(_._1 == "E")
      .map(x => {
        (x._2, x._3, x._4)
      })

    /**
     * 在生产上进行业务处理的时候，一定要考虑处理的健壮性以及你数据的准确性
     * 脏数据或者是不符合业务规则的数据是需要全部过滤掉之后
     * 再进行相应业务逻辑的处理
     *
     * 对于我们的业务来说，我们只需要统计level=E的即可
     * 对于level非E的，不做为我们业务指标的统计范畴
     *
     * 数据清洗：就是按照我们的业务规则把原始输入的数据进行一定业务规则的处理
     * 使得满足我们的业务需求为准
     */

    val mysqlData = env.addSource(new TyraelMySQLSource)
    //    mysqlData.print()
    val connectData = logData.connect(mysqlData)
      .flatMap(new CoFlatMapFunction[(Long, String, Long), mutable.HashMap[String, String], String] {

        var userDomainMap = mutable.HashMap[String, String]()

        // log
        override def flatMap1(value: (Long, String, Long), out: Collector[String]): Unit = {
          val domain = value._2
          val userId = userDomainMap.getOrElse(domain, "")

          //          println("~~~~~~~~~~~~~" + userId)

          out.collect(value._1 + "\t" + value._2 + "\t" + value._3 + "\t" + userId)
        }

        // MySQL
        override def flatMap2(value: mutable.HashMap[String, String], out: Collector[String]): Unit = {
          userDomainMap = value
        }
      })
    connectData.print()
    val connect = connectData.map(x => {
      val splits = x.split("\t")
      val time = splits(0).toLong
      println(time)
      val traffic = splits(2).toLong
      val userId = splits(3).toLong
      (time, traffic, userId)
    })

    // 1595506219000	v.qq.com	9370	8000000
    val resultData = connect.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks[(Long, Long, Long)] {

      val maxOutOfOrderness = 10000L // 3.5 seconds

      var currentMaxTimestamp: Long = _

      override def getCurrentWatermark: Watermark = {
        new Watermark(currentMaxTimestamp - maxOutOfOrderness)
      }

      override def extractTimestamp(element: (Long, Long, Long), previousElementTimestamp: Long): Long = {
        val timestamp = element._1
        currentMaxTimestamp = Math.max(timestamp, currentMaxTimestamp)
        timestamp
      }
    })

    resultData.print()

    val value = resultData.keyBy(2)
    value.print()
    val value1 = value // 此处按照域名进行keyBy
      .window(TumblingEventTimeWindows.of(Time.seconds(5)))
      .apply(new WindowFunction[(Long, Long, Long), (String, Long, Long), Tuple, TimeWindow] {
        override def apply(key: Tuple, window: TimeWindow, input: Iterable[(Long, Long, Long)], out: Collector[(String, Long, Long)]): Unit = {

          val userId = key.getField(2)
          var sum = 0l

          val times = ArrayBuffer[Long]()

          val iterator = input.iterator
          while(iterator.hasNext){
            val next = iterator.next()
            sum += next._2

            times.append(next._1)
          }
          val time = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date(times.max))
          out.collect((time,userId,sum))
        }
      })

    value1.print()

    env.execute("LogAnalysis02")
  }

}
