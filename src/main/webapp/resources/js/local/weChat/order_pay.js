/**
 * Created by chengWang on 2016/9/5.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    setTotalAmt();
})
function closeCoupon(){
    $(".coupon_div").css("display", "none");
}

function openCoupon(){
    $(".coupon_div").css("display", "block");
    $(".coupon_content").css("top", ($(window).height() - $(".coupon_content").height()) / 2 + "px");
}

function selectCoupon(obj, id, amt){
    $(".sel_coupon").find(".coupon_detail_sel").attr("src", contextPath + "/resources/images/weChat/order_pay/bg_discount_circle@3x.png");
    $(".sel_coupon").removeClass("sel_coupon");
    $(obj).addClass("sel_coupon");
    $(obj).find(".coupon_detail_sel").attr("src", contextPath + "/resources/images/weChat/order_pay/bg_discount_check@3x.png");
    $("#couponsId").val(id);
    $("#couponsAmt").val(amt);
    $("#couponsAmtDiv").html(amt);
    setTotalAmt();
    closeCoupon();
}

function setTotalAmt(){
    var couponsAmt = parseFloat($("#couponsAmt").val());
    var totalPrice = parseFloat($("#totalPrice").val());
    if (totalPrice - couponsAmt <= 0){
        totalPrice = 0.01;
    } else {
        totalPrice -= couponsAmt;
    }
    $(".pay_amt_text span").html(totalPrice.toFixed(2));
    $("#realPayAmt").val(totalPrice.toFixed(2));
    initSelectPayWay();
}

function initSelectPayWay(){
    var realPayAmt = parseFloat($("#realPayAmt").val());
    var balance =  parseFloat($("#balance").val());
    var platType = getCookie('platType');
    if (platType == 1){//微信支付
        $(".pay_way_ali").css("display", "none");
    }
    if (platType == 2){//支付宝支付
        $(".pay_way_wechat").css("display", "none");
    }
    if (realPayAmt > balance){
        $(".pay_way_balance").removeClass("pay_way_sele");
        $(".pay_way_balance .pay_way_line_img").attr("src", contextPath + "/resources/images/weChat/order_pay/pic_payment_balance@3x.png");
        $(".pay_way_balance div span").css("color", "RGB(99, 99, 99)");
        $(".pay_way_balance .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/order_pay/payment_ring_gray@3x.png");
        if (platType == 1){//微信支付
            selectPayWay($(".pay_way_wechat").get(0), 5);
        }
        if (platType == 2){//支付宝支付
            selectPayWay($(".pay_way_ali").get(0), 6);
        }
    } else {
        $(".pay_way_balance").addClass("pay_way_sele");
        $(".pay_way_balance .pay_way_line_img").attr("src", contextPath + "/resources/images/weChat/order_pay/pic_payment_balance_h@3x.png");
        $(".pay_way_balance div span").css("color", "RGB(255, 90, 90)");
        $(".pay_way_balance .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/order_pay/icon_addfunds_h@3x.png");
        selectPayWay($(".pay_way_balance").get(0), 1);
    }
}

function selectPayWay(obj, payType){
    if (!$(obj).hasClass("pay_way_sele")){
        return;
    }
    $(".pay_way_sele .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/order_pay/icon_addfunds_n@3x.png");
    $(obj).find(".pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/order_pay/icon_addfunds_h@3x.png");
    $("#payWay").val(payType);
}

function payInfoSubmit(obj){
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/order/pay/submit",
        data: {openid : getCookie('openid'), monthlyTypeId : $("#monthlyTypeId").val(), beginDate : $("#beginDate").val().replace(/\//g, ""),
            endDate : $("#endDate").val().replace(/\//g, ""), couponsId : $("#couponsId").val(), carNum : $("#carNum").val(),
            payWay : $("#payWay").val(), orderNo : $("#orderNo").val()},
        success: function(result) {
            if (result.resCode == '000000') {
                if ($("#payWay").val() == 1){//余额支付
                    window.location.href = contextPath + '/weixin/order/list/init';
                } else if ($("#payWay").val() == 6) {//支付宝支付
                    $("#ali_pay_hidden_div").html(result.data.payInfo);
                } else {//微信公众号支付
                    jsApiCall(result.data.appid, result.data.noncestr, result.data.package, result.data.timestamp, result.data.sign, obj);
                }
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
                ajaxButtonRespone(obj);
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
                    okFtn: function () {
                        window.location.href = contextPath + '/weixin/order/list/init';
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