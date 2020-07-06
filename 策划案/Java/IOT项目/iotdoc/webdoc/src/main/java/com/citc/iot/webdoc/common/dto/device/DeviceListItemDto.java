package com.citc.iot.webdoc.common.dto.device;

import com.citc.iot.webdoc.common.enums.device.EDeviceStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author 织法酱
 */
@Data
@ApiModel(value="设备列表信息DTO")
public class DeviceListItemDto
{
    @ApiModelProperty(value="id",example = "64位整数")
    Long id;
    @ApiModelProperty(value="逻辑名",example = "aircon_001")
    String name;
    @ApiModelProperty(value="显示名",example = "小明家的空调")
    String showName;
    @ApiModelProperty(value="所属项目Id",example = "64位整数")
    Long projectId;
    @ApiModelProperty(value="所属项目显示名",example = "只能中央空调")
    String projectShowName;
    @ApiModelProperty(value="所属产品Id",example = "64位整数")
    Long deviceDesignId;
    @ApiModelProperty(value="所属于产品显示名",example = "智能中央空调")
    String deviceDesignShowName;
    @ApiModelProperty(value = "状态枚举",example = "1在线，0离线，-1未激活")
    EDeviceStatus status;
}
