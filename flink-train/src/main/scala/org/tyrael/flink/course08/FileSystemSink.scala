package org.tyrael.flink.course08


import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
import org.apache.flink.streaming.connectors.fs.StringWriter
import org.apache.flink.streaming.connectors.fs.bucketing.{BucketingSink, DateTimeBucketer}

object FileSystemSink {
  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val data = env.socketTextStream("localhost", 9999)

    data.print().setParallelism(1)

    val filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\hdfssink"
    val sink = new BucketingSink[String](filePath)

    sink.setBucketer(new DateTimeBucketer("yyyy-MM-dd--HHmm"))
    sink.setWriter(new StringWriter)
    //    sink.setBatchSize(1024 * 1024 * 400) // this is 400 MB,
    //    sink.setBatchRolloverInterval(20 * 60 * 1000); // this is 20 mins

    sink.setBatchRolloverInterval(20)
    data.addSink(sink)
    env.execute("FileSystemSink")
  }

}
