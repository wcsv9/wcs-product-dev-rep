<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2018 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN PrivacyPolicyPopup.jsp -->
<%@ include file="/Widgets_801/Common/EnvironmentSetup.jspf"%>
<%@ include file="/Widgets_801/Common/nocache.jspf"%>

<c:set var="emsName" value="PrivacyPolicyPageCenter_Content"
	scope="request" />
<%@include
	file="../../com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation_Data.jspf"%>
<c:set var="contentName" value="${eSpotDatas.baseMarketingSpotActivityData[0].contentName}"/>
<c:set var="isSession" value="false"/>
<flow:ifEnabled feature="Session">
	<c:set var="isSession" value="true"/>
</flow:ifEnabled>
<%@ include file="ext/PrivacyPolicyPopup_UI.jspf"%>
<c:if test="${param.custom_view ne 'true'}">
	<%@ include file="PrivacyPolicyPopup_UI.jspf"%>
</c:if>
<!-- END PrivacyPolicyPopup.jsp -->