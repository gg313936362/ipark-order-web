package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.Constants;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import com.ipark.parkweb.util.SysConf;
import com.ipark.parkweb.util.weiXinUtils.WeChatUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/index")
public class WeiXinIndexController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

//    @RequestMapping("/init/{loginType}")
//    public String indexInit(@PathVariable Integer loginType, HttpServletRequest request){
//        request.setAttribute("WEIXIN_APP_ID", SysConf.WEIXIN_APP_ID);
//        request.setAttribute("WX_ADDRESS", SysConf.WX_ADDRESS);
//        request.setAttribute("loginType", loginType);
//        return "weixin/index";
////        return "weChat/index";
//    }

    @RequestMapping("/init/{webSourceType}/{loginType}")
    public String indexAccess(@PathVariable Integer webSourceType, @PathVariable Integer loginType,
                              @RequestParam(value = "param1", required = false) String param1, HttpServletRequest request){
        Map<String, Object> webSource = SysConf.WEB_SOURCE.get(webSourceType);
        if (webSource == null){
            request.setAttribute("msg", "来源接入平台类型不存在");
            return "error/error";
        }
        int platType = (int) webSource.get("platType");
        if (platType == Constants.webSourcePlatType.WE_CHAT_PLAT || platType == Constants.webSourcePlatType.WE_CHAT_MYSELF_OPENID_PLAT) {//微信平台接入；微信公众号接入，我方生成openid
            WeChatUtils wechatUtilsMap = SysConf.WECHATUTILS_MAP.get(webSourceType);
            if (wechatUtilsMap == null){
                request.setAttribute("msg", "微信来源信息不存在");
                return "error/error";
            } else {
                request.setAttribute("weixinAppId", wechatUtilsMap.getWeChatAppId());
                request.setAttribute("wxAddress", SysConf.WX_ADDRESS);
                request.setAttribute("webSourceType", webSourceType);
                request.setAttribute("platType", platType);
                request.setAttribute("loginType", loginType);
                request.setAttribute("param1", param1);
                return "weChat/index";
            }
        }

        request.setAttribute("msg", "来源接入平台类型未配置");
        return "error/error";
    }

    /**
     * 设置openid
     * @param code
     * @param openid
     * @param webSourceType
     * @param mobile
     * @param password
     * @param request
     * @return
     */
    @RequestMapping("/openid/set/{webSourceType}/{platType}/{mobile}/{password}")
    public String setOpenid(@RequestParam(value = "code", required = false) String code, @RequestParam(value = "auth_code",
                            required = false) String auth_code, @RequestParam(value = "openid", required = false) String openid,
                            @PathVariable Integer webSourceType, @PathVariable Integer platType, @PathVariable String mobile,
                            @PathVariable String password, HttpServletRequest request) throws Exception {
        if (!StringUtils.hasText(openid)) {
            if (platType == Constants.webSourcePlatType.WE_CHAT_PLAT) {//微信平台接入
                openid = SysConf.WECHATUTILS_MAP.get(webSourceType).getOpenid(code);
            } else if (platType == Constants.webSourcePlatType.WE_CHAT_MYSELF_OPENID_PLAT) {//微信公众号接入，我方生成openid
                openid = UUID.randomUUID().toString().replace("-", "");
            }
        }
        request.setAttribute("openid", openid);

        if (!(mobile.equals("0") || password.equals("0"))){//登录手机号和密码存在，则自动登录
            Map<String, Object> data = new HashMap<String, Object>();
            data.put("mobile", mobile);
            data.put("pwd", password);
            data.put("webSourceType", webSourceType);
            data.put("openId", openid);
            HttpResult httpResult = WapServerHttp.sendPost("/wap/user/login", data, true);
            if (!httpResult.getResCode().equals("000000") && !httpResult.getResCode().equals("200007")){
                request.setAttribute("msg", httpResult.getResMsg());
                return "error/error";
            }
        }
        return "weChat/openid_setting";
    }

    /**
     * 获取活动列表信息
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/act/list")
    public void getActList(HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/index/activityList", null);
        sendResponse(response, httpResult);
    }

    /**
     * 获取待缴记录个数
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/unpay/count/{openid}")
    public void getUnpayCount(@PathVariable String openid, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/index/unPayCnt", "openId=" + openid);
        sendResponse(response, httpResult);
    }

    /**
     * 支付主页
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/homepage/init")
    public String initHomePage(String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/index/payInfo", "openId=" + openid);
        String resCode = httpResult.getResCode();
        if (resCode.equals("000000") || resCode.equals("600001") || resCode.equals("600006") || resCode.equals("200008")) {
            List<Map<String, Object>> parkList = (List) httpResult.getData();
            LinkedList<Map<String, Object>> sortParkList = new LinkedList<Map<String, Object>>();
            if (parkList != null) {
                for (Map<String, Object> park : parkList) {
                    if (park.get("parkingInfo") == null) {
                        sortParkList.addLast(park);
                    } else {
                        sortParkList.addFirst(park);
                    }
                }
            }
            request.setAttribute("parkList", sortParkList);
            return "weChat/homepage";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }
}
