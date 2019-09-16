<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN OrderItemDetailB2C.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<flow:ifEnabled feature="AjaxCheckout">
	<c:set var="isAjaxCheckout" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxCheckout">
<form name="ShopCartForm" method="post" action="RESTOrderItemUpdate" id="ShopCartForm">
	<c:set var="isAjaxCheckout" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxAddToCart">
	<c:set var="isAjaxAddToCart" value="true" />
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxAddToCart">
	<c:set var="isAjaxAddToCart" value="false" />
</flow:ifDisabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
	<wcf:url var="SOAWishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />
	</wcf:url>
	<wcf:url var="SOAWishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />
	</wcf:url>
</flow:ifDisabled>

<wcf:url var="GuestWishListDisplayURL" value="InterestItemDisplay">
		<wcf:param name="storeId"   value="${WCParam.storeId}"  />
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="listId" value="." />
	</wcf:url>

<c:choose>
	<c:when test="${userType eq 'G'}">
		<c:set var="interestItemDisplayURL" value="${GuestWishListDisplayURL}"/>
	</c:when>
	<c:otherwise>
		<c:set var="interestItemDisplayURL" value="${WishListDisplayURL}"/>
	</c:otherwise>
</c:choose>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>

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

<c:set var="pagorder" value="${requestScope.order}"/>
<c:set var="orderId" value="${WCParam.orderId}"/>

<c:choose>
	<c:when test="${(empty pagorder || pagorder == null || fn:length(pagorder.orderItem) > pageSize) && (!empty orderId && orderId != null) && (!empty WCParam.fromPage && WCParam.fromPage == 'pendingOrderDisplay')}">
		<wcf:rest var="pagorder" url="store/{storeId}/order/{orderId}" scope="request">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
			<wcf:var name="orderId" value="${orderId}" encode="true"/>
			<wcf:param name="pageSize" value="${pageSize}"/>
			<wcf:param name="pageNumber" value="${currentPage}"/>
		</wcf:rest>
		<fmt:parseNumber var="recordSetTotal" value="${pagorder.recordSetTotal}" integerOnly="true" />
		<c:if test="${beginIndex > recordSetTotal}">
			<fmt:formatNumber var="totalPages" value="${(recordSetTotal/pageSize)}" maxFractionDigits="0"/>
			<c:if test="${recordSetTotal%pageSize < (pageSize/2)}">
				<fmt:formatNumber var="totalPages" value="${(recordSetTotal+(pageSize/2)-1)/pageSize}" maxFractionDigits="0"/>
			</c:if>
			<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" parseLocale="en_US"/>
			<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
			<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
			<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>
			<wcf:rest var="pagorder" url="store/{storeId}/order/{orderId}" scope="request">
				<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
				<wcf:var name="orderId" value="${orderId}" encode="true"/>
				<wcf:param name="pageSize" value="${pageSize}"/>
				<wcf:param name="pageNumber" value="${currentPage}"/>
			</wcf:rest>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${empty pagorder || pagorder == null || fn:length(pagorder.orderItem) > pageSize}">
			<wcf:rest var="pagorder" url="store/{storeId}/cart/@self">
				<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
				<wcf:param name="pageSize" value="${pageSize}"/>
				<wcf:param name="pageNumber" value="${currentPage}"/>
			</wcf:rest>
			<fmt:parseNumber var="recordSetTotal" value="${pagorder.recordSetTotal}" integerOnly="true" />
			<c:if test="${beginIndex > recordSetTotal}">
				<fmt:formatNumber var="totalPages" value="${(recordSetTotal/pageSize)}"/>
				<c:if test="${recordSetTotal%pageSize < (pageSize/2)}">
					<fmt:parseNumber var="totalPages" value="${(recordSetTotal+(pageSize/2)-1)/pageSize}" parseLocale="en_US"/>
				</c:if>
				<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true" parseLocale="en_US"/>
				<c:set var="beginIndex" value="${(totalPages-1)*pageSize}" />
				<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
				<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true"/>
				<wcf:rest var="pagorder" url="store/{storeId}/cart/@self">
					<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="pageNumber" value="${currentPage}"/>
				</wcf:rest>
			</c:if>
		</c:if>
	</c:otherwise>
</c:choose>
<c:set var="paymentInstruction" value="${pagorder}" scope="request"/>
<fmt:parseNumber var="recordSetTotal" value="${pagorder.recordSetTotal}" integerOnly="true" />

<c:if test="${beginIndex == 0}">
	<c:if test="${recordSetTotal > pagorder.recordSetCount}">
		<c:set var="pageSize" value="${pagorder.recordSetCount}" />
	</c:if>
</c:if>

<fmt:parseNumber var="numEntries" value="${pagorder.recordSetTotal}" integerOnly="true"/>

