package org.tyrael.flink.course04

import org.apache.flink.api.common.functions.RichMapFunction
import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._
import scala.collection.JavaConverters._
import org.apache.flink.configuration.Configuration

object DataSetBroadcastApp {
  def main(args: Array[String]): Unit = {
    val env = ExecutionEnvironment.getExecutionEnvironment
    val toBroadcast = env.fromElements("1", "2", "3")

    val data = env.fromElements("a", "b")

    data.map(new RichMapFunction[String, String]() {
      var broadcastSet: Traversable[String] = null

      override def open(config: Configuration): Unit = {
        // 3. Access the broadcast DataSet as a Collection
        broadcastSet = getRuntimeContext().getBroadcastVariable[String]("broadcastSetName").asScala
        for(ele <- broadcastSet){
          println(ele)
        }
      }

      override def map(value: String): String = {
        value
      }
    }).withBroadcastSet(toBroadcast, "broadcastSetName").print()

  }
}
