package com.citc.iot.webdoc.controller.overview;

import com.citc.iot.webdoc.common.respond.R;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/overview")
public class overviewController
{
    @RequestMapping(value = "getModuleInfo",method = {RequestMethod.GET})
    public R ShowOverview()
    {
        return R.unImplemented();
    }

    @RequestMapping(value = "GetResId",method = {RequestMethod.GET})
    public R GetResId(@RequestParam(value="id") long v_id)
    {
        return R.unImplemented();
    }

}
