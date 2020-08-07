insert into t_qshare_live_d
select
    FixedTime(ENHANCED_START(action_time,INTERVAL '10' MINUTE),'yyyyMMdd') as Fdate,
    FixedTime(ENHANCED_START(action_time,INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS') as Ftime_start,
    FixedTime(ENHANCED_END(action_time,INTERVAL '10' MINUTE),'yyyy-MM-dd HH:mm:SS') as Ftime_end,
    cast(anchorId as varchar),
    cast(plan_id as varchar),
    cast(count(1) as bigint) as live_pv,
    cast(count(distinct open_id) as bigint) as live_uv,
    cast(live_title as varchar)  as live_title,
    cast(qid as varchar) as qid,
    TO_BASE64(qidName)  as qidName
from
    (
        select
            ka_id,
            action_time,
            GET_JSON_VALUE(json_properties, '$.chan.anchorId') as anchorId,
            GET_JSON_VALUE(json_properties, '$.chan.planId') as plan_id,
            --GET_JSON_VALUE(json_properties, '$.user.wx_open_id') as open_id,
            wx_open_id  as open_id,
            GET_JSON_VALUE(json_properties, '$.chan.view_type') as view_type,
            GET_JSON_VALUE(json_properties, '$.chan.live_title') as live_title,
            GET_JSON_VALUE(json_properties, '$.page') as page,
            GET_JSON_VALUE(json_properties, '$.chan.qid') as qid,
            GET_JSON_VALUE(json_properties, '$.chan.qx_name') as qidName
        from qshare_online_source
        where action_type='browse_wxapp_page'
          and ka_id=10001032
    )
where page like '%supermarket/pages/media/live/live%'
    --and a.anchorId is not null and a.qid is not null and a.plan_id is not null and char_length(a.anchorId)>0 and char_length(a.qid)>0  and char_length(a.plan_id)>0 and a.anchorId <> 'null' and a.plan_id <> 'null' and   a.qid <> 'null'
    --and view_type='live'
group by ENHANCED(action_time, INTERVAL '10' MINUTE),
         anchorId,
         plan_id,
         qid,
         live_title,
         TO_BASE64(qidName)
