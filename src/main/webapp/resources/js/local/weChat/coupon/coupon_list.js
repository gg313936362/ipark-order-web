/**
 * Created by wangcheng on 2016/5/18.
 */
var	contextPath;
var pageIndex = 1;
var pageSize = 10;
$(function(){
    contextPath = $("#contextPath").val();
    getCoupon(1);
    refresher.init({
        id: "wrapper",
        pullDownAction: Refresh,
        pullUpAction: Load
    })

})
function Refresh() {
    setTimeout(function () {
        getCoupon(1);
    }, 1000);

}

function Load() {
    setTimeout(function () {
        getCoupon(2);
    }, 1000);
}
/**
 * 获取数据
 * @param type （1：下拉；2：上拉加载更多）
 */
function getCoupon(type){
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
        url: contextPath + "/weixin/coupon/get/" + getCookie('openid') + "/" + pageIndex + "/" + pageSize,
        data: null,
        success: function(result) {
            if (result.resCode == '000000') {
                if (type == 1){
                    $(".scroller ul").html(
                        "<li class='rule' onclick='jumpRulPage();'>" +
                        "<div>使用规则</div>" +
                        "<img src='" + contextPath + "/resources/images/weChat/coupon/coupon_list/icon_discount_regulation@3x.png'>" +
                        "</li>");
                }
                if (result.data.totalSize == 0){
                    $(".scroller ul").append(
                        "<li class='coupon_none' style='height: " + (document.body.offsetHeight - 58) + "px'>" +
                            "<div class='coupon_none_img'>" +
                                "<img src='" + contextPath + "/resources/images/weChat/coupon/coupon_list/pic_discount_unavailable@3x.png'>" +
                            "</div>" +
                            "<div class='coupon_none_text'>您没有优惠券</div>" +
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
                    var coupon = result.data.data[i];
                    var status = coupon.status;//1：未使用 2：已使用 3：已过期
                    var grayClass;
                    var grayImg;
                    var grayYuanImg;
                    if (status == 1){
                        grayClass = "";
                        grayImg = "";
                        grayYuanImg = "icon_discount_unused￥@3x.png";
                    } else if (status == 2){
                        grayClass = "class='gray'";
                        grayImg = "<img class='status_img' src='" + contextPath + "/resources/images/weChat/coupon/coupon_list/state_discount_pastdue@3x.png'>";
                        grayYuanImg = "icon_discount_used￥@3x.png";
                    } else if (status == 3){
                        grayClass = "class='gray'";
                        grayImg = "<img class='status_img' src='" + contextPath + "/resources/images/weChat/coupon/coupon_list/state_discount_used@3x.png'>";
                        grayYuanImg = "icon_discount_used￥@3x.png";
                    }
                    $(".scroller ul").append(
                        "<li " + grayClass + ">" +
                            grayImg +
                            "<div class='detail'>" +
                                "<div class='detail_text'>" +
                                    "<div class='detail_name'>" + coupon.name + "</div>" +
                                    "<div class='detail_name_end'>元优惠券</div>" +
                                    "<div class='detail_end_date'>有效期至：" + coupon.endTime + "</div>" +
                                "</div>" +
                                "<div class='detail_amt'>" + coupon.amt.toFixed(2) + "</div>" +
                                "<img class='yuan_img' src='" + contextPath + "/resources/images/weChat/coupon/coupon_list/" + grayYuanImg + "'>" +
                            "</div>" +
                        "</li>");
                }
                wrapper.refresh();
            } else {
                alert(result.resMsg);
            }

        }
    });
}

function jumpRulPage(){
    window.location.href = 'http://app.jiepark.com/app/h5/coupon_rule.html';
}