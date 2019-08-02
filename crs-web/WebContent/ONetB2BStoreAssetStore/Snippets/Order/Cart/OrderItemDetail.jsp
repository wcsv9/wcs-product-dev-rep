<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN OrderItemDetail.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<c:set var="loyTotalPoints" value="0"/>
<c:set var="redeemTotalPoints" value="0"/>
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
			<wcf:param name="sortOrderItemBy" value="orderItemID"/>
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
				<wcf:param name="sortOrderItemBy" value="orderItemID"/>
			</wcf:rest>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${empty pagorder || pagorder == null || fn:length(pagorder.orderItem) > pageSize}">
			<wcf:rest var="pagorder" url="store/{storeId}/cart/@self">
				<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
				<wcf:param name="pageSize" value="${pageSize}"/>
				<wcf:param name="pageNumber" value="${currentPage}"/>
				<wcf:param name="sortOrderItemBy" value="orderItemID"/>
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
					<wcf:param name="sortOrderItemBy" value="orderItemID"/>
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
<table id="order_details" class="v9_order_details" cellpadding="0" cellspacing="0" border="0" width="100%" summary="<fmt:message bundle="${storeText}" key="SHOPCART_TABLE_SUMMARY" />">
	  <tr class="nested">
		   <th class="align_left min-800" id="shoppingCart_tableCell_productName"><fmt:message bundle="${storeText}" key="SHOPCART_PRODUCT" /></th>
		   <%-- <th class="align_left" id="shoppingCart_tableCell_availability"><fmt:message bundle="${storeText}" key="SHOPCART_AVAILABILITY" /></th> --%>
		   <th class="align_right min-800" id="shoppingCart_tableCell_extGst">Each <br> (Ex GST)</th>
		   <th class="align_right min-800" id="shoppingCart_tableCell_each" abbr="<fmt:message bundle="${storeText}" key="UNIT_PRICE" />">Each <br> (Inc. GST)</th>
		   <th class="align_center min-800" id="shoppingCart_tableCell_quantity" abbr="<fmt:message bundle="${storeText}" key="QUANTITY1" />"><fmt:message bundle="${storeText}" key="SHOPCART_QTY" /></th>
		   <th class="align_right total min-800" id="shoppingCart_tableCell_total" abbr="<fmt:message bundle="${storeText}" key="TOTAL_PRICE" />"><fmt:message bundle="${storeText}" key="SHOPCART_TOTAL" /><br>(Inc. GST)</th>
	  </tr>

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

	<c:set var="orderHasCatentryWithParent" value="false" />
	<c:forEach var="orderItem0" items="${pagorder.orderItem}">
		<c:set var="aCatEntry" value="${itemDetailsInThisOrder[orderItem0.productId]}"/>
		<%-- If ITEM doesnt have defining attributes, then we will not show Change Attributes Link. No need to fetch parent catEntry details in this case --%>
		<c:set var="isSingleSKU" value="true"/>
		<c:forEach var="attribute" items="${aCatEntry.attributes}" varStatus="status2">
			<c:if test="${ attribute.usage == 'Defining' }" >
				<c:set var="isSingleSKU" value="false"/>
			</c:if>
		</c:forEach>
		<c:if test="${!empty aCatEntry.parentCatalogEntryID && isSingleSKU == 'false'}">
			<c:set var="orderHasCatentryWithParent" value="true" />
			<c:choose>
				<c:when test="${empty parentCatentryIds}" >
					<c:set var="parentCatentryIds" value="${aCatEntry.parentCatalogEntryID}" />
				</c:when>
				<c:otherwise>
					<c:set var="parentCatentryIds" value="${parentCatentryIds},${aCatEntry.parentCatalogEntryID}" />
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>

	<jsp:useBean id="parentCatalogEntrysMap" class="java.util.HashMap" scope="page"/>
	<c:if test="${orderHasCatentryWithParent}">
		<c:catch var="searchServerException">
			<wcf:rest var="parentCatalogEntrys" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byIds" >
				<c:forEach var="parentCatentryId" items="${parentCatentryIds}">
					<wcf:param name="id" value="${parentCatentryId}"/>
				</c:forEach>
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="currency" value="${env_currencyCode}" />
				<wcf:param name="responseFormat" value="json" />
				<wcf:param name="catalogId" value="${sdb.masterCatalog.catalogId}" />
				<wcf:param name="profileName" value="IBM_findProductByIds_Basic_Summary" />
			</wcf:rest>
			<c:forEach var="oneCatEntry" items="${parentCatalogEntrys.catalogEntryView}">
				<c:set property="${oneCatEntry.uniqueID}" value="${oneCatEntry}" target="${parentCatalogEntrysMap}"/>
			</c:forEach>
		</c:catch>
	</c:if>
	<c:set var="nonRecurringOrderItems" value=""/>
	<c:set var="nonRecurringOrderItemsCount" value="0"/>
	<c:forEach var="orderItem" items="${pagorder.orderItem}" varStatus="status">
		<c:set var="catEntry" value="${itemDetailsInThisOrder[orderItem.productId]}"/>
		<c:set var="patternName" value="ProductURL"/>
		<c:set var="dynamicKitConfigurable" value="${catEntry.dynamicKitConfigurable}"/>
		<c:set var="parentDynamicKitConfigurable" value="${catEntry.parentDynamicKitConfigurable}"/>
		<c:if test="${parentDynamicKitConfigurable eq '0' }">
			<c:set var="dynamicKitConfigurable" value="0"/>
		</c:if>
		
		<!-- Get Category name for GTM -->
		<c:set var="splt" value="${fn:split(catEntry.parentCatalogGroupID[0],'_')}"/>
		<wcf:rest var="category"
			url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${splt[1] }">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="currency" value="${env_currencyCode}" />
			<wcf:param name="responseFormat" value="json" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:rest>
		<input type="hidden" value='<c:out value="${category.catalogGroupView[0].longDescription }"/>' id='itemCategory_<c:out value="${orderItem.productId}"/>'/>
		
		<c:choose>
		    <c:when test="${dynamicKitConfigurable eq '1'}">
		        <c:set var="dynamicKitConfigurable" value="true"/>
		    </c:when>
		    <c:otherwise>
		        <c:set var="dynamicKitConfigurable" value="false"/>
		    </c:otherwise>
		</c:choose>

		<%-- The URL that links to the display page --%>
		<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="productId" value="${orderItem.productId}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>

		<%-- If this is a product and has defining attributes, then allow user to change --%>
		<c:set var="parentCatEntryId" value="${catEntry.parentCatalogEntryID}"/>
		<c:set var="hasSingleSKU" value="true"/>
		<c:if test="${!empty parentCatEntryId}">
			<c:set var="parentCatalogEntry" value="${parentCatalogEntrysMap[parentCatEntryId]}"/>
			<c:set var="hasSingleSKU" value="${parentCatalogEntry.hasSingleSKU}"/>
		</c:if>

			<c:if test="${!empty catEntry.thumbnail}">
				<c:choose>
					<c:when test="${(fn:startsWith(catEntry.thumbnail, 'http://') || fn:startsWith(catEntry.thumbnail, 'https://'))}">
						<wcst:resolveContentURL var="thumbNail" url="${catEntry.thumbnail}"/>
					</c:when>
					<c:when test="${fn:startsWith(catEntry.thumbnail, '/store/0/storeAsset')}">
						<c:set var="thumbNail" value="${storeContextPath}${catEntry.thumbnail}" />
					</c:when>
					<c:otherwise>
						<c:set var="thumbNail" value="${catEntry.thumbnail}" />
					</c:otherwise>
				</c:choose>
			</c:if>

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

		<%-- get the formatted qty for this item --%>
		<fmt:formatNumber var="quickCartOrderItemQuantity" value="${orderItem.quantity}"  pattern='#####'/>
		<%-- keep setting total number of items variable..in the last loop, it will contain correct value :-)better to get this value using length function.. --%>
		<c:set var="totalNumberOfItems" value="${status.count}"/>
		<input type="hidden" value='<c:out value="${orderItem.orderItemId}"/>' name='orderItem_<c:out value="${status.count}"/>' id='orderItem_<c:out value="${status.count}"/>'/>
		<input type="hidden" value='<c:out value="${orderItem.productId}"/>' name='catalogId_<c:out value="${status.count}"/>' id='catalogId_<c:out value="${status.count}"/>'/>
		<tr>

			<c:forEach var="discounts" items="${orderItem.adjustment}">
					<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
					<c:if test="${discounts.displayLevel == 'OrderItem'}">
						<c:set var="nobottom" value="th_align_left_no_bottom"/>
					</c:if>
			</c:forEach>
			<th class="th_align_left_normal <c:out value="${nobottom}"/>" id="shoppingCart_rowHeader_product<c:out value='${status.count}'/>" abbr="<fmt:message bundle="${storeText}" key="Checkout_ACCE_for" /> <c:out value="${fn:replace(cartItemName, search, replaceStr)}" escapeXml="${env_escapeXmlFlag}"/>">
				<div class="img" id="WC_OrderItemDetailsf_div_1_<c:out value='${status.count}'/>">
					<c:set var="catEntryIdentifier" value="${orderItem.productId}"/>
					<c:choose>
						<c:when test="${!empty thumbNail}">
							<c:set var="imgSource" value="${thumbNail}" />
						</c:when>
						<c:otherwise>
							<c:set var="imgSource" value="${jspStoreImgDir}images/NoImageIcon_sm.jpg" />
						</c:otherwise>
					</c:choose>
					<a href="${catEntryDisplayUrl}" id="catalogEntry_img_${orderItem.orderItemId}" title="<c:out value="${cartItemName}"/>">
						<img alt="${cartItemName}" src="${s3ImageHost}${imgSource}"/>
					</a>
					<c:remove var="thumbNail"/>
				</div>
				<div id="WC_OrderItemDetailsf_div_2_<c:out value='${status.count}'/>" class="img">
					<c:if test="${!empty  catEntry.name}">
						<%-- <p><a class="hover_underline" id="catalogEntry_name_${orderItem.orderItemId}" href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${cartItemName}" escapeXml="${env_escapeXmlFlag}"/></a></p>
						href="Javascript:this.gtmProductClick('<c:out value="${cartItemName}" escapeXml="${env_escapeXmlFlag}"/>', '<c:out value="${cartItemPartNumber}" escapeXml="${env_escapeXmlFlag}"/>', '<c:out value="${formattedUnitPrice}"/>', '<c:out value="${catEntry.manufacturer}"/>', '<c:out value="${quickCartOrderItemQuantity}"/>', '<c:out value="${orderItem.productId}"/>', '${status.count}', '<c:out value="${catEntryDisplayUrl}"/>');"
						--%>
						<p><a class="hover_underline" id="catalogEntry_name_${orderItem.orderItemId}" href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${cartItemName}" escapeXml="${env_escapeXmlFlag}"/></a></p>
					</c:if>
					<span>
						<fmt:message bundle="${storeText}" key="CurrentOrder_SKU_COLON">
							<fmt:param><c:out value="${cartItemPartNumber}" escapeXml="${env_escapeXmlFlag}"/></fmt:param>
						</fmt:message>
					</span><br/>
					
				
