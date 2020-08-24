package org.tyrael.flink.course08

import java.util.Properties

import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.api.scala._
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.streaming.util.serialization.SimpleStringSchema

object KafkaConnectorConsumerApp {

  def main(args: Array[String]): Unit = {

    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val topic = "testDemo"

    val properties = new Properties()
    properties.setProperty("bootstrap.servers", "localhost:9092")
    properties.setProperty("group.id", "test")
    val data = env.addSource(new FlinkKafkaConsumer[String](topic, new SimpleStringSchema(), properties))
    data.print()

    env.execute("KafkaConnectorConsumerApp")
  }
}
