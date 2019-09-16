<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ page contentType="text/html; charset=UTF-8" %>


<flow:ifEnabled feature="Analytics">
<%@include file="AnalyticsFacetSearch.jspf" %>   
 	<cm:product catentryId="${WCParam.productId}" extraparms="null, ${analyticsFacet}" returnAsJSON="true"  />
</flow:ifEnabled>
