package com.ipark.parkweb.util.ServerHttpUtils;

import com.ipark.parkweb.util.weiXinUtils.SecurityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.util.Map;

/**
 * Created by wangcheng on 2016/4/15.
 * 服务器请求基础类（wap）
 */
public class WapServerHttp extends BaseServerHttp {

    private static final Logger logger = LogManager.getLogger(WapServerHttp.class);

    private static String securityKey;

    /**
     * post请求
     * @param reqUrl
     * @param data
     * @param encrypt 是否加密
     * @return
     * @throws Exception
     */
    public static HttpResult sendPost(String reqUrl, Map<String, Object> data, boolean encrypt)throws Exception{
        String content = mapper.writeValueAsString(data);
        String userAgent = generateUserAgent(reqUrl);
        if(encrypt){//加密
            logger.info("post发送数据加密前：" + content);
            content = SecurityUtils.encrypt(content, securityKey);
        }
        return sendReq(POST, reqUrl, content, userAgent);
    }

    /**
     * get请求
     * @param reqUrl
     * @param content
     * @return
     * @throws Exception
     */
    public static HttpResult sendGet(String reqUrl, String content) throws Exception{
        String userAgent = generateUserAgent(reqUrl);
        return sendReq(GET, reqUrl, content, userAgent);
    }

    /**
     * 生产userAgent
     * @param url
     * @return
     */
    private static String generateUserAgent(String url){
        String currTimeHex = Long.toHexString(System.currentTimeMillis());
        String signature = SecurityUtils.sha1Hex("Wap" + currTimeHex + url);
        securityKey = signature.substring(0, 16);
        String userAgent = "IPark_Wap|" + signature + currTimeHex;//
        return userAgent;
    }
}
