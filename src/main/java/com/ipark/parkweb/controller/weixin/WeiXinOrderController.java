package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.Constants;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import com.ipark.parkweb.util.SysConf;
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
@RequestMapping("/weixin/order")
public class WeiXinOrderController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());
    /**
     * 包月车场列表初始化
     * @param request
     * @param openid
     * @return
     * @throws Exception
     */
    @RequestMapping("/park/list/init")
    public String initOrderParkList(String openid, HttpServletRequest request) throws Exception {
//        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
//        String resCode = httpResult.getResCode();
//        if (resCode.equals("200008")) {
//            return "redirect:/weixin/mem/validate/mobile/init";
//        }
        return "weChat/order_park_list";
    }

    /**
     * 获取包月车场列表
     * @param lng
     * @param lat
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/park/list/json")
    public void getOrderParkList(String lng, String lat, int pageIndex, int pageSize, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/park/monthlyList", "lng=" + lng + "&lat=" + lat
                + "&pageIndex=" + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 初始化发布包月需求信息页面
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/park/need/init")
    public String initOrderNeedPark(HttpServletRequest request) throws Exception {
        return "weChat/order_need";
    }

    /**
     * 发布包月需求信息
     * @param openid
     * @param mobile
     * @param parkingAddress
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/park/need/submit", method = RequestMethod.POST)
    public void submitOrderNeedPark(String openid, String mobile, String parkingAddress, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("openId", openid);
        data.put("mobile", mobile);
        data.put("parkingAddress", parkingAddress);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/parking/addRequired", data, false);
        sendResponse(response, httpResult);
    }

    /**
     * 初始化车场车位详情
     * @param lng
     * @param lat
     * @param parkId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/park/detail/init")
    public String initOrderParkDetail(String lng, String lat, String parkId, String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/user/info", "openId=" + openid);
        String resCode = httpResult.getResCode();
        if (resCode.equals("200008")) {
            return "redirect:/weixin/mem/validate/mobile/init";
        }
        httpResult = WapServerHttp.sendGet("/wap/park/monthlyDetail", "lng=" + lng + "&lat=" + lat + "&parkId=" + parkId);
        request.setAttribute("result", httpResult.getData());
        return "weChat/order_park_detail";
    }

    /**
     * 初始化车场包月类型详情
     * @param openid
     * @param monthlyTypeId
     * @param monthlyBeginDate
     * @param orderNo
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/park/type/init")
    public String initOrderParkType(String openid, String monthlyTypeId, String monthlyBeginDate, String orderNo,
                                    HttpServletRequest request) throws Exception {
        if (orderNo == null){
            orderNo = "0";
        }
        HttpResult httpResult = WapServerHttp.sendGet("/wap/park/monthlyTypeDetail", "openId=" + openid
                + "&monthlyTypeId=" + monthlyTypeId + "&monthlyBeginDate=" + monthlyBeginDate
                + "&orderNo=" + orderNo);
        request.setAttribute("result", httpResult.getData());
        request.setAttribute("monthlyTypeId", monthlyTypeId);
        request.setAttribute("monthlyBeginDate", monthlyBeginDate);
        request.setAttribute("orderNo", orderNo);
        return "weChat/order_park_type";
    }

    /**
     * 包月支付信息提交
     * @param openid
     * @param monthlyTypeId
     * @param beginDate
     * @param endDate
     * @param couponsId
     * @param carNum
     * @param payWay
     * @param orderNo
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/pay/submit", method = RequestMethod.POST)
    public void initOrderPaySubmit(String openid, String monthlyTypeId, String beginDate, String endDate, int couponsId,
                                     String carNum, int payWay, String orderNo, HttpServletResponse response) throws Exception {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("openId", openid);
        param.put("monthlyTypeId", monthlyTypeId);
        param.put("beginDate", beginDate);
        param.put("endDate", endDate);
        param.put("couponsId", couponsId);
        param.put("carNum", carNum);
        param.put("payWay", payWay);
        param.put("orderNo", orderNo);
        if (payWay == Constants.orderPayWay.ALI_PAY){//如果是支付宝网页支付，则返回回调地址
            param.put("showUrl", SysConf.WEB_ADDRESS + "/weixin/order/list/init'");
        }
        HttpResult httpResult = WapServerHttp.sendPost("/wap/monthlyOrder/pay", param, true);
        sendResponse(response, httpResult);
    }

    /**
     * 初始化用户包月订单列表
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/init")
    public String initOrderList() throws Exception {
        return "weChat/order_list";
    }

    /**
     * 获取用户订单列表信息
     * @param openid
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/list/json/{openid}/{pageIndex}/{pageSize}")
    public void getListJson(@PathVariable String openid, @PathVariable int pageIndex, @PathVariable int pageSize,
                            HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/monthlyOrder/list", "openId=" + openid + "&pageIndex="
                + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 初始化包月订单详情
     * @param openid
     * @param orderNo
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/detail/init/{openid}/{orderNo}")
    public String initOrderDetail(@PathVariable String openid, @PathVariable String orderNo, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/monthlyOrder/detail", "openId=" + openid + "&orderNo=" + orderNo);
        request.setAttribute("result", httpResult.getData());
        return "weChat/order_detail";
    }

    /**
     * 包月订单支付记录
     * @param openid
     * @param orderNo
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/pay/detail/init/{openid}/{orderNo}")
    public String initOrderPayDetail(@PathVariable String openid, @PathVariable String orderNo, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/monthlyOrder/payDetail", "openId=" + openid + "&orderNo=" + orderNo);
        request.setAttribute("result", httpResult.getData());
        return "weChat/order_pay_detail";
    }
}
