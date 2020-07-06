package com.citc.iot.webdoc.common.dto.devicedesign;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel(value = "命令Dto")
public class CommandDto
{
    @ApiModelProperty(value = "命令名",example = "eatBottle")
    String name;
    @ApiModelProperty(value = "描述",example = "通知玩家吃血瓶")
    String description;
    @ApiModelProperty(value = "属性列表",example = "下发属性的集合")
    List<CommandAttributeDto> attributeDtos;
}
