package com.citc.iot.webdoc.common.dto.rules;

import com.citc.iot.webdoc.common.enums.rule.EConditionType;
import com.citc.iot.webdoc.common.enums.rule.ERuleConditionsStrategy;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@ApiModel(value = "规则集合")
@Data
public class RuleConditionSetDto
{
    @ApiModelProperty(value = "规则类型(int)",example = "原生1，脚本2")
    EConditionType conditionType;
    @ApiModelProperty(value = "脚本的字符串",example = "脚本的内容，print(\"hello world\")")
    String script;
    @ApiModelProperty(value = "多条件关系",example = "1是&，2是|")
    ERuleConditionsStrategy ruleConditionsStrategy;//多个条件的策略，或还是与
    @ApiModelProperty(value = "条件数组")
    List<PureRuleConditionDto> conditions;
}