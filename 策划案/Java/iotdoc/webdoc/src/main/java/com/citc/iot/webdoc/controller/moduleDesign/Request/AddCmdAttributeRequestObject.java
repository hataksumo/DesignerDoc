package com.citc.iot.webdoc.controller.moduledesign.request;

import com.citc.iot.webdoc.common.dto.devicedesign.AttributeConstraintDto;
import com.citc.iot.webdoc.common.dto.devicedesign.CommandAttributeDto;
import lombok.Data;

/**
 * @author 织法酱
 */
@Data
public class AddCmdAttributeRequestObject
{
    long deviceDesignId;
    String cmdName;
    CommandAttributeDto attribute;
    AttributeConstraintDto constraint;
}
