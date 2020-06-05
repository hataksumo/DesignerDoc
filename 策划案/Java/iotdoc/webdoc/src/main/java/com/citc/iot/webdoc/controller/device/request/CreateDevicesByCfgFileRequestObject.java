package com.citc.iot.webdoc.controller.device.request;

import com.citc.iot.webdoc.common.enums.device.EDupIdHandle;
import lombok.Data;

@Data
public class CreateDevicesByCfgFileRequestObject
{
    Long device;
    String cfgFile;
    EDupIdHandle dupHandle;
}
