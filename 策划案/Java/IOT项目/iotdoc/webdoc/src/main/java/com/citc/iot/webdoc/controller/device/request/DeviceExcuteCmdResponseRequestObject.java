package com.citc.iot.webdoc.controller.device.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Map;


@Data
@ApiModel(value = "设备执行命令回执请求")
public class DeviceExcuteCmdResponseRequestObject
{
    @ApiModelProperty(value = "响应码",example = "200")
    int code;
    @ApiModelProperty(value = "回执信息",example = "成功")
    String message;
    @ApiModelProperty(value = "回执参数")
    Map<String,Object> data;
}
