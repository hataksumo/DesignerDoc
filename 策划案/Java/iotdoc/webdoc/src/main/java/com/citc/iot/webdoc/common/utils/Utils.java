package com.citc.iot.webdoc.common.utils;

import org.springframework.cglib.beans.BeanMap;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Pattern;

public class Utils {
    public static boolean IsValidUserName(String v_userName) {
        String regEx = "^[A-Za-z][A-Za-z1-9_-]+$";
//        Pattern pattern = Pattern.compile(regEx);
        String test = v_userName;
        int atLoc = v_userName.indexOf('@');
        if (atLoc > 0) {
            test = v_userName.substring(0, atLoc);
            String tail = v_userName.substring(atLoc);
        }
        return test.matches(regEx);
    }

    public static boolean IsValidPasswd(String v_passwd) {
        String regEx = "^[A-Za-z1-9_-]+$";
        return v_passwd.matches(regEx);
    }

    public static <T> Map<String, Object> beanToMap(T bean) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (bean != null) {
            BeanMap beanMap = BeanMap.create(bean);
            for (Object key : beanMap.keySet()) {
                map.put(key + "", beanMap.get(key));
            }
        }
        return map;
    }

    public static Boolean IsNullOrEmpty(String v_testStr)
    {
        return v_testStr == null||v_testStr.equals("");
    }

}
