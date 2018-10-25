<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>支付记录</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_pay_detail.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <c:forEach items="${result}" var="payDetail">
    <div class="pay_list">
      <div class="pay_list_top">
        <span></span>
        <div class="pay_list_top_left">
          <c:if test="${payDetail.payOrderType == 1}">包月订单</c:if>
          <c:if test="${payDetail.payOrderType == 4}">包月续约</c:if>
        </div>
        <div class="pay_list_top_right">￥${payDetail.payAmt}</div>
      </div>
      <div class="pay_list_bottom">
        <div>购买时长：${payDetail.monthCount}个月</div>
        <div>支付时间：${payDetail.tradeTime}</div>
        <div>有效时间：${payDetail.validBeginTime}到${payDetail.validEndTime}</div>
      </div>
    </div>
  </c:forEach>
</body>
</html>
