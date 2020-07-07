package org.tryael.flink.course04;

import org.apache.flink.api.common.functions.RichMapFunction;
import org.apache.flink.api.java.DataSet;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.MapOperator;
import org.apache.flink.configuration.Configuration;

import java.util.Collection;

public class JavaDataSetBroadcastApp {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();

        DataSet<Integer> toBroadcast = env.fromElements(1, 2, 3);

        DataSet<String> data = env.fromElements("a", "b");

        DataSet<String> result = data.map(new RichMapFunction<String, String>() {
            @Override
            public void open(Configuration parameters) throws Exception {
                // 3. Access the broadcast DataSet as a Collection
                Collection<Integer> broadcastSet = getRuntimeContext().getBroadcastVariable("broadcastSetName");
                for (Integer broadcast :broadcastSet){
                    System.out.println(broadcast);
                }
            }


            @Override
            public String map(String value) throws Exception {
                return value;
            }
        }).withBroadcastSet(toBroadcast, "broadcastSetName");// 2. Broadcast the DataSet

        result.print();
    }
}
