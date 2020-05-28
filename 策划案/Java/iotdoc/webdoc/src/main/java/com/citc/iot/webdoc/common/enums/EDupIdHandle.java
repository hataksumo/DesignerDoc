package com.citc.iot.webdoc.common.enums;

public enum EDupIdHandle
{
    STOP(1),
    SKIP(2),
    OVERWRITE(3);
    int value;
    EDupIdHandle(int v_value)
    {
        this.value = v_value;
    }
}
