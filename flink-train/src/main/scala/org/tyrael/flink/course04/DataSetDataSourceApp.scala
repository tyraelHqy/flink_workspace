package org.tyrael.flink.course04

import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._

object DataSetDataSourceApp {

  def main(args: Array[String]): Unit = {
    val env = ExecutionEnvironment.getExecutionEnvironment

    // 从集合的方式读取DataSet
    // fromCollection(env)
    fromTextFile(env)
  }

  def fromCollection(env: ExecutionEnvironment): Unit = {

    val data = 1 to 10
    env.fromCollection(data).print()

  }

  def fromTextFile(env: ExecutionEnvironment): Unit = {

    // 读取单个文件
     val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\input.txt"
     env.readTextFile(filePath).print()

    // 读取文件夹
    // val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\inputs"
    // env.readTextFile(filePath).print()
  }
}
