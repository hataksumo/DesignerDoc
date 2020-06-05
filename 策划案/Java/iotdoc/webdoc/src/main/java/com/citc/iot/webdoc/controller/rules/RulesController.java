package com.citc.iot.webdoc.controller.rules;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.rules.request.CreateRuleRequestObject;
import com.citc.iot.webdoc.controller.rules.request.EditRuleRequestObject;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@RestController
@Api(tags = "规则模块")
@RequestMapping("/Rules")
public class RulesController
{
    @ApiOperation(value = "获取规则列表",notes = "根据项目Id获取规则列表")
    @RequestMapping(value = "/getRuleList",method = {RequestMethod.GET})
    public R getRuleList(@RequestParam("projectId") Long pProjectId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "启用规则")
    @RequestMapping(value = "/enableRule",method = {RequestMethod.GET})
    public R enableRule(@RequestParam("ruleId") Long pRuleId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "禁用规则")
    @RequestMapping(value = "/disableRule",method = {RequestMethod.GET})
    public R disableRule(@RequestParam("ruleId") Long pRuleId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取规则信息")
    @RequestMapping(value = "/getRuleDetail",method = {RequestMethod.GET})
    public R getRuleDetail(@RequestParam("ruleId") Long pRuleId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取规则条件")
    @RequestMapping(value = "/getRuleConditions",method = {RequestMethod.GET})
    public R getRuleConditions(@RequestParam("ruleId") Long pRuleId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取规则动作")
    @RequestMapping(value = "/getRuleActions",method = {RequestMethod.GET})
    public R getRuleActions(@RequestParam("ruleId") Long pRuleId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建规则")
    @RequestMapping(value = "/createRule",method = {RequestMethod.POST})
    public R createRule(@RequestBody CreateRuleRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "编辑规则")
    @RequestMapping(value = "/editRule",method = {RequestMethod.POST})
    public R editRule(@RequestBody EditRuleRequestObject pData)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "删除条件")
    @RequestMapping(value = "/deleteCondition",method = {RequestMethod.GET})
    public R deleteCondition(@RequestParam("ruleId") Long pRuleId,@RequestParam("loc") int pLoc)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "删除动作")
    @RequestMapping(value = "/deleteAction",method = {RequestMethod.GET})
    public R deleteAction(@RequestParam("ruleId") Long pRuleId,@RequestParam("loc") int pLoc)
    {
        return R.unImplemented();
    }
}
