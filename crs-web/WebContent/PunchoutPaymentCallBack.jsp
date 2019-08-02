<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
hjghfhfhfhf
<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
<HTML lang="en">
	<HEAD><TITLE>Punchout Payment Result</TITLE></HEAD>
	<BODY>
<%
String paymentMethod = (String) request.getAttribute("punchoutPaymentMethod");
if ("SimplePunchoutPlugin".equalsIgnoreCase(paymentMethod)) {
	out.println("DONE");
}
%>
</BODY>
</HTML>

 --%>

<%@ page import="com.ibm.commerce.payments.plugincontroller.PPCConstants"%>
<HTML lang="en">
	<HEAD><TITLE>Punchout Payment Result</TITLE></HEAD>
	<BODY>
<%
	//FUSION COMMERCE MODIFICATIONS START
String paymentMethod = (String) request.getAttribute(PPCConstants.PUNCHOUT_PAYMENT_METHOD);
String storeId = (String) request.getAttribute("storeId");
String catalogId = (String) request.getAttribute("catalogId");
if ("70952".equalsIgnoreCase(storeId)) {
	catalogId = "15802";
}
String langId = (String) request.getAttribute("langId");
String orderId = (String) request.getAttribute("orderId");
String shipmentTypeId = (String) request.getAttribute("shipmentTypeId");
String chkurl =  request.getParameter("chkurl");
String cCentreId =  request.getParameter("cCentreId");
String poId =  request.getParameter("poid");
String domainNameForON =  "localhost:8443";//request.getParameter("domainNameForON").toString();


//FUSION COMMERCE MODIFICATIONS END
if ("SimplePunchoutPlugin".equalsIgnoreCase(paymentMethod)) {

	out.println("DONE");
}
//FUSION COMMERCE MODIFICATIONS START
else if ("PayPal".equalsIgnoreCase(paymentMethod)){
	if(chkurl.equals("cancel")){
		if("70952".equalsIgnoreCase(storeId) || "69452".equalsIgnoreCase(storeId)){
			response.sendRedirect("http://www.shredderbrands.com.au/webapp/wcs/stores/servlet/OrderShippingBillingView?fromPayPal=true&shipmentType=single&catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId);
		}
		else{
			response.sendRedirect("http://"+domainNameForON+"/webapp/wcs/stores/servlet/OrderShippingBillingView?fromPayPal=true&shipmentType=single&catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId);
		}
	}
	else if(chkurl.equals("return")){
		if("70952".equalsIgnoreCase(storeId) || "69452".equalsIgnoreCase(storeId)){
			response.sendRedirect("https://www.shredderbrands.com.au/webapp/wcs/stores/servlet/SingleShipmentOrderSummaryView?catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId+"&poid="+poId+"&cCentreId="+cCentreId);
		}
		else{
			response.sendRedirect("https://"+domainNameForON+"/webapp/wcs/stores/servlet/SingleShipmentOrderSummaryView?catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId+"&poid="+poId+"&cCentreId="+cCentreId);
		}		
	}
}
//FUSION COMMERCE MODIFICATIONS END


%>

</BODY>
</HTML>

