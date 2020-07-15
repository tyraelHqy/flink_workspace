package org.tryael.flink.course08;

import org.apache.commons.math3.fitting.leastsquares.EvaluationRmsChecker;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaProducer;
import org.apache.flink.streaming.connectors.kafka.internals.KeyedSerializationSchemaWrapper;
import org.apache.flink.streaming.util.serialization.KeyedSerializationSchema;
import org.apache.flink.streaming.util.serialization.SimpleStringSchema;

import java.util.Properties;

public class JavaKafkaConnectorProducerApp {

    /**
     * val env = StreamExecutionEnvironment.getExecutionEnvironment
     * <p>
     * // 从socket接收数据，通过Flink，将数据SInk到Kafka
     * val data = env.socketTextStream("localhost", 9999)
     * val topic = "tyraeltest"
     * val properties = new Properties()
     * properties.setProperty("bootstrap.servers", "10.40.155.50:9092")
     * <p>
     * val kafkaSink = new FlinkKafkaProducer[String](topic, new KeyedSerializationSchemaWrapper[String](new SimpleStringSchema()), properties)
     * data.addSink(kafkaSink)
     * env.execute("KafkaConnectorProducerApp")
     */

    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<String> data = env.socketTextStream("localhost", 9988);
        String topic = "tyraeltest";
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "10.40.155.50:9092");
        FlinkKafkaProducer<String> kafkaSink = new FlinkKafkaProducer<>(topic, new KeyedSerializationSchemaWrapper<String>(new SimpleStringSchema()), properties);
        data.addSink(kafkaSink);

        env.execute("JavaKafkaConnectorProducerApp");
    }
}
