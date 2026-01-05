

ALTER TABLE rc_rule_def_ver ADD online_time datetime NULL;
COMMENT ON COLUMN rc_rule_def_ver.online_time IS '上线时间';
ALTER TABLE rc_rule_def_ver ADD offline_time datetime NULL;
COMMENT ON COLUMN rC_rule_def_ver.offline_time IS '下线时间';
ALTER TABLE rc_rule_def_ver DROP COLUMN version_seq;
ALTER TABLE rc_rule_def_ver ADD ver_description varchar(1024) NULL;
COMMENT ON COLUMN rc_rule_def_ver.ver_description IS '版本描述';

ALTER TABLE rc_rule_def ADD version_seq int4 NOT NULL;
COMMENT ON COLUMN rc_rule_def.version_seq IS '版本序列';

ALTER TABLE rc_figure_data RENAME COLUMN user_id TO key;
ALTER TABLE rc_figure_data ALTER COLUMN key TYPE varchar(256);

ALTER TABLE rc_figure_data ADD dua int8 NOT NULL;
COMMENT ON COLUMN rc_figure_data.dua IS '有效时间';

ALTER TABLE rc_figure_data DROP COLUMN version;
ALTER TABLE rc_figure_data ADD COLUMN val_type tinyint;
COMMENT ON COLUMN rc_figure_data.val_type IS '变量类型';

ALTER TABLE rc_figure_data ADD COLUMN default_val varchar(256) NULL;
COMMENT ON COLUMN rc_figure_data.default_val IS '默认值';

ALTER TABLE rc_rule_call_log ADD COLUMN suggestion_measure varchar(60) NULL;
COMMENT ON COLUMN rc_rule_call_log.suggestion_measure IS '建议风控措施';

ALTER TABLE rc_rule_call_log ALTER COLUMN param TYPE text;
ALTER TABLE rc_rule_call_log ALTER COLUMN action TYPE text;

ALTER TABLE rc_rule_call_log ADD COLUMN event_code varchar(60) NOT NULL;
COMMENT ON COLUMN rc_rule_call_log.event_code IS '事件编码';

ALTER TABLE rc_rule_call_log ADD COLUMN err_msg varchar(1024) NULL;
COMMENT ON COLUMN rc_rule_call_log.err_msg IS '错误信息';

ALTER TABLE rc_rule_call_log ADD COLUMN success tinyint(1) NULL;
COMMENT ON COLUMN rc_rule_call_log.success IS '是否成功';

ALTER TABLE rc_rule_call_log DROP COLUMN rule_ver_code;


/*==============================================================*/
/* Table: rc_rule_call_figure_log
/* 规则调用指标                                                  */
/*==============================================================*/
create table rc_rule_call_figure_log
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   rule_id              bigint(20) not null comment '规则Id',
   rule_code            char(32) not null comment '规则编码',
   rule_ver_id          bigint(20) not null comment '规则版本Id',
   rule_ver_code        char(32) not null comment '规则版本Code',
   rule_call_log_id     bigint(20) not null comment '规则调用Id',
   figure_id            bigint(20) not null comment '指标Id',
   figure_code          char(32) not null comment '指标Code',
   figure_name          varchar(64) comment '指标名称',
   figure_type          tinyint(4) not null comment '指标类型',
   value_type           tinyint(4) not null comment '值类型',
   value                varchar(256) comment '指标值',
   is_success_get       tinyint(1) not null comment '是否成功获取',
   is_over_time         tinyint(1) not null comment '是否过期',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id)
);

alter table rc_rule_call_figure_log comment '规则调用指标日志';

/*==============================================================*/
/* Index: idx_rule                                              */
/*==============================================================*/
create index idx_rule on rc_rule_call_figure_log
(
   rule_id
);

/*==============================================================*/
/* Index: idx_rule_ver                                          */
/*==============================================================*/
create index idx_rule_ver on rc_rule_call_figure_log
(
   rule_ver_id
);

/*==============================================================*/
/* Index: idx_call_log_id                                       */
/*==============================================================*/
create index idx_call_log_id on rc_rule_call_figure_log
(
   rule_call_log_id,
   figure_id
);


ALTER TABLE rc_rule_call_log ADD COLUMN is_handled tinyint(1) not null default 0;
COMMENT ON COLUMN rc_rule_call_log.is_handled IS "是否已处理"

ALTER TABLE rc_rule_call_log ADD COLUMN is_need_handle tinyint(1) NOT NULL DEFAULT 0;
COMMENT ON COLUMN rc_rule_call_log.is_need_handle IS "是否需要处理";

ALTER TABLE rc_rule_def_ver ADD select_time datetime NULL;
COMMENT ON COLUMN rc_rule_def_ver.select_time IS "版本被选择时间";

ALTER TABLE rc_rule_call_log ADD handle_user_id bigint(20) null;
COMMENT ON COLUMN rc_rule_call_log.handle_user_id IS "处理人"

/*****************************20260105****************************/

ALTER TABLE rc_rule_call_log ADD excute_time bigint(20) null;
COMMENT ON COLUMN rc_rule_call_log.excute_time IS "执行时间";

ALTER TABLE rc_rule_call_log ADD handle_msg varchar(256) null;
COMMENT ON COLUMN rc_rule_call_log.handle_msg IS "处理信息";


drop index idx_rule_ver_id on rc_rule_ver_hit;

drop index idx_rule_id on rc_rule_ver_hit;

drop table if exists rc_rule_ver_hit;

/*==============================================================*/
/* Table: rc_rule_ver_hit                                       */
/*==============================================================*/
create table rc_rule_ver_hit
(
   id                   int8 not null comment '主键ID，雪花算法',
   rule_id              int8 not null comment '规则Id',
   rule_code            char(32) not null comment '规则Code',
   rule_ver_id          int8 not null comment '规则版本Id',
   no_lv                int8 not null default 0 comment '未告警数',
   low_lv               int8 not null default 0 comment '低告警数',
   medium_lv            int8 not null default 0 comment '中告警数',
   high_lv              int8 not null default 0 comment '高告警数',
   create_time          datetime not null comment '创建的时间',
   update_time          datetime comment '修改时间',
   primary key (id)
);

alter table rc_rule_ver_hit comment '规则命中';

/*==============================================================*/
/* Index: idx_rule_id                                           */
/*==============================================================*/
create index idx_rule_id on rc_rule_ver_hit
(
   rule_id
);

/*==============================================================*/
/* Index: idx_rule_ver_id                                       */
/*==============================================================*/
create index idx_rule_ver_id on rc_rule_ver_hit
(
   rule_ver_id
);

