package com.ipark.parkweb.controller.base;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ipark.parkweb.jsonbean.OutJson;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

public class BaseController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private static ObjectMapper mapper = new ObjectMapper();

	protected static final String ENCODING_UTF8 = "UTF-8";

	protected void sendResponse(HttpServletResponse response, HttpResult httpResult){
		OutJson outJB = new OutJson(httpResult.getResCode(), httpResult.getResMsg(), httpResult.getData());
		writeResponse(response, outJB);
	}

	protected void sendResponse(HttpServletResponse response, OutJson outJB){
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

}

 