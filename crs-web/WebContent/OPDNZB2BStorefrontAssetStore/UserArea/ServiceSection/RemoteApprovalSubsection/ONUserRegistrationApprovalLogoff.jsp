<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001-2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>

<!-- BEGIN ONUserRegistrationApprovalLogoff.jsp -->
<%@ page import="com.ibm.commerce.server.*" %>

${WCParam.message}
<body>
	<form name="logoff" action="Logoff" method="post" />
</body>

<script type="text/javascript" language="javascript">
	document.logoff.submit();
	alert(${WCParam.message});
	self.close();
</script>
<!-- END ONUserRegistrationApprovalLogoff.jsp -->
	
