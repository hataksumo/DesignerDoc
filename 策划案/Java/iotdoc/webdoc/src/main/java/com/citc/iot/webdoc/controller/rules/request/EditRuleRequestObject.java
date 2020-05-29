package com.citc.iot.webdoc.controller.rules.request;

import com.citc.iot.webdoc.common.dataDefine.rules.RuleAction;
import com.citc.iot.webdoc.common.dataDefine.rules.RuleConditionSet;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel(value = "修改规则请求对象")
public class EditRuleRequestObject
{
    @ApiModelProperty(value="项目Id",example = "64位二进制数")
    Long id;
    @ApiModelProperty(value="规则名",example = "残血嗑药")
    String ruleName;
    @ApiModelProperty(value="描述",example = "如果血量低于20%，通知用户吃药")
    String description;
    @ApiModelProperty(value="触发间隔，单位秒",example = "7200")
    int triggerInteval;
    @ApiModelProperty(value="规则集合")
    RuleConditionSet conditionSet;
    List<RuleAction> actions;
}
