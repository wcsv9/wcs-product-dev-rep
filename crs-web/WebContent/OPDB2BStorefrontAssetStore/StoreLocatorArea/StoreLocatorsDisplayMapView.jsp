<!doctype html>
<!-- BEGIN StoreLocatorsDisplayMapView.jsp -->	

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../Common/EnvironmentSetup.jspf"%>
<%@ include file="../Common/nocache.jspf"%>

<c:if test="${(empty sessionScope.longitude || param.fromSearch eq 'true') && (!empty param.lng) && param.fromLink eq 'true' && param.orderId ne 'NA'}">

	<wcf:rest var="sldbStoreList" url="store/{storeId}/storeLocatorB2C/getStoreData/{state}/{zipcode}/{within}/{stateOnly}/{latitude}/{longitude}/{fromCheckout}/{city}/{storeType}" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:var name="state" value="VIC" encode="true"/>
		<c:if test="${empty WCParam.city}">
			<wcf:var name="zipcode" value="4350" encode="true"/>
			<wcf:var name="city" value="4350" encode="true"/>
		</c:if>
		<c:if test="${!empty WCParam.city}">
			<wcf:var name="zipcode" value="${WCParam.city}" encode="true"/>
			<wcf:var name="city" value="${WCParam.city}" encode="true"/>
		</c:if>
		<wcf:var name="storeType" value="10" encode="true"/>
		<c:choose>
			<c:when test="${WCParam.fromLink eq 'true'}">
				<wcf:var name="within" value="1000" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="within" value="5000000" encode="true"/>
			</c:otherwise>
		</c:choose>			
		<wcf:var name="stateOnly" value="1" encode="true"/>
			
		<c:if test="${!empty sessionScope.latitude && WCParam.fromSearch ne 'true'}">
			<wcf:var name="latitude" value="${sessionScope.latitude}" encode="true"/>
		</c:if>
		<c:if test="${!empty sessionScope.longitude && WCParam.fromSearch ne 'true'}">
			<wcf:var name="longitude" value="${sessionScope.longitude}" encode="true"/>
		</c:if>
		<c:choose>
			<c:when test="${(empty sessionScope.latitude || WCParam.fromSearch eq 'true') && WCParam.fromLink eq 'true'}">
				<wcf:var name="latitude" value="${WCParam.lat}" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="latitude" value="133.7751" encode="true"/>
			</c:otherwise>
		</c:choose>	
		<c:choose>
			<c:when test="${(empty sessionScope.longitude || WCParam.fromSearch eq 'true') && WCParam.fromLink eq 'true'}">
				<wcf:var name="longitude" value="${WCParam.lng}" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="longitude" value="25.2744" encode="true"/>
			</c:otherwise>
		</c:choose>	
		<c:if test="${WCParam.fromCheckout eq 'true'}">
			<wcf:var name="fromCheckout" value="${WCParam.fromCheckout }" encode="true"/>
		</c:if>
		<wcf:var name="assetStore" value="${WCParam.assetStore}" encode="true"/>	
	</wcf:rest>	
		
