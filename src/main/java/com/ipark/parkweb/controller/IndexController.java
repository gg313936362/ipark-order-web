package com.ipark.parkweb.controller;

import com.ipark.parkweb.controller.base.BaseController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by wangcheng on 2016/5/4.
 */
@Controller
@RequestMapping("/index")
public class IndexController extends BaseController {
    private Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 错误信息页面
     * @param msg
     * @param request
     * @return
     */
    @RequestMapping("/error")
    public String loginInit(String msg,HttpServletRequest request){
        request.setAttribute("msg", msg);
        return "error/error";
    }
}
