package com.citc.iot.webdoc.common.enums.rule;

public enum ERuleStatus
{
    ACTIVE(1),
    DISABLE(0);
    int value;
    ERuleStatus(int pValue)
    {
        this.value = pValue;
    }
}
