package org.tyrael.flink.project

import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.api.scala._

object TyraelMySQLSourceTest {

  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val data = env.addSource(new TyraelMySQLSource).setParallelism(1)
    data.print()

    env.execute("TyraelMySQLSourceTest")
  }

}
