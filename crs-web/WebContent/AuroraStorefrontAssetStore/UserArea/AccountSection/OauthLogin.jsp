<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>
<%@ include file="../../Common/CommonJSToInclude.jspf" %>

<c:if test="${!empty WCParam.code}">
	<c:set var="code" scope="request"><c:out value="${WCParam.code}"/></c:set>
</c:if>
<c:if test="${!empty WCParam.access_token}">
	<c:set var="accessToken" scope="request"><c:out value="${WCParam.access_token}"/></c:set>
</c:if>
<c:if test="${!empty WCParam.provider}">
	<c:set var="provider" scope="request"><c:out value="${WCParam.provider}"/></c:set>
</c:if>
<!DOCTYPE HTML>
<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2018 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<html>
<head>
<title>OauthLogin</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

	<c:if test="${!empty WCParam.URL}">
		<input type="hidden" name="URL" value="<c:out value='${WCParam.URL}'/>" id="post_logon_url" />
	</c:if>
	
	<c:choose>
		<c:when test="${!empty accessToken}">
			<c:set var="token" scope="request"><c:out value="${accessToken}"/></c:set>
			<c:set var="isToken" scope="request"><c:out value="1"/></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="token" scope="request"><c:out value="${code}"/></c:set>
			<c:set var="isToken" scope="request"><c:out value="0"/></c:set>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
		
		var postLogonUrl = $("#post_logon_url").val();
		var param = {};
				
		MyAccountDisplay.validateOauthToken('<c:out value='${token}'/>', '<c:out value='${isToken}'/>', '<c:out value='${provider}'/>', postLogonUrl, param);
		
	</script>
</body>
</html>