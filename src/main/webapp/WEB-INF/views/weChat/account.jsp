<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>余额充值</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/account.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/account.js?2017022301"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" id="payWay">
  <div class="content">
    <div class="account_amt">
      <fmt:formatNumber type='number' value='${memInfo.accountBal}' minFractionDigits="2"></fmt:formatNumber>
    </div>
    <div class="account_title">账户余额（元）</div>
    <input id="recharge_amt_input" placeholder="请输入金额" type="tel">
    <div class="recharge_amt_content">
      <div class="recharge_amt_div" onclick="selectAmt(this, 50);">50元</div>
      <div class="recharge_amt_div" onclick="selectAmt(this, 100);">100元</div>
      <div class="recharge_amt_div" onclick="selectAmt(this, 200);">200元</div>
      <div class="recharge_amt_div" onclick="selectAmt(this, 500);">500元</div>
    </div>
    <div class="pay_way_title">支付方式</div>
    <div class="pay_way pay_way_wechat">
      <img class="pay_way_ali_img" src="${contextPath}/resources/images/weChat/account/pic_addfunds_wechat@3x.png">
      <div>微信</div>
      <img class="pay_way_seled_img" src="${contextPath}/resources/images/weChat/account/icon_addfunds_h@3x.png">
    </div>
    <div class="pay_way pay_way_ali">
      <img class="pay_way_ali_img" src="${contextPath}/resources/images/weChat/account/pic_addfunds_zhifubao@3x.png?2017030601">
      <div>支付宝</div>
      <img class="pay_way_seled_img" src="${contextPath}/resources/images/weChat/account/icon_addfunds_h@3x.png">
    </div>
  </div>
  <div class="pay_way_button_div" onclick="submitPay(this);">支付</div>
  <div id="ali_pay_hidden_div" style="display: none;"></div>
</body>
</html>
