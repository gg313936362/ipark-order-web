<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>车辆管理</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/car_list.css?2016120201">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/car_list.js?2016120501"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="get_car_button" onclick="window.location.href = '${contextPath}/weixin/car/upload/init';">找回车牌</div>
  <c:forEach items="${carList}" var="carNum">
    <div class="car_list_div">
      <div class="car_list_num">
        <div class="car_list_num_img">
          <img src="${contextPath}/resources/images/weChat/car_list/icon_vehiclemanagemengt_car_n@3x.png">
        </div>
        <div class="car_list_num_text"><span>${carNum.carNum}</span></div>
      </div>
      <div class="car_list_operate">
        <div class="car_list_operate_button" onclick="window.location.href = '${contextPath}/weixin/car/add/init/1?carNum=${carNum.carNum}';" style="border-right: 1px solid RGB(227, 227, 227);">
          <div class="car_list_operate_img">
            <img src="${contextPath}/resources/images/weChat/car_list/icon_vehiclemanagemengt_edit_n@3x.png">
          </div>
          <div class="car_list_operate_text"><span>编辑</span></div>
        </div>
        <div class="car_list_operate_button" onclick="deleteCarNum(this, '${carNum.carNum}');">
          <div class="car_list_operate_img">
            <img src="${contextPath}/resources/images/weChat/car_list/icon_vehiclemanagemengt_delete_n@3x.png">
          </div>
          <div class="car_list_operate_text"><span>删除</span></div>
        </div>
      </div>
    </div>
  </c:forEach>
  <div class="car_list_max">最多可绑定三辆车</div>
  <c:if test="${fn:length(carList) < 3}">
    <div class="car_list_button" onclick="window.location.href = '${contextPath}/weixin/car/add/init/1';">添加车牌</div>
  </c:if>
</body>
</html>
