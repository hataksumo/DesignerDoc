package com.citc.iot.webdoc.controller.moduleDesign.Request;

import com.citc.iot.webdoc.common.dataDefine.AttributeConstraint;
import com.citc.iot.webdoc.common.dataDefine.CommandAttribute;
import lombok.Data;

@Data
public class AddCmdAttributeRequestObject
{
    long deviceDesignId;
    String cmdName;
    CommandAttribute attribute;
    AttributeConstraint constraint;
}
