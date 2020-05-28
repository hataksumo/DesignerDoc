package com.citc.iot.webdoc.common.enums;

public enum EDeviceSortType
{
    NAME(1),
    ID(2),
    CREATE_TIME(3);

    int value;
    EDeviceSortType(int v_value)
    {
        this.value = v_value;
    }
}
