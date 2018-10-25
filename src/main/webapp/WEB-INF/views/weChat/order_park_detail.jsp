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
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/simple_slider/simple_slider.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_park_detail.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/simple_slider/simple_slider.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_park_detail.js?2017070701"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${result.distance}" id="distance">
  <c:if test="${fn:length(result.urls) == 0}">
    <img class="park_img" src="${contextPath}/resources/images/weChat/order_park_detail/pic_monthlyempty@3x.png">
  </c:if>
  <c:if test="${fn:length(result.urls) > 0}">
    <div class="park_img_wrapper">
      <div class="slider">
        <ul>
          <c:forEach items="${result.urls}" var="imgUrl"><li><img src="${imgUrl}"></li></c:forEach>
        </ul>
      </div>
    </div>
  </c:if>
  <div class="div_title">停车场信息</div>
  <div class="detail">
    <div class="detail_left">
      <div class="detail_name">${result.name}</div>
      <div class="detail_des">${result.address}</div>
    </div>
    <div class="detail_distance"></div>
    <img src="${contextPath}/resources/images/weChat/order_park_detail/icon_monthly_distance@3x.png">
  </div>
  <div class="div_title">包月类型</div>
  <c:forEach items="${result.monthlyTypes}" var="monthlyTypes">
    <c:if test="${monthlyTypes.monthlyType >= 1 && monthlyTypes.monthlyType <= 4}">
      <div class="order_div">
        <div class="order_line">
          <div class="order_name">
            <c:if test="${monthlyTypes.monthlyType == 1}">包月（休息时间）套餐</c:if>
            <c:if test="${monthlyTypes.monthlyType == 2}">包月（24小时）套餐</c:if>
            <c:if test="${monthlyTypes.monthlyType == 3}">包月（时间段）套餐</c:if>
            <c:if test="${monthlyTypes.monthlyType == 4}">包月（工作时间）套餐</c:if>
          </div>
          <div class="order_button" onclick="jumpOrderParkTypePage(${monthlyTypes.monthlyTypeId});">包车位</div>
        </div>
        <div class="order_line">
          <c:if test="${monthlyTypes.monthlyType == 1}">
            <div class="order_tip order_tip_left">服务时间：(法定工作日)</div>
            <div class="order_tip order_tip_right">${monthlyTypes.startTime}-${monthlyTypes.endTime}</div>
            <div class="order_tip order_tip_left order_tip_left_margin">(法定节假日)</div>
            <div class="order_tip order_tip_right">全天</div>
          </c:if>
          <c:if test="${monthlyTypes.monthlyType == 2}">
            <div class="order_tip order_tip_left">服务时间：全天24小时，包含周末</div>
          </c:if>
          <c:if test="${monthlyTypes.monthlyType == 3}">
            <div class="order_tip order_tip_left">服务时间：每天</div>
            <div class="order_tip order_tip_right">${monthlyTypes.startTime}-${monthlyTypes.endTime}</div>
          </c:if>
          <c:if test="${monthlyTypes.monthlyType == 4}">
            <div class="order_tip order_tip_left">服务时间：(法定工作日)</div>
            <div class="order_tip order_tip_right">${monthlyTypes.startTime}-${monthlyTypes.endTime}</div>
          </c:if>
        </div>
        <div class="order_line">
          <div class="order_tip order_tip_left">收费标准：<span><fmt:formatNumber type='number' value='${monthlyTypes.monthlyPrice}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元/月</div>
        </div>
        <c:if test="${monthlyTypes.monthlyType == 1 || monthlyTypes.monthlyType == 3 || monthlyTypes.monthlyType == 4}">
          <div class="order_line">
            <div class="order_tip order_tip_left order_tip_left_margin">超时（服务时间段以外）</div>
            <div class="order_tip order_tip_right">按临停计费</div>
          </div>
          <div class="order_line">
            <div class="order_remark order_remark order_tip_left order_tip_left_margin">
              <c:if test="${monthlyTypes.timeoutFeeType == 1}">注：如产生超时费用，请到首页缴纳欠费</c:if>
              <c:if test="${monthlyTypes.timeoutFeeType == 2}">注：如超时停车，请自行与停车场沟通</c:if>
            </div>
          </div>
        </c:if>
      </div>
    </c:if>
  </c:forEach>
  <div class="div_title">包月协议</div>
  <div class="protocol_div">
    <c:forEach items="${result.monthlyAgreements}" var="monthlyAgreements" varStatus="status">
      <div class="protocol_line">
        <div class="protocol_num">${status.index + 1}</div>
        <div class="protocol_text">${monthlyAgreements}</div>
      </div>
    </c:forEach>
  </div>
</body>
</html>
