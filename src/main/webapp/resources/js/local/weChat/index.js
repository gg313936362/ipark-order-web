/**
 * Created by wangcheng on 2016/5/3.
 */
var	contextPath;
$(function(){
    contextPath = $("#contextPath").val();
    $("body").showLoadingView();

    var openid = getCookie('openid');

    var oldWebSourceType = getCookie('webSourceType');
    var webSourceType = $("#webSourceType").val();
    setCookie('webSourceType', webSourceType);

    var loginType = $("#loginType").val();
    setCookie('loginType', loginType);

    var param1 = $("#param1").val();
    setCookie('param1', param1);

    var platType = $("#platType").val();
    setCookie('platType', platType);

    var targetUrl = "/weixin/index/openid/set/" + webSourceType + "/" + platType;

    var mobile = getCookie('login_mobile');
    var password = getCookie('login_psw');
    if (mobile != undefined && mobile != null && mobile != '' && password != undefined && password != null && password != ''){
        targetUrl += "/" + getCookie('login_mobile') + "/" + getCookie('login_psw');
    } else {
        targetUrl += "/0/0";
    }

    if (openid != undefined && openid != null && openid != '' && oldWebSourceType == webSourceType){
        window.location.href = contextPath + targetUrl + "?openid=" + openid;
    } else {
        if (platType == 1) {//微信接入
            window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + $("#weixinAppId").val() + "&redirect_uri="
                + $("#wxAddress").val() + targetUrl + "&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect";
        } else if (platType == 2) {//支付宝生活号接入
            window.location.href = "https://openauth.alipay.com/oauth2/publicAppAuthorize.htm?app_id=" + $("#shenghuoAppId").val() +
                "&scope=auth_base&redirect_uri=" + $("#wxAddress").val() + targetUrl;
        } else if (platType == 3) {//微信公众号接入，我方生成openid
            window.location.href = contextPath + targetUrl;
        }
    }


});
