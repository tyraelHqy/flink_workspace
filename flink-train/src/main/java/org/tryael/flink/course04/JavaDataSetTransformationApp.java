package org.tryael.flink.course04;

import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.functions.MapPartitionFunction;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.MapOperator;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.util.Collector;
import org.tyrael.flink.course04.DBUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class JavaDataSetTransformationApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
//        mapFunction(env);
//        filterFunction(env);
//        mapPartitionFunction(env);
//        flatMapFunction(env);
        distinctFunction(env);

    }


    public static void mapFunction(ExecutionEnvironment env) throws Exception {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        DataSource<Integer> dataSource = env.fromCollection(list);

        MapOperator<Integer, Integer> map = dataSource.map(new MapFunction<Integer, Integer>() {
            @Override
            public Integer map(Integer input) throws Exception {
                return input + 1;
            }
        });
        map.print();
    }

    public static void filterFunction(ExecutionEnvironment env) throws Exception {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        DataSource<Integer> dataSource = env.fromCollection(list);

        dataSource.map(new MapFunction<Integer, Integer>() {
            @Override
            public Integer map(Integer input) throws Exception {
                return input + 1;
            }
        }).filter(new FilterFunction<Integer>() {
            @Override
            public boolean filter(Integer input) throws Exception {
                return input > 5;
            }
        }).print();
    }

    public static void mapPartitionFunction(ExecutionEnvironment env) throws Exception {
        List<String> list = new ArrayList<>();
        for (int i = 1; i <= 100; i++) {
            list.add("student: " + i);
        }
        DataSource<String> data = env.fromCollection(list).setParallelism(6);

//        data.map(new MapFunction<String, String>() {
//            @Override
//            public String map(String value) throws Exception {
//                String connection = DBUtils.getConnection();
//                System.out.println("Connection: " + connection);
//                DBUtils.returnConnection(connection);
//                return value;
//            }
//        }).print();

        data.mapPartition(new MapPartitionFunction<String, String>() {
            @Override
            public void mapPartition(Iterable<String> values, Collector<String> out) throws Exception {
                String connection = DBUtils.getConnection();
                System.out.println("Connection: " + connection);
                DBUtils.returnConnection(connection);
            }
        }).print();
    }

    public static void flatMapFunction(ExecutionEnvironment env) throws Exception {
        List<String> info = new ArrayList<>();
        info.add("hadoop,spark");
        info.add("hadoop,flink");
        info.add("flink,flink");

        DataSource<String> stringDataSource = env.fromCollection(info);
        stringDataSource.flatMap(new FlatMapFunction<String, String>() {
            @Override
            public void flatMap(String input, Collector<String> out) throws Exception {
                String[] splits = input.split(",");
                for (String s : splits) {
                    out.collect(s);
                }
            }
        }).map(new MapFunction<String, Tuple2<String, Integer>>() {
            @Override
            public Tuple2<String, Integer> map(String value) throws Exception {
                return new Tuple2<String, Integer>(value, 1);
            }
        }).groupBy(0).sum(1).print();
    }

    public static void distinctFunction(ExecutionEnvironment env) throws Exception {
        List<String> info = new ArrayList<>();
        info.add("hadoop,spark");
        info.add("hadoop,flink");
        info.add("flink,flink");

        DataSource<String> stringDataSource = env.fromCollection(info);
        stringDataSource.flatMap(new FlatMapFunction<String, String>() {
            @Override
            public void flatMap(String input, Collector<String> out) throws Exception {
                String[] splits = input.split(",");
                for (String s : splits) {
                    out.collect(s);
                }
            }
        }).distinct().print();
    }
}
