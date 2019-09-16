<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>

<c:set var="homePageURL" value="${env_TopCategoriesDisplayURL}"/>

<wcf:url var="Logon_LogoutURLOriginal" value="Logoff">	    
  <wcf:param name="langId" value="${WCParam.langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />		  		 
  <wcf:param name="deleteCartCookie" value="true" />
  <wcf:param name="URL" value="${homePageURL}" />	
</wcf:url>
<c:if test="${userType ne 'G'}">

	<wcf:rest var="approvedUser" url="store/${WCParam.storeId}/registrationApproval/isApprovedUser/${userId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="userId" value="${WCParam.userId}"/>
	</wcf:rest>
	
	<c:set var="isApprovedUser" value="${approvedUser.isApprovedUser}" />

	<c:if test="${isApprovedUser eq 'false'}">
	
		<script>
			//document.getElementById("Header_GlobalLogin_onBehalfOf_loggedInDropdown_SignOut").click();
			GlobalLoginJS.deleteUserLogonIdCookie();
			logout('${Logon_LogoutURLOriginal}');
		</script>
	
	</c:if>

</c:if>