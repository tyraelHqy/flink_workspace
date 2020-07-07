package org.tyrael.flink.course04

import org.apache.commons.io.FileUtils
import org.apache.flink.api.common.functions.RichMapFunction
import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._
import org.apache.flink.configuration.Configuration
import scala.collection.JavaConverters._

object DistributeCacheApp {

  def main(args: Array[String]): Unit = {

    val env = ExecutionEnvironment.getExecutionEnvironment

    val filepath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\input.txt"

    // step1:注册一个本地/HDFS文件
    env.registerCachedFile(filepath, "tyrael-scala-dc")

    val data = env.fromElements("hadoop", "spark", "flink", "pyspark", "storm")

    data.map(new RichMapFunction[String, String] {

      override def open(parameters: Configuration): Unit = {
        val dcFile = getRuntimeContext.getDistributedCache().getFile("tyrael-scala-dc")

        val lines = FileUtils.readLines(dcFile)

        for (ele <- lines.asScala) {
          println(ele)
        }
      }

      override def map(value: String): String = {
        value
      }
    }).print()
  }

}
