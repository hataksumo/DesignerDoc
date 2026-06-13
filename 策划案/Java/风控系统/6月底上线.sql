CREATE TABLE `jh_table_desc_figure_source_def` (
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `code` char(50)  NOT NULL COMMENT '接口code',
  `name` varchar(128)  DEFAULT NULL COMMENT '名称',
  `description` varchar(1024) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '描述',
  `has_table_info` tinyint(1) NOT NULL default 0 COMMENT '是否有表信息',
  `table_name` varchar(256) NULL COMMENT '表名',
  `table_comment` varchar(256) NULL COMMENT '表名',
  `group_phrases` varchar(256) NULL COMMENT '分组语句',
  `data_sync_desc` varchar(256) NULL COMMENT '更新频率描述',
  `system_id` bigint NOT NULL default 0 COMMENT '所属系统',
  `system_code` varchar(64) NULL COMMENT '所属系统code',
  `status` tinyint NOT NULL COMMENT '状态',
  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` varchar(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` varchar(64) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` integer NOT NULL COMMENT '乐观锁',
  CONSTRAINT `jh_table_desc_figure_source_def_pkey` PRIMARY KEY (`id`),
  CONSTRAINT `uidx_jh_table_desc_figure_source_def_code` UNIQUE (`code`)
)
COMMENT '表描述数据源定义'

CREATE TABLE `jh_table_desc_figure_source_var` (
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `source_id`  bigint NOT NULL COMMENT '数据源主表id',
  `field_script` varchar(100)  NOT NULL COMMENT '字段脚本',
  `field_as` varchar(50) NOT NULL COMMENT '字段as,键',
  `name` varchar(64)  DEFAULT NULL COMMENT '字段名称',
  `description` varchar(1024)  DEFAULT NULL COMMENT '字段描述',
  `var_type` tinyint NOT NULL COMMENT '变量类型',
  `enum_code` varchar(100) NULL COMMENT '枚举code',
  `default_val` varchar(100) NOT NULL COMMENT '默认值',
  `order_idx` int NOT NULL default 0 COMMENT '字段排序',


  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` character varying(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` character varying(64) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` integer NOT NULL COMMENT '乐观锁',
  CONSTRAINT  `jh_table_desc_figure_source_var_pkey` PRIMARY KEY(`id`),
  CONSTRAINT  `uidx_jh_table_desc_figure_source_var_field_as` UNIQUE KEY(`source_id`,`field_as`)
)
COMMENT '表描述数据源字段'

CREATE TABLE `jh_script_figure_source_def`(
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `code` char(50)  NOT NULL COMMENT '接口code',
  `name` varchar(128)  DEFAULT NULL COMMENT '名称',
  `description` varchar(1024)  DEFAULT NULL COMMENT '描述',
  `table_desc_id` bigint NOT NULL COMMENT '表描述数据源Id',
  `script_text` text  NOT NULL COMMENT '脚本字段',
  `dim_arr` text NOT NULL COMMENT '维度，存的jh_table_desc_figure_source_var表的id',

  `system_id` bigint NOT NULL default 0 COMMENT '所属系统',
  `system_code` varchar(64) NULL COMMENT '所属系统code',
  `status` tinyint NOT NULL COMMENT '状态',

  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` varchar(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` varchar(64) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` integer NOT NULL COMMENT '乐观锁',
  CONSTRAINT `jh_script_figure_source_def_pkey` PRIMARY KEY(`id`),
  CONSTRAINT `uidx_jh_script_figure_source_def_code` UNIQUE KEY(`code`)
)
COMMENT '脚本数据源'

CREATE TABLE `jh_script_figure_source_var` (
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `source_id`  bigint NOT NULL COMMENT '数据源主表id',
  `field_key` varchar(50) NOT NULL COMMENT '返回值字段的键',

  `name` varchar(64)  DEFAULT NULL COMMENT '字段名称',
  `description` varchar(1024)  DEFAULT NULL COMMENT '字段描述',
  `var_type` tinyint NOT NULL COMMENT '变量类型',
  `enum_code` varchar(100) NULL COMMENT '枚举code',
  `default_val` varchar(100) NOT NULL COMMENT '默认值',
  `order_idx` int NOT NULL default 0 COMMENT '字段排序',

  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` character varying(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` character varying(64) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` integer NOT NULL COMMENT '乐观锁',
  CONSTRAINT `jh_script_figure_source_var_pkey` PRIMARY KEY (`id`),
  CONSTRAINT `uidx_jh_script_figure_source_var_field_key` UNIQUE KEY(`source_id`,`field_key`)
)
COMMENT '表描述数据源字段'


ALTER TABLE jh_rule_def drop column event_id;
ALTER TABLE jh_rule_def drop column event_code;

ALTER TABLE jh_rule_def alter column scene_id drop not null;
ALTER TABLE jh_rule_def alter column scene_code drop not null;


ALTER TABLE jh_rule_def add column table_desc_id bigint NOT NULL default 0 COMMENT '表描述数据源Id';


ALTER TABLE jh_rule_sub_def drop column actions;

ALTER TABLE jh_rule_sub_def add column has_jh_action tinyint(1) NOT NULL default 0 COMMENT '是否有稽核动作';
ALTER TABLE jh_rule_sub_def add column has_hit_rate_threshold tinyint(1) NOT NULL default 0 COMMENT '是否有命中阈值限制';
ALTER TABLE jh_rule_sub_def add column hit_rate_threshold int NOT NULL default 0 COMMENT '命中阈值，百分制';
ALTER TABLE jh_rule_sub_def add column inform_user_ids text NOT NULL default 0 COMMENT '通知用户Id列表';
ALTER TABLE jh_rule_sub_def add column inform_methods text NOT NULL default 0 COMMENT '通知方式';



CREATE TABLE `jh_rule_sub_def_inform_user`(
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `jh_rule_id` bigint NOT NULL COMMENT '稽核规则Id',
  `jh_rule_code` varchar(64) NOT NULL COMMENT '规则code',
  `jh_rule_sub_def_id` bigint NOT NULL COMMENT '子规则id',
  `user_id` bigint NOT NULL COMMENT '用户Id',
  `user_name` varchar(64) NULL COMMENT '用户名',

  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',

  CONSTRAINT `jh_jh_rule_sub_def_inform_user_pkey` PRIMARY KEY (`id`),
  CONSTRAINT `uidx_jh_rule_sub_def_inform_user_rel_key` unique KEY(`jh_rule_sub_def_id`,`user_id`),
  INDEX `idx_jh_rule_sub_def_inform_user_rel_rule_id`(`jh_rule_id`)
) 
COMMENT '告警通知表'




CREATE TABLE `jh_figure` (
`id` bigint NOT NULL COMMENT '主键ID，雪花算法',
`figure_type` tinyint NOT NULL COMMENT '指标类型',
`source_code` char(32) NOT NULL COMMENT '来源的code',
`source_id` bigint NOT NULL COMMENT '来源表的Id',
`source_var_id` bigint NOT NULL COMMENT '数据源字段表id',
`source_field` char(32) NOT NULL COMMENT '来源的field',
`code` char(32) NOT NULL COMMENT '编码',
`name` varchar(64) NOT NULL COMMENT '名称',
`description` varchar(1024) DEFAULT NULL COMMENT '描述',
`enable` tinyint NOT NULL COMMENT '启用',
`desensitize_type` integer DEFAULT 0 COMMENT '脱敏类型 0 不脱敏，1手机号类脱敏 2IP类脱敏 3地址类脱敏 4姓名类脱敏 5密钥脱敏 默认0不脱敏',
`system_id` bigint NOT NULL COMMENT '所属系统',
`create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
`create_user` varchar(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
`create_time` datetime NOT NULL COMMENT '创建的时间',
`update_user_id` bigint DEFAULT NULL COMMENT '修改用户Id',
`update_user` varchar(64) DEFAULT NULL COMMENT '修改者用户昵称',
`update_time` datetime DEFAULT NULL COMMENT '修改时间',
`version` integer NOT NULL COMMENT '乐观锁',

CONSTRAINT `jh_figure_pkey` PRIMARY KEY (`id`),
CONSTRAINT `uidx_jh_figure_code` UNIQUE (`code`),
constraint `uidx_jh_figure_source_var_id` UNIQUE(`source_var_id`)
)
COMMENT '看板指标'




