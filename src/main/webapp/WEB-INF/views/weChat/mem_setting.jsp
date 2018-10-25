<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>设置</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/lib/multi_switch/multi_switch.min.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/mem_setting.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js?2017010901"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/lib/multi_switch/multi_switch.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/mem_setting.js?2017010901"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="line top_line">
    <img class="line_img" src="${contextPath}/resources/images/weChat/mem_setting/icon_set_money@3x.png">
    <div class="line_title">钱包余额自动抵扣</div>
    <div class="line_switch" onclick="flagChange(1, this);">
      <input type="checkbox" class="multi_switch" value="${memInfo.walletPayFlag}" unchecked-value="0" checked-value="1"/>
    </div>
  </div>
  <div class="line">
    <img class="line_img" src="${contextPath}/resources/images/weChat/mem_setting/icon_set_news@3x.png">
    <div class="line_title">短信提示</div>
    <div class="line_switch" onclick="flagChange(2, this);">
      <input type="checkbox" class="multi_switch" value="${memInfo.smsRemindFlag}" unchecked-value="0" checked-value="1"/>
    </div>
  </div>
  <div class="login_out_button" onclick="loginOut(this);">退出登录</div>
</body>
</html>
