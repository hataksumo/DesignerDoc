package com.citc.iot.webdoc.common.dto.rules;

import com.citc.iot.webdoc.common.enums.rule.ERuleActionType;
import com.citc.iot.webdoc.common.enums.rule.ERuleStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "规则列表项Dto")
public class RuleListItemDto
{
    @ApiModelProperty(value = "id",example = "64位整数")
    Long id;
    @ApiModelProperty(value = "规则状态",example = "1表示生效，0表示禁用")
    ERuleStatus status;
    @ApiModelProperty(value = "规则名称",example = "残血嗑药")
    String ruleName;
    @ApiModelProperty(value = "规则名称",example = "残血嗑药")
    String description;
}
