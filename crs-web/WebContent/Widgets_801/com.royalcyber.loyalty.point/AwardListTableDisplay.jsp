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
<!-- START AwardListTableDisplay.jsp -->


<wcf:rest var="getLoyaltySoupStatusEnabled" url="store/{storeId}/loyalty/getLoyaltySoupStatusEnabled/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${param.userId}" encode="true"/>
</wcf:rest>	


<c:set var="loyaltyEnabled" value="${getLoyaltySoupStatusEnabled.loyaltyEnabled}" scope="session" />
<%--<c:set var="loyPoints" value="${awardAccesBean.userPoints}"/> --%>

<c:set var="totalPoints" value="${getLoyaltySoupStatusEnabled.totalPoints}" scope="session" />
<c:set var="webid" value="${getLoyaltyRestStatusEnabled.webid}" scope="session"/> 


<c:choose>
	<c:when test="${not empty getLoyaltySoupStatusEnabled.totalPoints && getLoyaltySoupStatusEnabled.totalPoints ne '0'}">
		<c:set var="totalPoints" value="${totalPoints}" scope="session" />
	</c:when>
	<c:otherwise>
		<c:set var="totalPoints" value="0" scope="session" />
	</c:otherwise>
		
</c:choose>
<%--
	<c:when test="${not empty loyPoints && totalPoints eq '0' && state eq 'WCS'}">
		<c:set var="totalPoints" value="${loyPoints}" scope="session" />
	</c:when> --%>
<!-- END AwardListTableDisplay.jsp -->