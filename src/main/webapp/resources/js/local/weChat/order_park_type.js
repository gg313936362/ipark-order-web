/**
 * Created by chengWang on 2016/9/1.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
})
function showSelCarNum(){
    $(".car_num_sel_div").css("top", $(window).height() + "px");
    $("#car_num_sel").css("display", "block");
    $(".car_num_sel_back").animate({"opacity" : "0.6"}, 200);
    $(".car_num_sel_div").animate({"top" : ($(window).height() - $(".car_num_sel_div").height()) + "px"}, 200);
}

function hiddenSelCarNum(){
    $(".car_num_sel_back").animate({"opacity" : "0"}, 200);
    $(".car_num_sel_div").animate({"top" : $(window).height() + "px"}, 200, null, function () {
        $("#car_num_sel").css("display", "none");
    });
}

function selectCarNum(obj){
    var carNum = $(obj).html();
    $("#carNumDiv").html(carNum);
    $("#carNum").val(carNum);
    hiddenSelCarNum();
}

function jumpAddCarNumPage(){
    window.location.href = contextPath + "/weixin/car/list/add/init";
}

function selectDate(){
    var selDate = $("#hiddenDate").val();
    if (selDate == ""){
        return;
    }
    selDate = selDate.replace(/-/g, "/");
    var minBeginDate = $("#minBeginDate").val();
    var maxBeginDate = $("#maxBeginDate").val();
    if (selDate < minBeginDate || selDate > maxBeginDate){
        $("body").alertDialog({
            title: "提示",
            text: "包月开始日期应在<br>" + minBeginDate + "到" + maxBeginDate
        });
        return;
    }
    window.location.href = contextPath + "/weixin/order/park/type/init?openid=" + getCookie('openid')
        + "&monthlyTypeId=" + $("#monthlyTypeId").val() + "&monthlyBeginDate=" + selDate;
    $("body").showLoadingView();
}

function submitOrder(monthCount, beginDate, endDate, totalPrice){
    var carNum = $("#carNum").val();
    if (carNum == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请选择车牌"
        });
        return;
    }
    window.location.href = contextPath + "/weixin/pay/order?openid=" + getCookie('openid') +
        "&monthlyTypeId=" + $("#monthlyTypeId").val() + "&monthCount=" + monthCount + "&beginDate="
        + beginDate + "&endDate=" + endDate + "&totalPrice=" + totalPrice + "&carNum=" + carNum + "&orderNo=" + $("#orderNo").val();
}