<c:forEach items="${sldbStoreList.alStoreBeans}" begin="0" var="sldbStore1" varStatus="statusCount"> 

	<c:if test="${statusCount.count eq 1}">
		<a id="setMystore123" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore1.storenumber}&shipEmail=${sldbStore1.email1}&orderItemId=${param.orderItemId}&latitude=${sldbStore1.dLatitude}&longitude=${sldbStore1.dLongitude}&storeName=${sldbStore1.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'></a>
		<script>
		document.getElementById('setMystore123').click();
		</script>
	</c:if>
</c:forEach>		
</c:if>

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
	<wcf:url var="BlogListView"  value="BlogListView">	
		<wcf:param name="urlLangId" value="${urlLangId}" />
		<wcf:param name="storeId"   value="${storeId}"  />
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}" />
		
	</wcf:url>
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
		<link rel="stylesheet" href="${jspStoreImgDir}css/store.css" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jspStoreImgDir}css/storeLocator.css" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}" type="text/css" media="print"/>
		
		<!-- Include script files -->
		<%@include file="../Common/CommonJSToInclude.jspf" %>
		
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js"></script>
		<script src="https://maps-api-ssl.google.com/maps/api/js?key=AIzaSyDTvReCzRW4OrcRngOdR5O7ImCkFMg9h3U"></script>
	   
    
		
		
		<script type="text/javascript">
		$(document).ready(function() { 
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
	
<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
	<!-- Begin Page -->
		
			<div id="page">
			<div id="grayOut"></div>
	<!-- Header Widget -->
			<div class="header_wrapper_position" id="headerWidget">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
				<%out.flush();%>
			</div>

			<div id="contentWrapper">
				<div id="content" role="main">
					<div id="store-locator">
						<div class="rowContainer" id="container_3074457345618268705">
							<div class="row breadcrumb-cat">
								<div class="col12">
									<div id="widget_breadcrumb">
										<ul aria-label="breadcrumb navigation region">
												<li><a href="#">Home</a><span class="divider" aria-hidden="true">&gt;</span></li>
											<li class="current">Store Locator</li>
										</ul>
									</div>
								</div>
							</div>	
							<div class="row margin-true">
								<div class="col12 title-desc">
									<h1>Store Locator</h1>
									<p>To proceed to checkout you will need to select a store. Find your local store here by entering your postcode.</p>
									<br/><br/>
								</div>
							</div>
							
							<div class="row margin-true">
								<div class="col4 acol12">
									<div class="find-field" >
										<h2>Find your local store</h2>
										<input type="text" name="city" id="address" placeholder="Enter your postcode to find your local store" onkeydown = "if (event.keyCode == 13)                     document.getElementById('cityGo').click()" >
										<a href="#" role="button" class="find-button" id="cityGo" onclick="initMap();">
										</a><br />
										<p>All the benefits of dealing with someone from your own community. We understand the world you live in. Being local means we can deliver your order quickly.</p>
										<div style="clear:both;"></div>
										
									</div>
									
								</div>
								
								<div class="col8">
									
								</div>
							</div>	
							<div class="row margin-true">
								<div class="col8 acol12 right">
									<div class="map">
										<div id="map_canvas"></div>
										<p id="error"></p>
									</div>
								</div>
								<div class="col4 acol12 left details-list">
								




		
   <div id="map" style="DISPLAY: NONE"></div>
      <script type="text/javascript">
		function getStateName(zipCode){
			var zCode = zipCode;
			if((zCode >= 1000 && zCode <= 2599) || (zCode >= 2620 && zCode <= 2898) || (zCode >= 2921 && zCode <= 2999)){
				zCode = zCode + ", NSW";
			}
			
			else if((zCode >= 0200 && zCode <= 0299) || (zCode >= 2600 && zCode <= 2619) || (zCode >= 2900 && zCode <= 2920)){
				zCode = zCode + ", ACT";
			}
			

			else if((zCode >= 3000 && zCode <= 3999) || (zCode >= 8000 && zCode <= 8999)){
				zCode = zCode + ", VIC";
			}
			
			else if((zCode >= 4000 && zCode <= 4999) || (zCode >= 9000 && zCode <= 9999)){
				zCode = zCode + ", QLD";
			}
			
			else if(zCode >= 5000 && zCode <= 5999){
				zCode = zCode + ", SA";
			}

			else if((zCode >= 6000 && zCode <= 6797) || (zCode >= 6800 && zCode <= 6999)){
				zCode = zCode + ", WA";
			}
			
			else if(zCode >= 7000 && zCode <= 7999){
				zCode = zCode + ", TAS";
			}
						
			else if(zCode >= 0800 && zCode <= 0999){
				zCode = zCode + ", NT";
			}
			
			else{
				zCode = zipCode;
			}
			return zCode;
		}
         function initMap() {
			/*var pCode = document.getElementById('address').value.trim();
			if(isNaN(pCode)){
				alert("Please enter a valid post code e.g. 3000 or 0801.");
				return;
			}
			if(pCode.toString().length != 4){
				alert("Please enter a valid 4 digits post code.");
				return;
			}*/
			 //   alert("Test");
				 var geocoder = new google.maps.Geocoder();
				 geocodeAddress(geocoder);
			            
         }
		
         
         function geocodeAddress(geocoder, resultsMap) {
           var zipCode = document.getElementById('address').value;
		   zipCode = getStateName(zipCode);
		   if(zipCode == ''){
			   alert('Please enter valid post code.');
			   return;
		   }
           var address = zipCode + ", Australia";         
           geocoder.geocode({
               'address': address
           }, function(results, status) {
               if (status === google.maps.GeocoderStatus.OK) {                   
                  var storeId='${param.storeId}';
                  var catalogId='${param.catalogId}';
				  var orderId='${param.orderId}';
				  var assetStore='${param.assetStore}';
				  if(orderId!='NA')
				  {
					   document.location.href ="StoreLocatorsB2CDisplayMapView?city="+zipCode+"&lat="+results[0].geometry.location.lat()+"&lng="+results[0].geometry.location.lng()+"&storeId="+storeId+"&catalogId="+catalogId+"&orderId="+${param.orderId}+"&orderItemId="+${param.orderItemId}+"&fromSearch=true&fromCheckout=true&fromLink=true&assetStore="+assetStore;
				  }
				  else{
					 document.location.href ="StoreLocatorsB2CDisplayMapView?city="+zipCode+"&lat="+results[0].geometry.location.lat()+"&lng="+results[0].geometry.location.lng()+"&storeId="+storeId+"&catalogId="+catalogId+"&orderId=NA&orderItemId=NA&fromSearch=true&fromLink=true&assetStore="+assetStore;
				  }
                
               } else {
                   alert('Geocode was not successful for the following reason: ' + status);
         
               }
           });
         
         }
          
            
      </script>	
<wcf:rest var="sldbStoreList" url="store/{storeId}/storeLocatorB2C/getStoreData/{state}/{zipcode}/{within}/{stateOnly}/{latitude}/{longitude}/{fromCheckout}/{city}/{storeType}" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
		<wcf:var name="state" value="VIC" encode="true"/>
		<c:if test="${empty WCParam.city}">
			<wcf:var name="zipcode" value="4350" encode="true"/>
			<wcf:var name="city" value="4350" encode="true"/>
		</c:if>
		<c:if test="${!empty WCParam.city}">
			<wcf:var name="zipcode" value="${WCParam.city}" encode="true"/>
			<wcf:var name="city" value="${WCParam.city}" encode="true"/>
		</c:if>
		<wcf:var name="storeType" value="10" encode="true"/>
		<c:choose>
			<c:when test="${WCParam.fromLink eq 'true'}">
				<wcf:var name="within" value="1000" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="within" value="5000000" encode="true"/>
			</c:otherwise>
		</c:choose>			
		<wcf:var name="stateOnly" value="1" encode="true"/>
			
		<c:if test="${!empty sessionScope.latitude && WCParam.fromSearch ne 'true'}">
			<wcf:var name="latitude" value="${sessionScope.latitude}" encode="true"/>
		</c:if>
		<c:if test="${!empty sessionScope.longitude && WCParam.fromSearch ne 'true'}">
			<wcf:var name="longitude" value="${sessionScope.longitude}" encode="true"/>
		</c:if>
		<c:choose>
			<c:when test="${(empty sessionScope.latitude || WCParam.fromSearch eq 'true') && WCParam.fromLink eq 'true'}">
				<wcf:var name="latitude" value="${WCParam.lat}" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="latitude" value="133.7751" encode="true"/>
			</c:otherwise>
		</c:choose>	
		<c:choose>
			<c:when test="${(empty sessionScope.longitude || WCParam.fromSearch eq 'true') && WCParam.fromLink eq 'true'}">
				<wcf:var name="longitude" value="${WCParam.lng}" encode="true"/>
			</c:when>
			<c:otherwise>
				<wcf:var name="longitude" value="25.2744" encode="true"/>
			</c:otherwise>
		</c:choose>	
		<c:if test="${WCParam.fromCheckout eq 'true'}">
			<wcf:var name="fromCheckout" value="${WCParam.fromCheckout }" encode="true"/>
		</c:if>
		<c:if test="${empty WCParam.fromCheckout}">
			<wcf:var name="fromCheckout" value="false" encode="true"/>
		</c:if>
		<wcf:var name="assetStore" value="${WCParam.assetStore}" encode="true"/>
				
	</wcf:rest>	      
  
<c:set var="userId" value="${CommandContext.user.userId}" scope="request"/>
<c:set var="userType" value="${CommandContext.user.registerType}" scope="request"/>
<c:if test="${CommandContext.user.userId eq '-1002'}">
	<c:set var="anonymousUser" value="true" scope="request"/>
</c:if>
<c:if test="${!empty CommandContext.user.displayName}">
<c:set var="userName" value="${CommandContext.user.displayName}" scope="request"/>
</c:if>

<c:set var="city" value="${param.city}" />
<c:if test="${anonymousUser eq true}">
<c:set var="userStore" value="${param.userStore}" scope="session"/>
<c:set var="userStoreSite" value="${param.userStoreSite}" scope="session"/>
<c:set var="userStoreContact" value="${param.userStoreContact}" scope="session"/>
<c:set var="userStoreDistance" value="${param.userStoreDistance}" scope="session"/>
<input type="hidden" id="userStoreName" name="userStoreName" value="${param.userStore}">
</c:if>
<%--
Hello <c:out value="${userType}"/>
Hello <c:out value="${anonymousUser}"/>
Hello ${CommandContext.user.displayName}

session value : ${sessionScope.userStore}
 --%>
 <%
String cssClass="";

%>

<form id="makeMystoreForm" action="StoreLocatorsB2CDisplayMapView?catalogId=10051&langId=-1" method="post">
	
	<input type="hidden" id="userStore" name="userStore" value="empty">
	<input type="hidden" id="userStoreID" name="userStoreID" value="<c:out value="${param.storeId}"/>">
	<input type="hidden" id="userName" name="userName" value="${CommandContext.user.displayName}">
	<input type="hidden" id="userStoreSite" name="userStoreSite" value="">
	<input type="hidden" id="userStoreContact" name="userStoreContact" value="">
	<input type="hidden" id="userStoreDistance" name="userStoreDistance" value="">

</form>

<div class="list">
	<table cellpadding="0" cellspacing="0" border="0" align="left" width="100%" id="locatorTable" class="decativated">
		<tbody>
		
		<script type="text/javascript">
   var map;
	var global_markers = [];  
	var names = [];
 	var i;
    var markers =[];
 	var values = [];
    var values1 = [];
    var valuesStoreName = [];
    var valueStoreContact = [];
    var valueStoreWebSite = [];
    var valueStoreDistance = [];
    var valueStoreZipcode = [];
    var valueStorefax=[];
    var valueStoreemail=[];
    var valueStorehours=[];
    var valueStoreAddress1=[];
	var valueCity=[];
	var valueState=[];
	var storeId=[];
	var field2=[];
	var distance;
	var allDistance;
    var valueStoreAddress1=[];
	
    		<c:forEach items="${sldbStoreList.alStoreBeans}" var="sldbStore" varStatus="statusCount"> 
			    
				
				values.push("${sldbStore.dLatitude}"); 
				values1.push("${sldbStore.dLongitude}"); 
				valueStoreWebSite.push("${sldbStore.storeWebSite}"); 
				valueStoreContact.push("${sldbStore.phone1}");
				valuesStoreName.push("${sldbStore.nickname}");
				valueStoreDistance.push("${sldbStore.distance}");
				valueStoreZipcode.push("${sldbStore.zipcode}");
				valueStorefax.push("${sldbStore.fax1}");
				valueStoreemail.push("${sldbStore.email1}");
				valueStorehours.push("${sldbStore.storehours}");
				valueStoreAddress1.push("${sldbStore.address1}");
				valueState.push("${sldbStore.state}");
				valueCity.push("${sldbStore.city}");
				storeId.push("${sldbStore.storenumber}");
				field2.push("${sldbStore.field2}");
				allDistance = "${sldbStore.distance}";				
				//alert(" VALUES => " + values[statusCount]);
			</c:forEach>
			//alert(" VALUES => " + valueStoreContact[0]);
			
			

 	for(i =0; i<values.length; i++ ){
	markers.push( [values[i], values1[i], valueStoreWebSite[i], valueStoreContact[i], valuesStoreName[i], valueStoreDistance[i],valueStoreZipcode[i],valueStorefax[i],valueStoreemail[i],valueStorehours[i],valueStoreAddress1[i],valueState[i],valueCity[i],storeId[i],field2[i] ]);
		if(i==4){
			distance = valueStoreDistance[i];
		}
	}
	if(distance == undefined || distance == 'undefined'){
		distance = allDistance;
	}
	
	
	     var i=0;
	     var c=0;
	     var marker=null;
		var infowindow = new google.maps.InfoWindow({});
		var contentString=null;
	function initialize() {
	
	
	

	
	
	
	
	
    geocoder = new google.maps.Geocoder();
    //alert(values[0]);
	//alert(values1[0]);
	var lat1='${param.lat}';
	var long1='${param.lng}';
	var latlng;
	if(values[0] == 0.0 && lat1 !='')
	{
		//alert(values[0]);
		latlng = new google.maps.LatLng(lat1, long1);
	}
	else
	{
		//alert(values[0]);
		latlng = new google.maps.LatLng(values[0], values1[0]);
	}
	
	
	var zoomValue = getZoomValue(distance);
	
    var myOptions = {
        zoom: zoomValue,        
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    //map.panTo(values[0],values1[0]);
    addMarker();
	}
	function getZoomValue(distance){
		distance = distance/1;
		if(distance >= 0 && distance < 9){
			return 13;
		}
		else if(distance >= 9 && distance < 15){
			return 12;
		}
		else if(distance >= 15 && distance < 35){
			return 11;
		}
		else if(distance >= 35 && distance < 60){
			return 10;
		}
		else if(distance >= 60 && distance < 120){
			return 9;
		}
		else if(distance >= 120 && distance < 250){
			return 8;
		}
		else if(distance >= 250 && distance < 800){
			return 7;
		}		
		else if(distance >= 800 && distance < 1400){
			return 6;
		}
		else if(distance >= 1400){
			return 4;
		}
		else{
			return 4;
		}
		
	}
  function addMarker() {
	 
    for (i = 0; i < markers.length; i++) {
        // obtain the attribues of each marker
        var lat = parseFloat(markers[i][0]);
        var lng = parseFloat(markers[i][1]);
        var trailhead_name = markers[i][2];
        var StoreContact = markers[i][3];
        var storeNames  = markers[i][4];
        var storeDistance = markers[i][5];
        var storeZipcode = markers[i][6]; 
        
        var storeFax = markers[i][7]; 
        var storeEmail = markers[i][8]; 
        var storeHours = markers[i][9]; 
        var storeAddress=markers[i][10];
		var storeState=markers[i][11];
		var storeCity=markers[i][12];
		var storeId=markers[i][13];
		var field2=markers[i][14];
        
     	 var makeYourStore = document.getElementById('displayYourStore');
       	 var storeName = document.getElementById('displayStoreName');
      	 var storeContact = document.getElementById('displayStoreContact');
     	 var storeWebSite = document.getElementById('displayStoreWebSite'); 
         var setStoreValue = document.getElementById('userStore'); 
         var userStoreSite = document.getElementById('userStoreSite'); 
         var userStoreContact = document.getElementById('userStoreContact'); 
         var userStoreDistance = document.getElementById('userStoreDistance'); 
         var displayStoreZipcode = document.getElementById('displayStoreZipcode'); 
         var makeMyStoreButton = document.getElementById('makeMyStoreButton');
         var displayStoreFax = document.getElementById('displayStoreFax');
         var displayStoreEmail = document.getElementById('displayStoreEmail');
         var displayStoreHours = document.getElementById('displayStoreHours');
         var displayStoreAddress = document.getElementById('displayStoreAddress');
		 
		  var displayStoreCity = document.getElementById('displayStoreCity');
		  var displayStoreState = document.getElementById('displayStoreState');
         
         
      	 names[i] = markers;
  
        var myLatlng = new google.maps.LatLng(lat, lng);

 	
		
	    document.getElementById("setMystore").style.display = 'block';
         marker = new google.maps.Marker({
            position: myLatlng,
             map: map,
            zoom: 8,
			mapTypeId: google.maps.MapTypeId.ROADMAP,           
            icon:'/wcsstore/ONB2BDirectStorefrontAssetStore/images/on-pin.png',
            title: " " + storeNames + " , " + storeDistance + " | Store name: " + storeEmail
        });
        
       marker.setMap(map);
       //map.setCenter(marker.getPosition());
      // map.panTo(values[0],values1[0]);
	
        global_markers[i] = marker;	


		 

		  infowindow = new google.maps.InfoWindow({
           content: contentString
          });


      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
		 contentString = '<html><body><div><p><a href="javascript:void(0)" onclick="window.open("http://'+markers[i][3]+',_self); return false;><b>'+markers[i][4]+'</b></a><br /><br />'+markers[i][10]+'<br/>'+markers[i][11]+','+markers[i][12]+','+markers[i][6]+'<br/><br/><b>Phone:</b> '+markers[i][3]+'<br/><b>Fax:</b> '+markers[i][7]+'<br/><b>Email:</b> '+markers[i][8]+'<br/><br/><b> </b><a href="https://'+markers[i][2]+'">'+markers[i][2]+'</a></p></div></body></html>';
          infowindow = new google.maps.InfoWindow({
           content: contentString
          });
          infowindow.open(map, marker);
        }
      })(marker, i));

		
          
        google.maps.event.addListener(global_markers[i], 'click', function() {
           
           var getIndex = global_markers.indexOf(this);
            console.log("This",markers[getIndex][4]);
            var lat=markers[getIndex][0];
            var lng=markers[getIndex][1];
            var getName = markers[getIndex][4];
            var getWebsite =  markers[getIndex][2];
            var getContactNum = markers[getIndex][3];
            var storeDistance = markers[getIndex][5];
            var getStoreZipcode = markers[getIndex][6];
            
            var getStoreFax = markers[getIndex][7];
            var getStoreEmail = markers[getIndex][8];
            var getStoreHours = markers[getIndex][9];
            var getStoreAddress = markers[getIndex][10];
			var getStoreState = markers[getIndex][11];
			var getStoreCity = markers[getIndex][12];
			var getStoreId = markers[getIndex][13];
			var getField2 = markers[getIndex][14];
           
          setStoreData(lat,lng,getName,getWebsite,getContactNum,storeDistance,getStoreZipcode,getStoreFax,getStoreEmail,getStoreHours,getStoreAddress,getStoreState,getStoreCity,getStoreId,getField2);
           
            setStoreValue.value = getName;
            userStoreSite.value = getWebsite;
            userStoreContact.value = "Phone: "+getContactNum;
            userStoreDistance.value = storeDistance;
            displayStoreZipcode.value = getStoreZipcode;
            
        	displayStoreFax.value = "Fax: "+getStoreFax;
         	displayStoreEmail.value ="Email: "+ getStoreEmail;
         	storeHours.innerHTML="Opening Hours<br> "+getStoreHours;
         	displayStoreAddress.value = getStoreAddress;
			if(getField2 == 'Y')
			{
			makeMyStoreButton.innerHTML ='<a id="setMystore" href="${param.assetStore}B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId='+getStoreId+'&shipEmail='+getStoreEmail+'&latitude='+lat+'&longitude='+lng+'&storeName='+getName+'&orderItemId=${param.orderItemId}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1"  >Set as My Store</a>';
			}
			displayStoreState.value = getStoreState;
			displayStoreCity.value = getStoreCity;
         	
        });
        
       
        

        
        
        
        
        
    }
}

     


	function setStoreData(lat,lng,storeNames,getWebsite,getContact,getStoreDistance,getStoreZipcode,getStoreFax,getStoreEmail,getStoreHours,getStoreAddress,getStoreState,getStoreCity,getStoreId,getField2){
	  store_detailsOne('firstrow2');
	 
	 var makeYourStore = document.getElementById('makeItMyStore');
     var storeName = document.getElementById('displayStoreName');
     var storeContact = document.getElementById('displayStoreContact');
     var storeWebSite = document.getElementById('displayStoreWebSite'); 
	 var makeMyStoreButton = document.getElementById('makeMyStoreButton');
	 var storeDistance = document.getElementById('displayStoreDistance'); 
	 var storeZipcode = document.getElementById('displayStoreZipcode'); 
	 var userStoreName = document.getElementById('userStoreName'); 
	 var storeFax=document.getElementById('displayStoreFax');
     var storeEmail=document.getElementById('displayStoreEmail');
     var storeHours=document.getElementById('displayStoreHours');
	 var storeAddress=document.getElementById('displayStoreAddress');
	 var storeState=document.getElementById('displayStoreState');
	 var storeCity=document.getElementById('displayStoreCity');
	 /*
		if(userStoreName.value == storeNames){
		makeYourStore.innerHTML = "Your Store";
		}else{
			//makeYourStore.innerHTML = "Set as My Store";
		}*/
		var assetstore='${param.assetStore}';
		if(getField2 == 'Y')
		{
		makeMyStoreButton.innerHTML ='<a id="setMystore" href="+assetstore+"B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId='+getStoreId+'&shipEmail='+getStoreEmail+'&latitude='+lat+'&longitude='+lng+'&storeName='+storeNames+'&orderItemId=${param.orderItemId}&assetStore="+assetstore+"&URL="+assetstore+"OrderShippingBillingView?shipmentType=single&guestChkout=1"  >Set as My Store</a>';
		}
		else{
			makeMyStoreButton.innerHTML ='';
		}
		 storeName.innerHTML = '<br/>' + storeNames + '<br/><br/>';
		storeWebSite.innerHTML = '<br/><b></b> <a href='+getWebsite+'>'+getWebsite+'</a><br/>';
		storeContact.innerHTML ="<br/><b>Phone: </b>"+getContact;
		storeZipcode.innerHTML = getStoreZipcode;
		storeFax.innerHTML="<b>Fax: </b>"+getStoreFax;
		storeEmail.innerHTML="<b>Email: </b>"+getStoreEmail;
		storeHours.innerHTML="<br/><b>Opening Hours</b><br/> "+getStoreHours;
		storeAddress.innerHTML=getStoreAddress;		 
        storeState.innerHTML=getStoreState;
        storeCity.innerHTML=getStoreCity;

		 
	} 
	
	
	
	
	
   window.onload = initialize;
   
       

