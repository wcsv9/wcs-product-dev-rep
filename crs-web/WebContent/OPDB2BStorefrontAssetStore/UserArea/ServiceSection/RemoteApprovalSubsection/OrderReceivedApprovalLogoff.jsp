
<!-- BEGIN OrderReceivedApprovalLogoff.jsp -->
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

<!-- END OrderReceivedApprovalLogoff.jsp -->