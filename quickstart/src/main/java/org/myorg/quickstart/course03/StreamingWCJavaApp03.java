package org.myorg.quickstart.course03;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.functions.RichFlatMapFunction;
import org.apache.flink.api.java.functions.KeySelector;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.utils.ParameterTool;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.util.Collector;

/**
 * 使用Java API来开发Flink的实时处理应用程序
 * <p>
 * wc统计的数据源自于socket
 */
public class StreamingWCJavaApp03 {

    public static void main(String[] args) throws Exception {

        // 获取参数
        int port;
        try {
            ParameterTool tool = ParameterTool.fromArgs(args);
            port = tool.getInt("port");
        } catch (Exception e) {
            System.err.println("端口未设置，使用默认端口9999");
            port = 9999;
        }
        // step1：获取执行环境
        final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        // step2: 读取数据
        DataStreamSource<String> text = env.socketTextStream("localhost", port);

        // step3： transform
//        text.flatMap(new MyFlatMapFunction())
        text.flatMap(new RichFlatMapFunction<String, WordCount>() {
            @Override
            public void flatMap(String value, Collector<WordCount> collector) throws Exception {
                String[] tokens = value.toLowerCase().split(",");

                for (String token : tokens) {
                    if (token.length() > 0) {
                        collector.collect(new WordCount(token.trim(), 1));
                    }
                }
            }
        })
                .keyBy(new KeySelector<WordCount, String>() {
                    @Override
                    public String getKey(WordCount wordCount) throws Exception {
                        return wordCount.word;
                    }
                })
                .timeWindow(Time.seconds(5))
                .sum("count")
                .print()
                .setParallelism(1);

//        text.flatMap(new FlatMapFunction<String, Tuple2<String, Integer>>() {
//            @Override
//            public void flatMap(String value, Collector<Tuple2<String, Integer>> collector) throws Exception {
//                String[] tokens = value.toLowerCase().split(",");
//
//                for (String token : tokens) {
//                    if (token.length() > 0) {
//                        collector.collect(new Tuple2<String, Integer>(token, 1));
//                    }
//                }
//
//            }
//        }).keyBy(0).timeWindow(Time.seconds(5)).sum(1).print().setParallelism(1);


        env.execute("StreamingWCJavaApp03");

    }

    public static class MyFlatMapFunction implements FlatMapFunction<String, WordCount> {

        @Override
        public void flatMap(String value, Collector<WordCount> collector) throws Exception {
            String[] tokens = value.toLowerCase().split(",");

            for (String token : tokens) {
                if (token.length() > 0) {
                    collector.collect(new WordCount(token.trim(), 1));
                }
            }
        }
    }

    public static class WordCount {
        private String word;
        private int count;

        public WordCount() {
        }

        public WordCount(String word, int count) {
            this.word = word;
            this.count = count;
        }

        public String getWord() {
            return word;
        }

        public void setWord(String word) {
            this.word = word;
        }

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }

        @Override
        public String toString() {
            return "WordCount{" +
                    "word='" + word + '\'' +
                    ", count=" + count +
                    '}';
        }
    }

}
