package com.zd.wechat.util;

import java.lang.reflect.Field;

public class BeanUtil {

	public static String toStringNotEmpty(Object bean) {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append(bean.getClass().getSimpleName());
		stringBuffer.append("[");
		for (Field f : bean.getClass().getDeclaredFields()) {
			f.setAccessible(true);
			try {
				if (f.get(bean) != null) { // 判断字段是否为空，并且对象属性中的基本都会转为对象类型来判断
					stringBuffer.append(f.getName() + ":" + f.get(bean) + ",");
				}
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		stringBuffer.delete(stringBuffer.length() - 1, stringBuffer.length());
		stringBuffer.append("]");
		return stringBuffer.toString();
	}

}
