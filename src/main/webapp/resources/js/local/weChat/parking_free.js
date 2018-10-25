/**
 * Created by chengwang on 2016/7/21.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    parseParkingTime();
    window.setInterval("runTimer();", 1000);
    setCookie("homepageRefreshFlag", 1);//设置首页刷新flag,1则返回首页要刷新页面
    initSharePage();//初始化所有分享功能，支付宝生活号隐藏

    wx.config({
        debug: false,
        appId: $("#appId").val(),
        timestamp: $("#timestamp").val(),
        nonceStr: $("#nonceStr").val(),
        signature: $("#signature").val(),
        jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage']
        // 所有要调用的 API 都要加到这个列表中
    });
})

wx.ready(function(){
    wx.onMenuShareAppMessage({
        title: $("#activityTitle").val(), // 分享标题
        desc: $("#activityContent").val(), // 分享描述
        link: $("#activityUrl").val(), // 分享链接
        imgUrl: getWebAddress() + '/resources/images/weChat/parking_free/share.png', // 分享图标
        type: '', // 分享类型,music、video或link，不填默认为link
        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
        success: function () {
            // 用户确认分享后执行的回调函数
        },
        cancel: function () {
            // 用户取消分享后执行的回调函数
        }
    });

    wx.onMenuShareTimeline({
        title: $("#activityTitle").val(), // 分享标题
        link: $("#activityUrl").val(), // 分享链接
        imgUrl: getWebAddress() + '/resources/images/weChat/parking_free/share.png', // 分享图标
        success: function () {
            // 用户确认分享后执行的回调函数
        },
        cancel: function () {
            // 用户取消分享后执行的回调函数
        }
    });
});

function runTimer(){
    var m = $("#mim");
    var s = $("#sec");
    var md = parseInt(m.html(),10);
    var sd = parseInt(s.html(),10);
    if (sd > 0) {
        if(sd  <= 10) {
            s.html('0'+(sd - 1));
        } else {
            s.html(sd - 1);
        }
    } else if(sd <= 0) {
        if(md > 0 ) {
            if(md <= 10) {
                m.html('0'+(md-1));
                s.html('59');
            } else {
                m.html(md-1);
                s.html('59');
            }
        } else if(md <= 0) {
            m.html('00');
            s.html('00');
            window.location.reload();
        }
    }
}

function parseParkingTime(){
    var parkingTime = $("#parking_time").html();
    var indexH = parkingTime.indexOf("小时");
    var indexM = parkingTime.indexOf("分钟");
    var parkingTimeDiv = "";
    if (indexH >= 0){
        parkingTimeDiv += "<span class='blue'>" + parkingTime.substring(0, indexH) + "</span>小时";
    } else {
        indexH = -2
    }
    if (indexM >= 0){
        parkingTimeDiv += "<span class='blue'>" + parkingTime.substring(indexH + 2, indexM) + "</span>分钟";
    }
    $("#parking_time").html(parkingTimeDiv);
}

//显示提示页
function showSharePage(){
    $(".shareRemind").css("display", "block");
}
//隐藏提示页
function hiddenSharePage(){
    $(".shareRemind").css("display", "none");
}
//初始化所有分享功能，支付宝生活号隐藏
function initSharePage(){
    var platType = getCookie('platType');
    if (platType == 2){//支付宝支付
        $(".hongbao_img").css('display', 'none');
        $('.share_div').css('display', 'none');
    }
}
//支付宝禁用分享
document.addEventListener('AlipayJSBridgeReady', function () {
    AlipayJSBridge.call("hideToolbar");
    AlipayJSBridge.call("hideOptionMenu");
}, false);