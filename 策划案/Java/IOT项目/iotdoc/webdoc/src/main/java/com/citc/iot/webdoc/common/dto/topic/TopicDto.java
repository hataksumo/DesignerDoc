package com.citc.iot.webdoc.common.dto.topic;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@ApiModel(value = "主题Dto")
public class TopicDto extends TopicListItemDto
{
    @ApiModelProperty(value = "订阅数",example = "3")
    int subscriberCnt;
    @ApiModelProperty(value = "创建时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime createTime;
    @ApiModelProperty(value = "主题地址",example = "www.ictc.com/topic/422352345615")
    String urn;
    @ApiModelProperty(value = "订阅列表")
    List<SubscriberDto> subscribers;
}
