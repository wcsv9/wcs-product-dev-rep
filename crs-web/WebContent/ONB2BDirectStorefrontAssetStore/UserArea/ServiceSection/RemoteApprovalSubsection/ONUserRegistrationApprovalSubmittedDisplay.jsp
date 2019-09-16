<!-- BEGIN ONUserRegistrationApprovalSubmittedDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>

 
	<wcf:rest var="approvalDisplay" url="store/${WCParam.storeId}/registrationApproval/ONUserRegistrationApprovalSubmittedDisplay/${WCParam.catalogId}/${WCParam.langId}/${WCParam.userId}/${WCParam.orgEntityId}/${WCParam.apruserId}">
		
		<wcf:var name="storeId" value = "${WCParam.storeId}"/>
		<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:var name="langId" value="${WCParam.langId}"/>
		<wcf:var name="userId" value="${WCParam.userId}"/>
		<wcf:var name="orgEntityId" value="${WCParam.orgEntityId}"/>
<%-- 		<wcf:var name="message" value="${WCParam.message}"/> --%>
		<wcf:var name="apruserId" value="${WCParam.apruserId}"/>	
	
	</wcf:rest>

	<c:set var="approvalDisplayResponse" value="${approvalDisplay}" />
	<c:set var="OrgEntityMap" value="${approvalDisplay.OrgEntityMap}" />
	<c:set var="DataMap" value="${approvalDisplay.DataMap}" />
	<c:set var="message" value="${WCParam.message}" />
	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>User Registration Approval</title>

<%-- <link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/> --%>

</head>
<body onload="UserRegistrationApprovalSubmittedDisplayInit()" style="background-image: none;">

<%-- 	<img src="<c:out value='${jspStoreImgDir}images/ON-logo.png'/>" /> --%>
	<br/><br/>
	
	<table cellpadding="8" cellspacing="0" width="80%" class="noBorder">
		<tr>
			<td>
				<h1>User Registration Approval</h1>
		
				<c:if test="${message != null}">
					<br/>
 					<b> ${WCParam.message} <b>
 					<%-- 					<span class="error_msg"><%=message%></span> --%>
					<br/>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<table>
					<tr>
						<td><B>Organisation</B></td>
						<td>&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td>Organisation Name: </td>
						<td>${OrgEntityMap.OrgEntityName}</td>
					</tr>
					<tr>
						<td>Address: </td>
						<td>
							<i>${OrgEntityMap.ADDR_ADDRESS1}</i><BR>
							<i>${OrgEntityMap.ADDR_ADDRESS2}</i><BR>
							<i>${OrgEntityMap.ADDR_CITY}</i><BR>
							<i>${OrgEntityMap.StateProvDisplayName}&nbsp;&nbsp;${OrgEntityMap.ADDR_ZIPCODE}</i><BR>
							<i>${OrgEntityMap.CountryDIsplayName}</i><BR>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><B>User</B></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>Logon Id: </td>
						<td>${DataMap.LogonId}</td>
					</tr>
					<tr>
						<td>First Name: </td>
						<td>${DataMap.FirstName}</td>
					</tr>
					<tr>
						<td>Last Name: </td>
						<td>${DataMap.LastName}</td>
					</tr>
					<tr>
						<td>Address: </td>
						<td>
							<i>${DataMap.Address1}</i><BR>
							<i>${DataMap.Address2}</i><BR>
							<i>${DataMap.City}</i><BR>
							<i>${DataMap.StateProvDisplayName}&nbsp;&nbsp;${DataMap.ZipCode}</i><BR>
							<i>${DataMap.CountryDIsplayName}</i><BR>
						</td>
					</tr>
					<tr>
						<td>Email: </td>
						<td>${DataMap.Email}</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>


	<div style="display: hidden">
	<form name="forceLogoff" action="Logoff" method="post">
		<input type="hidden" name="langId" value="-1"/>
		<input type="hidden" name="storeId" value="${WCParam.storeId}"/>
		<input type="hidden" name="catalogId" value="10051"/>
		<input type="hidden" name="URL" value="\"/>
	</form>
	</div>
	
</body>

<script type="text/javascript" language="javascript">
function UserRegistrationApprovalSubmittedDisplayInit() {
	forceLogoffWindow = window.open("ONUserRegistrationApprovalLogoff?message=${WCParam.message}","forceLogoffWindow","width=1,height=1");
	disableAllLinks();
}

function disableAllLinks() {
	var links = document.getElementsByTagName("a");
	for (var i=0;i<links.length;i++) {
		links[i].removeAttribute("href");
	}
}
</script>


</html>




<!-- END ONUserRegistrationApprovalSubmittedDisplay.jsp -->

