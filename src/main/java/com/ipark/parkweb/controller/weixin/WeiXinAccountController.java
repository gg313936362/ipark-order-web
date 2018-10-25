package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.Constants;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import com.ipark.parkweb.util.SysConf;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangcheng on 2016/5/4.
 */
@Controller
@RequestMapping("/weixin/account")
public class WeiXinAccountController extends BaseController {
    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 余额充值获取支付信息
     * @param openid
     * @param amount
     * @param payWay
     * @param response
     * @throws Exception
     */
    @RequestMapping("/pay/info")
    public void getPayInfo(String openid, double amount, Integer payWay, HttpServletResponse response) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("openId", openid);
        param.put("payWay", payWay);
        param.put("amount", amount);
        if (payWay == Constants.payWay.ALI_PAY){//如果是支付宝网页支付，则返回回调地址
            param.put("showUrl", SysConf.WEB_ADDRESS + "/weixin/pay/account?openid=" + openid);
        }
        HttpResult httpResult = WapServerHttp.sendPost("/wap/pay/recharge", param, true);
        sendResponse(response, httpResult);
    }
}
