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
  <title>支付费用</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/order_pay.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/order_pay.js?2017071001"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${monthlyTypeId}" id="monthlyTypeId">
  <input type="hidden" value="${beginDate}" id="beginDate">
  <input type="hidden" value="${endDate}" id="endDate">
  <input type="hidden" value="${carNum}" id="carNum">
  <input type="hidden" value="${result.maxCouponsId}" id="couponsId">
  <input type="hidden" value="${result.maxCouponsAmt}" id="couponsAmt">
  <input type="hidden" value="${totalPrice}" id="totalPrice">
  <input type="hidden" value="0" id="realPayAmt">
  <input type="hidden" value="${result.userBalance}" id="balance">
  <input type="hidden" value="0" id="payWay">
  <input type="hidden" value="${orderNo}" id="orderNo">
  <div class="order_detail">
    <div class="order_detail_month">${monthCount}个月</div>
    <div class="order_detail_amt"><span>${totalPrice}</span>元</div>
    <div class="order_detail_date">有效期：${beginDate}&nbsp;-&nbsp;${endDate}</div>
  </div>
  <div class="div_title">优惠券</div>
  <div class="order_coupon" <c:if test="${result.maxCouponsId != 0}">onclick="openCoupon();" </c:if>>
    <div class="order_coupon_left">捷停优惠券</div>
    <c:if test="${result.maxCouponsId == 0}"><div class="order_coupon_right">暂无优惠券</div></c:if>
    <c:if test="${result.maxCouponsId != 0}">
      <img src="${contextPath}/resources/images/weChat/order_pay/arrow_walletlist@3x.png">
      <div class="order_coupon_right">已抵扣<span id="couponsAmtDiv"><fmt:formatNumber type='number' value='${result.maxCouponsAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元</div>
    </c:if>
  </div>
  <div class="coupon_div">
    <div class="coupon_back" onclick="closeCoupon();"></div>
    <div class="coupon_content">
      <div class="coupon_content_title">选择优惠券</div>
      <img class="coupon_content_close" onclick="closeCoupon();" src="${contextPath}/resources/images/weChat/order_pay/icon_discount_cross@3x.png">
      <div class="coupon_list">
        <c:forEach items="${result.couponsUserList}" var="coupons">
          <div class="coupon_detail <c:if test="${result.maxCouponsId == coupons.id}">sel_coupon</c:if>" onclick="selectCoupon(this, ${coupons.id}, ${coupons.amt});">
            <div class="coupon_detail_sel_div">
              <c:if test="${result.maxCouponsId == coupons.id}">
                <img class="coupon_detail_sel" src="${contextPath}/resources/images/weChat/order_pay/bg_discount_check@3x.png"/>
              </c:if>
              <c:if test="${result.maxCouponsId != coupons.id}">
                <img class="coupon_detail_sel" src="${contextPath}/resources/images/weChat/order_pay/bg_discount_circle@3x.png"/>
              </c:if>
            </div>
            <div class="coupon_detail_div">
              <div class="coupon_detail_div_top">
                <div class="coupon_detail_div_top_yuan_div">
                  <div class="coupon_detail_div_top_yuan">￥</div>
                </div>
                <div class="coupon_detail_div_top_amt_div">
                  <div class="coupon_detail_div_top_amt">
                    <fmt:formatNumber type='number' value='${coupons.amt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>
                  </div>
                </div>
                <div class="coupon_detail_div_top_name">
                  <div class="coupon_detail_div_top_name_1">${coupons.name}</div>
                  <div class="coupon_detail_div_top_name_2">元优惠券</div>
                </div>
              </div>
              <div class="coupon_detail_div_bottom">有效期至：${coupons.endTime}</div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
  <div class="div_title">支付方式</div>
  <div class="pay_way_line pay_way_sele pay_way_balance" onclick="selectPayWay(this, 1);">
    <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/order_pay/pic_payment_balance_h@3x.png">
    <div>余额支付（余额：<span><fmt:formatNumber type='number' value='${result.userBalance}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元）</div>
    <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/psa/bluei/parking_pay/icon_addfunds_n@3x.png">
  </div>
  <div class="pay_way_line pay_way_sele pay_way_wechat" onclick="selectPayWay(this, 5);">
    <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/order_pay/pic_addfunds_wechat@3x.png">
    <div>微信支付</div>
    <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/weChat/order_pay/icon_addfunds_n@3x.png">
  </div>
  <div class="pay_way_line pay_way_sele pay_way_ali" onclick="selectPayWay(this, 5);">
    <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/order_pay/pic_addfunds_zhifubao@3x.png?2017030601">
    <div>支付宝</div>
    <img class="pay_way_line_seled_img" src="${contextPath}/resources/images/weChat/order_pay/icon_addfunds_n@3x.png">
  </div>
  <div class="pay_amt_div">
    <div class="pay_amt_text">总计：<span></span>元</div>
    <div class="pay_amt_button" onclick="payInfoSubmit(this);">支付</div>
  </div>
  <div id="ali_pay_hidden_div" style="display: none;"></div>
</body>
</html>
