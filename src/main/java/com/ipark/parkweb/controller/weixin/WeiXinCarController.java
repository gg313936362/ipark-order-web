package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import com.ipark.parkweb.util.ServerHttpUtils.WapServerHttp;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangcheng on 2016/5/3.
 */
@Controller
@RequestMapping("/weixin/car")
public class WeiXinCarController extends BaseController {

    private Logger logger = LogManager.getLogger(this.getClass());

//    /**
//     * 车辆管理列表初始化
//     * @param openid
//     * @param request
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/list/init/{openid}")
//    public String initCarList(@PathVariable String openid, HttpServletRequest request) throws Exception {
//        HttpResult httpResult = WapServerHttp.sendGet("/wap/car/list", "openId=" + openid);
//        if (((List)httpResult.getData()).size() == 0){
//            return "weixin/car_add";
//        }
//        request.setAttribute("carList", httpResult.getData());
//        return "weixin/car_list";
//    }

    /**
     * 添加车牌初始化
     * @param carNum
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/add/init")
    public String addCarInit(@RequestParam(value = "carNum", required = false) String carNum,
                             HttpServletRequest request) throws Exception {
        request.setAttribute("carNum", carNum);
        return "weixin/car_add";
    }

    /**
     * 添加或修改车牌
     * @param carNum
     * @param openid
     * @param sourceCarNum
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public void addUpdateCarNum(String carNum, String openid, @RequestParam(value = "sourceCarNum", required = false) String sourceCarNum,
                                HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("carNum", carNum);
        data.put("openId", openid);
        HttpResult httpResult;
        if (StringUtils.hasText(sourceCarNum)){
            data.put("sourceCarNum", sourceCarNum);
            httpResult = WapServerHttp.sendPost("/wap/car/edit", data, false);
        } else {
            httpResult = WapServerHttp.sendPost("/wap/car/add", data, false);
        }
        sendResponse(response, httpResult);
    }

    /**
     * 删除车牌
     * @param carNum
     * @param openid
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public void deleteCarNum(String carNum, String openid, HttpServletResponse response) throws Exception {
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("carNum", carNum);
        data.put("openId", openid);
        HttpResult httpResult;
        httpResult = WapServerHttp.sendPost("/wap/car/delete", data, false);

        sendResponse(response, httpResult);
    }

    /**
     * 车辆管理列表初始化
     * @param openid
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/init")
    public String initList(String openid, HttpServletRequest request) throws Exception {
        HttpResult httpResult = WapServerHttp.sendGet("/wap/car/list", "openId=" + openid);
        String resCode = httpResult.getResCode();
        if (resCode.equals("200008")) {
            return "redirect:/weixin/mem/validate/mobile/init";
        } else if (resCode.equals("000000")){
            if (((List)httpResult.getData()).size() == 0){
                request.setAttribute("type", 1);
                return "weChat/car_add";
            }
            request.setAttribute("carList", httpResult.getData());
            return "weChat/car_list";
        } else {
            request.setAttribute("msg", httpResult.getResMsg());
            return "error/error";
        }
    }

    /**
     * 添加车牌初始化
     * @param type 1:车辆列表进入；2：注册进入
     * @param carNum
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/add/init/{type}")
    public String addInit(@PathVariable int type ,@RequestParam(value = "carNum", required = false) String carNum,
                          HttpServletRequest request) throws Exception {
        request.setAttribute("type", type);
        request.setAttribute("carNum", carNum);
        return "weChat/car_add";
    }

    /**
     * 车辆行驶证上传初始化
     * @param request
     * @return
     */
    @RequestMapping("/upload/init")
    public String uploadInit(HttpServletRequest request) {
        return "weChat/car_upload/init";
    }

    /**
     * 上传车辆行驶证信息
     * @param carNum
     * @param engineNo
     * @param openid
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/upload/submit", method = RequestMethod.POST)
    public void uploadSubmit(String carNum, String engineNo, String openid, String imgBase64, String imgName,
                                HttpServletRequest request, HttpServletResponse response) throws Exception {
//        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//        MultipartFile imgFile = multipartRequest.getFile("uploadImg");
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("carNum", carNum);
        data.put("engineNo", engineNo);
        data.put("openId", openid);
//        data.put("picContent", new BASE64Encoder().encode(imgFile.getBytes()));
//        data.put("picName", imgFile.getOriginalFilename());
        data.put("picContent", imgBase64);
        data.put("picName", imgName);
        data.put("verifyCode", "ipark_web_upload_drivingLicense");
        HttpResult httpResult = WapServerHttp.sendPost("/wap/car/drivingLicense/upload", data, false);
        sendResponse(response, httpResult);
    }

    /**
     * 上传车辆行驶证信息返回成功结果页
     * @param request
     * @return
     */
    @RequestMapping("/upload/success")
    public String successProblem(HttpServletRequest request) {
        return "weChat/car_upload/success";
    }
}
