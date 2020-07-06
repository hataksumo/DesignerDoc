package com.citc.iot.webdoc.common.dto.project;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel(value = "项目列表项")
public class ProjectListItemDto
{
    @ApiModelProperty(value = "id",example = "64位整数")
    Long id;
    @ApiModelProperty(value = "逻辑名",example = "intelligentSchool")
    String name;
    @ApiModelProperty(value = "显示名",example = "智慧校园")
    String showName;
    @ApiModelProperty(value = "创建时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime createTime;
}
