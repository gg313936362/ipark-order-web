<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>发布需求</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_need.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_need.js"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="need_content">
    <div class="need_tips">请填写你的停车需求，捷停帮您找车位</div>
    <div class="input_div_wrapper">
      <div class="input_div">
        <div>停车地点</div>
        <img src="${contextPath}/resources/images/weChat/order_need/pic_requirement_＊@3x.png">
        <input type="text" placeholder="输入您所需停车场名称" id="parkingAddress">
      </div>
    </div>
    <div class="input_div_wrapper">
      <div class="input_div">
        <div>手机号码</div>
        <img src="${contextPath}/resources/images/weChat/order_need/pic_requirement_＊@3x.png">
        <input type="tel" placeholder="输入您的手机号码" id="mobile">
      </div>
    </div>
    <div class="need_button" onclick="submitNeed(this);">提交</div>
  </div>

</body>
</html>
