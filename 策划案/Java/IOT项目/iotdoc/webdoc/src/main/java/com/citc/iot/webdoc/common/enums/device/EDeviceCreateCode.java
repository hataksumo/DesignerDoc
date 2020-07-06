package com.citc.iot.webdoc.common.enums.device;

public enum EDeviceCreateCode
{
    SUCCESS(1),
    ID_DUPLICATE(2),
    CONTENT_ERR(3);
    int value;
    EDeviceCreateCode(int pValue)
    {
        this.value = pValue;
    }
}
