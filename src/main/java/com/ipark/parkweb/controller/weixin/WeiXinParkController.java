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

/**
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/park")
public class WeiXinParkController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

    @RequestMapping("/map/init")
    public String indexInit(HttpServletRequest request){
        return "weixin/map";
    }

    /**
     * map获取电子支付停车场
     * @param lng
     * @param lat
     * @param response
     * @throws Exception
     */
    @RequestMapping("/map")
    public void getMap(String lng, String lat, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/park/list", "lng=" + lng + "&lat=" + lat);
        sendResponse(response, httpResult);
    }

    /**
     * 车场列表初始化
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/init")
    public String initParkList(HttpServletRequest request) throws Exception {
        return "weChat/park_list";
    }

    /**
     * 获取车场列表
     * @param lng
     * @param lat
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/list")
    public void getParkList(String lng, String lat, int pageIndex, int pageSize, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/park/page", "lng=" + lng + "&lat=" + lat
                + "&pageIndex=" + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

    /**
     * 停车记录列表初始化
     * @param request
     * @return
     */
    @RequestMapping("/record/list/init")
    public String recordListInit(HttpServletRequest request){
        return "weChat/park_record_list";
    }

    /**
     * 获取停车记录
     * @param openid
     * @param pageIndex
     * @param pageSize
     * @param response
     * @throws Exception
     */
    @RequestMapping("/record/list")
    public void getParkRecordList(String openid, int pageIndex, int pageSize, HttpServletResponse response) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/parking/list", "openId=" + openid + "&pageIndex="
                + pageIndex + "&pageSize=" + pageSize);
        sendResponse(response, httpResult);
    }

//    /**
//     * 获取停车记录详情
//     * @param openid
//     * @param parkingLogId
//     * @param request
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/record/detail/{openid}/{parkingLogId}")
//    public String getParkRecordDetail(@PathVariable String openid, @PathVariable int parkingLogId, HttpServletRequest request) throws Exception {
//        HttpResult httpResult = WapServerHttp.sendGet("/wap/parking/detail", "openId=" + openid + "&parkingLogId=" + parkingLogId);
//        String resCode = httpResult.getResCode();
//        if (resCode.equals("000000")) {
//            Map<String, Object> parkingInfo = (Map<String, Object>) httpResult.getData();
//            request.setAttribute("parkingInfo", parkingInfo);
//            int isSupportPay = Integer.parseInt(parkingInfo.get("isSupportPay").toString());
//            if (isSupportPay == 0){//不支持电子支付
//                return "weChat/parking_no_pay";
//            } else {
//                int status = Integer.parseInt(parkingInfo.get("status").toString());
//                Object leaveTime = parkingInfo.get("leaveTime");
//                if ((leaveTime != null && !leaveTime.toString().equals("0")) || status == 4){
//                    return "weChat/parking_out";
//                }
//                if (status == 1) {
//                    return "weChat/parking_pay";
//                }
//                if (status == 2) {
//                    return "weChat/parking_over_time";
//                }
//                if (status == 3) {
//                    return "weChat/parking_free";
//                }
//            }
//        } else if (resCode.equals("200008")) {
//            return "redirect:/weixin/mem/reg/init";
//        }
//        request.setAttribute("msg", httpResult.getResMsg());
//        return "error/error";
//    }
}
