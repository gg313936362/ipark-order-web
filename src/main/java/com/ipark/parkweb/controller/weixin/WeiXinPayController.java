package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.Constants;
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
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/pay")
public class WeiXinPayController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 初始化支付详情页面
     * @param parkingLogId
     * @param openid
     * @param webSourceType
     * @param platType
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/detail")
    public String initDetail(int parkingLogId, String openid, Integer webSourceType, Integer platType,
                             @RequestParam(value = "isAliCityServer", required = false) Integer isAliCityServer, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/parking/detail", "openId=" + openid + "&parkingLogId=" + parkingLogId);
        String resCode = httpResult.getResCode();
        if (resCode.equals("000000")) {
            Map<String, Object> parkingInfo = (Map<String, Object>) httpResult.getData();
            request.setAttribute("parkingInfo", parkingInfo);
            int isSupportPay = Integer.parseInt(parkingInfo.get("isSupportPay").toString());
            if (isSupportPay == 0){//不支持电子支付
                return "weChat/parking_no_pay";
            } else {
                int status = Integer.parseInt(parkingInfo.get("status").toString());
                Object leaveTime = parkingInfo.get("leaveTime");
                if (leaveTime != null && !leaveTime.toString().equals("0")){
                    return "weChat/parking_out";
                }
                if (status == 1) {
                    if (isAliCityServer != null &&isAliCityServer == 1){//如果是支付宝城市服务支付
                        request.setAttribute("isAliCityServer", isAliCityServer);
                    }
                    return "weChat/parking_pay";
                }
                if (status == 2) {
                    if (isAliCityServer != null &&isAliCityServer == 1){//如果是支付宝城市服务支付
                        request.setAttribute("isAliCityServer", isAliCityServer);
                    }
                    return "weChat/parking_over_time";
                }
                if (status == 3) {
                    if (platType == Constants.webSourcePlatType.WE_CHAT_PLAT || platType == Constants.webSourcePlatType.WE_CHAT_MYSELF_OPENID_PLAT){//如果是微信公众号；微信公众号接入，我方生成openid
                        JsapiParam jsapiParam = SysConf.WECHATUTILS_MAP.get(webSourceType).getSign(request);
                        request.setAttribute("jsapiParam", jsapiParam);//返回jsapi所需参数
                    }
                    if (isAliCityServer != null &&isAliCityServer == 1){//如果是支付宝城市服务支付
                        request.setAttribute("isAliCityServer", isAliCityServer);
                    }
                    return "weChat/parking_free";
                }
                if (status == 4) {
                    return "weChat/parking_out_hand";
                }
            }
        } else if (resCode.equals("200008")) {
            return "redirect:/weixin/mem/validate/mobile/init";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }

    /**
     * 获取临停支付信息
     * @param couponsId
     * @param parkingLogId
     * @param openid
     * @param payWay
     * @param parkId
     * @param isAliCityServer
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/detail/submit", method = RequestMethod.POST)
    public void getDetailPayInfo(String couponsId, String parkingLogId, String openid, int payWay, Integer parkId,
                                 int isAliCityServer, HttpServletResponse response) throws Exception {
        if (parkId == 500){//汇金晚九点半到早九点不能电子支付
            int currentHhmm = Integer.parseInt(new SimpleDateFormat("HHmm").format(new Date()));
            if (currentHhmm >= 2130 || currentHhmm <= 1000){
                HttpResult httpResult = new HttpResult("900000", "本停车场在（晚9:30-早10:00)不支持手机支付停车费");
                sendResponse(response, httpResult);
                return;
            }
        }
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("couponsId", couponsId);
        data.put("parkingLogId", parkingLogId);
        data.put("openId", openid);
        data.put("payWay", payWay);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/pay/parking", data, true);
        sendResponse(response, httpResult);
    }

    /**
     * 待缴记录列表
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/unpay")
    public String initBlueiUnpayList(String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/pay/unPayList", "openId=" + openid);
        String resCode = httpResult.getResCode();
        if (resCode.equals("000000")) {
            request.setAttribute("detail", httpResult.getData());
            return "weChat/unpay_list";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }

    /**
     * 待缴记录包月详情列表
     * @param openid
     * @param orderNo
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/unpay/order/list/{openid}/{orderNo}")
    public String initBlueiUnpayOrderList(@PathVariable String openid, @PathVariable String orderNo, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/pay/unPayOrderParkings", "openId=" + openid + "&orderNo=" + orderNo);
        String resCode = httpResult.getResCode();
        if (resCode.equals("000000")) {
            request.setAttribute("orderList", httpResult.getData());
            return "weChat/unpay_order_list";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }

    /**
     * 待缴记录支付获取支付信息
     * @param openid
     * @param payWay
     * @param response
     * @throws Exception
     */
    @RequestMapping("/unpay/pay/info")
    public void getUnpayPayInfo(String openid, int payWay, HttpServletResponse response) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("openId", openid);
        param.put("payWay", payWay);
        param.put("parkingLogId", 0);
        param.put("couponsId", 0);
        if (payWay == Constants.payWay.ALI_PAY){//如果是支付宝网页支付，则返回回调地址
            param.put("showUrl", SysConf.WEB_ADDRESS + "/weixin/index/homepage/init?openid=" + openid);
        }
        HttpResult httpResult = WapServerHttp.sendPost("/wap/pay/payArrearsAmt", param, true);
        sendResponse(response, httpResult);
    }

    /**
     * 初始化包月支付页面
     * @param openid
     * @param monthlyTypeId
     * @param monthCount
     * @param beginDate
     * @param endDate
     * @param totalPrice
     * @param carNum
     * @param orderNo
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/order")
    public String initOrderPay(String openid, String monthlyTypeId, int monthCount, String beginDate, String endDate,
                               String totalPrice, String carNum, String orderNo, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/park/monthlyTypeDetail", "openId=" + openid
                + "&monthlyTypeId=" + monthlyTypeId + "&monthlyBeginDate=0&orderNo" + orderNo);
        request.setAttribute("result", httpResult.getData());
        request.setAttribute("monthlyTypeId", monthlyTypeId);
        request.setAttribute("monthCount", monthCount);
        request.setAttribute("beginDate", beginDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("carNum", carNum);
        request.setAttribute("orderNo", orderNo);
        return "weChat/order_pay";
    }

    /**
     * 初始化余额页面
     * @param openid
     * @param request
     * @return
     */
    @RequestMapping("/account")
    public String initBlueiAccount(String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        request.setAttribute("memInfo", httpResult.getData());
        return "weChat/account";
    }
}
