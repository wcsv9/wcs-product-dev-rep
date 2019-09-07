<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN CompareProduct.jsp -->

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>


<%@ include file="ext/CompareProduct_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="CompareProduct_Data.jspf" %>
</c:if>


<%@ include file="ext/CompareProduct_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="CompareProduct_UI.jspf" %>
</c:if>

<jsp:useBean id="CompareProduct_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END CompareProduct.jsp -->