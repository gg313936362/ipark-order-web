/**
 * Created by wangcheng on 2016/5/30.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    $("#carNum").carNumBoard();

    $('#mobile').bind('input propertychange', function() {
        var mobile = $.trim($("#mobile").val());
        if (mobile.length > 11){
            $("#mobile").val(mobile.substring(0, 11));
        }
    });
    $('#smsCode').bind('input propertychange', function() {
        var smsCode = $.trim($("#smsCode").val());
        if (smsCode.length > 6){
            $("#smsCode").val(smsCode.substring(0, 6));
        }
    });
})

function getCode(){
    if ($("#code_button").attr("status") == 1){
        return;
    }
    var mobile = $.trim($("#mobile").val());
    if (mobile == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入手机号"
        });
        return;
    }
    if (!mobile.match("^[1][0-9]{10}$")) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的手机号"
        });
        return;
    }
    $.ajax({
        type: "get",
        dateType: "json",
        url: contextPath + "/weixin/mem/code/" + mobile + "/1",
        data: null,
        success: function(result) {
            if (result.resCode == '000000') {
                $("#code_button").html("60s后重新发送");
                $("#code_button").attr("status", 1);

                var timer = setInterval(function(){
                    var btnVal = $("#code_button").html().split("s");
                    var s = parseInt(btnVal[0],10);
                    if (s > 0) {
                        $("#code_button").html((s - 1) + 's后重新发送');
                    } else {
                        $("#code_button").html("获得验证码");
                        $("#code_button").attr("status", 0);
                        clearInterval(timer);
                    }
                },1000);
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }

        }
    });
}

function register(obj){
    var mobile = $.trim($("#mobile").val());
    var smsCode = $.trim($("#smsCode").val());
    var carNum = $.trim($("#carNum").html());
    var openid = getCookie('openid');
    if (mobile == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入手机号"
        });
        return;
    }
    if (!mobile.match("^[1][0-9]{10}$")) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的手机号"
        });
        return;
    }
    if (smsCode == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入手机验证码"
        });
        return;
    }
    if (carNum == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入车牌号"
        });
        return;
    }
    if (!(carNum.match("^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9_港_澳]{5}$") || carNum.match("^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9_港_澳]{6}$"))) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的车牌号"
        });
        return;
    }
    if (openid == undefined || openid == '' || openid == null || openid == 'null'){
        $("body").alertDialog({
            title: "提示",
            text: "未获取openid，请先关注‘捷停’公众号"
        });
        return;
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/mem/reg",
        data: {mobile : mobile, smsCode : smsCode, carNum : carNum, openid : getCookie('openid'), webSourceType : getCookie('webSourceType')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                setCookie('mobile',mobile);
                var loginType = getCookie('loginType');
                if (loginType == 1){
                    window.location.href = contextPath + "/weixin/index/homepage/init?openid=" + getCookie('openid');
                }
                if (loginType == 4){
                    window.location.href = contextPath + "/weixin/order/park/list/init?openid=" + getCookie('openid');
                }
                if (loginType == 5){//车辆记录详情
                    window.location.href = contextPath + "/weixin/pay/detail?parkingLogId=" + getCookie('param1') + "&openid="
                        + openid + "&webSourceType=" + getCookie('webSourceType') + "&platType=" + getCookie('platType');
                }
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }
        }
    });
}

function forwardLogin(){
    window.location.href = contextPath + "/weixin/mem/log/init";
}