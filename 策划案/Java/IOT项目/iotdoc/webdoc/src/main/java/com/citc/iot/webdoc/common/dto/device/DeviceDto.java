package com.citc.iot.webdoc.common.dto.device;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author 织法酱
 */
@Data
@ApiModel(value="设备信息DTO")
public class DeviceDto extends DeviceListItemDto
{
    @ApiModelProperty(value="创建时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime createTime;
    @ApiModelProperty(value="设备影子")
    DeviceShadowDto shadow;
}
