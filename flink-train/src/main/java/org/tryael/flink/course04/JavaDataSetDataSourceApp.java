package org.tryael.flink.course04;

import org.apache.flink.api.java.ExecutionEnvironment;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class JavaDataSetDataSourceApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        fromCollection(env);
    }

    public static void fromCollection(ExecutionEnvironment env) throws Exception {
        List<Integer> list = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
        env.fromCollection(list).print();
    }
}
