package org.tyrael.flink.course04

import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._
import org.apache.flink.configuration.Configuration
import org.tryael.flink.course04.Person

object DataSetDataSourceApp {

  def main(args: Array[String]): Unit = {
    val env = ExecutionEnvironment.getExecutionEnvironment

    // 从集合的方式读取DataSet
    // fromCollection(env)
    // fromTextFile(env)
    //    fromCsvFile(env)
//    readRecursiveFiles(env)
    readCompressionFiles(env)
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

  //  case class MyCaseClass(name: String, age: Int)

  def fromCsvFile(env: ExecutionEnvironment): Unit = {
    val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\people.csv"
    //    env.readCsvFile[(String, Int, String)](filePath, ignoreFirstLine = true).print()

    //    env.readCsvFile[(String,Int)](filePath,ignoreFirstLine = true,includedFields = Array(0,1)).print()

    //    env.readCsvFile[MyCaseClass](filePath, ignoreFirstLine = true, includedFields = Array(0, 1)).print()

    env.readCsvFile[Person](filePath, ignoreFirstLine = true, pojoFields = Array("name", "age", "work")).print()
  }

  def readRecursiveFiles(env: ExecutionEnvironment): Unit = {
    val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\nested"
    env.readTextFile(filePath).print()
    println("~~~~~~~~~~~~~~~~~分割线~~~~~~~~~~~~~~~~~~~~~")

    // create a configuration object
    val parameters = new Configuration()
    // set the recursive enumeration parameter
    parameters.setBoolean("recursive.file.enumeration", true)

    // pass the configuration to the data source
    val logs = env.readTextFile("file:///path/with.nested/files").withParameters(parameters)
    env.readTextFile(filePath).withParameters(parameters).print()
  }

  def readCompressionFiles(env:ExecutionEnvironment): Unit ={
    val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\compression"
    env.readTextFile(filePath).print()
  }
}
