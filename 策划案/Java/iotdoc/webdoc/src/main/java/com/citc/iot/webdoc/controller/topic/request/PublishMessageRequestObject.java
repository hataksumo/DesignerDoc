package com.citc.iot.webdoc.controller.topic.request;

import lombok.Data;

@Data
public class PublishMessageRequestObject
{
    Long topicId;
    String title;
    String content;
}
