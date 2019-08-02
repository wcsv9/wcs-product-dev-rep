<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
 --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<%--<wcbase:useBean classname="au.officenational.order.commands.XLoyaltyPointsHistoryDataBean" id="awardAccesBean"></wcbase:useBean> --%>
<!-- BEGIN AwardListTableDisplay.jsp -->
<!-- Start Loyalty Point Changes May082013 remove below code-->


<c:set var="storeId1" value="${storeId}"/>

<wcf:rest var="getLoyaltyStatus" url="store/{storeId}/loyalty/getLoyaltyStatus/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${userId}" encode="true"/>
</wcf:rest>
		

<%--
 <wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>			
<c:set var="firstName" value="${person.contactInfo.contactName.firstName}"/>

<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>
<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>

<c:set var="logonid" value="${person.credential.logonID}"/>
	 --%>
     <c:choose>
	 <c:when test="${getLoyaltyStatus.content eq 'true' && getLoyaltyStatus.state eq 'WCS'}">
	
	<%--<%@ include file="LoyaltyPointLocal.jsp"%> --%>

	</c:when>
	 <c:when test="${getLoyaltyStatus.source eq 'REST'}">
	
		<%@ include file="LoyaltyRestAPI.jsp"%>

	</c:when>
	<c:otherwise>


	
	
	<%@ include file="LoyaltySoapAPI.jsp"%>
   
  
	
	</c:otherwise>
   </c:choose>
  
  
  

			

 
   
   
	
