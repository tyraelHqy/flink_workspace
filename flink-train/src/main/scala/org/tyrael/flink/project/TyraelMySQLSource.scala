package org.tyrael.flink.project

import java.sql.{Connection, DriverManager, PreparedStatement}

import org.apache.flink.configuration.Configuration
import org.apache.flink.streaming.api.functions.source.{RichParallelSourceFunction, SourceFunction}

import scala.collection.mutable

class TyraelMySQLSource extends RichParallelSourceFunction[mutable.HashMap[String, String]] {
  var connection: Connection = null
  var ps: PreparedStatement = null
  var isRunning = true
  var count = 1L

  // open:建立连接
  override def open(parameters: Configuration): Unit = {
    val driver = "com.mysql.jdbc.Driver"
    val url = "jdbc:mysql://127.0.0.1:3306/flink"
    val user = "root"
    val password = "123456"
    Class.forName(driver)
    connection = DriverManager.getConnection(url, user, password)
    val sql = "select user_id,domain from user_domain_config"
    ps = connection.prepareStatement(sql)
  }

  // 释放资源
  override def close(): Unit = {
    if (ps != null) {
      ps.close()
    }

    if (connection != null) {
      connection.close()
    }
  }

  override def cancel(): Unit = {}

  override def run(ctx: SourceFunction.SourceContext[mutable.HashMap[String, String]]): Unit = {
    /**
     * 代码关键:要从MySQL表中把数据读取出来转成Map，进行数据的封装
     */
    var resultMap: mutable.HashMap[String, String] = mutable.HashMap()
    val resultSet = ps.executeQuery()
    while (resultSet.next()) {
      val userId = resultSet.getString("user_id")
      val domain = resultSet.getString("domain")
      resultMap += (domain -> userId)
    }
    ctx.collect(resultMap)
  }
}
