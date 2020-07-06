package com.citc.iot.webdoc.common.enums.topic;

public enum ESubscribeStatus
{
    CONFIRMED(1),
    UNCONFIRMED(0);
    int value;
    ESubscribeStatus(int v_value)
    {
        this.value = v_value;
    }
}
