<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>

<!-- BEGIN SiteMap.jsp -->

<%@ include file="../Common/EnvironmentSetup.jspf"%>
<%@ include file="../include/ErrorMessageSetup.jspf"%>
<%@ include file="../Common/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>

<wcf:rest var="getPageResponse" url="store/{storeId}/page/name/{name}">
	<wcf:var name="storeId" value="${storeId}" encode="true" />
	<wcf:var name="name" value="HomePage" encode="true" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="profileName" value="IBM_Store_Details" />
</wcf:rest>
<c:set var="page" value="${getPageResponse.resultList[0]}" />

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="q" value="byObjectIdentifier" />
	<wcf:param name="objectIdentifier" value="${page.pageId}" />
	<wcf:param name="deviceClass" value="${deviceClass}" />
	<wcf:param name="pageGroup" value="Content" />
</wcf:rest>
<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}"
	scope="request" />
<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign"
	scope="request" />


<c:set var="pageTitle" value="Site Map" />

<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription"
	value="${page.fullImageAltDescription}" scope="request" />
<c:set var="pageCategory" value="Browse" scope="request" />

<wcf:url var="BlogListView" value="BlogListView">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	<flow:ifEnabled feature="FacebookIntegration">
		<%-- Facebook requires this to work in IE browsers --%>
		xmlns:fb="http://www.facebook.com/2008/fbml" 
		xmlns:og="http://opengraphprotocol.org/schema/"
	</flow:ifEnabled>
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}"
	xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><c:out value="${pageTitle}" /></title>
<meta name="description" content="<c:out value="${metaDescription}"/>" />
<meta name="keywords" content="<c:out value="${metaKeyword}"/>" />
<meta name="pageIdentifier" content="HomePage" />
<meta name="pageId" content="<c:out value="${page.pageId}"/>" />
<meta name="pageGroup" content="content" />

<link rel="canonical" href="<c:out value="${env_TopCategoriesDisplayURL}"/>" />

<!--Main Stylesheet for browser -->
<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}"
	type="text/css" media="screen" />
<link rel="stylesheet" href="${jspStoreImgDir}css/maps.css"
	type="text/css" media="screen" />
<!-- Style sheet for print -->
<link rel="stylesheet"
	href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css"
	media="print" />

<!-- Include script files -->
<%@ include file="../Common/CommonCSSToInclude.jspf"%>
<%@include file="../Common/CommonJSToInclude.jspf"%>

<script type="text/javascript"
	src="${jsAssetsDir}javascript/CommonContextsDeclarations.js"></script>
<script type="text/javascript"
	src="${jsAssetsDir}javascript/CommonControllersDeclaration.js"></script>
<script type="text/javascript"
	src="${jsAssetsDir}javascript/Widgets/collapsible.js"></script>
<script type="text/javascript">
			$(document).ready(function() { 
				shoppingActionsJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','<c:out value="${env_CurrencySymbolToFormat}" />');
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
			});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>
<wcpgl:jsInclude />

<flow:ifEnabled feature="FacebookIntegration">
	<%@include file="../Common/JSTLEnvironmentSetupExtForFacebook.jspf"%>
	<%--Facebook Open Graph tags that are required  --%>
	<meta property="og:title" content="<c:out value="${pageTitle}"/>" />
	<meta property="og:image"
		content="<c:out value="${schemeToUse}://${request.serverName}${portUsed}${jspStoreImgDir}images/logo.png"/>" />
	<meta property="og:url"
		content="<c:out value="${env_TopCategoriesDisplayURL}"/>" />
	<meta property="og:type" content="website" />
	<meta property="fb:app_id" name="fb_app_id"
		content="<c:out value="${facebookAppId}"/>" />
	<meta property="og:description" content="${page.metaDescription}" />
</flow:ifEnabled>
<script src="https://maps-api-ssl.google.com/maps/api/js?"></script>
</head>

