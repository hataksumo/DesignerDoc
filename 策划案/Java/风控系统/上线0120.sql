ALTER TABLE rc_rule_call_log ADD excute_time bigint(20) null;
COMMENT ON COLUMN rc_rule_call_log.excute_time IS "执行时间";

ALTER TABLE rc_rule_call_log ADD handle_msg varchar(256) null;
COMMENT ON COLUMN rc_rule_call_log.handle_msg IS "处理信息";



/*==============================================================*/
/* Table: rc_rule_ver_hit                                       */
/*==============================================================*/
create table rc_rule_ver_hit
(
   id                   int8 not null comment '主键ID，雪花算法',
   rule_id              int8 not null comment '规则Id',
   rule_code            char(32) not null comment '规则Code',
   rule_ver_id          int8 not null comment '规则版本Id',
   rule_ver_code        char(32) not null comment '规则版本号',
   total_times          int8 not null default 0 comment '未告警数',
   no_lv_times          int8 not null default 0 comment '未告警数',
   low_lv_times         int8 not null default 0 comment '低告警数',
   medium_lv_times      int8 not null default 0 comment '中告警数',
   high_lv_times        int8 not null default 0 comment '高告警数',
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

ALTER TABLE rc_rule_call_figure_log ADD rule_ver_code char(32) null;
COMMENT ON COLUMN rc_rule_call_figure_log.rule_ver_code IS "规则版本";

ALTER TABLE rc_rule_call_log ADD rule_ver_code char(32) null;
COMMENT ON COLUMN rc_rule_call_log.rule_ver_code IS "规则版本";




/*********************2026-01-19****************************/



drop table if exists rc_rule_sub_def_option;

/*==============================================================*/
/* Table: rc_rule_sub_def_options                               */
/*GenRcRuleSubDefOption*/
/*==============================================================*/

/*==============================================================*/
create table rc_rule_sub_def_option
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   rule_ver_id          bigint(20) not null comment '规则版本Id',
   rule_code            char(32) not null comment '规则编码，冗余字段',
   rule_ver_sub_id      bigint(20) not null comment '子规则Id',
   rule_ver_code        char(32) not null comment '规则版本号，冗余字段',
   rank_lv              tinyint(4) not null comment '告警等级',
   order_idx            int not null comment '第几个条件',
   figure_id            bigint(20) not null comment '指标id',
   op                   char(12) not null comment '条件',
   judge_val_source     tinyint(4) not null comment '右值类型',
   judge_values         text comment '自定义右值',
   description          varchar(1024) comment '条件描述',
   judge_val_figure_id  bigint(20) comment '右值指标id',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id)
);

alter table rc_rule_sub_def_option comment '子规则条件表';

/*==============================================================*/
/* Index: uidx_verid_idx                                        */
/*==============================================================*/
create unique index uidx_verid_idx on rc_rule_sub_def_option
(
   rule_ver_id,
   rank_lv,
   order_idx
);

/*==============================================================*/
/* Index: uidx_subid_idx                                        */
/*==============================================================*/
create unique index uidx_subid_idx on rc_rule_sub_def_option
(
   rule_ver_sub_id,
   order_idx
);
