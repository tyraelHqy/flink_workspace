package org.tyrael.flink.course04

import org.apache.flink.api.common.operators.Order
import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._

import scala.collection.mutable.ListBuffer

object DataSetTransformationApp {

  def main(args: Array[String]): Unit = {
    val env = ExecutionEnvironment.getExecutionEnvironment
    //    mapFunction(env)
    //    filterFunction(env)
    //    mapPartitionFunction(env)
    firstNFunction(env)
  }


  def mapFunction(env: ExecutionEnvironment): Unit = {
    val data = env.fromCollection(List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))

    // 对data中的每一个元素都做一个+1的操作
    // data.map((x: Int) => x + 1).print()
    // data.map(x => x+1).print()
    data.map(_ + 1).print()
  }

  def filterFunction(env: ExecutionEnvironment): Unit = {
    env.fromCollection(List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
      .map(_ + 1)
      .filter(_ > 5)
      .print()
  }

  // DataSource 100个元素,把结果存储到数据库中
  def mapPartitionFunction(env: ExecutionEnvironment): Unit = {
    val students = new ListBuffer[String]
    for (i <- 1 to 100) {
      students.append("student: " + i)
    }

    val data = env.fromCollection(students).setParallelism(4)

    data.mapPartition(x => {
      val connection = DBUtils.getConnection()
      println(connection + "...")
      DBUtils.returnConnection(connection)

      x
    }).print()
  }

  def firstNFunction(env: ExecutionEnvironment): Unit = {
    val info = ListBuffer[(Int, String)]()
    info.append((1, "Hadoop"))
    info.append((1, "Spark"))
    info.append((1, "Flink"))
    info.append((2, "Java"))
    info.append((2, "SpringBoot"))
    info.append((3, "Linux"))
    info.append((4, "VUE"))

    val data = env.fromCollection(info)

    //    data.first(3).print()
    //    data.groupBy(0).first(2).print()
    data.groupBy(0).sortGroup(1,Order.DESCENDING).first(2).print();
  }
}
