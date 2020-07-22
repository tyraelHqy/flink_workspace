package org.tyrael.flink.project

import java.text.SimpleDateFormat
import java.util.Properties

import org.apache.flink.streaming.api.TimeCharacteristic
import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks
import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.api.scala._
import org.apache.flink.streaming.api.watermark.Watermark
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.streaming.util.serialization.SimpleStringSchema
import org.slf4j.LoggerFactory

object LogAnalysis {

  def main(args: Array[String]): Unit = {
    val logger = LoggerFactory.getLogger("LogAnalysis")

    val env = StreamExecutionEnvironment.getExecutionEnvironment
    env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)

    val topic = "tyraeltest"
    val properties = new Properties()
    properties.setProperty("bootstrap.servers", "10.40.155.50:9092")
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
     * 在生产上进行业务处理的时候一定要考虑处理的健壮性以及数据的准确性
     * 脏数据或者是不符合业务规则的数据是需要全部过滤掉之后
     * 再继续进行相应业务逻辑的处理
     *
     * 对于我们的业务来说，我们只要统计level = E 的即可
     * 对于level非E的，不作为我们业务指标的统计范畴
     *
     * 数据清洗：按照我们的输入规则把原始输入的数据进行一定的业务规则的处理
     * 使得满足我们的业务需求为准
     */

    logData.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks[(Long, String, Long)] {
      val maxOutOfOrderness = 3500L // 3.5 seconds

      var currentMaxTimestamp: Long = _

      override def getCurrentWatermark: Watermark = {
        // return the watermark as current highest timestamp minus the out-of-orderness bound
        new Watermark(currentMaxTimestamp - maxOutOfOrderness)
      }

      override def extractTimestamp(element: (Long, String, Long), previousElementTimestamp: Long): Long = {
        val timestamp = element._1
        currentMaxTimestamp = Math.max(timestamp, currentMaxTimestamp)
        timestamp
      }
    })

    logData.print().setParallelism(1)
    env.execute("LogAnalysis")
  }

}
