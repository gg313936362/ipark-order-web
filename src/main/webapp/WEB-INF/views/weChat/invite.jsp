<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>推荐好友</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/invite.css">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/weixin/jweixin_1.0.0.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/invite.js"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <input type="hidden" value="${jsapiParam.appId}" id="appId">
  <input type="hidden" value="${jsapiParam.nonceStr}" id="nonceStr">
  <input type="hidden" value="${jsapiParam.timestamp}" id="timestamp">
  <input type="hidden" value="${jsapiParam.signature}" id="signature">
  <input type="hidden" value="${memInfo.activityTitle}" id="activityTitle">
  <input type="hidden" value="${memInfo.activityContent}" id="activityContent">
  <input type="hidden" value="${memInfo.activityUrl}" id="activityUrl">
  <div class="top">
    <div>
      <div class="top_left_div">推荐好友送</div>
    </div>
    <div>
      <div class="top_mid_div">${memInfo.shareMaxCouponsAmt}</div>
    </div>
    <div>
      <div class="top_right_div">元优惠券</div>
    </div>
  </div>
  <img class="top_img" src="${contextPath}/resources/images/weChat/invite/pic_share@3x.png">
  <div class="rate">
    <div class="rate_round <c:if test="${memInfo.inviteCount % 5 >= 1}">rate_sel</c:if>">¥${memInfo.shareMinCouponsAmt}</div>
    <div class="rate_line <c:if test="${memInfo.inviteCount % 5 >= 1}">rate_sel</c:if>"></div>
    <div class="rate_round <c:if test="${memInfo.inviteCount % 5 >= 2}">rate_sel</c:if>">¥${memInfo.shareMinCouponsAmt}</div>
    <div class="rate_line <c:if test="${memInfo.inviteCount % 5 >= 2}">rate_sel</c:if>"></div>
    <div class="rate_round <c:if test="${memInfo.inviteCount % 5 >= 3}">rate_sel</c:if>">¥${memInfo.shareMinCouponsAmt}</div>
    <div class="rate_line <c:if test="${memInfo.inviteCount % 5 >= 3}">rate_sel</c:if>"></div>
    <div class="rate_round <c:if test="${memInfo.inviteCount % 5 >= 4}">rate_sel</c:if>">¥${memInfo.shareMinCouponsAmt}</div>
    <div class="rate_line <c:if test="${memInfo.inviteCount % 5 >= 4}">rate_sel</c:if>"></div>
    <div class="rate_round <c:if test="${memInfo.inviteCount % 5 == 5}">rate_sel</c:if>">¥${memInfo.shareMaxCouponsAmt}</div>
  </div>
  <div class="share_button" onclick="showSharePage();">立即分享</div>
  <div class="rule">
    <div class="rule_tile">活动规则</div>
    <c:forEach items="${memInfo.activityDescs}" var="activityDesc">
      <div class="rule_text">${activityDesc}</div>
    </c:forEach>
  </div>
  <div class="shareRemind" onclick="hiddenSharePage();">
    <img src="${contextPath}/resources/images/weChat/invite/shareTo.png" />
  </div>
</body>
</html>
