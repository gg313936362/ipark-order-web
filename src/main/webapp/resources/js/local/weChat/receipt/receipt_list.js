/**
 * Created by chengWang on 2016/8/18.
 */
var	contextPath;
var pageIndex = 1;
var pageSize = 10;
$(function(){
    contextPath = $("#contextPath").val();
    getReceipt(1);
    refresher.init({
        id: "wrapper",
        pullDownAction: Refresh,
        pullUpAction: Load
    })
})

function Refresh() {
    setTimeout(function () {
        getReceipt(1);
    }, 1000);

}

function Load() {
    setTimeout(function () {
        getReceipt(2);
    }, 1000);
}

/**
 * 获取数据
 * @param type （1：下拉；2：上拉加载更多）
 */
function getReceipt(type){
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
        url: contextPath + "/weixin/receipt/list",
        data: {openid : getCookie('openid'), pageIndex : pageIndex, pageSize : pageSize},
        success: function(result) {
            if (result.resCode == '000000') {
                if (type == 1){
                    $(".scroller ul").html("");
                }
                if (result.data.totalSize == 0){
                    $(".scroller ul").append(
                        "<li class='order_none_div' style='height: " + (document.body.offsetHeight) + "px'>" +
                        "<div class='order_none_img'>" +
                        "<img src='" + contextPath + "/resources/images/weChat/receipt/pic_discount_unavailable@3x.png'>" +
                        "</div>" +
                        "<div class='order_none_text'>您暂无开票记录</div>" +
                        "</li>");
                    wrapper.refresh();
                    return;
                }
                var totalPage = result.data.totalPage;
                if (totalPage <= pageIndex){
                    pageIndex = -1;
                } else {
                    pageIndex++;
                }
                for (var i = 0; i < result.data.data.length; i++){
                    var receipt = result.data.data[i];
                    $(".scroller ul").append(
                        "<li class='receipt_div' onclick=\"jumpDetailPage('" + receipt.id + "')\">" +
                            "<img class='receipt_arrow' src='" + contextPath + "/resources/images/weChat/receipt/arrow_walletlist@3x.png'>" +
                            "<div class='receipt_line'>" +
                                "<div class='receipt_name'>电子发票</div>" +
                                "<div class='receipt_date'>" + receipt.applyTime + "</div>" +
                            "</div>" +
                            "<div class='receipt_line'>" +
                                "<div class='receipt_amt'>实收费用：<span>" + receipt.totalAmt + "</span>元</div>" +
                                "<div class='receipt_status " + (receipt.status == 0 ? "receipt_status_green" : "") + "'>" + (receipt.status == 0 ? "待开票" : "已开票") + "</div>" +
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

function jumpDetailPage(receiptId){
    window.location.href = contextPath + "/weixin/receipt/detail/init?openid=" + getCookie('openid') + "&receiptId=" + receiptId;
}