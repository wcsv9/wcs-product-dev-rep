<!doctype html>
<!-- BEGIN StoreLocatorsDisplayMapView.jsp -->	
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>


<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<%@ include file="../Common/CommonCSSToInclude.jspf" %>
	<%@ include file="../Common/CommonJSToInclude.jspf" %>
	
	<script type="text/javascript">
	<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
		document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
		</c:if>
	</script>
		
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Store Locator</title>
	<meta name="description" content="<c:out value="${page.metaDescription}"/>"/>
	<meta name="keywords" content="<c:out value="${page.metaKeyword}"/>"/>
	<meta name="pageIdentifier" content="<c:out value="${pageName}"/>"/>	
	<meta name="pageId" content="<c:out value="${plPageId}"/>"/>
	<meta name="pageGroup" content="<c:out value="${requestScope.pageGroup}"/>"/>

</head>

	<body>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
				
		<div id="page">
			<div id="headerWrapper">
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
					<c:param name="omitHeader" value="${WCParam.omitHeader}" />
				</c:import>
				<%out.flush();%>
			</div>
			
			<div id="contentWrapper">
				<div id="content" role="main">
					Store Locator
				</div>
			</div>
			
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp">
					<c:param name="omitHeader" value="${WCParam.omitHeader}" />
				</c:import>
				<%out.flush();%>
			</div>
		</div>
	
	<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
	<c:set var="layoutPageName" value="${page.name}"/>
	<%@ include file="../Common/LayoutPreviewSetup.jspf"%>

	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../Common/JSPFExtToInclude.jspf"%> </body>
	<c:if test = "${!empty plPageId}">
		<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${plPageId}"/>
	</c:if>
</html>