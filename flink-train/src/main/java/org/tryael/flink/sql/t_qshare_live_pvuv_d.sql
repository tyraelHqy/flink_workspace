insert
into
    t_qshare_live_uvpv_acc_d
select
    FixedTime(INCREMENT_START(action_time, INTERVAL '1' DAY, INTERVAL '10' MINUTE), 'yyyyMMdd') as Fdate,
    FixedTime(INCREMENT_START(action_time, INTERVAL '1' DAY, INTERVAL '10' MINUTE), 'yyyy-MM-dd HH:mm:SS') as Ftime_start,
    FixedTime(INCREMENT_TIME(true), 'yyyy-MM-dd HH:mm:SS') as Ftime_start,
    FixedTime(INCREMENT_END(action_time, INTERVAL '1' DAY, INTERVAL '10' MINUTE), 'yyyy-MM-dd HH:mm:SS') as Ftime_end,
    cast(store_id as varchar),
    cast(count(1) as bigint)as live_pv,
    cast(count(distinct open_id) as bigint)as live_uv
from (
         select action_time,
                GET_JSON_VALUE(json_properties, '$.chan.store_id')   as store_id,
                GET_JSON_VALUE(json_properties, '$.user.wx_open_id') as open_id
         from qshare_dev_source
         where action_type = 'browse_wxapp_page'
     )
group by INCREMENT(action_time,  INTERVAL '1' DAY, INTERVAL '10' MINUTE),
         store_id
