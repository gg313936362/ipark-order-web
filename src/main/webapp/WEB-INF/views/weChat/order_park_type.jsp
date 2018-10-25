<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>包车位</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_park_type.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_park_type.js?2017070701"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <c:if test="${orderNo == '0'}">
    <input type="hidden" value="${fn:length(result.carNumList) > 0 ? result.carNumList[0] : ""}" id="carNum">
  </c:if>
  <c:if test="${orderNo != '0'}">
    <input type="hidden" value="${result.orderCarNum}" id="carNum">
  </c:if>
  <input type="hidden" value="${result.minBeginDate}" id="minBeginDate">
  <input type="hidden" value="${result.maxBeginDate}" id="maxBeginDate">
  <input type="hidden" value="${monthlyTypeId}" id="monthlyTypeId">
  <input type="hidden" value="${orderNo}" id="orderNo">
  <c:if test="${orderNo == '0'}">
    <input type="date" id="hiddenDate" onblur="selectDate();">
    <div class="line line_top"
      <c:if test="${fn:length(result.carNumList) == 0}">
        onclick="jumpAddCarNumPage();">
        <div class="line_no_car">＋添加车牌</div>
      </c:if>
      <c:if test="${fn:length(result.carNumList) == 1}">
        >
        <div class="line_left">车牌号</div>
        <div class="line_right">${result.carNumList[0]}</div>
      </c:if>
      <c:if test="${fn:length(result.carNumList) > 1}">
        onclick="showSelCarNum();">
        <div class="line_left">车牌号</div>
        <img src="${contextPath}/resources/images/weChat/order_park_type/arrow_walletlist@3x.png">
        <div id="carNumDiv" class="line_right line_right_blue">${result.carNumList[0]}</div>
      </c:if>
    </div>
    <div id="car_num_sel">
      <div class="car_num_sel_back" onclick="hiddenSelCarNum();"></div>
      <div class="car_num_sel_div">
        <div class="car_num_sel_button_div">
          <div class="car_num_sel_button_1">车牌号</div>
          <c:forEach items="${result.carNumList}" var="carNum">
            <div class="car_num_sel_button_2" onclick="selectCarNum(this);">${carNum}</div>
          </c:forEach>
        </div>
        <div class="car_num_sel_button_3" onclick="hiddenSelCarNum();">确定</div>
      </div>
    </div>
    <label for="hiddenDate">
      <div class="line">
        <div class="line_left">包月开始日期</div>
        <img src="${contextPath}/resources/images/weChat/order_park_type/arrow_walletlist@3x.png">
        <div class="line_right line_right_blue">${monthlyBeginDate == "0" ? result.minBeginDate : monthlyBeginDate}</div>
      </div>
    </label>
  </c:if>
  <c:if test="${orderNo != '0'}">
    <div class="line line_top">
      <div class="line_left">车牌号</div>
      <div class="line_right">${result.orderCarNum}</div>
    </div>
    <div class="line">
      <div class="line_left">续约开始日期</div>
      <div class="line_right">${result.extensionValidDate}</div>
    </div>
  </c:if>
  <div class="div_title">包月时长</div>
  <div class="order_div_wrapper">
    <c:forEach items="${result.monthlyTypes}" var="monthlyType">
      <div class="order_div">
        <div class="order_title">${monthlyType.monthCount}个月</div>
        <div class="order_button" onclick="submitOrder('${monthlyType.monthCount}','${monthlyType.beginDate}','${monthlyType.endDate}','${monthlyType.totalPrice}');">包车位</div>
        <div class="order_price"><span>${monthlyType.totalPrice}</span>元（每月${monthlyType.unitPrice}元）</div>
        <div class="order_date">有效期：${monthlyType.beginDate}&nbsp;-&nbsp;${monthlyType.endDate}</div>
      </div>
    </c:forEach>
  </div>

</body>
</html>
