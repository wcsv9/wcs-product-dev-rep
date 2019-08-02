<%--
 =================================================================
  Licensed Materials - Property of IBM
  WebSphere Commerce
  (C) Copyright IBM Corp. 2007, 2016 All Rights Reserved.
  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file displays the shopping cart details. It shows an empty shopping cart page accordingly.
  *****
--%>
<!-- BEGIN ShopCartDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<wcf:url var="OrderCalculateURL" value="OrderShippingBillingView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />						
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="shipmentType" value="single" />
	
</wcf:url>
<wcf:url var="SavedOrderListDisplayURL" value="ListOrdersDisplayView">
	<wcf:param name="storeId"   value="${param.storeId}"  />
	<wcf:param name="catalogId" value="${param.catalogId}"/>
	<wcf:param name="langId" value="${param.langId}" />  
</wcf:url>
<c:url var="AjaxOrderItemDisplayView" value="AjaxOrderItemDisplayView">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
	<c:param name="orderId" value="${orderId}" />
</c:url>
<c:url var="OrderCancelURL" value="OrderCancel">
	<c:param name="langId" value="${langId}" />
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
	<c:param name="orderId" value="${orderId}" />
	<c:param name="URL" value="${AjaxOrderItemDisplayView}" />
</c:url>

<c:set var="guestUserURL" value="${OrderCalculateURL}"/>



<!-- Get order Details using the ORDER SOI -->
<c:set var="pageSize" value="${WCParam.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>
<script type="text/javascript">
	function storeDisplay(p, m, divId, action) {
	    document.getElementById(divId).style.display = action;
	    document.getElementById(divId).style.height = "auto";
	    if (action == "block") {
	        document.getElementById(m).style.display = 'block';
	        document.getElementById(p).style.display = 'none';
	    } else {
	        document.getElementById(m).style.display = 'none';
	        document.getElementById(p).style.display = 'block';
	    }
	}
</script>
<form name="AddItemToCartForm" method="POST" action="OrderItemAdd">
	<input type="hidden" name="storeId" value="${storeId}"/>
	<input type="hidden" name="catalogId" value="${catalogId}"/>
	<input type="hidden" name="langId" value="${langId}"/>
	<input type="hidden" name="orderId" value="."/>
	<input id="AddItemToCartForm_quantity" type="hidden" name="quantity" value="1"/>
	<input type="hidden" name="URL" value="SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay&updatePrices=1&calculationUsageId=-1&orderId=."/>
	<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" />
	<%-- <input type="hidden" name="catEntryId" value="${orderItem.catalogEntryId}"/> --%>
	<input type="hidden" name="catEntryId" value="37761"/>
	<input id="AddItemToCartForm_partNumber" type="hidden" name="partNumber" value="116143U"/>
	<input id="AddItemToCartForm_comment" type="hidden" name="comment" />
	<input type="hidden" name="fromSpecialItemField" id="fromSpecialItemField" value="true"/>
	<input type="hidden" name="loyEnabled" id="loyEnabled" value="false"/>		
</form>
<input type="hidden" id="authToken" value="${authToken }"/>
<form name="MQuickOrderForm" method="POST"></form>
<c:choose>
	<c:when test="${!empty sessionScope.loyaltyEnabled}">
		<c:set var="state" value="${sessionScope.state }"/>
		<c:set var="loyaltyEnabled" value="${sessionScope.loyaltyEnabled }"/>
		<c:set var="content" value="${sessionScope.content }"/>
		<c:set var="totalPoints" value="${sessionScope.totalPoints }"/>
	</c:when>
	<c:otherwise>
		<c:set var="state" value="${WCParam.state }"/>
		<c:set var="loyaltyEnabled" value="${WCParam.loyaltyEnabled }"/>
		<c:set var="content" value="${WCParam.content }"/>
		<c:set var="totalPoints" value="${WCParam.totalPoints }"/>
	</c:otherwise>
</c:choose>

