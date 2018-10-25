/**
 * Created by ChengWang on 2017/4/7.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
})

function optionSwitch(){
    if ($(".content_input_hidden").css("display") == "none"){
        $(".content_optional img").attr("src", contextPath + "/resources/images/weChat/receipt/icon_addfunds_h@3x.png");
        $(".content_input_hidden").css("display", "block");
    } else {
        $(".content_optional img").attr("src", contextPath + "/resources/images/weChat/receipt/icon_addfunds_n@3x.png");
        $(".content_input_hidden").css("display", "none");
    }
}

function jumpInstructionPage(){
    window.location.href = contextPath + "/receipt/instruction/init";
}

function register(obj){
    var orderNoAndOrderType = $.trim($("#orderNoAndOrderType").val());
    var gmfMc = $.trim($("#gmfMc").val());
    var gmfSjh = $.trim($("#gmfSjh").val());
    var gmfDzyx = $.trim($("#gmfDzyx").val());
    var gmfNsrsbh = $.trim($("#gmfNsrsbh").val());
    var gmfDz = $.trim($("#gmfDz").val());
    var gmfDh = $.trim($("#gmfDh").val());
    var gmfKhh = $.trim($("#gmfKhh").val());
    var gmfYhzh = $.trim($("#gmfYhzh").val());
    if (gmfMc == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入发票抬头"
        });
        return;
    }
    if (gmfMc.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "发票抬头不能超过50个字"
        });
        return;
    }
    if (gmfSjh == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入手机号"
        });
        return;
    }
    if (!gmfSjh.match("^[1][0-9]{10}$")) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的手机号"
        });
        return;
    }
    if (gmfDzyx == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入电子邮箱"
        });
        return;
    }
    if (!gmfDzyx.match("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")){
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的电子邮箱"
        });
        return;
    }
    if (gmfDzyx.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "电子邮箱不能超过50个字"
        });
        return;
    }
    if (gmfNsrsbh.length > 100){
        $("body").alertDialog({
            title: "提示",
            text: "纳税人识别号不能超过100个字"
        });
        return;
    }
    if (gmfDz.length > 100){
        $("body").alertDialog({
            title: "提示",
            text: "地址不能超过100个字"
        });
        return;
    }
    if (gmfDh.length > 100){
        $("body").alertDialog({
            title: "提示",
            text: "电话不能超过100个字"
        });
        return;
    }
    if (gmfKhh.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "开户行名称不能超过50个字"
        });
        return;
    }
    if (gmfYhzh.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "银行账号不能超过50个字"
        });
        return;
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/receipt/apply/submit",
        data: {orderNoAndOrderType : orderNoAndOrderType, gmfMc : gmfMc, gmfSjh : gmfSjh, gmfDzyx : gmfDzyx, gmfNsrsbh : gmfNsrsbh,
            gmfDz : gmfDz, gmfDh : gmfDh, gmfKhh : gmfKhh, gmfYhzh : gmfYhzh, openid : getCookie('openid')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                $("body").alertDialog({
                    title: "提示",
                    text: "开票成功",
                    okFtn: function(){
                        window.location.href = contextPath + "/weixin/receipt/list/init";
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