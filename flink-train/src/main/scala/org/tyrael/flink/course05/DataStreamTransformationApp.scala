package org.tyrael.flink.course05

import java.{lang, util}

import org.apache.flink.streaming.api.TimeCharacteristic
import org.apache.flink.streaming.api.collector.selector.OutputSelector
import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.api.scala._

object DataStreamTransformationApp {
  def main(args: Array[String]): Unit = {

    val env = StreamExecutionEnvironment.getExecutionEnvironment

    env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)

    //    filterFunction(env)
    //    unionFunction(env)
    splitSelectFunction(env)

    env.execute("DataStreamTransformationApp")
  }

  def filterFunction(env: StreamExecutionEnvironment): Unit = {
    val data = env.addSource(new CustomNonParallelSourceFunction)
    data.map(x => {
      println("received:" + x)
      x
    }).filter(_ % 2 == 0).print().setParallelism(1)
  }

  def unionFunction(env: StreamExecutionEnvironment): Unit = {
    val data1 = env.addSource(new CustomNonParallelSourceFunction)
    val data2 = env.addSource(new CustomNonParallelSourceFunction)

    data1.union(data2).print()

  }

  def splitSelectFunction(env: StreamExecutionEnvironment): Unit = {
    val data = env.addSource(new CustomNonParallelSourceFunction)
    val splits = data.split(new OutputSelector[Long] {
      override def select(input: Long): lang.Iterable[String] = {
        val list = new util.ArrayList[String]()
        if (input % 2 == 0) {
          list.add("even")
        } else {
          list.add("odd")
        }
        list
      }
    })
    splits.select("even", "odd").print()
  }
}
