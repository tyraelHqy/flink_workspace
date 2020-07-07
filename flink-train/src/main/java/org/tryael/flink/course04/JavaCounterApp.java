package org.tryael.flink.course04;

import org.apache.flink.api.common.JobExecutionResult;
import org.apache.flink.api.common.accumulators.LongCounter;
import org.apache.flink.api.common.functions.RichMapFunction;
import org.apache.flink.api.java.DataSet;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.MapOperator;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.core.fs.FileSystem;

public class JavaCounterApp {
    public static void main(String[] args) throws Exception{
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        DataSource<String> data = env.fromElements("hadoop", "spark", "flink", "pyspark", "storem");

        DataSet info = data.map(new RichMapFunction<String, String>() {

            LongCounter counter = new LongCounter();

            @Override
            public void open(Configuration parameters) throws Exception {
                super.open(parameters);

                getRuntimeContext().addAccumulator("ele-counts-java", counter);
            }

            @Override
            public String map(String value) throws Exception {
                counter.add(1);
                return value;
            }
        });

        String filename = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\sink-java-count-out";
        info.writeAsText(filename, FileSystem.WriteMode.OVERWRITE).setParallelism(5);
        JobExecutionResult jobResult = env.execute("CounterApp");

        Long num = jobResult.getAccumulatorResult("ele-counts-java");
        System.out.println("counts:"+num);
    }
}
