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
})

function login(obj){
    var mobile = $.trim($("#mobile").val());
    var pwd = $.trim($("#pwd").val());
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
        url: contextPath + "/weixin/mem/log",
        data: {mobile : mobile, pwd : pwd, openid : openid, webSourceType : getCookie('webSourceType')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                setCookie('mobile',mobile);
                setCookie('login_mobile', mobile);
                setCookie('login_psw', pwd);
                var loginType = getCookie('loginType');
                if (loginType == 1){
                    window.location.href = contextPath + "/weixin/index/homepage/init?openid=" + openid;
                }
                if (loginType == 4){
                    window.location.href = contextPath + "/weixin/order/park/list/init?openid=" + openid;
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

function forwardRegister(){
    window.location.href = contextPath + "/weixin/mem/reg/init";
}
function forwardForgetpwd(){
    window.location.href = contextPath + "/weixin/mem/forgetpwd/init";
}