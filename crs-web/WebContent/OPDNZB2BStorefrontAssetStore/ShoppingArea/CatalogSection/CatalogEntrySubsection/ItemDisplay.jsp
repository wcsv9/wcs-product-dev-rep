<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>

<!-- BEGIN ItemDisplay.jsp -->

<%-- 
  *****
  * This JSP diplay the product details given a productId or partNumber. This page imports the following components
  * Header Component - Display header links, department widget, mini shop-cart widget and Search widget
  * Product Image Component - Display the product image
  * Product Description Component - Displays product short description, attributes, inventory component, price component etc.,
  * Merchandising Association Component
  * E-spots for Recently Viewed and Recommendations
  * Product TAB component
  * Footer Component - Display footer links
  *****
--%>

<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>

<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="productId" value="${productId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:if test="${!empty productId}">
	<%-- Since this is a product page, get all the details about this product and save it in internal cache, so that other components can use it... --%>
	<c:catch var="searchServerException">
		<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${productId}" >	
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="currency" value="${env_currencyCode}"/>
			<wcf:param name="responseFormat" value="json"/>		
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<c:forEach var="contractId" items="${env_activeContractIds}">
				<wcf:param name="contractId" value="${contractId}"/>
			</c:forEach>
		</wcf:rest>
	</c:catch>
	<%-- Cache it in our internal hash map --%>
	<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
	<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>

	<wcf:rest var="getPageResponse" url="store/{storeId}/page">
		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="q" value="byCatalogEntryIds"/>
		<wcf:param name="catalogEntryId" value="${productId}"/>
	</wcf:rest>
	<c:set var="page" value="${getPageResponse.resultList[0]}"/>
	
	<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
		<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
	</c:if>
			
	
</c:if>

<c:set var="pageTitle" value="${page.title}" />
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription" value="${page.fullImageAltDescription}" scope="request" />
<c:set var="categoryId" value="${catalogNavigationView.catalogEntryView[0].parentCatalogGroupID}"/>
<c:set var="partNumber" value="${catalogNavigationView.catalogEntryView[0].partNumber}" scope="request"/>
<c:if test="${ empty partNumber}">
	<c:set var="partNumber" value="${page.partNumber}" scope="request"/>
</c:if>
<c:set var="search" value='"'/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr" value='\\\\"'/>
<c:set var="replaceStr01" value="\\\\'"/>

<c:set var="type" value="${fn:toLowerCase(catalogEntryDetails.catalogEntryTypeCode)}" />
<c:set var="type" value="${fn:replace(type,'bean','')}" />
<c:set var="pageGroup" value="Item" scope="request"/>

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<wcf:param name="objectIdentifier" value="${productId}"/>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="${pageGroup}"/>
</wcf:rest>

<%-- Special case when part of both master and sales catalog, categoryId returned is an array --%>
<c:set var="numParentCategories" value="0" />
<c:forEach var="aParentCategory" items="${categoryId}">
	<c:set var="numParentCategories" value="${numParentCategories+1}" />
</c:forEach>
<c:if test="${numParentCategories>1}">
	<c:set var="categoryId" value="${fn:split(categoryId[0], '_')[1]}"/>
</c:if>

<c:catch var="searchServerException">
	<wcf:rest var="subCategory" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${categoryId}" >	
		<wcf:param name="langId" value="${WCParam.langId}"/>
		<wcf:param name="currency" value="${env_currencyCode}"/>
		<wcf:param name="responseFormat" value="json"/>		
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<c:forEach var="contractId" items="${env_activeContractIds}">
			<wcf:param name="contractId" value="${contractId}"/>
		</c:forEach>
	</wcf:rest>
