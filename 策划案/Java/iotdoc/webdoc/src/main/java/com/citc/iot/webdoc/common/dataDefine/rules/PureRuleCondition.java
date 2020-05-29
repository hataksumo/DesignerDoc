package com.citc.iot.webdoc.common.dataDefine.rules;

import com.citc.iot.webdoc.common.enums.rule.EDeviceSelectorType;
import com.citc.iot.webdoc.common.enums.rule.ERuleConditionCompType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "条件")
public class PureRuleCondition
{
    @ApiModelProperty(value = "产品Id")
    Long deviceDesignId;
    @ApiModelProperty(value = "设备并存类型",example = "1是某1设备，2是全部设备")
    EDeviceSelectorType deviceSelectorType;
    @ApiModelProperty(value = "属性名称",example = "hp")
    String attrName;
    @ApiModelProperty(value = "属性符号",example = ">，>=，=，<=，<，")
    ERuleConditionCompType ruleConditionCompType;
    @ApiModelProperty(value = "数字比较字段",example = "20.5")
    double numCompVal;
    @ApiModelProperty(value = "字符串比较字段",example = "hh1")
    String strCompVal;
}