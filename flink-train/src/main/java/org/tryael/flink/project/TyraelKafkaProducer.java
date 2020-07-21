package org.tryael.flink.project;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Properties;

public class TyraelKafkaProducer {

    public static void main(String[] args) throws InterruptedException {

        String topic = "tyraeltest";
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "10.40.155.50:9092");
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        // 通过死循环一直不停地往Kafka的Broker里面生产数据
        while (true) {
            StringBuilder builder = new StringBuilder();
            System.out.println(builder.toString());
            producer.send(new ProducerRecord<String, String>(topic, builder.toString()));
            Thread.sleep(2000);

        }
    }
}
