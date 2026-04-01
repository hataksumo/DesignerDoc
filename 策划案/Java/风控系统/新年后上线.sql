drop table if exists sys_file;

create table sys_file
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   path                 varchar(2048) not null comment '文件路径',
   uuid                 char(36) not null comment '文件的uuid',
   suffix               varchar(10) null comment '文件后缀',
   mine_type            varchar(256) null comment '文件类型',
   fp1                  bigint(20) not null comment '指纹1',
   fp2                  bigint(20) not null comment '指纹2',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index idx_fp(fp1,fp2)
);

create table sys_file_group
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   code                 char(32) not null comment '文件组的Code',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   UNIQUE index uidx_code(code)
)

drop table if exists sys_rel_file_group;

create table sys_rel_file_group
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   file_group_code      char(32) not null comment '文件组的Code',
   file_id              bigint(20) not null comment '文件的Id',
   uuid                 char(36) not null comment '文件的uuid',
   file_group_id        bigint(20) not null comment '文件组的Id',
   name                 varchar(64) null comment '文件名,冗余字段',
   suffix               varchar(10) null comment '文件后缀,冗余字段',
   description          varchar(1024) null comment '文件描述,冗余字段',
   create_user_id       bigint(20) not null comment '创建者用户Id',
   create_user          varchar(64) not null comment '创建者用户昵称',
   create_time          datetime not null comment '创建的时间',
   update_user_id       bigint(20) comment '修改者用户Id',
   update_user          varchar(64) comment '修改者用户昵称',
   update_time          datetime comment '修改时间',
   version              int not null comment '乐观锁',
   primary key (id),
   index uidx_rel(file_group_id,file_id),
   index uidx_rel_code(file_group_code),
   index idx_uuid(uuid)
)


CREATE TABLE rc_rule_call_log_none_hit (
   id bigint NOT NULL COMMENT '主键ID，自增',
   rule_id bigint NOT NULL COMMENT '规则ID',
   rule_code char(32) NOT NULL COMMENT '规则编码',
   rule_name varchar(64) DEFAULT NULL COMMENT '规则名称',
   rule_ver_id bigint NOT NULL COMMENT '规则版本Id',
   param text  NOT NULL COMMENT '参数',
   action text  NOT NULL COMMENT '动作',
   call_time bigint NOT NULL COMMENT '调用时间戳',
   trigger_lv integer NOT NULL COMMENT '告警等级',
   create_user_id bigint NOT NULL COMMENT '创建用户Id',
   create_user varchar(64)  NOT NULL COMMENT '创建者用户昵称',
   create_time datetime NOT NULL COMMENT '创建时间',
   update_user_id bigint DEFAULT NULL COMMENT '修改者用户Id',
   update_user varchar(64)  DEFAULT NULL COMMENT '修改者用户昵称',
   update_time datetime DEFAULT NULL COMMENT '修改时间',
   version integer NOT NULL COMMENT '乐观锁',
   suggestion_measure varchar(256) DEFAULT NULL COMMENT '建议风控措施',
   event_code varchar(60) NOT NULL COMMENT '事件编码',
   err_msg varchar(1024)  DEFAULT NULL COMMENT '错误信息',
   success tinyint DEFAULT NULL COMMENT '是否成功',
   is_handled tinyint NOT NULL DEFAULT 0 COMMENT '是否已处理',
   is_need_handle tinyint NOT NULL DEFAULT 0 COMMENT '是否需要处理',
   handle_user_id bigint DEFAULT NULL COMMENT '处理人',
   execute_time bigint DEFAULT NULL COMMENT '执行时间',
   handle_msg varchar(256) DEFAULT NULL COMMENT '处理信息',
   rule_ver_code char(32)  DEFAULT NULL COMMENT '规则版本',
   system_id bigint NOT NULL DEFAULT 0 COMMENT '系统Id',
   org_id bigint NOT NULL DEFAULT 0 COMMENT '组织Id',
   dep_id bigint NOT NULL DEFAULT 0 COMMENT '部门Id',
   PRIMARY KEY (id),
   KEY idx_rule_idx(rule_id),
   KEY idx_rule_ver_id_idx(rule_ver_id)
)  COMMENT='规则未命中日志';


