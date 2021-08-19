package com.czp.casms.utils;

import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class DataTypeUtil {

    //构建指定类型
    public static <T> T buildType(Class<T> clazz, Object src) {
        if (src == null || clazz == null) {
            return null;
        }
        T t = null;
        try {
            t = clazz.newInstance();
            BeanUtils.copyProperties(src, t);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return t;
    }

    //构建指定List类型
    public static <T> List<T> buildType(Class<T> clazz, List<?> object) {
        if (CollectionUtils.isEmpty(object)) {
            return Collections.emptyList();
        }
        return object.stream().map(o -> buildType(clazz, o)).collect(Collectors.toList());
    }

}