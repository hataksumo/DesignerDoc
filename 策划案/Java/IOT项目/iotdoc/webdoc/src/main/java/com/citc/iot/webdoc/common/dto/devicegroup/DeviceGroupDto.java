package com.citc.iot.webdoc.common.dto.devicegroup;

import java.time.LocalDateTime;
import java.util.List;

import com.citc.iot.webdoc.common.dto.rules.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value="设备群组")
public class DeviceGroupDto extends DeviceGroupNodeDto
{
    @ApiModelProperty(value="子群组数量",example = "5")
    int subGroupCnt;
    @ApiModelProperty(value="群组下设备数量",example = "107")
    int deviceCnt;
    @ApiModelProperty(value="创建时间",example = "2020/05/14 17:33：54 GMT+08：00")
    LocalDateTime createTime;
    @ApiModelProperty(value="描述",example = "小明家的空调系统")
    String description;
    @ApiModelProperty(value="规则列表")
    List<RuleListItemDto> bindRules;
}
