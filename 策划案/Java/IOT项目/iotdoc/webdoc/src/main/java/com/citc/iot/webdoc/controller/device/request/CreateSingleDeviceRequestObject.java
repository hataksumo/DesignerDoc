package com.citc.iot.webdoc.controller.device.request;

import lombok.Data;

@Data
public class CreateSingleDeviceRequestObject
{
    long projectId;
    long deviceDesignId;
    String deviceId;
    String deviceShowName;
    String password;
}
