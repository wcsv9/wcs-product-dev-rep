<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  ***
  * This JSP shows all the required parameters for a payment using Visa credit card.
  * It is meant to be used in the single page checkout.
  ***
--%>

<!-- BEGIN StandardVisa.jsp -->

<!-- Set the taglib -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<c:set var="paymentAreaNumber" value="${fn:escapeXml(WCParam.currentPaymentArea)}"/>
<c:if test="${empty paymentAreaNumber}">
	<c:set var="paymentAreaNumber" value="${fn:escapeXml(param.paymentAreaNumber)}" />
</c:if>

<%-- Set the default value(current month + 1) of expire_month for this payment method --%>
<jsp:useBean id="now" class="java.util.Date"/>

<c:set var="expire_year" value="${param.expire_year}"/>
<c:set var="expire_month" value="${param.expire_month}"/>
<c:set var="account" value="${param.account}"/>
<c:set var="unmaskedAccount" value="${param.account}"/>
<c:set var="cc_cvc" value="${param.cc_cvc}"/>
<c:set var="piAmount" value="${param.piAmount}"/>
<c:set var="quickCheckoutProfileForPayment" value="${param.quickCheckoutProfileForPayment}"/>

<c:if test="${empty quickCheckoutProfileForPayment}" >
<c:set var="quickCheckoutProfileForPayment" value="${WCParam.quickCheckoutProfileForPayment}"/>
</c:if>


<c:set var="paymentTCId" value="${param.paymentTCId}"/>
<c:if test="${!empty paymentTCId}" >
<c:catch var="error">
	<wcf:rest var="paymentTCbean" url="store/{storeId}/contract" scope="page">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:param name="q" value="byPaymentTermConditionId"/>
		<wcf:param name="paymentTCId" value="${paymentTCId}"/>
	</wcf:rest>
</c:catch>

   	<c:forEach var="pAttrValue" items="${paymentTCbean.PAttrValues}">
       <c:remove var="attribute"/>
       <c:catch var="error">
        <wcf:rest var="attribute" url="store/{storeId}/cart/@self/pattribute/{attribute}" scope="page">
          <wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
          <wcf:var name="attribute" value="${pAttrValue.attributeId}" encode="true"/>
        </wcf:rest>
        <c:set var="attribute" value="${attribute.resultList[0]}"/>
      </c:catch>
	  <c:if test="${attribute.name eq 'account'}">
            <c:if test="${!empty pAttrValue.PAttrValue}">
              <c:set var="valueFromPaymentTC" value="true" />
			  <c:set var="unmaskedAccount" value="${pAttrValue.PAttrValue}"/>
				<wcf:rest var="edpMaskBean" url="store/{storeId}/cart/@self/payment_instruction/sensitive_data_mask_by_plain_string">
					<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
					<wcf:param name="plainString" value="${pAttrValue.PAttrValue}"/>
				</wcf:rest>
   		      <c:set var="account" value="${edpMaskBean.resultList[0].maskedString}" />
            </c:if>
            <c:if test="${empty pAttrValue.PAttrValue}">
	          <c:set var="account" value="" />
            </c:if>
       </c:if>
	   <c:if test="${attribute.name eq 'expire_year'}">
		<c:set var="expire_year" value="${pAttrValue.PAttrValue}"/>
	   </c:if>
	   <c:if test="${attribute.name eq 'expire_month'}">
		<c:set var="expire_month" value="${pAttrValue.PAttrValue}"/>
	   </c:if>
    </c:forEach>
</c:if>
<c:if test="${empty expire_month}">
	<c:set var="expire_month" value="${now.month + 1}"/>
</c:if>
<c:if test="${empty expire_year}">
	<c:set var="expire_year" value="${now.year + 1900}"/>
</c:if>
<%-- Set the default value("VISA") of cc_brand for this payment method --%>
<c:if test="${empty cc_brand}">
	<c:set var="cc_brand" value="VISA"/>
</c:if>

