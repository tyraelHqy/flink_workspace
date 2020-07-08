package org.tryael.flink.course06;

import org.apache.flink.api.java.DataSet;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.table.api.Table;
import org.apache.flink.table.api.java.BatchTableEnvironment;
import org.apache.flink.types.Row;

public class JavaTableSQLAPI {
    public static void main(String[] args) throws Exception {
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        BatchTableEnvironment tableEnv = BatchTableEnvironment.create(env);
        String filePath = "file:///D:\\Users\\tyraelhuang\\IdeaProjects\\flink-workspace\\test-data\\sales.csv";
        DataSource<Sales> csv = env.readCsvFile(filePath)
                .ignoreFirstLine()
                .pojoType(Sales.class,"transcationId","customId","itemId","amountPaid");
        csv.print();

        Table sales = tableEnv.fromDataSet(csv);
        tableEnv.registerTable("sales",sales);
        Table resultTable = tableEnv.sqlQuery("select customId,sum(amountPaid) money from sales group by customId");
        DataSet<Row> result = tableEnv.toDataSet(resultTable, Row.class);
        result.print();
    }

    public static class Sales {
        public String transcationId;
        public String customId;
        public String itemId;
        public double amountPaid;

        public String getTranscationId() {
            return transcationId;
        }

        public void setTranscationId(String transcationId) {
            this.transcationId = transcationId;
        }

        public String getCustomId() {
            return customId;
        }

        public void setCustomId(String customId) {
            this.customId = customId;
        }

        public String getItemId() {
            return itemId;
        }

        public void setItemId(String itemId) {
            this.itemId = itemId;
        }

        public double getAmountPaid() {
            return amountPaid;
        }

        public void setAmountPaid(double amountPaid) {
            this.amountPaid = amountPaid;
        }

        @Override
        public String toString() {
            return "Sales{" +
                    "transcationId='" + transcationId + '\'' +
                    ", customId='" + customId + '\'' +
                    ", itemId='" + itemId + '\'' +
                    ", amountPaid=" + amountPaid +
                    '}';
        }
    }
}
