package org.tryael.flink.course05;

import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.functions.source.RichParallelSourceFunction;

public class JavaCustomRichParallelSourceFunction extends RichParallelSourceFunction<Long> {
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

    @Override
    public void open(Configuration parameters) throws Exception {
        super.open(parameters);
    }

    @Override
    public void close() throws Exception {
        super.close();
    }
}
