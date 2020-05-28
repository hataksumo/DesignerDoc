package com.citc.iot.webdoc.common.enums;

public enum EAttributeType
{
    STRING(1),
    INTEGER(2),
    DOUBLE(3);
    int data;
    EAttributeType(int v_data)
    {
        this.data = v_data;
    }
}
