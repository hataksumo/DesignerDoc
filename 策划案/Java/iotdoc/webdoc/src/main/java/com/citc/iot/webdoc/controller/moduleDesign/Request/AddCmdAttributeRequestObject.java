package com.citc.iot.webdoc.controller.moduledesign.Request;

import com.citc.iot.webdoc.common.dto.devicedesign.AttributeConstraintDto;
import com.citc.iot.webdoc.common.dto.devicedesign.CommandAttributeDto;
import lombok.Data;

@Data
public class AddCmdAttributeRequestObject
{
    long deviceDesignId;
    String cmdName;
    CommandAttributeDto attribute;
    AttributeConstraintDto constraint;
}
