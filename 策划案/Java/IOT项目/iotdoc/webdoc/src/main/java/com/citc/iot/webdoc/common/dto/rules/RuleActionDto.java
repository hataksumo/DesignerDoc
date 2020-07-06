package com.citc.iot.webdoc.common.dto.rules;

import com.citc.iot.webdoc.common.enums.rule.ERuleActionType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Map;

@Data
@ApiModel(value = "规则动作DTO")
public class RuleActionDto
{
    @ApiModelProperty(value = "动作类型",example = "1 发送命令，2 发送主题消息")
    ERuleActionType ruleActionType;
    @ApiModelProperty(value = "产品Id",example = "64位整数")
    Long deviceDesignId;
    @ApiModelProperty(value = "动作名称",example = "嗑药")
    String actionName;
    @ApiModelProperty(value = "动作参数",example = "键值对")
    Map<String,Object> params;
    @ApiModelProperty(value = "主题Id",example = "键值对")
    Long topicId;
    @ApiModelProperty(value = "主题标题",example = "残血嗑药通知")
    String topicTitle;
    @ApiModelProperty(value = "主题内容",example = "尊敬的用户，系统检测到您血量低于20%，将为你自动嗑药")
    String topicContent;
}
