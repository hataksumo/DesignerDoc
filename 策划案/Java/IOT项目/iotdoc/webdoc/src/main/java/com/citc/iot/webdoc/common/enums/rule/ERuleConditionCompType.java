package com.citc.iot.webdoc.common.enums.rule;

public enum ERuleConditionCompType
{
    GT(">"),
    GTEQ(">="),
    EQ("="),
    LTEQ("<="),
    LT("<"),
    SEQ("s=");
    String op;
    ERuleConditionCompType(String v_op)
    {
        this.op = v_op;
    }
}
