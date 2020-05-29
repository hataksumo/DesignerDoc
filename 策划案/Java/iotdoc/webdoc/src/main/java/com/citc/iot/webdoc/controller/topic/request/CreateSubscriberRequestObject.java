package com.citc.iot.webdoc.controller.topic.request;

import com.citc.iot.webdoc.common.enums.ESubscribeProtocal;
import lombok.Data;

@Data
public class CreateSubscriberRequestObject
{
    Long TopicId;
    ESubscribeProtocal protocal;
    String endpointList;//;分隔
}
