package com.ipark.parkweb.util.ServerHttpUtils;

/**
 * Created by cheng.wang on 15/10/28.
 */
public class HttpResult {

    private String resCode;
    private String resMsg;
    private Object data;

    public HttpResult(){}

    public HttpResult(String resCode, String resMsg){
        this.resCode = resCode;
        this.resMsg = resMsg;
    }

    public String getResCode() {
        return resCode;
    }

    public void setResCode(String resCode) {
        this.resCode = resCode;
    }

    public String getResMsg() {
        return resMsg;
    }

    public void setResMsg(String resMsg) {
        this.resMsg = resMsg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
