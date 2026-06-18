ALTER TABLE jh_rule_task ADD COLUMN data_source_type tinyint not null default 1 comment "数据源类型，1是Excel，2是数据表";

ALTER TABLE jh_rule_task_version ADD COLUMN table_name varchar(100) null comment "数据源表名";
ALTER TABLE jh_rule_task_version ADD COLUMN time_field varchar(100) null comment "数据表时间字段名";
ALTER TABLE jh_rule_task_version ADD COLUMN time_begin datetime null comment "查询时间起始";
ALTER TABLE jh_rule_task_version ADD COLUMN time_end datetime null comment "查询时间起始";
ALTER TABLE jh_rule_task_version ADD COLUMN group_phrase varchar(100) null comment "分组字段";
ALTER TABLE jh_rule_task_version ADD COLUMN select_fields text null comment "查询字段";
ALTER TABLE jh_rule_task_version ALTER COLUMN file_group_id DROP not null;
ALTER TABLE jh_rule_task_version ADD COLUMN export_status tinyint not null default 1 comment "导出状态";


alter table jh_rule_task_version_file_status alter column file_attach_id drop not null;


alter table rc_event_inform MODIFY column event_code char(64) not null comment "事件code";
alter table rc_event_inform MODIFY column cal_figure_def_code char(64) not null comment "计算指标数据源code";