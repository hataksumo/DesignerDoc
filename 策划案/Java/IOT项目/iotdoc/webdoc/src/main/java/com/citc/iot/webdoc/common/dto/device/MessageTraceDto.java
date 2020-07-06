package com.citc.iot.webdoc.common.dto.device;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel(value="消息追踪DTO")
public class MessageTraceDto
{
    @ApiModelProperty(value = "id",example = "顺序整数")
    Long id;
    @ApiModelProperty(value = "节点类型",example = "直连设备")
    String nodeType;
    @ApiModelProperty(value = "消息时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime msgTime;
    @ApiModelProperty(value = "数据")
    String data;
}
