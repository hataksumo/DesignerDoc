alter table t_scene_event add column rule_prefix varchar(20) NULL;
COMMENT ON COLUMN t_scene_event.rule_prefix IS "规则前缀";


alter table