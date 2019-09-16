

<%-- 
  *****
  * This JSP file renders the order totals section used throughout the entire checkout flow.
  *****
--%>
<!-- BEGIN SingleShipmentOrderTotalsSummaryForApproval.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>


<script type="text/javascript">
	dojo.addOnLoad(initDiscountDetails);
	
	function initDiscountDetails(){	
		<%-- Initially discountDetailsSection div will be hidden (Otherwise all the tooltip pop-ups will be visible and disappear only after dojo parses it. So hide them initially). Display it on page load. --%>
		if(document.getElementById("discountDetailsSection")!=null )  {
			document.getElementById("discountDetailsSection").style.display = "block";
		}
	}
</script>

<c:set var="orderIdd" value="${requestScope.orderIdd}" />

<%-- the following check is to handle the AJAX case in the Shopping Cart page and Shipment Display page 
	when user modifies his/her order. In both pages, the "order" data is of the same type and has the same parameters --%>
<c:if test="${empty orderIdd || orderIdd==null}">

	<wcf:rest var="order" url="store/${WCParam.storeId}/cart/@self" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
	</wcf:rest>	

</c:if>

<c:set var="totalProductDiscount" value="0"/>
<c:set var="hasProductDiscount" value="false"/>
<c:set var="showTotals" value="true"/>

<flow:ifDisabled feature="SharedShippingBillingPage">
	<c:if test="${param.fromPage eq 'shoppingCartDisplay' || param.fromPage eq 'shippingPage'}">
		<c:set var="showTotals" value="false"/>
	</c:if>
</flow:ifDisabled>

<div style="clear:both"></div>

<div id="total_breakdown"style="padding-top:18px">

	<table id="order_total" cellpadding="0" cellspacing="0" border="0" summary="<fmt:message key="ORDER_TOTAL_TABLE_SUMMARY" bundle="${storeText}"/>">

		<c:set var="extorderId" value="${order.orderId}" scope="page" />	
		
			<wcf:rest var="getParams" url="store/${WCParam.storeId}/orderApproval/getParams/{orderId}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
				<wcf:var name="orderId" value="${WCParam.orderId}"/>	     		
		</wcf:rest>	

<c:set var="totalProductPrice" value="${orderIdd.totalProductPrice}"/>
<c:set var="totalSalesTax" value="${orderIdd.totalSalesTax }"/>
<c:set var="totalAdjustment" value="${orderIdd.totalAdjustment }"/>
<c:set var="totalShippingTax" value="${orderIdd.totalShippingTax }"/>
<c:set var="totalShippingCharge" value="${orderIdd.totalShippingCharge }"/>

	<c:set var="orderTotal" value=" ${getParams.orderTotal}"/>
	
				<%-- ORDER SUMMARY LINE - order subtotal --%>
			<tr> 
			
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_1">Order Subtotal:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_2"><fmt:formatNumber value="${orderTotal}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>			
			</tr>
		
		<c:if test="${showTotals eq true}">
			<%-- TOTAL PRODUCT DISCOUNTS --%>
			<%-- Check and see if there is any product (i.e. order item) level adjustment to display --%>
		
<!-- 			<tr> -->
<%-- 				<c:forEach var="orderItemAdjustment" items="${order.orderAmount.adjustment}"> --%>
<%-- 					<c:if test="${!hasProductDiscount}"> --%>
<%-- 						<c:if test="${orderItemAdjustment.displayLevel.name == 'OrderItem'}"> --%>
<%-- 							<c:set var="hasProductDiscount" value="true"/> --%>
<!-- 							<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_11"> -->
<%-- 								<fmt:message key="ORD_ORDER_DISCOUNTS_PRODUCTS" bundle="${storeText}"/>: --%>
<!-- 							</td> -->
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
<%-- 				<c:forEach var="orderItemAdjustment" items="${order.orderAmount.adjustment}"> --%>
<%-- 					<c:if test="${hasProductDiscount}"> --%>
<%-- 						<c:if test="${orderItemAdjustment.displayLevel.name == 'OrderItem'}"> --%>
<%-- 							<c:set var="totalProductDiscount" value="${totalProductDiscount + orderItemAdjustment.amount.value}"/> --%>
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
<%-- 				<c:if test="${hasProductDiscount}"> --%>
<!-- 					<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_12"> -->
<%-- 						<fmt:formatNumber value="${totalProductDiscount}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${!hasProductDiscount}"> --%>
<!-- 						<td></td> -->
<%-- 					</c:if> --%>
<!-- 			</tr> -->
	
	
	<%-- Start - Office brands - ORDER SUMMARY LINE - Product price + tax - discounts and adjustments--%>
		

			<tr>
				<c:set var="totalProductInclusiveTax" value="${(totalProductPrice + totalSalesTax)}"/>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_59">Inclusive of Tax:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_69">
				<c:choose>
					<c:when test="${userType eq 'G' && param.fromPage == 'orderConfirmationPage'}">
						<fmt:formatNumber value="${WCParam.oTotalAmout}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/>
					</c:when>
					<c:otherwise>
						<c:if test="${param.fromPage ne 'orderConfirmationPage'}">
							
							<fmt:formatNumber value="${totalProductInclusiveTax}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/>
						</c:if>
						<c:if test="${param.fromPage eq 'orderConfirmationPage'}">
							
							<fmt:formatNumber value="${(totalProductInclusiveTax + (totalAdjustment * -1))}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/>
						</c:if>			
					</c:otherwise>
				</c:choose>
				</td>
			</tr>

			<%-- End - Office brands - ORDER SUMMARY LINE - Product price + tax - discounts and adjustments --%>
			<%-- ORDER SUMMARY LINE - shipping charge --%>
			<tr>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_7">Shipping:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_8"><fmt:formatNumber value="${totalShippingCharge}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>
			</tr>				
			<%-- ORDER SUMMARY LINE - shipping tax --%>
			<tr style="display:none">
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_14">Shipping Tax:</td>
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_15"><fmt:formatNumber value="${totalShippingTax}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>				
			</tr>

			<%-- ORDER SUMMARY LINE - total order discount --%>
			<tr>
				<td class="total_details" id="WC_SingleShipmentOrderTotalsSummary_td_3">
					<%-- Check and see if there is any order level adjustment to display --%>
					<c:set var="displayDiscountTooltip" value="false"/>
					<c:forEach var="adjustment" items="${order.totalAdjustment}">
						<c:if test="${!displayDiscountTooltip}">
							<c:if test="${adjustment.displayLevel.name == 'Order'}">
								<c:set var="displayDiscountTooltip" value="true"/>
							</c:if>
						</c:if>
					</c:forEach>

				</td>
				<!--<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_4"><fmt:formatNumber value="${order.orderAmount.totalAdjustment.value - totalProductDiscount}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>-->
				<%-- Start Loyalty Point Changes --%>
				<%--
				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_4"><fmt:formatNumber value="${order.orderAmount.totalAdjustment.value - totalProductDiscount}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>
				--%>
