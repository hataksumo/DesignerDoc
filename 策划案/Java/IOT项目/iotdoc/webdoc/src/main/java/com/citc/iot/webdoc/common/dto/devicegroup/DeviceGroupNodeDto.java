package com.citc.iot.webdoc.common.dto.devicegroup;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "设备群组节点")
public class DeviceGroupNodeDto
{
    @ApiModelProperty(value = "父节点Id",example = "整数Id，-1表示根结点")
    Long parentId;
    @ApiModelProperty(value = "id",example = "顺序Id")
    Long id;
    @ApiModelProperty(value = "显示名",example = "顺序Id")
    String showName;
}
