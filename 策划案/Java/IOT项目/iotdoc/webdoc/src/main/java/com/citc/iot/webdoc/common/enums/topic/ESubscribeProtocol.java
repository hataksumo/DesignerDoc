package com.citc.iot.webdoc.common.enums.topic;

public enum ESubscribeProtocol
{
    Message(1),
    SMTP(2),
    HTTP(3),
    HTTPS(4);
    int value;
    ESubscribeProtocol(int v_value)
    {
        this.value = v_value;
    }
}
