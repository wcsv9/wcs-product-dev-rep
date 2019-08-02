<!doctype HTML>
<!-- BEGIN ContractAndUserAdminPannel.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE HTML>

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

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${contentPageName}</title>
	
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}css/store.css"/>" type="text/css" media="screen"/>

		<!-- Include script files -->
		<%@ include file="../Common/CommonJSToInclude.jspf"%>
		
		
		<wcf:url var="ContractAdminPannelView" value="ContractAdminPannelView" type="Ajax">
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				
		</wcf:url>	
		
		<%--<script type="text/javascript" src="${staticAssetContextRoot}${env_siteWidgetsDir}Common/javascript/WidgetCommon.js"></script>--%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Admin/AdminPannel.js"/>"></script>		
		<script type="text/javascript">  
		$(document).ready(function () { 
			CommonContextsJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
			CommonControllersDeclarationJS.setRefreshURL('contractUserAdminArea','<c:out value="${ContractAdminPannelView}"/>');
			
			AdminPannelJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
			
			AdminPannelJS.getContractAndUserPannel('','contract');
			//parseWidget("contractUserAdminArea");
			
			//AdminPannelJS.setContract('contracts');
										
			<fmt:message key="ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS" bundle="${storeText}" var="ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS"/>
			MessageHelper.setMessage("ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS","<c:out value='${ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS}'/>");
		});
		</script>			
	
	</head>
	
	<body>
		<!-- Page Start -->
		<div id="page" class="nonRWDPage">
			<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
			<div id="wrapper" class="ucp_active">
				<div class="highlight">
					<!-- Header Widget -->
					<div id="headerWrapper">
						<%out.flush();%>
						<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
						<%out.flush();%>
					</div>
				</div>
			</div>
			<!-- Main Content Start -->
			<div id="contentWrapper">
				<div id="tabsSection">
					<div id="tabs" role="main">
						<a id="ConAdd" class="ContractManagement active" onclick="javascript:AdminPannelJS.ConAdd('ConAdd','UserAdd');AdminPannelJS.getContractAndUserPannel('','contract');">Contract Management</a>
						<a id="UserAdd" class="UserManagement" onclick="javascript:AdminPannelJS.ConAdd('UserAdd','ConAdd');AdminPannelJS.getContractAndUserPannel('','user');">User Management</a>
						<div style="clear:both;"></div>
					</div>	
					
					<div wcType="RefreshArea" widgetId="contractUserAdminArea"  id="contractUserAdminArea" declareFunction="CommonControllersDeclarationJS.declarecontractUserAdminController()"
					ariaMessage="<fmt:message bundle="${storeText}" key="ACCE_Status_Order_Item_List_Updated" />"
					ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="OrderConfirmPagingDisplay_ACCE_Label">
						<%out.flush();%>					

							<c:import url="${env_jspStoreDir}Admin/ContractAdminPannel.jsp">
								<c:param name="flags" value="${WCParam.flags}"/>
								<c:param name="addFlag" value="${WCParam.addFlag}"/>
								<c:param name="addValue" value="${WCParam.addValue}"/>
								<c:param name="usrId" value="${WCParam.usrId}"/>
								<c:param name="contractName" value="${WCParam.contractName}"/>
								<c:param name="contractId" value="${WCParam.contractId}"/>
								<c:param name="storeIds" value="${WCParam.storeIds}"/>
								<c:param name="storeName" value="${WCParam.storeName}"/>
								<c:param name="orgId" value="${WCParam.orgId}"/>
								<c:param name="usId" value="${WCParam.usId}"/>
							</c:import>
						<%out.flush();%>
					</div>					
				</div>
				
			</div>
				<!-- Footer Widget -->
				<div class="highlight">
					<div id="footerWrapper">
						<%out.flush();%>
						<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
						<%out.flush();%>
					</div>
				</div>		
		</div>	
		<!-- Main Content End -->	
		
		
	</body>
</html>	



<!-- END ContractAndUserAdminPannel.jsp -->