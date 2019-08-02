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

<!-- BEGIN BlogPage.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>

<wcf:rest var="getPageResponse" url="store/{storeId}/page/name/{name}">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:var name="name" value="HomePage" encode="true"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="profileName" value="IBM_Store_Details"/>
</wcf:rest>
<c:set var="page" value="${getPageResponse.resultList[0]}"/>

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<wcf:param name="objectIdentifier" value="${page.pageId}"/>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="Content"/>
</wcf:rest>
<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>

<c:set var="pageTitle" value="${page.title}" />
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription" value="${page.fullImageAltDescription}" scope="request" />
<c:set var="pageCategory" value="Browse" scope="request"/>
	
	
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled>
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${pageTitle}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageIdentifier" content="HomePage"/>
		<meta name="pageId" content="<c:out value="${page.pageId}"/>"/>
		<meta name="pageGroup" content="content"/>	
	    <link rel="canonical" href="<c:out value="${env_TopCategoriesDisplayURL}"/>" />
		
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>
		<!-- Blogs Styles -->
		<link rel="stylesheet" href="${jspStoreImgDir}css/blogs.css" type="text/css" media="screen"/>
		
		<!-- Include script files -->
		<%@include file="../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				shoppingActionsJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','<c:out value="${env_CurrencySymbolToFormat}" />');
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>
		<wcpgl:jsInclude/>
		
		<flow:ifEnabled feature="FacebookIntegration">
			<%@include file="../Common/JSTLEnvironmentSetupExtForFacebook.jspf" %>
			<%--Facebook Open Graph tags that are required  --%>
			<meta property="og:title" content="<c:out value="${pageTitle}"/>" /> 			
			<meta property="og:image" content="<c:out value="${schemeToUse}://${request.serverName}${portUsed}${jspStoreImgDir}images/logo.png"/>" />
			<meta property="og:url" content="<c:out value="${env_TopCategoriesDisplayURL}"/>"/>
			<meta property="og:type" content="website"/>
			<meta property="fb:app_id" name="fb_app_id" content="<c:out value="${facebookAppId}"/>"/>
			<meta property="og:description" content="${page.metaDescription}" />
		</flow:ifEnabled>
	</head>
	<body>

	<wcf:url var="BlogListViewBeyond"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="blogCategory" value="Beyond" />
	</wcf:url>
	
	<wcf:url var="BlogListViewGreen"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="blogCategory" value="Green" />
	</wcf:url>
	
	<wcf:url var="BlogListViewOrganization"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="blogCategory" value="Organization" />
	</wcf:url>
	
	<wcf:url var="BlogListViewTech"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="blogCategory" value="Tech" />
	</wcf:url>
	
	<wcf:url var="BlogListViewWellBeing"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="blogCategory" value="WellBeing" />
	</wcf:url>
	
	<wcf:url var="BlogListView"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		
	</wcf:url>
	
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
		
		<!-- Begin Page -->
		<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
		<c:set var="layoutPageName" value="${page.name}"/>
		<%@ include file="/Widgets_701/Common/ESpot/LayoutPreviewSetup.jspf"%>

		<div id="page">
			<div id="grayOut"></div>
			<div id="headerWrapper">
				<c:set var="overrideLazyLoadDepartmentsList" value="true" scope="request"/>
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
					<c:param name="overrideLazyLoadDepartmentsList" value="${overrideLazyLoadDepartmentsList}" />
				</c:import>
				<%out.flush();%>
			</div>
			<div id="contentWrapper">
				<div id="content" role="main">
				<div class="row banner-row">
					<div class="col12"> 
						<a href="<c:out value="${BlogListView}"/>">
						<h1>Blogs for Business Sucess</h1>
						</a>
					</div>
				</div>
				<div class="row Blog-menu">
					<div class="col12">
						<a href="<c:out value="${BlogListViewBeyond}"/>">BEYOND</a>	
						<a href="<c:out value="${BlogListViewGreen}"/>">GREEN</a>	
						<a href="<c:out value="${BlogListViewOrganization}"/>">ORGANISATION</a>	
						<a href="<c:out value="${BlogListViewTech}"/>">TECH</a>	
						<a href="<c:out value="${BlogListViewWellBeing}"/>">WELLBEING</a>
					</div>
				</div>

	<div class="row" style="padding: 0px 0px 30px 0px;">
		<div class="col12"> 
		
		<!-- Blogs Details IF conditions for BEYOND category -->
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row1_Col1'}">
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row1_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row1_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row1_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row1_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row1_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row2_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row2_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row2_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row2_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Beyond_List_Row2_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Beyond_List_Row2_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if>
		
		
		<!-- Blogs Details IF conditions for GREEN category -->
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row1_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row1_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row1_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row1_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row1_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row1_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row2_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row2_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row2_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row2_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Green_List_Row2_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Green_List_Row2_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if>
		
		
		<!-- Blogs Details IF conditions for ORGANIZATION category -->
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row1_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row1_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row1_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row1_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row1_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row1_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row2_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row2_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row2_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row2_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Organization_List_Row2_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Organization_List_Row2_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if>
		
		
		<!-- Blogs Details IF conditions for TECH category -->
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row1_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row1_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row1_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row1_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row1_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row1_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row2_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row2_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row2_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row2_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_Tech_List_Row2_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_Tech_List_Row2_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if>
		
		
		<!-- Blogs Details IF conditions for WELLBEING category -->
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row1_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row1_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row1_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row1_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row1_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row1_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row2_Col1'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row2_Col1_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row2_Col2'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row2_Col2_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if> 
		
		<c:if test="${WCParam.emsName eq 'Blog_WellBeing_List_Row2_Col3'}">
			
			
				  <%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
						 <c:param name="storeId" value="${WCParam.storeId}" />
						 <c:param name="emsName" value="Blog_WellBeing_List_Row2_Col3_Detail" />
						 <c:param name="numberContentPerRow" value="1" />
						 <c:param name="catalogId" value="${WCParam.catalogId}" />
						 
					</c:import>
				 <%out.flush();%>
		
		</c:if>
		
		</div>
	</div>


		
	</div>
			
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
			</div>
		</div>
		
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../Common/JSPFExtToInclude.jspf"%> </body>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${page.pageId}"/>
<!-- END BlogPage.jsp -->		



</html>
