insert
into
    t_qshare_store_realtime_d_qa
select
    t1.Fdate,
    t1.Ftime_start,
    t1.Ftime_end,
    t1.store_id,
    t1.qid,
    t1.order_num,
    t1.order_user_num,
    t2.pay_num,
    t2.pay_user_num,
    t2.pay_amount,
    t1.order_amount,
    t1.storeName,
    t1.qidName
from
    ---订单相关
    (
        select
            FixedTime(TUMBLE_START(`timestamp`,INTERVAL '10' MINUTE),'yyyyMMdd',false) as Fdate,
            FixedTime(TUMBLE_START(`timestamp`,INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS',false) as Ftime_start,
            FixedTime(TUMBLE_END(`timestamp`,INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS',false) as Ftime_end,
            store_id,
            qid,
            count(distinct orderNo) as order_num,
            count(distinct uid) as order_user_num,
            sum(paymentAmount) as order_amount,
            max(storeName) as storeName,
            max(qidName) as qidName
        FROM(
            select
                `timestamp`,
                cast(data.storeId as varchar)as store_id,
                data.qid as qid,
                data.orderNo as orderNo,
                data.saasId as saasId,
                data.uid as uid,
                data.paymentStatus as paymentStatus,
                cast((data.paymentAmount) as bigint) as paymentAmount,
                --data.`time` as `time`,
                data.env as env,
                data.event as event,
                data.storeName as storeName,
                data.qidName as qidName
            from
                t_kafka_qshare_order_source_qa
            where
                data.env='qa'
                and data.event='CREATE_ORDER'
                --and saasId=''
            ) a
        where
            a.store_id is not null
            and a.qid is not null
            and a.store_id <> 'null'
            and a.qid <> 'null'
            group by
            TUMBLE(a.`timestamp`,INTERVAL '10' MINUTE),a.store_id,a.qid
    )t1
    join
    ---支付相关
    (
        select
            FixedTime(TUMBLE_START(`timestamp`, INTERVAL '10' MINUTE),'yyyyMMdd',false) as Fdate,
            FixedTime(TUMBLE_START(`timestamp`, INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS',false) as Ftime_start,
            FixedTime(TUMBLE_END(`timestamp`, INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS',false) as Ftime_end,
            store_id,
            qid,
            count(distinct orderNo) as pay_num,
            count(distinct uid) as pay_user_num,
            sum(paymentAmount) as pay_amount,
            max(storeName) as storeName,
            max(qidName) as qidName
        FROM
        (
            select
                `timestamp`,
                cast(data.storeId as varchar)as store_id,
                data.qid as qid,
                data.orderNo as orderNo,
                data.saasId as saasId,
                data.uid as uid,
                data.paymentStatus as paymentStatus,
                cast((data.paymentAmount) as bigint)  as paymentAmount,
                --data.`time` as `time`,
                data.env as env,
                data.event as event,
                data.storeName as storeName,
                data.qidName as qidName
            from
                t_kafka_qshare_pay_source
            where
                data.env='qa'
                and data.event='PAYSUCCESS'
                --and saasId=''
        ) b
    where
        b.store_id is not null
        and b.qid is not null
        and b.store_id <> 'null'
        and b.qid <> 'null'
        group by
        TUMBLE(b.`timestamp`,INTERVAL '10' MINUTE),
        b.store_id,
        b.qid
    )t2
on t1.Fdate=t2.Fdate
    and t1.Ftime_start=t2.Ftime_start
    and t1.store_id=t2.store_id
    and t1.qid=t2.qid