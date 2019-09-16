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

<%-- Used by refresh area to refresh the widget when a new requisition list has been added --%>
<%@ include file="/Widgets_801/Common/EnvironmentSetup.jspf" %>
<%@ include file="/Widgets_801/Common/nocache.jspf" %>
	
<%@ include file="ext/AddToRequisitionLists_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="AddToRequisitionLists_Data.jspf" %>
</c:if>

<%@include file="AddToRequisitionLists_Menu.jspf" %>