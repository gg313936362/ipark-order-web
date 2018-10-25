package com.ipark.parkweb.controller.weixin;

import com.ipark.parkweb.controller.base.BaseController;
import com.ipark.parkweb.jsonbean.OutJson;
import com.ipark.parkweb.util.ErrorCode;
import com.ipark.parkweb.util.SysConf;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by wangcheng on 2016/11/18.
 */
@Controller
@RequestMapping("/weixin/send")
public class WeiXinSendMsgController extends BaseController {
    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 发送出场模板信息
     * @param openid
     * @param carNum
     * @param parkName
     * @param arriveTime
     * @param webSourceType
     * @param parkingLogId
     * @param isJoinDiscount
     * @param disAmt
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/template/arrive", method = RequestMethod.POST)
    public void getPayInfo(String openid, String carNum, String parkName, String arriveTime, int webSourceType,
                           int parkingLogId, int isJoinDiscount, String disAmt, HttpServletResponse response) throws Exception {
//        OutJson outJB = null;
//       if(webSourceType == 1){
//           if (SysConf.WECHATUTILS_MAP.get(webSourceType).sendArriveTemplateMessage(openid, carNum, parkName,
//                   arriveTime, webSourceType, parkingLogId, isJoinDiscount, disAmt)){
//               outJB = new OutJson(ErrorCode.SUCCESS.getCode(), ErrorCode.SUCCESS.getText(), null);
//           } else {
//               outJB = new OutJson(ErrorCode.FAILED.getCode(), ErrorCode.FAILED.getText(), null);
//           }
//       } else {
//           outJB = new OutJson(ErrorCode.SUCCESS.getCode(), ErrorCode.SUCCESS.getText(), null);
//       }
//        sendResponse(response, outJB);
    }
}
