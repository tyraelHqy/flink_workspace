package org.myorg.quickstart.course02

import org.apache.flink.api.scala._

/**
 * 使用Scala开发Flink的实时处理应用程序
 */
object BatchJobWCScalaApp {

  def main(args: Array[String]): Unit = {
    val input = "file:///D:\\Users\\tyraelhuang\\tmp\\flink\\input"

    val env = ExecutionEnvironment.getExecutionEnvironment

    val text = env.readTextFile(input)

    text.print()

    // TODO
    text.flatMap(_.toLowerCase.split("\t"))
      .filter(_.nonEmpty)
      .map((_,1))
      .groupBy(0)
      .sum(1)
      .print()
  }
}
