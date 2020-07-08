package org.tyrael.flink.course05

import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.api.scala._

object DataStreamSourceApp {

  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment

    //    socketFunction(env)

    nonParallelSourceFunction(env)
    env.execute("DataStreamSourceApp")
  }

  def socketFunction(env: StreamExecutionEnvironment): Unit = {
    val data = env.socketTextStream("localhost", 9999)
    data.print().setParallelism(1)
  }

  def nonParallelSourceFunction(env: StreamExecutionEnvironment): Unit = {
    val data = env.addSource(new CustomNonParallelSourceFunction).setParallelism(1)
    data.print().setParallelism(1)

  }
}
