package com.citc.iot.webdoc.common.dto.topic;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "主题列表项")
public class TopicListItemDto
{
    @ApiModelProperty(value = "主题Id",example = "64位整数")
    Long id;
    @ApiModelProperty(value = "主题逻辑名",example = "dropBroadcast")
    String name;
    @ApiModelProperty(value = "主题显示名",example = "广播")
    String showName;
}
