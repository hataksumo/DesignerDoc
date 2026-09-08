
# 指标增加枚举Code 
alter table rc_figure add column enum_code varchar(32) NULL comment "枚举code";
alter table jh_figure add column enum_code varchar(32) NULL comment "枚举code";

# 名单表增加盐和加密算法标识
alter table t_name_list add column salt varchar(64) comment "盐";
alter table t_name_list add column algorithm varchar(32) not null default "none" comment "加密算法" ;

# param加密方式
alter table rc_rule_call_log add column algorithm varchar(32) not null default "none" comment "加密算法" ;
alter table rc_rule_call_log_none_hit add column algorithm varchar(32) not null default "none" comment "加密算法" ;