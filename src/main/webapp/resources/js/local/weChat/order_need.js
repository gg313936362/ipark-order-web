/**
 * Created by chengWang on 2016/8/30.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
})

function submitNeed(obj){
    var mobile = $.trim($("#mobile").val());
    var parkingAddress = $.trim($("#parkingAddress").val());
    if (mobile == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入手机号"
        });
        return;
    }
    if (!mobile.match("^[1][0-9]{10}$")) {
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的手机号"
        });
        return;
    }
    if (parkingAddress == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入所需停车场名称"
        });
        return;
    }
    if (parkingAddress.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "停车场名称不能超过50个字"
        });
        return;
    }
    if (ajaxButtonRequest(obj)){
        return;
    }
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/order/park/need/submit",
        data: {mobile : mobile, parkingAddress : parkingAddress, openid : getCookie('openid')},
        success: function(result) {
            ajaxButtonRespone(obj);
            if (result.resCode == '000000') {
                $("body").alertDialog({
                    title: "提示",
                    text: "需求已提交<br>如有合适的车位，<br>捷停将第一时间通知您"
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