insert
into t_qshare_store_realtime_d_qa
select t1.Fdate,
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
    (select
    FixedTime(TUMBLE_START(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyyMMdd', false) as Fdate,
    FixedTime(TUMBLE_START(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_start,
    FixedTime(TUMBLE_END(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_end,
    store_id,
    qid,
    count (distinct orderNo) as order_num,
    count (distinct uid) as order_user_num,
    sum(paymentAmount) as order_amount,
    max(storeName) as storeName,
    max(qidName) as qidName
    FROM
    ( select
    `timestamp`,
    cast(data.storeId as varchar) as store_id,
    data.qid as qid,
    data.orderNo as orderNo,
    data.saasId as saasId,
    data.uid as uid,
    data.paymentStatus as paymentStatus,
    cast((data.paymentAmount) as bigint) as paymentAmount,
    -- data.`time` as `time`,
    data.env as env,
    data.event as event,
    data.storeName as storeName,
    data.qidName as qidName
    from
    t_kafka_qshare_order_source_qa
    where
    data.env='qa'
    and data.event='CREATE_ORDER'
    -- and saasId=''
    ) a
    where
    a.store_id is not null
    and a.qid is not null
    and a.store_id <> 'null'
    and a.qid <> 'null'
    group by
    TUMBLE(a.`timestamp`,
    INTERVAL '10' MINUTE),
    a.store_id,
    a.qid ) t1
    join
    ---支付相关
    (select
    FixedTime(TUMBLE_START(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyyMMdd', false) as Fdate,
    FixedTime(TUMBLE_START(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_start,
    FixedTime(TUMBLE_END(`timestamp`,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_end,
    store_id,
    qid,
    count (distinct orderNo) as pay_num,
    count (distinct uid) as pay_user_num,
    sum(paymentAmount) as pay_amount,
    max(storeName) as storeName,
    max(qidName) as qidName
    FROM
    ( select
    `timestamp`,
    cast(data.storeId as varchar) as store_id,
    data.qid as qid,
    data.orderNo as orderNo,
    data.saasId as saasId,
    data.uid as uid,
    data.paymentStatus as paymentStatus,
    cast((data.paymentAmount) as bigint) as paymentAmount,
    -- data.`time` as `time`,
    data.env as env,
    data.event as event,
    data.storeName as storeName,
    data.qidName as qidName
    from
    t_kafka_qshare_pay_source
    where
    data.env='qa'
    and data.event='PAYSUCCESS'
    -- and saasId=''
    ) b
    where
    b.store_id is not null
    and b.qid is not null
    and b.store_id <> 'null'
    and b.qid <> 'null'
    group by
    TUMBLE(b.`timestamp`,
    INTERVAL '10' MINUTE),
    b.store_id,
    b.qid ) t2
on t1.Fdate=t2.Fdate
    and t1.Ftime_start=t2.Ftime_start
    and t1.store_id=t2.store_id
    and t1.qid=t2.qid


insert
into t_qshare_store_realtime_d_qa
select t2.Fdate,
       t2.Ftime_start,
       t2.Ftime_end,
       t2.store_id,
       t2.qid,
       t2.pay_num,
       t2.pay_user_num,
       t2.pay_amount,
       t2.storeName,
       t2.qidName
from
    ---支付相关
    (select
    FixedTime(TUMBLE_START(`timestamp`, INTERVAL '10' MINUTE), 'yyyyMMdd', false) as Fdate,
    FixedTime(TUMBLE_START(`timestamp`, INTERVAL '10' MINUTE), 'yyyy-MM-dd HH:mm:SS', false) as Ftime_start,
    FixedTime(TUMBLE_END(`timestamp`, INTERVAL '10' MINUTE), 'yyyy-MM-dd HH:mm:SS', false) as Ftime_end,
    store_id,
    qid,
    count (distinct orderNo) as pay_num,
    count (distinct uid) as pay_user_num,
    sum(paymentAmount) as pay_amount,
    max(storeName) as storeName,
    max(qidName) as qidName
    FROM
    (
    select
    `timestamp`,
    cast(data.storeId as varchar) as store_id,
    data.qid as qid,
    data.orderNo as orderNo,
    data.saasId as saasId,
    data.uid as uid,
    data.paymentStatus as paymentStatus,
    cast((data.paymentAmount) as bigint) as paymentAmount,
    -- data.`time` as `time`,
    data.env as env,
    data.event as event,
    data.storeName as storeName,
    data.qidName as qidName
    from
    t_kafka_qshare_pay_source
    where
    data.env='qa'
    and data.event='PAYSUCCESS'
    -- and saasId=''
    ) b
    where
    b.store_id is not null
    and b.qid is not null
    and b.store_id <> 'null'
    and b.qid <> 'null'
    group by
    TUMBLE(b.`timestamp`, INTERVAL '10' MINUTE),
    b.store_id,
    b.qid
    ) t2


CREATE TABLE `t_sam_pay_pvuv_online`
(
    `Fdate`        varchar(40) NOT NULL COMMENT '开始日期',
    `Ftime_start`  varchar(40) NOT NULL COMMENT '开始时间',
    `Ftime_end`    varchar(40) NOT NULL COMMENT '结束时间',
    `store_id`     varchar(40) NOT NULL COMMENT '店铺Id',
    `qid`          varchar(40) NOT NULL COMMENT 'qId',
    `pv`           bigint(255) NOT NULL DEFAULT '0' COMMENT '人次',
    `uv`           bigint(255) NOT NULL DEFAULT '0' COMMENT '人数',
    `pay_user_num` bigint(255) NOT NULL DEFAULT '0' COMMENT '支付用户数',
    `pay_amount`   bigint(255) NOT NULL DEFAULT '0' COMMENT '支付订单数',
    `pay_num`      bigint(255) NOT NULL DEFAULT '0' COMMENT '实付金额',
    `pay_num`      bigint(255) NOT NULL DEFAULT '0' COMMENT '实付金额',
    PRIMARY KEY (
                 `Fdate`,
                 `Ftime_start`,
                 `Ftime_end`,
                 `store_id`,
                 `qid`
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'sams online直播下单支付统计表'

CREATE TABLE `t_sams_payment_amount_acc_online`
(
    `Fdate`        varchar(40) NOT NULL COMMENT '开始日期',
    `Ftime_start`  varchar(40) NOT NULL COMMENT '开始时间',
    `Ftime_end`    varchar(40) NOT NULL COMMENT '结束时间',
    `pay_num`      bigint(255) NOT NULL DEFAULT '0' COMMENT '支付订单数',
    `pay_user_num` bigint(255) NOT NULL DEFAULT '0' COMMENT '支付用户数',
    `pay_amount`   bigint(255) NOT NULL DEFAULT '0' COMMENT '实付金额',
    PRIMARY KEY (
                 `Fdate`,
                 `Ftime_start`,
                 `Ftime_end`
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'sams online直播下单支付统计表';

CREATE TABLE `t_qshare_all_online_acc_pvuv`
(
    `Fdate`       varchar(40) NOT NULL COMMENT '开始日期',
    `Ftime_start` varchar(40) NOT NULL COMMENT '开始时间',
    `Ftime_time`  varchar(40) NOT NULL COMMENT '当前聚合结果的时间',
    `Ftime_end`   varchar(40) NOT NULL COMMENT '结束时间',
    `pv`          bigint(255) NOT NULL DEFAULT '0' COMMENT '人次',
    `uv`          bigint(255) NOT NULL DEFAULT '0' COMMENT '人数',
    PRIMARY KEY (
                 `Fdate`,
                 `Ftime_start`,
                 `Ftime_time`,
                 `Ftime_end`
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'V享online直播uvpv统计表'


CREATE TABLE `t_sams_kafka_test`
(
    `Fdate`         varchar(40) NOT NULL COMMENT '开始日期',
    `Ftime_start`   varchar(40) NOT NULL COMMENT '开始时间',
    `Ftime_end`     varchar(40) NOT NULL COMMENT '结束时间',
    `store_id`      varchar(40) NOT NULL COMMENT '店铺Id',
    `orderNo`       varchar(40) NOT NULL COMMENT '支付用户数',
    `uid`           varchar(40) NOT NULL COMMENT '支付订单数',
    `paymentAmount` bigint(255) NOT NULL COMMENT '实付金额',
    PRIMARY KEY (
                 `Fdate`,
                 `Ftime_start`,
                 `Ftime_end`,
                 `store_id`
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'sam online环境kafka test';

CREATE TABLE `t_sam_online_acc_pvuv`
(
    `Fdate`       varchar(40) NOT NULL COMMENT '开始日期',
    `Ftime_start` varchar(40) NOT NULL COMMENT '开始时间',
    `Ftime_time`  varchar(40) NOT NULL COMMENT '当前聚合结果的时间',
    `Ftime_end`   varchar(40) NOT NULL COMMENT '结束时间',
    `pv`          bigint(255) NOT NULL DEFAULT '0' COMMENT 'pv',
    `uv`          bigint(255) NOT NULL DEFAULT '0' COMMENT 'uv',
    PRIMARY KEY (
                 `Fdate`,
                 `Ftime_start`,
                 `Ftime_time`,
                 `Ftime_end`
        )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'sam online环境前端累计PVUV';

select FixedTime(Tumble_start(action_time, INTERVAL '1' MINUTE), 'yyyyMMdd')            as Fdate,
       FixedTime(Tumble_start(action_time, INTERVAL '1' MINUTE), 'yyyy-MM-dd HH:mm:SS') as Ftime_start,
       FixedTime(Tumble_end(action_time, INTERVAL '1' MINUTE), 'yyyy-MM-dd HH:mm:SS')   as Ftime_end,
       cast(store_id as varchar)                                                        as store_id,
       cast(count(1) as bigint)                                                         as store_pv
    cast(count(distinct local_id) as bigint)as store_uv
from (
         select action_time,
                GET_JSON_VALUE(json_properties, '$.chan.store_id') as store_id,
                local_id
         from sam_dev_source
         where action_type = 'browse_wxapp_page'
     )
group by TUMBLE(action_time, INTERVAL '1' MINUTE), store_id;