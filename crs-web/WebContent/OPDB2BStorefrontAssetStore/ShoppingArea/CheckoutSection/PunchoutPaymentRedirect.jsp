<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP file is used to redirect the browser to a punchout payment portal web page.
  * It is mapped to PunchoutPaymentRedirectView.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/nocache.jspf"%>
<c:set var="piidcustom" value="${WCParam.piId }"/>
<c:set var="selectedStoreIdForON" value="${WCParam.selectedStoreIdForON}" scope="page"/>
<c:if test="${WCParam.storeId ne '98552'}">
	<c:set var="selectedStoreIdForON" value="0" scope="page"/>
</c:if>

<c:if test="${empty WCParam.piId }">
	<wcf:rest var="getEwayEnKey" url="store/{storeId}/ordersummary/getEwayEnKey/{orderId}/{selectedStoreIdForON}" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:var name="orderId" value="${WCParam.orderId}" encode="true"/>
		<wcf:var name="selectedStoreIdForON" value="${selectedStoreIdForON}" encode="true"/>
	</wcf:rest>	
	<c:set var="piidcustom" value="${getEwayEnKey.piId }"/>
	
</c:if>	

<wcf:rest var="pi" url="store/{storeId}/cart/@self/payment_instruction/punchoutPaymentInfo" scope="request">
	<wcf:var   name="storeId" value="${WCParam.storeId}" encode="true" />
	<wcf:param name="orderId" value="${WCParam.orderId}" encode="true" />
	<wcf:param name="piId"    value="${piidcustom}"    encode="true" />
	<wcf:param name="profileName" value="IBM_PunchoutPaymentInfo" /> 
</wcf:rest>

<c:set var="url" value="${pi.paymentInstruction[0].xpapi_punchoutPopupURL}&useraction=commit" />
<c:set var="pageCategory" value="Checkout" scope="request"/>

<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@ include file="../../Common/CommonCSSToInclude.jspf"%>
		<title><fmt:message bundle="${storeText}" key="PUNCHOUT_PAYMENT_REDIRECT"/></title>
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>
	</head>
	<body id="punchout_payment_redirect_page">
		<c:set var="escapeXml" value="false"/>
		<c:if test="${fn:indexOf(url, '<form') != 0}">
			<c:set var="escapeXml" value="true"/>
		</c:if>
		<div id="punchout_payment_redirect" style="display:none;"><c:out value="${url}" escapeXml="${escapeXml}" /></div>
		<form name="punchoutPaymentRedirectForm_AuthTokenInfo"  id="punchoutPaymentRedirect_AuthTokenInfo">
			<input type="hidden" name="authToken" id="punchoutPaymentRedirect_authToken" value="<c:out value='${authToken}'/>"/>
		</form>
		<script type="text/javascript">
			$(document).ready(function(){
				cursor_clear();
				PunchoutJS.pay(<wcf:out value="${WCParam.storeId}" escapeFormat="js"/>, <wcf:out value="${WCParam.orderId}" escapeFormat="js"/>, <wcf:out value="${piidcustom}" escapeFormat="js"/>, "punchout_payment_redirect", true);
			});
		</script>
	<%@ include file="../../Common/JSPFExtToInclude.jspf"%> </body>
</html>
