<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN StaticContentPageDisplayContainer.jsp -->
<link rel="stylesheet" href="/wcsstore/ONetB2BStoreAssetStore/css/furnLandingPagStyle.css">
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div class="rowContainer static-page"  id="container_${pageDesign.layoutId}">
	<div class="row">
		<div class="col12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
	</div>
	<div class="row">
		<div class="col12" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
	</div>
</div>

<!-- END StaticContentPageDisplayContainer.jsp -->