<div class="card_info" id="WC_StandardVisa_div_1_<c:out value='${paymentAreaNumber}'/>">
	<c:choose>
		<c:when test="${valueFromPaymentTC == 'true'}" >
			<input type="hidden" name="valueFromPaymentTC" value="true" />
		</c:when>
		<c:when test="${quickCheckoutProfileForPayment}" >
			<input type="hidden" name="valueFromProfileOrder" value="Y" />  
		</c:when>
	</c:choose>
	<c:set var="accountValue" value="${account}"/>
	<input type="hidden" name="cc_brand" value="<c:out value="${cc_brand}" />" id="WC_StandardVisa_inputs_1_<c:out value='${paymentAreaNumber}'/>"/>
	<input type="hidden" name="paymentTCId" value="<c:out value="${paymentTCId}"/>" id="WC_StandardVisa_inputs_2_<c:out value='${paymentAreaNumber}'/>"/>
	<input type="hidden" name="account" id="account_<c:out value='${paymentAreaNumber}'/>" value="<c:out value="${accountValue}"/>" />
	<input type="hidden" id="mandatoryFields_<c:out value='${paymentAreaNumber}'/>" name="mandatoryFields"  value="account_<c:out value='${paymentAreaNumber}'/>,expire_month_<c:out value='${paymentAreaNumber}'/>,expire_year_<c:out value='${paymentAreaNumber}'/>,cc_cvc_<c:out value='${paymentAreaNumber}'/>,cc_nameoncard_<c:out value='${paymentAreaNumber}'/>,cc_cvc_<c:out value='${paymentAreaNumber}'/>,billing_address_id"/>

	<c:if test="${isBrazilStore}" >
		<%@ include file="OrderInstallmentPriceDisplay.jspf" %>
	</c:if>

	<span class="col1">
		<span class="card_holder">
			<span>
				<span class="required-field">*</span><label for="account1_<c:out value='${paymentAreaNumber}'/>">
				<span><b>Card Holder Name:<b/></span></label>
			</span><br/>
			<span>
				<input type="text" name="cc_nameoncard" value="" id="cc_nameoncard_${paymentAreaNumber}" title="<fmt:message key="Checkout_ACCE_required" bundle="${storeText}"/> <fmt:message key="EDPPaymentMethods_NAME_ON_CARD" bundle="${storeText}"/>" />
				<br/>
			</span>
		</span>
		<div style="height:8px;" ></div>
		<div class="row col12">
		<div class="col7 row setWidthIpadCardNum">
			<div class="">
				<span class="required-field">*</span><label for="account1_<c:out value='${paymentAreaNumber}'/>">
				<span>Card Number:</span></label>
			</div>
			<br/>
			<div class="">
				<input aria-required="true" type="tel" style="width: "  name="account1" onchange="JavaScript:TealeafWCJS.processDOMEvent(event);CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, false, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'account');" value="<c:out value="${accountValue}"/>" id="account1_<c:out value='${paymentAreaNumber}'/>"/>
			</div>
		</div>	
		<div class="col5 setWidthIpadCVV2">
		<span>
			<span class="required-field">*</span><label for="cc_cvc_<c:out value='${paymentAreaNumber}'/>"><fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV" /></label>
		</span><br />
		<input type="tel" style="width: 80%;"  onchange="JavaScript:TealeafWCJS.processDOMEvent(event);CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, false);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'cc_cvc');" name="cc_cvc" size="4" value="<c:out value='${cc_cvc}' />" id="cc_cvc_<c:out value='${paymentAreaNumber}'/>"/>
		<br/>
		<span class="visaCVV2">
			<span id="CVVDetailsSection_<c:out value='${paymentAreaNumber}'/>">		
				<span id="StandardVisa_CVVDetails_AcceText_<c:out value='${paymentAreaNumber}'/>" style="display:none">
					<fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV_WHAT_IS" />
					<fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV_DEFINITION" />
				</span>
				<span id="StandardVisa_CVVDetails_<c:out value='${paymentAreaNumber}'/>" class="order_link" title="<fmt:message key='EDPPaymentMethods_CVV_WHAT_IS' bundle='${storeText}'/><fmt:message key='EDPPaymentMethods_CVV_DEFINITION' bundle='${storeText}'/>" onmouseover="javascript: this.title = '';" onmouseout="javascript: this.title = document.getElementById('StandardVisa_CVVDetails_AcceText_<c:out value='${paymentAreaNumber}'/>').innerHTML;" tabindex="0"><fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV_WHAT_IS" /></span>
				<span id="StandardVisa_CVVDetails_<c:out value='${paymentAreaNumber}'/>_span_2" dojoType="wc.widget.Tooltip" connectId="StandardVisa_CVVDetails_<c:out value='${paymentAreaNumber}'/>" style="display: none;">
					<div id="tooltip_popup_<c:out value='${paymentAreaNumber}'/>" class="widget_site_popup">
						<div class="top">
							<div class="left_border"></div>
							<div class="middle"></div>
							<div class="right_border"></div>
						</div>
						<div class="clear_float"></div>
						<div class="middle">
							<div class="content_left_border">
								<div class="content_right_border">
									<div class="content">
										<div id="WC_StandardVisa_div_2_<c:out value='${paymentAreaNumber}'/>" class="header">
											<span><fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV_WHAT_IS" /></span>
										</div>
						
										<div id="WC_StandardVisa_div_4_<c:out value='${paymentAreaNumber}'/>" class="body">
											<fmt:message bundle="${storeText}" key="EDPPaymentMethods_CVV_DEFINITION" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="clear_float"></div>
						<div class="bottom">
							<div class="left_border"></div>
							<div class="middle"></div>
							<div class="right_border"></div>
						</div>
						<div class="clear_float"></div>
					</div>
				</span>
				<script type="text/javascript">$( document ).ready(function() {parseWidget("StandardVisa_CVVDetails_<c:out value='${paymentAreaNumber}'/>_span_2"); });</script>
			</span>
		</span>
		</div>
		</div>
		
		<span class="date">
			<span class="month_year"><span class="required-field">*</span><label for="expire_month_<c:out value='${paymentAreaNumber}'/>"><fmt:message bundle="${storeText}" key="MONTH" /></label>:<br />
				<select class="drop_down" onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'expire_month');" name="expire_month" id="expire_month_<c:out value='${paymentAreaNumber}'/>">
					<option
					<c:if test="${expire_month == 1 || expire_month == '01'}" > selected="selected" </c:if>
					value="01">01</option>
					<option
					<c:if test="${expire_month == 2 || expire_month == '02'}" > selected="selected" </c:if>
					value="02">02</option>
					<option
					<c:if test="${expire_month == 3 || expire_month == '03'}" > selected="selected" </c:if>
					value="03">03</option>
					<option
					<c:if test="${expire_month == 4 || expire_month == '04'}" > selected="selected" </c:if>
					value="04">04</option>
					<option
					<c:if test="${expire_month == 5 || expire_month == '05'}" > selected="selected" </c:if>
					value="05">05</option>
					<option
					<c:if test="${expire_month == 6 || expire_month == '06'}" > selected="selected" </c:if>
					value="06">06</option>
					<option
					<c:if test="${expire_month == 7 || expire_month == '07'}" > selected="selected" </c:if>
					value="07">07</option>
					<option
					<c:if test="${expire_month == 8 || expire_month == '08'}" > selected="selected" </c:if>
					value="08">08</option>
					<option
					<c:if test="${expire_month == 9 || expire_month == '09'}" > selected="selected" </c:if>
					value="09">09</option>
					<option
					<c:if test="${expire_month == 10 }" > selected="selected" </c:if>
					value="10">10</option>
					<option
					<c:if test="${expire_month == 11 }" > selected="selected" </c:if>
					value="11">11</option>
					<option
					<c:if test="${expire_month == 12 }" > selected="selected" </c:if>
					value="12">12</option>
				</select>
			</span>
			<span><span class="required-field">*</span><label for="expire_year_<c:out value='${paymentAreaNumber}'/>"><fmt:message bundle="${storeText}" key="YEAR" /></label>:<br />
				<select class="drop_down" name="expire_year" onchange="JavaScript:CheckoutPayments.removeCreditCardNumberAndCVV(<c:out value='${paymentAreaNumber}'/>, true, true);CheckoutHelperJS.paymentDataDirty(<c:out value='${paymentAreaNumber}'/>, true);CheckoutPayments.updatePaymentObject(<c:out value='${paymentAreaNumber}'/>, 'expire_year');" id="expire_year_<c:out value='${paymentAreaNumber}'/>">
					<c:set var="current_year" value="${now.year + 1900}"/>
					<c:forEach begin="0" end="10" varStatus="counter">
						<option
						<c:if test="${expire_year == current_year+counter.index }" > selected="selected" </c:if>
						value="${current_year+counter.index}">${current_year+counter.index}</option>
					</c:forEach>
				</select>
			</span>
		</span>
		<%--
		***************************
		* Start: Show the remaining amount -- the amount not yet allocated to a payment method
		***************************
		--%>
		<%@ include file="PaymentAmount.jspf"%>
	</span>	
</div>
<!-- END StandardVisa.jsp -->