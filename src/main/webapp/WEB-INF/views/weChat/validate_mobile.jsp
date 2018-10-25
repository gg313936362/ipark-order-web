<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>手机验证</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/validate_mobile.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/validate_mobile.js?20170805"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="content">
    <div class="line">
      <div class="line_img_div">
        <img class="line_img" src="${contextPath}/resources/images/weChat/mem/icon_login_mobilephone_h.png">
      </div>
      <input type="tel" autocomplete="off" id="mobile" value="${mobile}" placeholder="请输入11位手机号码">
    </div>
    <div class="line">
      <div class="line_img_div">
        <img class="line_img" src="${contextPath}/resources/images/weChat/mem/icon_login_verificationcode_h.png">
      </div>
      <input type="tel" autocomplete="off" style="width: 55%;" id="smsCode" placeholder="请输入短信验证码">
      <div id="code_button" status="0" onclick="getCode();">获得验证码</div>
    </div>
    <div class="bottom_div">
      <div class="xieyi">点击确认代表你同意<a href="${contextPath}/html/document/user_agreement.html?2017120501">《用户协议》</a></div>
    </div>
    <div class="submit_button" onclick="register(this);">确认</div>
  </div>
</body>
</html>
