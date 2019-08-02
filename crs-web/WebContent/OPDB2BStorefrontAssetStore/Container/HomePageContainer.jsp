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

<script>
function openPage(pageName,elmnt,color) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }
  document.getElementById(pageName).style.display = "block";
  elmnt.style.backgroundColor = color;
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
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
    <button class="tablink tab-1" onclick="openPage('HomeTab-1', this, '#5c6f7c')" id="defaultOpen">SPECIAL OFFERS</button>
	<button class="tablink tab-2" onclick="openPage('HomeTab-2', this, '#5c6f7c')" >INITIATIVE RANGE</button>
	<button class="tablink tab-3" onclick="openPage('HomeTab-3', this, '#5c6f7c')">LATEST PRODUCTS</button>
	<button class="tablink tab-4" onclick="openPage('HomeTab-4', this, '#5c6f7c')">HOTTEST PICKS</button>
	
	<div style="display: block;" id="HomeTab-1" class="col12 acol12 tabcontent" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div>
	<div id="HomeTab-2" class="col12 acol12 tabcontent" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
	<div id="HomeTab-3" class="col12 acol12 tabcontent" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
	<div id="HomeTab-4" class="col12 acol12 tabcontent" data-slot-id="12"><wcpgl:widgetImport slotId="12"/></div>
	
	</div>
	</div>

	<c:if test="${WCParam.storeId ne '80355'}">
		<div class="row eNews">
			<div class="col12" id="eNews">
				<%out.flush();%>
					<c:import url="${env_jspStoreDir}Container/ENews.jsp">
						<c:param name="eNewsCall" value="eNewsHome" />
						<c:param name="storeId" value="${WCParam.storeId}" />
					</c:import>
				<%out.flush();%>
				<%-- <%@include file="ENews.jsp"%> --%>
			</div>
		</div>
	</c:if>
	
	<%-- <div class="row margin-true">
		<div class="col8 acol12" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
	</div> --%>
	<%-- <div id="Home_products" class="row  home_tabs" >
		<div class="col4 acol12" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
	</div> --%>
	<div class="row row3-Home" id="row3Home">
	<div class="row3Home-center">
	<div class="left col4 acol12" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
	<div class="left col4 acol12" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
	<div class="left col4 acol12" data-slot-id="8"><wcpgl:widgetImport slotId="8"/></div>
	</div>
	</div>	
	
	<div class="row">
		<div class="col12" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
	</div>
	
	<div class="row margin-true brandsLogosRpw">
		<%out.flush();%>
			<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="emsName" value="Brands_Title_Home_espot" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
			</c:import>
		<%out.flush();%>	
	</div>
	
	<div class="col12 product-requirements-home">
		<%out.flush();%>
			<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="emsName" value="Requirements_Home_espot" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
			</c:import>
		<%out.flush();%>
	</div>
	
	<div style="height:20px"></div>
	<div class="row3-title">
		<div class="row">
			<div class="col12 product-requirements-home">
				<c:set var="stCity" value="${storeContact.stCity}"/>
				<%out.flush();%>
					<c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
		                <c:param name="storeId" value="${WCParam.storeId}" />
		                <c:param name="emsName" value="Dealer_info_espot" />
		                <c:param name="numberContentPerRow" value="1" />
		                <c:param name="catalogId" value="${WCParam.catalogId}" />
		                <c:param name="substitutionName1" value="[stCity]" />
		                <c:param name="substitutionValue1" value="${stCity}" />	
	            	</c:import>
	            <%out.flush();%>
	    	</div>
    	</div>
		
	</div>
	<div style="height:10px"></div>
	
</div>

<!-- END HomePageContainer.jsp -->