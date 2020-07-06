package com.citc.iot.webdoc.common.dto.project;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value= "项目Dto")
public class ProjectDto extends ProjectListItemDto
{
    @ApiModelProperty(value= "详细描述",example = "学校物联网系统，让物物相连，智能化教学管理")
    String description;
    @ApiModelProperty(value= "产品数量",example = "5")
    int deviceDesignNum;
    @ApiModelProperty(value= "设备数量",example = "50")
    int deviceNum;
    @ApiModelProperty(value= "群组数量",example = "8")
    int deviceGroupNum;
    @ApiModelProperty(value= "规则数量",example = "3")
    int ruleNum;
    @ApiModelProperty(value= "主题数量",example = "5")
    int topicNum;
}
