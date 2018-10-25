/**
 * Created by wangcheng on 2016/5/3.
 */
var	contextPath;
$(function(){
    contextPath = $("#contextPath").val();
    $("body").showLoadingView();
    //设置openid
    var openid = $.trim($("#openid").val());
    if (openid == undefined || openid == null || openid == ''){
        $("body").alertDialog({
            title: "提示",
            text: "获取openid失败"
        });
        return;
    }
    setCookie('openid', openid);
    var targetUrl;
    var loginType = getCookie('loginType');
    if (loginType == 1){//停车缴费
        targetUrl = "/weixin/index/homepage/init?openid=" + openid;
    } else if (loginType == 3){//邻趣分享
        targetUrl = "/act/linqu/share/init";
    } else if (loginType == 4){//包月界面
        targetUrl = "/weixin/order/park/list/init?openid=" + openid;
    } else if (loginType == 5){//车辆记录详情
        targetUrl = "/weixin/pay/detail?parkingLogId=" + getCookie('param1') + "&openid=" + getCookie('openid')
            + "&webSourceType=" + getCookie('webSourceType') + "&platType=" + getCookie('platType');
    } else if (loginType == 6){//登录注册页
        targetUrl = "/weixin/mem/validate/mobile/init";
    }
    window.location.href = contextPath + targetUrl;
});