drop table if exists jh_rule_task;
CREATE TABLE jh_rule_task(
   id bigint NOT NULL COMMENT '主键ID，自增',
   system_id bigint NOT NULL COMMENT '稽核系统Id',
   scene_id bigint NOT NULL COMMENT '稽核场景Id',
   event_id bigint NOT NULL COMMENT '稽核事件Id',
   jh_rule_id bigint NOT NULL COMMENT '稽核任务Id',
   jh_rule_ver_id bigint NOT NULL COMMENT '稽核任务版本Id',
   code char(32) NOT NULL COMMENT '稽核任务code',
   name varchar(64) NULL COMMENT '稽核任务名字',
   description varchar(256) COMMENT '稽核任务描述',
   cur_version_id bigint NOT NULL COMMENT '当前执行Id',
   version_seq int NOT NULL COMMENT '版本序号',
   version_code varchar(10) NOT NULL COMMENT '当前版本号',
   status tinyint(4) NOT NULL COMMENT '任务状态、1草稿、2数据源选择、3执行',
   org_id bigint NOT NULL DEFAULT 0 COMMENT '组织Id',
   dep_id bigint NOT NULL DEFAULT 0 COMMENT '部门Id',
   create_user_id bigint NOT NULL COMMENT '创建用户Id',
   create_user varchar(64) NOT NULL COMMENT '创建者用户昵称',
   create_time datetime NOT NULL COMMENT '创建时间',
   update_user_id bigint DEFAULT NULL COMMENT '修改者用户Id',
   update_user varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
   update_time datetime DEFAULT NULL COMMENT '修改时间',
   version integer NOT NULL COMMENT '乐观锁',
   PRIMARY KEY (id),
   KEY idx_code(code),
   KEY idx_jh_rule_id(jh_rule_id),
   KEY idx_system_id(system_id),
   KEY idx_event_id(event_id)
) COMMENT='稽核任务';




drop table if exists jh_rule_task_version;
CREATE TABLE jh_rule_task_version(
   id bigint NOT NULL COMMENT '主键ID，自增',
   task_id bigint NOT NULL COMMENT '任务Id',
   version_code varchar(10) NOT NULL COMMENT '版本code',

   analysis_status tinyint(4) NOT NULL COMMENT '解析进度、1、文件准备中、2文件解析、3计算中、4解析完成、5结果报告生成、6结果报告生成完成、-1解析失败',
   file_group_id bigint NOT NULL default 0 COMMENT '文件组Id',
   report_file_group_id bigint NOT NULL default 0 COMMENT '报告文件组Id',
   execute_time_beg datetime  NULL COMMENT '执行开始时间',
   execute_time_end datetime  NULL COMMENT '执行结束时间',

   total_data_num int not null default 0 comment '数据总量',
   handled_data_num int not null default 0 comment '已处理数据总量',
   err_data_num int not null default 0 comment '错误据总量',

   low_lv_times  int not null default 0 comment '低告警数',
   medium_lv_times int not null default 0 comment '中告警数',
   high_lv_times int not null default 0 comment '高告警数',

   error_msg varchar(1024) null comment '错误描述',

   create_user_id bigint NOT NULL COMMENT '创建用户Id',
   create_user varchar(64) NOT NULL COMMENT '创建者用户昵称',
   create_time datetime NOT NULL COMMENT '创建时间',
   update_user_id bigint DEFAULT NULL COMMENT '修改者用户Id',
   update_user varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
   update_time datetime DEFAULT NULL COMMENT '修改时间',
   version integer NOT NULL COMMENT '乐观锁',

   PRIMARY KEY (id),
   KEY idx_jh_task_id(task_id)
) COMMENT='稽核任务执行';


drop table if exists jh_rule_task_version_file_status;
CREATE TABLE jh_rule_task_version_file_status(
   id bigint NOT NULL COMMENT '主键ID，自增',

   task_id bigint NOT NULL COMMENT '任务Id',
   task_ver_id bigint NOT NULL COMMENT '任务执行Id',
   file_attach_id bigint NOT NULL COMMENT '文件关联Id',
   report_file_attach_id bigint NOT NULL default 0 COMMENT '报告文件关联Id',

   analysis_status tinyint(4) NOT NULL COMMENT '解析进度、1、文件准备中、2文件解析、3计算中、4解析完成、5结果报告生成、6结果报告生成完成、-1解析失败',

   total_data_num int not null default 0 comment '数据总量',
   handled_data_num int not null default 0 comment '已处理数据总量',
   err_data_num int not null default 0 comment '错误据总量',

   low_lv_times  int not null default 0 comment '低告警数',
   medium_lv_times int not null default 0 comment '中告警数',
   high_lv_times int not null default 0 comment '高告警数',

   error_msg varchar(1024) null comment '错误描述',

   create_user_id bigint NOT NULL COMMENT '创建用户Id',
   create_user varchar(64) NOT NULL COMMENT '创建者用户昵称',
   create_time datetime NOT NULL COMMENT '创建时间',
   update_user_id bigint DEFAULT NULL COMMENT '修改者用户Id',
   update_user varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
   update_time datetime DEFAULT NULL COMMENT '修改时间',
   version integer NOT NULL COMMENT '乐观锁',

   PRIMARY KEY (id),
   KEY idx_task_ver_id(task_ver_id)
) COMMENT='稽核任务版本文件状态';


