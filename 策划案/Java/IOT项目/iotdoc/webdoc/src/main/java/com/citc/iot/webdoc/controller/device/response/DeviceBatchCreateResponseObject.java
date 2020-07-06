package com.citc.iot.webdoc.controller.device.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel(value = "设备批量创建响应对象")
public class DeviceBatchCreateResponseObject
{
    @ApiModelProperty(value = "错误数量",example = "3")
    int failNum;
    @ApiModelProperty(value = "失败信息列表")
    List<DeviceBatchCreateFailedItem> failItems;
}
