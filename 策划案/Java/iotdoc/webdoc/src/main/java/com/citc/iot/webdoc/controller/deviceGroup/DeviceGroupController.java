package com.citc.iot.webdoc.controller.deviceGroup;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.deviceGroup.request.AddDeviceGroupRequestObject;
import com.citc.iot.webdoc.controller.deviceGroup.request.EditDeviceGroupRequestObject;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "设备群组模块")
@RestController
@RequestMapping("/DeviceGroup")
public class DeviceGroupController
{
    /*
    * 添加设备群组
    * */
    @ApiOperation(value = "创建群组")
    @RequestMapping(value = "/AddDeviceGroup",method = {RequestMethod.POST})
    public R AddDeviceGroup(@RequestBody AddDeviceGroupRequestObject v_data)
    {
        return R.unImplemented();
    }

    /*
    * 编辑设备群组详情
    * */
    @ApiOperation(value = "编辑设备群组详情")
    @RequestMapping(value ="/EditDeviceGroupDesc",method = {RequestMethod.POST})
    public R EditDeviceGroupDesc(@RequestBody EditDeviceGroupRequestObject v_data)
    {
        return R.unImplemented();
    }

    /*
    * 删除设备群组
    * */
    @ApiOperation(value = "删除设备群组")
    @RequestMapping(value ="/DeleteDeviceGroup",method = {RequestMethod.GET})
    public R DeleteDeviceGroup(@RequestParam("id") Long v_id)
    {
        return R.unImplemented();
    }

    /*
    * 获取群组信息
    * */
    @ApiOperation(value = "获取群组信息")
    @RequestMapping(value ="/GetGroupInfo",method = {RequestMethod.GET})
    public R GetGroupInfo(@RequestParam("id")  Long v_id)
    {
        return R.unImplemented();
    }

    /*
    * 绑定设备
    * */
    @ApiOperation(value = "绑定设备")
    @RequestMapping(value ="/BindDevices",method = {RequestMethod.POST})
    public R BindDevices(@RequestBody List<Long> v_ids)
    {
        return R.unImplemented();
    }

    /*
    * 绑定规则
    * */
    @ApiOperation(value = "绑定规则")
    @RequestMapping(value ="/BindRules",method = {RequestMethod.POST})
    public R BindRules(@RequestBody List<Long> v_ids)
    {
        return R.unImplemented();
    }

    /*
    * 获取当前群组适用的规则(包括父群组的规则，必须激活态)
    * */
    @ApiOperation(value = "获取当前群组适用的规则(包括父群组的规则，必须激活态)")
    @RequestMapping(value ="/GetActiveRules",method = {RequestMethod.GET})
    public R GetActiveRules(@RequestParam("id") Long v_id)
    {
        return R.unImplemented();
    }

    /*
    * 获取设备列表,包括子群组
    * */
    @ApiOperation(value = "获取设备列表,包括子群组")
    @RequestMapping(value ="/GetDeviceList",method = {RequestMethod.GET})
    public R GetDeviceList(@RequestParam("id") Long v_id,@RequestParam("pageId") int v_pageId)
    {
        return R.unImplemented();
    }
}
