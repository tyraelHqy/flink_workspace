package org.tryael.flink.project;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.api.java.tuple.Tuple;
import org.apache.flink.api.java.tuple.Tuple3;
import org.apache.flink.api.java.tuple.Tuple4;
import org.apache.flink.streaming.api.TimeCharacteristic;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks;
import org.apache.flink.streaming.api.functions.windowing.WindowFunction;
import org.apache.flink.streaming.api.watermark.Watermark;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer;
import org.apache.flink.util.Collector;

import javax.annotation.Nullable;
import java.text.SimpleDateFormat;
import java.util.*;

public class JavaLogAnalysis {
    private static final Logger LOG = LoggerFactory.getLogger(JavaLogAnalysis.class);

    public static void main(String[] args) throws Exception {

        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        String topic= "tyraeltest";
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "10.40.155.50:9092");
        properties.setProperty("group.id", "test");
        DataStreamSource<String> data = env.addSource(new FlinkKafkaConsumer<String>(topic,new SimpleStringSchema(),properties));
        data.print();

        SingleOutputStreamOperator<Tuple3<Long, String, Long>> logData = data.map(new MapFunction<String, Tuple4<String, Long, String, String>>() {
            @Override
            public Tuple4<String, Long, String, String> map(String value) throws Exception {
                String[] splits = value.split("\t");
                String level = splits[2];
                String timeStr = splits[3];

                Long time = 0l;

                try {
                    SimpleDateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    time = sourceFormat.parse(timeStr).getTime();
                } catch (Exception e) {
                    LOG.error("time parse error: {}", e.getMessage());
                }
                String domain = splits[5];
                String traffic = splits[6];
                Tuple4<String, Long, String, String> tuple4 = new Tuple4<>(level, time, domain, traffic);
                return tuple4;
            }
        }).filter(new FilterFunction<Tuple4<String, Long, String, String>>() {
            @Override
            public boolean filter(Tuple4<String, Long, String, String> value) throws Exception {
                return value.f1 != 0;
            }
        }).filter(new FilterFunction<Tuple4<String, Long, String, String>>() {
            @Override
            public boolean filter(Tuple4<String, Long, String, String> value) throws Exception {
                return value.f0.equals("E");
            }
        }).map(new MapFunction<Tuple4<String, Long, String, String>, Tuple3<Long, String, Long>>() {
            @Override
            public Tuple3<Long, String, Long> map(Tuple4<String, Long, String, String> value) throws Exception {
                return new Tuple3<Long, String, Long>(value.f1, value.f2, Long.parseLong(value.f3));
            }
        });

        logData.print();

        SingleOutputStreamOperator<Tuple3<String, String, Long>> resultData = logData.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks<Tuple3<Long, String, Long>>() {

            private final long maxOutOfOrderness = 10000; // 3.5 seconds

            private long currentMaxTimestamp;

            @Nullable
            @Override
            public Watermark getCurrentWatermark() {
                return new Watermark(currentMaxTimestamp - maxOutOfOrderness);
            }

            @Override
            public long extractTimestamp(Tuple3<Long, String, Long> element, long previousElementTimestamp) {
                Long timestamp = element.f0;
                currentMaxTimestamp = Math.max(timestamp, currentMaxTimestamp);
                return timestamp;
            }
        }).keyBy(1)
                .window(TumblingEventTimeWindows.of(Time.seconds(60)))
                .apply(new WindowFunction<Tuple3<Long, String, Long>, Tuple3<String, String, Long>, Tuple, TimeWindow>() {
                    @Override
                    public void apply(Tuple tuple, TimeWindow window, Iterable<Tuple3<Long, String, Long>> input, Collector<Tuple3<String, String, Long>> out) throws Exception {
                        String domain = tuple.getField(0).toString();

                        Long sum = 0l;

                        ArrayList<Long> times = new ArrayList<>();
                        Iterator<Tuple3<Long, String, Long>> iterator = input.iterator();
                        while (iterator.hasNext()) {
                            Tuple3<Long, String, Long> next = iterator.next();
                            sum += next.f2;
                            times.add(next.f0);
                        }


                        String time = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date(Collections.max(times)));
                        out.collect(new Tuple3<>(time, domain, sum));
                    }
                });

        resultData.print();

        env.execute("JavaLogAnalysis");
    }
}
