<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>个人中心</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022801">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/mem_info.css?2017022801">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/mem_info.js?2017030502"></script>
</head>
<body>
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="portrait_img_div">
    <img class="portrait_img" src="
    <c:if test="${memInfo.portrait == null}">${contextPath}/resources/images/weChat/mem_info/pic_personalcenter_headportrait@3x.png</c:if>
    <c:if test="${memInfo.portrait != null}">${memInfo.portrait}</c:if>">
  </div>
  <div class="mem_name">${memInfo.username}</div>
  <%--<div class="line" onclick="window.location.href = '${contextPath}/weixin/mem/wallet/init/' + getCookie('openid');">--%>
    <%--<img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_wallet@3x.png">--%>
    <%--<div>我的钱包</div>--%>
    <%--<div class="yue_coupon">余额/优惠券/发票</div>--%>
  <%--</div>--%>
  <div class="line" onclick="window.location.href = '${contextPath}/weixin/car/list/init?openid=' + getCookie('openid');">
    <img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_car@3x.png">
    <div>车辆管理</div>
  </div>
  <%--<div class="line" onclick="window.location.href = '${contextPath}/weixin/park/record/list/init';">--%>
    <%--<img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_record@3x.png">--%>
    <%--<div>停车记录</div>--%>
  <%--</div>--%>
  <div class="line" onclick="window.location.href = '${contextPath}/weixin/order/list/init';">
    <img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_order@3x.png">
    <div>包月订单</div>
    <c:if test="${memInfo.expireDate != null && memInfo.expireDate != ''}">
      <div class="yue_coupon">${memInfo.expireDate}到期</div>
    </c:if>
  </div>
  <%--<div class="bottom">--%>
    <%--<div class="bottom_div" onclick="window.location.href = 'tel:4008201759'">--%>
      <%--<img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_connectus@3x.png">--%>
      <%--<div>联系我们</div>--%>
    <%--</div>--%>
    <%--<div class="bottom_div share_friend" onclick="window.location.href = '${contextPath}/weixin/mem/invite/init/'+ getCookie('webSourceType')+ '/' + getCookie('openid');">--%>
      <%--<img src="${contextPath}/resources/images/weChat/mem_info/icon_recommend@3x.png">--%>
      <%--<div class="green">推荐好友</div>--%>
    <%--</div>--%>
    <%--<div class="bottom_div" onclick="window.location.href = '${contextPath}/weixin/mem/setting/init/' + getCookie('openid');">--%>
      <%--<img src="${contextPath}/resources/images/weChat/mem_info/icon_personalcenter_set@3x.png">--%>
      <%--<div>设置</div>--%>
    <%--</div>--%>
  <%--</div>--%>

</body>
</html>
