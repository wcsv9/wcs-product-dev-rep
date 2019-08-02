<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2007
//* All Rights Reserved
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>
<%-- 
  ***
  * This JSP shows all the required parameters for a payment using offline credit card.
  * It is meant to be used in the single page checkout.
  *
  * It is basically just asking for the payment amount and the billing address.
  ***
--%>

<!-- Start - JSP File Name: PayPal.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<c:set var="paymentAreaNumber" value="${WCParam.currentPaymentArea}"/>
<c:if test="${empty paymentAreaNumber}">
	<c:set var="paymentAreaNumber" value="${param.paymentAreaNumber}" />
</c:if>
<c:set var="paymentTCId" value="${param.paymentTCId}"/>
<c:set var="catalogId" value="${param.catalogId}"/>
<c:set var="storeId" value="${param.storeId}"/>
<c:set var="langId" value="${param.langId}"/>
<div id="WC_PayPal_div_0">
  <span>
	<img src="https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">The safer, easier way to pay.</span>
	</span>
</div>
<br>
<div class="card_info" id="WC_PayPal_div_1">

	<%-- The section to collect the protocol data for this payment method --%>
	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_PayPal_inputs_1"/>
  <input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" />
	<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" />
	<input type="hidden" name="langId" value="<c:out value="${langId}"/>" />
	<span class="col1">

		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<%@ include file="PaymentAmount.jspf"%>
	</span>
</div>
<!-- End - JSP File Name: PayPal.jsp -->