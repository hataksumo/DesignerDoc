package com.citc.iot.webdoc.controller.moduledesign.Request;

import com.citc.iot.webdoc.common.enums.devicedesign.ENetworkProtocal;
import com.citc.iot.webdoc.common.enums.devicedesign.ENetworkProtocalFormate;
import lombok.Data;

@Data
public class CreateDeviceDesignRequestObject
{
    Long projectId;
    String name;
    ENetworkProtocal protocal;
    ENetworkProtocalFormate protocalFormate;
    Integer useModule;
    String industry;
    String deviceType;
    String fileModule;
}
