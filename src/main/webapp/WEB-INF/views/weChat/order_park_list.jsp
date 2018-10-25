<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>包月车位</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/gaode_map/main1119.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/pull_refresh/reset.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/pull_refresh/pull_to_refresh.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_park_list.css?2018101001">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script src="http://webapi.amap.com/maps?v=1.4.1&key=ea0560f531c1771672f12e974bb6891d&plugin=AMap.Geocoder,AMap.Autocomplete,AMap.CitySearch"></script>
  <script src="https://webapi.amap.com/maps?v=1.4.1&key=ea0560f531c1771672f12e974bb6891d&plugin=AMap.Geocoder,AMap.Autocomplete,AMap.CitySearch"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/pull_refresh/iscroll.js?2016120501"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/pull_refresh/pull_to_refresh.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_park_list.js?2016110703"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div style="float: left; width: 97%; background: RGB(248, 248, 248); padding-right: 3%;" onclick="jumpMemInfoPage();">
    <div style="float: right; line-height: 34px; font-size: 14px; color: #999999;">个人中心</div>
    <img style="float: right; height: 16px; margin: 9px 5px 9px 0;" src="${contextPath}/resources/images/weChat/homepage/icon_home_personal-center@3x.png">
  </div>
  <div class="search_div">
    <div class="search_input">
      <img src="${contextPath}/resources/images/weChat/order_park_list/icon_search@3x.png">
      <input type="text" placeholder="搜索停车场" onfocus="showSearch();autoComplete(this);" oninput="autoComplete(this);">
    </div>
    <div class="search_cancel" onclick="hiddenSearch();">取消</div>
  </div>
  <div class="current_address">
    <img src="${contextPath}/resources/images/weChat/order_park_list/icon_search_dangqianweizhi@3x.png">
    <div>当前位置：未知</div>
  </div>
  <div class="sel_address">

  </div>
  <div class="sel_park_wrapper">
    <div id="wrapper" style="overflow: hidden;">
      <div class="scroller">
        <ul>

        </ul>
      </div>
    </div>
  </div>
</body>
</html>
