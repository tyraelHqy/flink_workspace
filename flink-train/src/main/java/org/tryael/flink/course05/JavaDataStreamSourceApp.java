package org.tryael.flink.course05;

import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;


public class JavaDataStreamSourceApp {

    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//        socketFunction(env);
//        nonParallelSourceFunction(env);
//        parallelSourceFunction(env);
        richParallelSourceFunction(env);
        env.execute("JavaDataStreamSourceApp");
    }

    public static void socketFunction(StreamExecutionEnvironment env) {

        DataStream<String> data = env.socketTextStream("localhost", 9999);
        data.print();
    }

    public static void nonParallelSourceFunction(StreamExecutionEnvironment env) {

        DataStream<Long> data = env.addSource(new JavaCustomNonParallelSourceFunction());
        data.print();
    }

    public static void parallelSourceFunction(StreamExecutionEnvironment env) {

        DataStream<Long> data = env.addSource(new JavaCustomParallelSourceFunction()).setParallelism(2);
        data.print();
    }

    public static void richParallelSourceFunction(StreamExecutionEnvironment env) {

        DataStream<Long> data = env.addSource(new JavaCustomRichParallelSourceFunction()).setParallelism(2);
        data.print();
    }
}
