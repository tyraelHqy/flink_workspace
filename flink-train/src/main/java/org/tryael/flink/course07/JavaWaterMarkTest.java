//package org.tryael.flink.course07;
//
//import org.apache.commons.collections.IteratorUtils;
//import org.apache.commons.math3.fitting.leastsquares.EvaluationRmsChecker;
//import org.apache.flink.api.common.functions.MapFunction;
//import org.apache.flink.api.java.tuple.Tuple;
//import org.apache.flink.api.java.tuple.Tuple2;
//import org.apache.flink.api.java.tuple.Tuple6;
//import org.apache.flink.streaming.api.TimeCharacteristic;
//import org.apache.flink.streaming.api.datastream.DataStreamSource;
//import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
//import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
//import org.apache.flink.streaming.api.functions.AssignerWithPeriodicWatermarks;
//import org.apache.flink.streaming.api.functions.windowing.WindowFunction;
//import org.apache.flink.streaming.api.watermark.Watermark;
//import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
//import org.apache.flink.streaming.api.windowing.time.Time;
//import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
//import org.apache.flink.util.Collector;
//
//import javax.annotation.Nullable;
//import java.text.SimpleDateFormat;
//import java.util.Arrays;
//
//public class JavaWaterMarkTest {
//    public static void main(String[] args) {
//        if (args.length != 2) {
//            System.err.println("USAGE:\nSocketWatermarkTest <hostname> <port>");
//            return;
//        }
//
//        // 设置数据源，接收socket的数据
//        String hostname = args[0];
//        Integer port = Integer.parseInt(args[1]);
//
//        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//
//        // 设置Flink的时间类型为EventTime
//        env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime);
//
//        // 接收socket数据
//        DataStreamSource<String> input = env.socketTextStream(hostname, port);
//
//        SingleOutputStreamOperator<Tuple2<String, Long>> inputMap = input.map(new MapFunction<String, Tuple2<String, Long>>() {
//            @Override
//            public Tuple2<String, Long> map(String value) throws Exception {
//                String[] arr = value.split("\\W+");
//                String code = arr[0];
//                Long s = Long.parseLong(arr[1]);
//                return new Tuple2<>(code, s);
//            }
//        });
//
//        SingleOutputStreamOperator<Tuple2<String, Long>> watermarkStream = inputMap.assignTimestampsAndWatermarks(new AssignerWithPeriodicWatermarks<Tuple2<String, Long>>() {
//            Long currentMaxTimeStamp = 0L;
//            Long maxOutOfOrderness = 10000L; // 最大允许的乱序时间是10s
//            Watermark watermark = null;
//
//            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//
//            @Nullable
//            @Override
//            public Watermark getCurrentWatermark() {
//                watermark = new Watermark(currentMaxTimeStamp - maxOutOfOrderness);
//                return watermark;
//            }
//
//            @Override
//            public long extractTimestamp(Tuple2<String, Long> element, long previousElementTimestamp) {
//                Long timestamp = element.f1;
//                currentMaxTimeStamp = Math.max(timestamp, currentMaxTimeStamp);
//                System.out.println("timestamp:" + element.f0 + "," + element.f1 + "|" + format.format(element.f1) + "," + currentMaxTimeStamp + "|" + format.format(currentMaxTimeStamp) + "," + watermark.toString());
//                return timestamp;
//            }
//        });
//
//        /**
//         * event time每隔3秒触发一次窗口，输出
//         * （code，窗口内元素个数，窗口内最早元素的时间，窗口内最晚元素的时间，窗口自身开始时间，窗口自身结束时间）
//         */
//        watermarkStream.keyBy(0).window(TumblingProcessingTimeWindows.of(Time.seconds(3))).apply(new WindowFunctionTest);
//
//
//    }
//
//    class WindowFunctionTest implements WindowFunction<Tuple2<String, Long>, Tuple6<String, Integer, String, String, String, String>, String, TimeWindow>{
//
//        @Override
//        public void apply(String key, TimeWindow window, Iterable<Tuple2<String, Long>> input, Collector<Tuple6<String, Integer, String, String, String, String>> out) throws Exception {
//
//            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//            out.collect(key,);
//        }
//    }
//}
