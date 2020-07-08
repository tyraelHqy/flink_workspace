package org.tyrael.flink.course05

import java.sql.{Connection, DriverManager, PreparedStatement}

import org.apache.flink.configuration.Configuration
import org.apache.flink.streaming.api.functions.sink.{RichSinkFunction, SinkFunction}
import org.tryael.flink.course05.Student

class SinkToMySQL extends RichSinkFunction[Student] {
  var connection: Connection = null

  var pstm: PreparedStatement = null

  def getConnection = {
    Class.forName("com.mysql.jdbc.Driver")
    val url = "jdbc:mysql://localhost:3306/flink_train"
    connection = DriverManager.getConnection(url, "root", "123456")
    connection
  }

  override def open(parameters: Configuration): Unit = {
    println("open~~~~~~")
    val conn = getConnection
    val sql = "insert into student(id,name,age) values (?,?,?) ON DUPLICATE KEY UPDATE name=?,age=?"

    pstm = conn.prepareStatement(sql)
  }

  override def invoke(value: Student, context: SinkFunction.Context[_]): Unit = {
    println("invoke~~~~~~~~~")
    pstm.setInt(1, value.id)
    pstm.setString(2, value.name)
    pstm.setInt(3, value.age)
    pstm.setString(4, value.name)
    pstm.setInt(5, value.age)
    pstm.executeUpdate()
  }

  override def close(): Unit = {
    if (pstm != null) {
      pstm.close()
    }
    if (connection != null) {
      connection.close()
    }
  }
}
