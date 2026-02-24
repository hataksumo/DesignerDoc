alter table t_scene_event add column rule_prefix varchar(20) NOT NULL default "rule";
COMMENT ON COLUMN t_scene_event.rule_prefix IS "规则前缀";

drop table if exists rc_rule_def_ver_valid
/*==============================================================*/
/* Table: rc_rule_def_ver_valid                                 */
/*==============================================================*/
create table rc_rule_def_ver_valid
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   rule_id              bigint(20) not null comment '规则Id',
   rule_code            char(32) not null comment '规则code,冗余字段',
   rule_ver_id          bigint(20) not null comment '规则版本Id',
   rule_ver_code        char(32) not null comment '规则版本Code',
   has_valid_time        tinyint(1) not null comment '是否有生效时间',
   valid_time_beg       datetime comment '生效时间开始',
   valid_time_end       datetime comment '生效时间结束',
   execute_time_type     tinyint(4) comment '执行时间类型',
   day_time_beg         char(32) comment '每天开始时间',
   day_time_end         char(32) comment '每天结束时间',
   week1                tinyint(1) comment '周一是否开启',
   week2                tinyint(1) comment '周二是否开启',
   week3                tinyint(1) comment '周三是否开启',
   week4                tinyint(1) comment '周四是否开启',
   week5                tinyint(1) comment '周五是否开启',
   week6                tinyint(1) comment '周六是否开启',
   week7                tinyint(1) comment '周日是否开启',
   month_day_cfg        text comment '月度开启配置',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id)
);

alter table rc_rule_def_ver_valid comment '规则版本生效条件';

/*==============================================================*/
/* Index: idx_rule_ver_id                                       */
/*==============================================================*/
create unique index uidx_ver_id on rc_rule_def_ver_valid
(
   rule_ver_id
);


alter table rc_rule_def_ver add column priority int4 not null default 0;
COMMENT ON COLUMN rc_rule_def_ver.priority IS "优先级";

alter table rc_rule_def_ver add column has_valid tinyint(1) not null default 0;
COMMENT ON COLUMN rc_rule_def_ver.has_valid IS "是否有有效信息配置";

alter table rc_rule_ver_hit RENAME COLUMN update_time TO modify_time;

alter table rc_rule_call_log add column rule_name varchar(64) null;
COMMENT ON COLUMN rc_rule_call_log.rule_name IS "规则名称";

alter table rc_rule_call_log add column system_id int8 not null default 0;
COMMENT ON COLUMN rc_rule_call_log.system_id IS "系统id";

alter table rc_rule_call_log add column org_id int8 not null default 0;
COMMENT ON COLUMN rc_rule_call_log.org_id IS "组织Id";

alter table rc_rule_call_log add column dep_id int8 not null default 0;
COMMENT ON COLUMN rc_rule_call_log.dep_id IS "部门Id";

alter table rc_rule_call_log add column execute_time int8 null;
COMMENT ON COLUMN rc_rule_call_log.execute_time IS "执行时间";