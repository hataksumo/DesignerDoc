package com.citc.iot.webdoc.common.dto.devicedesign;

import com.citc.iot.webdoc.common.enums.devicedesign.ENetworkProtocal;
import com.citc.iot.webdoc.common.enums.devicedesign.ENetworkProtocalFormate;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "产品列表项Dto")
public class DeviceDesignListItemDto
{
    @ApiModelProperty(value = "id",example = "64位整数")
    Long id;
    @ApiModelProperty(value = "逻辑名",example = "aircon")
    String name;
    @ApiModelProperty(value = "显示名",example = "空调")
    String showName;
    @ApiModelProperty(value = "协议名",example = "1 MQTT，2 COAP，3 HTTP，4 HTTPS")
    ENetworkProtocal protocalType;
    @ApiModelProperty(value = "协议格式", example = "1 Json, 2 Protobuff")
    ENetworkProtocalFormate networkProtocalFormate;
}
