# 风控价值

alter table rc_rule_def_ver add column rc_value_type tinyint null comment "风控价值类型";

alter table rc_rule_sub_def add column rc_value_source tinyint null comment "风控价值来源";
alter table rc_rule_sub_def add column rc_value_ud decimal(10,2) null comment "用户定义风控价值";
alter table rc_rule_sub_def add column rc_value_figure_id int8 null comment "用户定义风控价值指标Id";

alter table jh_rule_def_ver add column rc_value_type tinyint null comment "风控价值类型";

alter table jh_rule_sub_def add column rc_value_source tinyint null comment "风控价值来源";
alter table jh_rule_sub_def add column rc_value_ud decimal(10,2) null comment "用户定义风控价值";
alter table jh_rule_sub_def add column rc_value_figure_id int8 null comment "用户定义风控价值指标Id";



# 计算指标同步

create table rc_event_inform
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   event_id             bigint(20) not null comment '事件Id',
   event_code           char(32) not null comment '事件code',
   cal_figure_def_id    bigint(20) not null comment '营服数据源Id',
   cal_figure_def_code  char(32) not null comment '营服数据源Code',
   enable               tinyint(1) not null comment '启用' default 1,

   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index idx_event_id(event_id,cal_figure_def_id),
   index idx_figure_def_id(cal_figure_def_id,event_id)
)COMMENT='计算指标，事件通知';


alter table rc_interface_def ALTER COLUMN url varchar(1024) null COMMENT "请求的url";




create table rc_cal_figure_event_log
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   event_id             bigint(20) not null comment '事件Id',
   event_code           char(32) not null comment '事件code',
   cal_figure_def_id    bigint(20) not null comment '营服数据源Id',
   cal_figure_def_code  char(32) not null comment '营服数据源Code',
   send_time            datetime not null comment '触发时间',
   param                text null comment '参数快照',

   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index idx_event_id(event_id,cal_figure_def_id),
   index idx_figure_def_id(cal_figure_def_id,event_id)
)COMMENT='计算指标，事件触发日志';



create table rc_cal_figure_receive_log
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   request_id           bigint(20) not null comment '请求Id',
   event_id             bigint(20) not null comment '事件Id',
   event_code           char(32) not null comment '事件code',
   cal_figure_def_id    bigint(20) not null comment '营服数据源Id',
   cal_figure_def_code  char(32) not null comment '营服数据源Code',
   receive_time         datetime not null comment '触发时间',
   response             text null comment '返回结果',

   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index idx_request_id(request_id)
)COMMENT='营服返回数据日志';