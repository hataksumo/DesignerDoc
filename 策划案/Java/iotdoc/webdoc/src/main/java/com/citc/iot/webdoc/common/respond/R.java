package com.citc.iot.webdoc.common.respond;

import com.alibaba.fastjson.JSON;
import com.citc.iot.webdoc.common.utils.Utils;

import java.util.HashMap;
import java.util.Map;

public class R extends HashMap<String, Object> {

    private static final long serialVersionUID = 1L;

    public R() {
        put("code", RCode.API_CODE_CALL_SUCCESS);
        put("message", "操作成功");
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

    public boolean isOk() {
        return this.get("code").equals(RCode.CHECK_DATA_OK);
    }

    public boolean isSuccess() {
        return this.get("code").equals(RCode.API_CODE_CALL_SUCCESS);
    }

    public static R error() {
        return error(RCode.API_CODE_CALL_ERROR, "操作失败");
    }

    public static R error(String message) {
        return error(RCode.API_CODE_CALL_ERROR, message);
    }

    public static R error(int code, String message) {
        R r = new R();
        r.put("code", code);
        r.put("message", message);
        return r;
    }

    public static R error(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }

    public static R error(int code) {
        R r = new R();
        r.put("code", code);
        r.put("message", "");
        return r;
    }

    public static R ok(String message) {
        R r = new R();
        r.put("message", message);
        return r;
    }

    public static R logicFailed(int v_errCode, String v_failedMsg) {
        R r = new R();
        r.put("code", RCode.API_CODE_CALL_Login_Fail);
        r.put("errCode", v_errCode);
        r.put("message", v_failedMsg);
        return r;
    }

    public static R logicFailed(String v_failedMsg) {
        R r = new R();
        r.put("code", RCode.API_CODE_CALL_Login_Fail);
        r.put("message", v_failedMsg);
        return r;
    }


    public static R unImplemented() {
        R r = new R();
        r.put("code", RCode.API_CODE_CALL_UNIMPLEMENTED);
        r.put("message", "没有实现");
        return r;
    }

    public static R ok(Map<String, Object> map) {
        R r = new R();
        r.putAll(map);
        return r;
    }

    public static <T> R okForObject(T v_obj) {
        R r = new R();
        Map<String, Object> mp = Utils.beanToMap(v_obj);
        r.putAll(mp);
        return r;
    }

    public static R ok() {
        return new R();
    }

    @Override
    public R put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public static R buildEmptyR(String message) {
        R r = new R();
        r.put("code", RCode.API_CODE_CALL_ERROR);
        r.put("message", message + "超时，熔断器返回");
        return r;
    }

    public int getCode() {
        return (int) this.get("code");
    }

    public boolean insertDataOk() {
        return this.get("code").equals(RCode.INSERT_DATA_SUCCESS);
    }

    public boolean checkRowDataOk() {
        return this.get("code").equals(RCode.CHECK_DATA_OK);
    }

    public String getErrMsg() {
        return get("message").toString();
    }
}
