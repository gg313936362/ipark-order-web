/**
 * Created by chengWang on 2016/8/2.
 */
var	contextPath;
var currentCity = "全国";
var pageIndex = 1;
var pageSize = 10;
var selLngLat;//选中的坐标
$(function() {
    contextPath = $("#contextPath").val();
    $(".sel_park_wrapper").css("height", (document.body.scrollHeight - 90) + "px");
    refresher.init({
        id: "wrapper",
        pullDownAction: Refresh,
        pullUpAction: Load
    })
    currentCitySearch();
    getMyLocation();
})

function Refresh() {
    setTimeout(function () {
        getParkList(1);
    }, 1000);
}

function Load() {
    setTimeout(function () {
        getParkList(2);
    }, 1000);
}

/**
 * 获取数据
 * @param type （1：下拉；2：上拉加载更多）
 */
function getParkList(type){
    if (type == 1){
        pageIndex = 1;
    }
    if (type == 2 && pageIndex == -1){
        wrapper.refresh();
        return;
    }
    $.ajax({
        type: "get",
        dateType: "json",
        url: contextPath + "/weixin/order/park/list/json",
        data: {lng : selLngLat.bd_lng, lat : selLngLat.bd_lat, pageIndex : pageIndex, pageSize : pageSize},
        success: function(result) {
            $("body").hiddenLoadingView();
            if (result.resCode == '000000') {
                var totalPage = result.data.totalPage;
                if (totalPage <= pageIndex){
                    pageIndex = -1;
                } else {
                    pageIndex++;
                }
                if (type == 1){
                    if (result.data.data[0].orderDistance < 5000){
                        $(".scroller ul").html('');
                    } else {
                        // $(".scroller ul").html(
                        //     "<div class='no_park'>" +
                        //         "<div class='no_park_text'>附近暂无合适的包月车位</div>" +
                        //         "<div class='no_park_button' onclick='jumpNeedParkPage();'>求车位</div>" +
                        //     "</div>" +
                        //     "<div class='nearby_park'>是否考虑下列车位</div>");
                    }
                }
                for (var i = 0; i < result.data.data.length; i++){
                    var record = result.data.data[i];
                    $(".scroller ul").append(
                        "<li class='sel_park_div' onclick='jumpOrderParkDetailPage(" + record.id + ");'>" +
                            "<div class='sel_park_div_1'>" +
                                "<div class='sel_park_div_line sel_park_div_line_big sel_park_div_line_title'>" + record.name + "</div>" +
                                "<div class='sel_park_div_line'>" + record.address + "</div>" +
                            "</div>" +
                            "<img src='" + contextPath + "/resources/images/weChat/order_park_list/arrow_walletlist@3x.png'>" +
                            "<div class='sel_park_div_2'>" +
                                "<div class='sel_park_div_line sel_park_div_line_big'><span>" + record.price + "</span>元/月</div>" +
                                "<div class='sel_park_div_line'>" + distancePares(record.orderDistance) + "</div>" +
                            "</div>" +
                        "</li>");
                }
                wrapper.refresh();
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.resMsg
                });
            }

        }
    });
}

function distancePares(distance){
    if (distance < 1000){
        return distance.toFixed(1) + "m";
    } else {
        return (distance / 1000).toFixed(1) + "km";
    }
}

function showSearch(){
    $(".sel_park_wrapper").css("display", "none");
    $(".sel_address").css("display", "block");
    $(".search_input").animate({"width" : "87%"}, 200, null, function () {
        $(".search_cancel").css("display", "block");
    });
}

