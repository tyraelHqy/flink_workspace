package org.tyrael.flink.course05

import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment

object DataStreamSourceApp {

  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment

    socketFunction(env)

    env.execute("DataStreamSourceApp")
  }

  def socketFunction(env: StreamExecutionEnvironment): Unit = {
    val data = env.socketTextStream("localhost",9999)

    data.print().setParallelism(1)
  }
}
