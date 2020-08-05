package org.tryael.flink.experiment;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.java.tuple.Tuple;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.streaming.api.TimeCharacteristic;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks;
import org.apache.flink.streaming.api.functions.windowing.WindowFunction;
import org.apache.flink.streaming.api.watermark.Watermark;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;

import javax.annotation.Nullable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * 程序说明：首先使用Socket模拟接收数据，然后使用map进行处理，
 * 接着调用assignTimestampsAndWatermarks方法抽取timestamp并生成Watermark，
 * 最后调用Windows打印信息来验证Window的触发时机
 */

public class StreamingWindowWatermark {
    public static void main(String[] args) throws Exception {
        // 定义Socket端口号
        int port = 9999;
        // 获取运行环境
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        // 设置使用EventTIme，默认使用processTIme
        env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime);

        //设置并行度为1。默认并行度是当前机器的CPU数量
        env.setParallelism(1);

        // 连接Socket 获取输入的数据
        DataStream<String> text = env.socketTextStream("localhost", port, "\n");

        // 解析输入的数据
        DataStream<Tuple2<String, Long>> inputMap = text.map(new MapFunction<String, Tuple2<String, Long>>() {
            @Override
            public Tuple2<String, Long> map(String value) throws Exception {
                String[] arr = value.split(",");
                return new Tuple2<>(arr[0], Long.parseLong(arr[1]));
            }
        });

        // 抽取时间戳timestamp和生成 Watermark
        SingleOutputStreamOperator<Tuple2<String, Long>> waterMarkStream = inputMap.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks<Tuple2<String, Long>>() {

            Long currentMaxTimestamp = 0L;
            final Long maxOutOfOrderness = 10000L; //最大允许的乱序时间是10s

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

            /**
             * 定义生活Watermark的逻辑，默认100ms被调用一次
             * @return
             */
            @Nullable
            @Override
            public Watermark getCurrentWatermark() {
                return new Watermark(currentMaxTimestamp - maxOutOfOrderness);
            }

            /**
             * 定义生成如何提去timestamp
             * @param element
             * @param previousElementTimestamp
             * @return
             */
            @Override
            public long extractTimestamp(Tuple2<String, Long> element, long previousElementTimestamp) {
                Long timestamp = element.f1;
                currentMaxTimestamp = Math.max(timestamp, currentMaxTimestamp);
                System.out.println("Key:" + element.f0 +
                        ",eventtime:[" + element.f1 + "|" + sdf.format(element.f1) + "].currentMaxTimestamp:[" +
                        currentMaxTimestamp + "|" + sdf.format(currentMaxTimestamp) + "],watermark:[" +
                        getCurrentWatermark().getTimestamp() + "|" + sdf.format(getCurrentWatermark().getTimestamp()) + "]");
                return timestamp;
            }
        });

        // 分组，聚合
        DataStream<String> window = waterMarkStream.keyBy(0)
                .window(TumblingEventTimeWindows.of(Time.seconds(3)))
                .allowedLateness(Time.seconds(2))
                .apply(new WindowFunction<Tuple2<String, Long>, String, Tuple, TimeWindow>() {
                    /**
                     * 对Window内的数据进行排序，保证数据的顺序
                     * @param tuple
                     * @param window
                     * @param input
                     * @param out
                     * @throws Exception
                     */
                    @Override
                    public void apply(Tuple tuple, TimeWindow window, Iterable<Tuple2<String, Long>> input, Collector<String> out) throws Exception {
                        String key = tuple.toString();
                        List<Long> arrarList = new ArrayList<Long>();
                        Iterator<Tuple2<String, Long>> it = input.iterator();
                        while (it.hasNext()) {
                            Tuple2<String, Long> next = it.next();
                            arrarList.add(next.f1);
                        }
                        Collections.sort(arrarList);
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                        String result = key + "," +
                                arrarList.size() + "," +
                                sdf.format(arrarList.get(0)) + "," +
                                sdf.format(arrarList.get(arrarList.size() - 1)) + "," +
                                sdf.format(window.getStart()) + "," +
                                sdf.format(window.getEnd());
                        out.collect(result);
                    }
                });

        // 测试，把结果打印在控制台

        window.print();

        env.execute("StreamingWindowWatermark");
    }
}
