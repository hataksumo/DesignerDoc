package com.citc.iot.webdoc.controller.overview;

import com.citc.iot.webdoc.common.respond.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "总览")
@RestController
@RequestMapping("/overview")
public class overviewController
{
    @ApiOperation(value="获取各模块数量信息")
    @RequestMapping(value = "/getModuleInfo",method = {RequestMethod.GET})
    public R ShowOverview()
    {
        return R.unImplemented();
    }

    @ApiOperation(value="获取资源Id")
    @RequestMapping(value = "/GetResId",method = {RequestMethod.GET})
    public R GetResId(@RequestParam(value="id") long pId)
    {
        return R.unImplemented();
    }

}
