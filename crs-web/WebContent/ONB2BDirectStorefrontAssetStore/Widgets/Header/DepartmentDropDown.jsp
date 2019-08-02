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

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<c:set var="departmentId" value="${param.categoryId}"/>
<c:set var="uniqueID" value="${param.uniqueID}"/>
<c:set var="subcategoryLimit" value="50"/>
<c:set var="depthAndLimit" value="${subcategoryLimit + 1},${subcategoryLimit + 1}"/>
<wcf:rest var="categoryHierarchy" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/@top" >
	<c:if test="${!empty WCParam.langId}">
	<wcf:param name="langId" value="${WCParam.langId}"/>
	</c:if>
	<c:if test="${empty WCParam.langId}">
	<wcf:param name="langId" value="${langId}"/>
	</c:if>

	<wcf:param name="responseFormat" value="json"/>		
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="depthAndLimit" value="${depthAndLimit}"/>
	<c:forEach var="contractId" items="${env_activeContractIds}">
		<wcf:param name="contractId" value="${contractId}"/>
	</c:forEach>
</wcf:rest>


<jsp:useBean id="categoryURLMap" class="java.util.HashMap"/>

<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
		<wcf:url var="categoryURL" value="Category3" patternName="CanonicalCategoryURL">
			<wcf:param name="storeId" value="${storeId}"/>
			<wcf:param name="catalogId" value="${catalogId}"/>		
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="urlLangId" value="${urlLangId}"/>
			<wcf:param name="categoryId" value="${department.uniqueID}"/>
			<wcf:param name="pageView" value="${env_defaultPageView}"/>
			<wcf:param name="beginIndex" value="0"/>
		</wcf:url>	
		<c:set target="${categoryURLMap}" property="${department.uniqueID}" value="${categoryURL}"/>
		<c:forEach var="category" items="${department.catalogGroupView}">
			<wcf:url var="categoryURL" value="Category3" patternName="CategoryURL">
				<wcf:param name="storeId" value="${storeId}"/>
				<wcf:param name="catalogId" value="${catalogId}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="urlLangId" value="${urlLangId}"/>
				<wcf:param name="categoryId" value="${category.uniqueID}"/>
				<wcf:param name="top_category" value="${department.uniqueID}"/>
				<wcf:param name="pageView" value="${env_defaultPageView}"/>
				<wcf:param name="beginIndex" value="0"/>
			</wcf:url>			
			<c:set target="${categoryURLMap}" property="${department.uniqueID}_${category.uniqueID}" value="${categoryURL}"/>
			<c:forEach var="subcategory" items="${category.catalogGroupView}">
				<wcf:url var="categoryURL" value="Category3" patternName="CategoryURLWithParentCategory">
					<wcf:param name="storeId" value="${storeId}"/>
					<wcf:param name="catalogId" value="${catalogId}"/>
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="urlLangId" value="${urlLangId}"/>
					<wcf:param name="categoryId" value="${subcategory.uniqueID}"/>
					<wcf:param name="parent_category_rn" value="${category.uniqueID}"/>
					<wcf:param name="top_category" value="${department.uniqueID}"/>
					<wcf:param name="pageView" value="${env_defaultPageView}"/>
					<wcf:param name="beginIndex" value="0"/>
				</wcf:url>
				<c:set target="${categoryURLMap}" property="${department.uniqueID}_${category.uniqueID}_${subcategory.uniqueID}" value="${categoryURL}"/>
			</c:forEach>
		</c:forEach>	
</c:forEach>

<div class="main-category-mobile-menu show-for-mobile-menu">
   <!-- <ul class="cd-dropdown-gallery is-hidden fade-out">
		<li> <a href="#">OFFICE SUPPLIES</a>	</li>
		<li> <a href="#">INKS &amp; TONERS</a> </li>
		<li> <a href="#">PAPER</a></li>
		<li><a href="#">TECHNOLOGY</a></li>
		<li><a href="#">FURNITURE</a>	</li>
		<li><a href="#">FACILITIES SUPPLIES</a></li>				
		<li><a href="#">WORKWEAR</a></li>
		<li><a href="#">PRINT &amp; PROMOTION</a></li>
		<li><a href="#">OfficeBrands Products</a></li>
	</ul> -->
	<ul class="cd-dropdown-gallery is-hidden fade-out">
		<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}" end="7">
			<li>
				<a class="head_link" href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}"><c:out value="${department.name}"/></a>
			</li>			
		</c:forEach>
		<li>
			<a>VIEW MORE</a>
			<ul>
				<li><a href="#0">Back</a></li>					
				<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
					<li>
						<a href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}" ><c:out value="${department.name}"/></a>
					</li>
				</c:forEach>
			</ul>
		</li>
	</ul>
</div>

<div class="cd-dropdown-wrapper">
	<div id="Products-Menu" class="hide-for-mobile-menu"></div>
	<nav class="cd-dropdown">		
		<a href="#0" class="cd-close">Close</a>
		<ul class="cd-dropdown-content">
			<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}" end="7">
				<li class="hide-for-mobile-menu">
					<a class="head_link" href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}"><c:out value="${department.name}"/></a>
					
					<ul class="cd-dropdown-gallery is-hidden">
						<c:forEach var="category" items="${department.catalogGroupView}" >
							<c:set var="key" value="${department.uniqueID}_${category.uniqueID}"/>
							<li><a href="${fn:escapeXml(fn:replace(categoryURLMap[key],'http://','https://'))}"><c:out value="${category.name}"/></a></li>
						</c:forEach>
					</ul> 
				</li>
				<li class="has-children show-for-mobile-menu">
					<a href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}"><c:out value="${department.name}"/></a>
					
					<ul class="cd-dropdown-gallery is-hidden">
						<li class="go-back"><a href="#0">Back</a></li>
						<li><a href="${fn:escapeXml(categoryURLMap[department.uniqueID])}"><h3><c:out value="${department.name}"/></h3></a></li>
						<c:forEach var="category" items="${department.catalogGroupView}" end="${subcategoryLimit - 1}" >
							<c:set var="key" value="${department.uniqueID}_${category.uniqueID}"/>
							<li><a href="${fn:escapeXml(categoryURLMap[key])}"><h3 style="color:#666666"><c:out value="${category.name}"/></h3></a></li>
						</c:forEach>
					</ul> 
				</li>
			</c:forEach>
			<li class="has-children">
				<a class="head_link"  >VIEW MORE</a>
				<ul class="cd-dropdown-gallery is-hidden">
					<li class="go-back"><a href="#0">Back</a></li>					
					<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
						<c:if test="${department.name ne 'U REWARDS'}">
							<li>
								<a href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}" ><c:out value="${department.name}"/></a>
							</li>
						</c:if>
						<c:if test="${department.name eq 'U REWARDS' && !empty sessionScope.loyaltyEnabled && sessionScope.loyaltyEnabled eq 'true'}">
							<li>
								<a href="${fn:escapeXml(fn:replace(categoryURLMap[department.uniqueID],'http://','https://'))}" ><c:out value="${department.name}"/></a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</li>
		</ul> 
	</nav> 
</div>
