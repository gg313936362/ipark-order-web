package com.ipark.parkweb.controller;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.Constants;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import com.ipark.parkweb.util.SysConf;
import com.ipark.parkweb.util.weiXinUtils.WeChatUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangcheng on 2016/5/4.
 */
@Controller
@RequestMapping("/sys/param")
public class SysParamController extends BaseController {
    private static Logger logger = LogManager.getLogger(SysParamController.class);

    static {
        //获取所有网页来源信息
        loadWebSource();
    }

    /**
     * 获取所有网页来源信息
     * @param response
     */
    @RequestMapping("/websource")
    public void initWebSource(HttpServletResponse response) {
        sendResponse(response, loadWebSource());
    }

    private static HttpResult loadWebSource() {
        try {
            HttpResult httpResult = WapServerHttp.sendGet("/wap/index/websource", null);
            List<Map<String, Object>> dataList = (List<Map<String, Object>>) httpResult.getData();
            Map<Integer, Map<String, Object>> webSource = new HashMap<Integer, Map<String, Object>>();
            Map<Integer, WeChatUtils> wechatUtilsMap = new HashMap<Integer, WeChatUtils>();
            for (Map<String, Object> data : dataList){
                webSource.put((int) data.get("type"), data);
                int platType = (int) data.get("platType");
                if (platType == Constants.webSourcePlatType.WE_CHAT_PLAT || platType == Constants.webSourcePlatType.WE_CHAT_MYSELF_OPENID_PLAT) {
                    wechatUtilsMap.put((int) data.get("type"), new WeChatUtils(data.get("wechatAppId").toString(),
                            data.get("wechatAppSecret").toString()));
                } else if (platType == Constants.webSourcePlatType.ALIPAY_PLAT){// TODO: 2017/2/14 暂时只做捷停自己生活号，接入多加生活号的话需要传递该生活号的具体参数

                }
            }
            SysConf.WEB_SOURCE = webSource;
            SysConf.WECHATUTILS_MAP = wechatUtilsMap;
            logger.info("获取所有网页来源信息,{}", webSource);
            return httpResult;
        } catch (Exception e){
            logger.error("获取所有网页来源信息出错");
            return null;
        }
    }
}
