
-- 未命中数据也增加request_id
alter table rc_rule_call_log_none_hit add column request_id varchar(128) not null default "0" comment "请求id";
create index idx_rc_rule_call_log_none_hit_request_id on rc_rule_call_log(request_id);

alter table rc_interface_def add column cache_type tinyint not null default 1 comment "接口缓存类型，1先查询再缓存，2直接查缓存，没数据直接反默认值";
alter table rc_interface_def add column refresh_dua int4 not null default 3600 comment "缓存刷新时间";


CREATE INDEX idx_rc_figure_data_modify_time ON rc_figure_data(modify_time);
CREATE INDEX idx_none_hit_create_time ON rc_rule_call_log_none_hit(create_time);

-- 数据整理

-- 每周1次
DELETE FROM rc_figure_data  WHERE modify_time < DATE_SUB(NOW(), INTERVAL 1 MONTH);

DELETE FROM rc_rule_call_figure_log
WHERE rule_call_log_id IN (
    SELECT id
    FROM rc_rule_call_log_none_hit
    WHERE create_time < DATE_SUB(NOW(), INTERVAL 1 MONTH)
);

DELETE FROM rc_rule_call_log_none_hit
WHERE create_time < DATE_SUB(NOW(), INTERVAL 1 MONTH);