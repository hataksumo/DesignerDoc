package com.citc.iot.webdoc.controller.rules.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "创建规则请求对象")
public class CreateRuleRequestObject
{
    @ApiModelProperty(value="项目Id",example = "64位二进制数")
    Long projectId;
    @ApiModelProperty(value="规则名称",example = "eatBottle")
    String name;
    @ApiModelProperty(value="描述",example = "如果血量低于20%，通知用户吃药")
    String description;
}
