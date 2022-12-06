/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2022/7/21 8:49:23                            */
/*==============================================================*/


if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_dataset')
            and   name  = 'idx_datasource'
            and   indid > 0
            and   indid < 255)
   drop index sys_dataset.idx_datasource
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_dataset')
            and   name  = 'idx_code'
            and   indid > 0
            and   indid < 255)
   drop index sys_dataset.idx_code
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_dataset')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_dataset.idx_del
go

alter table sys_dataset
   drop constraint PK_SYS_DATASET
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_dataset')
            and   type = 'U')
   drop table sys_dataset
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_datasource')
            and   name  = 'idx_name'
            and   indid > 0
            and   indid < 255)
   drop index sys_datasource.idx_name
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_datasource')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_datasource.idx_del
go

alter table sys_datasource
   drop constraint PK_SYS_DATASOURCE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_datasource')
            and   type = 'U')
   drop table sys_datasource
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_module')
            and   name  = 'idx_code'
            and   indid > 0
            and   indid < 255)
   drop index sys_module.idx_code
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_module')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_module.idx_del
go

alter table sys_module
   drop constraint PK_SYS_MODULE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_module')
            and   type = 'U')
   drop table sys_module
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_rel_user_role')
            and   name  = 'idx_role_code'
            and   indid > 0
            and   indid < 255)
   drop index sys_rel_user_role.idx_role_code
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_rel_user_role')
            and   name  = 'idx_user_name'
            and   indid > 0
            and   indid < 255)
   drop index sys_rel_user_role.idx_user_name
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_rel_user_role')
            and   name  = 'uidx_user_role'
            and   indid > 0
            and   indid < 255)
   drop index sys_rel_user_role.uidx_user_role
go

alter table sys_rel_user_role
   drop constraint PK_SYS_REL_USER_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_rel_user_role')
            and   type = 'U')
   drop table sys_rel_user_role
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_role')
            and   name  = 'idx_code'
            and   indid > 0
            and   indid < 255)
   drop index sys_role.idx_code
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_role')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_role.idx_del
go

alter table sys_role
   drop constraint PK_SYS_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_role')
            and   type = 'U')
   drop table sys_role
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_script')
            and   name  = 'idx_datasource'
            and   indid > 0
            and   indid < 255)
   drop index sys_script.idx_datasource
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_script')
            and   name  = 'idx_code'
            and   indid > 0
            and   indid < 255)
   drop index sys_script.idx_code
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_script')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_script.idx_del
go

alter table sys_script
   drop constraint PK_SYS_SCRIPT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_script')
            and   type = 'U')
   drop table sys_script
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_user')
            and   name  = 'idx_name'
            and   indid > 0
            and   indid < 255)
   drop index sys_user.idx_name
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('sys_user')
            and   name  = 'idx_del'
            and   indid > 0
            and   indid < 255)
   drop index sys_user.idx_del
go

alter table sys_user
   drop constraint PK_SYS_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('sys_user')
            and   type = 'U')
   drop table sys_user
go

if exists(select 1 from systypes where name='Text')
   drop type Text
go

if exists(select 1 from systypes where name='boolean')
   drop type boolean
go

if exists(select 1 from systypes where name='cName')
   drop type cName
go

if exists(select 1 from systypes where name='double')
   drop type "double"
go

if exists(select 1 from systypes where name='enum')
   drop type enum
go

if exists(select 1 from systypes where name='id')
   drop type id
go

if exists(select 1 from systypes where name='integer')
   drop type integer
go

if exists(select 1 from systypes where name='key')
   drop type "key"
go

if exists(select 1 from systypes where name='long_varchar')
   drop type long_varchar
go

if exists(select 1 from systypes where name='string')
   drop type string
go

if exists(select 1 from systypes where name='timestamp')
   drop type timestamp
go

/*==============================================================*/
/* Domain: Text                                                 */
/*==============================================================*/
create type Text
   from text
go

/*==============================================================*/
/* Domain: boolean                                              */
/*==============================================================*/
create type boolean
   from bit
go

/*==============================================================*/
/* Domain: cName                                                */
/*==============================================================*/
create type cName
   from varchar(64)
go

/*==============================================================*/
/* Domain: "double"                                             */
/*==============================================================*/
create type "double"
   from double precision
go

/*==============================================================*/
/* Domain: enum                                                 */
/*==============================================================*/
create type enum
   from tinyint
go