<div class="row margin-true">
	<div class="left quick v9_quick_order" id="other_products">
		<h2 id="quickOrderPlus"
			onclick="storeDisplay('quickOrderPlus','quickOrderMinus','quickOrder','block');">
			<div class="plus">+</div>
			<div class="headingTitle">Add Quick Order Item/s</div>
		</h2>
		<h2 id="quickOrderMinus" style="display: none;"
			onclick="storeDisplay('quickOrderPlus','quickOrderMinus','quickOrder','none');">
			<div class="plus">-</div>
			<div class="headingTitle">Add Quick Order Item/s</div>
		</h2>
		<div id="quickOrder" style="display: none;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="2%"></td>
					<td width="40%"><h3>Product Code</h3></td>
					<td width="2%">&nbsp;</td>
					<td width="7%"><h3>Qty</h3></td>
					<td>&nbsp;</td>
				</tr>
				
			</table>
			<input type="hidden" id="productCounter" name="counter" value="2"/>
			<div id="productDiv">
				<c:set var="autoSKUSuggestInputField" value="AddItem_ProductCode_1"
					scope="request" />
				<c:set var="suffix" value="_AddItem_ProductCode_1" scope="request" />
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="2%"></td>
						<td width="40%"><input id="AddItem_ProductCode_1" type="text"
							style="width: 100%; padding: 3px 0px;" class="input"
							onfocus="AutoSKUSuggestJS._onFocus(event);"
							onblur="AutoSKUSuggestJS._onBlur(event);"
							onkeyup="AutoSKUSuggestJS._onKeyUp(event);"
							placeholder="Type a Product Code" /></td>
						<td width="2%"></td>
						<td width="7%"><input id="AddItem_Qty_1" type="text"
							class="input" style="width: 25px; padding: 3px;" value="1" /></td>
						<td width="2%"></td>
						<td><a class="button primary" onClick="javascript:ShipmodeSelectionExtJS.checkPartNumber('AddItemToCartForm','product');wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'state':'<c:out value='${state}'/>', 'loyaltyEnabled':'<c:out value='${loyaltyEnabled}'/>','content':'<c:out value='${content}'/>','totalPoints':'<c:out value='${totalPoints}'/>'});" id="WC_CurrentOrderDisplayCartSection_Link_1"> Add To Cart </a></td>
					</tr>
					<tr>
						<td height="7"></td>
					</tr>
				</table>
				<%out.flush();%>
					<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url= "${env_siteWidgetsDir}Common/MyAccountList/AutoSKUSuggest_UI.jsp">
						<wcpgl:param name="suffix" value="${suffix}" />	
						<wcpgl:param name="autoSKUSuggestInputField" value="${autoSKUSuggestInputField}" />
						<wcpgl:param name="autoSuggestBySKULabel" value="${autoSuggestBySKULabel}" />
					</wcpgl:widgetImport>
				<%out.flush();%>
			</div>
			<%-- <div id="productDiv1" style="display: none;">
				<c:forEach var = "i" begin = "2" end = "5">
				
					<c:set var="autoSKUSuggestInputField1" value="AddItem_ProductCode_${i}"
						scope="request" />
					<c:set var="suffix1" value="_AddItem_ProductCode_${i}" scope="request" />
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="2%"></td>
							<td width="40%"><input id="${autoSKUSuggestInputField1}" type="text"
								style="width: 100%; padding: 3px 0px;" class="input"
								onfocus="AutoSKUSuggestJS._onFocus(event);"
								onblur="AutoSKUSuggestJS._onBlur(event);"
								onkeyup="AutoSKUSuggestJS._onKeyUp(event);"
								placeholder="Type a Product Code" /></td>
							<td width="2%"></td>
							<td width="7%"><input id="AddItem_Qty_${i}" type="text"
								class="input" style="width: 25px; padding: 3px;" /></td>
							<td width="49%"></td>
						</tr>
						<tr>
							<td height="7"></td>
						</tr>
					</table>
					<%out.flush();%>
						<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url= "${env_siteWidgetsDir}Common/MyAccountList/AutoSKUSuggest_UI.jsp">
							<wcpgl:param name="suffix" value="${suffix1}" />	
							<wcpgl:param name="autoSKUSuggestInputField" value="${autoSKUSuggestInputField1}" />
							<wcpgl:param name="autoSuggestBySKULabel" value="${autoSuggestBySKULabel}" />
						</wcpgl:widgetImport>
					<%out.flush();%>
				</c:forEach>
			</div> --%>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="2%"></td>
					<td height="20"><a href="#"
						onClick="javascript:ShipmodeSelectionExtJS.addProductField('productDiv');"> +
							Add more items</a></td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="left quick v9_quick_order" id="other_products">
	<h2 id="specialItemPlus"
		onclick="storeDisplay('specialItemPlus','specialItemMinus','specialItem','block');">
		<div class="plus">+</div>
		<div class="headingTitle">Add Special Item/s</div>
	</h2>
	<h2 id="specialItemMinus" style="display: none;"
		onclick="storeDisplay('specialItemPlus','specialItemMinus','specialItem','none');">
		<div class="plus">-</div>
		<div class="headingTitle">Add Special Item/s</div>
	</h2>
	<div id="specialItem" style="display: none;">
		<!-- End  1."Add Product Code' field-->
		<!-- Start  2."Add Special Item' field-->
		<%
			/*
				CatEntrySearchListDataBean searchBean = new CatEntrySearchListDataBean();
				CommandContext aCommandContext = (CommandContext)request.getAttribute("CommandContext");
				JSPResourceBundle tooltechtext = new JSPResourceBundle(sdb.getResourceBundle("storetext"));
				searchBean.setCommandContext(aCommandContext);
				searchBean.setSearchTerm(tooltechtext.getString("AddSpecial_searchTerm"));
				searchBean.setIsProduct(true);
				searchBean.setPageSize(tooltechtext.getString("AddSpecial_pageSize"));
				searchBean.setSearchTermScope(searchBean.SEARCH_IN_PRODUCTNAME);
				searchBean.setSearchType(searchBean.EXACTPHRASE);
				searchBean.populate();
				CatalogEntryDataBean[] result = searchBean.getResultList();
			
				if (result != null)
				{*/
		%>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				
				<td width="40%"><h3>Add Special Item</h3></td>
				<td width="2%">&nbsp</td>
				<td width="7%"><h3>Qty</h3></td>
				<td width="2%">&nbsp</td>
				<td>&nbsp</td>
			</tr>
		</table>
		<div id="specialDiv">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40%"><textarea
							style="width: 100%; margin: 0px; padding: 1px; height: 22px"
							id="AddSpecialItem_Comment_1"></textarea></td>
					<td width="2%"></td>
					<td width="7%" valign="top"><input id="AddSpecialItem_Qty_1"
						type="text" class="input" style="width: 25px; padding: 3px"
						value="1" /></td>
					<td width="2%"></td>
					<td valign="top"><a class="button primary"
						onClick="javascript:ShipmodeSelectionExtJS.addToOrderAjax('AddItemToCartForm','special')"
						id="WC_CurrentOrderDisplayCartSection_Link_1"> Add To Cart </a></td>
				</tr>
			</table>
		</div>
		<table border="0" cellpadding="0" cellspacing="0">
			<a href="#"
				onClick="javascript:ShipmodeSelectionExtJS.addProductField('specialDiv');">+
				Add more special items</a>
			<%
				//}
			%>
			<tr>
				<td height="15"></id>
			</tr>
		</table>
	</div>
