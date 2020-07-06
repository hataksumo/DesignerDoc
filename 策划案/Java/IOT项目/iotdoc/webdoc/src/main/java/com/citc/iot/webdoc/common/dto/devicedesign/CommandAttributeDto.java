package com.citc.iot.webdoc.common.dto.devicedesign;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value="命令属性Dto")
public class CommandAttributeDto extends AttributeDto
{
    @ApiModelProperty(value = "是否必要",example = "1必要，0不必要")
    int isNessasery;
}
