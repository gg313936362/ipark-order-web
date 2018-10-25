/**
 * Created by chengwang on 2016/8/1.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    initPayWay();
})

function initPayWay(){
    var platType = getCookie('platType');
    if (platType == 1){//微信支付
        $(".pay_way_ali").css("display", "none");
        $("#payWay").val(4);
    }
    if (platType == 2){//支付宝支付
        $(".pay_way_wechat").css("display", "none");
        $("#payWay").val(7);
    }
}

function selectAmt(obj, amt){
    $(".recharge_amt_div_sel").removeClass("recharge_amt_div_sel");
    $(obj).addClass("recharge_amt_div_sel");
    $("#recharge_amt_input").val(amt);
}

function submitPay(obj){
    var amt = $.trim($("#recharge_amt_input").val());
    if (amt == ''){
        return;
    }
    if(!/^\d+(\.\d+)?$/.test(amt)){
        $("body").alertDialog({
            title: "提示",
            text: "金额必须是数字"
        });
        return;
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/account/pay/info",
        data: {openid : getCookie('openid'), amount : $.trim($("#recharge_amt_input").val()), payWay : $("#payWay").val()},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                if ($("#payWay").val() == 7) {//支付宝支付
                    $("#ali_pay_hidden_div").html(result.data.payInfo);
                } else {//微信支付
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
                        location.reload();
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