</div>

</div>
<!-- End code added by ali for Quick Order functionality in shopping cart page -->
<c:if test="${CommandContext.user.userId != '-1002'}">
	<flow:ifEnabled feature="BOPIS">		
		<c:set var="order" value="${requestScope.orderInCart}" scope="request"/>
		<c:set var="shippingInfo" value="${requestScope.shippingInfo}"/>
		<c:if test="${empty order || order == null}">
			<wcf:rest var="order" url="store/{storeId}/cart/@self" scope="request">
				<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
				<wcf:param name="pageSize" value="${pageSize}"/>
				<wcf:param name="pageNumber" value="${currentPage}"/>
				<wcf:param name="sortOrderItemBy" value="orderItemID"/>
			</wcf:rest>
		</c:if>
		<c:if test="${empty shippingInfo || shippingInfo == null}">
			<c:set var="shippingInfo" value="${order}" scope="request"/>
		</c:if>
	</flow:ifEnabled>
</c:if>
<c:if test="${CommandContext.user.userId != '-1002' && empty order}">
	<%-- When BOPIS is not enabled, this block gets executed. --%>
	<%-- This service is mainly to check if order is empty or not --%>
	<wcf:rest var="order" url="store/{storeId}/cart/@self" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:param name="sortOrderItemBy" value="orderItemID"/>
		<wcf:param name="pageSize" value="${pageSize}"/>
		<wcf:param name="pageNumber" value="${currentPage}"/>
		<wcf:param name="sortOrderItemBy" value="orderItemID"/>
	</wcf:rest>
