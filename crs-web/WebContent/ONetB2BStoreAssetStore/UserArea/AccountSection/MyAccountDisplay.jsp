
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../Common/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="myAccountLandingPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>
<c:set var="pageCategory" value="MyAccount" scope="request"/>

<fmt:message bundle="${storeText}" key="MA_MYACCOUNT" var="contentPageName" scope="request"/>

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
<!-- BEGIN MyAccountDisplay.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<%@ include file="../../Common/CommonCSSToInclude.jspf"%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ include file="../../Common/CommonJSToInclude.jspf"%>
	<%@ include file="MyAccountDisplayExt.jspf" %>
	<%@ include file="GiftRegistryMyAccountDisplayExt.jspf" %>
	
	<title><fmt:message bundle="${storeText}" key="MA_MYACCOUNT"/></title>
	
	<%@ include file="../../Common/CommonJSPFToInclude.jspf"%>
		


<script type="text/javascript">
	$(document).ready(function() {
		categoryDisplayJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>','${userType}');
		MyAccountServicesDeclarationJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>');

		<fmt:message bundle="${storeText}" key="MO_ORDER_CANCELED_MSG" var="MO_ORDER_CANCELED_MSG"/>
		<fmt:message bundle="${storeText}" key="SCHEDULE_ORDER_CANCEL_MSG" var="SCHEDULE_ORDER_CANCEL_MSG"/>
		<fmt:message bundle="${storeText}" key="SCHEDULE_ORDER_PENDING_CANCEL_MSG" var="SCHEDULE_ORDER_PENDING_CANCEL_MSG"/>
		<fmt:message bundle="${storeText}" key="SUBSCRIPTION_CANCEL_MSG" var="SUBSCRIPTION_CANCEL_MSG"/>
		<fmt:message bundle="${storeText}" key="SUBSCRIPTION_PENDING_CANCEL_MSG" var="SUBSCRIPTION_PENDING_CANCEL_MSG"/>
		<fmt:message bundle="${storeText}" key="CANNOT_RENEW_NOW_MSG" var="CANNOT_RENEW_NOW_MSG"/>
		<!-- JR54936 -->
		<fmt:message bundle="${storeText}" key="CANNOT_REORDER_ANY_MSG" var="CANNOT_REORDER_ANY_MSG"/>
		MessageHelper.setMessage("CANNOT_REORDER_ANY_MSG", <wcf:json object="${CANNOT_REORDER_ANY_MSG}"/>);	
		
		MessageHelper.setMessage("MO_ORDER_CANCELED_MSG", <wcf:json object="${MO_ORDER_CANCELED_MSG}"/>);	
		MessageHelper.setMessage("SCHEDULE_ORDER_CANCEL_MSG", <wcf:json object="${SCHEDULE_ORDER_CANCEL_MSG}"/>);
		MessageHelper.setMessage("SCHEDULE_ORDER_PENDING_CANCEL_MSG", <wcf:json object="${SCHEDULE_ORDER_PENDING_CANCEL_MSG}"/>);
		MessageHelper.setMessage("SUBSCRIPTION_CANCEL_MSG", <wcf:json object="${SUBSCRIPTION_CANCEL_MSG}"/>);
		MessageHelper.setMessage("SUBSCRIPTION_PENDING_CANCEL_MSG", <wcf:json object="${SUBSCRIPTION_PENDING_CANCEL_MSG}"/>);
		MessageHelper.setMessage("CANNOT_RENEW_NOW_MSG", <wcf:json object="${CANNOT_RENEW_NOW_MSG}"/>);
		if (getCookie("WC_SHOW_USER_ACTIVATION_" + WCParamJS.storeId) == "true") {
			setCookie("WC_SHOW_USER_ACTIVATION_" + WCParamJS.storeId, null, {path: '/', expires: -1, domain: cookieDomain});
		}
	});
</script>
 <script type="text/javascript">
         function popupWindow(URL) {
            window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
         }
 </script>

</head>
<body>
 