function hiddenSearch(){
    $(".search_cancel").css("display", "none");
    $(".sel_address").css("display", "none");
    $(".search_input").animate({"width" : "100%"}, 200, null, function () {});
    $(".sel_park_wrapper").css("display", "block");
}
//定位当前经纬度
function getMyLocation(){
    $("body").showLoadingView();
    AMap.plugin('AMap.Geolocation', function () {
        var geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
            maximumAge: 0,           //定位结果缓存0毫秒，默认：0
            convert: true,           //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
            showButton: false,        //显示定位按钮，默认：true
            buttonPosition: 'LB',    //定位按钮停靠位置，默认：'LB'，左下角
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            showMarker: true,        //定位成功后在定位到的位置显示点标记，默认：true
            showCircle: true,        //定位成功后用圆圈表示定位精度范围，默认：true
            panToLocation: true,     //定位成功后将定位到的位置作为地图中心点，默认：true
            zoomToAccuracy: false      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
        });
        geolocation.getCurrentPosition();
        //返回定位信息
        AMap.event.addListener(geolocation, 'complete', function(geolocationResult){
            regeocoder(geolocationResult.position.lng, geolocationResult.position.lat);
            selLngLat = ggToBd(geolocationResult.position.lng, geolocationResult.position.lat);
            getParkList(1);
        });
        //返回定位出错信息
        AMap.event.addListener(geolocation, 'error', function(geolocationError){
            $("body").hiddenLoadingView();
            $("body").alertDialog({
                title: "提示",
                text: geolocationError.info
            });
        });
    })
}
//逆向地理编码（坐标-地址）
function regeocoder(lng, lat){
    var lnglat = [lng, lat];
    var geocoder = new AMap.Geocoder({
        radius: 1000,
        extensions: "base"
    });
    geocoder.getAddress(lnglat, function(status, result) {
        if (status === 'complete' && result.info === 'OK') {
            $(".current_address div").html("当前位置：" + result.regeocode.formattedAddress);
        } else {
            $(".current_address div").html("当前位置：未知");
        }
    });
}
//输入提示
function autoComplete(obj){
    var keys = $.trim($(obj).val());
    if (keys == ''){
        $(".sel_address").html('');
        return;
    }
    var auto = new AMap.Autocomplete({
        city : currentCity,
        datatype : "poi"
    });
    auto.search($.trim($(obj).val()), function(status, result){
        if (status === 'complete') {
            var html = "";
            for (var i = 0; i < result.tips.length; i++){
                if (result.tips[i].location.lng == undefined || result.tips[i].location.lat == undefined){
                    continue;
                }
                html += "<div class='sel_address_div' onclick=\"clickAutoTips('" + result.tips[i].name + "'," + result.tips[i].location.lng + "," + result.tips[i].location.lat + ")\">" +
                            "<img src='" + contextPath + "/resources/images/psa/bluei/park_list/icon_search_address@3x.png'>" +
                            "<div class='sel_address_div_title'>" + result.tips[i].name + "</div>" +
                            "<div class='sel_address_div_desc'>" + (result.tips[i].address == '' ? result.tips[i].name : result.tips[i].address) + "</div>" +
                        "</div>";
            }
            $(".sel_address").html(html);
            //alert(JSON.stringify(result));
        } else if (status === 'no_data'){
            $(".sel_address").html('');
        } else {
            $("body").alertDialog({
                title: "提示",
                text: result.info
            });
        }
    })
}

function clickAutoTips(name, lng, lat){
    $("body").showLoadingView();
    $(".search_input input").val(name);
    hiddenSearch();
    selLngLat = ggToBd(lng, lat);
    getParkList(1);
}

//通过ip定位城市信息
function currentCitySearch(){
    //加载IP定位插件
    AMap.plugin(["AMap.CitySearch"], function() {
        //实例化城市查询类
        var citysearch = new AMap.CitySearch();
        //自动获取用户IP，返回当前城市
        citysearch.getLocalCity();
        AMap.event.addListener(citysearch, "complete", function(result){
            if(result && result.city && result.bounds) {
                currentCity = result.city;
            } else {
                currentCity = "全国";
            }
        });
    });
}

function jumpNeedParkPage(){
    window.location.href = contextPath + "/weixin/order/park/need/init";
}

function jumpOrderParkDetailPage(parkId){
    window.location.href = contextPath + "/weixin/order/park/detail/init?lng="
        + selLngLat.bd_lng + "&lat=" + selLngLat.bd_lat + "&parkId=" + parkId + "&openid=" + getCookie('openid');
}

function jumpMemInfoPage(){
    window.location.href = contextPath + "/weixin/mem/info/init/" + getCookie('openid');
}