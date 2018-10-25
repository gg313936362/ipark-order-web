<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>添加车牌</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/car_num_board/main.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/car_add.css?2017032301">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/car_add.js?2017053102"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${carNum}" id="car_num_input_hidden">
  <input type="hidden" value="${carNum}" id="update_car_num">
  <input type="hidden" value="0" id="new_flag">
  <input type="hidden" value="${type}" id="type">
  <div class="car_add_tip">请绑定真实有效的车牌号</div>
  <div class="car_add_input">
    <div class="car_add_input_left">
      <div class="car_num_input car_num_input_1"></div>
    </div>
    <div class="car_add_input_left">
      <div class="car_num_input car_num_input_2"></div>
    </div>
    <div class="car_add_input_mid">
      <div class="car_add_input_point"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_3"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_4"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_5"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_6"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_7"></div>
    </div>
    <div class="car_add_input_right">
      <div class="car_num_input car_num_input_8"></div>
    </div>
  </div>
  <div class="new_flag" onclick="clickNewFlag();">
    <div>新能源车牌</div>
    <img src="${contextPath}/resources/images/weChat/car_add/icon_addfunds_n@3x.png">
  </div>
  <div class="car_add_button" onclick="updateOrAddCarNum(this);">确认</div>
</body>
</html>
