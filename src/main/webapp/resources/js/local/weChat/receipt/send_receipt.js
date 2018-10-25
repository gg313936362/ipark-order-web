/**
 * Created by ChengWang on 2017/4/7.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
})


function send(){
    var email = $.trim($("#email_input").val());
    if (email == ""){
        $("body").alertDialog({
            title: "提示",
            text: "请输入电子邮箱"
        });
        return;
    }
    if (!email.match("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$")){
        $("body").alertDialog({
            title: "提示",
            text: "请输入正确格式的电子邮箱"
        });
        return;
    }
    if (email.length > 50){
        $("body").alertDialog({
            title: "提示",
            text: "电子邮箱不能超过50个字"
        });
        return;
    }
    $("body").showLoadingView();
    $.ajax({
        type: "post",
        dateType: "json",
        url: contextPath + "/weixin/receipt/send",
        data: {email : email, receiptId : $("#receiptId").val(), openid : getCookie('openid')},
        success: function(result) {
            $("body").hiddenLoadingView();
            if (result.resCode == '000000') {
                $("body").alertDialog({
                    title: "提示",
                    text: "电子发票已发送到你的邮箱，请查收"
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