<!-- Page Start -->
<div id="page">
	<div id="grayOut"></div>
	<!-- Header Widget -->
	<div class="header_wrapper_position" id="headerWidget">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
		
		<c:if test="${userType ne 'G'}">
			<%out.flush();%>
			<c:import url= "${env_siteWidgetsDir}com.royalcyber.loyalty.point/LoyaltyHeader.jsp">
				<c:param name="storeId"   value="${WCParam.storeId}"  />
				<c:param name="catalogId" value="${WCParam.catalogId}"/>
				<c:param name="langId" value="${WCParam.langId}" />
				<c:param name="userId" value="${userId}" />
			</c:import>
			<%out.flush();%>
		</c:if>
	</div>
	
	<script type="text/javascript">
		if('<wcf:out value="${WCParam.page}" escapeFormat="js"/>'=='quickcheckout'){
			$(document).ready(function() {
				setTimeout(function() {
					var successMessage = Utils.getLocalizationMessage("QC_UPDATE_SUCCESS");
					MessageHelper.displayStatusMessage(successMessage);
				}, 200);
			});
		}
	</script>

	
	
<wcf:url var="userRegistrationFormURL" value="UserRegistrationForm">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="editRegistration" value="Y" />
<wcf:param name="userRegistrationStyle" value="strong"/>
</wcf:url>
<wcf:url var="addressBookFormURL" value="AddressBookForm">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="addressBookStyle" value="strong"/>
</wcf:url>
<wcf:url var="QuickOrderURL" value="QuickOrderView">
<wcf:param name="storeId" value="${storeId}" />
<wcf:param name="catalogId" value="${catalogId}" />
<wcf:param name="langId" value="${langId}" />
<wcf:param name="isQuickOrder" value="true" />
</wcf:url>
<wcf:url var="trackRecurringOrderStatusURL" value="TrackOrderStatus">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="isRecurringOrder" value="true" />
<wcf:param name="recurringOrderStatusStyle" value="strong"/>
<wcf:param name="showOrderHeader" value="true"/>
</wcf:url>
<wcf:url var="trackOrderStatusURL" value="TrackOrderStatus">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="orderStatusStyle" value="strong"/>
<flow:ifEnabled feature="contractSelection">
<wcf:param name="showOrderHeader" value="false"/>
</flow:ifEnabled>
<flow:ifDisabled feature="contractSelection">
<wcf:param name="showOrderHeader" value="true"/>
</flow:ifDisabled>	
</wcf:url>
<wcf:url var="requisitionListURL" value="RequisitionListDisplayView">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="pageSize" value="50" />
<wcf:param name="requisitionListStyle" value="strong"/>	
</wcf:url>
<c:if test="${!(userType eq 'G')}">
	<%-- Determine roles played by user to hide/show functionality on pages --%>
	<%-- Get the roles for the user --%>
	<wcf:rest var="userRoles" url="store/{storeId}/person/{personId}" scope="request">
		<wcf:var name="storeId" value="${storeId}"/>
		<wcf:var name="personId" value="${userId}"/>
		<wcf:param name="responseFormat" value="json"/>
		<wcf:param name="profileName" value="IBM_Assigned_Roles_Details"/>
	</wcf:rest>
	<c:if test="${!empty userRoles && !empty userRoles.rolesWithDetails}">
		<c:forEach items="${userRoles.rolesWithDetails}" var="role">
			<c:choose >
				<c:when test="${role.roleId == -21}">
					<c:set var="bBuyerAdmin" value="true"/>
				</c:when>
				<c:when test="${role.roleId == -22}">
					<c:set var="bBuyerApprover" value="true"/>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:if>
	<c:if test="${bBuyerApprover == true || bBuyerAdmin == true}">
	<c:set var="displayMyOrganizationsLink" value="true"/>
