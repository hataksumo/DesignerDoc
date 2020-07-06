package com.citc.iot.webdoc.controller.topic.request;

import com.citc.iot.webdoc.common.enums.topic.ESubscribeProtocol;
import com.citc.iot.webdoc.common.enums.topic.ESubscribeStatus;
import lombok.Data;

@Data
public class GetSubscribeListRequestObject
{
    int pageId;
    String searchStr;
    ESubscribeStatus status;
    ESubscribeProtocol protocal;
}
