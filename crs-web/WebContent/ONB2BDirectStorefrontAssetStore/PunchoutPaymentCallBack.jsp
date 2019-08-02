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


<HTML lang="en">
	<HEAD><TITLE>Punchout Payment Result</TITLE></HEAD>
	<BODY>
<%
	//FUSION COMMERCE MODIFICATIONS START
String paymentMethod = "PayPal";
String storeId = (String) request.getAttribute("storeId");
String catalogId = (String) request.getAttribute("catalogId");
if ("70952".equalsIgnoreCase(storeId)) {
	catalogId = "15802";
}
String langId ="-1";
String orderId = (String) request.getAttribute("orderId");
String shipmentTypeId = (String) request.getAttribute("shipmentTypeId");
String chkurl =  request.getParameter("chkurl");
String cCentreId =  request.getParameter("cCentreId");
String poId =  request.getParameter("poid");
String domainNameForON = request.getParameter("domainNameForON").toString();

if("localhost".equalsIgnoreCase(domainNameForON)){
	domainNameForON=domainNameForON+":8443";
	
}
//FUSION COMMERCE MODIFICATIONS END
if ("SimplePunchoutPlugin".equalsIgnoreCase(paymentMethod)) {

	out.println("DONE");
}
//FUSION COMMERCE MODIFICATIONS START
else if ("PayPal".equalsIgnoreCase(paymentMethod)){
	if(chkurl.equals("cancel")){
		if("70952".equalsIgnoreCase(storeId) || "69452".equalsIgnoreCase(storeId)){
			response.sendRedirect("https://www.shredderbrands.com.au/wcs/shop/OrderShippingBillingView?fromPayPal=true&shipmentType=single&catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId);
		}
		else{
			response.sendRedirect("https://"+domainNameForON+"/wcs/shop/OrderShippingBillingView?fromPayPal=true&shipmentType=single&catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId);
		}
	}
	else if(chkurl.equals("return")){
		if("70952".equalsIgnoreCase(storeId) || "69452".equalsIgnoreCase(storeId)){
			response.sendRedirect("https://www.shredderbrands.com.au/wcs/shop/SingleShipmentOrderSummaryView?catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId+"&poid="+poId+"&cCentreId="+cCentreId);
		}
		else{
			response.sendRedirect("https://"+domainNameForON+"/wcs/shop/SingleShipmentOrderSummaryView?catalogId="+catalogId+"&orderId="+orderId+"&storeId="+storeId+"&poid="+poId+"&cCentreId="+cCentreId);
		}		
	}
}
//FUSION COMMERCE MODIFICATIONS END


%>

</BODY>
</HTML>