<!-- Start Loyalty Points Changes By Ali Raza -->	
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

		
		<c:if test="${userType != 'G'}">



			<c:if test="${state eq 'R' && loyaltyEnabled eq 'true' && content eq 'true'  || state eq 'WCS' && content eq 'true' }"> 
				
				<c:choose>
					<c:when test="${empty orderItem.unitPrice}">
					
						<wcf:rest var="loyaltyPointsForProduct" url="store/{storeId}/loyalty/getLoyaltyPointsByCatentryId/{catentryId}/{unitPrice}/{itemQty}/{orderItemId}/{flag}/{catalogId}" scope="request">
							<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
							<wcf:var name="catentryId" value="${cartItemPartNumber}" encode="true"/>
							<wcf:var name="unitPrice" value="$0.0" encode="true"/>
							<wcf:var name="itemQty" value="0" encode="true"/>
							<wcf:var name="orderItemId" value="${orderItem.orderItemId}" encode="true"/>
							<wcf:var name="flag" value="orderItem" encode="true"/>
							<wcf:var name="catalogId" value="${WCParam.catalogId}" encode="true"/>
						</wcf:rest>
					</c:when>
					<c:otherwise>
						<wcf:rest var="loyaltyPointsForProduct" url="store/{storeId}/loyalty/getLoyaltyPointsByCatentryId/{catentryId}/{unitPrice}/{itemQty}/{orderItemId}/{flag}/{catalogId}" scope="request">
							<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
							<wcf:var name="catentryId" value="${cartItemPartNumber}" encode="true"/>
							<wcf:var name="unitPrice" value="${orderItem.unitPrice}" encode="true"/>
							<wcf:var name="itemQty" value="0" encode="true"/>
							<wcf:var name="orderItemId" value="${orderItem.orderItemId}" encode="true"/>
							<wcf:var name="flag" value="orderItem" encode="true"/>
							<wcf:var name="catalogId" value="${WCParam.catalogId}" encode="true"/>
						</wcf:rest>
						
					</c:otherwise>
				</c:choose>	
					
					<fmt:parseNumber var="productWiseLoyaltyPoints" integerOnly="true" type="number" value="${loyaltyPointsForProduct.loyaltyPoints}" />
					
				<input type="hidden" name="loyCons" id="loyCons" value="<c:out value="${loyaltyPointsForProduct.loyaltyconstant}" />"  />
				<input type="hidden" name="itemPrice" id="itemPrice" value="<c:out value="${loyaltyPointsForProduct.unitPrice}" />"  />
				<c:if test="${productWiseLoyaltyPoints != null && productWiseLoyaltyPoints != 0 && WCParam.storeId ne '11901'}">							
					<div class="earn_upoint_checkout">
								<c:set var="loyTotalPoints" value="${ loyTotalPoints + productWiseLoyaltyPoints }"/>
								<input type="hidden" name="redeemValue_<c:out value='${status.count}'/>" id="redeemValue_<c:out value='${status.count}'/>" value="" />
								Earn <c:out value="${productWiseLoyaltyPoints }" /> UPoints
					</div>
					<div style="clear:both"></div>
				</c:if>
				
				<c:if test="${loyaltyPointsForProduct.redeemable}">
					<c:set var="isRedeem1" value="true"/>
					 
					<div class="redeem_upoint_checkout">
						
									<fmt:parseNumber var="redeemP" integerOnly="true" type="number" value="${loyaltyPointsForProduct.redeemValue}" />
									<c:out value="${redeemP}" />												
									<c:set var="redeemTotalPoints" value="${ redeemTotalPoints + redeemP }"/>
								Redeem UPoints
					</div>
					<div style="clear:both"></div>
				</c:if> 
				<c:remove var="productWiseLoyaltyPoints"/>
				<c:remove var="loyaltyPointsForProduct"/>
			</c:if>
		</c:if>
		<c:if test="${state eq 'R' && loyaltyEnabled eq 'true' && content eq 'true'  || state eq 'WCS' && content eq 'true' }"> 
			<input type="hidden" name="loyCons" id="loyCons" value="0"  />
			<input type="hidden" name="itemPrice" id="itemPrice" value="0"  />			
		</c:if>
