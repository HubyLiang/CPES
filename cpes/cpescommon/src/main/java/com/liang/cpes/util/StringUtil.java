package com.liang.cpes.util;

public class StringUtil {
	public static boolean isEmpty( String s ) {
		// java中trim方法不能去掉全角空格
		return s == null || s.trim().equals("");
	}
	
	public static boolean isNotEmpty( String s ) {
//		return s != null && !s.trim().equals("");
		return !isEmpty(s);
	}
}