</c:catch>
<c:set var="emsNameLocalPrefix" value="${fn:replace(subCategory.catalogGroupView[0].identifier,' ','')}" scope="request"/>
<%-- Uncomment to use CatalogEntry's partnumber as the emsNameLocalPrefix
<c:set var="emsNameLocalPrefix" value="${fn:replace(partNumber,' ','')}" scope="request"/>
--%>
<c:set var="emsNameLocalPrefix" value="${fn:replace(emsNameLocalPrefix,'\\\\','')}"/>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled>
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@include file="../../../Common/CommonCSSToInclude.jspf" %>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${pageTitle}"/></title>
		<meta name="viewport" content="<c:out value="${viewport}"/>"/>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageIdentifier" content="<c:out value="${partNumber}"/>"/>
		<meta name="pageId" content="<c:out value="${productId}"/>"/>
		<meta name="pageGroup" content="<c:out value="${pageGroup}"/>"/>
		<link rel="canonical" href="<c:out value="${ProductDisplayURL}"/>" />
		
		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript">
			$(document).ready(function () { 
					shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
					<c:if test="${CommandContext.user.userId ne '-1002' && unregisterMktEvent ne '1'}">
						shoppingActionsServicesDeclarationJS.registerMarketingEvent({productId:'<c:out value="${productId}"/>',DM_ReqCmd:'ProductDisplay',storeId:'<c:out value="${storeId}"/>'});
					</c:if>
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
					document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
				</c:if>
		</script>
		
		<flow:ifEnabled feature="FacebookIntegration">
			<%@include file="../../../Common/JSTLEnvironmentSetupExtForFacebook.jspf" %>
			
			<%--Facebook Open Graph tags that are required  --%>
			<meta property="og:title" content="<c:out value="${pageTitle}"/>" />
			
			<c:choose>
				<c:when test="${!empty catalogEntryDetails.thumbnail}">
					<c:choose>
						<c:when test="${(fn:startsWith(catalogEntryDetails.thumbnail, 'http://') || fn:startsWith(catalogEntryDetails.thumbnail, 'https://'))}">
							<wcst:resolveContentURL var="imagePath" url="${catalogEntryDetails.thumbnail}" includeHostName="true"/>
						</c:when>
						<c:when test="${fn:startsWith(catalogEntryDetails.thumbnail, '/store/0/storeAsset')}">
							<c:set var="imagePath" value="${restPrefix}${catalogEntryDetails.thumbnail}" />
						</c:when>
						<c:otherwise>
							<c:set var="imagePath" value="${catalogEntryDetails.thumbnail}" />
						</c:otherwise>
					</c:choose>
				</c:when>				
				<c:when test="${!empty catalogEntryDetails.fullImage}">
					<c:choose>
						<c:when test="${(fn:startsWith(catalogEntryDetails.fullImage, 'http://') || fn:startsWith(catalogEntryDetails.fullImage, 'https://'))}">
							<wcst:resolveContentURL var="imagePath" url="${catalogEntryDetails.fullImage}" includeHostName="true"/>
						</c:when>
						<c:when test="${fn:startsWith(catalogEntryDetails.fullImage, '/store/0/storeAsset')}">
							<c:set var="imagePath" value="${restPrefix}${catalogEntryDetails.fullImage}" />
						</c:when>
						<c:otherwise>
							<c:set var="imagePath" value="${catalogEntryDetails.fullImage}" />
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:set var="imagePath" value="${jspStoreImgDir}images/logo.png" />
				</c:otherwise>
			</c:choose>
			<c:if test="${(!fn:startsWith(imagePath, 'http://') && !fn:startsWith(imagePath, 'https://'))}">
				<c:set var="imagePath" value="${schemeToUse}://${request.serverName}${portUsed}${imagePath}"/>
			</c:if>
			<meta property="og:image" content="<c:out value="${imagePath}" />"/>
			
			<meta property="og:url" content="<c:out value="${ProductDisplayURL}"/>"/>
			<meta property="og:type" content="product"/>
			<meta property="og:description" content="<c:out value="${metaDescription}"/>" />
			<meta property="fb:app_id" name="fb_app_id" content="<c:out value="${facebookAppId}"/>"/>
		</flow:ifEnabled>
	</head>
		
	<body>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
		
<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="entitledItems" value="${catalogEntryDetails.sKUs}"/>
<c:set var="numberOfSKUs" value="${catalogEntryDetails.numberOfSKUs}"/>
<c:set var="attributes" value="${catalogEntryDetails.attributes}"/>
<div id="IntelligentOfferCategoryId" style="display:none;"><c:out value="${categoryId}" /></div>
<div id="IntelligentOfferMainPartNumber" style="display:none;"><c:out value="${partNumber}" /></div>
<div id="entitledItem_<c:out value='${catalogEntryID}'/>" style="display:none;">
		[
		<c:if test="${type == 'package' || type == 'bundle' || type == 'item' || type == 'dynamickit'}">
			{
			"catentry_id" : "<c:out value='${catalogEntryID}'/>",
			"Attributes" :	{ }
			}
		</c:if>
		]
</div>

	
		<!-- Begin Page -->
		<div id="page">
			<div id="grayOut"></div>
			<div id="headerWrapper">
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
				<c:if test="${userType ne 'G'}">
					<%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.royalcyber.loyalty.point/LoyaltyHeader.jsp">
						<c:param name="storeId"   value="${storeId}"  />
						<c:param name="catalogId" value="${catalogId}"/>
						<c:param name="langId" value="${langId}" />
						<c:param name="userId" value="${CommandContext.user.userId }"/>
					</c:import>
					<%out.flush();%>
				</c:if>	
			</div>
			
			<c:choose>
				<c:when test="${empty catalogEntryDetails}">
					<wcf:url var="GenericErrorURL" value="ProductDisplayErrorView">
						<wcf:param name="catalogId" value="${catalogId}"/>
						<wcf:param name="storeId" value="${storeId}"/>
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="excMsgKey" value="_ERR_CATENTRY_NOT_EXISTING_IN_STORE"/>
					</wcf:url>
					<script type="text/javascript">
						$(document).ready(function() { 
							document.location.href = "<c:out value="${GenericErrorURL}" escapeXml="false"/>";
						});
					</script>
				</c:when>
				<c:otherwise>
					<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
					<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>
					<c:set var="rootWidget" value="${pageDesign.widget}"/>
					<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionId}" debug=false/>
				</c:otherwise>
			</c:choose>

			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
			</div>
		</div>
		
		<c:set var="layoutPageIdentifier" value="${productId}"/>
		<c:set var="layoutPageName" value="${catalogNavigationView.catalogEntryView[0].partNumber}"/>
		<%@ include file="../../../Common/LayoutPreviewSetup.jspf"%>
		
		<flow:ifEnabled feature="Analytics">
			<%@include file="../../../AnalyticsFacetSearch.jspf" %>
			<cm:product catalogNavigationViewJSON="${catalogNavigationView}" extraparms="null, ${analyticsFacet}"/>
			<cm:pageview pageType="wcs-productdetail"/>
		</flow:ifEnabled>
		<%@ include file="../../../Common/JSPFExtToInclude.jspf"%>
		
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>
		
		<!-- Get Category name for GTM -->
		<c:choose>
			<c:when test="${fn:contains(catEntry.parentCatalogGroupID,'_')}">
						<c:set var="splt" value="${fn:split(catEntry.parentCatalogGroupID[0],'_')}"/>
						<wcf:rest var="category"
							url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${splt[1] }">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="currency" value="${env_currencyCode}" />
							<wcf:param name="responseFormat" value="json" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						</wcf:rest>
						<input type="hidden" value='<c:out value="${category.catalogGroupView[0].longDescription }"/>' id='itemCategory_<c:out value="${catEntry.uniqueID}"/>_<c:out value="${position}"/>'/>		                    
			</c:when>
			<c:otherwise>
		
				<c:set var="splt" value="${catEntry.parentCatalogGroupID}"/>
				<wcf:rest var="category"
					url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${splt }">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="currency" value="${env_currencyCode}" />
					<wcf:param name="responseFormat" value="json" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				</wcf:rest>
				<input type="hidden" value='<c:out value="${category.catalogGroupView[0].longDescription }"/>' id='itemCategory_<c:out value="${catEntry.uniqueID}"/>_<c:out value="${position}"/>'/>
			</c:otherwise>
		</c:choose>  
		<!-- Get Category name for GTM -->
	</body>
	<script type="text/javascript">
	var productDetails = JSON.parse('${ catalogEntryDetails}');
	var products = new Array(1);
	var brand = '';
	if (productDetails.manufacturer) {
		brand = productDetails.manufacturer;
	}
	var cat = '';
	var catElement = document.getElementById('itemCategory_'+ productDetails.uniqueID);
	if (catElement) {
		cat = catElement.value;
	}
	var price = '';
	var priceElement = document.getElementById('ProductInfoPrice_'+ productDetails.uniqueID);
	if (!priceElement) {
		priceElement = document.getElementById('itemPrice');
	}
	if (priceElement) {
		price = priceElement.value.replace('$', '');
	}
	var product = {
		'name': productDetails.name,
		'id': productDetails.partNumber, //SKU
		'price': price,
		'brand': brand,
		'variant': '',
		'category': cat
	};
	products[0] = product;
	console.log('product : ', product);
	dataLayer.push({
		'event': 'itemView',
		'ecommerce': {
			'detail': {
			'products': products
			}
		}
	});
	
	function addToCartProductForGTM(quantity) {
		product['quantity'] = quantity;
		products[0] = product;
		console.log('product : ' , products); 
		dataLayer.push({
			'event': 'addToCart',
			'ecommerce': {
				'add': {
					'products': products
				}
			}
		});

	}
	</script>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}"/>
<!-- END ItemDisplay.jsp -->		
</html>
