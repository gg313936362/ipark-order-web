package com.ipark.parkweb.interceptor;

import com.ipark.parkweb.interceptor.base.BaseInterceptor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.method.HandlerMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by cheng.wang on 2015/6/22.
 */
public class DefaultInterceptor extends BaseInterceptor {

	private Logger logger = LogManager.getLogger(this.getClass());

	/**
	 * 在业务处理器处理请求之前被调用
	 */
	@SuppressWarnings("unchecked")
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		request.setCharacterEncoding(ENCODING_UTF8);
		String reqMethod = request.getMethod();
		HandlerMethod hm = (HandlerMethod) handler;
		String userAgent = request.getHeader("User-Agent");
		String reqIp = getReqIpAddr(request);
		String reqUri = request.getServletPath();
		logger.info("User-Agent:{},ReqUri:{},reqMethod:{},reqIp:{})",userAgent, reqUri, reqMethod, reqIp);

		if ("POST".equals(reqMethod)) {
			Map<String, String[]> parameterMap = request.getParameterMap();
			StringBuffer paramString = new StringBuffer();
			for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
				paramString.append(entry.getKey() + ":" + entry.getValue());
			}
			logger.info("post传递参数：" + paramString.toString());
		}

		return super.preHandle(request, response, handler);
	}
}
