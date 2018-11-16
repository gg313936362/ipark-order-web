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
  <c:set var="imagePath" value="/"></c:set>
  <c:if test="${isAliCityServer == 1}">
    <c:set var="imagePath" value="/ali/"></c:set>
  </c:if>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/parking_pay.css?2017032201">
  <c:if test="${isAliCityServer == 1}">
    <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/parking_pay_ali.css?2017030701">
  </c:if>

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script src="https://as.alipayobjects.com/g/component/antbridge/1.1.1/antbridge.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/parking_pay.js?2017032301"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${parkingInfo.maxCouponsId}" id="couponsId">
  <input type="hidden" value="${parkingInfo.maxCouponsAmt}" id="couponsAmt">
  <input type="hidden" value="${parkingInfo.parkingAmt}" id="parkingAmt">
  <input type="hidden" value="${parkingInfo.serviceFee}" id="serviceFee">
  <input type="hidden" value="${parkingInfo.unPayAmt}" id="unPayAmt">
  <input type="hidden" value="${parkingInfo.parkingLogId}" id="parkingLogId">
  <input type="hidden" value="${parkingInfo.parkId}" id="parkId">
  <input type="hidden" id="realPayAmt">
  <input type="hidden" value="${parkingInfo.userBalance}" id="balance">
  <input type="hidden" id="payWay">
  <input type="hidden" value="${parkingInfo.isNetworking}" id="isNetworking">
  <input type="hidden" value="${isAliCityServer}" id="isAliCityServer"><!--如果是支付宝城市服务支付，则禁止使用余额支付-->
  <div class="pay_top">
    <div class="pay_top_left">
      <div class="pay_top_top">
        <div class="pay_top_top_big_div">
          <div class="pay_top_top_big">
            <fmt:formatNumber type='number' value='${parkingInfo.parkingAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>
          </div>
        </div>
        <div class="pay_top_top_small_div">
          <div class="pay_top_top_small">元</div>
        </div>
      </div>
      <div class="pay_top_top_bottom">当前费用</div>
    </div>
    <div class="pay_top_right">
      <div class="pay_top_top" id="parking_time">
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
  <div class="pay_title">费用明细</div>
  <c:if test="${parkingInfo.unPayAmt != '0.00'}">
    <div class="pay_line" onclick="jumpUnpayPage();">
      <div class="pay_line_left">待缴费用(超时)</div>
      <div class="pay_line_right">
        <span class="red"><fmt:formatNumber type='number' value='${parkingInfo.unPayAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元
        <img class="coupon_arrow" src="${contextPath}/resources/images/weChat/parking_pay/arrow_walletlist@3x.png">
      </div>
    </div>
  </c:if>
  <div class="pay_line">
    <div class="pay_line_left">捷惠服务费</div>
    <div class="pay_line_right">${parkingInfo.serviceFee}元</div>
  </div>
  <div class="pay_line" <c:if test="${parkingInfo.maxCouponsId != 0}">onclick="openCoupon();"</c:if>>
    <div class="pay_line_left">优惠</div>
    <div class="pay_line_right">
      <c:if test="${parkingInfo.maxCouponsId == 0}">
        暂无优惠券
      </c:if>
      <c:if test="${parkingInfo.maxCouponsId != 0}">
        已抵扣<span class="red" id="couponsAmtDiv"><fmt:formatNumber type='number' value='${parkingInfo.maxCouponsAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元
        <img class="coupon_arrow" src="${contextPath}/resources/images/weChat/parking_pay/arrow_walletlist@3x.png">
      </c:if>
    </div>
  </div>
  <c:if test="${parkingInfo.realParkingAmt != parkingInfo.parkingAmt}">
    <div class="pay_line">
      <div class="pay_line_left">抢车位优惠</div>
      <div class="pay_line_right"><fmt:formatNumber type='number' value='${parkingInfo.reduceAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>元</div>
    </div>
  </c:if>
  <div class="pay_title">支付方式</div>
  <div class="pay_way_line pay_way_sele pay_way_balance" onclick="selectPayWay(this, 3);">
    <img class="pay_way_line_img" src="${contextPath}/resources/images/weChat/parking_pay/pic_payment_balance_h@3x.png">
    <div>余额支付（余额：<span><fmt:formatNumber type='number' value='${parkingInfo.userBalance}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元）</div>
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
  <c:if test="${isAliCityServer == 1}">
    <div class="server_tel" onclick="window.location.href = 'tel:4008201759'">本服务由上海杰汇信息科技有限公司提供<br>客服电话：400-820-1759</div>
  </c:if>
  <div class="pay_button_div_blank"></div>
  <c:if test="${parkingInfo.isJoinDiscount == 1 && parkingInfo.parkingType != 3 && parkingInfo.parkingType != 4}">
    <img class="act_img" onclick="grab();" src="${contextPath}/resources/images/weChat/parking_pay/icon_qizheyouhui@3x.png?2016121301">
  </c:if>
  <div class="pay_button_div">
    <div class="pay_button_amt">总计：<span id="totalAmtDiv"></span>元</div>
    <div class="pay_button" onclick="submitPay(this);">支付</div>
  </div>
  <div class="coupon_div">
    <div class="coupon_back" onclick="closeCoupon();"></div>
    <div class="coupon_content">
      <div class="coupon_content_title">选择优惠券</div>
      <img class="coupon_content_close" onclick="closeCoupon();" src="${contextPath}/resources/images/weChat/parking_pay/icon_discount_cross@3x.png">
      <div class="coupon_list">
        <c:forEach items="${parkingInfo.couponsUserList}" var="coupons">
          <div class="coupon_detail <c:if test="${parkingInfo.maxCouponsId == coupons.id}">sel_coupon</c:if>" onclick="selectCoupon(this, ${coupons.id}, ${coupons.amt});">
            <div class="coupon_detail_sel_div">
              <c:if test="${parkingInfo.maxCouponsId == coupons.id}">
                <img class="coupon_detail_sel" src="${contextPath}/resources/images/weChat/parking_pay${imagePath}bg_discount_check@3x.png"/>
              </c:if>
              <c:if test="${parkingInfo.maxCouponsId != coupons.id}">
                <img class="coupon_detail_sel" src="${contextPath}/resources/images/weChat/parking_pay${imagePath}bg_discount_circle@3x.png"/>
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
  <div class="net_div">
    <div class="net_back" onclick="$('.net_div').css('display', 'none');"></div>
    <div class="net_content">
      <div class="net_text1">网络正在抢修，暂停手机支付<br>给您造成的不便敬请谅解</div>
      <%--<div class="net_text2">2元优惠券已发放，<span onclick="jumpCouponPage();">请查收</span></div>--%>
      <div class="net_button_div">
        <div class="net_button" onclick="$('.net_div').css('display', 'none');">确认</div>
      </div>
    </div>
  </div>
  <c:if test="${parkingInfo.realParkingAmt != parkingInfo.parkingAmt}">
  <div class="grab_div">
    <div class="grab_back" onclick="closeGrab();"></div>
    <div class="grab_content">
      <img class="grab_content_close" onclick="closeGrab();" src="${contextPath}/resources/images/weChat/parking_pay/icon_discount_cross@3x.png">
      <div class="grab_content_title">恭喜你本次停车费优惠&nbsp;<span><fmt:formatNumber type='number' value='${parkingInfo.reduceAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>&nbsp;元</div>
      <div class="grab_content_text">注：优惠车位将为您保留30分钟，30分钟未支付，该优惠将自动取消</div>
      <div class="grab_content_button" onclick="closeGrab();">确认</div>
    </div>
  </div>
  </c:if>
  <div id="ali_pay_hidden_div" style="display: none;"></div>
</body>
</html>
