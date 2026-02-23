drop table if exists sys_file;

create table sys_file
(
   id                   bigint(20) not null comment '主键ID，雪花算法',
   path                 varchar(2048) not null comment '文件路径',
   uuid                 char(36) not null comment '文件的uuid',
   suffix               varchar(10) null comment '文件后缀',
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
   code                 char(32) not null comment '文件组的Code',
   file_id              bigint(20) not null comment '文件的Id',
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
   index idx_rel(file_group_id,file_id),
   index idx_code(code)
)