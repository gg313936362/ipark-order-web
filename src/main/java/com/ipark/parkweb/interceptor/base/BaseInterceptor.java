package com.ipark.parkweb.interceptor.base;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ipark.parkweb.jsonbean.OutJson;
import com.ipark.parkweb.util.ErrorCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

/**
 * Created by cheng.wang on 2015/6/22.
 */
public class BaseInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    protected static final String ENCODING_UTF8 = "UTF-8";

    protected static ObjectMapper mapper = new ObjectMapper();

    protected void sendResponse(HttpServletResponse response, ErrorCode error){
        OutJson outJB = new OutJson(error.getCode(), error.getText(), null);
        writeResponse(response, outJB);
    }

    private void writeResponse(HttpServletResponse response, Object outJB){
        response.setContentType("text/json; charset=utf-8");
        response.setCharacterEncoding(ENCODING_UTF8);
        response.setHeader("Content-Encoding", "gzip");
        GZIPOutputStream out = null;
        String jsonOut;
        try {
            jsonOut = mapper.writeValueAsString(outJB);
            logger.info(">>>>>>>>Interceptor Send:{}",jsonOut);
            out = new GZIPOutputStream(response.getOutputStream());
            out.write(jsonOut.getBytes(ENCODING_UTF8));
            out.flush();
        } catch (Exception e) {
            logger.error("",e);
        } finally{
            if(out != null){
                try {
                    out.close();
                } catch (IOException e) {
                    logger.error("",e);
                }
            }
        }
    }

    protected String getReqIpAddr(HttpServletRequest request) {
        String ip = null;
        try {
            ip = request.getHeader("x-forwarded-for");
            if (!StringUtils.hasText(ip) || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
            }
            if (!StringUtils.hasText(ip) || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
            }
            if (!StringUtils.hasText(ip) || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
            }
        } catch (Exception e) {
            logger.error("",e);
        }
        return ip;
    }

}
