package com.citc.iot.webdoc.controller.moduleDesign;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.moduleDesign.Request.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Api(tags = "产品模块")
@RestController
@RequestMapping("/DeviceDesign")
public class DeviceDesignController
{
    /*
    * 获取产品列表
    * */
    @ApiOperation(value = "获取产品列表")
    @RequestMapping(value = "/GetDeviceDesignList",method = {RequestMethod.GET})
    public R GetDeviceDesignList(@RequestParam Long v_projectId)
    {
        return R.unImplemented();
    }
    /*
    * 创建产品
    * */
    @ApiOperation(value = "创建产品")
    @RequestMapping(value = "/CreateDeviceDesign", method = {RequestMethod.POST})
    public R CreateDeviceDesign(@RequestBody CreateDeviceDesignRequestObject v_data, HttpServletRequest v_req)
    {
        return R.unImplemented();
    }
    /*
    * 获取产品详细信息
    * */
    @ApiOperation(value = "获取产品详细信息")
    @RequestMapping(value = "/GetDeviceDesignDetil", method = {RequestMethod.GET})
    public R GetDeviceDesignDetil(@RequestParam("id") Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
     * 获取设备数量
     * */
    @ApiOperation(value = "获取该产品下设备数量")
    @RequestMapping(value = "/GetDeviceCnt", method = {RequestMethod.GET})
    public R GetDeviceCnt(@RequestParam("id") long v_deviceDesignId)
    {
        return R.unImplemented();
    }

    /*
    * 获得产品属性
    * */
    @ApiOperation(value = "获取产品属性")
    @RequestMapping(value = "/GetAttributes", method = {RequestMethod.GET})
    public R GetAttributes(@RequestParam("id") Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
    * 添加一个属性
    * */
    @ApiOperation(value = "添加一个属性")
    @RequestMapping(value = "/AddAttributeItem", method = {RequestMethod.POST})
    public R AddAttributeItem(@RequestBody AddUpDataAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获得一个属性的详细信息
    * */
    @ApiOperation(value = "获得一个属性的详细信息")
    @RequestMapping(value = "/AddAttributeItem", method = {RequestMethod.GET})
    public R GetAttributeItem(@RequestParam("id") Long v_deviceDesignId,@RequestParam("name") String v_name)
    {
        return R.unImplemented();
    }
    /*
    * 编辑属性
    * */
    @ApiOperation(value = "编辑属性")
    @RequestMapping(value = "/EditAttributeItem", method = {RequestMethod.POST})
    public R EditAttributeItem(@RequestBody AddUpDataAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 删除属性
    * */
    @ApiOperation(value = "删除属性")
    @RequestMapping(value = "/DeleteAttributeItem", method = {RequestMethod.GET})
    public R DeleteAttributeItem(@RequestParam("id") Long v_deviceDesignId,@RequestParam("name") String v_name)
    {
        return R.unImplemented();
    }

    /*
    * 获得命令列表
    * */
    @ApiOperation(value = "获得命令列表")
    @RequestMapping(value = "/GetCommandList", method = {RequestMethod.GET})
    public R GetCommandList(@RequestParam("id") Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
    * 创建一个命令
    * */
    @ApiOperation(value = "创建一个命令")
    @RequestMapping(value = "/CreateCommand", method = {RequestMethod.POST})
    public R CreateCommand(CreateCommandRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获得一个命令的详细信息
    * */
    @ApiOperation(value = "获得一个命令的详细信息")
    @RequestMapping(value = "/GetCommandDetail", method = {RequestMethod.GET})
    public R GetCommandDetail(@RequestParam("id") Long v_deviceDesignId,@RequestParam("name") String v_cmdName)
    {
        return R.unImplemented();
    }

    /*
    * 为特定命令添加一个属性
    * */
    @ApiOperation(value = "为特定命令添加一个属性")
    @RequestMapping(value = "/AddCommandAttribute", method = {RequestMethod.POST})
    public R AddCommandAttribute(@RequestBody AddCmdAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获取一个命令属性的详细信息
    * */
    @ApiOperation(value = "获得一个命令的详细信息")
    @RequestMapping(value = "/GetCmdAttributeItem", method = {RequestMethod.GET})
    public R GetCmdAttributeItem(@RequestParam("id") Long v_deviceDesignId,
                                 @RequestParam("cmdName") String v_cmdName,
                                 @RequestParam("attrName") String v_attrName)
    {
        return R.unImplemented();
    }

    /*
    * 编辑一个命令属性
    * */
    @ApiOperation(value = "编辑一个命令属性")
    @RequestMapping(value = "/EditCmdAttribute", method = {RequestMethod.POST})
    public R EditCmdAttribute(@RequestBody CreateCommandRequestObject v_data)
    {
        return R.unImplemented();
    }

    /*
    * 删除一个命令属性
    * */
    @ApiOperation(value = "删除一个命令属性")
    @RequestMapping(value = "/DeleteCmdAttributeItem", method = {RequestMethod.GET})
    public R DeleteCmdAttributeItem(@RequestParam("id") Long v_deviceDesignId,
                                    @RequestParam("cmdName") String v_cmdName,
                                    @RequestParam("attrName") String v_attrName)
    {
        return R.unImplemented();
    }
    /*
    * 导出模型配置
    * */
    @ApiOperation(value = "导出模型配置")
    @RequestMapping(value = "/OutputConfig", method = {RequestMethod.GET})
    public R OutputConfig(@RequestParam("id") Long v_deviceDesignId)
    {
        return R.unImplemented();
    }

    /*
    * 使用配置文件初始化
    * */
    @ApiOperation(value = "使用配置文件初始化")
    @RequestMapping(value = "/InitWithConfig", method = {RequestMethod.POST})
    public R InitWithConfig(@RequestBody InitWithConfigRequestObject v_data)
    {
        return R.unImplemented();
    }

}
