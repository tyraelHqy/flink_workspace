package org.tryael.flink.course08;

import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer;

import java.util.Properties;

public class JavaKafkaConnectorConsumerApp {

    /*
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val topic = "tyraeltest"
    val properties = new Properties()
    properties.setProperty("bootstrap.servers", "10.40.155.50:9092")
    properties.setProperty("group.id", "test")
    val data = env.addSource(new FlinkKafkaConsumer[String](topic, new SimpleStringSchema(), properties))
    data.print()

    env.execute("KafkaConnectorConsumerApp")
     */

    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        String topic= "tyraeltest";
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "10.40.155.50:9092");
        properties.setProperty("group.id", "test");
        DataStreamSource<String> data = env.addSource(new FlinkKafkaConsumer<String>(topic,new SimpleStringSchema(),properties));
        data.print();

        env.execute("JavaKafkaConnectorConsumerApp");
    }
}