</c:if>
<c:if test="${CommandContext.user.userId != '-1002'}">
	<c:if test="${empty order.orderItem && beginIndex >= pageSize}">
	<fmt:parseNumber var="recordSetTotal" value="${ShowVerbCart.recordSetTotal}" integerOnly="true" />
	<fmt:formatNumber var="totalPages" value="${(recordSetTotal/pageSize)}" maxFractionDigits="0"/>
	<c:if test="${recordSetTotal%pageSize < (pageSize/2)}">
		<fmt:formatNumber var="totalPages" value="${(recordSetTotal+(pageSize/2)-1)/pageSize}" maxFractionDigits="0"/>
		</c:if>
		<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
		<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
		<wcf:rest var="order" url="store/{storeId}/cart/@self" scope="request">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
			<wcf:param name="sortOrderItemBy" value="orderItemID"/>
			<wcf:param name="pageSize" value="${pageSize}"/>
			<wcf:param name="pageNumber" value="${currentPage}"/>
			<wcf:param name="sortOrderItemBy" value="orderItemID"/>
		</wcf:rest>
	</c:if>
</c:if>
<wcf:url var="currentShoppingCartLink" value="ShopCartPageView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>

<c:set var="numberOfOrderItems" value="0" />
<c:set var="numEntries" value="0" />

<c:if test="${!empty order.orderItem}">
	<c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
		<c:set var="numberOfOrderItems" value="${numberOfOrderItems + orderItem.quantity}"/>
	</c:forEach>
	<fmt:formatNumber value="${numberOfOrderItems}" var="numberOfOrderItems"/>
	<fmt:parseNumber var="numEntries" value="${order.recordSetTotal}" integerOnly="true" />
</c:if>
<script type="text/javascript">
$(document).ready(
	function(){
		
		ShipmodeSelectionExtJS.setOrderItemId('${order.orderItem[0].orderItemId}');
		var numberOfOrderItems = "0";
		if ("${numberOfOrderItems}" != "") {
			numberOfOrderItems = "${numberOfOrderItems}";
		}
		var numberOfOrderItemsDisplayedInMSC = "0";
		if (document.getElementById("minishopcart_total") != null) {
			numberOfOrderItemsDisplayedInMSC = document.getElementById("minishopcart_total").innerHTML.trim();
		}
		
		// check if number of order items and matches the number showed on mini-shop cart, if not match, refresh mini-shop cart
		if ((numberOfOrderItems != numberOfOrderItemsDisplayedInMSC) || (${numEntries} > ${pageSize})) {
			//var param = [];
			//param.deleteCartCookie = true;
			if ($("#MiniShoppingCart").length > 0) {
				 //dijit.byId("MiniShoppingCart").refresh(param);
				 setDeleteCartCookie();
				 loadMiniCart("<c:out value='${CommandContext.currency}'/>","<c:out value='${langId}'/>")
			}
		}
	}
);
</script>
<c:set var="showTax" value="false"/>
<c:set var="showShipping" value="false"/>
<c:choose>
	<c:when test="${empty param.orderId}">
		<c:choose>
			<c:when test="${!empty WCParam.orderId}">
				<c:set var="orderId" value="${WCParam.noElementToDisplay}" />
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:set var="orderId" value="${param.orderId}" />
	</c:otherwise>
</c:choose>

<jsp:useBean id="itemDetailsInThisOrder" class="java.util.HashMap" scope="request"/>

<c:if test="${!empty order.orderId}" >
	<%@ include file="ShopCartOnBehalfOfLock_Data.jspf"%>
	<%-- Refresh Area is not needed when refreshing the results list via Ajax Call --%>
	<%-- Refresh area is needed only during onBehalfSession. To lock/unlock/takeOver order lock --%>
	<c:if test="${env_shopOnBehalfSessionEstablished eq true}"> 
		<fmt:message var="ariaMessage" bundle="${storeText}" key="ACCE_STATUS_ORDER_LOCK_STATUS_UPDATED"/>
		<span id="orderLockStatus_Label" class="spanacce" aria-hidden="true"><fmt:message bundle="${storeText}" key="ACCE_ORDER_LOCK_STATUS_CONTENT"/></span>
		<div id="orderLockStatusRefreshArea" wcType='RefreshArea' widgetId='orderLockStatusSection' declareFunction='declareOrderLockStatusRefreshArea()' ariaMessage='${ariaMessage}' ariaLiveId='${ariaMessageNode}' role='region'  aria-labelledby="orderLockStatus_Label">
	</c:if>
	<%@ include file="ShopCartOnBehalfOfLock_UI.jspf"%>
	<c:if test="${env_shopOnBehalfSessionEstablished eq true}"> 
		</div>
	</c:if>
