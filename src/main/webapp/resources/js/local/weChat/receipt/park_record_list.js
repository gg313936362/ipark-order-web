/**
 * Created by chengWang on 2016/8/18.
 */
var	contextPath;
var pageIndex = 1;
var pageSize = 10;
$(function(){
    contextPath = $("#contextPath").val();
    //$(".wrapper_div").css("height", (document.body.scrollHeight - 60) + "px");
    getRecord(1);
    refresher.init({
        id: "wrapper",
        pullDownAction: Refresh,
        pullUpAction: Load
    })
})

function Refresh() {
    setTimeout(function () {
        getRecord(1);
    }, 1000);

}

function Load() {
    setTimeout(function () {
        getRecord(2);
    }, 1000);
}

/**
 * 获取数据
 * @param type （1：下拉；2：上拉加载更多）
 */
function getRecord(type){
    if (type == 1){
        pageIndex = 1;
    }
    if (type == 2 && pageIndex == -1){
        wrapper.refresh();
        return;
    }
    $.ajax({
        type: "get",
        dateType: "json",
        url: contextPath + "/weixin/receipt/record/list",
        data: {openid : getCookie('openid'), pageIndex : pageIndex, pageSize : pageSize},
        success: function(result) {
            if (result.resCode == '000000') {
                if (type == 1){
                    $(".scroller ul").html(
                        "<li class='receipt_list' onclick='jumpListPage();'>" +
                        "<div>开票历史</div>" +
                        "</li>");
                }
                if (result.data.totalSize == 0){
                    $(".scroller ul").append(
                        "<li class='order_none_div' style='height: " + (document.body.offsetHeight) + "px'>" +
                        "<div class='order_none_img'>" +
                        "<img src='" + contextPath + "/resources/images/weChat/receipt/pic_discount_unavailable@3x.png'>" +
                        "</div>" +
                        "<div class='order_none_text'>您没有可开发票的行程</div>" +
                        "<div class='order_none_text1'>说明：尊敬的车主您好，捷惠增值税电子发票已在部分停车场上线了，还有部分场库需直接向场库方索取发票，谢谢</div>" +
                        "</li>");
                    wrapper.refresh();
                    return;
                }
                $(".grab_div").css("display", "block");
                var totalPage = result.data.totalPage;
                if (totalPage <= pageIndex){
                    pageIndex = -1;
                } else {
                    pageIndex++;
                }
                for (var i = 0; i < result.data.data.length; i++){
                    var record = result.data.data[i];
                    $(".scroller ul").append(
                        "<li class='record_div' onclick=\"submitApply('" + record.parkingLogId + "_2', " + record.amount + ")\">" +
                            //"<div class='select_icon'>" +
                            //    "<img src='" + contextPath + "/resources/images/weChat/receipt/payment_ring_gray@3x.png'>" +
                            //"</div>" +
                            "<div class='record_text1'>" +
                                "<div class='record_text_title'>" + record.parkName + "</div>" + "<div class='record_text_type'>临停</div>" +
                            "</div>" +
                            "<div class='record_text2'>" +
                                "<div class='record_text_time_left'>入场时间</div>" +
                                "<div class='record_text_time_right'>" + record.arriveTime + "</div>" +
                            "</div>" +
                            "<div class='record_text2'>" +
                                "<div class='record_text_time_left'>出场时间</div>" +
                                "<div class='record_text_time_right'>" + record.leaveTime + "</div>" +
                            "</div>" +
                            "<div class='record_text3'>" +
                                "<div class='record_text_left'>实收费用：<span>" + record.amount + "</span>元</div>" +
                                "<img class='record_text_arrow' src='" + contextPath + "/resources/images/weChat/receipt/arrow_walletlist@3x.png'>" +
                                "<div class='record_text_right'>开票</div>" +
                            "</div>" +
                        "</li>");
                }
                wrapper.refresh();
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }

        }
    });
}

function submitApply(orderNoAndOrderType, receiptAmt){
    window.location.href = contextPath + "/weixin/receipt/apply/init?orderNoAndOrderType=" + orderNoAndOrderType
        + "&amount=" + receiptAmt + "&openid=" + getCookie('openid');
}

function jumpListPage(){
    window.location.href = contextPath + "/weixin/receipt/list/init";
}

//function selectRecord(obj){
//    if ($(obj).attr("status") == 0){
//        $(obj).attr("status", 1);
//        $(obj).find(".select_icon img").attr("src", contextPath + "/resources/images/weChat/receipt/icon_addfunds_h@3x.png");
//        countTotalAmt();
//    } else {
//        $(obj).attr("status", 0);
//        $(obj).find(".select_icon img").attr("src", contextPath + "/resources/images/weChat/receipt/payment_ring_gray@3x.png");
//        countTotalAmt();
//    }
//}
//
//function countTotalAmt(){
//    var totalAmt = 0;
//    var orderNoAndOrderType = "";
//    for (var i = 0; i < $(".record_div").size(); i++){
//        var _this = $($(".record_div").get(i));
//        if (_this.attr("status") == 1){
//            totalAmt += parseFloat($(_this).find(".record_text3 .record_text_right span").html());
//            orderNoAndOrderType += _this.attr("parkingLogId") + "_" + _this.attr("parkingType") + "|";
//        }
//    }
//    if (orderNoAndOrderType.length > 0){
//        orderNoAndOrderType = orderNoAndOrderType.substring(0, orderNoAndOrderType.length - 1);
//    }
//    $(".receipt_amt_text span").html(totalAmt);
//    $("#orderNoAndOrderType").val(orderNoAndOrderType);
//}
function closeGrab(){
    $(".grab_div").css("display", "none");
}

//function submitApply(){
//    if ($(".receipt_amt_text span").html() == ""){
//        $("body").alertDialog({
//            title: "提示",
//            text: "开票金额不能为0"
//        });
//        return;
//    }
//    window.location.href = contextPath + "weixin/receipt/apply/init?orderNoAndOrderType=" + $("#orderNoAndOrderType").val()
//        + "&amount=" + $(".receipt_amt_text span").html();
//}