/*==============================================================*/
/* Domain: id                                                   */
/*==============================================================*/
create type id
   from bigint
go

/*==============================================================*/
/* Domain: integer                                              */
/*==============================================================*/
create type integer
   from int
go

/*==============================================================*/
/* Domain: "key"                                                */
/*==============================================================*/
create type "key"
   from varchar(32)
go

/*==============================================================*/
/* Domain: long_varchar                                         */
/*==============================================================*/
create type long_varchar
   from varchar(1204)
go

/*==============================================================*/
/* Domain: string                                               */
/*==============================================================*/
create type string
   from varchar(128)
go

/*==============================================================*/
/* Domain: timestamp                                            */
/*==============================================================*/
create type timestamp
   from datetime
go

/*==============================================================*/
/* Table: sys_dataset                                           */
/*==============================================================*/
create table sys_dataset (
   id                   bigint               not null,
   type                 tinyint              not null,
   app_code             varchar(32)          not null,
   module_code          varchar(32)          not null,
   code                 varchar(32)          not null,
   name                 varchar(64)          null,
   description          varchar(1204)        null,
   "open"               tinyint              not null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_dataset') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_dataset' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'dataset，数据集的包装类，体现面向对象思想', 
   'user', @CurrentUser, 'table', 'sys_dataset'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '数据集类型',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'app_code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'app_code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用Code',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'app_code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'module_code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'module_code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块Code',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'module_code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '数据集Code',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '数据集名称',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'description')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'description'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '数据集简介',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'description'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'open')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'open'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否开放',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'open'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_dataset')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_dataset', 'column', 'del'
go

alter table sys_dataset
   add constraint PK_SYS_DATASET primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_dataset (
del ASC
)
go

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on sys_dataset (
code ASC
)
go

/*==============================================================*/
/* Index: idx_datasource                                        */
/*==============================================================*/
create index idx_datasource on sys_dataset (
type ASC
)
go

