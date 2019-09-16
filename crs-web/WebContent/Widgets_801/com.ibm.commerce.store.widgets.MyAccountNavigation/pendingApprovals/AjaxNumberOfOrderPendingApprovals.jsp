<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN AjaxNumberOfOrderPendingApprovals.jsp -->
<%@ include file="/Widgets_801/Common/EnvironmentSetup.jspf" %>
<%@ include file="/Widgets_801/Common/nocache.jspf" %>

<c:set var="approvalType" value="orderApprovals" />
<%@ include file="../ext/pendingApprovals/NumberOfPendingApprovals_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true' && fetchPendingOrderApprovalCount ne 'false'}">
	<%@ include file="NumberOfPendingApprovals_Data.jspf" %>
</c:if>

<%@ include file="../ext/pendingApprovals/NumberOfPendingApprovals_UI.jspf"%>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="NumberOfPendingApprovals_UI.jspf"%>
</c:if>

<!-- END AjaxNumberOfOrderPendingApprovals.jsp -->