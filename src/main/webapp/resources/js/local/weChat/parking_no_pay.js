/**
 * Created by chengwang on 2016/7/28.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();
    parseParkingTime();
})

function parseParkingTime(){
    var timeoutTime = $("#timeoutTime").html();
    var indexH = timeoutTime.indexOf("小时");
    var indexM = timeoutTime.indexOf("分钟");
    var timeoutTimeDiv = "";
    if (indexH >= 0){
        timeoutTimeDiv = "<div class='pay_top_top_big_div'>" +
            "<div class='pay_top_top_big'>" + timeoutTime.substring(0, indexH) + "</div>" +
            "</div>" +
            "<div class='pay_top_top_small_div'>" +
            "<div class='pay_top_top_small'>时</div>" +
            "</div>";
    }
    if (indexM >= 0){
        timeoutTimeDiv += "<div class='pay_top_top_big_div'>" +
            "<div class='pay_top_top_big'>" + timeoutTime.substring(indexH + 2, indexM) + "</div>" +
            "</div>" +
            "<div class='pay_top_top_small_div'>" +
            "<div class='pay_top_top_small'>分</div>" +
            "</div>";
    }
    $("#timeoutTime").html(timeoutTimeDiv);
}