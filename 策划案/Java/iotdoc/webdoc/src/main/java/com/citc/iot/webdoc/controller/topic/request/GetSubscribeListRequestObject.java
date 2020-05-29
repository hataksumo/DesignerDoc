package com.citc.iot.webdoc.controller.topic.request;

import com.citc.iot.webdoc.common.enums.ESubscribeProtocal;
import com.citc.iot.webdoc.common.enums.ESubscribeStatus;
import lombok.Data;

@Data
public class GetSubscribeListRequestObject
{
    int pageId;
    String searchStr;
    ESubscribeStatus status;
    ESubscribeProtocal protocal;
}