/*==============================================================*/
/* Table: sys_datasource                                        */
/*==============================================================*/
create table sys_datasource (
   id                   bigint               not null,
   code                 varchar(32)          not null,
   name                 varchar(64)          null,
   description          varchar(1204)        null,
   db_type              tinyint              not null,
   url                  varchar(1204)        not null,
   user_name            varchar(32)          not null,
   passwd               varchar(128)         not null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_datasource') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_datasource' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '数据源表', 
   'user', @CurrentUser, 'table', 'sys_datasource'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_datasource')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_datasource', 'column', 'del'
go

alter table sys_datasource
   add constraint PK_SYS_DATASOURCE primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_datasource (
del ASC
)
go

/*==============================================================*/
/* Index: idx_name                                              */
/*==============================================================*/
create index idx_name on sys_datasource (
code ASC
)
go

/*==============================================================*/
/* Table: sys_module                                            */
/*==============================================================*/
create table sys_module (
   id                   bigint               not null,
   app_id               bigint               not null,
   app_code             varchar(32)          not null,
   app_name             varchar(64)          null,
   code                 varchar(32)          not null,
   name                 varchar(64)          null,
   description          varchar(1204)        null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_module') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_module' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '应用表，平台可以创建多个应用，以做鉴权与数据隔离。
   应用下有数据源和模块。', 
   'user', @CurrentUser, 'table', 'sys_module'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'app_id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用Id，外键',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'app_code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用Code，冗余字段',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'app_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用名，冗余字段',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'app_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块Code',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块Name',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'description')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'description'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用的描述',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'description'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_module')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_module', 'column', 'del'
go

alter table sys_module
   add constraint PK_SYS_MODULE primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_module (
del ASC
)
go

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on sys_module (
app_code ASC,
code ASC
)
go

/*==============================================================*/
/* Table: sys_rel_user_role                                     */
/*==============================================================*/
create table sys_rel_user_role (
   id                   bigint               not null,
   user_id              bigint               not null,
   role_id              bigint               not null,
   user_name            varchar(32)          not null,
   nick_name            varchar(64)          not null,
   role_code            varchar(32)          not null,
   role_name            varchar(64)          not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_rel_user_role') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_rel_user_role' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '角色关联表', 
   'user', @CurrentUser, 'table', 'sys_rel_user_role'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_rel_user_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_rel_user_role', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_rel_user_role', 'column', 'id'
go

alter table sys_rel_user_role
   add constraint PK_SYS_REL_USER_ROLE primary key nonclustered (id)
go

/*==============================================================*/
/* Index: uidx_user_role                                        */
/*==============================================================*/
create unique index uidx_user_role on sys_rel_user_role (
user_id ASC,
role_id ASC
)
go

/*==============================================================*/
/* Index: idx_user_name                                         */
/*==============================================================*/
create index idx_user_name on sys_rel_user_role (
user_name ASC
)
go

/*==============================================================*/
/* Index: idx_role_code                                         */
/*==============================================================*/
create index idx_role_code on sys_rel_user_role (
role_code ASC
)
go

/*==============================================================*/
/* Table: sys_role                                              */
/*==============================================================*/
create table sys_role (
   id                   bigint               not null,
   code                 varchar(32)          not null,
   name                 varchar(64)          null,
   description          varchar(1204)        null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_role') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_role' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '角色表', 
   'user', @CurrentUser, 'table', 'sys_role'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_role')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_role', 'column', 'del'
go

alter table sys_role
   add constraint PK_SYS_ROLE primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_role (
del ASC
)
go

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on sys_role (
code ASC
)
go

/*==============================================================*/
/* Table: sys_script                                            */
/*==============================================================*/
create table sys_script (
   id                   bigint               not null,
   data_source_id       bigint               null,
   app_code             varchar(32)          not null,
   module_code          varchar(32)          not null,
   code                 varchar(32)          not null,
   method               tinyint              not null,
   name                 varchar(64)          null,
   description          varchar(1204)        null,
   script               text                 null,
   script_md5           varchar(128)         null,
   error                tinyint              not null,
   "open"               tinyint              not null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_script') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_script' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'python脚本表，存储python脚本，是否打开，数据源等信息', 
   'user', @CurrentUser, 'table', 'sys_script'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'data_source_id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'data_source_id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '数据源Id',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'data_source_id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'app_code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'app_code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '应用Code',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'app_code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'module_code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'module_code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块Code',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'module_code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本Code',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'method')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'method'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '链接的请求方法，GET，PUT，POST，DELETE',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'method'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本名称',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'description')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'description'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本简介',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'description'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'script')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'script'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本片段文本',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'script'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'script_md5')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'script_md5'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本的md5',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'script_md5'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'error')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'error'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '脚本是否有错',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'error'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'open')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'open'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否开放',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'open'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_script')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_script', 'column', 'del'
go

alter table sys_script
   add constraint PK_SYS_SCRIPT primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_script (
del ASC
)
go

/*==============================================================*/
/* Index: idx_code                                              */
/*==============================================================*/
create index idx_code on sys_script (
code ASC
)
go

/*==============================================================*/
/* Index: idx_datasource                                        */
/*==============================================================*/
create index idx_datasource on sys_script (
data_source_id ASC
)
go

/*==============================================================*/
/* Table: sys_user                                              */
/*==============================================================*/
create table sys_user (
   id                   bigint               not null,
   name                 varchar(32)          not null,
   passwd               varchar(128)         null,
   user_title           varchar(64)          null,
   ban                  tinyint              not null,
   passwd_reset         tinyint              not null,
   email                varchar(128)         null,
   phone                varchar(128)         null,
   create_time          datetime             not null,
   create_by            bigint               not null,
   create_name          varchar(32)          not null,
   create_ip            varchar(128)         not null,
   modify_time          datetime             null,
   modify_by            bigint               null,
   modify_name          varchar(32)          null,
   modify_ip            varchar(128)         null,
   version              int                  not null,
   del                  tinyint              not null
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('sys_user') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'sys_user' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   '用户表', 
   'user', @CurrentUser, 'table', 'sys_user'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主键',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建用户Id',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者用户名',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'create_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建者Ip',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'create_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改时间',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_time'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_by')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_by'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户Id',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_by'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改用户名称',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'modify_ip')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_ip'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '修改的Ip',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'modify_ip'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'version')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'version'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'version'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('sys_user')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'del')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'del'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'user', @CurrentUser, 'table', 'sys_user', 'column', 'del'
go

alter table sys_user
   add constraint PK_SYS_USER primary key nonclustered (id)
go

/*==============================================================*/
/* Index: idx_del                                               */
/*==============================================================*/
create index idx_del on sys_user (
del ASC
)
go

/*==============================================================*/
/* Index: idx_name                                              */
/*==============================================================*/
create index idx_name on sys_user (
name ASC
)
go

