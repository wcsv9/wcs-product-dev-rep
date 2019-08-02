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
<%@page import="com.ibm.commerce.bi.BIConfigRegistry"%>
<%@page import="com.ibm.commerce.command.CommandContext"%>
<%@page import="com.ibm.commerce.server.ECConstants"%>
<%@ page import="com.ibm.commerce.server.JSPHelper"%>
<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<!--Start StoreName.jsp -->
<wcf:url var="StoreLocatorsB2CDisplayMapView"  value="StoreLocatorsB2CDisplayMapView">
	<wcf:param name="storeId"   value="${param.storeId}"  />
	<wcf:param name="catalogId" value="${param.catalogId}"/>
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="orderId" value="NA" />
	<wcf:param name="orderItemId" value="NA" />
	
	<c:choose>
		<c:when test="${!empty sessionScope.lat}">
			<wcf:param name="lat" value="${sessionScope.lat}" />
			<wcf:param name="long" value="${sessionScope.longs}" />
		</c:when>
		<c:otherwise>
			<wcf:param name="lat" value="-37.8104" />
			<wcf:param name="long" value="145.006" />
		</c:otherwise>
	</c:choose>	
	
</wcf:url>


		 <div id="ContactUs" ><div><a href="${fn:escapeXml(StoreLocatorsB2CDisplayMapView)}">FIND A STORE</a></div></div> 
		
		
		
		