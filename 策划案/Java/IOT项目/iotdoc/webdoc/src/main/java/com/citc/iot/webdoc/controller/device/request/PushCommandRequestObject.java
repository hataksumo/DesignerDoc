package com.citc.iot.webdoc.controller.device.request;

import lombok.Data;

import java.util.Map;

@Data
public class PushCommandRequestObject
{
    Long debiceId;
    String data;
}
