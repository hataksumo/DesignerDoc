package com.citc.iot.webdoc.controller.moduleDesign;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.moduleDesign.Request.AddCmdAttributeRequestObject;
import com.citc.iot.webdoc.controller.moduleDesign.Request.AddUpDataAttributeRequestObject;
import com.citc.iot.webdoc.controller.moduleDesign.Request.CreateCommandRequestObject;
import com.citc.iot.webdoc.controller.moduleDesign.Request.CreateDeviceDesignRequestObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/DeviceDesign")
public class DeviceDesignController
{
    /*
    * 获取产品列表
    * */
    public R GetDeviceDesignList(Long v_projectId)
    {
        return R.unImplemented();
    }
    /*
    * 创建产品
    * */
    public R CreateDeviceDesign(CreateDeviceDesignRequestObject v_data, HttpServletRequest v_req)
    {
        return R.unImplemented();
    }
    /*
    * 获取产品详细信息
    * */
    public R GetDeviceDesignDetil(Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
     * 获取设备数量
     * */
    public R GetDeviceCnt(long v_deviceDesignId)
    {
        return R.unImplemented();
    }

    /*
    * 获得产品属性
    * */
    public R GetAttributes(Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
    * 添加一个属性
    * */
    public R AddAttributeItem(AddUpDataAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获得一个属性的详细信息
    * */
    public R GetAttributeItem(Long v_deviceDesignId,String v_name)
    {
        return R.unImplemented();
    }
    /*
    * 编辑属性
    * */
    public R EditAttributeItem(AddUpDataAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 删除属性
    * */
    public R DeleteAttributeItem(Long v_deviceDesignId,String v_attrName)
    {
        return R.unImplemented();
    }

    /*
    * 获得命令列表
    * */
    public R GetCommandList(Long v_deviceDesignId)
    {
        return R.unImplemented();
    }
    /*
    * 创建一个命令
    * */
    public R CreateCommand(CreateCommandRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获得一个命令的详细信息
    * */
    public R GetCommandDetail(Long v_deviceDesignId,String v_cmdName)
    {
        return R.unImplemented();
    }

    /*
    * 为特定命令添加一个属性
    * */
    public R AddCommandAttribute(AddCmdAttributeRequestObject v_data)
    {
        return R.unImplemented();
    }
    /*
    * 获取一个命令属性的详细信息
    * */
    public R GetCmdAttributeItem(String v_attrName)
    {
        return R.unImplemented();
    }

    /*
    * 编辑一个命令属性
    * */
    public R EditCmdAttribute(CreateCommandRequestObject v_data)
    {
        return R.unImplemented();
    }

    /*
    * 删除一个命令属性
    * */
    public R DeleteCmdAttributeItem(Long v_deviceDesignId,String v_cmdName,String v_attrName)
    {
        return R.unImplemented();
    }
    /*
    * 导出模型配置
    * */
    public R OutputConfig(Long v_deviceDesignId)
    {
        return R.unImplemented();
    }

    /*
    * 使用配置文件初始化
    * */
    public R InitWithConfig(Long v_deviceDesignId,String v_config)
    {
        return R.unImplemented();
    }

}
