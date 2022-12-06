/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/3/4 16:51:41                            */
/*==============================================================*/


drop index  if exists idx_owner on account_shop;

drop index  if exists idx_del on account_shop;

drop table if exists account_shop;

drop index  if exists idx_del on account_user;

drop table if exists account_user;

drop index  if exists idx_del on busy_good;

drop table if exists busy_good;

drop index  if exists idx_time on busy_order;

drop index  if exists idx_owner on busy_order;

drop index  if exists idx_del on busy_order;

drop table if exists busy_order;

drop index  if exists idx_good on busy_order_good;

drop index  if exists idx_order on busy_order_good;

drop index  if exists idx_owner on busy_order_good;

drop index  if exists idx_del on busy_order_good;

drop table if exists busy_order_good;

/*==============================================================*/
/* Table: account_shop                                          */
/*==============================================================*/
create table account_shop
(
   id                   bigint not null comment '主键',
   name                 varchar(64) not null comment '商店名称',
   owner_id             bigint not null comment '拥有者Id，或-1',
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除',
   primary key (id)
);

alter table account_shop comment '商店表';

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on account_shop
(
   del
);

/*==============================================================*/
/* Index: idx_owner                                             */
/*==============================================================*/
create index idx_owner on account_shop
(
   owner_id
);

/*==============================================================*/
/* Table: account_user                                          */
/*==============================================================*/
create table account_user
(
   id                   bigint not null comment '主键',
   user_name            varchar(32) not null comment '用户名',
   passwd               varchar(128) not null comment '密码',
   nick_name            varchar(64) not null comment '用户昵称',
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除',
   primary key (id)
);

alter table account_user comment '用户表';

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on account_user
(
   del
);

/*==============================================================*/
/* Table: busy_good                                             */
/*==============================================================*/
create table busy_good
(
   id                   bigint not null comment '主键',
   name                 varchar(64),
   price                double,
   stock                int,
   shop_id              bigint,
   shop_name            varchar(64),
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除',
   primary key (id)
);

alter table busy_good comment '商品表';

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on busy_good
(
   del
);

/*==============================================================*/
/* Table: busy_order                                            */
/*==============================================================*/
create table busy_order
(
   id                   bigint not null comment '主键',
   price                double not null comment '订单价格',
   pay                  double not null comment '实付金额',
   owner_id             bigint not null comment '拥有者Id，或-1',
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除',
   primary key (id)
);

alter table busy_order comment '订单表';

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on busy_order
(
   del
);

/*==============================================================*/
/* Index: idx_owner                                             */
/*==============================================================*/
create index idx_owner on busy_order
(
   owner_id
);

/*==============================================================*/
/* Index: idx_time                                              */
/*==============================================================*/
create index idx_time on busy_order
(
   create_time
);

/*==============================================================*/
/* Table: busy_order_good                                       */
/*==============================================================*/
create table busy_order_good
(
   id                   bigint not null comment '主键',
   order_id             bigint not null,
   good_id              bigint not null,
   good_name            varchar(64) not null,
   shop_id              bigint not null,
   shop_name            varchar(64) not null,
   out_stock_id         bigint not null,
   out_stock_cnt        int not null,
   price                double not null comment '订单价格',
   owner_id             bigint not null comment '拥有者Id，或-1',
   create_time          timestamp not null comment '创建时间',
   create_by            bigint not null comment '创建用户Id',
   create_name          varchar(32) not null comment '创建者用户名',
   create_ip            varchar(128) not null comment '创建者Ip',
   modify_time          timestamp comment '修改时间',
   modify_by            bigint comment '修改用户Id',
   modify_name          varchar(32) comment '修改用户名称',
   modify_ip            varchar(128) comment '修改的Ip',
   version              int not null comment '版本号',
   del                  bool not null comment '是否删除',
   primary key (id)
);

alter table busy_order_good comment '订单商品表';

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on busy_order_good
(
   del
);

/*==============================================================*/
/* Index: idx_owner                                             */
/*==============================================================*/
create index idx_owner on busy_order_good
(
   owner_id
);

/*==============================================================*/
/* Index: idx_order                                             */
/*==============================================================*/
create index idx_order on busy_order_good
(
   order_id
);

/*==============================================================*/
/* Index: idx_good                                              */
/*==============================================================*/
create index idx_good on busy_order_good
(
   good_id
);

