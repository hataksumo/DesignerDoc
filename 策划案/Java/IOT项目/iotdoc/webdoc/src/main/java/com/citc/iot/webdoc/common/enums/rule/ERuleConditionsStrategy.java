package com.citc.iot.webdoc.common.enums.rule;

public enum ERuleConditionsStrategy
{
    ALL(1),
    ONE(2);
    int value;
    ERuleConditionsStrategy(int v_value)
    {
        this.value = v_value;
    }
}
