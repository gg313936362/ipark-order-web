<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>找车位</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/gaode_map/main1119.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/park_list.css?2016120501">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script src="http://webapi.amap.com/maps?v=1.4.1&key=ea0560f531c1771672f12e974bb6891d&plugin=AMap.Geocoder,AMap.Autocomplete,AMap.CitySearch"></script>
  <script src="https://webapi.amap.com/maps?v=1.4.1&key=ea0560f531c1771672f12e974bb6891d&plugin=AMap.Geocoder,AMap.Autocomplete,AMap.CitySearch"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/park_list.js?2017052706"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="search_div">
    <div class="search_input">
      <img src="${contextPath}/resources/images/weChat/park_list/icon_search@3x.png">
      <input type="text" placeholder="搜索停车场" onfocus="showSearch();autoComplete(this);" oninput="autoComplete(this);">
    </div>
    <div class="search_cancel" onclick="hiddenSearch();">取消</div>
  </div>
  <div class="current_address">
    <img src="${contextPath}/resources/images/weChat/park_list/icon_search_dangqianweizhi@3x.png">
    <div>当前位置：未知</div>
  </div>
  <div class="sel_address">

  </div>
  <div class="sel_park">

  </div>
  <div class="park_type">
    <div class="park_type_line"></div>
    <div class="park_type_button park_type_button_left" onclick="insertParkList(2);">
      <span>手机支付</span>
      <div class="park_type_button_point"><div></div></div>
    </div>
    <div class="park_type_button park_type_button_right" onclick="insertParkList(1);">
      <span>全部</span>
      <div class="park_type_button_point"><div></div></div>
    </div>
  </div>
  <div class="order_navi">
    <input type="hidden" id="orderParkName">
    <input type="hidden" id="orderLng">
    <input type="hidden" id="orderLat">
    <div class="order_navi_back"></div>
    <div class="order_navi_div">
      <div class="order_navi_div_text_1"></div>
      <div class="order_navi_div_text_2">是否确认预订停车位并导航？</div>
      <div class="order_navi_div_button order_navi_div_button_1" onclick="naviOrder(1);">预订&导航</div>
      <div class="order_navi_div_button order_navi_div_button_2" onclick="naviOrder(2);">预订</div>
      <div class="order_navi_div_button order_navi_div_button_3" onclick="naviOrder(3);">导航</div>
      <div class="order_navi_div_button" onclick="$('.order_navi').css('display', 'none');">取消</div>
    </div>
  </div>
  <div class="order_navi_succ">
    <div class="order_navi_succ_back" onclick="$('.order_navi_succ').css('display', 'none');"></div>
    <div class="order_navi_succ_div">
      <img>
      <span></span>
      <div onclick="$('.order_navi_succ').css('display', 'none');">确认</div>
    </div>
  </div>

</body>
</html>
