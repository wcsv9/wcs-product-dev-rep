<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%--
  *****
  *	This JSP is the confirmation page for e-mail for user is successfully registered.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../Common/EnvironmentSetup.jspf" %>

<c:set var="userMail" value="${param.userMail}" /> 

<!--MAIN CONTENT STARTS HERE-->

<table width="100%" border="0" cellpadding="0" cellspacing="0">	
	<tr> 
		<td>
			This person ${userMail} wants to know about news and specials in your store, please contact them for more details.
		</td>
	</tr>
</table>

<!--MAIN CONTENT ENDS HERE-->
