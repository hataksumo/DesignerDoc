package com.citc.iot.webdoc.common.dataDefine;

import com.citc.iot.webdoc.common.enums.EAttributeType;
import lombok.Data;

@Data
public class Attribute
{
    String name;
    EAttributeType attrType;
    String description;
    AttributeConstraint constraint;
}
