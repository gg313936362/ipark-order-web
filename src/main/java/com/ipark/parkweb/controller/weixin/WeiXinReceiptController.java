package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/receipt")
public class WeiXinReceiptController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 可开发票停车记录列表初始化
     * @param request
     * @return
     */
    @RequestMapping("/record/list/init")
    public String recordListInit(HttpServletRequest request){
        return "weChat/receipt/park_record_list";
    }

    /**
     * 获取可开发票停车记录
     * @param openid
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/record/list")
    public void getParkRecordList(String openid, int pageIndex, int pageSize, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/receipt/parkingLog", "openId=" + openid + "&pageIndex="
                + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 发票申请页面
     * @param openid
     * @param orderNoAndOrderType
     * @param amount
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/apply/init")
    public String initApply(String openid, String orderNoAndOrderType, String amount, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/receipt/kprInfo", "openId=" + openid);
        if (httpResult.getResCode().equals("000000")){
            if (httpResult.getData() != null){
                request.setAttribute("userInfo", httpResult.getData());
            }
        }
        request.setAttribute("orderNoAndOrderType", orderNoAndOrderType);
        request.setAttribute("amount", amount);
        return "weChat/receipt/apply";
    }

    /**
     * 开票历史列表初始化
     * @param request
     * @return
     */
    @RequestMapping("/list/init")
    public String listInit(HttpServletRequest request) throws Exception {
        return "weChat/receipt/receipt_list";
    }

    /**
     * 获取开票历史
     * @param openid
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/list")
    public void getList(String openid, int pageIndex, int pageSize, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/receipt/list", "openId=" + openid + "&pageIndex="
                + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 开票详情初始化
     * @param openid
     * @param receiptId
     * @param request
     * @return
     */
    @RequestMapping("/detail/init")
    public String initDetail(String openid, String receiptId, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/receipt/detail", "openId=" + openid + "&receiptId=" + receiptId);
        if (httpResult.getResCode().equals("000000")){
            request.setAttribute("detail", httpResult.getData());
            request.setAttribute("receiptId", receiptId);
            return "weChat/receipt/receipt_detail";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }

    /**
     * 发送邮件页面初始化
     * @param receiptId
     * @param request
     * @return
     */
    @RequestMapping("/send/init")
    public String intSendReceipt(String receiptId, HttpServletRequest request) throws Exception {
        request.setAttribute("receiptId", receiptId);
        return "weChat/receipt/send_receipt";
    }

    /**
     * 发送邮件
     * @param email
     * @param openid
     * @param receiptId
     * @param response
     * @throws Exception
     */
    @RequestMapping("/send")
    public void getList(String email, String openid, String receiptId, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("openId", openid);
        data.put("receiptId", receiptId);
        data.put("email", email);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/receipt/send", data, false);
        sendResponse(response, httpResult);
    }
}
