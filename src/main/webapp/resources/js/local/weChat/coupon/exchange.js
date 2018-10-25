/**
 * Created by Cheng Wang on 2016/12/28.
 */
var	contextPath;
$(function(){
    contextPath = $("#contextPath").val();
})

function exchange(obj){
    var exchangeCode = $.trim($("#exc_input").val());
    if (exchangeCode == ""){
        return;
    }

    if (exchangeCode.length > 100){
        $("body").alertDialog({
            title: "提示",
            text: '兑换码长度不能长度不能超过100个字'
        });
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/coupon/exchange",
        data: {exchangeCode : exchangeCode, openid : getCookie('openid')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                $("body").alertDialog({
                    title: "提示",
                    text: '兑换成功！',
                    okFtn: function(){
                        $('body').showLoadingView();
                        window.location.href = contextPath + "/weixin/coupon/list/init";
                    }
                });
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }

        }
    });
}