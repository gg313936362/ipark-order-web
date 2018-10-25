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
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/parking_free.css?2017030602">
  <c:if test="${isAliCityServer == 1}">
    <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/parking_free_ali.css?20170307">
  </c:if>

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script src="https://as.alipayobjects.com/g/component/antbridge/1.1.1/antbridge.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/parking_free.js?2017070601"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${jsapiParam.appId}" id="appId">
  <input type="hidden" value="${jsapiParam.nonceStr}" id="nonceStr">
  <input type="hidden" value="${jsapiParam.timestamp}" id="timestamp">
  <input type="hidden" value="${jsapiParam.signature}" id="signature">
  <input type="hidden" value="${parkingInfo.activityTitle}" id="activityTitle">
  <input type="hidden" value="${parkingInfo.activityContent}" id="activityContent">
  <input type="hidden" value="${parkingInfo.activityUrl}" id="activityUrl">
  <div class="pay_top">
    <div class="pay_top_mid_div">
      <div class="pay_top_mid">
        <img src="${contextPath}/resources/images/weChat/parking_free/pay_success@3x.png">
        <div>支付成功</div>
      </div>
    </div>
    <div class="pay_top_left">
      <div class="pay_top_top" id="free_time">
        <div class="pay_top_top_big_div">
          <div class="pay_top_top_big">
            <span id="mim"><fmt:formatNumber type='number' value="${(parkingInfo.freeSurplusTime - parkingInfo.freeSurplusTime %60) / 60}" pattern="00"/></span>:<span id="sec"><fmt:formatNumber type='number' value="${parkingInfo.freeSurplusTime % 60}" pattern="00"/></span>
          </div>
        </div>
      </div>
      <div class="pay_top_top_bottom">免费时间</div>
    </div>
    <div class="pay_top_right">
      <div class="pay_top_top">
        <div class="pay_top_top_big_div">
          <div class="pay_top_top_big">
            <fmt:formatNumber type='number' value='${parkingInfo.payAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>
          </div>
        </div>
        <div class="pay_top_top_small_div">
          <div class="pay_top_top_small">元</div>
        </div>
      </div>
      <div class="pay_top_top_bottom">已付费用</div>
    </div>
    <div class="pay_top_bottom"></div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">停车场</div>
    <div class="pay_line_right">${parkingInfo.parkName}</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">入场时间</div>
    <div class="pay_line_right">${parkingInfo.arriveTime}</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">支付时间</div>
    <div class="pay_line_right">${parkingInfo.payTime}</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">停车时长</div>
    <div class="pay_line_right" id="parking_time">${parkingInfo.parkingTimeLength}</div>
  </div>
  <div class="pay_title">费用明细</div>
  <c:if test="${parkingInfo.unPayAmt != '0.00'}">
    <div class="pay_line">
      <div class="pay_line_left">待缴费用(超时)</div>
      <div class="pay_line_right">
        <span class="red"><fmt:formatNumber type='number' value='${parkingInfo.unPayAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元
      </div>
    </div>
  </c:if>
  <div class="pay_line">
    <div class="pay_line_left">捷停服务费</div>
    <div class="pay_line_right">${parkingInfo.serviceFee}元</div>
  </div>
  <div class="pay_line">
    <div class="pay_line_left">优惠</div>
    <div class="pay_line_right">
      <c:if test="${parkingInfo.discountAmt == '0.00'}">
        未使用优惠券
      </c:if>
      <c:if test="${parkingInfo.discountAmt != '0.00'}">
        已抵扣<span class="red" id="couponsAmtDiv"><fmt:formatNumber type='number' value='${parkingInfo.discountAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元
      </c:if>
    </div>
  </div>
  <div class="pay_line" style="margin-bottom: 36px;">
    <div class="pay_line_left">支付费用</div>
    <div class="pay_line_right">
      <span class="red"><fmt:formatNumber type='number' value='${parkingInfo.payAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber></span>元
    </div>
  </div>
  <c:if test="${isAliCityServer == 1}">
    <div class="server_tel" onclick="window.location.href = 'tel:4008201759'">本服务由上海杰汇信息科技有限公司提供<br>客服电话：400-820-1759</div>
  </c:if>
  <img class="hongbao_img" onclick="showSharePage();" src="${contextPath}/resources/images/weChat/parking_free/moeney@3x.png">
  <div class="shareRemind" onclick="hiddenSharePage();">
    <img src="${contextPath}/resources/images/weChat/parking_free/shareTo.png" />
  </div>
  <div class="share_div">
    <div class="share_back" onclick="$('.share_div').css('display', 'none');"></div>
    <div class="share_content">
      <div class="share_top">
        <img src="${contextPath}/resources/images/weChat/parking_free/icon_X@3x.png" onclick="$('.share_div').css('display', 'none');">
        <div>
          <c:if test="${parkingInfo.parkingType < 3}">分享有优惠</c:if>
          <c:if test="${parkingInfo.parkingType == 3 || parkingInfo.parkingType == 4}">本次抢车位帮你减免${parkingInfo.reduceAmt}元</c:if>
        </div>
      </div>
      <div class="share_text">推荐5位好友送<span>${parkingInfo.shareTotalCouponsAmt}</span>元优惠券<br>推荐一位好友送${parkingInfo.shareMinCouponsAmt}元优惠券</div>
      <div class="share_rate">
        <div class="share_rate_round <c:if test="${parkingInfo.inviteCount % 5 >= 1}">share_rate_sel</c:if>">¥${parkingInfo.shareMinCouponsAmt}</div>
        <div class="share_rate_line <c:if test="${parkingInfo.inviteCount % 5 >= 1}">share_rate_sel</c:if>"></div>
        <div class="share_rate_round <c:if test="${parkingInfo.inviteCount % 5 >= 2}">share_rate_sel</c:if>">¥${parkingInfo.shareMinCouponsAmt}</div>
        <div class="share_rate_line <c:if test="${parkingInfo.inviteCount % 5 >= 2}">share_rate_sel</c:if>"></div>
        <div class="share_rate_round <c:if test="${parkingInfo.inviteCount % 5 >= 3}">share_rate_sel</c:if>">¥${parkingInfo.shareMinCouponsAmt}</div>
        <div class="share_rate_line <c:if test="${parkingInfo.inviteCount % 5 >= 3}">share_rate_sel</c:if>"></div>
        <div class="share_rate_round <c:if test="${parkingInfo.inviteCount % 5 >= 4}">share_rate_sel</c:if>">¥${parkingInfo.shareMinCouponsAmt}</div>
        <div class="share_rate_line <c:if test="${parkingInfo.inviteCount % 5 >= 4}">share_rate_sel</c:if>"></div>
        <div class="share_rate_round <c:if test="${parkingInfo.inviteCount % 5 == 5}">share_rate_sel</c:if>">¥${parkingInfo.shareMaxCouponsAmt}</div>
      </div>
      <div class="share_button_div">
        <div class="share_button" onclick="showSharePage();">立即分享</div>
      </div>
    </div>
  </div>
</body>
</html>
