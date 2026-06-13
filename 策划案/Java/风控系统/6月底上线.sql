CREATE TABLE `jh_table_desc_figure_source_def` (
  `id` bigint NOT NULL COMMENT '主键ID，雪花算法',
  `code` char(50)  NOT NULL COMMENT '接口code',
  `name` varchar(128)  DEFAULT NULL COMMENT '名称',
  `description` varchar(1024) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '描述',
  `has_table_info` tinyint(1) NOT NULL default 0 COMMENT '是否有表信息',
  `table_name` varchar(256) NULL COMMENT '表名',
  `group_phrases` varchar(256) NULL COMMENT '分组语句',

  `enable` tinyint NOT NULL COMMENT '启用停用',
  `create_user_id` bigint NOT NULL COMMENT '创建者用户Id',
  `create_user` varchar(64) COLLATE `ci_x_icu` NOT NULL COMMENT '创建者用户昵称',
  `create_time` datetime NOT NULL COMMENT '创建的时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '修改者用户Id',
  `update_user` varchar(64) COLLATE `ci_x_icu` DEFAULT NULL COMMENT '修改者用户昵称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `version` integer NOT NULL COMMENT '乐观锁',
  CONSTRAINT `jh_table_desc_figure_source_def_pkey` PRIMARY KEY (`id`),
  unique CONSTRAINT `uidx_jh_table_desc_figure_source_def_code` UNIQUE (`code`)
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
  `dim_arr` varchar(128) NOT NULL COMMENT '维度，存的jh_table_desc_figure_source_var表的id，","分割',

  `enable` tinyint(1) NOT NULL default 0 COMMENT '启用停用',
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