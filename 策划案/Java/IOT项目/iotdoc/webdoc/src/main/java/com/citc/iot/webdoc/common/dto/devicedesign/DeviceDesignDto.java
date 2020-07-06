package com.citc.iot.webdoc.common.dto.devicedesign;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@ApiModel(value="产品Dto")
public class DeviceDesignDto extends DeviceDesignListItemDto
{
    @ApiModelProperty(value="所属项目Id",example = "64位整数")
    Long projectId;
    @ApiModelProperty(value = "项目显示名",example = "智能空调")
    String projectShowName;
    @ApiModelProperty(value = "上次编辑时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime lastEditTime;
    @ApiModelProperty(value = "属性列表")
    List<AttributeDto> attributes;
    @ApiModelProperty(value = "命令列表")
    List<CommandDto> commands;
}
