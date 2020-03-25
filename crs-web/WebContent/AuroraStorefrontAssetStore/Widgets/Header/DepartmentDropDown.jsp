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
<c:set var="subcategoryLimit" value="10"/>
<c:set var="depthAndLimit" value="${subcategoryLimit + 1},${subcategoryLimit + 1}"/>
<c:catch var="searchServerException">
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
</c:catch>

<jsp:useBean id="categoryURLMap" class="java.util.HashMap"/>
<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
	<c:if test="${department.uniqueID eq uniqueID}">
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
	</c:if>
</c:forEach>

<c:forEach var="department" items="${categoryHierarchy.catalogGroupView}">
	<c:if test="${department.uniqueID eq uniqueID}">
		<div class="header">
			<a id="departmentLink_${department.uniqueID}" href="${fn:escapeXml(categoryURLMap[department.uniqueID])}" class="link menuLink" aria-label="${department.name}" role="menuitem" tabindex="-1"><c:out value="${department.name}"/></a>
			<a id="departmentToggle_${department.uniqueID}" href="#" class="toggle" role="button" data-toggle="departmentMenu_${department.uniqueID}" aria-labelledby="departmentLink_${department.uniqueID}"><span role="presentation"></span></a>
		</div>
		<c:if test="${!empty department.catalogGroupView}">
			<ul class="categoryList"><c:forEach var="category" items="${department.catalogGroupView}" end="${subcategoryLimit - 1}"><li>
				<c:set var="key" value="${department.uniqueID}_${category.uniqueID}"/>
				<a id="categoryLink_${key}" href="${fn:escapeXml(categoryURLMap[key])}" aria-label="${category.name}" class="menuLink" role="menuitem" tabindex="-1"><c:out value="${category.name}"/></a>
				<c:if test="${!empty category.catalogGroupView}">
					<ul class="subcategoryList"><c:forEach var="subcategory" items="${category.catalogGroupView}" end="${subcategoryLimit - 1}"><li>
						<c:set var="key" value="${department.uniqueID}_${category.uniqueID}_${subcategory.uniqueID}"/>
						<a id="subcategoryLink_${key}" href="${fn:escapeXml(categoryURLMap[key])}" aria-label="${subcategory.name}" class="menuLink" role="menuitem" tabindex="-1"><c:out value="${subcategory.name}"/></a>
					</li></c:forEach><c:if test="${fn:length(category.catalogGroupView) > subcategoryLimit}"><li class="more">
						<c:set var="key" value="${department.uniqueID}_${category.uniqueID}"/>
						<a id="moreLink_${key}" href="${fn:escapeXml(categoryURLMap[key])}" class="menuLink" role="menuitem" tabindex="-1"><fmt:message bundle="${storeText}" key="MORE_CATEGORY"/></a>
					</li></c:if></ul>
				</c:if>
			</li></c:forEach><c:if test="${fn:length(department.catalogGroupView) > subcategoryLimit}"><li class="more">
				<a id="moreLink_${department.uniqueID}" href="${fn:escapeXml(categoryURLMap[department.uniqueID])}" class="menuLink" role="menuitem" tabindex="-1"><fmt:message bundle="${storeText}" key="MORE_CATEGORY"/></a>
			</li></c:if></ul>
		</c:if>
	</c:if>	
</c:forEach>
