/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/5/25 10:04:21                           */
/*==============================================================*/


drop index idx on bl_battle;

drop index idx_del on bl_battle;

alter table bl_battle
   drop primary key;

drop table if exists bl_battle;

drop index idx_battle_id on bl_boss;

drop index idx_del on bl_boss;

alter table bl_boss
   drop primary key;

drop table if exists bl_boss;

drop index idx_boss on bl_hit;

drop index idx_user_battle on bl_hit;

drop index idx_del on bl_hit;

alter table bl_hit
   drop primary key;

drop table if exists bl_hit;

drop index idx_battle_player on bl_player_score;

drop index idx_del on bl_player_score;

alter table bl_player_score
   drop primary key;

drop table if exists bl_player_score;

drop index idx_del on bl_union;

alter table bl_union
   drop primary key;

drop table if exists bl_union;

drop index idx_battle on bl_union_score;

drop index idx_union on bl_union_score;

drop index idx_del on bl_union_score;

alter table bl_union_score
   drop primary key;

drop table if exists bl_union_score;

drop index idx_nick_name on bl_user;

drop index idx_del on bl_user;

alter table bl_user
   drop primary key;

drop table if exists bl_user;

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
/* Table: bl_battle                                             */
/*==============================================================*/
create table bl_battle
(
   id                   bigint not null comment '主键',
   union_id             bigint not null comment '公会的id',
   year                 int not null comment '哪一年的公会战',
   constellation        tinyint not null comment '星座',
   phase                int not null comment '第几周目',
   day                  bool not null comment '目前公会战进行了几天',
   status               tinyint not null comment '公会战的状态，ON_GOING(1), FINISH(2)',
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

alter table bl_battle comment '公会战';

alter table bl_battle
   add primary key (id, union_id, year, constellation, phase, day, status);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_battle
(
   del
);

/*==============================================================*/
/* Index: idx                                                   */
/*==============================================================*/
create index idx on bl_battle
(
   union_id,
   year,
   constellation
);

/*==============================================================*/
/* Table: bl_boss                                               */
/*==============================================================*/
create table bl_boss
(
   id                   bigint not null comment '主键',
   battle_id            bigint not null comment '公会战id',
   boss_type            tinyint not null comment 'boss类型',
   hp                   int not null comment '剩余血量',
   alive                bool not null comment '是否存活',
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

alter table bl_boss comment 'boss类';

alter table bl_boss
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_boss
(
   del
);

/*==============================================================*/
/* Index: idx_battle_id                                         */
/*==============================================================*/
create index idx_battle_id on bl_boss
(
   battle_id
);

/*==============================================================*/
/* Table: bl_hit                                                */
/*==============================================================*/
create table bl_hit
(
   id                   bigint not null comment '主键',
   user_id              bigint not null comment '用户id',
   nick_name            varchar(64) not null comment '用户昵称，冗余字段',
   battle_id            bigint not null comment '公会战id',
   boss_id              bigint not null comment 'boss id',
   done                 bool not null comment '是否出刀',
   demage               int not null comment '伤害',
   score                int not null comment '分数',
   hit_type             tinyint not null comment '刀类型 WHOLE(1) TAIL(2) COMPENSITE(3)',
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

alter table bl_hit comment '伤害表';

alter table bl_hit
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_hit
(
   del
);

/*==============================================================*/
/* Index: idx_user_battle                                       */
/*==============================================================*/
create index idx_user_battle on bl_hit
(
   user_id,
   battle_id
);

/*==============================================================*/
/* Index: idx_boss                                              */
/*==============================================================*/
create index idx_boss on bl_hit
(
   boss_id
);

/*==============================================================*/
/* Table: bl_player_score                                       */
/*==============================================================*/
create table bl_player_score
(
   id                   bigint not null comment '主键',
   player_id            bigint not null comment '玩家id',
   player_name          varchar(64) not null comment '玩家名称',
   battle_id            bigint not null comment '公会战id',
   hit_whole            int not null comment '完整刀次数',
   hit_tail             int not null comment '尾刀次数',
   hit_compensate       int not null comment '补偿刀次数',
   sl                   bool not null comment '是否SL',
   score                int not null comment '分数',
   demage               int not null comment '伤害',
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

alter table bl_player_score comment '玩家分数';

alter table bl_player_score
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_player_score
(
   del
);

/*==============================================================*/
/* Index: idx_battle_player                                     */
/*==============================================================*/
create index idx_battle_player on bl_player_score
(
   battle_id,
   player_id
);

/*==============================================================*/
/* Table: bl_union                                              */
/*==============================================================*/
create table bl_union
(
   id                   bigint not null comment '主键',
   name                 varchar(64) not null comment '昵称',
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

alter table bl_union comment '公会表';

alter table bl_union
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_union
(
   del
);

/*==============================================================*/
/* Table: bl_union_score                                        */
/*==============================================================*/
create table bl_union_score
(
   id                   bigint not null comment '主键',
   union_id             bigint not null comment '公会id',
   union_name           varchar(64) not null comment '公会名称',
   battle_id            bigint not null comment '公会战id',
   round                int not null comment '第几轮',
   boss                 int not null comment '第几个boss',
   score                int not null comment '分数',
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

alter table bl_union_score comment '公会分数';

alter table bl_union_score
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_union_score
(
   del
);

/*==============================================================*/
/* Index: idx_union                                             */
/*==============================================================*/
create index idx_union on bl_union_score
(
   union_id
);

/*==============================================================*/
/* Index: idx_battle                                            */
/*==============================================================*/
create index idx_battle on bl_union_score
(
   battle_id
);

/*==============================================================*/
/* Table: bl_user                                               */
/*==============================================================*/
create table bl_user
(
   id                   bigint not null comment '主键',
   nick_name            varchar(64) not null comment '昵称',
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

alter table bl_user comment '用户表';

alter table bl_user
   add primary key (id);

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on bl_user
(
   del
);

/*==============================================================*/
/* Index: idx_nick_name                                         */
/*==============================================================*/
create index idx_nick_name on bl_user
(
   nick_name
);

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

