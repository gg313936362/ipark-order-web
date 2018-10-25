<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>停车详情</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/parking_no_pay.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/parking_no_pay.js"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="pay_top">
    <div class="pay_top_left">
      <div class="pay_top_top">
        <div class="pay_top_top_big_div">
          <div class="pay_top_top_big">
            <fmt:formatNumber type='number' value='${parkingInfo.amount}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>
          </div>
        </div>
        <div class="pay_top_top_small_div">
          <div class="pay_top_top_small">元</div>
        </div>
      </div>
      <div class="pay_top_top_bottom">当前费用</div>
    </div>
    <div class="pay_top_right">
      <div class="pay_top_top" id="timeoutTime">
        ${parkingInfo.parkingTimeLength}
      </div>
      <div class="pay_top_top_bottom">停车时长</div>
    </div>
    <div class="pay_top_mid_div">
      <div class="pay_top_mid">计费中</div>
    </div>
    <div class="pay_top_bottom">*请勿在道闸处支付停车费</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">停车场</div>
    <div class="pay_line_right">${parkingInfo.parkName}</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">入场时间</div>
    <div class="pay_line_right">${parkingInfo.arriveTime}</div>
  </div>
  <div class="pay_line_tip">注：本停车场暂未开通电子支付，敬请期待</div>
</body>
</html>
