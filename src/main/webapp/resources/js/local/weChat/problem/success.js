/**
 * Created by Cheng Wang on 2016/11/24.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    setCookie("homepageRefreshFlag", 1);//设置首页刷新flag,1则返回首页要刷新页面
})