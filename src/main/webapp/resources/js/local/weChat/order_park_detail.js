/**
 * Created by chengWang on 2016/9/1.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    $(".slider").yxMobileSlider({width:700,height:400,during:5000});
    $(".detail_distance").html(distancePares($("#distance").val()));
    paresTime();
})

function distancePares(distance){
    if (distance < 1000){
        return parseFloat(distance).toFixed(1) + "m";
    } else {
        return (distance / 1000).toFixed(1) + "km";
    }
}

function paresTime(){
    $(".order_tip_right").each(function(){
        var time = $(this).html();
        if (time.indexOf("-") >= 0){
            time = time.split("-");
            $(this).html(time[0].substring(0, 2) + "：" + time[0].substring(2, 4) + "-" + time[1].substring(0, 2) + "：" + time[1].substring(2, 4));
        }
    });
}

function jumpOrderParkTypePage(monthlyTypeId){
    window.location.href = contextPath + "/weixin/order/park/type/init?openid=" + getCookie('openid')
        + "&monthlyTypeId=" + monthlyTypeId + "&monthlyBeginDate=0&orderNo=0";
}