<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN SubCategoryPageContainer.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf"%>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>
<style>
	div#page div#contentWrapper .row .col6.acol12 {
    width: 100%;
    max-width: 1300px;
    margin: 0 auto;
    float: none;
}
	div#widget_breadcrumb {
    
    margin: -1px -5px;
}
	#content .facetWidget.collapsible {
    padding: 0px 4% 10px 0%;
    margin-left: -5px;
   
}
	</style>
<div class="rowContainer" id="container_${pageDesign.layoutId}">
	<div class="row margin-true">
		<div class="col12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
	</div>
	
	<div class="row margin-true">
		<div class="col4 acol12 ccol2" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
		<div class="col8 acol12 ccol10 right" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
	</div>
</div>

<!-- END SubCategoryPageContainer.jsp -->
