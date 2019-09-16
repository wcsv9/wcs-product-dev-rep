<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN HomePageContainer.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div class="rowContainer home-page-Container" id="container_${pageDesign.layoutId}">
	
	<div id="hero-banner" class="row">
		<div class="col12 acol12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
	</div>
	
	<div id="espotBanner">
	<div class="col12 acol12" data-slot-id="2"><wcpgl:widgetImport slotId="2"/></div>
	</div>
	
	
	<div id="Home_products" class="bestOffer home_tabs row margin-true">
    <div class="col12 acol12 home_tabs_align_center">
		<div class="col12" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div>
	</div>
	</div>
	
	<c:if test="${WCParam.storeId ne '80355'}">
		<div class="row eNews">
			<div class="col12" id="eNews">
				<%out.flush();%>
					<c:import url="${env_jspStoreDir}Container/ENews.jsp">
						<c:param name="eNewsCall" value="eNewsHome" />
					</c:import>
				<%out.flush();%>
				<%-- <%@include file="ENews.jsp"%> --%>
			</div>
		</div>
	</c:if>
	
	<%-- <div class="row margin-true">
		<div class="col8 acol12" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
	</div> --%>
	<div id="Home_products" class="row  home_tabs" >
		<div class="col4 acol12" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
	</div>
	<div class="row row3-Home" id="row3Home">
	<div class="row3Home-center">
	<div class="col4 acol12" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
		<div class="col4 acol12" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
		<div class="col4 acol12" data-slot-id="8"><wcpgl:widgetImport slotId="8"/></div>
	</div>
	</div>
	
	
	<%--<div class="row">
		<div class="col12" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
	</div>
</div>--%>

<!-- END HomePageContainer.jsp -->
