ALTER TABLE jh_rule_task ADD COLUMN data_source_type tinyint not null default 1 comment "数据源类型，1是Excel，2是数据表";

ALTER TABLE jh_rule_task ADD COLUMN table_name varchar(100) null comment "数据源表名";
ALTER TABLE jh_rule_task ADD COLUMN time_field varchar(100) null comment "数据表时间字段名";
ALTER TABLE jh_rule_task ADD COLUMN time_begin datetime null comment "查询时间起始";
ALTER TABLE jh_rule_task ADD COLUMN time_end datetime null comment "查询时间起始";
ALTER TABLE jh_rule_task ADD COLUMN group_phase varchar(100) null comment "分组字段";