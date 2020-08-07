package org.tryael.flink.project;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

public class TyraelKafkaProducer {

    private static final String url = "10.40.156.50:9092";

    public static void main(String[] args) throws InterruptedException {

        String topic = "tyraeltest";
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", TyraelKafkaProducer.url);
        properties.setProperty("key.serializer", StringSerializer.class.getName());
        properties.setProperty("value.serializer", StringSerializer.class.getName());
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        // 通过死循环一直不停地往Kafka的Broker里面生产数据
        while (true) {
            StringBuilder builder = new StringBuilder();
            builder
                    .append("tencent").append("\t")
                    .append("CN").append("\t")
                    .append(getLevels()).append("\t")
                    .append(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())).append("\t")
                    .append(getIps()).append("\t")
                    .append(getDomains()).append("\t")
                    .append(getTraffic()).append("\t");
            System.out.println(builder.toString());
            producer.send(new ProducerRecord<String, String>(topic, builder.toString()));
            Thread.sleep(2000);

        }
    }

    // 生产 level 数据
    public static String getLevels() {
        String[] levels = new String[]{"M", "E"};
        return levels[new Random().nextInt(levels.length)];
    }

    // 生产 ip 数据
    public static String getIps() {
        String[] ips = new String[]{
                "223.104.18.110",
                "113.101.75.194",
                "183.225.139.16",
                "112.1.66.34",
                "175.148.211.190",
                "183.227.58.21",
                "59.83.198.84",
                "117.28.38.28",
                "117.59.39.169"
        };
        return ips[new Random().nextInt(ips.length)];
    }

    // 生产 domain 数据
    public static String getDomains() {
        String[] domains = new String[]{
                "pvp.qq.com",
                "im.qq.com",
                "ml.qq.com",
                "v.qq.com",
                "3q.qq.com",
                "pv.tqqt.com",
                "pv2.weqn.com",
                "pv3.myapp.com"
        };
        return domains[new Random().nextInt(domains.length)];
    }

    // 生产 traffic 数据
    public static long getTraffic() {
        return new Random().nextInt(10000);
    }
}
