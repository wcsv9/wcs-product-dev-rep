<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN GmtPurchaseData.jsp -->

<%@ include file="../../Common/EnvironmentSetup.jspf"%>

<c:if test="${WCParam.externalQuoteId == null || WCParam.externalQuoteId == ''}">
	<wcf:rest var="pagorder" url="store/{storeId}/order/{orderId}">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:var name="orderId" value="${WCParam.orderId}" encode="true"/>
		<wcf:param name="accessProfile" value="IBM_Details" />
		<wcf:param name="pageSize" value="${param.pageSize}"/>
		<wcf:param name="pageNumber" value="${param.pageNumber}"/>
		<wcf:param name="sortOrderItemBy" value="orderItemID"/>
	</wcf:rest>
</c:if>
<%--
	The following snippet retrieves all the catalog entries associated with each item in the current order.
	It was taken out of the larger c:forEach loop below for performance reasons.
--%>
<jsp:useBean id="itemDetailsInThisOrder" class="java.util.HashMap" scope="page"/>
<c:catch var="searchServerException">	
	<wcf:rest var="allCatEntryInOrder" url="${param.searchHostNamePath}${param.searchContextPath}/store/${WCParam.storeId}/productview/byIds" >
		<c:forEach var="orderItem0" items="${pagorder.orderItem}">
			<%@ include file="../../Snippets/Catalog/CatalogEntryDisplay/ResolveCatalogEntryIDExt.jspf" %>
			<wcf:param name="id" value="${orderItem0.productId}"/>
		</c:forEach>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="currency" value="${param.envCurrencyCode}" />
		<wcf:param name="responseFormat" value="json" />
		<wcf:param name="catalogId" value="${param.catagId}" />
		<wcf:param name="profileName" value="IBM_findProductByIds_Summary_WithNoEntitlementCheck" />
	</wcf:rest>
</c:catch>
<c:forEach var="aCatEntry" items="${allCatEntryInOrder.catalogEntryView}">
	<c:set property="${aCatEntry.uniqueID}" value="${aCatEntry}" target="${itemDetailsInThisOrder}"/>
</c:forEach>
<script>
	/* console.log('pageorder : ', JSON.parse('${pagorder}') );
	console.log('order details : ${itemDetailsInThisOrder}');//, JSON.parse('${itemDetailsInThisOrder}')); */
	console.log('price : ' + document.getElementById('WC_SingleShipmentOrderTotalsSummary_td_2').innerHTML.trim().replace('$', ''));
	var step = 3;
	var gtmProdCount = 0;
	if ('${userType}' == 'G') {
		step = 4;
	}
	dataLayer.push({
		'event': 'checkout',
		'ecommerce': {
			'checkout': {
				'actionField': {'step':step}//Number of step which should be incremented.
			 }
		 }
	});
	var products = new Array(10);
	var name = '';
	 var brand = '';
	 var price = '';
	 var quantity = '';
	 var id = '';
	 var separation = '';
	 var stores = {
		'12410' : 'https://www.officenational.com.au',
		'14069' : 'https://www.officeproductsdepot.com.au',
		'68952' : 'http://www.onet.net.au/',
		'91009' : 'https://www.opd.co.nz/'
	 }
	 var subTotal = document.getElementById('WC_SingleShipmentOrderTotalsSummary_td_2').innerHTML.trim().replace('$', '');
	 var freightCharges = document.getElementById('WC_SingleShipmentOrderTotalsSummary_td_24').innerHTML.trim().replace('$', '');
	 var minOrderChargesElement = document.getElementById('WC_SingleShipmentOrderTotalsSummary_td_15_guest');
	 var minOrderCharges = 0.0;
	 if (minOrderChargesElement) {
		 minOrderCharges = minOrderChargesElement.innerHTML.trim().replace('$', ''); 
	 }
	 var shippingCharges = parseFloat(freightCharges) + parseFloat(minOrderCharges);
	 console.log('shipping charges : ' + shippingCharges);
	var productDetails = JSON.parse('${itemDetailsInThisOrder}'.replace(/([{,]\s*)(\d+)*=/g, "$1\"$2\":"));
	JSON.parse('${pagorder.orderItem}').forEach(myFunction);
	if (gtmProdCount > 0) {
		SavedOrderInfoJS.sendGtmPurchaseData('${pagorder.orderId}', name, id, price, brand, quantity, '${WCParam.storeId}', getClientId(), subTotal, shippingCharges, stores['${WCParam.storeId}']);
		gtmProdCount = 0;
	}
	function myFunction(item, index) {
		if (name != '') {
			separation = ',';
		}
		name = name + separation + productDetails[item.productId].name;
		id= id + separation +  item.partNumber;
		price= price + separation +  item.unitPrice;
		brand= brand + separation +  productDetails[item.productId].manufacturer;
		quantity= quantity + separation +  item.unitQuantity;
		gtmProdCount++;
		if (gtmProdCount == 10) {
			SavedOrderInfoJS.sendGtmPurchaseData('${pagorder.orderId}', name, id, price, brand, quantity, '${WCParam.storeId}', '${CommandContext.user.userId}');
			gtmProdCount = 0;
		}
	}
	
	function getClientId() {
		var match = document.cookie.match('(?:^|;)\\s*_ga=([^;]*)');
		var raw = (match) ? decodeURIComponent(match[1]) : null;
		if (raw) {
			match = raw.match(/(\d+\.\d+)$/);
		}
		var gacid = (match) ? match[1] : null;
		if (gacid) {
			return gacid;
		}
		return '';
	}

</script>
<!-- END GmtPurchaseData.jsp -->