<c:if test="${numEntries > pageSize}">
	<fmt:formatNumber var="totalPages" type="number" groupingUsed="false" value="${numEntries / pageSize}" maxFractionDigits="0" />
	<c:if test="${numEntries - (totalPages * pageSize) > 0}" >
		<c:set var="totalPages" value="${totalPages + 1}" />
	</c:if>

	<c:choose>
		<c:when test="${beginIndex + pageSize >= numEntries}">
			<c:set var="endIndex" value="${numEntries}" />
		</c:when>
		<c:otherwise>
			<c:set var="endIndex" value="${beginIndex + pageSize}" />
		</c:otherwise>
	</c:choose>

	<fmt:formatNumber var="currentPage" value="${(beginIndex/pageSize)+1}"/>
	<fmt:parseNumber var="currentPage" value="${currentPage}" integerOnly="true" parseLocale="en_US"/>

	<div id="ShopcartPaginationText1">
		<div class="textfloat">
		<fmt:message bundle="${storeText}" key="CATEGORY_RESULTS_DISPLAYING" >
			<fmt:param><fmt:formatNumber value="${beginIndex + 1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
		</fmt:message>
		</div>
		<div class="text textfloat divpadding">

			<c:if test="${beginIndex != 0}">

				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText1_1" class="tlignore" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_1'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText1_1" class="tlignore" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_1'); if(submitRequest()){ cursor_wait();
					wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:otherwise>
				</c:choose>

				</c:if>

					<img src="<c:out value="${jspStoreImgDir}${env_vfileColor}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message bundle="${storeText}" key="CATEGORY_PAGING_LEFT_IMAGE" />" />

				<c:if test="${beginIndex != 0}">
					</a>
				</c:if>
			<span>

			<fmt:message bundle="${storeText}" key="CATEGORY_RESULTS_PAGES_DISPLAYING" >
				<fmt:param><fmt:formatNumber value="${currentPage}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
			</fmt:message>

			</span>

				<c:if test="${numEntries > endIndex }">
				<c:choose>
					<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
							<a id="ShopcartPaginationText1_2" class="tlignore" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_2'); if(submitRequest()){ cursor_wait();
						wcRenderContext.updateRenderContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText1_2" class="tlignore" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText1_2'); if(submitRequest()){ cursor_wait();
						wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:otherwise>
				</c:choose>
					</c:if>
				<img src="<c:out value="${jspStoreImgDir}${env_vfileColor}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message bundle="${storeText}" key="CATEGORY_PAGING_RIGHT_IMAGE" />" />
				<c:if test="${numEntries > endIndex }">
					</a>
				</c:if>

		</div>
	</div>
	<div class="clear_float"></div>
</c:if>

<c:set var="allContractsValid" value="true" scope="request"/>

<table id="order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message bundle="${storeText}" key="SHOPCART_TABLE_SUMMARY" />">


<flow:ifDisabled feature="AjaxCheckout">

	<input type="hidden" name="storeId" value='<c:out value="${storeId}"/>' id="WC_OrderItemDetailsf_inputs_5"/>
	<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_OrderItemDetailsf_inputs_6"/>
	<input type="hidden" name="orderId" value='<c:out value="${pagorder.orderId}"/>' id="WC_OrderItemDetailsf_inputs_7"/>
	<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' id="WC_OrderItemDetailsf_inputs_8"/>
	<c:choose>
		<c:when test="${param.fromPage == 'pendingOrderDisplay'}">
			<input type="hidden" name="URL" id="WC_OrderItemDetailsf_inputs_4" value='PendingOrderDisplayView?orderId=<c:out value="${pagorder.orderId}"/>&catalogId=<c:out value="${catalogId}"/>&storeId=<c:out value="${storeId}"/>&langId=<c:out value="${langId}"/>'/>
			<input type="hidden" name="errorViewName" value="PendingOrderDisplayView" id="WC_OrderItemDetailsf_inputs_9"/>
		</c:when>
		<c:otherwise>
			<input type="hidden" name="URL" id="WC_OrderItemDetailsf_inputs_4" value='AjaxOrderItemDisplayView?&orderItem*=&quantity*=&selectedAttr*=&catalogId_*=&beginIndex*=&orderId*='/>
			<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="WC_OrderItemDetailsf_inputs_9"/>
		</c:otherwise>
	</c:choose>


	<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_OrderItemDetailsf_inputs_10"/>
	<input type="hidden" name="calculateOrder" value="1" id="WC_OrderItemDetailsf_inputs_11"/>

