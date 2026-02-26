drop table if exists sys_file;

create table sys_file
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   path                 varchar(2048) not null comment '文件路径',
   uuid                 char(36) not null comment '文件的uuid',
   suffix               varchar(10) null comment '文件后缀',
   mine_type            varchar(32) null comment '文件类型',
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
   jh_rule_id bigint NOT NULL COMMENT '稽核任务Id',
   name varchar(64) NULL COMMENT '稽核任务名字',
   cur_execute_id bigint NOT NULL COMMENT '当前执行Id',
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
   PRIMARY KEY (id)，
   KEY idx_jh_rule_id(jh_rule_id),
   KEY idx_system_id(system_id),
   KEY idx_scene_id(scene_id)
) COMMENT='稽核任务';


drop table if exists jh_rule_task_version;
CREATE TABLE jh_rule_task_version(
   id bigint NOT NULL COMMENT '主键ID，自增',
   task_id bigint NOT NULL COMMENT '任务Id',


   analysis_status tinyint(4) NOT NULL COMMENT '解析进度、1文件解析、2计算中、3解析完成、4解析失败',
   file_group_id bigint NOT NULL COMMENT '文件组Id',
   execute_time_beg datetime NOT NULL COMMENT '执行开始时间',
   execute_time_end datetime NOT NULL COMMENT '执行结束时间',

   data_num int8 not null default 0 comment '数据总量',
   handled_data_num int8 not null default 0 comment '已处理数据总量',

   low_lv_times  int8 not null default 0 comment '低告警数',
   medium_lv_times int8 not null default 0 comment '中告警数',
   high_lv_times int8 not null default 0 comment '高告警数',


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






drop table if exists jh_rule_call_log;
CREATE TABLE `jh_rule_call_log` (
  `id` bigint NOT NULL COMMENT '主键ID，自增',
  `task_id` bigint NOT NULL COMMENT '任务Id',
  `rule_id` bigint NOT NULL COMMENT '规则ID',
  `rule_code` char(32) NOT NULL COMMENT '规则编码',
  `rule_name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `rule_ver_id` bigint NOT NULL COMMENT '规则版本ID',
  `rule_ver_code` bigint NOT NULL COMMENT '规则版本code',
  `param` text NOT NULL COMMENT '参数',
  `call_time` bigint NOT NULL COMMENT '调用时间戳',
  `trigger_lv` int NOT NULL COMMENT '触发等级',
  `suggestion_measure` varchar(256) DEFAULT NULL COMMENT '建议风控措施',
  `system_id` bigint NOT NULL COMMENT '稽核系统Id',
  `scene_id` bigint NOT NULL COMMENT '稽核场景Id',
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



drop table if exists jh_rule_call_figure_log;
CREATE TABLE `jh_rule_call_figure_log` (
  `id` bigint NOT NULL COMMENT '主键ID，首尾索引',
  `rule_id` bigint NOT NULL COMMENT '规则ID',
  `rule_code` char(32) NOT NULL COMMENT '规则编码',
  `rule_ver_id` bigint NOT NULL COMMENT '规则版本ID',
  `rule_ver_code` bigint NOT NULL COMMENT '规则版本code',
  `task_id` bigint NOT NULL COMMENT '任务Id',
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
  KEY `idx_rule_idx1` (`rule_id`)
) COMMENT='指标规则调用指标日志';