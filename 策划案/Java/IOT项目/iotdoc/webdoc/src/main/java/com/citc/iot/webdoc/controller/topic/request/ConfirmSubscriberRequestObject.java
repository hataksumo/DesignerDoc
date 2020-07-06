package com.citc.iot.webdoc.controller.topic.request;

import lombok.Data;

import java.util.List;

@Data
public class ConfirmSubscriberRequestObject
{
    List<Long> subscribeList;
}
