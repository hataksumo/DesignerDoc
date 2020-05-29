package com.citc.iot.webdoc.common.dataDefine.rules;

import com.citc.iot.webdoc.common.enums.rule.RuleActionType;
import lombok.Data;

import java.util.Map;

@Data
public class RuleAction
{
    RuleActionType ruleActionType;
    Long deviceDesignId;
    String actionName;
    Map<String,String> params;
    Long topicId;
    String topicTitle;
    String topicContent;
}
