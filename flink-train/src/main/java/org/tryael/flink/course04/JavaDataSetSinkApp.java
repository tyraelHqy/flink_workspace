package org.tryael.flink.course04;

import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.core.fs.FileSystem;

import java.util.Arrays;
import java.util.List;

public class JavaDataSetSinkApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        String filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\sink-out";
        DataSource<Integer> data = env.fromCollection(list);

        data.writeAsText(filePath, FileSystem.WriteMode.OVERWRITE);

        env.execute("JavaDataSetSinkApp");
    }
}
