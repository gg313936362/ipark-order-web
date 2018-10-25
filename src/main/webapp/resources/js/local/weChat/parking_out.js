/**
 * Created by chengwang on 2016/7/28.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    parseParkingTime();
})

function parseParkingTime(){
    var top_park_tTime = $(".top_park_tTime").html();
    var indexH = top_park_tTime.indexOf("小时");
    var indexM = top_park_tTime.indexOf("分钟");
    var timeoutTimeDiv = "";
    if (indexH >= 0){
        timeoutTimeDiv = "<div class='pay_top_top_big_div'>" +
            "<div class='pay_top_top_big'>" + top_park_tTime.substring(0, indexH) + "</div>" +
            "</div>" +
            "<div class='pay_top_top_small_div'>" +
            "<div class='pay_top_top_small'>时</div>" +
            "</div>";
    }else {
        indexH = -2
    }
    if (indexM >= 0){
        timeoutTimeDiv += "<div class='pay_top_top_big_div'>" +
            "<div class='pay_top_top_big'>" + top_park_tTime.substring(indexH + 2, indexM) + "</div>" +
            "</div>" +
            "<div class='pay_top_top_small_div'>" +
            "<div class='pay_top_top_small'>分</div>" +
            "</div>";
    }
    $(".top_park_tTime").html(timeoutTimeDiv);

    var parkingTime = $("#parking_time").html();
    if (parkingTime != '' && parkingTime != undefined){
        indexH = parkingTime.indexOf("小时");
        indexM = parkingTime.indexOf("分钟");
        var parkingTimeDiv = "总时长：";
        if (indexH >= 0){
            parkingTimeDiv += "<span class='blue'>" + parkingTime.substring(0, indexH) + "</span>小时";
        }
        if (indexM >= 0){
            parkingTimeDiv += "<span class='blue'>" + parkingTime.substring(indexH + 2, indexM) + "</span>分钟";
        }
        $("#parking_time").html(parkingTimeDiv);
    }
}

//支付宝禁用分享
document.addEventListener('AlipayJSBridgeReady', function () {
    AlipayJSBridge.call("hideToolbar");
    AlipayJSBridge.call("hideOptionMenu");
}, false);
