package com.citc.iot.webdoc.controller.device.request;

import com.citc.iot.webdoc.common.enums.EDeviceSortType;
import lombok.Data;

@Data
public class GetDeviceListRequestObject
{
    EDeviceSortType sortType;
    Long projectId;
    Long deviceDesignId;
    String deviceName;
    int pageId;
}
