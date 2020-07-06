package com.citc.iot.webdoc.common.dto.device;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @author 织法酱
 */
@ApiModel(value = "消息追踪列表")
public class MessageTraceListDto
{
    @ApiModelProperty(value = "分页Id",example = "2")
    int pageId;
    @ApiModelProperty(value = "分页数据")
    List<MessageTraceDto> data;
}
