package com.citc.iot.webdoc.controller.device;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.device.request.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@Api(tags = "设备模块")
@RestController
@RequestMapping("/Device")
public class DeviceController
{
    @ApiOperation(value = "获取设备列表",notes = "支持项目筛选，产品筛选和设备模糊查询")
    @RequestMapping(value = "/GetDeviceList",method = {RequestMethod.POST,RequestMethod.GET})
    public R GetDeviceList(@RequestBody GetDeviceListRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建设备")
    @RequestMapping(value = "/CreateDevice",method = {RequestMethod.POST})
    public R CreateDevice(@RequestBody CreateSingleDeviceRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "使用配置文件创建设备")
    @RequestMapping(value = "/CreateDevicesByConfig",method = {RequestMethod.POST})
    public R CreateDevicesByConfig(@RequestBody CreateDevicesByCfgFileRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取设备详细信息")
    @RequestMapping(value = "/GetDeviceDetail",method = {RequestMethod.GET})
    public R GetDeviceDetail(@RequestParam(value = "deviceId") Long v_deviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取设备影子")
    @RequestMapping(value = "/GetDeviceShadow",method = {RequestMethod.GET})
    public R GetDeviceShadow(@RequestParam(value="deviceId") Long v_deviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "重置设备密码")
    @RequestMapping(value = "/ResetPassword",method = {RequestMethod.POST})
    public R ResetPassword(@RequestBody ResetDevicePasswordRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "向设备推送命令")
    @RequestMapping(value = "/PushCommand",method = {RequestMethod.POST})
    public R PushCommand(@RequestBody PushCommandRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "开启消息追踪")
    @RequestMapping(value = "/StartDeviceTrace",method = {RequestMethod.POST})
    public R StartDeviceTrace(StartDeviceTraceRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "清空消息追踪历史数据")
    @RequestMapping(value = "/StartDeviceTrace",method = {RequestMethod.GET})
    public R ClearDeviceTraceData(@RequestParam(value = "deviceId") Long v_deviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取消息追踪分页数据")
    @RequestMapping(value = "/GetTraceMessageList",method = {RequestMethod.GET})
    public R GetTraceMessageList(@RequestParam(value = "deviceId") Long v_deviceId,@RequestParam(value = "pageId") int v_pageId)
    {
        return R.unImplemented();
    }
}