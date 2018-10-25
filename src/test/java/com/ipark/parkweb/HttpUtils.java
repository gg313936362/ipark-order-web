package com.ipark.parkweb;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ipark.parkweb.util.ErrorCode;
import com.ipark.parkweb.util.ServerHttpUtils.HttpResult;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.StringUtils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.zip.GZIPInputStream;

/**
 * Created by wangcheng on 2016/4/15.
 */
public class HttpUtils {

    private static final Logger logger = LogManager.getLogger(HttpUtils.class);

    protected static final String ENCODING = "UTF-8";
    protected static final String GET = "GET";
    protected static final String POST = "POST";
    protected static final String WEB_ADDRESS = "http://testwx.jiepark.com";

    protected static ObjectMapper mapper = new ObjectMapper();

    protected static HttpResult sendWebReq(String mothod, String reqUrl, String content) throws Exception{
        logger.info("向web端发送http请求......");
        StringBuilder strBu = new StringBuilder();
        BufferedReader bin = null;

        HttpURLConnection conn = null;
        HttpResult httpResult = null;
        try {
            reqUrl = WEB_ADDRESS + reqUrl;
            logger.info("请求的URL："+ reqUrl);

            boolean haveContent = StringUtils.hasText(content);
            boolean postMethod = false;
            if(POST.equals(mothod)){
                postMethod = true;
            }
            if(GET.equals(mothod) && haveContent){
                reqUrl =  reqUrl + "?" + content;
                logger.info("get发送完整url：" + reqUrl);
            }

            URL url = new URL(reqUrl);
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(100000);
            conn.setReadTimeout(80000);
            conn.setDoOutput(postMethod);
            conn.setDoInput(true);
            conn.setRequestMethod(mothod);
            conn.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式
            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded"); // 设置传输的格式application/x-www-form-urlencoded
            conn.connect();
            if(postMethod && haveContent){
                logger.info("post发送数据：" + content);
                OutputStream out = conn.getOutputStream();
                byte[] reqData = content.getBytes(ENCODING);
                out.write(reqData);
                out.flush();
                out.close();
            }

            InputStream in = conn.getInputStream();

            bin = null;
            int resCode = conn.getResponseCode();
            if (resCode == 200) {
                GZIPInputStream gzin = new GZIPInputStream(in);
                InputStreamReader isr = new InputStreamReader(gzin, ENCODING);

                bin = new BufferedReader(isr);
                String s = null;
                while ((s = bin.readLine()) != null) {
                    strBu.append(s);
                }
                logger.info("web端http请求成功，返回数据：" + strBu.toString());
                httpResult = mapper.readValue(strBu.toString(), HttpResult.class);
            }else{
                logger.info("web端http请求出错，错误码：" + resCode);
            }
        } catch (Exception e) {
            httpResult = new HttpResult(ErrorCode.SERVER_FAILED.getCode(), ErrorCode.SERVER_FAILED.getText());
            logger.info("web端http请求异常，", e);
        }finally {
            if(bin != null){
                bin.close();
            }
			if(conn != null){
				conn.disconnect();
			}
        }

        return httpResult;
    }
}
