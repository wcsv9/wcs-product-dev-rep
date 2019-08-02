<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<!--Start StoreName.jsp -->

<div class="storeLocator">
		<b>YOUR STORE:</b>
		<c:if test="${empty sessionScope.storeName1}">
			Office National
		</c:if>
		<c:if test="${!empty sessionScope.storeName1}">
			<c:out value="${fn:escapeXml(sessionScope.storeName1)}" /> 
		</c:if>
		<!--
		&nbsp&nbsp <a href="${fn:escapeXml(param.StoreLocatorsB2CDisplayMapView)}"  return false;">Change my store &gt;</a>
		-->
		</div>