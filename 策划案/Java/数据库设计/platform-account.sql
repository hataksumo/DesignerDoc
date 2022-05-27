/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/5/9 16:20:20                            */
/*==============================================================*/


drop index idx_role_code on sys_rel_user_role;

drop index idx_user_name on sys_rel_user_role;

drop index uidx_user_role on sys_rel_user_role;

alter table sys_rel_user_role
   drop primary key;

drop table if exists sys_rel_user_role;

drop index idx_code on sys_role;

drop index idx_del on sys_role;

alter table sys_role
   drop primary key;

drop table if exists sys_role;

drop index idx_name on sys_user;

drop index idx_del on sys_user;

alter table sys_user
   drop primary key;

drop table if exists sys_user;

/*==============================================================*/
/* Table: sys_rel_user_role                                     */
/*==============================================================*/
create table sys_rel_user_role
(
   id                   bigint not null comment '主键',
   user_id              bigint not null,
   role_id              bigint not null,
   user_name            varchar(32) not null,
   role_code            varchar(32) not null,
   role_name            varchar(64) not null
);

alter table sys_rel_user_role comment '角色关联表';

alter table sys_rel_user_role
   add primary key (id);

/*==============================================================*/
/* Index: uidx_user_role                                        */
/*==============================================================*/
create unique index uidx_user_role on sys_rel_user_role
(
   user_id,
   role_id
);

/*==============================================================*/
/* Index: idx_user_name                                         */
/*==============================================================*/
create index idx_user_name on sys_rel_user_role
(
   user_name
);

/*==============================================================*/
/* Index: idx_role_code                                         */
/*==============================================================*/
create index idx_role_code on sys_rel_user_role
(
   role_code
);

/*==============================================================*/
/* Table: sys_role                                              */
/*==============================================================*/
create table sys_role
(
   id                   bigint not null comment '主键',
   code                 varchar(32) not null,
   name                 varchar(64),
   description          varchar(1204),
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除'
);

alter table sys_role comment '角色表';

alter table sys_role
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_role
(
   del
);

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on sys_role
(
   code
);

/*==============================================================*/
/* Table: sys_user                                              */
/*==============================================================*/
create table sys_user
(
   id                   bigint not null comment '主键',
   name                 varchar(32) not null,
   passwd               varchar(128),
   user_title           varchar(64),
   ban                  bool not null,
   passwd_reset         bool not null,
   email                varchar(128),
   phone                varchar(128),
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除'
);

alter table sys_user comment '用户表';

alter table sys_user
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_user
(
   del
);

/*==============================================================*/
/* Index: idx_name                                              */
/*==============================================================*/
create index idx_name on sys_user
(
   name
);

