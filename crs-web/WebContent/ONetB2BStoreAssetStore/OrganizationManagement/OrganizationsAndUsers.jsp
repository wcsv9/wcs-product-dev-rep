<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<fmt:message bundle="${storeText}" key="ORGANIZATIONMANAGE_ORGS_AND_USERS" var="contentPageName" scope="request"/>
<c:set var="pageCategory" value="MyAccount" scope="request"/>

<!DOCTYPE HTML>

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

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@ include file="../Common/CommonCSSToInclude.jspf"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${contentPageName}</title>

		<!-- Include script files -->
		<%@ include file="../Common/CommonJSToInclude.jspf"%>
		<script type="text/javascript">  
		$(document).ready(function() {
			<fmt:message key="ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS" bundle="${storeText}" var="ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS"/>
			MessageHelper.setMessage("ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS","<c:out value='${ORGANIZATIONUSERSLIST_UPDATE_USERSTATUS_SUCCESS}'/>");
		
			var deviceAgent = navigator.userAgent.toLowerCase();
			var agentID = deviceAgent.match(/(iphone|ipod|ipad)/);
		    var is_safari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);

			//var is_iPad = navigator.userAgent.match(/iPad/i) != null;
			if(agentID){
				$(".getTabAndContents .tabs").css("margin-top", "5px"); 
				$(".getTabAndContents .tabs").css("margin-bottom", "0px"); 
				 
			}
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
				<div id="content" role="main">
					<div class="rowContainer" id="container_orgUserList_detail">
						<div class="row margin-true">
							<!-- breadcrumb -->
							<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">  
									<wcpgl:param name="pageGroup" value="Content" />
									<wcpgl:param name="doNotCacheForMyAccount" value="true"/>
								</wcpgl:widgetImport>
							<%out.flush();%>
							<div class="col12"></div>
						</div>
										
						<div class="row margin-true">
							<!-- Left Nav -->
							<%-- <div class="col4 acol12 ccol3">
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
								<%out.flush();%>	
							</div> --%>
							
							<!-- Content area -->
							<div class="col12 acol12 ccol12 right">
								<div >	
									
								</div>	
								
								
				<div class="row headInsideMenu">
					<div class="col1">&nbsp;</div>
					<div class="col10 userIconLine">
						<div class="organizationAndUserIcon"> </div>
						<hr>
					</div>
					<div class="col1">&nbsp;</div>
				<div class="col12"><p>${contentPageName}</p></div>
				<div class="col12 links">
					<div class="normalMenu" id="accDetailMenu">
						<%out.flush();%>
					        <c:import url="${env_jspStoreDir}Common/MyAccountPageURLs.jsp"/>
					    <%out.flush();%>
					</div>
				</div>
				</div>	
							
				 
							<div class="row margin-true">
			<div class="col12 center-align company-details-accounts" data-slot-id="4">
			
				<div class="container getTabAndContents">
					<ul class="tabs">
						<li class="tab-link current" data-tab="cd_tab-1">Organization</li>
						<li class="tab-link" data-tab="cd_tab-2">User</li>
						
					</ul>
						<div id="cd_tab-1" class="tab-content">
						
								<div>
								<%out.flush();%>
										<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationList/OrganizationList.jsp">
											<wcpgl:param name="showOrgSummary" value="true"/>
										</wcpgl:widgetImport>
									<%out.flush();%>
								</div>
								
					</div>
					<div id="cd_tab-2" class="tab-content">
								<div>
			
									<%out.flush();%>
		
										<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationUsersList/OrganizationUsersList.jsp"/>
									<%out.flush();%>
								</div>
					</div>
					</div>
			</div>
			</div>
 <script>
$(document).ready(function(){
	$('#cd_tab-3').removeClass('current');
	$('#cd_tab-1').addClass('current');
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})
</script>
							
							
									
								
								
							
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
			</div>				
			<!-- Main Content End -->

			<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
			<%@ include file="../Common/JSPFExtToInclude.jspf"%>
		</div>
	</body>
</html>
