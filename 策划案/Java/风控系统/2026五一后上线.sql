alter table t_scene_event add column rule_order_strategy tinyint not null default 1 comment "规则排序策略";

alter table rc_interface_def add column dua int not null default 300 comment "缓存持续时间";

alter table rc_cal_figure_receive_log drop column event_id;
alter table rc_cal_figure_receive_log drop column event_code;
alter table rc_cal_figure_receive_log drop column cal_figure_def_id;
alter table rc_cal_figure_receive_log drop column cal_figure_def_code;

create table rc_event_inform_it
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   event_id             bigint(20) not null comment '事件Id',
   event_code           char(32) not null comment '事件code',
   interface_def_id    bigint(20) not null comment '接口数据源Id',
   interface_def_code  char(32) not null comment '接口数据源Code',
   enable               tinyint(1) not null comment '启用' default 1,

   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index idx_event_id(event_id,interface_def_id),
   index idx_interface_def_id(interface_def_id,event_id)
)COMMENT='接口指标，事件通知';


create table sys_enum_switch
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   enum_code            varchar(40) not null comment '枚举code',
   item_key             varchar(40) not null comment '枚举项键',
   item_code            varchar(20) not null comment '枚举项编码',
   sort_idx             int  not null comment '排序号',
   name                 varchar(64)  null comment '名称',
   description          varchar(128)  null comment '描述',
   ext_param             text        null comment '额外参数',
   enabled              tinyint(1)  not null default 1 comment '是否启用',


   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   unique index idx_code_key(enum_code,item_key)
)COMMENT='枚举开关';