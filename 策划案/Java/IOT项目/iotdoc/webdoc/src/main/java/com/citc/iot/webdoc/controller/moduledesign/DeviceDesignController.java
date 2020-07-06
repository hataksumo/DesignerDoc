package com.citc.iot.webdoc.controller.moduledesign;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.moduledesign.request.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * @author 织法酱
 */
@Api(tags = "产品模块")
@RestController
@RequestMapping("/DeviceDesign")
public class DeviceDesignController
{

    @ApiOperation(value = "获取产品列表")
    @RequestMapping(value = "/getDeviceDesignList",method = {RequestMethod.GET})
    public R getDeviceDesignList(@RequestParam Long pProjectId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建产品")
    @RequestMapping(value = "/createDeviceDesign", method = {RequestMethod.POST})
    public R createDeviceDesign(@RequestBody CreateDeviceDesignRequestObject pData, HttpServletRequest pReq)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取产品详细信息")
    @RequestMapping(value = "/getDeviceDesignDetil", method = {RequestMethod.GET})
    public R getDeviceDesignDetil(@RequestParam("id") Long pDeviceDesignId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取该产品下设备数量")
    @RequestMapping(value = "/getDeviceCnt", method = {RequestMethod.GET})
    public R getDeviceCnt(@RequestParam("id") long pDeviceDesignId)
    {
        return R.unImplemented();
    }


    @ApiOperation(value = "获取产品属性")
    @RequestMapping(value = "/getAttributes", method = {RequestMethod.GET})
    public R getAttributes(@RequestParam("id") Long pDeviceDesignId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "添加一个属性")
    @RequestMapping(value = "/addAttributeItem", method = {RequestMethod.POST})
    public R addAttributeItem(@RequestBody AddUpDataAttributeRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获得一个属性的详细信息")
    @RequestMapping(value = "/addAttributeItem", method = {RequestMethod.GET})
    public R getAttributeItem(@RequestParam("id") Long pDeviceDesignId,@RequestParam("name") String pName)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "编辑属性")
    @RequestMapping(value = "/editAttributeItem", method = {RequestMethod.POST})
    public R editAttributeItem(@RequestBody AddUpDataAttributeRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "删除属性")
    @RequestMapping(value = "/deleteAttributeItem", method = {RequestMethod.GET})
    public R deleteAttributeItem(@RequestParam("id") Long pDeviceDesignId,@RequestParam("name") String pName)
    {
        return R.unImplemented();
    }


    @ApiOperation(value = "获得命令列表")
    @RequestMapping(value = "/getCommandList", method = {RequestMethod.GET})
    public R getCommandList(@RequestParam("id") Long pDeviceDesignId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建一个命令")
    @RequestMapping(value = "/createCommand", method = {RequestMethod.POST})
    public R createCommand(CreateCommandRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获得一个命令的详细信息")
    @RequestMapping(value = "/getCommandDetail", method = {RequestMethod.GET})
    public R getCommandDetail(@RequestParam("id") Long pDeviceDesignId,@RequestParam("name") String pCmdName)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "为特定命令添加一个属性")
    @RequestMapping(value = "/addCommandAttribute", method = {RequestMethod.POST})
    public R addCommandAttribute(@RequestBody AddCmdAttributeRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获得一个命令的详细信息")
    @RequestMapping(value = "/getCmdAttributeItem", method = {RequestMethod.GET})
    public R getCmdAttributeItem(@RequestParam("id") Long pDeviceDesignId,
                                 @RequestParam("cmdName") String pCmdName,
                                 @RequestParam("attrName") String pAttrName)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "编辑一个命令属性")
    @RequestMapping(value = "/editCmdAttribute", method = {RequestMethod.POST})
    public R editCmdAttribute(@RequestBody CreateCommandRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "删除一个命令属性")
    @RequestMapping(value = "/deleteCmdAttributeItem", method = {RequestMethod.GET})
    public R deleteCmdAttributeItem(@RequestParam("id") Long pDeviceDesignId,
                                    @RequestParam("cmdName") String pCmdName,
                                    @RequestParam("attrName") String pAttrName)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "导出模型配置")
    @RequestMapping(value = "/outputConfig", method = {RequestMethod.GET})
    public R outputConfig(@RequestParam("id") Long pDeviceDesignId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "使用配置文件初始化")
    @RequestMapping(value = "/initWithConfig", method = {RequestMethod.POST})
    public R initWithConfig(@RequestBody InitWithConfigRequestObject pData)
    {
        return R.unImplemented();
    }

}
