package com.citc.iot.webdoc.common.enums.rule;

public enum EConditionType
{
    PURE(1),
    SCRIPT(2);
    int value;
    EConditionType(int v_value)
    {
        this.value = v_value;
    }
}
