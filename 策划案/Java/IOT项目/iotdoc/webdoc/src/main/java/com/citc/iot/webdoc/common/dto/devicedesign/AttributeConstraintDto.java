package com.citc.iot.webdoc.common.dto.devicedesign;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "属性约束Dto")
public class AttributeConstraintDto
{
    @ApiModelProperty(value = "字符串长度", example = "15")
    int len;
    @ApiModelProperty(value = "字符串枚举", example = "[咖啡,起司,三明治]")
    String[] enums;
    @ApiModelProperty(value = "数值型最小值", example = "5")
    int min;
    @ApiModelProperty(value = "数值型最大值", example = "15")
    int max;
    @ApiModelProperty(value = "数值型最小值", example = "5.0")
    double fMin;
    @ApiModelProperty(value = "数值型最小值", example = "15.0")
    double fMax;
}
