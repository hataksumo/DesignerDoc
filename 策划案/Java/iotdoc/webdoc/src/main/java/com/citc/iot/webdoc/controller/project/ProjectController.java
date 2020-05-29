package com.citc.iot.webdoc.controller.project;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.project.request.CreateProjectRequestObject;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@Api(tags = "项目模块")
@RestController
@RequestMapping("/projectView")
public class ProjectController
{
    @ApiOperation(value = "获取各子模块数量信息")
    @RequestMapping(value = "/getResItemsView",method = {RequestMethod.GET})
    public R getResItemsView(@RequestParam(value="id") Long v_id)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建项目")
    @RequestMapping(value = "/createProject",method = {RequestMethod.POST})
    public R createProject(@RequestBody CreateProjectRequestObject v_data)
    {
        return R.unImplemented();
    }

}
