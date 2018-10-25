package com.ipark.parkweb.jsonbean;

/**
 * Created by cheng.wang on 2015/7/29.
 */
public class OutJson {
    private String resCode;
    private String resMsg;
    private Object data;

    public OutJson(String resCode, String resMsg, Object data){
        this.resCode = resCode;
        this.resMsg = resMsg;
        this.data = data;
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