drop table if exists jh_rule_task_version_file_param_config;
CREATE TABLE jh_rule_task_version_file_param_config(
   id bigint NOT NULL COMMENT '主键ID，自增',

   task_id bigint NOT NULL COMMENT '任务Id',
   task_ver_id bigint NOT NULL COMMENT '任务执行Id',
   file_status_id bigint NOT NULL COMMENT '任务文件状态Id',

   order_idx int NOT NULL DEFAULT 0 COMMENT '排序位，第几列',
   param_key varchar(50) NOT NULL COMMENT '参数键',
   param_name varchar(50) NOT NULL COMMENT '参数名',
   param_type tinyint NOT NULL COMMENT '参数类型',
   default_val varchar(64) NOT NULL COMMENT '默认值',


   create_user_id bigint NOT NULL COMMENT '创建用户Id',
   create_user varchar(64) NOT NULL COMMENT '创建者用户昵称',
   create_time datetime NOT NULL COMMENT '创建时间',
   update_user_id bigint DEFAULT NULL COMMENT '修改者用户Id',
   update_user varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
   update_time datetime DEFAULT NULL COMMENT '修改时间',
   version integer NOT NULL COMMENT '乐观锁',
   PRIMARY KEY (id),
   KEY idx_file_status_id(file_status_id)
) COMMENT='稽核任务版本文件参数配置';



drop table if exists jh_rule_call_log;
CREATE TABLE `jh_rule_call_log` (
  `id` bigint NOT NULL COMMENT '主键ID，自增',
  `task_id` bigint NOT NULL COMMENT '任务Id',
  `task_ver_id` bigint NOT NULL COMMENT '任务执行Id',
  `file_status_id` bigint NOT NULL COMMENT '文件Id',
  `order_idx` int NOT NULL DEFAULT 0 COMMENT '排序位，也就是Excel的第几行数据',
  `rule_id` bigint NOT NULL COMMENT '规则ID',
  `rule_code` char(32) NOT NULL COMMENT '规则编码',
  `rule_name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `rule_ver_id` bigint NOT NULL COMMENT '规则版本ID',
  `rule_ver_code` char(12) NOT NULL COMMENT '规则版本code',
  `call_time` bigint NOT NULL COMMENT '调用时间戳',
  `trigger_lv` int NOT NULL COMMENT '触发等级',
  `system_id` bigint NOT NULL COMMENT '稽核系统Id',
  `err_msg` varchar(1024) DEFAULT NULL COMMENT '错误信息',
  `success` tinyint DEFAULT NULL COMMENT '是否成功',
  `is_handled` tinyint NOT NULL DEFAULT 0 COMMENT '是否已处理',
  `is_need_handle` tinyint NOT NULL DEFAULT 0 COMMENT '是否需要处理',
  `handle_user_id` bigint DEFAULT NULL COMMENT '处理人',
  `execute_time` bigint DEFAULT NULL COMMENT '执行时间',
  `handle_msg` varchar(256) DEFAULT NULL COMMENT '处理信息',
  `org_id` bigint NOT NULL DEFAULT 0 COMMENT '组织Id',
  `dep_id` bigint NOT NULL DEFAULT 0 COMMENT '部门Id',
  `create_user_id` bigint NOT NULL COMMENT '创建用户Id',
  `create_user` varchar(64) NOT NULL COMMENT '创建用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改用户Id',
  `update_user` varchar(64) DEFAULT NULL COMMENT '修改用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` int NOT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`),
  KEY idx_rule_idx_idx (rule_id),
  KEY idx_task_id(task_id)
) COMMENT='稽核日志';


drop table if exists jh_rule_call_log_none_hit;
CREATE TABLE `jh_rule_call_log_none_hit` (
  `id` bigint NOT NULL COMMENT '主键ID，自增',
  `task_id` bigint NOT NULL COMMENT '任务Id',
  `task_ver_id` bigint NOT NULL COMMENT '任务执行Id',
  `file_status_id` bigint NOT NULL COMMENT '文件Id',
  `order_idx` int NOT NULL DEFAULT 0 COMMENT '排序位，也就是Excel的第几行数据',
  `rule_id` bigint NOT NULL COMMENT '规则ID',
  `rule_code` char(32) NOT NULL COMMENT '规则编码',
  `rule_name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `rule_ver_id` bigint NOT NULL COMMENT '规则版本ID',
  `rule_ver_code` char(12) NOT NULL COMMENT '规则版本code',
  `call_time` bigint NOT NULL COMMENT '调用时间戳',
  `trigger_lv` int NOT NULL COMMENT '触发等级',
  `system_id` bigint NOT NULL COMMENT '稽核系统Id',
  `err_msg` varchar(1024) DEFAULT NULL COMMENT '错误信息',
  `success` tinyint DEFAULT NULL COMMENT '是否成功',
  `is_handled` tinyint NOT NULL DEFAULT 0 COMMENT '是否已处理',
  `is_need_handle` tinyint NOT NULL DEFAULT 0 COMMENT '是否需要处理',
  `handle_user_id` bigint DEFAULT NULL COMMENT '处理人',
  `execute_time` bigint DEFAULT NULL COMMENT '执行时间',
  `handle_msg` varchar(256) DEFAULT NULL COMMENT '处理信息',
  `org_id` bigint NOT NULL DEFAULT 0 COMMENT '组织Id',
  `dep_id` bigint NOT NULL DEFAULT 0 COMMENT '部门Id',
  `create_user_id` bigint NOT NULL COMMENT '创建用户Id',
  `create_user` varchar(64) NOT NULL COMMENT '创建用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改用户Id',
  `update_user` varchar(64) DEFAULT NULL COMMENT '修改用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` int NOT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`),
  KEY idx_rule_idx_idx (rule_id),
  KEY idx_task_id(task_id)
) COMMENT='稽核日志-未命中';