function store_detailsOne(divID) {
		//document.getElementById(store_id).style.display = action;
		document.getElementById(divID).style.display = "none";
		//document.getElementById(show).style.display = "block";
		 document.getElementById("setMystore").style.display = 'block';
	}

function store_details(store_id,action,hide,show,linkhide,linkshow){document.getElementById(store_id).style.display=action;document.getElementById(hide).style.display="none";document.getElementById(show).style.display="block";document.getElementById(linkhide).style.display="none";document.getElementById(linkshow).style.display="block";}
function locator_more(){document.getElementById("locatorTable").className="activated";}
    </script>
    
	
			
<div id="showStoreDetails">		
<c:choose>
				<c:when test="${!empty sessionScope.userStore}">
					<div id="displayYourStore"> <a href='#' id="makeItMyStore">MyStore</a> </div></br>
					<div id="displayStoreName">${sessionScope.userStore} </div></br>
					<div id="displayStoreContact"> ${sessionScope.userStoreContact}</div></br>
	                <div id="displayStoreAddress"></div>
					<div id="displayStoreWebSite"><a href='${sessionScope.userStoreSite}'> ${sessionScope.userStoreSite}</a></div></br>
					<!-- <div id="displayStoreZipcode"> </div> -->
					<div id="displayStoreDistance"> ${sessionScope.userStoreDistance}</div>
					<div id="displayStoreContact"> ${sessionScope.userStoreContact}</div>
				    <div id="displayStoreFax"></div>
				    <div id="displayStoreEmail"></div>
				    <div id="dd">Opening Hours</div>
				    <div id="displayStoreHours"></div>
				</c:when>
				<c:when test="${param.fromLink ne 'true'}">
					
				</c:when>
				<c:otherwise>
					<h2 class="closest">Your closest store is:</h2>
					<div id="displayYourStore"></div>
					<div id="displayStoreName"></div>
					<div>
						<span id="displayStoreAddress"></span>
						<span id="displayStoreCity"></span>
						<span id="displayStoreState"></span>
						<span id="displayStoreZipcode"></span>
					</div>
					<div id="displayStoreContact"></div>
					<div id="displayStoreFax"></div>
				    <div id="displayStoreEmail"></div>
				    
				    <div id="displayStoreHours"></div>
					<div id="displayStoreWebSite"></div>
					<input type="hidden" name="lat" id="lat" value="">
					<input type="hidden" name="lng" id="lng" value="">
					
					<div id="makeMyStoreButton"></div>
				</c:otherwise>
			</c:choose>			


