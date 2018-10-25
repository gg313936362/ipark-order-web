/**
 * Created by Cheng Wang on 2016/11/24.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
})

function submit(feedbackType){
    $("body").confirmDialog({
        title: "提示",
        text: "是否确认反馈该问题？",
        okFtn: function(){
            $("body").showLoadingView();
            $.ajax({
                type: "post",
                dateType: "json",
                url: contextPath + "/weixin/problem/submit",
                data: {parkingLogId : $("#parkingLogId").val(), openid : getCookie('openid'), feedbackType : feedbackType},
                success: function(result) {
                    if (result.resCode == '000000') {
                        window.location.href = contextPath + "/weixin/problem/success?feedbackType=" + feedbackType;
                    } else {
                        $("body").hiddenLoadingView();
                        $("body").alertDialog({
                            title: "提示",
                            text: result.resMsg
                        });
                    }
                }
            });
        }
    });
}