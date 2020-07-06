package com.citc.iot.webdoc.common.dto.topic;

import com.citc.iot.webdoc.common.enums.topic.ESubscribeProtocol;
import com.citc.iot.webdoc.common.enums.topic.ESubscribeStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "订阅Dtp")
public class SubscriberDto
{
    @ApiModelProperty(value="主题Id",example = "64位整数")
    Long id;
    @ApiModelProperty(value="主题资源路径",example = "www.ictc.com/topic/422352345615")
    String urn;
    @ApiModelProperty(value="订阅协议",example = "1 短信，2 邮件，3 http，4 https")
    ESubscribeProtocol protocol;
    @ApiModelProperty(value="订阅终端地址",example = "10.12.231.16/Java/dropInfo")
    String endPoint;
    @ApiModelProperty(value="订阅状态",example = "1 已确认，2 未确认")
    ESubscribeStatus status;
}