<!-- End Loyalty Points Changes By Ali Raza -->	
					
					
					
					<c:if test="${empty catEntry.parentCatalogEntryID && cartItemPartNumber != null && !empty cartItemPartNumber}">
						<c:choose>
							<c:when test="${empty order_partnumbers}" >
								<c:set var="order_partnumbers" value="${cartItemPartNumber}" />
							</c:when>
							<c:otherwise>
								<c:set var="order_partnumbers" value="${order_partnumbers}|${cartItemPartNumber}" />
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${orderItem.freeGift}">
						<p class="italic"><fmt:message bundle="${storeText}" key="SHOPCART_FREEGIFT" /></p>
					</c:if>
					<%@ include file="../../ReusableObjects/OrderGiftItemDisplayExt.jspf" %>
					<%@ include file="../../ReusableObjects/GiftRegistryOrderGiftItemDisplayExt.jspf" %>
					<%--
					 ***
					 * Start: Display Defining attributes
					 * Loop through the attribute values and display the defining attributes
					 ***
					--%>
					<c:remove var="selectedAttr"/>
					<c:forEach var="attribute" items="${catEntry.attributes}" varStatus="status2">
						<c:if test="${ attribute.usage=='Defining' }" >
							<c:choose>
								<c:when test="${empty selectedAttr}">
									<c:set var="selectedAttr" value='${attribute.name}|${attribute.values[0].value}'/>
								</c:when>
								<c:otherwise>
									<c:set var="selectedAttr" value='${selectedAttr}|${attribute.name}|${attribute.values[0].value}'/>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>

					<c:if test="${!orderItem.freeGift && !empty selectedAttr && !hasSingleSKU}">
						<a class="order_link hover_underline tlignore" id="WC_OrderItemDetailsf_links_1_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" href="javaScript: if (!this.disabled) {setCurrentId('WC_OrderItemDetailsf_links_1_<c:out value="${status.count}"/>_<c:out value="${status2.count}"/>');
								QuickInfoJS.changeAttributes('${orderItem.orderItemId}','<c:out value='${parentCatEntryId}'/>', '${orderItem.productId}',${quickCartOrderItemQuantity});}">
							<fmt:message bundle="${storeText}" key="CHANGE_ATTRIBUTES" />
						</a>
						<br/>
					</c:if>
					<input type="hidden" name="selectedAttr" id="selectedAttr_${orderItem.orderItemId}" value="${selectedAttr}"/>

					<%-- Build non recurring item message for order item --%>
					<c:if test="${catEntry.disallowRecurringOrder == '1'}">
						<c:set var="nonRecurringOrderItemsCount" value="${nonRecurringOrderItemsCount+1}"/>
						<c:if test="${!empty nonRecurringOrderItems}">
							<c:set var="nonRecurringOrderItems" value="${nonRecurringOrderItems},"/>
						</c:if>
						<c:set var="nonRecurringOrderItems" value="${nonRecurringOrderItems}${orderItem.orderItemId}"/>
						<div class="no_checkout" id="nonRecurringItem_<c:out value='${orderItem.orderItemId}'/>" style="display: none;"><div class="no_checkout_icon"></div> &nbsp;<fmt:message bundle="${storeText}" key="NON_RECURRING_PRODUCT" /></div>
					</c:if>
					<%--
					 ***
					 * End: Display Defining attributes
					 ***
					--%>

					<c:if test="${showDynamicKit eq 'true' && !empty orderItem.configurationID}">
						<div class="top_margin5px"><fmt:message bundle="${storeText}" key="CONFIGURATION" /></div>
						<p>
							<ul class="product_specs" id="configuredComponents_${orderItem.orderItemId}">
								<c:forEach var="oiComponent" items="${orderItem.orderItemComponent}">
									<c:forEach var="savedDKComponent" items="${dkComponents.catalogEntryView}">
										<c:if test="${savedDKComponent.uniqueID == oiComponent.catalogEntryIdentifier.uniqueID}">
											<fmt:formatNumber var="itemComponentQuantity" value="${oiComponent.quantity.value}" type="number" maxFractionDigits="0"/>
											<c:choose>
												<c:when test="${itemComponentQuantity>1}">
													<%-- output order item component quantity in the form of "5 x ComponentName" --%>
													<fmt:message bundle="${storeText}" var="txtOrderItemQuantityAndName" key="ITEM_COMPONENT_QUANTITY_NAME" >
														<fmt:param><c:out value="${itemComponentQuantity}" escapeXml="false"/></fmt:param>
														<fmt:param><c:out value="${savedDKComponent.name}" escapeXml="${env_escapeXmlFlag}"/></fmt:param>
													</fmt:message>
													<li><c:out value="${txtOrderItemQuantityAndName}"/></li>
												</c:when>
												<c:otherwise>
													<li><c:out value="${savedDKComponent.name}"/></li>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								</c:forEach>
							</ul>
						</p>
						<wcf:url var="dkConfigureURL" value="ConfigureView">
							<wcf:param name="storeId"   value="${WCParam.storeId}"  />
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="catEntryId" value="${orderItem.productId}" />
							<wcf:param name="orderItemId" value="${orderItem.orderItemId}"/>
							<wcf:param name="contractId" value="${orderItem.contractId}"/>
							<wcf:param name="fromURL" value="AjaxOrderItemDisplayView" />
						</wcf:url>
						<c:if test="${dynamicKitConfigurable}">
							<p>
								<a href="<c:out value='${dkConfigureURL}'/>"><fmt:message bundle="${storeText}" key="CHANGE_CONFIGURATION" /></a>
							</p>
						</c:if>
					</c:if>

					<c:set var="fromPage" value="${param.fromPage}" scope="request"/>
					<c:set var="orderId" value="${pagorder.orderId}" scope="request"/>

					<c:if test="${!orderItem.freeGift}">
						<c:if test="${env_contractSelection}">
							<c:set var="isShoppingCartPage" value="true"/>
							<%@ include file="B2BContractSelectExt.jspf" %>
						</c:if>
						<br/>

							<%-- displays move to wish list link if user is a registered shopper --%>
							<flow:ifEnabled feature="SOAWishlist">
								<%out.flush();%>
								<c:import url = "${env_jspStoreDir}Widgets/ShoppingList/ShoppingList.jsp">
									<c:param name="parentPage" value="OI${orderItem.orderItemId}"/>
									<c:param name="catalogId" value="${WCParam.catalogId}"/>
									<c:param name="productId" value="${orderItem.productId}"/>
									<c:param name="deleteCartCookie" value="true" />
									<c:param name="orderItemId" value="${orderItem.orderItemId}"/>
								</c:import>
								<%out.flush();%>
							</flow:ifEnabled>
							

							<a class="remove_address_link hover_underline tlignore" id="WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>" href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>'); CheckoutHelperJS.deleteFromCart('<c:out value='${orderItem.orderItemId}'/>'); this.gtmRemoveFromCart('<c:out value="${cartItemName}" escapeXml="${env_escapeXmlFlag}"/>', '<c:out value="${cartItemPartNumber}" escapeXml="${env_escapeXmlFlag}"/>', '<c:out value="${formattedUnitPrice}"/>', '<c:out value="${catEntry.manufacturer}"/>', '<c:out value="${quickCartOrderItemQuantity}"/>', '<c:out value="${orderItem.productId}"/>');wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'state':'<c:out value='${state}'/>', 'loyaltyEnabled':'<c:out value='${loyaltyEnabled}'/>','content':'<c:out value='${content}'/>','totalPoints':'<c:out value='${totalPoints}'/>'});">
								<%-- <img src="<c:out value='${jspStoreImgDir}${env_vfileColor}'/>table_x_delete.png" alt=""/> --%>
								<fmt:message bundle="${storeText}" key="SHOPCART_REMOVE" />
							</a>
							<!-- For Add Comments button -->
							<a class="remove_address_link hover_underline tlignore" id="WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>" href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_2_<c:out value='${status.count}'/>'); CheckoutHelperJS.toggleComment(<c:out value='${status.count}'/>);wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'state':'<c:out value='${state}'/>', 'loyaltyEnabled':'<c:out value='${loyaltyEnabled}'/>','content':'<c:out value='${content}'/>','totalPoints':'<c:out value='${totalPoints}'/>'});" >Add Comments</a> 

							
							<%-- displays move to requisition list link --%>
							<%-- <flow:ifEnabled feature="RequisitionList">
								<div class="OrderItemMoveToRequisitionLists">
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.PDP_AddToRequisitionLists/AddToRequisitionLists.jsp">
										<wcpgl:param name="langId" value="${langId}" />	
										<wcpgl:param name="parentPage" value="${orderItem.orderItemId}" />
										<wcpgl:param name="quantity" value="${orderItem.quantity}" />
										<wcpgl:param name="moveToRequisitionList" value="true" />
										<wcpgl:param name="includeReqListJS" value="true" />
										<wcpgl:param name="nestedAddToRequisitionListsWidget" value="true"/>
										<wcpgl:param name="productId" value="${orderItem.productId}"/>
										<wcpgl:param name="configurationID" value="${orderItem.configurationID}" />
									</wcpgl:widgetImport>
								<%out.flush();%>														
								<script type="text/javascript">
									$(document).ready(function() {									
										wcTopic.subscribe("DefiningAttributes_Resolved<c:out value='${orderItem.orderItemId}'/>", addReqListsJS<c:out value='${orderItem.orderItemId}'/>.setCatEntryId);																		
										wcTopic.publish("DefiningAttributes_Resolved<c:out value='${orderItem.orderItemId}'/>", "<c:out value='${orderItem.productId}'/>", "<c:out value='${parentCatEntryId}'/>");
									});
								</script>							
								</div>	
								<c:remove var="AddToRequisitionListJSIncluded"/>
							</flow:ifEnabled> --%>
							<flow:ifEnabled feature="RequisitionList">
								<div class="OrderItemMoveToRequisitionLists">
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.PDP_AddToRequisitionLists/AddToRequisitionLists.jsp">
										<wcpgl:param name="langId" value="${langId}" />	
										<wcpgl:param name="parentPage" value="${orderItem.orderItemId}" />
										<wcpgl:param name="quantity" value="${orderItem.quantity}" />
										<wcpgl:param name="includeReqListJS" value="true" />
										<wcpgl:param name="nestedAddToRequisitionListsWidget" value="true"/>
										<wcpgl:param name="productId" value="${orderItem.productId}"/>
										<wcpgl:param name="configurationID" value="${orderItem.configurationID}" />
										<wcpgl:param name="cartSKUs" value="true" />
									</wcpgl:widgetImport>
								<%out.flush();%>
								<input type="hidden" id="ProductInfoName_${orderItem.productId}" value="${fn:escapeXml(cartItemName)}"/>
								<input type="hidden" id="ProductInfoImage_${orderItem.productId}" value="${fn:escapeXml(imgSource)}"/>												
								<script type="text/javascript">
									$(document).ready(function() {									
										wcTopic.subscribe("DefiningAttributes_Resolved<c:out value='${orderItem.orderItemId}'/>", addReqListsJS<c:out value='${orderItem.orderItemId}'/>.setCatEntryId);																		
										wcTopic.publish("DefiningAttributes_Resolved<c:out value='${orderItem.orderItemId}'/>", "<c:out value='${orderItem.productId}'/>", "<c:out value='${parentCatEntryId}'/>");
									});
								</script>							
								</div>	
								<c:remove var="AddToRequisitionListJSIncluded"/>
							</flow:ifEnabled>
							
							<%-- <input type="hidden" id="commentOrderItemId_${status.count}" name="commentOrderItemId_${status.count}" value="${orderItem.orderItemIdentifier.uniqueID}" /> --%>
							<input type="hidden" id="commentOrderItemId_${status.count}" name="commentOrderItemId_${status.count}" value="${orderItem.orderItemId}" />
							<c:set var="cnt1" value="${status.count}" />
							<div style="clear:both"></div>
							<div class="add-comments" style="padding:10px 0px">
								<c:choose>
								<c:when test="${empty orderItem.comments || orderItem.comments == '' }">
									<textarea rows="3" style="margin-right:10px;float:left;display: none" cols="30" id="comment_${status.count}" name="<c:out value="comment_${status.count}" />" oninput="javaScript:blockCheckImg('comment_${status.count}_checkImg');"><c:out value="${orderItem.comments}" /></textarea>
									<input type="button" style="display: none;padding:20px 10px;" id="commentb_${status.count}" name="<c:out value="commentb_${status.count}" />" value="Save Comment" onclick="JavaScript:setCurrentId('comment_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCheckImgId('comment_${status.count}_checkImg'); CheckoutHelperJS.updateCartComments(document.getElementById('comment_${status.count}'), '<c:out value='${orderItem.orderItemId}'/>');"" />
									<span id="comment_${status.count}_checkImg" style="display:none;color:#FF0000;font-weight:bold;">
										<img src="${jspStoreImgDir}images/colors/color1/iconCheck.gif">
									</span>									
								</c:when>
								<c:otherwise>
									<textarea rows="3" cols="40" style="" id="comment_${status.count}" name="<c:out value="comment_${status.count}" />" oninput="javaScript:blockCheckImg('comment_${status.count}_checkImg');"><c:out value="${orderItem.comments}" /></textarea>								
									<input type="button" style="" id="commentb_${status.count}" name="<c:out value="commentb_${status.count}" />" value="Save Comment" onclick="JavaScript:setCurrentId('comment_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCheckImgId('comment_${status.count}_checkImg'); CheckoutHelperJS.updateCartComments(document.getElementById('comment_${status.count}'), '<c:out value='${orderItem.orderItemId}'/>'); "" /> 
									<span id="comment_${status.count}_checkImg" style="color:#FF0000;font-weight:bold;">
										<img src="${jspStoreImgDir}images/colors/color1/iconCheck.gif">
									</span>
								</c:otherwise>	
							</c:choose>
							</div>
						
					</c:if>
					<div class="clear"></div>
					
					<!-- price for mobile start
					<div class="field-title max-800">Price (ex GST)</div>
					<div class="field-title max-800">Unit Price</div>-->
					<div style="clear:both;"></div>
					 <%--<div class="field-data max-800">
						 <wcbase:useBean id="catalogEntry3" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean"  scope="request">
							<c:set property="catalogEntryID" value="${catEntryIdentifier}" target="${catalogEntry3}"/>
						</wcbase:useBean> --%>
						<%--<wcf:rest var="catalogEntry3" url="store/{storeId}/moq/getMoq/{catentryId}" scope="request">
							<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
							<wcf:var name="catentryId" value="${catEntryIdentifier}" encode="true"/>
						</wcf:rest>
						
						<c:choose>
							<c:when test="${catalogEntry3.field1 eq 0}">					
								
											
							</c:when>
							<c:otherwise>
								<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>				
								<c:set var="temp1" value="${fn:replace(formattedUnitPrice,'$','')}" />
								<c:set var="temp2" value="${fn:replace(temp1,',','')}" />
								<c:set var="price" value="${temp2 }" />
								<c:set var="acPrice" value="${temp2 }" />
								<c:set var="price" value="${(price - (price / 1.1)) }" />
								<c:set var="exGstPrice" value="${(acPrice - price) }" />	
								--%>
										<%-- unit price column of order item details table --%>
										<%-- shows unit price of the order item --%>
									<%--	<span class="price">
											<fmt:formatNumber var="formattedUnitPrice" value="${exGstPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
											<c:out value="${formattedUnitPrice}" escapeXml="false" />
											<c:out value="${CurrencySymbol}"/>
										</span>
							
							</c:otherwise>
						</c:choose>
					</div>--%>
					<!--  <div class="field-data max-800">
						 <fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
						<c:out value="${formattedUnitPrice}" escapeXml="false" />
						<c:out value="${CurrencySymbol}"/>
					</div>-->
					<div style="clear:both;height:15px;"></div>
					
					<!--  <div class="field-title max-800">Qty</div>
					<div class="field-title max-800">Total</div>
					-->
					<div style="clear:both;"></div>
					<!-- <div class="field-data max-800">
					
									<%-- <% out.flush(); %>
										<c:import url="${env_siteWidgetsDir}com.royalcyber.moq/QuentityCheck.jsp">
											<c:param name="catalogId" value="${WCParam.catalogId}" />	                	              
											<c:param name="currentProductId" value="${parentCatEntryId}" />
											<c:param name="currentStoreId" value="${WCParam.storeId}" />										
										</c:import> 
									<% out.flush(); %> --%>
									<wcf:rest var="itemInfo" url="store/{storeId}/moq/getMoq/{catentryId}" scope="request">
										<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
										<wcf:var name="catentryId" value="${catEntryIdentifier}" encode="true"/>
									</wcf:rest>
						 <c:choose>
							<c:when test="${orderItem.freeGift}">
								<%-- This is a free item..can't change the qty --%>
								<input type="hidden" value="-1" id='freeGift_qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'/><span><c:out value="${quickCartOrderItemQuantity}"/></span>
							</c:when>
							<c:otherwise>
								<span class="spanacce" id="Quantity_ACCE_Message"><fmt:message bundle="${storeText}" key='ACCE_Quantity_Update_Message' /></span>
								<flow:ifEnabled feature="AjaxCheckout">
									<label for='qty_<c:out value="${status.count}"/>' style='display:none'><fmt:message bundle="${storeText}" key="QUANTITY1" /></label>
									
									<c:choose>
										 <%-- <c:when test="${sessionScope.qty ne 'null' && sessionScope.catentryId ne 'null' && !empty sessionScope.qty && WCParam.catalogId ne '10001' && WCParam.catalogId ne '10601' }">
											<input id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' type="tel" aria-labelledby="Quantity_ACCE_Message" size="1" style="width:25px;" value='<c:out value="${sessionScope.qty}"/>' onchange="JavaScript:if(this.value%'${sessionScope.qty}'==0 && this.value !=0); else{alert('The quantity you entered is invalid. The valid quantity is a multiple of [${sessionScope.qty}]');  this.value='${sessionScope.qty}'; return;}; setCurrentId('qty_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${orderItem.orderItemId}'/>',event)" />
											<c:remove var="qty"/>
											<c:remove var="catentryId"/>
										</c:when> --%>
										<c:when test="${itemInfo.quantity ne 'null' && !empty itemInfo.quantity && WCParam.catalogId ne '10001' && WCParam.catalogId ne '10601' }">
											<input id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' type="tel" aria-labelledby="Quantity_ACCE_Message" size="1" style="width:25px;" value='<c:out value="${itemInfo.quantity}"/>' onchange="JavaScript:if(this.value%'${itemInfo.quantity}'==0 && this.value !=0); else{alert('The quantity you entered is invalid. The valid quantity is a multiple of [${itemInfo.quantity}]');  this.value='${itemInfo.quantity}'; return;}; setCurrentId('qty_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${orderItem.orderItemId}'/>',event)" />
											<c:remove var="qty"/>
											<c:remove var="catentryId"/>
										</c:when>
										<c:otherwise>
										
											<input id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' type="tel" aria-labelledby="Quantity_ACCE_Message" size="1" style="width:25px;" value='<c:out value="${quickCartOrderItemQuantity}"/>' onkeydown="JavaScript:setCurrentId('qty_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${orderItem.orderItemId}'/>',event)" />
										</c:otherwise>
									</c:choose>
									
								</flow:ifEnabled>
								<flow:ifDisabled feature="AjaxCheckout">
									<label for='quantity_<c:out value="${status.count}"/>' style='display:none'><fmt:message bundle="${storeText}" key="QUANTITY1" /></label>
									<input type="hidden" value='<c:out value="${orderItem.orderItemId}"/>' name='orderItemId_<c:out value="${status.count}"/>' id='orderItemId_<c:out value="${status.count}"/>'/>
									<fmt:formatNumber	var="quickCartOrderItemQuantity" value="${orderItem.quantity}" type="number" maxFractionDigits="0"/>
									<input type="tel" aria-labelledby="Quantity_ACCE_Message" size="2" class="input" value='<c:out value="${quickCartOrderItemQuantity}"/>' id='quantity_<c:out value="${status.count}"/>' name='quantity_<c:out value="${status.count}"/>'/>
								</flow:ifDisabled>
							</c:otherwise>
						</c:choose>
					</div>-->
					
					
					<!--  <div class="field-data max-800">
						 <c:choose>
							<c:when test="${orderItem.freeGift}">
								<%-- the OrderItem is a freebie --%>
								<span class="details">
									<fmt:message bundle="${storeText}" key="OrderSummary_SHOPCART_FREE" />
								</span>
							</c:when>
							<c:otherwise>
								<span class="price">
									<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
									<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
									<c:out value="${CurrencySymbol}"/>
								</span>
							</c:otherwise>
						</c:choose>
					</div>-->
					<div style="clear:both;"></div>
					<!-- price for mobile end-->
				</div>
			</th>
			<%-- <td id="WC_OrderItemDetailsf_td_1_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> avail" headers="shoppingCart_tableCell_availability shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<%@ include file="../../ReusableObjects/CatalogEntryAvailabilityDisplay.jspf" %>
			</td> --%>
			
			<wcf:rest var="catalogInfo" url="store/{storeId}/moq/getMoq/{catentryId}" scope="request">
				<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
				<wcf:var name="catentryId" value="${catEntryIdentifier}" encode="true"/>
			</wcf:rest>
			<c:choose>
				<c:when test="${catalogInfo.field1 eq '0'}">					
					<td id="WC_OrderItemDetailsf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each min-800" headers="shoppingCart_tableCell_each shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				
						<%-- unit price column of order item details table --%>
						<%-- shows unit price of the order item --%>
						<span class="price">
							<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
					<c:out value="${formattedUnitPrice}" escapeXml="false" />
					<c:out value="${CurrencySymbol}"/>
						</span>
		
					</td>		
				</c:when>
				<c:otherwise>
					<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>				
					<c:set var="temp1" value="${fn:replace(formattedUnitPrice,'$','')}" />
					<c:set var="temp2" value="${fn:replace(temp1,',','')}" />
					<c:set var="price" value="${temp2 }" />
					<c:set var="acPrice" value="${temp2 }" />
					<c:set var="price" value="${(price - (price / 1.1)) }" />
					<c:set var="exGstPrice" value="${(acPrice - price) }" />	
					<td id="WC_OrderItemDetailsf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each min-800" headers="shoppingCart_tableCell_each shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				
							<%-- unit price column of order item details table --%>
							<%-- shows unit price of the order item --%>
							<span class="price">
								<fmt:formatNumber var="formattedUnitPrice" value="${exGstPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
								<c:out value="${formattedUnitPrice}" escapeXml="false" />
								<c:out value="${CurrencySymbol}"/>
							</span>
			
						</td>	
				</c:otherwise>
			</c:choose>
			<c:remove var="catalogEntry3"/>
			<td id="WC_OrderItemDetailsf_td_2_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each min-800" headers="shoppingCart_tableCell_each shoppingCart_rowHeader_product<c:out value='${status.count}'/>">

				<%-- unit price column of order item details table --%>
				<%-- shows unit price of the order item --%>
				<span class="price">
					<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
					<c:out value="${formattedUnitPrice}" escapeXml="false" />
					<c:out value="${CurrencySymbol}"/>
				</span>

			</td>
			<td id="WC_OrderItemDetailsf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> QTY min-800" headers="shoppingCart_tableCell_quantity shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<p class="item-quantity">
					<c:choose>
						<c:when test="${orderItem.freeGift}">
							<%-- This is a free item..can't change the qty --%>
							<input type="hidden" value="-1" id='freeGift_qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>'/><span><c:out value="${quickCartOrderItemQuantity}"/></span>
						</c:when>
						<c:otherwise>
							<span class="spanacce" id="Quantity_ACCE_Message"><fmt:message bundle="${storeText}" key='ACCE_Quantity_Update_Message' /></span>
							<label for='qty_<c:out value="${status.count}"/>' style='display:none'><fmt:message bundle="${storeText}" key="QUANTITY1" /></label>

							<input id='qty_<c:out value="${status.count}"/>' name='qty_<c:out value="${status.count}"/>' type="tel" aria-labelledby="Quantity_ACCE_Message" size="1" style="width:25px;" value='<c:out value="${quickCartOrderItemQuantity}"/>' onkeydown="JavaScript:setCurrentId('qty_<c:out value='${status.count}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${orderItem.orderItemId}'/>',event);wcRenderContext.updateRenderContext('ShopCartPaginationDisplay_Context',{'state':'<c:out value='${state}'/>', 'loyaltyEnabled':'<c:out value='${loyaltyEnabled}'/>','content':'<c:out value='${content}'/>','totalPoints':'<c:out value='${totalPoints}'/>'});" />

							<input type="hidden" id='quantity_<c:out value="${orderItem.productId}"/>' name='quantity_<c:out value="${orderItem.productId}"/>' type="tel" aria-labelledby="Quantity_ACCE_Message" value='<c:out value="${quickCartOrderItemQuantity}"/>' />

						</c:otherwise>
					</c:choose>
				</p>
			</td>
			<%-- <td id="WC_OrderItemDetailsf_td_3_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> each" headers="shoppingCart_tableCell_each shoppingCart_rowHeader_product<c:out value='${status.count}'/>">

				unit price column of order item details table
				shows unit price of the order item
				<span class="price">
					<fmt:formatNumber var="formattedUnitPrice" value="${orderItem.unitPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
					<c:out value="${formattedUnitPrice}" escapeXml="false" />
					<c:out value="${CurrencySymbol}"/>
				</span>

			</td>
 --%>			<td id="WC_OrderItemDetailsf_td_4_<c:out value='${status.count}'/>" class="<c:out value="${nobottom}"/> total min-800" headers="shoppingCart_tableCell_total shoppingCart_rowHeader_product<c:out value='${status.count}'/>">
				<c:choose>
					<c:when test="${orderItem.freeGift}">
						<%-- the OrderItem is a freebie --%>
						<span class="details">
							<fmt:message bundle="${storeText}" key="OrderSummary_SHOPCART_FREE" />
						</span>
					</c:when>
					<c:otherwise>
						<span class="price">
							<fmt:formatNumber var="totalFormattedProductPrice" value="${orderItem.orderItemPrice}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
							<c:out value="${totalFormattedProductPrice}" escapeXml="false" />
							<c:out value="${CurrencySymbol}"/>
						</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:remove var="nobottom"/>
		<%-- row to display product level discount --%>
		<c:if test="${!empty orderItem.adjustment}">
			<jsp:useBean id="aggregatedDiscounts" class="java.util.HashMap" scope="page" />
			<jsp:useBean id="discountReferences" class="java.util.HashMap" scope="page" />

			<%-- Loop through the discounts, summing discounts with the same code --%>
			<c:forEach var="discounts" items="${orderItem.adjustment}">
				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<c:set property="${discounts.code}" value="${discounts}" target="${discountReferences}"/>
					<c:if test="${empty aggregatedDiscounts[discounts.code]}">
						<c:set property="${discounts.code}" value="0" target="${aggregatedDiscounts}"/>
					</c:if>
					<c:set property="${discounts.code}" value="${aggregatedDiscounts[discounts.code]+discounts.amount}" target="${aggregatedDiscounts}"/>
				</c:if>
			</c:forEach>

			<c:forEach var="discountsIterator" items="${discountReferences}" varStatus="status2">
				<c:set var="discounts" value="${discountsIterator.value}" />
				<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
				<c:if test="${discounts.displayLevel == 'OrderItem'}">
					<tr>
						<th colspan="4" class="th_align_left_dotted_top_solid_bottom" abbr="<fmt:message bundle="${storeText}" key="Checkout_ACCE_prod_discount" /> <c:out value="${fn:replace(cartItemName, search, replaceStr)}" escapeXml="false"/>" id="shopcart_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<div class="itemspecs" id="WC_OrderItemDetailsf_div_3_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
								<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
									<c:param name="code" value="${discounts.code}" />
									<c:param name="langId" value="${langId}" />
									<c:param name="storeId" value="${WCParam.storeId}" />
									<c:param name="catalogId" value="${WCParam.catalogId}" />
								</c:url>
								<a class="discount hover_underline" href='<c:out value="${DiscountDetailsDisplayViewURL}" />' id="WC_OrderItemDetails_Link_ItemDiscount_1_<c:out value='${status2.count}'/>">
									<img src="<c:out value="${jspStoreImgDir}" />images/empty.gif" alt="<fmt:message bundle="${storeText}" key="Checkout_ACCE_prod_discount" /> <c:out value="${fn:replace(catalogEntry.description.name, search, replaceStr)}" escapeXml="false"/>"/>
									<c:out value="${discounts.description}" escapeXml="false"/>
								</a>
								<br />
							</div>
						</th>
						<td id="WC_OrderItemDetailsf_td_5_<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>" class="th_align_left_dotted_top_solid_bottom total min-800" headers="shopcart_rowHeader_discount<c:out value='${status.count}'/>_<c:out value='${status2.count}'/>">
							<fmt:formatNumber	var="formattedDiscountValue" value="${aggregatedDiscounts[discounts.code]}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
							<c:out value="${formattedDiscountValue}" escapeXml="false" />
							<c:out value="${CurrencySymbol}"/>
							<br />
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<c:remove var="aggregatedDiscounts"/>
			<c:remove var="discountReferences"/>
		</c:if>
		<c:remove var="catEntry"/>
	</c:forEach>
	
	<script type="text/javascript">
		var products = new Array(10);
	    var productDetails = JSON.parse('${itemDetailsInThisOrder}'.replace(/([{,]\s*)(\d+)*=/g, "$1\"$2\":"));
	    var count = 0;
	    JSON.parse('${pagorder.orderItem}').forEach(myFunction);
	    if (count > 0) {
		    pushProductsBatch(products);
	    }
	    function myFunction(item, index) {
		    count++;
		    var categElement = document.getElementById('itemCategory_' + item.productId);
			var cat = '';
			if (typeof(categElement) != 'undefined' && categElement != null) {
				cat = categElement.value.replace("$", "");
			}
		    var product = {
			    'name': productDetails[item.productId].name,
			    'id': item.partNumber,//SKU
			    'price': item.unitPrice,
			    'brand': productDetails[item.productId].manufacturer,
			    'variant': '',
			    'category': cat,
			    'quantity': item.unitQuantity
		    };
		    products[index%10]= product;
		    if (count==10) {
			    pushProductsBatch(products);
			    products = new Array(10);
			    count = 0;
		    }
	    }
	    function pushProductsBatch(productsArray) {
	    	console.log('products :', productsArray);
		    dataLayer.push({
			    'event': 'checkout',
			    'ecommerce': {
				    'checkout': {
					    'actionField': {'step': 1},
					    'products': productsArray
				     }
			     }
		    });
	    }	   
		function gtmRemoveFromCart(name, id, price, manufacturer, quantity, productId) {
			var categElement = document.getElementById('itemCategory_' + productId);
			var cat = '';
			if (typeof(categElement) != 'undefined' && categElement != null) {
				cat = categElement.value.replace("$", "");
			}
			dataLayer.push({
				'event': 'removeFromCart',
				'ecommerce': {
					'remove': {
						'products': [{
							'name': name,
							'id': id,
							'price': price,
							'brand': manufacturer,
							'variant': '',
							'category': cat,
							'quantity': 1
						}]
					}
				}
			});
		}
	
		function gtmProductClick(name, id, price, manufacturer, quantity, productId, position, pdpUrl) {
			try {
				var categElement = document.getElementById('itemCategory_' + productId);
				var cat = '';
				if (typeof(categElement) != 'undefined' && categElement != null) {
					cat = categElement.value.replace("$", "");
				}
				dataLayer.push({
					'event': 'itemClick',
					'ecommerce': {
						'click': {
							'actionField': {'list': 'Current Order'}, // List name from previous step
							'products': [{
								'name': name,
								'id': id,
								'price': price,
								'brand': manufacturer,
								'category': cat,
								'list': 'Current Order',
								'variant': '',
								'position': position
							}]
						}
					}
				});
			} catch(err) {
				console.log('GTM Current Order Page Product Click Error : ', err);
			} finally {
				window.location.href = pdpUrl;	
			}
		}
	</script>
	<c:remove var="itemDetailsInThisOrder"/>
	<c:if test="${parentCatalogEntrysMap != null }">
		<c:forEach var="parentCatalogEntry" items="${parentCatalogEntrysMap}" >
			<c:if test="${not empty parentCatalogEntry.value.partNumber }" >
				<c:choose>
					<c:when test="${empty order_partnumbers}" >
						<c:set var="order_partnumbers" value="${parentCatalogEntry.value.partNumber}" />
					</c:when>
					<c:otherwise>
						<c:set var="order_partnumbers" value="${order_partnumbers}|${parentCatalogEntry.value.partNumber}" />
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</c:if>

	<script type="text/javascript">
		$(document).ready(function() {
			wcTopic.publish("order_contents_ProductRec", "<c:out value='${order_partnumbers}'/>");
		});
	</script>
	<c:remove var="order_partnumbers"/>

	<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
	<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>

	<c:forEach var="paymentInstance" items="${paymentInstruction.paymentInstruction}">
		<c:if test="${!empty existingPaymentInstructionIds}">
			<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds},"/>
		</c:if>
		<c:set var="existingPaymentInstructionIds" value="${existingPaymentInstructionIds}${paymentInstance.piId}"/>
	</c:forEach>
	<input type="hidden" name="existingPaymentInstructionId" value="<c:out value="${existingPaymentInstructionIds}"/>" id="existingPaymentInstructionId"/>

	<%-- If there are more than pageSize items in the order, we need to call another service to find out the non recurring order items in the order --%>
	<c:if test="${numEntries > pageSize}">
		<wcf:rest var="nonRecOrder" url="store/{storeId}/cart/@self">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
			<wcf:param name="pageSize" value="${pageSize}"/>
			<wcf:param name="pageNumber" value="1"/>
			<wcf:param name="sortOrderItemBy" value="orderItemID"/>
		</wcf:rest>
		<c:set var="totalNonRecItemsInOrder" value="0"/>
		<c:set var="allNonRecOrderItemIds" value=""/>
		<c:forEach var="nonRecOrderItem" items="${nonRecOrder.orderItem}" varStatus="nonRec_status">
			<c:if test="${!empty allNonRecOrderItemIds}">
				<c:set var="allNonRecOrderItemIds" value="${allNonRecOrderItemIds},"/>
			</c:if>
			<c:set var="allNonRecOrderItemIds" value="${allNonRecOrderItemIds}${nonRecOrderItem.orderItemId}"/>
			<c:set var="totalNonRecItemsInOrder" value="${totalNonRecItemsInOrder+1}"/>
		</c:forEach>
		<c:set var="nonRecurringOrderItems" value="${allNonRecOrderItemIds}"/>
		<c:set var="nonRecurringOrderItemsCount" value="${totalNonRecItemsInOrder}"/>
	</c:if>

	<input type="hidden" name="currentOrderId" value="<c:out value="${pagorder.orderId}"/>" id="currentOrderId"/>
	<input type="hidden" name="numOrderItemsInOrder" value="<c:out value="${numEntries}"/>" id="numOrderItemsInOrder"/>
	<input type="hidden" name="nonRecurringOrderItems" value="<c:out value="${nonRecurringOrderItems}"/>" id="nonRecurringOrderItems"/>
	<input type="hidden" name="nonRecurringOrderItemsCount" value="<c:out value="${nonRecurringOrderItemsCount}"/>" id="nonRecurringOrderItemsCount"/>
 </table>

