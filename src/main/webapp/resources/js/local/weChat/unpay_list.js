/**
 * Created by ChengWang on 2016/8/12.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    if ($("#totalAmt").val() == 0){
        window.location.href = contextPath + "/weixin/index/homepage/init?openid=" + getCookie('openid') + "&webSourceType=" + getCookie('webSourceType');
    }
    initSelectPayWay();
})

function initSelectPayWay(){
    var totalAmt = parseFloat($("#totalAmt").val());
    var balance =  parseFloat($("#balance").val());
    var platType = getCookie('platType');
    if (platType == 1){//微信支付
        $(".pay_way_ali").css("display", "none");
    }
    if (platType == 2){//支付宝支付
        $(".pay_way_wechat").css("display", "none");
    }
    if (totalAmt > balance){
        $(".pay_way_balance").removeClass("pay_way_sele");
        $(".pay_way_balance .pay_way_line_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/pic_payment_balance@3x.png");
        $(".pay_way_balance div span").css("color", "RGB(99, 99, 99)");
        $(".pay_way_balance .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/payment_ring_gray@3x.png");
        if (platType == 1){//微信支付
            selectPayWay($(".pay_way_wechat").get(0), 4);
        }
        if (platType == 2){//支付宝支付
            selectPayWay($(".pay_way_ali").get(0), 7);
        }
    } else {
        $(".pay_way_balance").addClass("pay_way_sele");
        $(".pay_way_balance .pay_way_line_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/pic_payment_balance_h@3x.png");
        $(".pay_way_balance div span").css("color", "RGB(255, 90, 90)");
        $(".pay_way_balance .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/icon_addfunds_h@3x.png");
        selectPayWay($(".pay_way_balance").get(0), 3);
    }
}

function selectPayWay(obj, payType){
    if (!$(obj).hasClass("pay_way_sele")){
        return;
    }
    $(".pay_way_sele .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/icon_addfunds_n@3x.png");
    $(obj).find(".pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay/icon_addfunds_h@3x.png");
    $("#payWay").val(payType);
}

function showPayWay(){
    $(".pay_way_back").css("opacity", "0");
    $(".pay_way_content").css("top", $(window).height() + "px");
    $(".pay_way_div").css("display", "block");
    $(".pay_way_back").animate({"opacity" : "0.5"}, 200);
    $(".pay_way_content").animate({"top" : ($(window).height() - 258) + "px"}, 200);
}

function hiddenPayWay(){
    $(".pay_way_back").animate({"opacity" : "0"}, 200);
    $(".pay_way_content").animate({"top" : $(window).height() + "px"}, 200, null, function () {
        $(".pay_way_div").css("display", "none");
    });
}

function submitPay(obj){
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/pay/unpay/pay/info",
        data: {payWay : $("#payWay").val(), openid : getCookie('openid')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                if ($("#payWay").val() == 3){
                    window.location.href = contextPath + "/weixin/index/homepage/init?openid=" + getCookie('openid');
                } else if ($("#payWay").val() == 7) {
                    $("#ali_pay_hidden_div").html(result.data.payInfo);
                } else {
                    jsApiCall(result.data.appid, result.data.noncestr, result.data.package, result.data.timestamp, result.data.sign, obj);
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

//调用微信JS api 支付
function jsApiCall(appid, noncestr, package, timestamp, paysign, obj) {
    WeixinJSBridge.invoke(
        'getBrandWCPayRequest',
        {
            "appId": appid,
            "nonceStr": noncestr,
            "package": package,
            "signType": "MD5",
            "timeStamp": timestamp,
            "paySign": paysign
        },
        function (res) {
            //WeixinJSBridge.log(res.err_msg);
            // alert(res.err_code+res.err_desc+res.err_msg);
            if (res.err_msg == "get_brand_wcpay_request:ok") {
                $("body").alertDialog({
                    title: "提示",
                    text: "微信支付成功!",
                    okFtn: function(){
                        window.location.href = contextPath + "/weixin/index/homepage/init?openid=" + getCookie('openid');
                    }
                });
            } else if (res.err_msg == "get_brand_wcpay_request:cancel") {
                $("body").alertDialog({
                    title: "提示",
                    text: "用户取消支付!"
                });
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: "支付失败!"
                });
            }
            ajaxButtonRespone(obj);
        }
    );
}

function jumpRecordDetailPage(parkingLogId){
    window.location.href = contextPath + "/weixin/pay/detail?openid=" + getCookie('openid') + "&parkingLogId="
        + parkingLogId + "&webSourceType=" + getCookie('webSourceType') + "&platType=" + getCookie('platType');
}