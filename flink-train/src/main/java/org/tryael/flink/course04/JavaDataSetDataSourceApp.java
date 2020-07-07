package org.tryael.flink.course04;

import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class JavaDataSetDataSourceApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();

        fromTextFile(env);
//        fromCollection(env);
    }

    public static void fromCollection(ExecutionEnvironment env) throws Exception {
        List<Integer> list = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
        env.fromCollection(list).print();
    }

    public static void fromTextFile(ExecutionEnvironment env) throws Exception {

        String filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\input.txt";

        // step2: read data
        DataSource<String> text = env.readTextFile(filePath);
        text.print();

        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~分割线~~~~~~~~~~~~~~~~~~~~~~~~~");

        filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\inputs";
        env.readTextFile(filePath).print();
    }

}
