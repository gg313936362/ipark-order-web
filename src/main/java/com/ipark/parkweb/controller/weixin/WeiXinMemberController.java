package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import com.ipark.parkweb.util.SysConf;
import com.ipark.parkweb.util.weiXinUtils.JsapiParam;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangcheng on 2016/5/4.
 */
@Controller
@RequestMapping("/weixin/mem")
public class WeiXinMemberController extends BaseController {
    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 注册页面
     * @param request
     * @return
     */
    @RequestMapping("/reg/init")
    public String regInit(HttpServletRequest request){
        return "weChat/register";
    }

    /**
     * 发送手机验证码
     * @param mobile
     * @param codeType
     * @param response
     * @throws Exception
     */
    @RequestMapping("/code/{mobile}/{codeType}")
    public void getCode(@PathVariable String mobile, @PathVariable Integer codeType, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/sms/user", "flag=" + codeType + "&mobile=" + mobile);
        sendResponse(response, httpResult);
    }

    /**
     * 注册
     * @param mobile
     * @param carNum
     * @param smsCode
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    public void reg(String mobile, String carNum, String smsCode, String openid, Integer webSourceType,
                    HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("mobile", mobile);
        data.put("carNum", carNum);
        data.put("smsCode", smsCode);
        data.put("openId", openid);
        data.put("webSourceType", webSourceType);
        data.put("source", SysConf.WEB_SOURCE.get(webSourceType).get("name"));
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/reg", data, true);
        sendResponse(response, httpResult);
    }

    /**
     * 登录页面
     * @param request
     * @return
     */
    @RequestMapping("/log/init")
    public String logInit(HttpServletRequest request){
        return "weChat/login";
    }

    /**
     * 登录
     * @param mobile
     * @param pwd
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/log", method = RequestMethod.POST)
    public void log(String mobile, String pwd, String openid, Integer webSourceType, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("mobile", mobile);
        data.put("pwd", pwd);
        data.put("webSourceType", webSourceType);
        data.put("openId", openid);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/login", data, true);
        sendResponse(response, httpResult);
    }

    /**
     * 找回密码初始化
     * @param request
     * @return
     */
    @RequestMapping("/forgetpwd/init")
    public String forgetpwdInit(HttpServletRequest request){
        return "weChat/forgetpwd";
    }

    /**
     * 找回密码
     * @param mobile
     * @param smsCode
     * @param pwd
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/forgetpwd", method = RequestMethod.POST)
    public void forgetpwd(String mobile, String smsCode, String pwd, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("mobile", mobile);
        data.put("smsCode", smsCode);
        data.put("pwd", pwd);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/repwd", data, true);
        sendResponse(response, httpResult);
    }

    /**
     * 用户信息页面
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/info/init/{openid}")
    public String infoInit(@PathVariable String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        String resCode = httpResult.getResCode();
        if (resCode.equals("200008")) {
            return "redirect:/weixin/mem/validate/mobile/init";
        } else if (resCode.equals("000000")){
            request.setAttribute("memInfo", httpResult.getData());
            return "weChat/mem_info";
        } else {
            request.setAttribute("msg", httpResult.getResMsg());
            return "error/error";
        }
    }

    /**
     * 我的钱包初始化
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/wallet/init/{openid}")
    public String blueiWalletInit(@PathVariable String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        request.setAttribute("memInfo", httpResult.getData());
        return "weChat/mem_wallet";
    }

    /**
     * 用户设置初始化
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/setting/init/{openid}")
    public String blueiSetInit(@PathVariable String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        request.setAttribute("memInfo", httpResult.getData());
        return "weChat/mem_setting";
    }

    /**
     * 设置自动扣款和短信提示
     * @param openid
     * @param setType
     * @param switchFlag
     * @param response
     * @throws Exception
     */
    @RequestMapping("/setting/{openid}/{setType}/{switchFlag}")
    public void loginOut(@PathVariable String openid, @PathVariable String setType, @PathVariable String switchFlag,
                         HttpServletResponse response) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("openId", openid);
        param.put("setType", setType);
        param.put("switchFlag", switchFlag);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/set", param, false);
        sendResponse(response, httpResult);
    }

    /**
     * 登出
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping("/login/out/{openid}")
    public void loginOut(@PathVariable String openid, HttpServletResponse response) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("openId", openid);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/logout", param, true);
        sendResponse(response, httpResult);
    }

    /**
     * 要求好友页面初始化
     * @param webSourceType
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/invite/init/{webSourceType}/{openid}")
    public String inviteInit(@PathVariable Integer webSourceType, @PathVariable String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        request.setAttribute("memInfo", httpResult.getData());
        JsapiParam jsapiParam = SysConf.WECHATUTILS_MAP.get(webSourceType).getSign(request);
        request.setAttribute("jsapiParam", jsapiParam);//返回jsapi所需参数
        return "weChat/invite";
    }

    /**
     * 验证手机登录页面
     * @param request
     * @return
     */
    @RequestMapping("/validate/mobile/init")
    public String validateMobileInit(HttpServletRequest request){
        return "weChat/validate_mobile";
    }

    /**
     * 验证手机登录
     * @param mobile
     * @param smsCode
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/validate/mobile", method = RequestMethod.POST)
    public void validateMobile(String mobile, String smsCode, String openid, Integer webSourceType, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("mobile", mobile);
        data.put("smsCode", smsCode);
        data.put("webSourceType", webSourceType);
        data.put("source", SysConf.WEB_SOURCE.get(webSourceType).get("name"));
        data.put("openId", openid);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/user/mobileLogin", data, true);
        sendResponse(response, httpResult);
    }
}
