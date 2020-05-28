package com.citc.iot.webdoc.controller.moduleDesign.Request;

import com.citc.iot.webdoc.common.dataDefine.Attribute;
import com.citc.iot.webdoc.common.dataDefine.AttributeConstraint;
import lombok.Data;

@Data
public class AddUpDataAttributeRequestObject
{
    long deviceDesignId;
    Attribute attribute;
    AttributeConstraint constraint;
}
