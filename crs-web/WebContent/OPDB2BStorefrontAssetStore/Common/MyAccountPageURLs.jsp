<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN MyAccountPageURLs.jsp -->

<%@ include file="/Widgets_801/Common/EnvironmentSetup.jspf"%>
<c:if test="${!(userType eq 'G')}">
	<%-- Determine roles played by user to hide/show functionality on pages --%>
	<%-- Get the roles for the user --%>
	<wcf:rest var="userRoles" url="store/{storeId}/person/{personId}"
		scope="request">
		<wcf:var name="storeId" value="${storeId}" />
		<wcf:var name="personId" value="${userId}" />
		<wcf:param name="responseFormat" value="json" />
		<wcf:param name="profileName" value="IBM_Assigned_Roles_Details" />
	</wcf:rest>
	<c:if test="${!empty userRoles && !empty userRoles.rolesWithDetails}">
		<c:forEach items="${userRoles.rolesWithDetails}" var="role">
			<c:choose>
				<c:when test="${role.roleId == -21}">
					<c:set var="bBuyerAdmin" value="true" />
				</c:when>
				<c:when test="${role.roleId == -22}">
					<c:set var="bBuyerApprover" value="true" />
				</c:when>
			</c:choose>
		</c:forEach>
	</c:if>

	<c:if test="${bBuyerApprover == true || bBuyerAdmin == true}">
		<c:set var="displayMyOrganizationsLink" value="true" />
		<wcf:url var="organizationsAndUsersURL"
			value="OrganizationsAndUsersView">
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="pageSize" value="50" />
			<wcf:param name="requisitionListStyle" value="strong" />
		</wcf:url>
		<wcf:url var="orderApprovalViewURL" value="OrderApprovalView">
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="langId" value="${langId}" />

		</wcf:url>
	</c:if>
</c:if>

<wcf:url var="userRegistrationFormURL" value="UserRegistrationForm">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
	<wcf:param name="userRegistrationStyle" value="strong" />
</wcf:url>
<wcf:url var="userRegistrationFormURL" value="UserRegistrationForm">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="editRegistration" value="Y" />
	<wcf:param name="userRegistrationStyle" value="strong" />
</wcf:url>
<wcf:url var="addressBookFormURL" value="AddressBookForm">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="addressBookStyle" value="strong" />
</wcf:url>
<wcf:url var="QuickOrderURL" value="QuickOrderView">
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="isQuickOrder" value="true" />
</wcf:url>
<wcf:url var="trackRecurringOrderStatusURL" value="TrackOrderStatus">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="isRecurringOrder" value="true" />
	<wcf:param name="recurringOrderStatusStyle" value="strong" />
	<wcf:param name="showOrderHeader" value="true" />
</wcf:url>
<wcf:url var="trackOrderStatusURL" value="TrackOrderStatus">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="orderStatusStyle" value="strong" />
	<flow:ifEnabled feature="contractSelection">
		<wcf:param name="showOrderHeader" value="false" />
	</flow:ifEnabled>
	<flow:ifDisabled feature="contractSelection">
		<wcf:param name="showOrderHeader" value="true" />
	</flow:ifDisabled>
</wcf:url>
<wcf:url var="requisitionListURL" value="RequisitionListDisplayView">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="pageSize" value="50" />
	<wcf:param name="requisitionListStyle" value="strong" />
</wcf:url>

<wcf:url var="ListOrdersDisplayViewURL" value="ListOrdersDisplayView">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="page" value="savedorder" />
	<wcf:param name="myAcctMain" value="1" />
</wcf:url>
<wcf:url var="AwardPointsListDisplayViewURL"
	value="AwardPointsListDisplayView">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="orderApprovalViewURL" value="OrderApprovalView">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<a onclick="ResponsiveMenu();" id="responsiveMenu">Menu</a>

<a href="${userRegistrationFormURL }">Account Details</a>
<a href="${requisitionListURL}">Favourites</a>
<a href="${trackOrderStatusURL}">Order History</a>
<a href="${addressBookFormURL}">Address Book</a>
<a href="${QuickOrderURL}">Quick Order</a>
<c:if test="${sessionScope.loyaltyEnabled eq 'true' }">
	<a href="${AwardPointsListDisplayViewURL}">Rewards &amp; Vouchers</a>
</c:if>
<c:if test="${bBuyerAdmin == true }">
	<a href="${organizationsAndUsersURL}">Company Details &amp;
		Accounts</a>
</c:if>
<a href="${ListOrdersDisplayViewURL}">Saved Orders</a>
<a href="${trackRecurringOrderStatusURL}">Recurring Orders</a>
<c:if test="${bBuyerAdmin == true }">
	<a href="${orderApprovalViewURL}">Approvals</a>
</c:if>


<script>
	function ResponsiveMenu() {
		var x = document.getElementById("accDetailMenu");
		if (x.className === "normalMenu") {
			x.className = " responsive";
		} else {
			x.className = "normalMenu";
		}
	}
</script>

<!-- END MyAccountPageURLs.jsp -->

