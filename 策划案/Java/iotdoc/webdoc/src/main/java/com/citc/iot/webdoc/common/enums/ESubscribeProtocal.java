package com.citc.iot.webdoc.common.enums;

public enum ESubscribeProtocal
{
    Message(1),
    SMTP(2),
    HTTP(3),
    HTTPS(4);
    int value;
    ESubscribeProtocal(int v_value)
    {
        this.value = v_value;
    }
}
