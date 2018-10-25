/**
 * Created by wangcheng on 2016/5/30.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();

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
        url: contextPath + "/weixin/mem/code/" + mobile + "/2",
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

function forgetpwd(obj){
    var mobile = $.trim($("#mobile").val());
    var smsCode = $.trim($("#smsCode").val());
    var pwd = $.trim($("#pwd").val());
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
    if (pwd == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入密码"
        });
        return;
    }
    if (pwd.length > 20 || pwd.length < 6) {
        $("body").alertDialog({
            title: "提示",
            text: "密码应大于6位，小于20位"
        });
        return;
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/mem/forgetpwd",
        data: {mobile : mobile, smsCode : smsCode, pwd : pwd},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                $("body").alertDialog({
                    title: "提示",
                    text: "密码修改成功！",
                    okFtn: function(){
                        history.go(-1);
                    }
                });
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }
        }
    });
}