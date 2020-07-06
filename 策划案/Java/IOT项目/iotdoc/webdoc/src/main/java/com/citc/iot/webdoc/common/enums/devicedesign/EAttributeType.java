package com.citc.iot.webdoc.common.enums.devicedesign;

/**
 * @author 织法酱
 */

@SuppressWarnings("ALL")
public enum EAttributeType
{
    /**
    * 字符串
    */
    STRING(1),
    /**
     * 整数
     */
    INTEGER(2),
    /**
     * 浮点数
     */
    DOUBLE(3);

    /**
    * 枚举值
    */
    int data;
    EAttributeType(int pData)
    {
        this.data = pData;
    }
}
