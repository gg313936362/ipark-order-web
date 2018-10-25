<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>我的钱包</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/mem_wallet.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/mem_wallet.js"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="line first" onclick="window.location.href = '${contextPath}/weixin/coupon/exchange/init';">
    <img class="line_top" src="${contextPath}/resources/images/weChat/mem_wallet/icon-list-2@3x.png">
    <div class="line_title">优惠兑换码</div>
    <img class="line_arrow" src="${contextPath}/resources/images/weChat/mem_wallet/arrow_walletlist@3x.png">
  </div>
  <div class="line" onclick="window.location.href = '${contextPath}/weixin/coupon/list/init';">
    <img class="line_top" src="${contextPath}/resources/images/weChat/mem_wallet/icon-list-2@3x.png">
    <div class="line_title">停车优惠券</div>
    <img class="line_arrow" src="${contextPath}/resources/images/weChat/mem_wallet/arrow_walletlist@3x.png">
    <div class="line_detail"><span class="red">${memInfo.couponsCount}</span>&nbsp;张</div>
  </div>
  <div class="line" onclick="window.location.href = '${contextPath}/weixin/pay/account?openid=' + getCookie('openid');">
    <img class="line_top" src="${contextPath}/resources/images/weChat/mem_wallet/icon-list-3@3x.png">
    <div class="line_title">余额</div>
    <img class="line_arrow" src="${contextPath}/resources/images/weChat/mem_wallet/arrow_walletlist@3x.png">
    <div class="line_detail">
      <span class="red">
        <fmt:formatNumber type='number' value='${memInfo.accountBal}' maxFractionDigits="2"></fmt:formatNumber>
      </span>&nbsp;元
    </div>
  </div>
  <div class="line" onclick="window.location.href = '${contextPath}/weixin/receipt/record/list/init';">
    <img class="line_top" style="margin-top: 20px;" src="${contextPath}/resources/images/weChat/mem_wallet/icon_invoice@3x.png">
    <div class="line_title">开发票</div>
    <img class="line_arrow" src="${contextPath}/resources/images/weChat/mem_wallet/arrow_walletlist@3x.png">
  </div>
</body>
</html>
