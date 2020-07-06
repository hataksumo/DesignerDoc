package com.citc.iot.webdoc.common.enums.rule;

public enum EDeviceSelectorType
{
    ANYONE(1),
    ALL(2);
    int value;
    EDeviceSelectorType(int v_value)
    {
        this.value = v_value;
    }
}