<c:if test="${numEntries > pageSize}">
	<div id="ShopcartPaginationText2">
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
							<a id="ShopcartPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_1'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex - pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText2_1" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_1'); if(submitRequest()){ cursor_wait();
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
							<a id="ShopcartPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_2'); if(submitRequest()){ cursor_wait();
						wc.render.updateContext('PendingOrderPaginationDisplay_Context',{'beginIndex':'<c:out value='${beginIndex + pageSize}'/>','pageSize':'<c:out value='${pageSize}'/>'});}}">

					</c:when>
					<c:otherwise>
						<a id="ShopcartPaginationText2_2" href="javaScript:if(!CheckoutHelperJS.checkForDirtyFlag()){setCurrentId('ShopcartPaginationText2_2'); if(submitRequest()){ cursor_wait();
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
</c:if>

<flow:ifEnabled feature="Analytics">
	<script type="text/javascript">
		$(document).ready(function() {
			analyticsJS.storeId="<c:out value="${WCParam.storeId}" />";
			analyticsJS.catalogId="<c:out value="${WCParam.catalogId}" />";
			analyticsJS.publishCartView();
		});
	</script>
</flow:ifEnabled>


<!-- loyalty changes start -->

<c:if test="${loyTotalPoints > 0 || redeemTotalPoints > 0}">
	<c:choose>
		<c:when test="${(loyTotalPoints - redeemTotalPoints) < 0}">
			<div class="reward-points-checkout ">
				<span class="reward-text-checkout">
					<span class="aro-left-teward">
						With this order 
						<span style="text-decoration: underline;">
						<c:set var="redPoint" value"${redeemTotalPoints - loyTotalPoints}"  scope="session"/>
							<c:out value"${redeemTotalPoints - loyTotalPoints}" /> Points
						</span>
						will be Redeemed from your total Loyalty points
					</span>
				</span>
			</div>
		</c:when>
		<c:when test="${(loyTotalPoints - redeemTotalPoints) > 0}">
			<div class="reward-points-checkout ">
				<span class="reward-text-checkout">
					<span class="aro-left-teward">
						With this order you will earn 
						<span style="text-decoration: underline;">
						<c:set var="redPoint" value"0"  scope="session"/>
							<c:out value"${loyTotalPoints - redeemTotalPoints}" /> Reward Points
						</span>
						towards your total
					</span>
				</span>
			</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</c:if>

<!-- loyalty changes end -->
<!-- END OrderItemDetail.jsp -->
