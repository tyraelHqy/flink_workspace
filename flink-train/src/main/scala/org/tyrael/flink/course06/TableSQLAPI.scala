package org.tyrael.flink.course06

import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.api.scala._
import org.apache.flink.table.api.scala.BatchTableEnvironment
import org.apache.flink.types.Row

object TableSQLAPI {
  def main(args: Array[String]): Unit = {
    val env = ExecutionEnvironment.getExecutionEnvironment
    val tableEnv = BatchTableEnvironment.create(env)

    val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\sales.csv"

    // 已经拿到DataSet
    val csv = env.readCsvFile[SalesLog](filePath, ignoreFirstLine = true)
    //    csv.print()

    // DataSet ==> Table
    val salesTable = tableEnv.fromDataSet(csv)

    // Table ==> table
    tableEnv.registerTable("sales",salesTable)

    // sql
    val resultTable = tableEnv.sqlQuery("select customId,sum(amountPaid) money from sales group by customId")

    tableEnv.toDataSet[Row](resultTable).print()

  }


  case class SalesLog(transcationId: String, customId: String, itemId: String, amountPaid: Double)

}