<!-- 				<td class="total_figures" id="WC_SingleShipmentOrderTotalsSummary_td_4"> -->
<!-- 					<div id="WC_SingleShipmentOrderTotalsSummary_td_4_lpDiscount"> -->
						
<%-- 						<fmt:formatNumber value="${(order.orderAmount.totalAdjustment.value - totalProductDiscount)}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/> --%>
<!-- 					</div> -->
<!-- 				</td>			 -->
				<%-- End Loyalty Point Changes --%>
			</tr>

		<%-- ORDER SUMMARY LINE - order total --%>
		<tr>
			<td class="total_details order_total" id="WC_SingleShipmentOrderTotalsSummary_td_9">Order Total:</td>
			<c:choose>
				<c:when test="${param.fromPage == 'shoppingCartDisplay'}">
					<!--<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_13"><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value + order.orderAmount.totalAdjustment.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>-->
					<%--Start Loyalty Point Changes --%>
					<!--
					<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_13"><fmt:formatNumber value="${order.orderAmount.totalProductPrice.value + order.orderAmount.totalAdjustment.value}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></td>
					-->
					<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_13"><div id="WC_SingleShipmentOrderTotalsSummary_td_13_lpOrderTotal"><fmt:formatNumber value="${totalProductPrice + totalAdjustment}" type="currency" maxFractionDigits="${currencyDecimal}" currencySymbol="${CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/></div></td>
				<%--End Loyalty Point Changes --%>
				</c:when>
				<c:otherwise>
					<c:set var="orderTotalAmout" value="${order.grandTotal.value}"/>
					<c:set var="totalDis" value="${totalAdjustment * -1}"/>
					<c:if test="${param.fromPage ne 'orderConfirmationPage'}">
						<c:set var="orderTotalAmout" value="${((totalProductInclusiveTax + totalShippingCharge + 
						totalShippingTax ) - totalDis)}"/>
						<c:set var="orderTotalForGuest" value="${orderTotalAmout}" scope="session"/>
					</c:if>	

					<c:if test="${param.fromPage eq 'orderConfirmationPage'}">
						<c:choose>
							<c:when test="${empty orderTotalForGuest}">
								<c:set var="orderTotalAmout" value="${((totalProductInclusiveTax + totalShippingCharge +totalShippingTax) - totalDis)}"/>								
							</c:when>
							<c:otherwise>
								<c:set var="orderTotalAmout" value="${orderTotalForGuest}"/>
							</c:otherwise>
						</c:choose>
					</c:if> 
					
					<td class="total_figures breadcrumb_current" id="WC_SingleShipmentOrderTotalsSummary_td_10">
					<fmt:formatNumber value="${orderTotalAmout}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/>
					</td>
					<input type="hidden" name="oTotalAmout" id="oTotalAmout" value="<c:out value='${totalProductInclusiveTax}'/>">
<!-- 					Add OrderTotalAmount hidden field By Raheel 05-08-2013 -->
					<input type="hidden" name="OrderTotalAmount" value="<c:out value='${orderTotalAmout}'/>" id="OrderTotalAmount" />
				</c:otherwise>
			</c:choose>
		</tr>
		
		</c:if>	
		
	</table>
</div>