drop table if exists jh_rule_call_log_param;
CREATE TABLE `jh_rule_call_log_param` (
  `id` bigint NOT NULL COMMENT '主键ID，自增',
  `task_ver_id` bigint NOT NULL COMMENT '稽核任务版本Id',
  `jh_log_id` bigint NOT NULL COMMENT '稽核规则日志Id',
  `key` varchar(64) NOT NULL COMMENT '参数',
  `name` varchar(256) NOT NULL COMMENT '名称',
  `value` varchar(256) NOT NULL COMMENT '值',
  `create_user_id` bigint NOT NULL COMMENT '创建用户Id',
  `create_user` varchar(64) NOT NULL COMMENT '创建用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改用户Id',
  `update_user` varchar(64) DEFAULT NULL COMMENT '修改用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` int NOT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`),
  KEY idx_task_var_id(task_ver_id),
  KEY idx_jh_log_id(jh_log_id)
) COMMENT='稽核日志-参数';



drop table if exists jh_rule_call_figure_log;
CREATE TABLE `jh_rule_call_figure_log` (
  `id` bigint NOT NULL COMMENT '主键ID，首尾索引',
  `rule_id` bigint NOT NULL COMMENT '规则ID',
  `rule_code` char(32) NOT NULL COMMENT '规则编码',
  `rule_ver_id` bigint NOT NULL COMMENT '规则版本ID',
  `rule_ver_code` char(12) NOT NULL COMMENT '规则版本code',
  `task_id` bigint NOT NULL COMMENT '任务Id',
  `task_ver_id` bigint NOT NULL COMMENT '任务执行Id',
  `rule_call_log_id` bigint NOT NULL COMMENT '规则调用Id',
  `figure_id` bigint NOT NULL COMMENT '指标Id',
  `figure_code` char(32) NOT NULL COMMENT '指标Code',
  `figure_name` varchar(64) DEFAULT NULL COMMENT '指标名称',
  `figure_type` tinyint NOT NULL COMMENT '指标类型',
  `value_type` tinyint NOT NULL COMMENT '值类型',
  `value` varchar(256) DEFAULT NULL COMMENT '指标值',
  `is_success_get` tinyint NOT NULL COMMENT '是否成功获取',
  `is_over_time` tinyint NOT NULL COMMENT '是否过期',
  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` varchar(64) NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` int NOT NULL COMMENT '乐观锁',
  PRIMARY KEY (`id`),
  KEY idx_call_log_id_idx (rule_call_log_id, figure_id),
  KEY `idx_rule_idx` (`rule_id`)
) COMMENT='指标规则调用指标日志';


SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
where tablename = "rc_figure" and schemaname = "risk_engine_platform";

drop index risk_engine_platform.uidx_source_field;

create unique index uidx_rc_figure_field 
on rc_figure(source_id,source_field,param_dim_key,system_id);


alter table rc_interface_def ALTER COLUMN url DROP NOT NULL;

delete from rc_interface_def;
delete from rc figure where figure_type = 2;


alter table rc_interface_def ADD COLUMN third_code char(32) null COMMENT "第三方code，只在第三方转发调用时才有效";

alter table jh_rule_task ADD COLUMN description varchar(256) null COMMENT "稽核任务描述";