</flow:ifDisabled>

	<c:if test="${pagorder.orderItem != null && !empty pagorder.orderItem}">
		<c:if test="${showDynamicKit eq 'true'}">
			<c:set var="orderHasDKComponents" value="false" />
			<c:forEach var="orderItem" items="${pagorder.orderItem}">
				<c:if test="${!empty orderItem.configurationID && !empty orderItem.orderItemComponent}">
					<c:set var="orderHasDKComponents" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${orderHasDKComponents eq 'true'}">
				<c:catch var="searchServerException">
					<wcf:rest var="dkComponents" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byIds" >
							<c:forEach var="orderItem" items="${pagorder.orderItem}">
									<wcf:param name="id" value="${orderItem.productId}"/>
										<c:forEach var="orderItemComponents" items="${orderItem.orderItemComponent}">
											<wcf:param name="id" value="${orderItemComponents.catalogEntryIdentifier.uniqueID}"/>
										</c:forEach>
							</c:forEach>
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="currency" value="${env_currencyCode}" />
							<wcf:param name="responseFormat" value="json" />
							<wcf:param name="catalogId" value="${sdb.masterCatalog.catalogId}" />
					</wcf:rest>
				</c:catch>
			</c:if>
		</c:if>
	</c:if>

	<%--
		The following snippet retrieves all the catalog entries associated with each item in the current order.
		It was taken out of the larger c:forEach loop below for performance reasons.
	--%>
	<%-- Try to get it from our internal hashMap --%>
	<jsp:useBean id="missingCatentryIdsMap" class="java.util.HashMap"/>
	<c:if test="${itemDetailsInThisOrder == null}">
		<jsp:useBean id="itemDetailsInThisOrder" class="java.util.HashMap" scope="request"/>
	</c:if>

	<c:forEach var="orderItem0" items="${pagorder.orderItem}">
		<c:set var="aCatEntry" value="${itemDetailsInThisOrder[orderItem0.productId]}"/>
		<c:if test="${empty aCatEntry}">
			<c:set property="${orderItem0.productId}" value="${orderItem0.productId}" target="${missingCatentryIdsMap}"/>
		</c:if>
	</c:forEach>
	<c:if test="${!empty missingCatentryIdsMap}">
		<c:catch var="searchServerException">
			<wcf:rest var="missingCatEntryInOrder" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byIds" >
				<c:forEach var="missingCatEntryId" items="${missingCatentryIdsMap}">
					<wcf:param name="id" value="${missingCatEntryId.value}"/>
				</c:forEach>
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="currency" value="${env_currencyCode}" />
				<wcf:param name="responseFormat" value="json" />
				<wcf:param name="catalogId" value="${sdb.masterCatalog.catalogId}" />
				<wcf:param name="profileName" value="IBM_findProductByIds_Summary_WithNoEntitlementCheck" />
			</wcf:rest>
		</c:catch>
	</c:if>
	<c:forEach var="aCatEntry" items="${missingCatEntryInOrder.catalogEntryView}">
		<c:set property="${aCatEntry.uniqueID}" value="${aCatEntry}" target="${itemDetailsInThisOrder}"/>
	</c:forEach>
	<c:remove var="missingCatentryIdsMap"/>

	

	


	<c:forEach var="orderItem" items="${pagorder.orderItem}" varStatus="status">
		<c:set var="catEntry" value="${itemDetailsInThisOrder[orderItem.productId]}"/>
		<c:set var="patternName" value="ProductURL"/>
		
		<%-- The URL that links to the display page --%>
		<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="productId" value="${orderItem.productId}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>

		<%-- If this is a product and has defining attributes, then allow user to change --%>



		<c:choose>
			<c:when test="${empty catEntry.name}">
				<c:set var="cartItemName" value="${orderItem.partNumber}" />
				<c:set var="cartItemPartNumber" value="${orderItem.partNumber}" />
			</c:when>
			<c:otherwise>
				<c:set var="cartItemName" value="${catEntry.name}" />
				<c:set var="cartItemPartNumber" value="${catEntry.partNumber}" />
			</c:otherwise>
		</c:choose>
		<c:if test="${!empty sessionScope.storeName1}">
										<script>
										ga('ec:addProduct', {
										  'id': "${orderItem.productId}",                      // SKU ID
										  'name': "${cartItemName}"            // The Product's name
										  
										});
										 
										</script>
	    </c:if>
		<%-- get the formatted qty for this item --%>
		<fmt:formatNumber var="quickCartOrderItemQuantity" value="${orderItem.quantity}"  pattern='#####'/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${orderItem.orderItemId}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${orderItem.productId}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${cartItemName}"/>' name='catalogName_<c:out value="${status.count}"/>' id='catalogName_<c:out value="${status.count}"/>'/>
		
		<tr>

			<c:forEach var="discounts" items="${orderItem.adjustment}">
					<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
					<c:if test="${discounts.displayLevel == 'OrderItem'}">
						<c:set var="nobottom" value="th_align_left_no_bottom"/>
					</c:if>
			</c:forEach>
			<th class="th_align_left_normal <c:out value="${nobottom}"/>" id="shoppingCart_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message bundle="${storeText}" key="Checkout_ACCE_for" /> <c:out value="${fn:replace(cartItemName, search, replaceStr)}" escapeXml="false"/>">
				
				<div id="WC_OrderItemDetailsf_div_2_<c:out value='${status.count}'/>" class="img">
					<c:if test="${!empty  catEntry.name}">
						<p> <a class="hover_underline" id="catalogEntry_name_${orderItem.orderItemId}" href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${cartItemName}" escapeXml="false"/></a></p>
					</c:if>
					<span>Product code: <c:out value="${cartItemPartNumber}" escapeXml="false"/></span><br/>
					
				</div>
			</th>
			</tr>
		<c:remove var="catEntry"/>
	</c:forEach>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
	<c:remove var="itemDetailsInThisOrder"/>



<!-- END OrderItemDetailB2C.jsp -->
