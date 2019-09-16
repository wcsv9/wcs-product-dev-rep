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

<!DOCTYPE html>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/nocache.jspf"%>


<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<%@ include file="../../Common/CommonCSSToInclude.jspf"%>
		<title><fmt:message bundle="${storeText}" key="CONFIGURE" /></title>
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>
       </head>

	<body>

        <c:set var="hasBreadCrumbTrail" value="true" scope="request"/>

        <%@ include file="../../Common/CommonJSPFToInclude.jspf"%>
		<div id="page">
			<!-- Start Header -->
			<div class="header_wrapper_position" id="headerWidget">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
				<%out.flush();%>
			</div>
			<!-- End Header -->
			
			<%out.flush();%>
				<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OmniConfigurator/OmniConfigurator.jsp">  														
				</wcpgl:widgetImport>
				<%out.flush();%>
			
			<!--Start Footer Content-->
			<div class="footer_wrapper_position">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
				<%out.flush();%>
			</div>
			<!--End Footer Content-->
       <%@ include file="../../Common/JSPFExtToInclude.jspf"%> 
</body>
</html>
<!-- END Configure.jsp -->
      

