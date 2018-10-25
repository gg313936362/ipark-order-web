package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
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
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/coupon")
public class WeiXinCouponController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

//    @RequestMapping("/init")
//    public String indexInit(HttpServletRequest request) throws Exception {
//        return "weixin/coupon";
//    }

    /**
     * 获取优惠券
     * @param openid
     * @param response
     * @param pageIndex
     * @param pageSize
     * @return
     * @throws Exception
     */
    @RequestMapping("/get/{openid}/{pageIndex}/{pageSize}")
    public void getCoupon(@PathVariable String openid, @PathVariable Integer pageIndex, @PathVariable Integer pageSize,
                          HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/coupons/list", "openId=" + openid + "&pageIndex="
                + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 兑换优惠券
     * @param exchangeCode
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/exchange", method = RequestMethod.POST)
    public void exchange(String exchangeCode, String openid, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("exchangeCode", exchangeCode);
        data.put("openId", openid);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/coupons/exchange", data, false);
        sendResponse(response, httpResult);
    }

    /**
     * 优惠券兑换
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/exchange/init")
    public String initExchange(HttpServletRequest request) throws Exception {
        return "weChat/coupon/exchange";
    }

    /**
     * 优惠券列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/init")
    public String listInit(HttpServletRequest request) throws Exception {
        return "weChat/coupon/coupon_list";
    }

}
