package com.citc.iot.webdoc.common.enums;

public enum ENetworkProtocalFormate
{
    JSON(1),
    PROTOBUF(2);
    int value;
    ENetworkProtocalFormate(int v_value)
    {
        this.value = v_value;
    }
}
