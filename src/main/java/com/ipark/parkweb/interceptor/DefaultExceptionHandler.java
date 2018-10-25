package com.ipark.parkweb.interceptor;

import com.ipark.parkweb.interceptor.base.BaseInterceptor;
import com.ipark.parkweb.util.ErrorCode;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by cheng.wang on 2015/9/11.
 * 异常统一处理
 */
public class DefaultExceptionHandler extends BaseInterceptor implements HandlerExceptionResolver {

    private Logger logger = LogManager.getLogger(this.getClass());

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception e) {
        HandlerMethod hm = (HandlerMethod) handler;
        ErrorCode errorCode;
        if (e instanceof MaxUploadSizeExceededException){//上传文件过大
            errorCode = ErrorCode.PIC_OVER_SIZE_4M;
        } else {
            errorCode = ErrorCode.SYS_ERROR;
        }

        logger.error("", e);
        if (hm.isVoid()) {//返回json
            sendResponse(response, errorCode);
            return null;
        } else {
            request.setAttribute("msg", errorCode.getText());
            return new ModelAndView("error/error");
        }
    }
}
