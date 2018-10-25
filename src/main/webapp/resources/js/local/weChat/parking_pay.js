/**
 * Created by chengwang on 2016/7/19.
 */
var	contextPath;
var imagePath = "/";
$(function() {
    contextPath = $("#contextPath").val();
    if ($("#isAliCityServer").val() == 1){//如果是支付宝城市服务，换图片颜色
        imagePath = "/ali/";
    }
    parseParkingTime();
    setTotalAmt();
    setCookie("homepageRefreshFlag", 1);//设置首页刷新flag,1则返回首页要刷新页面
    //isNetworking();
})

//判断是否断网
function isNetworking(){
    var isNetworking = $("#isNetworking").val();
    if (isNetworking == 0){//如果断网
        $(".net_div").css("display", "block");
        $(".pay_button").css("background", "RGB(210, 210, 210)");
        $(".pay_button").attr("onclick", "$('.net_div').css('display', 'block');");
    }
}

function parseParkingTime(){
    var parkingTime = $("#parking_time").html();
    var indexH = parkingTime.indexOf("小时");
    var indexM = parkingTime.indexOf("分钟");
    var parkingTimeDiv = "";
    if (indexH >= 0){
        parkingTimeDiv = "<div class='pay_top_top_big_div'>" +
                            "<div class='pay_top_top_big'>" + parkingTime.substring(0, indexH) + "</div>" +
                         "</div>" +
                         "<div class='pay_top_top_small_div'>" +
                            "<div class='pay_top_top_small'>时</div>" +
                         "</div>";
    }
    if (indexM >= 0){
        parkingTimeDiv += "<div class='pay_top_top_big_div'>" +
                            "<div class='pay_top_top_big'>" + parkingTime.substring(indexH + 2, indexM) + "</div>" +
                          "</div>" +
                          "<div class='pay_top_top_small_div'>" +
                            "<div class='pay_top_top_small'>分</div>" +
                          "</div>";
    }
    $("#parking_time").html(parkingTimeDiv);
}

function closeCoupon(){
    $(".coupon_div").css("display", "none");
}

function openCoupon(){
    $(".coupon_div").css("display", "block");
    $(".coupon_content").css("top", ($(window).height() - $(".coupon_content").height()) / 2 + "px");
}

function selectCoupon(obj, id, amt){
    $(".sel_coupon").find(".coupon_detail_sel").attr("src", contextPath + "/resources/images/weChat/parking_pay" + imagePath + "bg_discount_circle@3x.png");
    $(".sel_coupon").removeClass("sel_coupon");
    $(obj).addClass("sel_coupon");
    $(obj).find(".coupon_detail_sel").attr("src", contextPath + "/resources/images/weChat/parking_pay" + imagePath + "bg_discount_check@3x.png");
    $("#couponsId").val(id);
    $("#couponsAmt").val(amt);
    $("#couponsAmtDiv").html(amt);
    setTotalAmt();
    closeCoupon();
}

function setTotalAmt(){
    var couponsAmt = $("#couponsAmt").val();
    var parkingAmt = $("#parkingAmt").val();
    var unPayAmt = $("#unPayAmt").val();
    var serviceFee = $("#serviceFee").val();
    if (parkingAmt - couponsAmt <= 0){
        if (parseFloat(unPayAmt) + parseFloat(serviceFee) > 0){
            parkingAmt = 0;
        } else {
            parkingAmt = 0.01;
        }
    } else {
        parkingAmt -= couponsAmt;
    }
    $("#totalAmtDiv").html((parseFloat(parkingAmt) + parseFloat(unPayAmt) + parseFloat(serviceFee)).toFixed(2));
    $("#realPayAmt").val((parseFloat(parkingAmt) + parseFloat(unPayAmt) + parseFloat(serviceFee)).toFixed(2));
    initSelectPayWay();
}

function showPayWay(){
    $(".pay_way_back").css("opacity", "0");
    $(".pay_way_content").css("top", $(window).height() + "px");
    $(".pay_way_div").css("display", "block");
    $(".pay_way_back").animate({"opacity" : "0.5"}, 200);
    $(".pay_way_content").animate({"top" : ($(window).height() - 208) + "px"}, 200);
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
    var isAliCityServer = 0;
    if ($("#isAliCityServer").val() == 1){
        isAliCityServer = 1;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/pay/detail/submit",
        data: {couponsId : $("#couponsId").val(), parkingLogId : $("#parkingLogId").val(), payWay : $("#payWay").val(),
            openid : getCookie('openid'), parkId : $("#parkId").val(), isAliCityServer : isAliCityServer},
        success: function(result) {
            if (result.resCode == '000000') {
                if ($("#payWay").val() == 3){//余额支付
                    location.reload();
                } else if ($("#payWay").val() == 7) {//支付宝支付
                    $("#ali_pay_hidden_div").html(result.data.payInfo);
                } else {//微信支付
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

function initSelectPayWay(){
    var totalAmt = parseFloat($("#realPayAmt").val());
    var balance =  parseFloat($("#balance").val());
    var platType = getCookie('platType');
    if (platType == 1){//微信支付
        $(".pay_way_ali").css("display", "none");
    }
    if (platType == 2){//支付宝支付
        $(".pay_way_wechat").css("display", "none");
    }
    if ($("#isAliCityServer").val() == 1){
        balance = 0;
        $(".pay_way_balance").css("display", "none");//如果是支付宝城市服务支付，则禁止使用余额支付
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
    $(".pay_way_sele .pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay" + imagePath + "icon_addfunds_n@3x.png");
    $(obj).find(".pay_way_line_seled_img").attr("src", contextPath + "/resources/images/weChat/parking_pay" + imagePath + "icon_addfunds_h@3x.png");
    $("#payWay").val(payType);
}

function jumpUnpayPage(){
    window.location.href = contextPath + "/weixin/pay/unpay?openid=" + getCookie('openid');
}

function jumpSevenDisPage(){
    window.location.href = contextPath + "/act/sevenDis/init?openid=" + getCookie('openid');
}

function jumpCouponPage(){
    window.location.href = contextPath + "/weixin/coupon/list/init";
}
//支付宝禁用分享
document.addEventListener('AlipayJSBridgeReady', function () {
    AlipayJSBridge.call("hideToolbar");
    AlipayJSBridge.call("hideOptionMenu");
}, false);

function closeGrab(){
    $(".grab_div").css("display", "none");
}
//抢车位
function grab(){
    $('body').showLoadingView();
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/act/sevenDis/grab",
        data: {openid: getCookie("openid"), parkingLogId: $("#parkingLogId").val()},
        success: function (result) {
            if (result.resCode == '000000') {
                location.reload();
                $(".grab_div").css("display", "block");
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
                $('body').hiddenLoadingView();
            }

        }
    });
}