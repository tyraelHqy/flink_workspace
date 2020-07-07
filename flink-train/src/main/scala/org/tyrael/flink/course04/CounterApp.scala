package org.tyrael.flink.course04

import org.apache.flink.api.common.functions.RichMapFunction
import org.apache.flink.api.java.ExecutionEnvironment
import org.apache.flink.api.java._

object CounterApp {

  def main(args: Array[String]): Unit = {

    val env = ExecutionEnvironment.getExecutionEnvironment

    val data = env.fromElements("hadoop", "spark", "flink", "pyspark", "storem")

    data.map(new RichMapFunction[String, Long]() {
      var counter = 0l;

      override def map(value: String): Long = {
        counter = counter + 1
        println("counter:"+counter)
        counter
      }
    }).setParallelism(3).print()

    data.print()
  }
}
