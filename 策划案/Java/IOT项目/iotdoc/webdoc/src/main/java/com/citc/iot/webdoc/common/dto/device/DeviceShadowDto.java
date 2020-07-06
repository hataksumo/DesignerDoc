package com.citc.iot.webdoc.common.dto.device;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * @author 织法酱
 */
@Data
@ApiModel(value="设备影子DTO")
public class DeviceShadowDto
{
    @ApiModelProperty(value = "上次通信时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime timestamp;
    @ApiModelProperty(value = "设备属性",example = "根据产品模型属性的键值对Json")
    Map<String,Object> attributes;
}
