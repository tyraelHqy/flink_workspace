id ,
  saas_id ,
  uid ,
  channel_type ,
  channel_name ,
  open_id ,
  app_id ,
  wx_union_id ,
  password ,
  invitation_code ,
  is_forever ,
  effective_start_time ,
  effective_end_time ,
  register_time ,
  source_type ,
  create_time ,
  update_time ,

select id,
       saas_id,
       uid,
       is_member,
       user_name,
       first_name_chinese,
       last_name_chinese,
       first_name_english,
       last_name_english,
       nickname,
       phone,
       sex,
       birthday,
       id_card_type,
       id_card_no,
       head_url,
       country_name
from t_user_info_0;



CREATE TABLE if not exists sam_ods_user_info_0_d
(
    id           bigint COMMENT '自增id',
    saas_id      bigint COMMENT '商户id',
    uid string COMMENT '用户id',
    is_member    tinyint COMMENT '是否会员 0否 1是',
    user_name string COMMENT '用户名',
    first_name_chinese string COMMENT '名-中文',
    last_name_chinese string COMMENT '姓-中文',
    first_name_english string COMMENT '名-英文',
    last_name_english string COMMENT '姓-英文',
    nickname string COMMENT '昵称',
    phone string COMMENT '手机号',
    sex          tinyint COMMENT '0未知 1男 2女',
    birthday string COMMENT '生日 如1970-01-01',
    id_card_type tinyint COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string COMMENT '证件号',
    head_url string COMMENT '头像url',
    country_name string COMMENT '国家名称',
    country_code string COMMENT '国家编码',
    province_name string COMMENT '省名称',
    province_code string COMMENT '省编码',
    city_name string COMMENT '市名称',
    city_code string COMMENT '市编码',
    district_name string COMMENT '区名称',
    district_code string COMMENT '区编码',
    detail_address string COMMENT '详细地址',
    slot1 string COMMENT '插槽1',
    slot2 string COMMENT '插槽2',
    slot3 string COMMENT '插槽3',
    slot4 string COMMENT '插槽4',
    slot5 string COMMENT '插槽5',
    slot6 string COMMENT '插槽6',
    slot7 string COMMENT '插槽7',
    slot8 string COMMENT '插槽8',
    slot9 string COMMENT '插槽9',
    slot10 string COMMENT '插槽10',
    extend string COMMENT '扩展信息 json对象',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间'

) COMMENT '用户信息表' partition by list (fdate)(partition default);

CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表'

use yunmall_qa;
CREATE TABLE if not exists sam_ods_register_auth_d
(
    id           bigint COMMENT '自增id',
    saas_id      bigint COMMENT '商户id',
    uid string COMMENT '用户id',
    channel_type tinyint COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string COMMENT '渠道名称 跟channel_type对应',
    open_id string COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string COMMENT '微信unionid',
    password string COMMENT '渠道认证密码',
    invitation_code string COMMENT '邀请码',
    is_forever   tinyint COMMENT '1：永久有效 2：限时有效',
    effective_start_time string COMMENT '账户有效开始时间',
    effective_end_time string COMMENT '账户有效结束时间',
    register_time string COMMENT '注册时间',
    source_type  tinyint COMMENT '用户来源 0用户注册 1后台导入',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    fdate string comment '分区字段'
) COMMENT '注册鉴权表' partition by list (fdate)(partition default);

INSERT OVERWRITE table sam_ods_register_auth_d partition (fate = '${YYYYMMDD}')
select id,
       saas_id,
       uid,
       channel_type,
       channel_name,
       open_id,
       app_id,
       wx_union_id,
       password,
       invitation_code,
       is_forever,
       effective_start_time,
       effective_end_time,
       register_time,
       source_type,
       create_time,
       update_time,
       '${YYYYMMDD}'

from (select *
      from sam_ods_register_auth_0_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_1_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_2_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_3_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_4_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_5_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_6_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_7_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_8_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_9_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_10_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_11_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_12_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_13_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_14_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_register_auth_15_d
      where fdate = '${YYYYMMDD}') tb;


