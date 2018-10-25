package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/weixin/problem")
public class WeiXinProblemController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 车辆信息反馈界面
     * @param parkingLogId
     * @param openid
     * @param request
     * @return
     */
    @RequestMapping("/init")
    public String initProblem(int parkingLogId, String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/parking/detail", "openId=" + openid + "&parkingLogId=" + parkingLogId);
        String resCode = httpResult.getResCode();
        if (resCode.equals("000000")) {
            Map<String, Object> parkingInfo = (Map<String, Object>) httpResult.getData();
            request.setAttribute("parkingInfo", parkingInfo);
            return "weChat/problem/init";
        } else if (resCode.equals("200008")) {
            return "redirect:/weixin/mem/validate/mobile/init";
        }
        request.setAttribute("msg", httpResult.getResMsg());
        return "error/error";
    }

    /**
     * 车辆信息反馈提交
     * @param feedbackType
     * @param parkingLogId
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public void getDetailPayInfo(int feedbackType, String parkingLogId, String openid, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("feedbackType", feedbackType);
        data.put("parkingLogId", parkingLogId);
        data.put("openId", openid);
        HttpResult httpResult = WapServerHttp.sendPost("/wap/parking/user/feedback", data, false);
        sendResponse(response, httpResult);
    }

    /**
     * 信息返回成功结果页
     * @param feedbackType
     * @param request
     * @return
     */
    @RequestMapping("/success")
    public String successProblem(int feedbackType, HttpServletRequest request) {
        request.setAttribute("feedbackType", feedbackType);
        return "weChat/problem/success";
    }
}
