package com.citc.iot.webdoc.controller.device.request;

import lombok.Data;

@Data
public class StartDeviceTraceRequestObject
{
    Long deviceId;
    int day;
    int hour;
    int minute;
}
