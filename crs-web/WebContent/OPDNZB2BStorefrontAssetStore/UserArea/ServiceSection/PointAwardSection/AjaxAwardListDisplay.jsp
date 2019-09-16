<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN AjaxAwardListDisplay.jsp -->


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<fmt:message bundle="${storeText}" key="MYACCOUNT_REQUISITION_LISTS" var="contentPageName" scope="request"/>
<c:set var="pageCategory" value="MyAccount" scope="request"/>

<!DOCTYPE HTML>





<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
    <%@ include file="../../../Common/CommonCSSToInclude.jspf"%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Reward Points</title>

    <%@ include file="../../../Common/CommonJSToInclude.jspf"%>
    <%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
	
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
	<script type="text/javascript">	
		<fmt:message key="MYACCOUNT_REQUISITIONLIST_DELETE_SUCCESS" bundle="${storeText}" var="MYACCOUNT_REQUISITIONLIST_DELETE_SUCCESS"/>
		<fmt:message key="MYACCOUNT_REQUISITIONLIST_CREATE_SUCCESS" bundle="${storeText}" var="MYACCOUNT_REQUISITIONLIST_CREATE_SUCCESS"/>
		<fmt:message key="PRODUCT_NOT_BUYABLE" bundle="${storeText}" var="PRODUCT_NOT_BUYABLE"/>
		<fmt:message key="INVALID_CONTRACT" bundle="${storeText}" var="INVALID_CONTRACT"/>
		MessageHelper.setMessage("MYACCOUNT_REQUISITIONLIST_DELETE_SUCCESS", "<c:out value='${MYACCOUNT_REQUISITIONLIST_DELETE_SUCCESS}'/>");		
		MessageHelper.setMessage("MYACCOUNT_REQUISITIONLIST_CREATE_SUCCESS", "<c:out value='${MYACCOUNT_REQUISITIONLIST_CREATE_SUCCESS}'/>");		
		MessageHelper.setMessage("PRODUCT_NOT_BUYABLE", "<c:out value='${PRODUCT_NOT_BUYABLE}'/>");
		MessageHelper.setMessage("INVALID_CONTRACT", "<c:out value='${INVALID_CONTRACT}'/>");	
	</script>
</head>

<body> 
<!-- Page Start -->
<div id="page">
	
	<div id="RequisitionListErrorMessage">
		<c:if test="${!empty errorMessage}">
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					MessageHelper.displayErrorMessage('${errorMessage}');
				});
			</script>
		</c:if>
	</div>
	 <!-- Import Header Widget -->
    <div class="header_wrapper_position" id="headerWidget">
        <%out.flush();%>
        <c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
        <%out.flush();%>
    </div>
    <!-- Header Nav End -->
	<div id="contentWrapper">
		<div id="content" role="main">		
			<div class="row margin-true">
                <div class="col12">
                    <%out.flush();%>
                        <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
                            <wcpgl:param name="pageGroup" value="Content"/>
                        </wcpgl:widgetImport>
                    <%out.flush();%>
                </div>
            </div>
			<div class="rowContainer" id="container_MyAccountDisplayB2B">
                <div class="row margin-true">
                    <%-- <div class="col4 acol12 ccol3">
                        <%out.flush();%>
                            <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
                        <%out.flush();%>
                    </div> --%>
                    <div class="col12 acol12 ccol12 right">
                        <!-- Main Content Start -->


					<div class="row headInsideMenu">
						<div class="col1">&nbsp;</div>
						<div class="col10 userIconLine">
							<div class="addressBookUserIcon"> </div>
							<hr>
						</div>
						<div class="col1">&nbsp;</div>
						<div class="col12"><p>Reward Points</p></div>
						<div class="col12 links">
							<div class="normalMenu" id="accDetailMenu">
								<%out.flush();%>
							        <c:import url="${env_jspStoreDir}Common/MyAccountPageURLs.jsp"/>
							    <%out.flush();%>
							</div>
						</div>
					</div>
						
						<div dojoType="wc.widget.RefreshArea" id="RequisitionListDisplay_Widget" controllerId="RequisitionListDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">					
							<%out.flush();%>
							<c:import url="${env_jspStoreDir}UserArea/ServiceSection/PointAwardSection/AwardListTableDisplay.jsp">
							</c:import>
							<%out.flush();%>
						</div>
						
								
									
							
						</div>
											
					</div>
				</div>
			</div>			
		</div>
		
	 <div id="overlay" class="nodisplay"></div>
    <!-- Main Content End -->	

	
	 <!-- Footer Start -->
    <div class="footer_wrapper_position">
        <%out.flush();%>
            <c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
        <%out.flush();%>
    </div>
    <!-- Footer End -->

</div><!-- end class="page" -->

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>
</html>




<!-- END AjaxAwardListDisplay.jsp -->