package com.citc.iot.webdoc.common.dto.devicedesign;

import com.citc.iot.webdoc.common.enums.devicedesign.EAttributeType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel(value = "属性DTO")
@Data
public class AttributeDto
{
    @ApiModelProperty(value = "属性名",example = "hp")
    String name;
    @ApiModelProperty(value = "属性类型",example = "1 字符串, 2 整数, 3浮点型")
    EAttributeType attrType;
    @ApiModelProperty(value = "属性描述",example = "记录玩家的生命值")
    String description;
    @ApiModelProperty(value = "属性约束")
    AttributeConstraintDto constraint;
}
