package com.citc.iot.webdoc.common.dto.rules;

import com.citc.iot.webdoc.common.dto.devicedesign.DeviceDesignListItemDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel(value = "规则Dto")
public class RuleDto extends RuleListItemDto
{
    @ApiModelProperty(value = "产品列表")
    List<DeviceDesignListItemDto> produceDesigns;
    @ApiModelProperty(value = "规则条件集合")
    RuleConditionSetDto ruleConditionSet;
    @ApiModelProperty(value = "规则动作列表")
    List<RuleActionDto> ruleActions;
}
