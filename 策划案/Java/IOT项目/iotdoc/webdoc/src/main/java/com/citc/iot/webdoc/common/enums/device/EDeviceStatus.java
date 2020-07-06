package com.citc.iot.webdoc.common.enums.device;

public enum EDeviceStatus
{
    ONLINE(1),
    OFFLINE(0),
    UNACTIVE(-1);
    int value;
    EDeviceStatus(int pValue)
    {
        this.value = pValue;
    }
}
