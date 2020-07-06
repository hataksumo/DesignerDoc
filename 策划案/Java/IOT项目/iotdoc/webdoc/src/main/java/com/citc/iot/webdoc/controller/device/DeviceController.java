package com.citc.iot.webdoc.controller.device;

import com.citc.iot.webdoc.common.dto.device.*;
import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.device.request.*;
import com.citc.iot.webdoc.controller.device.response.DeviceBatchCreateResponseObject;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;

/**
 * @author 织法酱
 */
@Api(tags = "设备模块")
@RestController
@RequestMapping("/Device")
public class DeviceController
{
    @ApiOperation(value = "获取设备列表",notes = "支持项目筛选，产品筛选和设备模糊查询")
    @ApiResponses({
            @ApiResponse(response = DeviceListDto.class,code=200,message = "请求成功,返回设备列表信息"),
            @ApiResponse(code=201,message = "请求失败，token过期或不合法，请重新登录")
            })
    @RequestMapping(value = "/GetDeviceList",method = {RequestMethod.POST,RequestMethod.GET})
    public R GetDeviceList(@RequestBody GetDeviceListRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建设备")
    @ApiResponses({
            @ApiResponse(code=200,message = "请求成功,返回设备列表信息"),
            @ApiResponse(code=201,message = "创建设备失败，设备名已被占用"),
            @ApiResponse(code=202,message = "表单不合法"),
    })
    @RequestMapping(value = "/CreateDevice",method = {RequestMethod.POST})
    @ApiResponse(response = DeviceListDto.class,code=200,message = "创建设备")
    public R CreateDevice(@RequestBody CreateSingleDeviceRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "使用配置文件创建设备")
    @RequestMapping(value = "/CreateDevicesByConfig",method = {RequestMethod.POST})
    @ApiResponses({
            @ApiResponse(response = DeviceBatchCreateResponseObject.class,code=200,message = "请求成功,返回设备列表信息"),
            @ApiResponse(code=201,message = "文件格式有误")
    })
    public R CreateDevicesByConfig(@RequestBody CreateDevicesByCfgFileRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取设备详细信息")
    @RequestMapping(value = "/GetDeviceDetail",method = {RequestMethod.GET})
    @ApiResponses({
            @ApiResponse(response = DeviceDto.class,code=200,message = "请求成功,返回设备信息"),
            @ApiResponse(code=201,message = "没有找到该设备的Id")
    })
    public R GetDeviceDetail(@RequestParam(value = "deviceId") Long pDeviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取设备影子")
    @RequestMapping(value = "/GetDeviceShadow",method = {RequestMethod.GET})
    @ApiResponses({
            @ApiResponse(response = DeviceShadowDto.class,code=200,message = "请求成功,返回设备信息"),
            @ApiResponse(code=201,message = "没有找到该设备的Id")
    })
    public R GetDeviceShadow(@RequestParam(value="deviceId") Long pDeviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "重置设备密码")
    @RequestMapping(value = "/ResetPassword",method = {RequestMethod.POST})
    @ApiResponses({
            @ApiResponse(code=200,message = "成功重置秘钥"),
    })
    public R ResetPassword(@RequestBody ResetDevicePasswordRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "向设备推送命令")
    @RequestMapping(value = "/PushCommand",method = {RequestMethod.POST})
    @ApiResponses({
            @ApiResponse(code=200,message = "命令已进入缓存"),
    })
    public R PushCommand(@RequestBody PushCommandRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "设备命令回执")
    @RequestMapping(value = "/ReplayForCommand",method = {RequestMethod.POST})
    @ApiResponses({
            @ApiResponse(code=200,message = "收到设备回执"),
    })
    public R ReplayForCommand(@RequestBody DeviceExcuteCmdResponseRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "开启消息追踪")
    @RequestMapping(value = "/StartDeviceTrace",method = {RequestMethod.POST})
    @ApiResponses({
            @ApiResponse(code=200,message = "开启消息追踪成功"),
    })
    public R StartDeviceTrace(StartDeviceTraceRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "清空消息追踪历史数据")
    @RequestMapping(value = "/StartDeviceTrace",method = {RequestMethod.GET})
    @ApiResponses({
            @ApiResponse(code=200,message = "清空消息追踪历史数据成功"),
    })
    public R ClearDeviceTraceData(@RequestParam(value = "deviceId") Long pDeviceId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取消息追踪分页数据")
    @RequestMapping(value = "/GetTraceMessageList",method = {RequestMethod.GET})
    @ApiResponses({
            @ApiResponse(response = MessageTraceListDto.class,code=200,message = "成功获取消息追踪数据"),
    })
    public R GetTraceMessageList(@RequestParam(value = "deviceId") Long pDeviceId,@RequestParam(value = "pageId") int v_pageId)
    {
        return R.unImplemented();
    }
}