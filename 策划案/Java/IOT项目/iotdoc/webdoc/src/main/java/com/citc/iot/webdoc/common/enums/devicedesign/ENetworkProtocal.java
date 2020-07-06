package com.citc.iot.webdoc.common.enums.devicedesign;

public enum ENetworkProtocal
{
    MQTT(1),
    COAP(2),
    HTTP(3),
    HTTPS(4);
    int data;
    ENetworkProtocal(int v_data)
    {
        this.data = v_data;
    }
}
