package com.citc.iot.webdoc.controller.moduleDesign.Request;

import com.citc.iot.webdoc.common.enums.ENetworkProtocal;
import com.citc.iot.webdoc.common.enums.ENetworkProtocalFormate;
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
