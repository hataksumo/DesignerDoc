package com.citc.iot.webdoc.controller.topic;

import com.citc.iot.webdoc.common.respond.R;
import com.citc.iot.webdoc.controller.topic.request.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@Api(tags="主题模块")
@RestController
@RequestMapping("/Topic")
public class TopicController
{
    @ApiOperation(value = "获取主题列表")
    @RequestMapping(value = "/getTopicList",method = {RequestMethod.GET})
    public R getTopicList(@RequestParam("pageId") GetTopicListRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取主题列表")
    @RequestMapping(value = "/getTopicList",method = {RequestMethod.POST})
    public R createTopic(@RequestBody CreateTopicRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建订阅")
    @RequestMapping(value = "/createSubscriber",method = {RequestMethod.POST})
    public R createSubscriber(@RequestBody CreateSubscriberRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "创建订阅")
    @RequestMapping(value = "/deleteTopic",method = {RequestMethod.GET})
    public R deleteTopic(@RequestParam("id") Long v_id)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "发布消息")
    @RequestMapping(value = "/publishMessage",method = {RequestMethod.POST})
    public R publishMessage(@RequestBody PublishMessageRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取订阅列表")
    @RequestMapping(value = "/getSubscriberList",method = {RequestMethod.GET})
    public R getSubscriberList(@RequestParam GetSubscribeListRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "删除订阅")
    @RequestMapping(value = "/deleteSubscribe",method = {RequestMethod.GET})
    public R deleteSubscribe(@RequestParam("subscribeId") Long v_subscribeId)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "确认订阅")
    @RequestMapping(value = "/confirmSubscriber",method = {RequestMethod.POST})
    public R confirmSubscriber(@RequestBody ConfirmSubscriberRequestObject v_data)
    {
        return R.unImplemented();
    }

    @ApiOperation(value = "获取主题详情")
    @RequestMapping(value = "/getTopicDetial",method = {RequestMethod.POST})
    public R getTopicDetial(@RequestParam("id") Long v_id)
    {
        return R.unImplemented();
    }
}
