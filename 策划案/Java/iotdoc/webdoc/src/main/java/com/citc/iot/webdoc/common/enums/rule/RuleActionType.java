package com.citc.iot.webdoc.common.enums.rule;

public enum RuleActionType
{
    SEND_COMMAND(1),
    SEND_TO_TOPIC(2);
    int value;
    RuleActionType(int v_value)
    {
        this.value = v_value;
    }
}
