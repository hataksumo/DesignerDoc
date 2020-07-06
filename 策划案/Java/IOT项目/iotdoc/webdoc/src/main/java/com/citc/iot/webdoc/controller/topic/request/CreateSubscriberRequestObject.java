package com.citc.iot.webdoc.controller.topic.request;

import com.citc.iot.webdoc.common.enums.topic.ESubscribeProtocol;
import lombok.Data;

@Data
public class CreateSubscriberRequestObject
{
    Long TopicId;
    ESubscribeProtocol protocal;
    String endpointList;//;分隔
}
