package com.citc.iot.webdoc.controller.moduledesign.request;

import com.citc.iot.webdoc.common.dto.devicedesign.AttributeDto;
import com.citc.iot.webdoc.common.dto.devicedesign.AttributeConstraintDto;
import lombok.Data;

@Data
public class AddUpDataAttributeRequestObject
{
    long deviceDesignId;
    AttributeDto attribute;
    AttributeConstraintDto constraint;
}