</c:if>
<wcf:rest var="costCenter" url="store/{storeId}/userRegister/getCostCenter/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${CommandContext.user.userId}" encode="true"/>
</wcf:rest>
<script>	
	function PrintMe(){
		var dispSetting="width=801,height=800,left=100,top=25,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no,resizable=yes";
		window.open("OrderItemDetailPrintView?storeId=${WCParam.storeId}&orderId=${order.orderId}","",dispSetting); 
	}
</script>
<div id="box" class="shopping_cart_box v9_box">
	<div class="myaccount_header bottom_line" id="shopping_cart_product_table_tall">
		<%@ include file="../../Snippets/ReusableObjects/CheckoutTopESpotDisplay.jspf"%>
		<%-- Split the shopping_cart_product_table_tall div in order to move the online and pick up in store choice and maintain function --%>
	<c:choose>
		<c:when test="${!empty order.orderItem }" >
			<%out.flush();%>
			<c:import url="/${sdb.jspStoreDir}/Snippets/Order/Cart/ShipmodeSelectionExt.jsp"/>
			<%out.flush();%>
			</div>
			
			<div class="body" id="WC_ShopCartDisplay_div_5">
				<input type="hidden" id="OrderFirstItemId" value="${order.orderItem[0].orderItemId}"/>
				<span id="ShopCartPagingDisplay_ACCE_Label" class="spanacce"><fmt:message bundle="${storeText}" key="ACCE_Region_Order_Item_List"/></span>
				<div wcType="RefreshArea" widgetId="ShopCartPagingDisplay" id="ShopCartPagingDisplay" refreshurl="<c:out value="${currentShoppingCartLink}"/>" declareFunction="CommonControllersDeclarationJS.declareShopCartPagingDisplayRefreshArea()" ariaMessage="<fmt:message bundle="${storeText}" key="ACCE_Status_Order_Item_List_Updated"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="ShopCartPagingDisplay_ACCE_Label">
					<%out.flush();%>
					<c:import url="/${sdb.jspStoreDir}/Snippets/Order/Cart/OrderItemDetail.jsp">
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="langId" value="${WCParam.langId}" />
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="content" value="${WCParam.content}" />
						<c:param name="state" value="${WCParam.state}" />
						<c:param name="loyaltyEnabled" value="${WCParam.loyaltyEnabled}" />
						
					</c:import>
					<%out.flush();%>
				</div>
				<%-- <div class="free_gifts_block">
					<%out.flush();%>
					<c:import url="/${sdb.jspStoreDir}/Snippets/Marketing/Promotions/PromotionPickYourFreeGift.jsp"/>
					<%out.flush();%>
				</div> --%>
				<div id="WC_ShopCartDisplay_div_5a" class="espot_payment left">
					<%out.flush();%>
						<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
							<wcpgl:param name="storeId" value="${storeId}" />
							<wcpgl:param name="catalogId" value="${catalogId}" />
							<wcpgl:param name="emsName" value="ShoppingCartCenter_Content" />
						</wcpgl:widgetImport>
					<%out.flush();%>
				</div>

				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/ShoppingArea/CheckoutSection/SingleShipment/SingleShipmentOrderTotalsSummary.jsp">
					<c:param name="returnView" value="AjaxOrderItemDisplayView"/>
					<c:param name="fromPage" value="shoppingCartDisplay"/>
				</c:import>
				<%out.flush();%>
				<br clear="all" /> 
				<div id="cost_center">
					<c:if test="${WCParam.storeId ne '80355'}">
						<div id="cost">
							<div  class="promotion_input">
								<span class="bold">Office Records</span>
							</div>
							<div  class="promotion_input">
								<label for="purchase_order_number" class="nodisplay">
								<fmt:message bundle="${storeText}" key="AB_ADDRESS_LABEL_TEXT" >		
								<fmt:param><fmt:message bundle="${storeText}" key="EDPPaymentMethods_PO_NUMBER" /></fmt:param>
								<fmt:param><fmt:message bundle="${storeText}" key="Checkout_ACCE_required" /></fmt:param></fmt:message>
								</label>
								<span><fmt:message bundle="${storeText}" key="EDPPaymentMethods_PO_NUMBER" /></span> <br />
							 	<input type="text" name="purchase_order_number" id="purchase_order_number" value="<c:out value='${WCParam.purchaseorder_id}'/>"/>
								<input type="hidden" name="purchaseOrderNumberRequired" id="purchaseOrderNumberRequired" value="<c:out value='${purchaseOrderNumberRequired}'/>"/>
							 </div>
							
							<!-- end code added by ali for purchase order No functionality in shopping cart page -->
							<div class="promotion_input">
								<span>Cost Center</span>
								<br />
								<c:set var="costcntr" value="${fn:split(costCenter.costCenterValue[0], ';')}" /> 
						 		<select id="costCentreList" multiple style="width: 200px;height: 53px;" onclick="javascript:document.getElementById('costCentre_id').value = this.value;">
							 		<c:forEach var="cst" items="${costcntr}"  varStatus='outerStatus'>
								 		<c:if test="${cst ne 'NULL' }">
								 			<option value='<c:out value="${cst }"/>'><c:out value="${cst }"/></option>
								 		</c:if>
								         
								    </c:forEach>
						 		</select>
								<%-- <select id="costCentreList" multiple style="width: 200px;height: 53px;" onclick="javascript:document.getElementById('costCentre_id').value = this.value;">
									<option value="<%=ccArray[i]%>"><%=ccArray[i]%></option>
								</select> --%>
								<input type="hidden" name="costCentre_id" id="costCentre_id" value="" />
							</div>
							<br clear="all" />
						</div>
					</c:if>
					<%-- <c:if test="${WCParam.storeId eq '80355' && userType ne 'G'}">
						<div id="cost">
							<div  class="promotion_input">
								<span class="bold">Office Records</span>
							</div>
							<div  class="promotion_input">
								<label for="purchase_order_number" class="nodisplay">
								<fmt:message bundle="${storeText}" key="AB_ADDRESS_LABEL_TEXT" >		
									<fmt:param><fmt:message bundle="${storeText}" key="EDPPaymentMethods_PO_NUMBER" /></fmt:param>
									<fmt:param><fmt:message bundle="${storeText}" key="Checkout_ACCE_required" /></fmt:param></fmt:message>
								</label>
								<span><fmt:message bundle="${storeText}" key="EDPPaymentMethods_PO_NUMBER" /></span> <br />
								<input type="text" name="purchase_order_number" id="purchase_order_number" value="<c:out value='${WCParam.purchaseorder_id}'/>"/>
								<input type="hidden" name="purchaseOrderNumberRequired" id="purchaseOrderNumberRequired" value="<c:out value='${purchaseOrderNumberRequired}'/>"/>
							</div>
						
							<!-- end code added by ali for purchase order No functionality in shopping cart page -->
						
							<div class="promotion_input">
								<span>Cost Center</span>
								<br />
								<%@ include file="../CheckoutSection/SingleShipment/SingleShipmentCostCenterDisplay.jsp"%>
							  </div>
							   <br clear="all" />
						  </div>
					 </c:if> --%>
					 
					<!-- start code added by ali for Promotion code  functionality in shopping cart page -->
					<div id="Promotional">
						<div  class="promotion_input">
							<span class="bold">Coupon Code</span>
						</div>
						<flow:ifEnabled feature="promotionCode">
							<c:if test="${param.fromPage != 'orderSummaryPage' && param.fromPage != 'orderConfirmationPage' && param.fromPage != 'pendingOrderDisplay'}">
								<div id="promotions">
									<%-- Flush the buffer so this fragment JSP is not cached twice --%>
									<%out.flush();%>
									<c:import url="/${sdb.jspStoreDir}/Snippets/Marketing/Promotions/PromotionCodeDisplay.jsp">
										<c:param name="orderId" value="${order.orderId}" />
										<c:param name="returnView" value="${param.returnView}" />
									</c:import>
									<%out.flush();%>
								</div>
							</c:if>
						</flow:ifEnabled>
					</div>
				<%@ include file="../../Snippets/ReusableObjects/CheckoutBottomESpotDisplay.jspf"%>
			</div>
			<div class="order-ceckout">
				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/Snippets/Order/Cart/CheckoutLogon.jsp"/>
				<%out.flush();%>
			</div>
			<!-- Start Punchout code -->
			<c:set var="punchoutCondition" value="" />
			<flow:ifEnabled feature="PunchoutCheckout">
				<c:if test="${userType ne 'G'}">
					<wcf:rest var="punchoutResponse" url="store/{storeId}/punchout/getXml">
						<wcf:var name="storeId" value="${storeId}" encode="true"/>
					</wcf:rest>
					<c:set var="punchoutCondition" value="${punchoutResponse.userField2}" />
					<c:if test="${punchoutCondition eq 'true'}">

						<script type="text/javascript">
						function punchoutSet(){
							document.getElementById("punchoutForm").action="http://easeetrade.cattech.com.au/punchoutedi/PunchoutCallback/OFFICEBRANDS"; //https url;
							document.getElementById("punchoutForm").submit();
						}
						</script>

						<form method="POST" id="punchoutForm" enctype="multipart/form-data">
							<input type="hidden" id="USER" name="USER" value="${CommandContext.user.displayName}">
							<input type="text" id="DOC" name="DOC" value='${punchoutResponse.xmlDoc}' style="display:none;">
						</form>
					</c:if>
				</c:if>
			</flow:ifEnabled>
			<!-- End Punchout code -->
			
			<%--<div class="order-ceckout">
				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/Snippets/Order/Cart/CheckoutLogon.jsp"/>
				<%out.flush();%>
			</div> --%>
			<br clear="all">
			<div class="navBase">
				<div class='nav stickyB'>
					<div id="checkout-button-row">
						<div class="left orderTotalDiv" id="other_products">
							<h2 id="specialItemPlus">
								<div class="headingTitle">Order Total: 
									<div class="orderTotal" id="ordTotalTwo">
										<%-- <fmt:formatNumber value="${order.totalProductPrice + totalProductDiscount + totalOrderLevelDiscount}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/> --%>
										<fmt:formatNumber value="${order.grandTotal}" type="currency" maxFractionDigits="${env_currencyDecimal}" minFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/><c:out value="${CurrencySymbol}"/>
									</div>
								</div>
							</h2>
						</div>				
						<div class="btn-Check">		
						<c:if test="${userType eq 'G'}">
							<div class="button-blue">
								<input type="hidden" name="guestCheckLogon" id="guestCheckLogon" value="false"/>
								<a href="javascript:GlobalLoginJS.InitHTTPSecure('Header_GlobalLogin');" class="button_primary">
									<div class="button_text">Sign in & Checkout</div>
								</a>
							</div>
						</c:if>
						<div class="button-green">
							<c:set var="pagorder1" value="${requestScope.order}"/>
							<c:set var="priceZeroCheck" value="false"/>
							<c:forEach var="orderItem10" items="${pagorder1.orderItem}">
								<c:if test="${orderItem10.unitPrice eq '0.00000'}">
									<c:set var="priceZeroCheck" value="true"/>
								</c:if>
							</c:forEach>
							
							
								<c:choose>
									<c:when test="${requestScope.allContractsValid}">
										<c:choose>
											 <c:when test="${!empty sessionScope.redPoint}">
												<div class="button_align left" id="WC_CheckoutLogonf_div_10">
													<a href="#" role="button" class="button_primary" id="shopcartCheckout" tabindex="0" onclick="javascript:TealeafWCJS.processDOMEvent(event);if(CheckoutHelperJS.checkRedeem('<c:out value="${totalPoints}"/>','<c:out value="${sessionScope.redPoint}"/>','0') && CheckoutHelperJS.canCheckoutContinue('<c:out value="${userType}"/>') && CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.registeredUserContinue('<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>','','','<c:out value='${orderId}'/>');}return false;">
													<c:remove var="redPoint"/>
											</c:when>
											<c:when test="${priceZeroCheck eq 'true' && loyaltyEnabled ne 'true' && proceed eq 'true'}">
												<div class="button_align left" id="WC_CheckoutLogonf_div_10">
													<a href="#" role="button" class="button_primary" id="shopcartCheckout" tabindex="0" onclick="javascript:alert('You are not subscribed to add Loyalty Redeemable Products in the Cart. Please remove the items with PartNumber <c:out value="${pNumber}"/> from the cart to place the order or contact store administrator for more details.')"  >
											</c:when> 
											<c:otherwise>
												<div class="button_align left" id="WC_CheckoutLogonf_div_10">
												<c:if test="${userType ne 'G'}">
													<a href="#" role="button" class="button_primary" id="shopcartCheckout" tabindex="0" onclick="javascript:TealeafWCJS.processDOMEvent(event);if(CheckoutHelperJS.clickOnCheckout()){if(CheckoutHelperJS.canCheckoutContinue('<c:out value="${userType}"/>') && CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.registeredUserContinue('<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>');}return false;}">
													<%-- <a href="#" role="button" class="button_primary" id="shopcartCheckout" tabindex="0" onclick="javascript:TealeafWCJS.processDOMEvent(event);if(CheckoutHelperJS.clickOnCheckout()){if(CheckoutHelperJS.checkRedeem('<c:out value="${totalPoints}"/>','<c:out value="${sessionScope.redPoint}"/>','0') && CheckoutHelperJS.canCheckoutContinue('<c:out value="${userType}"/>') && CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){ShipmodeSelectionExtJS.registeredUserContinue('<c:out value='${OrderCalculateURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>','','','<c:out value='${orderId}'/>');}return false;}">--%>
												</c:if>
												<c:if test="${userType eq 'G'}">
													<a href="#" role="button" class="button_primary" id="guestShopperContinue" onclick="javascript:if(CheckoutHelperJS.canCheckoutContinue('<c:out value="${userType}"/>') && CheckoutHelperJS.updateShoppingCart(document.ShopCartForm,true)){TealeafWCJS.processDOMEvent(event);ShipmodeSelectionExtJS.guestShopperContinue('<c:out value='${guestUserURL}'/>', '<c:out value='${PhysicalStoreSelectionURL}'/>', '<c:out value='${orderId}'/>', '<c:out value='${WCParam.catalogId}'/>','<c:out value='${sessionScope.shipStoreId}'/>','<c:out value='${sessionScope.shipEmail}'/>','<c:out value='${sessionScope.latitude}'/>','<c:out value='${sessionScope.longitude}'/>','<c:out value='${sessionScope.storeName1}'/>');}return false;">
												</c:if>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<div class="disabled left" id="WC_CheckoutLogonf_div_10">
											<a role="button" class="button_primary" id="shopcartCheckout" tabindex="0" onclick="javascript:TealeafWCJS.processDOMEvent(event);setPageLocation('#')">
									</c:otherwise>
								</c:choose>
									<div class="button_text"><fmt:message bundle="${storeText}" key="SHOPCART_CHECKOUT" /></div>
								</a>
							
						</div>
						<flow:ifEnabled feature="PunchoutCheckout">
							<c:if test="${userType ne 'G'}">
								<c:if test="${punchoutCondition eq 'true'}">
									<div class="button_align left" id="WC_CheckoutLogonf_div_10">	
										<a href="#" role="button" class="button_primary" style="background-color: orange; border: 1px solid orange;" href="#" onclick="punchoutSet();" >
											<div class="left_border"></div>
											<div class="button_text">
												Return Cart
											</div>
											<div class="right_border"></div>
										</a>
									</div>
								</c:if>
							</c:if>
						</flow:ifEnabled>

						
						<div class="button-gray">
							<a href="#" class="button_primary" onclick="javascript:PrintMe();">
								<div class="button_text">Print Order</div>
							</a>
						</div>
						</div>
						<div class="clear"></div>

						
					</div>
		</c:when>
		<c:otherwise>
			</div>
			<div class="body" id="WC_ShopCartDisplay_div_6">
				<%@ include file="../../Snippets/ReusableObjects/EmptyShopCartDisplay.jspf"%>
			</div>
		</c:otherwise>
	</c:choose>
	
	<div class="footer" id="WC_ShopCartDisplay_div_7">
		<div class="left_corner" id="WC_ShopCartDisplay_div_8"></div>
		<div class="left" id="WC_ShopCartDisplay_div_9"></div>
		<div class="right_corner" id="WC_ShopCartDisplay_div_10"></div>
	</div>
</div>
<script>
	$(window).scroll(function(){
		var yourTop = $('.navBase').position().top;
		if( $(this).scrollTop() > yourTop ){
			$(".nav").addClass("sticky");
		}
		else if( $(this).scrollTop() > yourTop - ($( window ).height() - 75) &&  $(this).scrollTop() < yourTop ){
			$(".nav").removeClass("sticky");
			$(".nav").removeClass("stickyB");
		}
		else {
			$(".nav").addClass("stickyB");
		}
	});
	$(".nav").click(function(){
		setYourTop = yourTop + 5 + "px";
		$("html, body").animate({ scrollTop: setYourTop });
	});
</script>
<!-- END ShopCartDisplay.jsp -->