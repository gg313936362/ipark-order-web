<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>超时欠费</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/unpay_list.css">

</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <c:forEach items="${orderList}" var="orderDetail">
    <div class="unpay_div">
      <div class="unpay_text1">
        <div class="unpay_text_title">${orderDetail.parkName}</div>
        <div class="unpay_text_type orange">包月</div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">入场时间</div>
        <div class="unpay_text_time_right">${orderDetail.arriveTime}</div>
      </div>
      <div class="unpay_text2">
        <div class="unpay_text_time_left">出场时间</div>
        <div class="unpay_text_time_right">${orderDetail.leaveTime}</div>
      </div>
      <div class="unpay_text3">
        <div class="unpay_text_amt">欠费：<span><fmt:formatNumber type='number' value='${orderDetail.amount}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
      </div>
    </div>
  </c:forEach>
</body>
</html>
