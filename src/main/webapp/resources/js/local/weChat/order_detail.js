/**
 * Created by chengWang on 2016/9/8.
 */
var	contextPath;
$(function(){
    contextPath = $("#contextPath").val();
})

function jumpOrderPayDetailPage(orderNo){
    window.location.href = contextPath + "/weixin/order/pay/detail/init/" + getCookie('openid') + "/" + orderNo;
}