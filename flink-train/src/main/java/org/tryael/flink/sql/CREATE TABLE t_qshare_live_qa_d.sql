CREATE TABLE `t_qshare_live_qa_d` (
`Fdate` varchar(32) NOT NULL COMMENT '日期',
`Ftime_start` varchar(32) NOT NULL COMMENT '开始时间',
`Ftime_end` varchar(32) NOT NULL COMMENT '结束时间',
`room_id` varchar(32) NOT NULL COMMENT 'Q享号直播间id',
`live_pv` bigint(20) NOT NULL DEFAULT '0' COMMENT '直播间观看次数',
`live_uv` bigint(20) NOT NULL DEFAULT '0' COMMENT '直播间观看人数',
`live_online_uv` bigint(20) NOT NULL DEFAULT '0' COMMENT '直播间同时在线人数',
`live_title` varchar(32) NOT NULL COMMENT '直播间名称',
PRIMARY KEY (
`Fdate`,
`Ftime_start`,
`Ftime_end`,
`room_id`
)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb64 COMMENT = 'qshare实时计算直播累加数据qa'