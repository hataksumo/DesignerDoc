package com.citc.iot.webdoc.controller.device.response;

import com.citc.iot.webdoc.common.enums.device.EDeviceCreateCode;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.Data;

@Data
@ApiModel(value = "设备批量创建错误项")
public class DeviceBatchCreateFailedItem
{
    @ApiModelProperty(value="设备用户名",example = "device_1")
    String userName;
    @ApiModelProperty(value="错误码",example = "0表示成功，1表示Id重复,2表示内容错误")
    EDeviceCreateCode errCode;
    @ApiModelProperty(value="错误信息",example = "设备Id重复")
    String errMsg;
}