</br>

</div>




<c:forEach items="${sldbStoreList.alStoreBeans}" begin="0" var="sldbStore" varStatus="statusCount"> 

			 
				
					<c:choose>
			         <c:when test="${statusCount.count eq 1 && param.fromLink eq 'true'}">
					 
					 <div id="firstrow" style="display:none">
					<tr class="store-line" id="firstrow2">
					<%
					  cssClass="store-line2";
					%>
					<c:url var="storeDetailURL"
						value="StoreDetailView?langId=-1&storeId=${storeId}&catalogId=${catalogId}&storeNumber=${sldbStore.storenumber}&address=${sldbStore.address1} ${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode} " />
					<td>${sldbStore.nickname}</td>
					<td>${sldbStore.distance}&nbsp;km</td>
					</tr>
					<tr>
					<td colspan="2">
						<br />
						<c:if test="${param.fromLink eq 'true'}">
							<div id="store_${sldbStore.zipcode}"  >
						</c:if>
						<c:if test="${param.fromLink ne 'true'}">
							<div id="store_${sldbStore.zipcode}" class="store-details" style="display:none">
						</c:if>
							<div class="store_address">${sldbStore.address1}
								${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode}</div>
							<br/>
							<div class="store_phone"><b>Phone:</b> ${sldbStore.phone1}</div><div style="clear:both"></div>
							<div class="store_phone"><b>Fax:</b> ${sldbStore.fax1} </div><div style="clear:both"></div>
							<div class="store_phone"><b>Email:</b> ${sldbStore.email1} </div><div style="clear:both"></div>
							<br/>
							 <c:set
								var="mapList1" value="${sldbStore.object}" />
						
							<div class="store_timing">
								<b>Opening Hours:</b><br/>
								${sldbStore.storehours}
								
							</div>
							<br/>
							<div class="store_site_list">
								 <a href="javascript:void(0)"
									onclick="window.open('http://<c:out value='${sldbStore.storeWebSite}' />','_self'); return false;"><c:out
										value="${sldbStore.storeWebSite}"></c:out>
								</a>
							</div>
							<c:if test="${(empty sessionScope.longitude || param.fromSearch eq 'true') && sldbStore.field2 eq 'Y' && param.fromCheckout eq 'true'}">
							<a id="setMystore" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore.storenumber}&shipEmail=${sldbStore.email1}&orderItemId=${param.orderItemId}&latitude=${sldbStore.dLatitude}&longitude=${sldbStore.dLongitude}&storeName=${sldbStore.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'>Set as My Store</a>
							
							</c:if>
							<c:if test="${!empty sessionScope.longitude && param.fromSearch ne 'true' && sldbStore.field2 eq 'Y' }">
							<a id="setMystoreSelected" href="javascript:void(0)" >My Store</a>
							</c:if>
						</div>
						<br /><br />
						</td>
						</tr>
						</div>
						</c:when>
						<c:when test="${ param.fromLink ne 'true'}">

				
				<c:if test="${statusCount.count eq 6}">
					<tr class="more" style="display:none;">
						<td colspan="2">
							<div id="setMystore" onclick="locator_more();">View More...</div>
						</td>
					</tr>
				</c:if>
					<c:url var="storeDetailURL"
						value="StoreDetailView?langId=-1&storeId=${storeId}&catalogId=${catalogId}&storeNumber=${sldbStore.storenumber}&address=${sldbStore.address1} ${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode} " />
				<tr style="display:none;">
					<td>				
						<a id="link_show_${sldbStore.zipcode}" class="store_name" onclick="store_details('store_${sldbStore.zipcode}','block','icon_show_${sldbStore.zipcode}','icon_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}')">${sldbStore.nickname}</a>
						<a id="link_hide_${sldbStore.zipcode}" class="store_name" onclick="store_details('store_${sldbStore.zipcode}','none','icon_hide_${sldbStore.zipcode}','icon_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}')" style="display:none;">${sldbStore.nickname}</a>	
					</td>
					
					<td align="right" style="vertical-align:top;">
						<div id="icon_show_${sldbStore.zipcode}" onclick="store_details('store_${sldbStore.zipcode}','block','icon_show_${sldbStore.zipcode}','icon_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}')" class="store_distance"></div>
						<div id="icon_hide_${sldbStore.zipcode}" onclick="store_details('store_${sldbStore.zipcode}','none','icon_hide_${sldbStore.zipcode}','icon_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}')" class="store_distance" style="display:none;"></div>
						
						
					</td>
				</tr>
				<tr style="display:none;">
					<td colspan="2">
						<div id="store_${sldbStore.zipcode}" class="store-details" >
							<br/>
							<div class="store_address">
								${sldbStore.address1} ${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode}
							</div>
							<br/>
							<div class="store_phone"><b>Phone:</b> ${sldbStore.phone1}</div><div style="clear:both"></div>
							<div class="store_phone"><b>Fax:</b> ${sldbStore.fax1}</div><div style="clear:both"></div>
							<div class="store_phone"><b>Email:</b> ${sldbStore.email1}</div><div style="clear:both"></div>
							<br/>
							 <c:set
								var="mapList1" value="${sldbStore.object}" />
						
							<div class="store_timing">
								<b>Opening Hours:</b><br/>
								${sldbStore.storehours}
								
							</div>
							<br/>
							<div class="store_site_list">
								 <a href="javascript:void(0)"
									onclick="window.open('http://<c:out value='${sldbStore.storeWebSite}' />','_self'); return false;"><c:out
										value="${sldbStore.storeWebSite}"></c:out>
								</a>
							</div>
							<c:if test="${!empty param.orderId && sldbStore.field2 eq 'Y' && param.fromCheckout eq 'true'}">
							<a id="setMystore" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore.storenumber}&shipEmail=${sldbStore.email1}&orderItemId=${param.orderItemId}&latitude=${sldbStore.dLatitude}&longitude=${sldbStore.dLongitude}&storeName=${sldbStore.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'>Set as My Store</a>
							</c:if>
							<c:if test="${empty param.orderId && sldbStore.field2 eq 'Y' && param.fromCheckout eq 'true'}">
							<a id="setMystore" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=NA&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore.storenumber}&shipEmail=${sldbStore.email1}&orderItemId=NA&latitude=${sldbStore.dLatitude}&longitude=${sldbStore.dLongitude}&storeName=${sldbStore.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'>Set as My Store</a>
							</c:if>
						</div>
					</td>
				</tr>
</c:when>
				<c:otherwise>

				<c:if test="${statusCount.count eq 2 }">
				
<tr><td colspan="2"><h2>Other stores near you:</h2></td></tr>
<tr>
					<td colspan="3" height="8" class="seprator"></td>
				</tr>
<tr class="store-line">				
				</c:if>
				<c:if test="${statusCount.count eq 6}">
					<tr class="more">
						<td colspan="2">
							<div id="setMystore" onclick="locator_more();">View More...</div>
						</td>
					</tr>
				</c:if>
					<c:url var="storeDetailURL"
						value="StoreDetailView?langId=-1&storeId=${storeId}&catalogId=${catalogId}&storeNumber=${sldbStore.storenumber}&address=${sldbStore.address1} ${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode} " />
				<tr>
					<td>				
						<a id="link_show_${sldbStore.zipcode}" class="store_name" onclick="store_details('store_${sldbStore.zipcode}','block','icon_show_${sldbStore.zipcode}','icon_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}')">${sldbStore.nickname}</a>
						<a id="link_hide_${sldbStore.zipcode}" class="store_name" onclick="store_details('store_${sldbStore.zipcode}','none','icon_hide_${sldbStore.zipcode}','icon_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}')" style="display:none;">${sldbStore.nickname}</a>	
					</td>
					
					<td align="right" style="vertical-align:top;">
						<div id="icon_show_${sldbStore.zipcode}" onclick="store_details('store_${sldbStore.zipcode}','block','icon_show_${sldbStore.zipcode}','icon_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}')" class="store_distance">${sldbStore.distance}&nbsp;km</div>
						<div id="icon_hide_${sldbStore.zipcode}" onclick="store_details('store_${sldbStore.zipcode}','none','icon_hide_${sldbStore.zipcode}','icon_show_${sldbStore.zipcode}','link_hide_${sldbStore.zipcode}','link_show_${sldbStore.zipcode}')" class="store_distance" style="display:none;">${sldbStore.distance}&nbsp;km</div>
						
						
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="store_${sldbStore.zipcode}" class="store-details">
							<br/>
							<div class="store_address">
								${sldbStore.address1} ${sldbStore.city}, ${sldbStore.state} ${sldbStore.zipcode}
							</div>
							<br/>
							<div class="store_phone"><b>Phone:</b> ${sldbStore.phone1}</div><div style="clear:both"></div>
							<div class="store_phone"><b>Fax:</b> ${sldbStore.fax1}</div><div style="clear:both"></div>
							<div class="store_phone"><b>Email:</b> ${sldbStore.email1}</div><div style="clear:both"></div>
							<br/>
							 <c:set
								var="mapList1" value="${sldbStore.object}" />
						
							<div class="store_timing">
								<b>Opening Hours:</b><br/>
								${sldbStore.storehours}
								
							</div>
							<br/>
							<div class="store_site_list">
								 <a href="javascript:void(0)"
									onclick="window.open('http://<c:out value='${sldbStore.storeWebSite}' />','_self'); return false;"><c:out
										value="${sldbStore.storeWebSite}"></c:out>
								</a>
							</div>
							<c:if test="${!empty param.orderId && sldbStore.field2 eq 'Y' && param.fromCheckout eq 'true'}">
							<a id="setMystore" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=${param.orderId}&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore.storenumber}&shipEmail=${sldbStore.email1}&orderItemId=${param.orderItemId}&latitude=${sldbStore.dLatitude}&longitude=${sldbStore.dLongitude}&storeName=${sldbStore.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'>Set as My Store</a>
							</c:if>
							<c:if test="${empty param.orderId && sldbStore.field2 eq 'Y' && param.fromCheckout eq 'true'}">
							<a id="setMystore" href="javascript:void(0)" onclick='window.open("${param.assetStore}B2COrderUpdate?orderId=NA&storeId=${param.storeId}&catalogId=${param.catalogId}&shipStoreId=${sldbStore.storenumber}&shipEmail=${sldbStore.email1}&orderItemId=NA&latitude=${sldbStore.dLatitude}&longitude=${sldbStore.dLongitude}&storeName=${sldbStore.nickname}&assetStore=${param.assetStore}&URL=${param.assetStore}OrderShippingBillingView?shipmentType=single&guestChkout=1","_self"); return false;'>Set as My Store</a>
							</c:if>
						</div>
					</td>
				</tr>
</c:otherwise>
						
           </c:choose>
	   
				<tr>
					<td colspan="3" height="14"></td>
				</tr>
				<c:if test="${ param.fromLink eq 'true'}">
				<tr>
					<td colspan="3" height="15" class="seprator"></td>
				</tr>
				</c:if>
				
				  
				
			</c:forEach>
						
 
 
</tbody>
</table>


</div></div>
								
							</div>	
						</div>
					</div>


				</div>
			</div>
			
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
			</div>
		</div>
		
<script type="text/javascript">

		 
</script>
		
		
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../Common/JSPFExtToInclude.jspf"%> </body>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${page.pageId}"/>
<!-- END StoreLocatorsDisplayMapView.jsp -->		
</html>