<body>
	<%-- This file includes the progressBar mark-up and success/error message display markup --%>
	<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

	<!-- Begin Page -->
	<c:set var="layoutPageIdentifier" value="${page.pageId}" />
	<c:set var="layoutPageName" value="${page.name}" />
	<%-- <%@ include file="../Widgets_801/Common/ESpot/LayoutPreviewSetup.jspf"%> --%>

	<div id="page">
		<div id="grayOut"></div>
		<div id="headerWrapper">
			<c:set var="overrideLazyLoadDepartmentsList" value="true" scope="request" />
			<%
				out.flush();
			%>
			<c:import url="${env_jspStoreDir}Widgets/Header/Header.jsp">
				<c:param name="overrideLazyLoadDepartmentsList" value="${overrideLazyLoadDepartmentsList}" />
			</c:import>
			<%
				out.flush();
			%>
		</div>

		<div id="contentWrapper">
			<div id="content" class="sitemap" role="main">
				</br>
				<h1>Site Map</h1>
				</br>
				<div class="map-Stores">
					<h2>Stores</h2>
					
					<%-- Start: Custom Rest (Arsalan), Geeting National Acctount STORE URL --%>
					<div class="map-row-stores-top">
						<div class="store-title">Office Brands</div>
						<div class="store-url">
							<a href="http://www.officebrands.com.au/">www.officebrands.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<div class="map-row-stores">
						<div class="store-title">National Accounts</div>
							<div class="store-url">
								<c:set var="domainName" value="<%=request.getServerName() %>" />
								<c:choose>
									<c:when test="${domainName eq 'localhost'}">
										<a href="https://localhost:8443/wcs/shop/en/nationalaccount">https://localhost:8443/wcs/shop/en/nationalaccount</a>
									</c:when>
									<c:when test="${domainName eq 'obuat.net.au'}">
										<a href="https://obuat.net.au/wcs/shop/nationalaccount">https://obuat.net.au/wcs/shop/nationalaccount</a>
									</c:when>
									<c:otherwise>
										<a href="https://www.officebrands.net.au/shop/en/nationalaccount">www.officebrands.net.au</a>
									</c:otherwise>
								</c:choose>
							</div>
						<div style="clear:both"></div>
					</div>
					<%-- End: Custom Rest (Arsalan), Geeting National Acctount STORE URL --%>
					
					
					</br>
					</br>
					<%-- Start: Custom Rest (Arsalan), Geeting Office National--%>
					<div class="map-row-stores-top">
						<div class="store-title">Office National</div>
						<div style="clear: both"></div>
					</div>

					<%-- Start: Custom Rest (Arsalan), Geeting Office National Australia STORE URL--%>
					<div class="map-row-stores">
						<div class="store-title">Australia</div>
						<div class="store-url">
							<a href="https://www.officenational.com.au">www.officenational.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<wcf:rest var="siteMapsON" url="store/{storeId}/storeDetails/storeSiteMap/{storeName}" scope="request" cached="true">
						<wcf:var name="storeId" value="${storeId}" encode="true" />
						<wcf:var name="storeName" value="ON" />
					</wcf:rest>
					<c:forEach items="${siteMapsON.siteMap }" var="siteMapList"
						varStatus="index">
						<c:if test="${siteMapList.storeId ne '24101'}">
							<div class="map-row-stores">
								<div class="store-title">${siteMapList.storeName}</div>
								<div class="store-url">
									<wcf:url var="TopCategoriesDisplayURLTempForSiteMap"
										value="TopCategories1" patternName="HomePageURLWithLang">
										<wcf:param name="langId" value="${WCParam.langId}" />
										<wcf:param name="storeId" value="${siteMapList.storeId}" />
										<wcf:param name="catalogId" value="10051" />
										<wcf:param name="urlLangId" value="${urlLangId}" />
									</wcf:url>
									<c:set var="stUrl" value="${TopCategoriesDisplayURLTempForSiteMap}" />
									<a href="${stUrl}">${stUrl}</a>
								</div>
								<div style="clear: both"></div>
							</div>
						</c:if>
					</c:forEach>

					<div class="map-row-stores">
						<div class="store-title">Bolton's Office National - Ballarat</div>
						<div class="store-url">
							<a href="https://www.boltonbros.com.au">www.boltonbros.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<div class="map-row-stores">
						<div class="store-title">Downs Office Equipment & Supplies
							Office National</div>
						<div class="store-url">
							<a href="https://www.doe.com.au">www.doe.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<div class="map-row-stores">
						<div class="store-title">Micon Office National</div>
						<div class="store-url">
							<a href="https://www.miconnational.com.au">www.miconnational.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<div class="map-row-stores">
						<div class="store-title">Select Office National Bankstown</div>
						<div class="store-url">
							<a href="https://www.selectofficenational.com.au">www.selectofficenational.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<%-- End: Custom Rest (Arsalan), Geeting Office National Australia STORE URL--%>

					</br>
					</br>
					<div class="map-row-stores">
						<div class="store-title">Africa</div>
						<div class="store-url">
							<a href="https://www.officenational.co.za">www.officenational.co.za</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<%-- End: Custom Rest (Arsalan), Geeting Office National--%>

					</br>
					</br>

					<%-- Start: Custom Rest (Arsalan), Geeting Office Products Depot --%>
					<div class="map-row-stores-top">
						<div class="store-title">Office Products Depot</div>
						<div style="clear: both"></div>
					</div>

					<%-- Start: Custom Rest (Arsalan), Geeting OPD Australia STORE URL--%>
					<div class="map-row-stores">
						<div class="store-title">Australia</div>
						<div class="store-url">
							<a
								href="https://www.officeproductsdepot.com.au/shop/en/opdb2cstore">www.officeproductsdepot.com.au</a>
						</div>
						<div style="clear: both"></div>
					</div>

					<wcf:rest var="siteMapsOPD"
						url="store/{storeId}/storeDetails/storeSiteMap/{storeName}"
						scope="request" cached="true">
						<wcf:var name="storeId" value="${storeId}" encode="true" />
						<wcf:var name="storeName" value="OPD" />
					</wcf:rest>
					<c:forEach items="${siteMapsOPD.siteMap }" var="siteMapList" varStatus="index">
						<c:if test="${siteMapList.storeId ne '24101'}">
							<div class="map-row-stores">
								<div class="store-title">${siteMapList.storeName}</div>
									<div class="store-url">
										<wcf:url var="TopCategoriesDisplayURLTempForSiteMap" value="TopCategories1" patternName="HomePageURLWithLang">
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${siteMapList.storeId}" />
											<wcf:param name="catalogId" value="10051" />
											<wcf:param name="urlLangId" value="${urlLangId}"/>
										</wcf:url>
										<c:set var="stUrl" value="${TopCategoriesDisplayURLTempForSiteMap}"/>
										<a href="${stUrl}">${stUrl}</a>
									</div>
								<div style="clear:both"></div>
							</div>
						</c:if>
					</c:forEach>
					<%-- END: Custom Rest (Arsalan), Geeting OPD Australia STORE URL--%>


					</br>
					</br>
					<%-- Start: Custom Rest (Arsalan), Geeting OPD New Zealand STORE URL--%>
					<div class="map-row-stores">
						<div class="store-title">New Zealand</div>
						<div class="store-url">
							<a href="https://www.opd.co.nz/">www.opd.co.nz</a>
						</div>
						<div style="clear: both"></div>
					</div>
					<wcf:rest var="siteMapsOPDNZ"
						url="store/{storeId}/storeDetails/storeSiteMap/{storeName}"
						scope="request" cached="true">
						<wcf:var name="storeId" value="${storeId}" encode="true" />
						<wcf:var name="storeName" value="OPDNZ" />
					</wcf:rest>
					<c:forEach items="${siteMapsOPDNZ.siteMap }" var="siteMapList" varStatus="index">
						<c:if test="${siteMapList.storeId ne '24101'}">
							<div class="map-row-stores">
								<div class="store-title">${siteMapList.storeName}</div>
									<div class="store-url">
										<wcf:url var="TopCategoriesDisplayURLTempForSiteMap" value="TopCategories1" patternName="HomePageURLWithLang">
											<wcf:param name="langId" value="${WCParam.langId}" />
											<wcf:param name="storeId" value="${siteMapList.storeId}" />
											<wcf:param name="catalogId" value="24502" />
											<wcf:param name="urlLangId" value="${urlLangId}"/>
										</wcf:url>
										<c:set var="stUrl" value="${TopCategoriesDisplayURLTempForSiteMap}"/>
										<a href="${stUrl}">${stUrl}</a>
									</div>
								<div style="clear:both"></div>
							</div>
						</c:if>
					</c:forEach>
					<%-- End: Custom Rest (Arsalan), Geeting OPD New Zealand STORE URL--%>


					</br>
					</br>
					<%-- Start: Custom Rest (Arsalan), Geeting ONET STORE URL --%>
					<div class="map-row-stores-top">
						<div class="store-title">O-Net Independent Store</div>
						<div class="store-url">
							<a href="https://www.onet.net.au/">www.onet.net.au</a>
						</div>
						<div style="clear: both"></div>
					</div>

					<wcf:rest var="siteMapsONET"
						url="store/{storeId}/storeDetails/storeSiteMap/{storeName}"
						scope="request" cached="true">
						<wcf:var name="storeId" value="${storeId}" encode="true" />
						<wcf:var name="storeName" value="Onet" />
					</wcf:rest>
					<c:forEach items="${siteMapsONET.siteMap }" var="siteMapList" varStatus="index">
							<c:if test="${siteMapList.storeId ne '24101'}">
								<div class="map-row-stores">
									<div class="store-title">${siteMapList.storeName}</div>
										<div class="store-url">
											<wcf:url var="TopCategoriesDisplayURLTempForSiteMap" value="TopCategories1" patternName="HomePageURLWithLang">
												<wcf:param name="langId" value="${WCParam.langId}" />
												<wcf:param name="storeId" value="${siteMapList.storeId}" />
												<wcf:param name="catalogId" value="10051" />
												<wcf:param name="urlLangId" value="${urlLangId}"/>
											</wcf:url>
											<c:set var="stUrl" value="${TopCategoriesDisplayURLTempForSiteMap}"/>
											<a href="${stUrl}">${stUrl}</a>
										</div>
									<div style="clear:both"></div>
								</div>
							</c:if>
						</c:forEach>
						<div class="map-row-stores">
							<div class="store-title">Yallambee Investments T/A Copyline</div>
							<div class="store-url">
								<a href="https://www.copyline.com.au">copyline.com.au</a>
							</div>
							<div style="clear:both"></div>
						</div>
					</div>
					<%-- End: Custom Rest (Arsalan), Geeting ONET STORE URL --%>
					
					
					<c:set var="subcategoryLimit" value="10" />
					<c:set var="depthAndLimit" value="${subcategoryLimit + 1},${subcategoryLimit + 1},${subcategoryLimit + 1}" />
					<wcf:rest var="categoryHierarchy" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/@top">
						<c:if test="${!empty WCParam.langId}">
							<wcf:param name="langId" value="${WCParam.langId}" />
						</c:if>
						<c:if test="${empty WCParam.langId}">
							<wcf:param name="langId" value="${langId}" />
						</c:if>
						<wcf:param name="responseFormat" value="json" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="depthAndLimit" value="${depthAndLimit}" />
						<c:forEach var="contractId" items="${env_activeContractIds}">
							<wcf:param name="contractId" value="${contractId}" />
						</c:forEach>
					</wcf:rest>

					<jsp:useBean id="categoryURLMap" class="java.util.HashMap" />
					<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
						<wcf:url var="categoryURL" value="Category3" patternName="CanonicalCategoryURL">
							<wcf:param name="storeId" value="${storeId}" />
							<wcf:param name="catalogId" value="${catalogId}" />
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="urlLangId" value="${urlLangId}" />
							<wcf:param name="categoryId" value="${department.uniqueID}" />
							<wcf:param name="pageView" value="${env_defaultPageView}" />
							<wcf:param name="beginIndex" value="0" />
						</wcf:url>
						<c:set target="${categoryURLMap}" property="${department.uniqueID}" value="${categoryURL}" />
						
						<c:forEach var="category" items="${department.catalogGroupView}">
							<wcf:url var="categoryURL" value="Category3" patternName="CategoryURL">
								<wcf:param name="storeId" value="${storeId}" />
								<wcf:param name="catalogId" value="${catalogId}" />
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="urlLangId" value="${urlLangId}" />
								<wcf:param name="categoryId" value="${category.uniqueID}" />
								<wcf:param name="top_category" value="${department.uniqueID}" />
								<wcf:param name="pageView" value="${env_defaultPageView}" />
								<wcf:param name="beginIndex" value="0" />
							</wcf:url>
							<c:set target="${categoryURLMap}" property="${department.uniqueID}_${category.uniqueID}" value="${categoryURL}" />
							
							<c:forEach var="subcategory" items="${category.catalogGroupView}">
								<wcf:url var="categoryURL" value="Category3" patternName="CategoryURLWithParentCategory">
									<wcf:param name="storeId" value="${storeId}" />
									<wcf:param name="catalogId" value="${catalogId}" />
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="urlLangId" value="${urlLangId}" />
									<wcf:param name="categoryId" value="${subcategory.uniqueID}" />
									<wcf:param name="parent_category_rn" value="${category.uniqueID}" />
									<wcf:param name="top_category" value="${department.uniqueID}" />
									<wcf:param name="pageView" value="${env_defaultPageView}" />
									<wcf:param name="beginIndex" value="0" />
								</wcf:url>
								<c:set target="${categoryURLMap}" property="${category.uniqueID}_${subcategory.uniqueID}" value="${categoryURL}" />
								
								<c:forEach var="subcategorySec" items="${subcategory.catalogGroupView}">
									<wcf:url var="categoryURL" value="Category3" patternName="CategoryURLWithParentCategory">
										<wcf:param name="storeId" value="${storeId}" />
										<wcf:param name="catalogId" value="${catalogId}" />
										<wcf:param name="langId" value="${langId}" />
										<wcf:param name="urlLangId" value="${urlLangId}" />
										<wcf:param name="categoryId" value="${subcategorySec.uniqueID}" />
										<wcf:param name="parent_category_rn" value="${subcategory.uniqueID}" />
										<wcf:param name="top_category" value="${department.uniqueID}" />
										<wcf:param name="pageView" value="${env_defaultPageView}" />
										<wcf:param name="beginIndex" value="0" />
									</wcf:url>
									<c:set target="${categoryURLMap}" property="${subcategory.uniqueID}_${subcategorySec.uniqueID}" value="${categoryURL}" />
								</c:forEach>
							</c:forEach>
						</c:forEach>
					</c:forEach>
					</br>
					</br>
					<div class="map-Products">
						<h2>Products</h2>
						<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
							<div class="map-row-stores-top l1">
								<div class="store-title">
									<a href="${fn:escapeXml(categoryURLMap[department.uniqueID])}">
										<c:out value="${department.name}" />
									</a>
								</div>
								<div class="store-url">
									<a href="${fn:escapeXml(categoryURLMap[department.uniqueID])}">
										${fn:escapeXml(categoryURLMap[department.uniqueID])} </a>
								</div>
								<div style="clear: both"></div>
							</div>

							<c:if test="${!empty department.catalogGroupView}">
								<c:forEach var="category" items="${department.catalogGroupView}" end="${subcategoryLimit - 1}">
									<c:set var="key"
										value="${department.uniqueID}_${category.uniqueID}" />
									<div class="map-row-stores l2">
										<div class="store-title">
											<a href="${fn:escapeXml(categoryURLMap[key])}"> <c:out
													value="${category.name}" />
											</a>
										</div>
										<div class="store-url">
											<a href="${fn:escapeXml(categoryURLMap[key])}">
												${fn:escapeXml(categoryURLMap[key])} </a>
										</div>
										<div style="clear: both"></div>
									</div>
									<c:if test="${!empty category.catalogGroupView}">
										<c:forEach var="subcategory" items="${category.catalogGroupView}" end="${subcategoryLimit - 1}">
											<c:set var="key" value="${category.uniqueID}_${subcategory.uniqueID}" />
											<div class="map-row-stores l3">
												<div class="store-title">
													<a href="${fn:escapeXml(categoryURLMap[key])}"> <c:out value="${subcategory.name}" />
													</a>
												</div>
												<div class="store-url">
													<a href="${fn:escapeXml(categoryURLMap[key])}">
														${fn:escapeXml(categoryURLMap[key])} </a>
												</div>
												<div style="clear: both"></div>
											</div>
											<c:if test="${!empty subcategory.catalogGroupView}">
												<c:forEach var="subcategorySec" items="${subcategory.catalogGroupView}" end="${subcategoryLimit - 1}">
													<c:set var="key" value="${subcategory.uniqueID}_${subcategorySec.uniqueID}" />
													<div class="map-row-stores l4">
														<div class="store-title">
															<a href="${fn:escapeXml(categoryURLMap[key])}"> <c:out value="${subcategorySec.name}" />
															</a>
														</div>
														<div class="store-url">
															<a href="${fn:escapeXml(categoryURLMap[key])}"> ${fn:escapeXml(categoryURLMap[key])} </a>
														</div>
														<div style="clear: both"></div>
													</div>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
						</br>
					</div>
					
					<%-- Start: Custom Rest (Arsalan), Geeting MFName STORE URL--%>
					<wcf:rest var="siteMapsMFName" url="store/{storeId}/storeDetails/storeSiteMap/{storeName}" scope="request" cached="true">
						<wcf:var name="storeId" value="${storeId}" encode="true" />
						<wcf:var name="storeName" value="MFName" />
					</wcf:rest>
					<%-- Start: Custom Rest (Arsalan), Geeting MFName STORE URL --%>
					<div class="map-Brands">
						<h2>BRANDS</h2>
						<c:forEach items="${siteMapsMFName.siteMap }" var="siteMapList">
							<c:if test="${not empty siteMapList.mfName && siteMapList.mfName ne 'null'}">
								<div class="map-row-stores">
									<div class="store-title">${siteMapList.mfName}</div>
									<div class="store-url">
										<wcf:url var="CategoryNavigationResultsViewURLForSiteMap" value="SearchDisplay" type="Ajax">
											<wcf:param name="sType" value="SimpleSearch" />
											<wcf:param name="fromPage" value="catalogEntryList" />
											<wcf:param name="urlRequestType" value="Base" />
											<wcf:param name="catalogId" value="${catalogId}" />
											<wcf:param name="resultType" value="products" />
											<wcf:param name="showResultsPage" value="true" />
											<wcf:param name="pageView" value="list" />
											<wcf:param name="beginIndex" value="0" />
											<wcf:param name="resultCatEntryType" value="2" />
											<wcf:param name="langId" value="${langId}" />
											<wcf:param name="searchType" value="2" />
											<wcf:param name="pageSize" value="12" />
											<wcf:param name="manufacturer" value="${siteMapList.mfName}" />
											<wcf:param name="storeId" value="${storeId}" />											
											<wcf:param name="searchSource" value="Q" />
										</wcf:url>
										<a href="${CategoryNavigationResultsViewURLForSiteMap}">${CategoryNavigationResultsViewURLForSiteMap}</a>
									</div>
									<div style="clear: both"></div>
								</div>
							</c:if>
						</c:forEach>
					</div>
					</br>
					</br>
				</div>
			</div>

			<div id="footerWrapper">
				<%
					out.flush();
				%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp">
					<c:param name="omitHeader" value="${WCParam.omitHeader}" />
				</c:import>
				<%
					out.flush();
				%>
			</div>
		</div>

		<flow:ifEnabled feature="Analytics">
			<cm:pageview />
		</flow:ifEnabled>
		<%@ include file="../Common/JSPFExtToInclude.jspf"%>
</body>
<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}"
	pageId="${page.pageId}" />
</html>


<!-- END SiteMap.jsp -->