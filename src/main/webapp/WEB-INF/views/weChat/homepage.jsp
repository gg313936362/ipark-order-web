<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title></title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/base.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/wap_show_tools/wap_show_tools.css?2017022805">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/simple_slider/simple_slider.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/owlcarousel/owl.carousel.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/lib/owlcarousel/owl.theme.default.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/local/weChat/homepage.css?2016120801">

  <script type="text/javascript" src="${contextPath}/resources/js/lib/jquery/jquery_1.9.min.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/common/base.js?2016050301"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/wap_show_tools/wap_show_tools.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/simple_slider/simple_slider.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/lib/owlcarousel/owl.carousel.js"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/weChat/homepage.js?2017081603"></script>
  <script type="text/javascript" src="${contextPath}/resources/js/local/count_code/baidu_count.js"></script>
</head>
<body style="margin-top: -20px;">
  <input type="hidden" value="${contextPath}" id="contextPath">
  <div class="slider">
    <ul></ul>
  </div>
  <div class="homepage_tips">
  </div>
  <input type="hidden" id="car_num_list" value="<c:forEach items="${parkList}" var="park">${park.carNum},</c:forEach>">
  <input type="hidden" id="park_info_list" value="
  <c:forEach items="${parkList}" var="park">
    {'carNum' : '${park.carNum}',
    <c:if test="${park.parkingInfo == null}">
      'parkingLogId' : '0', 'status' : '0'},
    </c:if>
    <c:if test="${park.parkingInfo != null}">
      'parkingLogId' : '${park.parkingInfo.parkingLogId}', 'status' : '${park.parkingInfo.status}'},
    </c:if>
  </c:forEach>
  ">
  <div class="park_list">
    <div class="refresh_button" onclick="$('body').showLoadingView();location.reload();">
      <img src="${contextPath}/resources/images/weChat/homepage/icon_home_renovate@3x.png">
      刷新
    </div>
    <div class="problem_button" onclick="jumpProblemPage();">
      问题反馈
    </div>
    <div class="owl_carousel">
      <c:if test="${fn:length(parkList) == 0}">
        <div class="item">
          <div class="park_detail">
            <img class="park_detail_no_img" src="${contextPath}/resources/images/weChat/homepage/pic4@3x.png">
            <div class="park_detail_no_tips">您暂无任何车辆信息</div>
          </div>
          <div class="park_operate_div">
            <div class="park_operate_button" onclick="jumpAddCarNumPage();">添加车辆</div>
          </div>
          <div class="park_info">
            <div class="park_info_left">时长</div>
            <div class="park_info_right">0小时0分钟</div>
          </div>
        </div>
      </c:if>
      <c:forEach items="${parkList}" var="park">
        <c:if test="${park.parkingInfo == null || (park.parkingInfo.status == 4 || park.parkingInfo.status == 5 || park.parkingInfo.status == 6)}">
          <div class="item">
            <div class="park_detail">
              <img class="park_detail_no_img" src="${contextPath}/resources/images/weChat/homepage/pic4@3x.png">
              <div class="park_detail_no_tips">
                <c:if test="${park.parkingInfo == null}">您未驶入捷惠停车场</c:if>
                <c:if test="${park.parkingInfo.status == 4}">无法找到停车场对应的<br>计费脚本</c:if>
                <c:if test="${park.parkingInfo.status == 5}">本停车场不支持<br>电子支付</c:if>
                <c:if test="${park.parkingInfo.status == 6}">您已驶入包月停车场</c:if>
              </div>
            </div>
            <div class="park_operate_div">
            </div>
            <div class="park_info">
              <div class="park_info_left">时长</div>
              <div class="park_info_right">0小时0分钟</div>
            </div>
          </div>
        </c:if>
        <c:if test="${park.parkingInfo != null && park.parkingInfo.status == 1}">
          <div class="item">
            <div class="park_detail">
              <div class="park_detail_tips_1">计费中</div>
              <div class="park_detail_info">
                <div class="park_detail_info_amt_div">
                  <div class="park_detail_info_amt">
                    <fmt:formatNumber type='number' value='${park.parkingInfo.parkingAmt}' maxFractionDigits="0" groupingUsed="false"></fmt:formatNumber>
                  </div>
                </div>
                <div class="park_detail_info_yuan_div">
                  <div class="park_detail_info_yuan">元</div>
                </div>
              </div>
              <div class="park_detail_tips_2">当前费用</div>
            </div>
            <div class="park_operate_div">
              <c:if test="${park.parkingInfo.isJoinDiscount == 0}">
                <div class="park_operate_button park_operate_pay" onclick="jumpPayPage(${park.parkingInfo.parkingLogId})">付费</div>
              </c:if>
              <c:if test="${park.parkingInfo.isJoinDiscount == 1}">
                <div class="park_operate_pay_grab" onclick="jumpPayPage(${park.parkingInfo.parkingLogId})"></div>
              </c:if>
            </div>
            <div class="park_info">
              <div class="park_info_left">时长</div>
              <div class="park_info_right">${park.parkingInfo.parkingTimeLength}</div>
            </div>
          </div>
        </c:if>
        <c:if test="${park.parkingInfo != null && park.parkingInfo.status == 3}">
          <div class="item">
            <div class="park_detail">
              <div class="park_detail_tips_1">支付成功</div>
              <div class="park_detail_info run_timer">
                <div class="park_detail_info_minute_div">
                  <div class="park_detail_info_minute"><fmt:formatNumber type='number' value="${(park.parkingInfo.freeSurplusTime - park.parkingInfo.freeSurplusTime % 60) / 60}" pattern="00"/></div>
                </div>
                <div class="park_detail_info_min_div">
                  <div class="park_detail_info_min">min</div>
                </div>
                <div class="park_detail_info_sec_div">
                  <div class="park_detail_info_sec"><fmt:formatNumber type='number' value="${park.parkingInfo.freeSurplusTime % 60}" pattern="00"/></div>
                </div>
                <div class="park_detail_info_s_div">
                  <div class="park_detail_info_s">s</div>
                </div>
              </div>
              <div class="park_detail_tips_2">免费出场时间</div>
            </div>
            <div class="park_operate_div">
              <div class="park_operate_button" onclick="jumpPayPage(${park.parkingInfo.parkingLogId})">查看详情</div>
            </div>
            <div class="park_info">
              <div class="park_info_left">支付金额</div>
              <div class="park_info_right"><fmt:formatNumber type='number' value='${park.parkingInfo.payAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>元</div>
            </div>
          </div>
        </c:if>
        <c:if test="${park.parkingInfo != null && park.parkingInfo.status == 2}">
          <div class="item">
            <div class="park_detail">
              <div class="park_detail_tips_1">计费中</div>
              <div class="park_detail_info">
                <div class="park_detail_info_amt_div">
                  <div class="park_detail_info_amt">
                    <fmt:formatNumber type='number' value='${park.parkingInfo.timeoutAmt}' maxFractionDigits="2" groupingUsed="false"></fmt:formatNumber>
                  </div>
                </div>
                <div class="park_detail_info_yuan_div">
                  <div class="park_detail_info_yuan">元</div>
                </div>
              </div>
              <div class="park_detail_tips_2">超时费用</div>
            </div>
            <div class="park_operate_div">
              <div class="park_operate_button" onclick="jumpPayPage(${park.parkingInfo.parkingLogId})">查看详情</div>
            </div>
            <div class="park_info">
              <div class="park_info_left">时长</div>
              <div class="park_info_right">${park.parkingInfo.parkingTimeLength}</div>
            </div>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>
  <div class="bottom_bar_brace"></div>
  <div class="bottom_bar">
    <div class="bottom_bar_button" onclick="jumpMemInfoPage();">
      <img src="${contextPath}/resources/images/weChat/homepage/icon_home_personal-center@3x.png">
      <div>个人中心</div>
    </div>
    <div class="bottom_bar_button" onclick="jumpParkListPage();">
      <img src="${contextPath}/resources/images/weChat/homepage/search@3x.png">
      <div>查找停车场</div>
    </div>
    <div class="bottom_bar_button" onclick="jumpOrderParkListPage();">
      <img src="${contextPath}/resources/images/weChat/homepage/time@3x.png">
      <div>包月服务</div>
    </div>
  </div>
</body>
</html>