package com.ipark.parkweb.util;

import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import com.ipark.parkweb.util.weiXinUtils.WeChatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by cheng.wang on 2015/6/29.
 */
public class SysConf {
	private static Logger logger = LoggerFactory.getLogger(SysConf.class);
	
	private static final String BUNDLE_NAME = "conf/conf";
	
	//server服务地址
	public static final String SERVER_ADDRESS = getBundleString("SERVER_ADDRESS");
	//网站地址
	public static final String WEB_ADDRESS = getBundleString("WEB_ADDRESS");
	//微信地址
	public static final String WX_ADDRESS = getBundleString("WX_ADDRESS");
	//网页来源信息
	public static Map<Integer, Map<String, Object>> WEB_SOURCE;
	/*************************************微信信息**************************************/
	//微信app_id
	public static final String WEIXIN_APP_ID = getBundleString("WEIXIN_APP_ID");
	//微信app_secret
	public static final String WEIXIN_APP_SECRET = getBundleString("WEIXIN_APP_SECRET");
	//每个微信号的信息map
	public static Map<Integer, WeChatUtils> WECHATUTILS_MAP;

	private static String getBundleString(String key){
		return ResourceBundle.getBundle(BUNDLE_NAME, Locale.CHINA).getString(key);
	}
	
	public static void main(String args[]){

	}
}
 