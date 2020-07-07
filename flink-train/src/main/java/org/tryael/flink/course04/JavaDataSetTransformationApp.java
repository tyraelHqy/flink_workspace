package org.tryael.flink.course04;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.MapOperator;

import java.util.Arrays;
import java.util.List;

public class JavaDataSetTransformationApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        mapFunction(env);
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
}
