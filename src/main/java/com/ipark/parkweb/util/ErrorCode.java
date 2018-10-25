package com.ipark.parkweb.util;

/**
 * Created by cheng.wang on 2015/6/22.
 */
public enum ErrorCode {
    //系统级
    SUCCESS("000000", "success"),
    SYS_ERROR("999999", "系统异常"),
    FAILED("900000", "操作失败！"),
    SERVER_FAILED("900001", "服务器链接失败"),

    //图片上传
    PIC_TYPE_ERROR("100001", "只支持jpg、png、gif和bmp图片类型"),
    PIC_OVER_SIZE_4M("100002", "图片最大不超过4M");

    private String code;
    private String text;

    private ErrorCode(String code, String text) {
        this.code = code;
        this.text = text;
    }

    public String getCode() {
        return code;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
