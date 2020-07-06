package com.citc.iot.webdoc.controller.devicegroup.request;

import lombok.Data;

@Data
public class AddDeviceGroupRequestObject
{
    Long parentId;
    String name;
    String description;
}
