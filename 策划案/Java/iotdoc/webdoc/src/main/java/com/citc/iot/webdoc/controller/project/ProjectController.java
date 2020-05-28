package com.citc.iot.webdoc.controller.project;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.project.request.CreateProjectRequestObject;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/projectView")
public class ProjectController
{
    @RequestMapping(value = "/getResItemsView",method = {RequestMethod.GET})
    public R getResItemsView(@RequestParam(value="id") Long v_id)
    {
        return R.unImplemented();
    }

    @RequestMapping(value = "/createProject",method = {RequestMethod.POST})
    public R createProject(@RequestBody CreateProjectRequestObject v_data)
    {
        return R.unImplemented();
    }

}
