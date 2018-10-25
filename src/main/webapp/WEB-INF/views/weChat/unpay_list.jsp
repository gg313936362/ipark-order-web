<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>待缴费用</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/unpay_list.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/unpay_list.js?2017022302"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${detail.totalAmt}" id="totalAmt">
  <input type="hidden" value="${detail.balance}" id="balance">
  <input type="hidden" id="payWay">
  <c:forEach items="${detail.unPayParkings}" var="parkingDetail">
    <div class="unpay_div" onclick="jumpRecordDetailPage(${parkingDetail.parkingLogId})">
      <div class="unpay_text1">
        <div class="unpay_text_title">${parkingDetail.parkName}</div>
        <div class="unpay_text_type">临停</div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">入场时间</div>
        <div class="unpay_text_time_right">${parkingDetail.arriveTime}</div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">出场时间</div>
        <div class="unpay_text_time_right">${parkingDetail.leaveTime}</div>
      </div>
      <div class="unpay_text3">
        <div class="unpay_text_amt">欠费：<span><fmt:formatNumber type='number' value='${parkingDetail.amount}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
        <img class="unpay_text_arrow" src="${contextPath}/resources/images/weChat/unpay_list/arrow_walletlist@3x.png">
      </div>
    </div>
  </c:forEach>
  <c:forEach items="${detail.unPayOrders}" var="orderDetail">
    <div class="unpay_div">
      <div class="unpay_text1">
        <div class="unpay_text_title">${orderDetail.parkName}</div>
        <div class="unpay_text_type orange">包月</div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">开始日期</div>
        <div class="unpay_text_time_right">
          <fmt:parseDate value="${orderDetail.arriveTime}" var="arriveTime" pattern="yyyyMMddHHmm" />
          <fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${arriveTime}" />
        </div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">结束日期</div>
        <div class="unpay_text_time_right">
          <fmt:parseDate value="${orderDetail.leaveTime}" var="arriveTime" pattern="yyyyMMddHHmm" />
          <fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${arriveTime}" />
        </div>
      </div>
      <div class="unpay_text3" onclick="window.location.href = '${contextPath}/weixin/pay/unpay/order/list/' + getCookie('openid') + '/${orderDetail.orderNo}';">
        <div class="unpay_text_amt">欠费：<span><fmt:formatNumber type='number' value='${orderDetail.amount}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
        <img class="unpay_text_arrow" src="${contextPath}/resources/images/weChat/unpay_list/arrow_walletlist@3x.png">
      </div>
    </div>
  </c:forEach>
  <div class="unpay_amt_div_blank"></div>
  <div class="unpay_amt_div">
    <div class="unpay_amt_text">总计：<span><fmt:formatNumber type='number' value='${detail.totalAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
    <div class="unpay_amt_button" onclick="showPayWay();">支付</div>
  </div>
  <div class="pay_way_div">
    <div class="pay_way_back" onclick="hiddenPayWay();"></div>
    <div class="pay_way_content">
      <div class="pay_way_title">支付方式</div>
      <div class="pay_way_line pay_way_sele pay_way_balance" onclick="selectPayWay(this, 3);">
        <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/parking_pay/pic_payment_balance_h@3x.png">
        <div>余额支付（余额：<span><fmt:formatNumber type='number' value='${detail.balance}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元）</div>
        <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/weChat/parking_pay/icon_addfunds_n@3x.png">
      </div>
      <div class="pay_way_line pay_way_sele pay_way_wechat" onclick="selectPayWay(this, 4);">
        <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/parking_pay/pic_addfunds_wechat@3x.png">
        <div>微信</div>
        <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/weChat/parking_pay/icon_addfunds_n@3x.png">
      </div>
      <div class="pay_way_line pay_way_sele pay_way_ali" onclick="selectPayWay(this, 7);">
        <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/parking_pay/pic_addfunds_zhifubao@3x.png?2017030601">
        <div>支付宝</div>
        <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/weChat/parking_pay/icon_addfunds_n@3x.png">
      </div>
      <div class="pay_way_button_div">
        <div onclick="submitPay(this);">支付</div>
      </div>
    </div>
  </div>
  <div id="ali_pay_hidden_div" style="display: none;"></div>
</body>
</html>