CREATE TABLE t_message_task_count
(
    id              bigint(20)   NOT NULL COMMENT '主键id',
    message_task_id bigint(20)   NOT NULL DEFAULT '0' COMMENT '消息任务id',
    job_id          bigint(20)   NOT NULL DEFAULT '0' COMMENT '任务批次id',
    fail_count      bigint(20)   NOT NULL DEFAULT '0' COMMENT '失败数',
    success_count   bigint(20)   NOT NULL DEFAULT '0' COMMENT '成功数',
    total_count     bigint(20)   NOT NULL DEFAULT '0' COMMENT '总数',
    count_status    tinyint(255) NOT NULL DEFAULT '0' COMMENT '0-未统计结束 1-已统计',
    send_status     tinyint(4)   NOT NULL DEFAULT '0' COMMENT '0-未发送 1-已发送',
    message_type    tinyint(4)   NOT NULL DEFAULT '0' COMMENT '0-默认 1-短信 2-apppush 3-站内信',
    PRIMARY KEY (id),
    KEY idx_job_id (job_id) USING BTREE COMMENT '任务批次id索引'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '消息任务统计表'

select id,
       message_task_id,
       job_id,
       fail_count,
       success_count,
       total_count,
       count_status,
       send_status,
       message_type
from t_message_task_count;

use yunmall_qa;
CREATE TABLE if not exists sam_ods_message_task_count_d
(
    id              bigint COMMENT '主键id',
    message_task_id bigint COMMENT '消息任务id',
    job_id          bigint COMMENT '任务批次id',
    fail_count      bigint COMMENT '失败数',
    success_count   bigint COMMENT '成功数',
    total_count     bigint COMMENT '总数',
    count_status    tinyint COMMENT '0-未统计结束 1-已统计',
    send_status     tinyint COMMENT '0-未发送 1-已发送',
    message_type    tinyint COMMENT '0-默认 1-短信 2-apppush 3-站内信',
    fdate string comment '分区字段'
) COMMENT '消息任务统计表' partition by list (fdate)(partition default);

CREATE TABLE if not exists sam_ods_t_message_task_d
(
    id                 bigint COMMENT '主键ID',
    task_name string COMMENT '任务名称',
    message_type       tinyint COMMENT '0-默认 1-短信 2-apppush 3-站内信',
    language string COMMENT '0-中文 1-英文 多语言用英文逗号隔开',
    chinese_title string COMMENT '中文签名',
    chinese_message_content string COMMENT '中文短信内容',
    english_title string COMMENT '英文签名',
    english_message_content string COMMENT '英文短信内容',
    android_pic string COMMENT 'android图片',
    ios_pic string COMMENT 'ios图片',
    ios_system_url string COMMENT 'ios系统跳转链接',
    android_system_url string COMMENT 'android系统跳转链接',
    ios_customize_url string COMMENT 'ios自定义链接',
    android_customize_url string COMMENT 'android自定义链接',
    push_channel string COMMENT '推送渠道 0-默认 1-Android 2-IOS 多个渠道用英文隔开',
    user_tag string COMMENT '用户标签，多个用逗号隔开',
    push_time string COMMENT '推送时间',
    push_status        int COMMENT '0-未推送 1-推送中 2-推送成功 3-审核中 4-审核未通过 ',
    push_success_count bigint COMMENT '推送成功数',
    push_fail_count    bigint COMMENT '推送失败数',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    is_delete          tinyint COMMENT '0-正常 1-删除',
    fetch_id string COMMENT '获取标签批次ID',
    msg_template_id string COMMENT '短信模板ID',
    fdate string comment '分区字段'
        PRIMARY KEY (id)
) COMMENT '消息任务表' partition by list (fdate)(partition default);

select id,
       task_name,
       message_type,
       language,
       chinese_title,
       chinese_message_content,
       english_title,
       english_message_content,
       android_pic,
       ios_pic,
       ios_system_url,
       android_system_url,
       ios_customize_url,
       android_customize_url,
       push_channel,
       user_tag,
       push_time,
       push_status,
       push_success_count,
       push_fail_count,
       create_time,
       update_time,
       is_delete,
       fetch_id,
       msg_template_id
from t_message_task;

CREATE TABLE if not exists sam_ods_t_spu_front_category_d
(
    id                bigint COMMENT '主键,自增id',
    saas_id           bigint COMMENT '商家id',
    store_id          bigint COMMENT '门店id',
    spu_id            bigint COMMENT 'spuid',
    front_category_id bigint COMMENT '后台类目id',
    is_deleted        tinyint COMMENT '是否删除，0：未删除；1：已删除',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    fdate string COMMENT '分区字段'
) COMMENT 'spu前台类目' partition by list (fdate)(partition default);
INSERT OVERWRITE table sam_ods_t_spu_front_category_d partition (fdate = '${YYYYMMDD}')
select id,
       saas_id,
       store_id,
       spu_id,
       front_category_id,
       is_deleted,
       create_time,
       update_time,
       '${YYYYMMDD}'
from (select *
      from sam_ods_t_spu_front_category_0_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_1_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_2_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_3_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_4_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_5_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_6_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_spu_front_category_7_d
      where fdate = '${YYYYMMDD}') tb;



use yunmall_qa;

create table if not exists t_front_category
(
    front_category_id bigint COMMENT '商家id',
    saas_id           bigint COMMENT '商家id',
    store_id          bigint COMMENT '门店id',
    title string COMMENT '类目名称',
    e_title string COMMENT '英文名称',
    image string COMMENT '类目图片',
    parent_tree string COMMENT '父类目树',
    parent_id         bigint COMMENT '父类目id',
    level             int COMMENT '类目层级',
    is_available      tinyint DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext string COMMENT '扩展字段',
    is_deleted        tinyint COMMENT '是否删除，0：未删除；1：已删除',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    priority          int COMMENT '优先级(用于排序)',
    fdate string COMMENT '分区字段'
) COMMENT '前台类目表'
select front_category_id,
       saas_id,
       store_id,
       title,
       e_title,
       image,
       parent_tree,
       parent_id,
       level,
       is_available,
       ext,
       is_deleted,
       create_time,
       update_time,
       priority,
       '${YYYYMMDD}'
from (select *
      from sam_ods_t_front_category_0_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_1_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_2_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_3_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_4_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_5_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_6_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_front_category_7_d
      where fdate = '${YYYYMMDD}') tb;


use yunmall_qa;

create table if not exists sam_ods_t_store_delivery_type_d
(
    id               bigint COMMENT '主键id',
    store_id         bigint COMMENT '门店id',
    delivery_type_id bigint COMMENT '配送方式id',
    create_by string COMMENT '创建者',
    update_bye string COMMENT '更新着',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    fdate string COMMENT '分区字段'
) COMMENT '门店配送方式关联表' partition by list (fdate)(partition default);

INSERT OVERWRITE table sam_ods_t_store_delivery_type_d partition (fdate = '${YYYYMMDD}')
select id,
       store_id,
       delivery_type_id,
       create_by,
       update_bye,
       create_time,
       update_time,
       '${YYYYMMDD}'
from (select *
      from sam_ods_t_store_delivery_type_0_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_1_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_2_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_3_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_4_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_5_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_6_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_7_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_8_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_9_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_10_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_11_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_12_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_13_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_14_d
      where fdate = '${YYYYMMDD}'
      union
      select *
      from sam_ods_t_store_delivery_type_15_d
      where fdate = '${YYYYMMDD}') tb;

create database rights_db_0;
create database rights_db_1;
create database rights_db_2;
create database rights_db_3;
create database rights_db_4;
create database rights_db_5;
create database rights_db_6;
create database rights_db_7;
create database rights_db_8;
create database rights_db_9;
create database rights_db_10;
create database rights_db_11;
create database rights_db_12;
create database rights_db_13;
create database rights_db_14;
create database rights_db_15;

use goods_db_0;

use goods_db_1;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_2;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_3;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_4;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_5;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_6;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';
use goods_db_7;
CREATE TABLE t_brand
(
    brand_id   bigint(20)          NOT NULL COMMENT '后台分配的品牌ID',
    saas_id    bigint(20)          NOT NULL COMMENT '商家id',
    ext string (4096) NOT NULL DEFAULT '' COMMENT '品牌扩展信息',
    title string (255) DEFAULT NULL COMMENT '品牌名称',
    is_deleted tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (brand_id) USING BTREE,
    KEY idx_saas_id (saas_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '品牌表';


use goods_db_0;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_1;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_2;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_3;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_4;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_5;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_6;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';
use goods_db_7;
CREATE TABLE t_spu_front_category
(
    id                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键,自增id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    spu_id            bigint(20)          NOT NULL COMMENT 'spuid',
    front_category_id bigint(20)          NOT NULL COMMENT '后台类目id',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_categoryid (saas_id, front_category_id) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3721
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu前台类目';

use goods_db_0;
CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_1;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_2;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_3;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_4;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_5;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_6;

CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';
use goods_db_7;
CREATE TABLE t_front_category
(
    front_category_id bigint(20)          NOT NULL COMMENT '商家id',
    saas_id           bigint(20)          NOT NULL COMMENT '商家id',
    store_id          bigint(20)          NOT NULL COMMENT '门店id',
    title string (64) NOT NULL COMMENT '类目名称',
    e_title string (64) NOT NULL DEFAULT '' COMMENT '英文名称',
    image string (512) NOT NULL DEFAULT '' COMMENT '类目图片',
    parent_tree string (255) DEFAULT NULL COMMENT '父类目树',
    parent_id         bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level             int(11)             NOT NULL COMMENT '类目层级',
    is_available      tinyint(4)          NOT NULL DEFAULT '0' COMMENT '启用1:启用/0:未启用',
    ext               json                         DEFAULT NULL COMMENT '扩展字段',
    is_deleted        tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    priority          int(11)             NOT NULL DEFAULT '0' COMMENT '优先级(用于排序)',
    PRIMARY KEY (front_category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '前台类目表';



use goods_db_0;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_1;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_2;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_3;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_4;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_5;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_6;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';
use goods_db_7;
CREATE TABLE t_spu
(
    spu_id           bigint(20)          NOT NULL COMMENT '后台生成的spu id',
    saas_id          bigint(20)          NOT NULL COMMENT '商家id',
    master_biz_type  tinyint(4)          NOT NULL COMMENT '主类型(1:)',
    vice_biz_type    tinyint(4)          NOT NULL COMMENT '副类型',
    external_spu_id  bigint(20)          NOT NULL DEFAULT '0' COMMENT '外部spu id',
    spu_bar_code string (64) NOT NULL DEFAULT '' COMMENT 'spu条码',
    channel          int(4)              NOT NULL DEFAULT '0' COMMENT '渠道',
    category_leaf_id bigint(20)          NOT NULL COMMENT '后台类目叶子',
    category_id_tree string (256) DEFAULT NULL COMMENT '后台类目树',
    title string (64) NOT NULL COMMENT 'spu中文名称',
    e_title string (128) NOT NULL DEFAULT '' COMMENT 'spu英文名称',
    intro string (256) NOT NULL DEFAULT '' COMMENT '简介',
    is_available     tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '可售状态',
    unit string (64) NOT NULL COMMENT '单位',
    brand_id         bigint(20)                   DEFAULT '0' COMMENT '品牌id',
    images           json                NOT NULL COMMENT '图片',
    default_images   json                NOT NULL COMMENT '主图',
    videos           json                         DEFAULT NULL COMMENT '视频',
    attr             json                NOT NULL COMMENT '属性值',
    spec             json                NOT NULL COMMENT '必选规格',
    is_deleted       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (spu_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_category (saas_id, category_leaf_id) USING BTREE,
    KEY idx_brand (saas_id, brand_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'spu表';

use goods_db_0;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_1;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_2;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_3;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_4;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_5;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_6;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表';
use goods_db_7;
CREATE TABLE t_sku
(
    sku_id          bigint(20)          NOT NULL COMMENT '后台分配的sku id',
    saas_id         bigint(20)          NOT NULL COMMENT '商家id',
    spu_id          bigint(20)          NOT NULL COMMENT 'spu id',
    external_sku_id bigint(20)                   DEFAULT '0' COMMENT '外部skuid',
    sku_bar_code string (64) DEFAULT '' COMMENT 'sku条码',
    biz_tag         int(4)                       DEFAULT '0' COMMENT '业务标签',
    sales_mode      int(4)                       DEFAULT '0' COMMENT '销售模式',
    title string (64) DEFAULT '' COMMENT 'spu中文名称',
    e_title string (256) DEFAULT '' COMMENT 'spu英文名称',
    is_available    tinyint(4) unsigned          DEFAULT '0' COMMENT '可售状态1:可售/0:不可售',
    images          json                         DEFAULT NULL COMMENT '图片',
    default_images  json                         DEFAULT NULL COMMENT '主图',
    videos          json                         DEFAULT NULL COMMENT '视频',
    spec            json                         DEFAULT NULL COMMENT 'sku选定的规格',
    is_deleted      tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (sku_id) USING BTREE,
    KEY idx_spuid (saas_id, spu_id) USING BTREE,
    KEY idx_skuid (saas_id, sku_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = 'sku表'


use goods_db_0;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_1;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_2;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_3;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_4;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_5;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_6;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';
use goods_db_7;
CREATE TABLE t_category
(
    category_id bigint(20)          NOT NULL COMMENT '后台分配的类目ID',
    saas_id     bigint(20)          NOT NULL COMMENT '商家id',
    title string (100) NOT NULL COMMENT '类目名称',
    parent_tree string (256) DEFAULT NULL COMMENT '父类目树',
    parent_id   bigint(20)                   DEFAULT NULL COMMENT '父类目id',
    level       int(11)             NOT NULL COMMENT '类目层级',
    status      tinyint(4)          NOT NULL DEFAULT '1' COMMENT '状态0-停用,1-启用',
    is_leaf     tinyint(4)          NOT NULL DEFAULT '1' COMMENT '是否叶子节点，0：否；1：是',
    is_deleted  tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0：未删除；1：已删除',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    image string (128) NOT NULL DEFAULT '' COMMENT '后台类目图片',
    PRIMARY KEY (category_id) USING BTREE,
    KEY idx_parent (saas_id, parent_id) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC COMMENT = '后台类目表';

use user_db_0;

CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_1;

CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';

use user_db_2;

CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_3;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_4;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_5;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_6;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_7;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_8;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_9;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_10;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_11;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_12;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_13;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_14;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_15;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';



use t_merchant_service_0;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_1;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_2;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_3;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_4;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_5;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_6;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_7;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_8;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_9;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_10;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_11;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_12;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_13;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_14;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (200) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10039
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_15;



use t_merchant_service_0;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_1;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_2;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_3;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_4;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_5;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_6;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_7;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_8;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_9;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_10;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_11;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_12;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_13;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_14;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';
use t_merchant_service_15;
CREATE TABLE t_store_delivery_type
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id         bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店id',
    delivery_type_id bigint(20)          NOT NULL DEFAULT '0' COMMENT '配送方式id',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_bye string (40) NOT NULL DEFAULT '' COMMENT '更新着',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店配送方式关联表';


use sams_message;
CREATE TABLE t_message_task_count
(
    id              bigint(20)   NOT NULL COMMENT '主键id',
    message_task_id bigint(20)   NOT NULL DEFAULT '0' COMMENT '消息任务id',
    job_id          bigint(20)   NOT NULL DEFAULT '0' COMMENT '任务批次id',
    fail_count      bigint(20)   NOT NULL DEFAULT '0' COMMENT '失败数',
    success_count   bigint(20)   NOT NULL DEFAULT '0' COMMENT '成功数',
    total_count     bigint(20)   NOT NULL DEFAULT '0' COMMENT '总数',
    count_status    tinyint(255) NOT NULL DEFAULT '0' COMMENT '0-未统计结束 1-已统计',
    send_status     tinyint(4)   NOT NULL DEFAULT '0' COMMENT '0-未发送 1-已发送',
    message_type    tinyint(4)   NOT NULL DEFAULT '0' COMMENT '0-默认 1-短信 2-apppush 3-站内信',
    PRIMARY KEY (id),
    KEY idx_job_id (job_id) USING BTREE COMMENT '任务批次id索引'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '消息任务统计表';

use user_admin_db_0;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_1;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_2;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_3;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_4;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_5;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_6;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_7;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_8;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_9;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_10;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_11;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_12;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_13;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_14;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';
use user_admin_db_15;
CREATE TABLE t_register_auth
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    channel_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '注册账户的渠道类型 0：手机号 1：邮箱 2：微信相关渠道 3：QQ渠道 4：微博渠道 5：身份证 6：其他；',
    channel_name string (32) NOT NULL DEFAULT '' COMMENT '渠道名称 跟channel_type对应',
    open_id string (128) NOT NULL DEFAULT '' COMMENT '与channelType对应，如手机号、邮箱、身份证号、微信openId等',
    app_id string (128) NOT NULL DEFAULT '' COMMENT '对应业务方注册渠道的应用ID',
    wx_union_id string (128) NOT NULL DEFAULT '' COMMENT '微信unionid',
    password string (32) NOT NULL DEFAULT '' COMMENT '渠道认证密码',
    invitation_code string (32) NOT NULL DEFAULT '' COMMENT '邀请码',
    is_forever   tinyint(4) NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效开始时间',
    effective_end_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账户有效结束时间',
    register_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    source_type  tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户来源 0用户注册 1后台导入',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_openid_appid_channeltype_saasid (open_id, app_id, channel_type, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4 COMMENT = '注册鉴权表';


use member_db;
CREATE TABLE t_member_card
(
    id                   bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id              bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    card_id              int(11)    NOT NULL DEFAULT '0' COMMENT '卡id',
    card_no string (64) NOT NULL DEFAULT '' COMMENT '卡号',
    referrer string (64) NOT NULL DEFAULT '' COMMENT '推荐人',
    parent_card_no string (64) NOT NULL DEFAULT '' COMMENT '父卡号',
    is_forever           int(11)    NOT NULL DEFAULT '0' COMMENT '1：永久有效 2：限时有效',
    effective_start_time bigint(20) NOT NULL DEFAULT '0' COMMENT '账户有效开始时间 毫秒时间戳',
    effective_end_time   bigint(20) NOT NULL DEFAULT '0' COMMENT '账户有效结束时间 毫秒时间戳',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    card_status          int(11)    NOT NULL DEFAULT '0' COMMENT '卡状态 1：待激活 2：已激活 3：已过期 4：已失效',
    is_auto_renew        int(11)    NOT NULL DEFAULT '0' COMMENT '是否自动续费 0：否 1：是',
    next_renew_time      bigint(20) NOT NULL DEFAULT '0' COMMENT '下次续费时间 毫秒时间戳',
    pay_way              int(11)    NOT NULL DEFAULT '0' COMMENT '支付方式',
    is_deleted           int(11)    NOT NULL DEFAULT '0' COMMENT '是否删除 0：否 1：是',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id),
    KEY idx_cardno_saasid (card_no, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2537
  DEFAULT CHARSET = utf8mb4 COMMENT = '会员-卡关系表'


use t_merchant_service_0;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_1;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_2;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_3;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_4;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_5;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_6;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_7;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_8;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_9;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_10;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_11;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_12;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_13;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_14;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';
use t_merchant_service_15;
drop table t_store;
CREATE TABLE t_store
(
    id                 bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    store_id           bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店ID',
    store_name string (40) NOT NULL DEFAULT '' COMMENT '门店名称',
    store_num          bigint(255)         NOT NULL DEFAULT '0' COMMENT '门店编号',
    store_name_en string (255) NOT NULL DEFAULT '' COMMENT '店铺英文名称',
    store_type string (20) NOT NULL DEFAULT '' COMMENT '门店类型',
    parent_num         bigint(20)          NOT NULL DEFAULT '0' COMMENT '父门店编号',
    store_logo string (2048) NOT NULL DEFAULT '' COMMENT '门店logo',
    store_address string (255) NOT NULL DEFAULT '' COMMENT '门店地址',
    province_name string (20) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (20) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (20) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (20) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (255) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (255) NOT NULL DEFAULT '' COMMENT '区编码',
    longitude          double              NOT NULL DEFAULT '0' COMMENT '经度',
    latitude           double              NOT NULL DEFAULT '0' COMMENT '维度',
    store_tel string (40) NOT NULL DEFAULT '' COMMENT '门店电话',
    store_business string (2000) NOT NULL DEFAULT '' COMMENT '门店营业时间',
    store_admin string (40) NOT NULL DEFAULT '' COMMENT '门店管理员',
    store_admin_tel string (40) NOT NULL DEFAULT '' COMMENT '门店管理员电话',
    status             tinyint(4)          NOT NULL DEFAULT '0' COMMENT '门店状态',
    is_deleted         tinyint(4)          NOT NULL DEFAULT '0' COMMENT '软删除',
    create_by string (40) NOT NULL DEFAULT '' COMMENT '创建者',
    update_by string (40) NOT NULL DEFAULT '' COMMENT '更新者',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    saas_id            bigint(20)          NOT NULL DEFAULT '0' COMMENT '商铺id',
    invoice_config string (512) NOT NULL DEFAULT '' COMMENT '发票配置',
    business_time_type int(4)              NOT NULL DEFAULT '0' COMMENT '营业时间类型：0：自定义；1：全天； 2继承店铺',
    goods_config string (512) NOT NULL DEFAULT '' COMMENT '商品配置',
    store_priority     bigint(20)          NOT NULL DEFAULT '0' COMMENT '门店优先级',
    store_address_en string (255) NOT NULL DEFAULT '' COMMENT '英文门店地址',
    province_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文省名称',
    city_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文市名称',
    district_name_en string (255) NOT NULL DEFAULT '' COMMENT '英文区名称',
    PRIMARY KEY (id),
    KEY idx_store_name (store_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 484480
  DEFAULT CHARSET = utf8mb4 COMMENT = '门店表';



CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表'

select id,
       saas_id,
       uid,
       is_member,
       user_name,
       first_name_chinese,
       last_name_chinese,
       first_name_english,
       last_name_english,
       nickname,
       phone,
       sex,
       birthday,
       id_card_type,
       id_card_no,
       head_url,
       country_name,
       country_code,
       province_name,
       province_code,
       city_name,
       city_code,
       district_name,
       district_code,
       detail_address,
       slot1,
       slot2,
       slot3,
       slot4,
       slot5,
       slot6,
       slot7,
       slot8,
       slot9,
       slot10,
       extend,
       create_time,
       update_time
from t_user_info;

use yunmall_online;
create table if not exists t_user_info
(
    id           bigint COMMENT '自增id',
    saas_id      bigint COMMENT '商户id',
    uid string COMMENT '用户id',
    is_member    tinyint COMMENT '是否会员 0否 1是',
    user_name string COMMENT '用户名',
    first_name_chinese string COMMENT '名-中文',
    last_name_chinese string COMMENT '姓-中文',
    first_name_english string COMMENT '名-英文',
    last_name_english string COMMENT '姓-英文',
    nickname string COMMENT '昵称',
    phone string COMMENT '手机号',
    sex          tinyint COMMENT '0未知 1男 2女',
    birthday string COMMENT '生日 如1970-01-01',
    id_card_type tinyint COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string COMMENT '证件号',
    head_url string COMMENT '头像url',
    country_name string COMMENT '国家名称',
    country_code string COMMENT '国家编码',
    province_name string COMMENT '省名称',
    province_code string COMMENT '省编码',
    city_name string COMMENT '市名称',
    city_code string COMMENT '市编码',
    district_name string COMMENT '区名称',
    district_code string COMMENT '区编码',
    detail_address string COMMENT '详细地址',
    slot1 string COMMENT '插槽1',
    slot2 string COMMENT '插槽2',
    slot3 string COMMENT '插槽3',
    slot4 string COMMENT '插槽4',
    slot5 string COMMENT '插槽5',
    slot6 string COMMENT '插槽6',
    slot7 string COMMENT '插槽7',
    slot8 string COMMENT '插槽8',
    slot9 string COMMENT '插槽9',
    slot10 string COMMENT '插槽10',
    extend string COMMENT '扩展信息 json对象',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    fdate string comment '分区字段'
) COMMENT '用户信息表' partition by list (fdate)(partition default);


select id,
       saas_id,
       uid,
       is_member,
       user_name,
       first_name_chinese,
       last_name_chinese,
       first_name_english,
       last_name_english,
       nickname,
       phone,
       sex,
       birthday,
       id_card_type,
       id_card_no,
       head_url,
       country_name,
       country_code,
       province_name,
       province_code,
       city_name,
       city_code,
       district_name,
       district_code,
       detail_address,
       slot1,
       slot2,
       slot3,
       slot4,
       slot5,
       slot6,
       slot7,
       slot8,
       slot9,
       slot10,
       extend,
       create_time,
       update_time,
       fdate,


create database user_db;
CREATE TABLE t_user_info
(
    id           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id      bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    is_member    tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name string (32) NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese string (32) NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english string (32) NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english string (32) NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname string (32) NOT NULL DEFAULT '' COMMENT '昵称',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    sex          tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday     date                DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type tinyint(4) NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no string (20) NOT NULL DEFAULT '' COMMENT '证件号',
    head_url string (2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1 string (64) NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2 string (64) NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3 string (64) NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4 string (64) NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5 string (64) NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6 string (64) NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7 string (64) NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8 string (64) NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9 string (64) NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10 string (64) NOT NULL DEFAULT '' COMMENT '插槽10',
    extend string (4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';


CREATE TABLE t_message_task_count
(
    id              bigint COMMENT '主键id',
    message_task_id bigint COMMENT '消息任务id',
    job_id          bigint COMMENT '任务批次id',
    fail_count      bigint COMMENT '失败数',
    success_count   bigint COMMENT '成功数',
    total_count     bigint COMMENT '总数',
    count_status    tinyint COMMENT '0-未统计结束 1-已统计',
    send_status     tinyint COMMENT '0-未发送 1-已发送',
    message_type    tinyint COMMENT '0-默认 1-短信 2-apppush 3-站内信',
) COMMENT '消息任务统计表'

CREATE TABLE t_message_task
(
    id                 bigint COMMENT '主键ID',
    task_name string COMMENT '任务名称',
    message_type       tinyint COMMENT '0-默认 1-短信 2-apppush 3-站内信',
    language string COMMENT '0-中文 1-英文 多语言用英文逗号隔开',
    chinese_title string COMMENT '中文签名',
    chinese_message_content string COMMENT '中文短信内容',
    english_title string COMMENT '英文签名',
    english_message_content string COMMENT '英文短信内容',
    android_pic string COMMENT 'android图片',
    ios_pic string COMMENT 'ios图片',
    ios_system_url string COMMENT 'ios系统跳转链接',
    android_system_url string COMMENT 'android系统跳转链接',
    ios_customize_url string COMMENT 'ios自定义链接',
    android_customize_url string COMMENT 'android自定义链接',
    push_channel string COMMENT '推送渠道 0-默认 1-Android 2-IOS 多个渠道用英文隔开',
    user_tag string COMMENT '用户标签，多个用逗号隔开',
    push_time string COMMENT '推送时间',
    push_status        int COMMENT '0-未推送 1-推送中 2-推送成功 3-审核中 4-审核未通过 ',
    push_success_count bigint COMMENT '推送成功数',
    push_fail_count    bigint COMMENT '推送失败数',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    is_delete          tinyint COMMENT '0-正常 1-删除',
    fetch_id string COMMENT '获取标签批次ID',
    msg_template_id string COMMENT '短信模板ID',

) COMMENT '消息任务表';


use qshare_db_anchor_0;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_1;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_2;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_3;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_4;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_5;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_6;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_7;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_8;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_9;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_10;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_11;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_12;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_13;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_14;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';
use qshare_db_anchor_15;
CREATE TABLE t_qshare_bind_detail
(
    id         int(11)    NOT NULL AUTO_INCREMENT COMMENT '主键',
    qid        bigint(20) NOT NULL COMMENT 'Q享号主id',
    anchor_id  bigint(20) NOT NULL COMMENT '主播id',
    anchor_nickname string (50) DEFAULT '' COMMENT '申请主播昵称',
    anchor_head_url string (1024) DEFAULT '' COMMENT '申请主播头像',
    anchor_sign string (256) DEFAULT '' COMMENT '主播签名',
    status     int(11)             DEFAULT '0' COMMENT '绑定状态：0-申请中，1-关联中，2-已解除关联，3-删除',
    create_time string NOT NULL COMMENT '首次请求时间',
    update_time string NOT NULL COMMENT '更新时间',
    is_default tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认绑定',
    PRIMARY KEY (id),
    KEY idx_qid (qid)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享号绑定主播关系表';

use qshare_db_anchor_0;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_1;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_2;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_3;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_4;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_5;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_6;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_7;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_8;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_9;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_10;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_11;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_12;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_13;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';
use qshare_db_anchor_14;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';


use qshare_db_anchor_15;
CREATE TABLE t_qstore_anchor
(
    id        int(11)    NOT NULL AUTO_INCREMENT COMMENT 'pk',
    saas_id   bigint(20) NOT NULL DEFAULT '0' COMMENT 'saasid',
    store_id  bigint(20) NOT NULL DEFAULT '0' COMMENT '门店id，中台storeId',
    anchor_id bigint(20) NOT NULL DEFAULT '0' COMMENT '主播id',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次请求时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_anchor_store (anchor_id, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '主播关联门店';

select id,
       saas_id,
       store_id,
       anchor_id,
       create_time,
       update_time
from t_qstore_anchor;



use yunmall_qa;
create table if not exists qshare_ods_qstore_anchoru_0_d
(
    id        int COMMENT 'pk',
    saas_id   bigint COMMENT 'saasid',
    store_id  bigint COMMENT '门店id，中台storeId',
    anchor_id bigint COMMENT '主播id',
    create_time string COMMENT '首次请求时间',
    update_time string COMMENT '更新时间',
    fdate string comment '日期'
) comment '主播关联门店' partition by list (fdate)(partition default);

insert overwrite table qshare_ods_qstore_anchoru_d partition (fdate='${YYYYMMDD}')
SELECT id,
       saas_id,
       store_id,
       anchor_id,
       create_time,
       update_time,
       '${YYYYMMDD}'

from (
         select *
         from qshare_ods_qstore_anchoru_0_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_1_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_2_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_3_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_4_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_5_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_6_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_7_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_8_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_9_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_10_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_11_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_12_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_13_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_14_d
         where fdate = '${YYYYMMDD}'
         union
         select *
         from qshare_ods_qstore_anchoru_15_d
         where fdate = '${YYYYMMDD}'
     ) tb;


use yunmall_online;

create table if not exists sam_ods_customer_info_h
(
    id          bigint COMMENT '主键ID',
    uid string COMMENT '用户ID',
    is_wechat   tinyint COMMENT '是否关注微信公众号，0-未关注 1-关注',
    register_channel string COMMENT '注册渠道: unknown, app, ios, android, mini_program, h5, pc等',
    is_down_app tinyint COMMENT 'App是否下载 0 未下载 1-已下载',
    language string COMMENT '语言设置：中文：CN，英文：EN',
    opera_os string COMMENT '操作系统名称',
    mem_register_time string COMMENT '会员注册时间',
    cus_register_time string COMMENT '客户注册时间',
    open_id string COMMENT 'openId',
    union_id string COMMENT 'unionId',
    cus_name string COMMENT '客户姓名',
    buy_card_channel string COMMENT '购卡渠道:unknown, app, ios, android, mini_program, h5, pc等',
    card_no string COMMENT '会员卡号',
    bind_time string COMMENT '绑卡时间',
    mem_img_time string COMMENT '上传会籍头像时间',
    refer_card_no string COMMENT '推荐人卡号',
    mobile string COMMENT '手机号',
    mem_type    tinyint COMMENT '1:个人会籍主卡 2:个人会籍商业主卡 3:个人会籍亲友免费卡 4:个人会籍员工卡 5:卓越会籍主卡 6:卓越',
    last_login_time string COMMENT '用户最后登录时间',
    last_order_time string COMMENT '小程序最后下单时间',
    last_order_store string COMMENT '小程序小程序最后下单门店',
    last_order_store_code string COMMENT '小程序最后下单门店编码',
    first_order_time string COMMENT '小程序首次下单时间',
    first_order_store string COMMENT '小程序首次下单门店',
    first_order_store_code string COMMENT '小程序首次下单门店编码',
    first_app_order_store string COMMENT 'app首次下单门店',
    first_app_order_store_code string COMMENT 'app首次下单门店编码',
    first_app_order_time string COMMENT 'app首次下单时间',
    last_app_order_time string COMMENT 'app最后下单时间',
    last_app_order_store string COMMENT 'app最后下单门店',
    last_app_order_store_code string COMMENT 'app最后下单门店编码',
    create_time string COMMENT '创建时间',
    update_time string COMMENT '更新时间',
    fdate string comment '分区日期'
) comment 'sku表'
    partition by list (fdate)(partition default);

CREATE TABLE sam_ods_customer_info_h
(
    id          bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户ID',
    is_wechat   tinyint(4)          NOT NULL DEFAULT '0' COMMENT '是否关注微信公众号，0-未关注 1-关注',
    register_channel string (20) NOT NULL DEFAULT '' COMMENT '注册渠道: unknown, app, ios, android, mini_program, h5, pc等',
    is_down_app tinyint(4)          NOT NULL DEFAULT '0' COMMENT 'App是否下载 0 未下载 1-已下载',
    language string (10) NOT NULL DEFAULT '' COMMENT '语言设置：中文：CN，英文：EN',
    opera_os string (20) NOT NULL DEFAULT '' COMMENT '操作系统名称',
    mem_register_time string DEFAULT NULL COMMENT '会员注册时间',
    cus_register_time string DEFAULT NULL COMMENT '客户注册时间',
    open_id string (64) NOT NULL DEFAULT '' COMMENT 'openId',
    union_id string (64) NOT NULL DEFAULT '' COMMENT 'unionId',
    cus_name string (60) NOT NULL DEFAULT '' COMMENT '客户姓名',
    buy_card_channel string (20) NOT NULL DEFAULT '' COMMENT '购卡渠道:unknown, app, ios, android, mini_program, h5, pc等',
    card_no string (64) NOT NULL DEFAULT '' COMMENT '会员卡号',
    bind_time string DEFAULT NULL COMMENT '绑卡时间',
    mem_img_time string DEFAULT NULL COMMENT '上传会籍头像时间',
    refer_card_no string (64) NOT NULL DEFAULT '' COMMENT '推荐人卡号',
    mobile string (20) NOT NULL DEFAULT '' COMMENT '手机号',
    mem_type    tinyint(4)          NOT NULL DEFAULT '0' COMMENT '1:个人会籍主卡 2:个人会籍商业主卡 3:个人会籍亲友免费卡 4:个人会籍员工卡 5:卓越会籍主卡 6:卓越会籍商业主卡 7:卓越会籍亲友免费卡',
    last_login_time string DEFAULT NULL COMMENT '用户最后登录时间',
    last_order_time string DEFAULT NULL COMMENT '小程序最后下单时间',
    last_order_store string (64) NOT NULL DEFAULT '' COMMENT '小程序小程序最后下单门店',
    last_order_store_code string (64) NOT NULL DEFAULT '' COMMENT '小程序最后下单门店编码',
    first_order_time string DEFAULT NULL COMMENT '小程序首次下单时间',
    first_order_store string (64) NOT NULL DEFAULT '' COMMENT '小程序首次下单门店',
    first_order_store_code string (64) NOT NULL DEFAULT '' COMMENT '小程序首次下单门店编码',
    first_app_order_store string (64) NOT NULL DEFAULT '' COMMENT 'app首次下单门店',
    first_app_order_store_code string (64) NOT NULL DEFAULT '' COMMENT 'app首次下单门店编码',
    first_app_order_time string DEFAULT NULL COMMENT 'app首次下单时间',
    last_app_order_time string DEFAULT NULL COMMENT 'app最后下单时间',
    last_app_order_store string (64) NOT NULL DEFAULT '' COMMENT 'app最后下单门店',
    last_app_order_store_code string (64) NOT NULL DEFAULT '' COMMENT 'app最后下单门店编码',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_uid (uid) COMMENT '用户ID唯一索引'
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户定开信息表';



use user_db_0;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_1;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_2;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_3;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_4;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_5;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_6;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_7;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_8;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_9;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_10;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_11;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_12;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_13;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_14;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';
use user_db_15;
CREATE TABLE t_receiver_address
(
    id         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id    bigint(20) NOT NULL DEFAULT '0' COMMENT '商户id',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户id',
    phone string (32) NOT NULL DEFAULT '' COMMENT '手机号',
    name string (32) NOT NULL DEFAULT '' COMMENT '收货人姓名',
    country_name string (32) NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code string (32) NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name string (32) NOT NULL DEFAULT '' COMMENT '省名称',
    province_code string (32) NOT NULL DEFAULT '' COMMENT '省编码',
    city_name string (32) NOT NULL DEFAULT '' COMMENT '市名称',
    city_code string (32) NOT NULL DEFAULT '' COMMENT '市编码',
    district_name string (32) NOT NULL DEFAULT '' COMMENT '区名称',
    district_code string (32) NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address string (128) NOT NULL DEFAULT '' COMMENT '详细地址',
    postcode string (6) NOT NULL DEFAULT '' COMMENT '邮编',
    is_default tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认地址 1：是 2：否',
    address_tag string (32) NOT NULL DEFAULT '' COMMENT '地址标签 家 公司 学校',
    latitude string (32) NOT NULL DEFAULT '' COMMENT '纬度',
    longitude string (32) NOT NULL DEFAULT '' COMMENT '经度',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb4 COMMENT = '收货地址表';


CREATE TABLE t_customer_info
(
    id          bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    uid string (64) NOT NULL DEFAULT '' COMMENT '用户ID',
    is_wechat   tinyint(4)          NOT NULL DEFAULT '0' COMMENT '是否关注微信公众号，0-未关注 1-关注',
    register_channel string (20) NOT NULL DEFAULT '' COMMENT '注册渠道: unknown, app, ios, android, mini_program, h5, pc等',
    is_down_app tinyint(4)          NOT NULL DEFAULT '0' COMMENT 'App是否下载 0 未下载 1-已下载',
    language string (10) NOT NULL DEFAULT '' COMMENT '语言设置：中文：CN，英文：EN',
    opera_os string (20) NOT NULL DEFAULT '' COMMENT '操作系统名称',
    mem_register_time string DEFAULT NULL COMMENT '会员注册时间',
    cus_register_time string DEFAULT NULL COMMENT '客户注册时间',
    open_id string (64) NOT NULL DEFAULT '' COMMENT 'openId',
    union_id string (64) NOT NULL DEFAULT '' COMMENT 'unionId',
    cus_name string (60) NOT NULL DEFAULT '' COMMENT '客户姓名',
    buy_card_channel string (20) NOT NULL DEFAULT '' COMMENT '购卡渠道:unknown, app, ios, android, mini_program, h5, pc等',
    card_no string (64) NOT NULL DEFAULT '' COMMENT '会员卡号',
    bind_time string DEFAULT NULL COMMENT '绑卡时间',
    mem_img_time string DEFAULT NULL COMMENT '上传会籍头像时间',
    refer_card_no string (64) NOT NULL DEFAULT '' COMMENT '推荐人卡号',
    mobile string (20) NOT NULL DEFAULT '' COMMENT '手机号',
    mem_type    tinyint(4)          NOT NULL DEFAULT '0' COMMENT '1:个人会籍主卡 2:个人会籍商业主卡 3:个人会籍亲友免费卡 4:个人会籍员工卡 5:卓越会籍主卡 6:卓越会籍商业主卡 7:卓越会籍亲友免费卡',
    last_login_time string DEFAULT NULL COMMENT '用户最后登录时间',
    last_order_time string DEFAULT NULL COMMENT '小程序最后下单时间',
    last_order_store string (64) NOT NULL DEFAULT '' COMMENT '小程序小程序最后下单门店',
    last_order_store_code string (64) NOT NULL DEFAULT '' COMMENT '小程序最后下单门店编码',
    first_order_time string DEFAULT NULL COMMENT '小程序首次下单时间',
    first_order_store string (64) NOT NULL DEFAULT '' COMMENT '小程序首次下单门店',
    first_order_store_code string (64) NOT NULL DEFAULT '' COMMENT '小程序首次下单门店编码',
    first_app_order_store string (64) NOT NULL DEFAULT '' COMMENT 'app首次下单门店',
    first_app_order_store_code string (64) NOT NULL DEFAULT '' COMMENT 'app首次下单门店编码',
    first_app_order_time string DEFAULT NULL COMMENT 'app首次下单时间',
    last_app_order_time string DEFAULT NULL COMMENT 'app最后下单时间',
    last_app_order_store string (64) NOT NULL DEFAULT '' COMMENT 'app最后下单门店',
    last_app_order_store_code string (64) NOT NULL DEFAULT '' COMMENT 'app最后下单门店编码',
    create_time string NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time string NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_uid (uid) COMMENT '用户ID唯一索引'
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户定开信息表';


use user_db_0;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_1;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_2;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_3;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_4;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_5;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_6;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_7;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_8;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_9;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_10;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_11;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_12;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_13;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_14;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';
use user_db_15;
CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 441
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表';


CREATE TABLE t_user_info_0
(
    id                 bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增id',
    saas_id            bigint(20)    NOT NULL DEFAULT '0' COMMENT '商户id',
    uid                varchar(64)   NOT NULL DEFAULT '' COMMENT '用户id',
    is_member          tinyint(4)    NOT NULL DEFAULT '0' COMMENT '是否会员 0否 1是',
    user_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '用户名',
    first_name_chinese varchar(32)   NOT NULL DEFAULT '' COMMENT '名-中文',
    last_name_chinese  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-中文',
    first_name_english varchar(32)   NOT NULL DEFAULT '' COMMENT '名-英文',
    last_name_english  varchar(32)   NOT NULL DEFAULT '' COMMENT '姓-英文',
    nickname           varchar(32)   NOT NULL DEFAULT '' COMMENT '昵称',
    phone              varchar(32)   NOT NULL DEFAULT '' COMMENT '手机号',
    sex                tinyint(4)    NOT NULL DEFAULT '0' COMMENT '0未知 1男 2女',
    birthday           date                   DEFAULT NULL COMMENT '生日 如：1970-01-01',
    id_card_type       tinyint(4)    NOT NULL DEFAULT '0' COMMENT '证件类型 1：身份证 2：港澳通行证',
    id_card_no         varchar(20)   NOT NULL DEFAULT '' COMMENT '证件号',
    head_url           varchar(2048) NOT NULL DEFAULT '' COMMENT '头像url',
    country_name       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家名称',
    country_code       varchar(32)   NOT NULL DEFAULT '' COMMENT '国家编码',
    province_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '省名称',
    province_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '省编码',
    city_name          varchar(32)   NOT NULL DEFAULT '' COMMENT '市名称',
    city_code          varchar(32)   NOT NULL DEFAULT '' COMMENT '市编码',
    district_name      varchar(32)   NOT NULL DEFAULT '' COMMENT '区名称',
    district_code      varchar(32)   NOT NULL DEFAULT '' COMMENT '区编码',
    detail_address     varchar(128)  NOT NULL DEFAULT '' COMMENT '详细地址',
    slot1              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽1',
    slot2              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽2',
    slot3              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽3',
    slot4              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽4',
    slot5              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽5',
    slot6              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽6',
    slot7              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽7',
    slot8              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽8',
    slot9              varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽9',
    slot10             varchar(64)   NOT NULL DEFAULT '' COMMENT '插槽10',
    extend             varchar(4096) NOT NULL DEFAULT '' COMMENT '扩展信息 json对象',
    create_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time        datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_uid_saasid (uid, saas_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 117
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户信息表'


use yunmall_online;

create table if not exists sam_ods_user_info_0_d
(
    id           bigint comment '自增id',
    saas_id      bigint comment '商户id',
    uid string comment '用户id',
    is_member    tinyint comment '是否会员 0否 1是',
    user_name string comment '用户名',
    first_name_chinese string comment '名-中文',
    last_name_chinese string comment '姓-中文',
    first_name_english string comment '名-英文',
    last_name_english string comment '姓-英文',
    nickname string comment '昵称',
    phone string comment '手机号',
    sex          tinyint comment '0未知 1男 2女',
    birthday string comment '生日 如：1970-01-01',
    id_card_type tinyint comment '证件类型 1：身份证 2：港澳通行证',
    id_card_no string comment '证件号',
    head_url string comment '头像url',
    country_name string comment '国家名称',
    country_code string comment '国家编码',
    province_name string comment '省名称',
    province_code string comment '省编码',
    city_name string comment '市名称',
    city_code string comment '市编码',
    district_name string comment '区名称',
    district_code string comment '区编码',
    detail_address string comment '详细地址',
    slot1 string comment '插槽1',
    slot2 string comment '插槽2',
    slot3 string comment '插槽3',
    slot4 string comment '插槽4',
    slot5 string comment '插槽5',
    slot6 string comment '插槽6',
    slot7 string comment '插槽7',
    slot8 string comment '插槽8',
    slot9 string comment '插槽9',
    slot10 string comment '插槽10',
    extend string comment '扩展信息 json对象',
    create_time string comment '创建时间',
    update_time string comment '更新时间',
    fdate string comment '分区日期'
) comment '用户信息表'
    partition by list (fdate)(partition default);

use yunmall_online;

create table if not exists sam_ods_user_info_d
(
    id           bigint comment '自增id',
    saas_id      bigint comment '商户id',
    uid string comment '用户id',
    is_member    tinyint comment '是否会员 0否 1是',
    user_name string comment '用户名',
    first_name_chinese string comment '名-中文',
    last_name_chinese string comment '姓-中文',
    first_name_english string comment '名-英文',
    last_name_english string comment '姓-英文',
    nickname string comment '昵称',
    phone string comment '手机号',
    sex          tinyint comment '0未知 1男 2女',
    birthday string comment '生日 如：1970-01-01',
    id_card_type tinyint comment '证件类型 1：身份证 2：港澳通行证',
    id_card_no string comment '证件号',
    head_url string comment '头像url',
    country_name string comment '国家名称',
    country_code string comment '国家编码',
    province_name string comment '省名称',
    province_code string comment '省编码',
    city_name string comment '市名称',
    city_code string comment '市编码',
    district_name string comment '区名称',
    district_code string comment '区编码',
    detail_address string comment '详细地址',
    slot1 string comment '插槽1',
    slot2 string comment '插槽2',
    slot3 string comment '插槽3',
    slot4 string comment '插槽4',
    slot5 string comment '插槽5',
    slot6 string comment '插槽6',
    slot7 string comment '插槽7',
    slot8 string comment '插槽8',
    slot9 string comment '插槽9',
    slot10 string comment '插槽10',
    extend string comment '扩展信息 json对象',
    create_time string comment '创建时间',
    update_time string comment '更新时间',
    fdate string comment '分区日期'
) comment '用户信息表'
    partition by list (fdate)(partition default);

insert overwrite table sam_ods_user_info_d partition (fdate = '${YYYYMMDD}')
select id,
       saas_id,
       uid,
       is_member,
       user_name,
       first_name_chinese,
       last_name_chinese,
       first_name_english,
       last_name_english,
       nickname,
       phone,
       sex,
       birthday,
       id_card_type,
       id_card_no,
       head_url,
       country_name,
       country_code,
       province_name,
       province_code,
       city_name,
       city_code,
       district_name,
       district_code,
       detail_address,
       slot1,
       slot2,
       slot3,
       slot4,
       slot5,
       slot6,
       slot7,
       slot8,
       slot9,
       slot10,
       extend,
       create_time,
       update_time,
       '${YYYYMMDD}'
from (select *
      from sam_ods_user_info_0_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_1_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_2_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_3_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_4_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_5_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_6_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_7_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_8_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_9_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_10_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_11_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_12_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_13_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_14_d
      where fdate = '${YYYYMMDD}'
      union all
      select *
      from sam_ods_user_info_15_d
      where fdate = '${YYYYMMDD}') tb;



create table if not exists qshare_dal_merchant_stat_dd
(
    fdate string comment '日期',
    video_count        bigint comment '商品回放视频录制数量',
    store_id string comment '门店id',
    plan_id string comment '直播id',
    visit_pv           bigint comment '含商品讲解的回放直播间浏览次数',
    visit_uv           bigint comment '含商品讲解的回放直播间浏览人数',
    visit_detail_pv    bigint comment '含商品讲解的商品详情页浏览次数',
    visit_detail_uv    bigint comment '含商品讲解的商品详情页浏览人数',
    view_pv            bigint comment '回放页内观看讲解的次数',
    click_uv           bigint comment '回放直播间点击回放讲解的人数去重',
    view_uv            bigint comment '商品详情页点击观看讲解人数去重',
    order_cnt          bigint comment '通过商品回放下单笔数',
    order_user_cnt     bigint comment '通过商品回放下单人数',
    order_amt          double comment '通过商品回放下单金额',
    order_pay_cnt      bigint comment '通过商品回放支付订单量',
    order_pay_user_cnt bigint comment '通过商品回放支付订单金额',
    order_pay_amt      double comment '通过商品回放支付人数'
) comment '商家数据统计表' partition by list (fdate)(partition default);


CREATE TABLE dal_merchant_stat_dd
(
    id                 int(11) NOT NULL AUTO_INCREMENT,
    fdate              varchar(20) DEFAULT NULL COMMENT '日期',
    video_count        bigint(20) comment '商品回放视频录制数量',
    store_id           varchar(20) DEFAULT NULL COMMENT '门店id',
    plan_id            varchar(20) comment '直播id',
    visit_pv           bigint(20) comment '含商品讲解的回放直播间浏览次数',
    visit_uv           bigint(20) comment '含商品讲解的回放直播间浏览人数',
    vid_cnt            bigint(20) comment '新增V享号数量',
    visit_detail_pv    bigint(20) comment '含商品讲解的商品详情页浏览次数',
    visit_detail_uv    bigint(20) comment '含商品讲解的商品详情页浏览人数',
    view_pv            bigint(20) comment '回放页内观看讲解的次数',
    click_uv           bigint(20) comment '回放直播间点击回放讲解的人数去重',
    view_uv            bigint(20) comment '商品详情页点击观看讲解人数去重',
    order_cnt          bigint(20) comment '通过商品回放下单笔数',
    order_user_cnt     bigint(20) comment '通过商品回放下单人数',
    order_amt          bigint(20) comment '通过商品回放下单金额',
    order_pay_cnt      bigint(20) comment '通过商品回放支付订单量',
    order_pay_user_cnt bigint(20) comment '通过商品回放支付订单金额',
    order_pay_amt      bigint(20) comment '通过商品回放支付人数',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '商品回放数据统计表'


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
    FixedTime(TUMBLE_START(timestamp,
    INTERVAL '10' MINUTE),
    'yyyyMMdd', false) as Fdate,
    FixedTime(TUMBLE_START(timestamp,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_start,
    FixedTime(TUMBLE_END(timestamp,
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
    timestamp,
    cast(data.storeId as varchar) as store_id,
    data.qid as qid,
    data.orderNo as orderNo,
    data.saasId as saasId,
    data.uid as uid,
    data.paymentStatus as paymentStatus,
    cast((data.paymentAmount) as bigint) as paymentAmount,
    -- data.time as time,
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
    TUMBLE(a.timestamp,
    INTERVAL '10' MINUTE),
    a.store_id,
    a.qid ) t1
    join
    ---支付相关
    (select
    FixedTime(TUMBLE_START(timestamp,
    INTERVAL '10' MINUTE),
    'yyyyMMdd', false) as Fdate,
    FixedTime(TUMBLE_START(timestamp,
    INTERVAL '10' MINUTE),
    'yyyy-MM-dd HH:mm:SS', false) as Ftime_start,
    FixedTime(TUMBLE_END(timestamp,
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
    timestamp,
    cast(data.storeId as varchar) as store_id,
    data.qid as qid,
    data.orderNo as orderNo,
    data.saasId as saasId,
    data.uid as uid,
    data.paymentStatus as paymentStatus,
    cast((data.paymentAmount) as bigint) as paymentAmount,
    -- data.time as time,
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
    TUMBLE(b.timestamp,
    INTERVAL '10' MINUTE),
    b.store_id,
    b.qid ) t2
on t1.Fdate=t2.Fdate
    and t1.Ftime_start=t2.Ftime_start
    and t1.store_id=t2.store_id
    and t1.qid=t2.qid



CREATE TABLE t_qshare_pvuv
(
    Sdate varchar(40) NOT NULL COMMENT '开始时间',
    Edate varchar(40) NOT NULL COMMENT '结束时间',
    pv    bigint(255) NOT NULL DEFAULT '0' COMMENT '人次',
    uv    bigint(255) NOT NULL DEFAULT '0' COMMENT '人数',
    PRIMARY KEY (Sdate, Edate)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 't_qshare_pvuv表';


CREATE TABLE t_qshare_live_uvpv_acc_d
(
    Fdate       varchar(40) NOT NULL COMMENT '开始日期',
    Ftime_start varchar(40) NOT NULL COMMENT '开始时间',
    Ftime_time  varchar(40) NOT NULL COMMENT '当前聚合结果的时间',
    Ftime_end   varchar(40) NOT NULL COMMENT '结束时间',
    store_id    varchar(40) NOT NULL COMMENT '店铺Id',
    pv          bigint(255) NOT NULL DEFAULT '0' COMMENT '人次',
    uv          bigint(255) NOT NULL DEFAULT '0' COMMENT '人数',
    PRIMARY KEY (Fdate, Ftime_start, Ftime_time, Ftime_end, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享直播uvpv统计表';


alter table t_qshare_live_uvpv_acc_d
    add primary key (Ftime_time);


CREATE TABLE t_qshare_online_acc_pvuv
(
    Fdate       varchar(40) NOT NULL COMMENT '开始日期',
    Ftime_start varchar(40) NOT NULL COMMENT '开始时间',
    Ftime_time  varchar(40) NOT NULL COMMENT '当前聚合结果的时间',
    Ftime_end   varchar(40) NOT NULL COMMENT '结束时间',
    store_id    varchar(40) NOT NULL COMMENT '店铺Id',
    pv          bigint(255) NOT NULL DEFAULT '0' COMMENT '人次',
    uv          bigint(255) NOT NULL DEFAULT '0' COMMENT '人数',
    PRIMARY KEY (Fdate, Ftime_start, Ftime_time, Ftime_end, store_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = 'Q享直播uvpv统计表';


select *, store_id as store_name, plan_id as plan_topic
from dal_live_pay_count_dd
where store_id = {store_id}

CREATE TABLE t_command_activity
(
    id               bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    anchor_id        bigint(20)          NOT NULL DEFAULT '0' COMMENT '主播id',
    plan_id          bigint(20)          NOT NULL DEFAULT '0' COMMENT '直播计划id',
    activity_id      varchar(64)         NOT NULL DEFAULT '' COMMENT '活动id',
    activity_type    int(11)             NOT NULL DEFAULT '0' COMMENT '活动类型',
    status           int(11)             NOT NULL DEFAULT '0' COMMENT '活动状态',
    prize            varchar(64)         NOT NULL DEFAULT '' COMMENT '奖品',
    prize_tpl_id     varchar(64)         NOT NULL DEFAULT '' COMMENT '对接营销中台-奖品模板id',
    activity_version varchar(64)         NOT NULL DEFAULT '' COMMENT '活动版本号',
    num              int(11)             NOT NULL DEFAULT '0' COMMENT '中奖人数',
    user             int(11)             NOT NULL DEFAULT '0' COMMENT '参与用户。游客，订阅者等',
    way              int(11)             NOT NULL DEFAULT '0' COMMENT '参与方式。输入口令，分享直播间等',
    ext_text         text COMMENT '扩展信息，存储为TEXT，查询时原样返回',
    ext_column_1     varchar(64)         NOT NULL DEFAULT '' COMMENT '扩展字段1，查询时原样返回',
    ext_column_2     varchar(64)         NOT NULL DEFAULT '' COMMENT '扩展字段2，查询时原样返回',
    lottery_time     timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '活动设置的开奖时间',
    create_time      timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time      timestamp           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uniq_activity_id_version (activity_id, activity_version),
    KEY idx_anchor_plan (anchor_id, plan_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 56
  DEFAULT CHARSET = utf8mb4 COMMENT = '口令活动表'

select id,
       anchor_id,
       plan_id,
       activity_id,
       group_id,
       leader_user_id,
       leader_head_url,
       leader_nick_name,
       group_status,
       group_time,
       create_time,
       updated_time
from t_group_info;

create table if not exists qshare_ods_group_info_d
(
    id               bigint COMMENT '自增id',
    anchor_id        bigint COMMENT '主播id',
    plan_id          bigint COMMENT '组团活动关联的直播id',
    activity_id      string COMMENT '组团活动id',
    group_id         string COMMENT '团id',
    leader_user_id   bigint COMMENT '团长uid',
    leader_head_url  string COMMENT '团长头像',
    leader_nick_name string COMMENT '团长昵称',
    group_status     tinyint COMMENT '成团状态，1：未成团，2：已成团',
    group_time       string COMMENT '成团时间',
    create_time      string COMMENT '创建时间',
    updated_time     string COMMENT '更新时间',
    fdate          string comment '日期'
) COMMENT = '组团信息表，按 anchor_id 分库' partition by list (fdate)(partition default);

