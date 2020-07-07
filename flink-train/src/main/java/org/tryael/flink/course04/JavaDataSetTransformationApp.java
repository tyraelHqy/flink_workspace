package org.tryael.flink.course04;

import org.apache.flink.api.common.functions.*;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.MapOperator;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.tuple.Tuple3;
import org.apache.flink.util.Collector;
import org.tyrael.flink.course04.DBUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static sun.misc.Version.print;

public class JavaDataSetTransformationApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
//        mapFunction(env);
//        filterFunction(env);
//        mapPartitionFunction(env);
//        flatMapFunction(env);
//        distinctFunction(env);

//        joinFunction(env);
        outJoinFunction(env);
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

    public static void joinFunction(ExecutionEnvironment env) throws Exception {

        List<Tuple2<Integer, String>> info1 = new ArrayList<>();
        info1.add(new Tuple2<>(1, "PKK"));
        info1.add(new Tuple2<>(2, "JKKK"));
        info1.add(new Tuple2<>(3, "QLL"));
        info1.add(new Tuple2<>(4, "YUW"));

        List<Tuple2<Integer, String>> info2 = new ArrayList<>();
        info2.add(new Tuple2<>(1, "北京"));
        info2.add(new Tuple2<>(2, "上海"));
        info2.add(new Tuple2<>(3, "成都"));
        info2.add(new Tuple2<>(5, "杭州"));

        DataSource<Tuple2<Integer, String>> data1 = env.fromCollection(info1);
        DataSource<Tuple2<Integer, String>> data2 = env.fromCollection(info2);

        data1.join(data2).where(0)
                .equalTo(0)
                .with(new JoinFunction<Tuple2<Integer, String>, Tuple2<Integer, String>, Tuple3<Integer, String, String>>() {
                    @Override
                    public Tuple3<Integer, String, String> join(Tuple2<Integer, String> first, Tuple2<Integer, String> second) throws Exception {
                        return new Tuple3<>(first.f0, first.f1, second.f1);
                    }
                }).print();

    }

    public static void outJoinFunction(ExecutionEnvironment env) throws Exception {

        List<Tuple2<Integer, String>> info1 = new ArrayList<>();
        info1.add(new Tuple2<>(1, "PKK"));
        info1.add(new Tuple2<>(2, "JKKK"));
        info1.add(new Tuple2<>(3, "QLL"));
        info1.add(new Tuple2<>(4, "YUW"));

        List<Tuple2<Integer, String>> info2 = new ArrayList<>();
        info2.add(new Tuple2<>(1, "北京"));
        info2.add(new Tuple2<>(2, "上海"));
        info2.add(new Tuple2<>(3, "成都"));
        info2.add(new Tuple2<>(5, "杭州"));

        DataSource<Tuple2<Integer, String>> data1 = env.fromCollection(info1);
        DataSource<Tuple2<Integer, String>> data2 = env.fromCollection(info2);


        data1.leftOuterJoin(data2).where(0)
                .equalTo(0)
                .with(new JoinFunction<Tuple2<Integer, String>, Tuple2<Integer, String>, Tuple3<Integer, String, String>>() {
                    @Override
                    public Tuple3<Integer, String, String> join(Tuple2<Integer, String> first, Tuple2<Integer, String> second) throws Exception {
                        if (second == null) {
                            return new Tuple3<>(first.f0, first.f1, "-");
                        }
                        return new Tuple3<>(first.f0, first.f1, second.f1);
                    }
                }).print();

        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

        data1.rightOuterJoin(data2).where(0)
                .equalTo(0)
                .with(new JoinFunction<Tuple2<Integer, String>, Tuple2<Integer, String>, Tuple3<Integer, String, String>>() {
                    @Override
                    public Tuple3<Integer, String, String> join(Tuple2<Integer, String> first, Tuple2<Integer, String> second) throws Exception {
                        if (first == null) {
                            return new Tuple3<>(second.f0, "-", second.f1);
                        }
                        return new Tuple3<>(first.f0, first.f1, second.f1);
                    }
                }).print();
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

        data1.fullOuterJoin(data2).where(0)
                .equalTo(0)
                .with(new JoinFunction<Tuple2<Integer, String>, Tuple2<Integer, String>, Tuple3<Integer, String, String>>() {
                    @Override
                    public Tuple3<Integer, String, String> join(Tuple2<Integer, String> first, Tuple2<Integer, String> second) throws Exception {
                        if (first == null) {
                            return new Tuple3<>(second.f0, "-", second.f1);
                        } else if (second == null) {
                            return new Tuple3<>(first.f0, first.f1, "-");
                        }
                        return new Tuple3<>(first.f0, first.f1, second.f1);
                    }
                }).print();
    }
}