<wcf:url var="organizationsAndUsersURL" value="OrganizationsAndUsersView">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="pageSize" value="50" />
<wcf:param name="requisitionListStyle" value="strong"/>	
</wcf:url>
<wcf:url var="orderApprovalViewURL" value="OrderApprovalView" >
<wcf:param name="storeId"   value="${WCParam.storeId}"  />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
</wcf:url>
</c:if>
</c:if>
<wcf:url var="ListOrdersDisplayViewURL" value="ListOrdersDisplayView">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
<wcf:param name="page" value="savedorder" />
<wcf:param name="myAcctMain" value="1"/>	
</wcf:url>
<wcf:url var="AwardPointsListDisplayViewURL" value="AwardPointsListDisplayView">
<wcf:param name="storeId" value="${WCParam.storeId}" />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="orderApprovalViewURL" value="OrderApprovalView" >
<wcf:param name="storeId"   value="${WCParam.storeId}"  />
<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
<wcf:param name="langId" value="${langId}" />
</wcf:url>

	
	<!-- Main Content Start -->
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
			<div class="row myAccSummaryPage">
				<div class="row col12">
					<a href="${userRegistrationFormURL}">
						<div class="col4 acol6 row myAccBox">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/userIcon.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Account Details</p></div>
						</a>
					</div>
					<div class="col4 acol6 row myAccBox">
						<a href="${requisitionListURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/favourites.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Favourites</p></div>
						</a>
					</div>
					<div class="col4 acol6 row myAccBox">
						<a href="${trackOrderStatusURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/orderHistory.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Order History</p></div>
						</a>
					</div>
					<div class="col4 acol6 row myAccBox">
						<a href="${addressBookFormURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/addressBook.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Address Book</p></div>
						</a>
					</div>
					<div class="col4 acol6 row myAccBox">
						<a href="${QuickOrderURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/shopping.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Quick Order</p></div>
						</a>
					</div>
					<c:if test="${sessionScope.loyaltyEnabled ne 'false' && !empty sessionScope.loyaltyEnabled }">
					
						<div class="col4 acol6 row myAccBox">
							<a href="${AwardPointsListDisplayViewURL}">
							<div class="row col12">
								<div class="col1">&nbsp;</div>
								<div class="col10 userIconLine">
									<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/rewards.png" /></div>
									<hr>
								</div>
								<div class="col1">&nbsp;</div>
							</div>
							<div class="col12"><p>Rewards & Vouchers</p></div>
							</a>
						</div>
				   </c:if>
					<c:if test="${bBuyerAdmin == true }">
					<div class="col4 acol6 row myAccBox">
						<a href="${organizationsAndUsersURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/companyDetails.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Company Details & Accounts</p></div>
						</a>
					</div>
					</c:if>
					<div class="col4 acol6 row myAccBox">
						<a href="${trackRecurringOrderStatusURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/recurring.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Recurring Orders</p></div>
						</a>
					</div>
					<c:if test="${bBuyerAdmin == true }">
					<div class="col4 acol6 row myAccBox lastItemFullWidth">
						<a href="${orderApprovalViewURL}">
						<div class="row col12">
							<div class="col1">&nbsp;</div>
							<div class="col10 userIconLine">
								<div class="userIcon"><img src="/wcsstore/ONetB2BStoreAssetStore/images/approvals.png" /></div>
								<hr>
							</div>
							<div class="col1">&nbsp;</div>
						</div>
						<div class="col12"><p>Order Approvals</p></div>
						</a>
					</div>

					</c:if>

				</div>
			</div>
			<%-- <div class="rowContainer" id="container_MyAccountDisplayB2B">
				<div class="row margin-true">					
					<div class="col4 acol12 ccol3">
						<%out.flush();%>
							<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
						<%out.flush();%>		
					</div>
					<div class="col8 acol12 ccol9 right gggg">
						<div id="MyAccountDisplayPageHeading">
							<h1><fmt:message key="MA_SUMMARY" bundle="${storeText}"/></h1>
						</div>
						<%out.flush();%>
							<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.WelcomeMessage/WelcomeMessage.jsp"/>
						<%out.flush();%>

						<div class="myAccountSubHeading">
							<span><fmt:message key="MA_PERSONAL_INFO" bundle="${storeText}"/></span>
						</div>
						<%out.flush();%>
							<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.AccountSummary/AccountSummary.jsp"/>
						<%out.flush();%>
					</div>

					<div class="col8 acol12 ccol9 right">
						<flow:ifEnabled feature="TrackingStatus">
							<div class="myAccountSubHeading">
								<span><fmt:message key="MA_RECENT_ORDER_HISTORY" bundle="${storeText}"/></span>
							</div>
							<%out.flush();%>
								<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
									<wcpgl:param name="storeId" value="${WCParam.storeId}"/>
									<wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
									<wcpgl:param name="langId" value="${langId}"/>
									<wcpgl:param name="showPONumber" value="${showPONumber}"/>
									<wcpgl:param name="selectedTab" value="PreviouslyProcessed"/>
									<wcpgl:param name="isMyAccountMainPage" value="true"/>
								</wcpgl:widgetImport>
							<%out.flush();%>

							<flow:ifEnabled feature="RecurringOrders">
								<div class="myAccountSubHeading">
									<span><fmt:message key="MA_RECENT_SCHEDULEDORDERS" bundle="${storeText}"/></span>
								</div>
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
										<wcpgl:param name="storeId" value="${WCParam.storeId}"/>
										<wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcpgl:param name="langId" value="${langId}"/>
										<wcpgl:param name="showPONumber" value="${showPONumber}"/>
										<wcpgl:param name="isRecurringOrder" value="true"/>
										<wcpgl:param name="isMyAccountMainPage" value="true"/>
									</wcpgl:widgetImport>
								<%out.flush();%>
							</flow:ifEnabled>
							<flow:ifEnabled feature="Subscription">
								<div class="myAccountSubHeading">
									<span><fmt:message key="MA_RECENT_SUBSCRIPTIONS" bundle="${storeText}"/></span>
								</div>
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
										<wcpgl:param name="storeId" value="${WCParam.storeId}"/>
										<wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcpgl:param name="langId" value="${langId}"/>
										<wcpgl:param name="showPONumber" value="${showPONumber}"/>
										<wcpgl:param name="isSubscription" value="true"/>
										<wcpgl:param name="isMyAccountMainPage" value="true"/>
									</wcpgl:widgetImport>
								<%out.flush();%>
							</flow:ifEnabled>

							<flow:ifEnabled feature="EnableQuotes">
								<div class="myAccountSubHeading">
									<span><fmt:message key="MA_RECENTQUOTES" bundle="${storeText}"/></span>
								</div>
								<%out.flush();%>
									<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
										<wcpgl:param name="storeId" value="${WCParam.storeId}"/>
										<wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
										<wcpgl:param name="langId" value="${langId}"/>
										<wcpgl:param name="showPONumber" value="${showPONumber}"/>
										<wcpgl:param name="selectedTab" value="PreviouslyProcessed"/>
										<wcpgl:param name="isQuote" value="true"/>
										<wcpgl:param name="isMyAccountMainPage" value="true"/>
									</wcpgl:widgetImport>
								<%out.flush();%>
							</flow:ifEnabled>
						</flow:ifEnabled>
					</div>
				</div>
			</div> --%>
		</div>
	</div>	
	<!-- Main Content End -->

	<!-- Footer Start Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div> 
     <!-- Footer Start End -->
</div>

<flow:ifEnabled feature="Analytics"><cm:pageview pageType="wcs-registration"/></flow:ifEnabled>
<%@ include file="../../Common/JSPFExtToInclude.jspf"%>

<!-- Style sheet for print -->
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetprint}"/>" type="text/css" media="print"/>
</body>
	<%out.flush();%>
		<c:import url="${env_jspStoreDir}ShoppingArea/CatalogSection/CategorySubsection/IsApproveUser.jsp"/>
	<%out.flush();%>	
</html>
<!-- END MyAccountDisplay.jsp -->
