package com.citc.iot.webdoc.controller.device.request;

import lombok.Data;

@Data
public class ResetDevicePasswordRequestObject
{
    Long deviceId;
    String password;
}
