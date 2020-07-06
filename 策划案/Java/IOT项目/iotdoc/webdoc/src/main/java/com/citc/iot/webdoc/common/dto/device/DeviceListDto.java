package com.citc.iot.webdoc.common.dto.device;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @author 织法酱
 */
@Data
@ApiModel(value = "设备列表")
public class DeviceListDto
{
    @ApiModelProperty(value = "分页Id",example = "1")
    int pageId;
    @ApiModelProperty(value = "分页列表数组数据")
    List<DeviceListItemDto> datas;
}
