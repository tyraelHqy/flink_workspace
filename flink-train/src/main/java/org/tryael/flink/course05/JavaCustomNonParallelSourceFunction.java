package org.tryael.flink.course05;

import org.apache.flink.streaming.api.functions.source.SourceFunction;

public class JavaCustomNonParallelSourceFunction implements SourceFunction<Long> {

    boolean isRunning = true;
    long count = 1;

    @Override
    public void run(SourceContext ctx) throws Exception {
        while (true) {
            ctx.collect(count);
            count++;
            Thread.sleep(1000);
        }
    }

    @Override
    public void cancel() {
        isRunning = false;
    }
}
