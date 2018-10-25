<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>订单详情</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_detail.css?2017071001">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_detail.js?2017071001"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <c:if test="${result.status == 1}">
    <div class="title">
        <div class="title_name"><div class="title_name_blue"></div>预约成功</div>
        <div class="title_tip">需要1-2工作日同步车位信息</div>
    </div>
    <div class="status">
      <div class="status_text status_text_1">支付完成</div>
      <div class="status_text status_text_2 status_text_blue">车位信息同步中</div>
      <div class="status_text status_text_3">开始停车</div>
      <div class="status_point status_point_1"></div>
      <div class="status_line"></div>
      <div class="status_point status_point_blue"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
    </div>
  </c:if>
  <c:if test="${result.status == 2}">
    <div class="title">
        <div class="title_name"><div class="title_name_blue"></div>订单执行中</div>
        <div class="title_tip">请在服务时间内停车</div>
    </div>
    <div class="status">
      <div class="status_text status_text_1">预约成功</div>
      <div class="status_text status_text_2 status_text_blue">订单执行中</div>
      <div class="status_text status_text_3">订单完成</div>
      <div class="status_point status_point_1"></div>
      <div class="status_line"></div>
      <div class="status_point status_point_blue"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
    </div>
  </c:if>
  <c:if test="${result.status == 4}">
    <div class="title">
        <div class="title_name"><div class="title_name_grey"></div>订单完成</div>
        <div class="title_tip">本次包月已经结束，如有需要请重新下单</div>
    </div>
    <div class="status">
      <div class="status_text status_text_1">预约成功</div>
      <div class="status_text status_text_2">订单执行中</div>
      <div class="status_text status_text_3">订单完成</div>
      <div class="status_point status_point_1"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
    </div>
  </c:if>
  <c:if test="${result.status == 6 && result.refundStatus == 2}">
    <div class="title">
        <div class="title_name"><div class="title_name_grey"></div>订单取消中</div>
        <div class="title_tip">您的预约金额将在5个工作日退还给您</div>
    </div>
    <div class="status">
      <div class="status_text status_text_1">取消申请</div>
      <div class="status_text status_text_2 status_text_blue">退款中</div>
      <div class="status_text status_text_3">退款成功</div>
      <div class="status_point status_point_1"></div>
      <div class="status_line"></div>
      <div class="status_point status_point_blue"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
    </div>
  </c:if>
  <c:if test="${result.status == 6 && result.refundStatus == 3}">
    <div class="title">
        <div class="title_name"><div class="title_name_grey"></div>订单已取消</div>
        <div class="title_tip">预约金额已由原路退至您支付所使用的账户，请查收</div>
    </div>
    <div class="status">
      <div class="status_text status_text_1">取消申请</div>
      <div class="status_text status_text_2">退款中</div>
      <div class="status_text status_text_3">退款成功</div>
      <div class="status_point status_point_1"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
      <div class="status_line"></div>
      <div class="status_point"></div>
    </div>
  </c:if>
  <div class="line">
    <div class="line_left">订单详情</div>
    <div class="line_right">订单号：${result.orderNo}</div>
  </div>
  <div class="detail">
    <div class="detail_title">${result.parkName}</div>
    <div class="detail_date">有效日期：${result.monthCount}个月（${result.validBeginDate}-${result.validEndDate}）</div>
    <div class="detail_title">
      <c:if test="${result.monthlyType == 1}">包月（休息时间）套餐</c:if>
      <c:if test="${result.monthlyType == 2}">包月（24小时）套餐</c:if>
      <c:if test="${result.monthlyType == 3}">包月（时间段）套餐</c:if>
      <c:if test="${result.monthlyType == 4}">包月（工作时间）套餐</c:if>
    </div>
    <c:if test="${result.monthlyType == 1}">
      <div class="detail_line">
        <div class="detail_line_right">服务时间：(法定工作日)</div>
        <div class="detail_line_left">${result.serviceBeginTime}-${result.serviceEndTime}</div>
      </div>
      <div class="detail_line">
        <div class="detail_line_right detail_line_right_margin">(法定节假日)</div>
        <div class="detail_line_left">全天</div>
      </div>
    </c:if>
    <c:if test="${result.monthlyType == 2}">
      <div class="detail_line">
        <div class="detail_line_right">服务时间：全天24小时，包含周末</div>
      </div>
    </c:if>
    <c:if test="${result.monthlyType == 3}">
      <div class="detail_line">
        <div class="detail_line_right">服务时间：每天</div>
        <div class="detail_line_left">${result.serviceBeginTime}-${result.serviceEndTime}</div>
      </div>
    </c:if>
    <c:if test="${result.monthlyType == 4}">
      <div class="detail_line">
        <div class="detail_line_right">服务时间：(法定工作日)</div>
        <div class="detail_line_left">${result.serviceBeginTime}-${result.serviceEndTime}</div>
      </div>
    </c:if>
    <div class="detail_line">
      <div class="detail_line_right">
        <c:if test="${result.status == 1 || result.status == 2}">收费标准：<span><fmt:formatNumber type='number' value='${result.unitPrice}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元/月</c:if>
        <c:if test="${result.status == 4 || result.status == 6}">收费标准：<fmt:formatNumber type='number' value='${result.unitPrice}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>元/月</c:if>
      </div>
    </div>
    <c:if test="${result.monthlyType == 1 || result.monthlyType == 3 || result.monthlyType == 4}">
      <div class="detail_line">
        <div class="detail_line_right detail_line_right_margin">超时（服务时间段以外）</div>
        <div class="detail_line_left">按临停计费</div>
      </div>
      <div class="detail_tip detail_line_right_margin">
        <c:if test="${result.timeoutFeeType == 1}">注：如产生超时费用，请到首页缴纳欠费</c:if>
        <c:if test="${result.timeoutFeeType == 2}">注：如超时停车，请自行与停车场沟通</c:if>
      </div>
    </c:if>
  </div>
  <div class="line">
    <div class="line_left">停车费用</div>
    <div class="line_pay_record" onclick="jumpOrderPayDetailPage('${result.orderNo}')">交易记录</div>
  </div>
  <div class="amt">
    <div class="amt_text">
      <div class="amt_text_left">停车费</div>
      <div class="amt_text_right"><fmt:formatNumber type='number' value='${result.parkingAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>元</div>
    </div>
    <div class="amt_text">
      <div class="amt_text_left">优惠</div>
      <div class="amt_text_right"><fmt:formatNumber type='number' value='${result.subtractAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>元</div>
    </div>
    <div class="amt_line"></div>
    <div class="amt_text">
      <div class="amt_text_left">实收费用</div>
      <div class="amt_text_right"><span><fmt:formatNumber type='number' value='${result.reserveAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
    </div>
    <c:if test="${result.status == 2 || result.status == 4}">
      <div class="amt_text">
        <div class="amt_text_left">超时费用</div>
        <div class="amt_text_right"><span><fmt:formatNumber type='number' value='${result.timeoutAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
      </div>
      <div class="amt_text">
        <div class="amt_text_left">已补缴费用</div>
        <div class="amt_text_right"><span><fmt:formatNumber type='number' value='${result.supplementAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
      </div>
      <div class="amt_text">
        <div class="amt_text_left">欠费金额</div>
        <div class="amt_text_right"><span><fmt:formatNumber type='number' value='${result.arrearsAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
      </div>
    </c:if>
  </div>
</body>
</html>
