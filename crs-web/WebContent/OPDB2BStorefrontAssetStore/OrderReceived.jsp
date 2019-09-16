

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="Common/EnvironmentSetup.jspf" %>
<%@ page import="java.util.*" %>

<wcf:rest var="orderEmailDetails" url="store/${WCParam.storeId}/orderEmail/ONOrderEmailDetails/${WCParam.orderId}" scope="request">
		<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
		<wcf:var name="orderId" value = "${WCParam.orderId}" encode="true"/>
</wcf:rest>

<c:set var="storeId" value="${WCParam.storeId}" scope="page" />
<c:set var="orderId" value="${WCParam.orderId}" scope="page" />
<c:set var="userType" value="${orderEmailDetails.userType}" scope="page" />
<c:set var="getFormattedName" value="${orderEmailDetails.getFormattedName}" scope="page" />
<c:set var="storeEntDisplayName" value="${orderEmailDetails.storeEntDisplayName}" scope="page" />
<c:set var="tempStr" value="${orderEmailDetails.tempStr}" scope="page" />
<c:set var="stName" value="${orderEmailDetails.stName}" scope="page" />
<c:set var="orgName" value="${orderEmailDetails.getOrganizationName}" scope="page" />
<c:set var="purchaseOrderNumber" value="${orderEmailDetails.purchaseOrderNumber}" scope="page" />
<c:set var="lastUpdateDateTime" value="${orderEmailDetails.lastUpdateDateTime}" scope="page" />
<c:set var="logonId" value="${orderEmailDetails.logonId}" scope="page" />
<c:set var="storeInformation" value="${orderEmailDetails.storeInformation}" scope="page" />
<c:set var="orgAddress" value="${orderEmailDetails.orgAddress}" scope="page" />
<c:set var="phone" value="${orderEmailDetails.Phone}" scope="page" />
<c:set var="email" value="${orderEmailDetails.Email}" scope="page" />
<c:set var="fax" value="${orderEmailDetails.Fax}" scope="page" />
<c:set var="costCenter" value="${orderEmailDetails.costCenter}" scope="page" />
<c:set var="shipAsCom" value="${orderEmailDetails.shipAsCom}" scope="page" />
<c:set var="deliveryAddress" value="${orderEmailDetails.deliveryAddress}" scope="page" />
<c:set var="orderComment" value="${orderEmailDetails.orderComment}" scope="page" />

<c:set var="paymentMethod" value="${orderEmailDetails.paymentMethod}" scope="page" />
<c:set var="paymentBillFirstname" value="${orderEmailDetails.paymentBillFirstname}" scope="page" />
<c:set var="paymentBillLastname" value="${orderEmailDetails.paymentBillLastname}" scope="page" />
<c:set var="paymentBillAddress1" value="${orderEmailDetails.paymentBillAddress1}" scope="page" />
<c:set var="paymentBillAddress2" value="${orderEmailDetails.paymentBillAddress2}" scope="page" />
<c:set var="paymentBillAddress3" value="${orderEmailDetails.paymentBillAddress3}" scope="page" />
<c:set var="paymentBillCity" value="${orderEmailDetails.paymentBillCity}" scope="page" />
<c:set var="paymentBillState" value="${orderEmailDetails.paymentBillState}" scope="page" />
<c:set var="paymentBillZipCode" value="${orderEmailDetails.paymentBillZipCode}" scope="page" />
<c:set var="paymentBillCountry" value="${orderEmailDetails.paymentBillCountry}" scope="page" />
<c:set var="paymentBillPhone" value="${orderEmailDetails.paymentBillPhone}" scope="page" />

<c:set var="distinctShipAddressId" value="${orderEmailDetails.distinctShipAddressId[0]}" scope="page" />
<c:set var="distinctShipAddressMap" value="${orderEmailDetails.distinctShipAddressMap}" scope="page" />

<c:set var="bgColor1" value="${distinctShipAddressMap.bgColor}" scope="page" />
<c:set var="ezyCode1" value="${distinctShipAddressMap.ezyCode}" scope="page" />
<c:set var="partNumber1" value="${distinctShipAddressMap.partNumber}" scope="page" />
<c:set var="orderItemName1" value="${distinctShipAddressMap.orderItemName}" scope="page" />
<c:set var="orderItemComments1" value="${distinctShipAddressMap.orderItemComments}" scope="page" />
<c:set var="unitOfMeasure1" value="${distinctShipAddressMap.unitOfMeasure}" scope="page" />
<c:set var="orderItemPrice1" value="${distinctShipAddressMap.orderItemPrice}" scope="page" />
<c:set var="orderItemQuantity1" value="${distinctShipAddressMap.orderItemQuantity}" scope="page" />  			
<c:set var="itemSubTotal1" value="${distinctShipAddressMap.itemSubTotal}" scope="page" />  

<c:set var="indexes2" value="${orderEmailDetails.indexes2}" scope="page" />  
	
<c:if test="${indexes2 ne 'abc'}">

	<c:set var="indexes2Map" value="${orderEmailDetails.indexes2Map}" scope="page" />
	
	<c:set var="bgColor2" value="${indexes2Map.bgColor}" scope="page" />
	<c:set var="ezyCode2" value="${indexes2Map.ezyCode}" scope="page" />
	<c:set var="partNumber2" value="${indexes2Map.partNumber}" scope="page" />
	<c:set var="orderItemName2" value="${indexes2Map.orderItemName}" scope="page" />
	<c:set var="orderItemComments2" value="${indexes2Map.orderItemComments}" scope="page" />
	<c:set var="unitOfMeasure2" value="${indexes2Map.unitOfMeasure}" scope="page" />
	<c:set var="orderItemPrice2" value="${indexes2Map.orderItemPrice}" scope="page" />
	<c:set var="orderItemQuantity2" value="${indexes2Map.orderItemQuantity}" scope="page" />  			
	<c:set var="itemSubTotal2" value="${indexes2Map.itemSubTotal}" scope="page" /> 
	
</c:if>


<c:set var="pSTotalLabel" value="${orderEmailDetails.pSTotalLabel}" scope="page" />  
<c:set var="pSTotal" value="${orderEmailDetails.pSTotal}" scope="page" />  
<c:set var="displayOrderChargeTax" value="${orderEmailDetails.displayOrderChargeTax}" scope="page" />  
<c:set var="orderReceivedOrderDiscount" value="${orderEmailDetails.orderReceivedOrderDiscount}" scope="page" />  
<c:set var="orderLevelDiscountForDisplay" value="${orderEmailDetails.orderLevelDiscountForDisplay}" scope="page" />  
<c:set var="getDiscountAdjustmentTotal" value="${orderEmailDetails.getDiscountAdjustmentTotal}" scope="page" />  
<c:set var="orderReceivedMinusAdjustmentString" value="${orderEmailDetails.orderReceivedMinusAdjustmentString}" scope="page" />  
<c:set var="orderReceivedMinusAdjustmentValue" value="${orderEmailDetails.orderReceivedMinusAdjustmentValue}" scope="page" />  
<c:set var="getFormattedTotalShippingCharge" value="${orderEmailDetails.getFormattedTotalShippingCharge}" scope="page" />  
<c:set var="label" value="${orderEmailDetails.label}" scope="page" />  
<c:set var="getFormattedTotalShippingCharges" value="${orderEmailDetails.getFormattedTotalShippingCharges}" scope="page" />  
<c:set var="getFormattedTotalShippingTax" value="${orderEmailDetails.getFormattedTotalShippingTax}" scope="page" />  
<c:set var="orderReceivedShippingTaxString" value="${orderEmailDetails.orderReceivedShippingTaxString}" scope="page" />  
<c:set var="orderReceivedShippingTaxValue" value="${orderEmailDetails.orderReceivedShippingTaxValue}" scope="page" />  
<c:set var="totalExGst" value="${orderEmailDetails.totalExGst}" scope="page" />  
<c:set var="orderReceivedTaxString" value="${orderEmailDetails.orderReceivedTaxString}" scope="page" />  
<c:set var="orderReceivedTaxValue" value="${orderEmailDetails.orderReceivedTaxValue}" scope="page" />  
<c:set var="oTotal" value="${orderEmailDetails.oTotal}" scope="page" />  
<c:set var="minChargeApply" value="${orderEmailDetails.minChargeApply}" scope="page" />  
<c:set var="minCharges" value="${orderEmailDetails.minCharges}" scope="page" />  
<c:set var="minValue" value="${orderEmailDetails.minValue}" scope="page" />  
<c:set var="orderReceivedOrderTotal" value="${orderEmailDetails.orderReceivedOrderTotal}" scope="page" />  
<c:set var="scCharges" value="${orderEmailDetails.scCharges}" scope="page" /> 
<c:set var="grandTotal" value="${orderEmailDetails.grandTotal}" scope="page" /> 

<c:set var="promoCode" value="${orderEmailDetails.promoCode}" scope="page" /> 
<c:set var="shippingInstructions" value="${orderEmailDetails.shippingInstructions}" scope="page" />
<c:set var="dob" value="${orderEmailDetails.dob}" scope="page" />


<%! 

	public String headerRow(String label, String data) {
		StringBuffer buf = new StringBuffer();
		
		buf.append("<tr>");
		buf.append("<td width=\"20%\" valign=\"top\">");
		buf.append("<b>" + label +"</b>");
		buf.append("</td>");
		buf.append("<td>");
		buf.append(data);
		buf.append("</td>");
		buf.append("</tr>");
		
		return buf.toString();
	}


	// TextAlign numbers
	private static final int HEADING_SIDE = 50;
	private static final int NUMBER_SIDE = 20;
	private static final String ENCODING = "UTF-8";
	
	private static final String HTML_LINEBREAK = "<BR/>";

%>

<% 
	
	String stId = pageContext.getAttribute("storeId").toString();
	String orderId = pageContext.getAttribute("orderId").toString();
	String userType = pageContext.getAttribute("userType").toString();
	String getFormattedName = pageContext.getAttribute("getFormattedName").toString();
	String storeEntDisplayName = pageContext.getAttribute("storeEntDisplayName").toString();
	String tempStr = pageContext.getAttribute("tempStr").toString();
	String stName = pageContext.getAttribute("stName").toString();
	String orgName = pageContext.getAttribute("orgName").toString();
	String purchaseOrderNumber = pageContext.getAttribute("purchaseOrderNumber").toString();
	String lastUpdateDateTime = pageContext.getAttribute("lastUpdateDateTime").toString();
	String logonId = pageContext.getAttribute("logonId").toString();
 	String phone = pageContext.getAttribute("phone").toString();
	String email = pageContext.getAttribute("email").toString();
 	String fax = pageContext.getAttribute("fax").toString();
 	String costCenter = pageContext.getAttribute("costCenter").toString();
	String shipAsCom = pageContext.getAttribute("shipAsCom").toString();
 	String deliveryAddress = pageContext.getAttribute("deliveryAddress").toString();
 	String orderComment = pageContext.getAttribute("orderComment").toString(); 	
 	String storeInformation = pageContext.getAttribute("storeInformation").toString();
 	String orgAddress = pageContext.getAttribute("orgAddress").toString();
 	
 	String paymentMethod = pageContext.getAttribute("paymentMethod").toString(); 	
 	String paymentBillFirstname = pageContext.getAttribute("paymentBillFirstname").toString(); 	
 	String paymentBillLastname = pageContext.getAttribute("paymentBillLastname").toString(); 	
 	String paymentBillAddress1 = pageContext.getAttribute("paymentBillAddress1").toString(); 	
 	String paymentBillAddress2 = pageContext.getAttribute("paymentBillAddress2").toString(); 	
 	String paymentBillAddress3 = pageContext.getAttribute("paymentBillAddress3").toString(); 	
 	String paymentBillCity = pageContext.getAttribute("paymentBillCity").toString(); 	
 	String paymentBillState = pageContext.getAttribute("paymentBillState").toString(); 	
 	String paymentBillZipCode = pageContext.getAttribute("paymentBillZipCode").toString(); 	
 	String paymentBillCountry = pageContext.getAttribute("paymentBillCountry").toString(); 	
 	String paymentBillPhone = pageContext.getAttribute("paymentBillPhone").toString(); 	
 	
 	String distinctShipAddressId = pageContext.getAttribute("distinctShipAddressId").toString();
 	String bgColor1 = pageContext.getAttribute("bgColor1").toString();
 	String ezyCode1 = pageContext.getAttribute("ezyCode1").toString();
 	String partNumber1 = pageContext.getAttribute("partNumber1").toString();
 	String orderItemName1 = pageContext.getAttribute("orderItemName1").toString();
 	String orderItemComments1 = pageContext.getAttribute("orderItemComments1").toString();
 	String unitOfMeasure1 = pageContext.getAttribute("unitOfMeasure1").toString();
 	String orderItemPrice1 = pageContext.getAttribute("orderItemPrice1").toString();
 	String orderItemQuantity1 = pageContext.getAttribute("orderItemQuantity1").toString();
 	String itemSubTotal1 = pageContext.getAttribute("itemSubTotal1").toString();

 	String indexes2 = pageContext.getAttribute("indexes2").toString();

 	if (indexes2.equalsIgnoreCase("abc")) {
 		
 	 	String bgColor2 = "a";
 	 	String ezyCode2 = "b";
 	 	String partNumber2 = "c";
 	 	String orderItemName2 = "d";
 	 	String orderItemComments2 = "e";
 	 	String unitOfMeasure2 = "f";
 	 	String orderItemPrice2 = "g";
 	 	String orderItemQuantity2 = "h";
 	 	String itemSubTotal2 = "i";

 	}	else {
 		
	 	String bgColor2 = pageContext.getAttribute("bgColor2").toString();
	 	String ezyCode2 = pageContext.getAttribute("ezyCode2").toString();
	 	String partNumber2 = pageContext.getAttribute("partNumber2").toString();
	 	String orderItemName2 = pageContext.getAttribute("orderItemName2").toString();
	 	String orderItemComments2 = pageContext.getAttribute("orderItemComments2").toString();
	 	String unitOfMeasure2 = pageContext.getAttribute("unitOfMeasure2").toString();
	 	String orderItemPrice2 = pageContext.getAttribute("orderItemPrice2").toString();
	 	String orderItemQuantity2 = pageContext.getAttribute("orderItemQuantity2").toString();
	 	String itemSubTotal2 = pageContext.getAttribute("itemSubTotal2").toString();
 		
 	}
 	
 	String pSTotalLabel = pageContext.getAttribute("pSTotalLabel").toString();
 	String pSTotal = pageContext.getAttribute("pSTotal").toString();
 	String displayOrderChargeTax = pageContext.getAttribute("displayOrderChargeTax").toString();
 	String orderReceivedOrderDiscount = pageContext.getAttribute("orderReceivedOrderDiscount").toString();
 	String orderLevelDiscountForDisplay = pageContext.getAttribute("orderLevelDiscountForDisplay").toString(); 	
 	String getDiscountAdjustmentTotal = pageContext.getAttribute("getDiscountAdjustmentTotal").toString();
 	String orderReceivedMinusAdjustmentString = pageContext.getAttribute("orderReceivedMinusAdjustmentString").toString();
 	String orderReceivedMinusAdjustmentValue = pageContext.getAttribute("orderReceivedMinusAdjustmentValue").toString(); 
 	String getFormattedTotalShippingCharge = pageContext.getAttribute("getFormattedTotalShippingCharge").toString();
 	String label = pageContext.getAttribute("label").toString();
 	String getFormattedTotalShippingCharges = pageContext.getAttribute("getFormattedTotalShippingCharges").toString(); 	
 	String getFormattedTotalShippingTax = pageContext.getAttribute("getFormattedTotalShippingTax").toString();
 	String orderReceivedShippingTaxString = pageContext.getAttribute("orderReceivedShippingTaxString").toString();
 	String orderReceivedShippingTaxValue = pageContext.getAttribute("orderReceivedShippingTaxValue").toString(); 	
 	String totalExGst = pageContext.getAttribute("totalExGst").toString();
 	String orderReceivedTaxString = pageContext.getAttribute("orderReceivedTaxString").toString();
 	String orderReceivedTaxValue = pageContext.getAttribute("orderReceivedTaxValue").toString(); 	
 	String oTotal = pageContext.getAttribute("oTotal").toString();
 	String minChargeApply = pageContext.getAttribute("minChargeApply").toString();
 	String minCharges = pageContext.getAttribute("minCharges").toString();
 	String minValue = pageContext.getAttribute("minValue").toString();
 	String orderReceivedOrderTotal = pageContext.getAttribute("orderReceivedOrderTotal").toString();
 	String scCharges = pageContext.getAttribute("scCharges").toString();
 	String grandTotal = pageContext.getAttribute("grandTotal").toString();
 	String promoCode = pageContext.getAttribute("promoCode").toString();
 	String shippingInstructions = pageContext.getAttribute("shippingInstructions").toString();
 	String dob = pageContext.getAttribute("dob").toString();


 	
 	
	if(!userType.equalsIgnoreCase("G")){
	
	if(stId.equalsIgnoreCase("80355") || stId.equalsIgnoreCase("98552") || stId.equalsIgnoreCase("81852")) 
	{
		out.println("<span style=\"font-size:12;font-family:'Verdana','sans serif'\"><b>The following order has been submitted "+tempStr+" to " + stName + " by " + getFormattedName + " of " + orgName + "</b></span>");
	}
	else
	{
		out.println("<span style=\"font-size:12;font-family:'Verdana','sans serif'\"><b>The following order has been submitted "+tempStr+" to " + storeEntDisplayName + " by " + getFormattedName + " of " + orgName + "</b></span>");
	}
	
	out.println(HTML_LINEBREAK);
	out.println(HTML_LINEBREAK);
	
	out.println("<table style=\"padding: 0; font-size:12;font-family:'Verdana','sans serif'\" width=\"100%\">");
	out.println(headerRow("Order No:", orderId));
	
	out.println(headerRow("Purchase Order No:", purchaseOrderNumber));
	
	out.println(headerRow("Date & Time", lastUpdateDateTime));

	out.println("<tr><td colspan='2'><br/><b>Please contact the store for any enquires</b></td></tr>");

	out.println(headerRow("Store Information:", storeInformation));		
	
	out.println(headerRow("User ID:", logonId));
	
	out.println(headerRow("Name:", getFormattedName));
	out.println(headerRow("Company:", orgName));

	if (phone != null && phone.trim().length() != 0) {
		out.println(headerRow("Phone:", phone));
	}	
	
	if (email != null && email.trim().length() != 0) {
		out.println(headerRow("Email:", email));
	}	
	
	if (fax != null && fax.trim().length() != 0) {
		out.println(headerRow("Fax:", fax));
	}		
	
	out.println(headerRow("Cost Center:", costCenter));	
	
	out.println(headerRow("Customer Organization Address:", orgAddress));
	
	out.println(headerRow("Ship as Complete:", shipAsCom));
	
	
	if (distinctShipAddressId != null) {
		
		out.println(headerRow("Delivery Address:", deliveryAddress));
	
	if (orderComment != null && orderComment.trim().length() != 0) {
		out.println(headerRow(" ", " "));
		out.println(headerRow("Order Comment:", orderComment));
	}		

	}
	
	
	out.println("</table>");
	
	out.println(HTML_LINEBREAK);

	out.println("<table style=\"padding: 0; font-size:12;font-family:'Verdana','sans serif'\" width=\"100%\">");
	out.println("<tr>");
	out.println("<td width=\"20%\" valign=\"top\">");
	out.println("<b>Payment Information:</b>");
	out.println("</td>");
	out.println("<td>");
	out.println("<table style=\"padding: 5; font-size:12;font-family:'Verdana','sans serif'\" width=\"60%\">");
	out.println("<tr BGCOLOR=\"#808080\" style=\"color: #FFFFFF\">");
	out.println("<td>");
	out.println("Payment Method");
	out.println("</td>");
	out.println("<td>");
	out.println("Billing Address");
	out.println("</td>");
	out.println("</tr>");	
	
	out.print("<tr valign=\"top\" ><td>" + paymentMethod + "</td>");
	out.println("<td>");
	
		out.println(logonId);
		out.println(HTML_LINEBREAK + paymentBillFirstname + " " + paymentBillLastname);
	   if (paymentBillAddress1.length() != 0) {
	  	      out.println(HTML_LINEBREAK + paymentBillAddress1);
	  	   }
  	   if (paymentBillAddress2.length() != 0) {
   	      out.println(HTML_LINEBREAK + paymentBillAddress2);
   	   }
   	   if (paymentBillAddress3.length() != 0) {
   	      out.println(HTML_LINEBREAK + paymentBillAddress3);
   	   }
   	   if (paymentBillCity.length() != 0) {
   	      out.println(HTML_LINEBREAK + paymentBillCity + ", " + paymentBillState);
   	   }
   	   if (paymentBillCountry.length() != 0) {
   	      out.println(HTML_LINEBREAK + paymentBillCountry + ", " + paymentBillZipCode);
   	   }
 	   out.println("</td></tr>");
 	   
	out.println("</table></td></tr>");
	out.println("</table>"); 	   
  
	out.println(HTML_LINEBREAK); 
 	   
	out.println("<TABLE cellpadding=\"2\" style=\"font-size:12;font-family:'Verdana','sans serif';\" width=\"100%\">");
	out.println("<TR BGCOLOR=#808080 style=\"color: #FFFFFF\">");
	out.println("<TD>Previous Code</TD><TD>Ezcode</TD><TD>Description</TD><TD align=\"center\">Unit</TD><TD align=\"center\">Price</TD><TD align=\"center\">Qty</TD><TD align=\"center\">Total</TD>");
	out.println("</TR>");	
	
	
	if (distinctShipAddressId != null) {
		
		out.print("<TR BGCOLOR=\"" + bgColor1 + "\">");
		out.print("<TD valign=\"top\">" + ezyCode1 + "</TD>");
		out.print("<TD valign=\"top\">" + partNumber1 + "</TD>");
		out.print("<TD>" + orderItemName1);
		
		if (orderItemComments1 != null && orderItemComments1.trim().length() != 0) {
			out.print("<BR /><BR /> <b>Comments:</b> <BR />" + orderItemComments1 +"<BR /><BR /></TD>");
		} else {
			out.print("</TD>");
		}
		
		out.print("<TD valign=\"top\" align=\"center\">" + unitOfMeasure1 + "</TD>");
		out.print("<TD valign=\"top\" align=\"right\">" + orderItemPrice1 + "</TD>");
		out.print("<TD valign=\"top\" align=\"center\">" + orderItemQuantity1 + "</TD>");
		
		out.print("<TD valign=\"top\" align=\"right\">" + itemSubTotal1 + "</TD>");

	}

 	if (indexes2.equalsIgnoreCase("abc")) {

 	}
 	else {
 		
		out.print("<TR BGCOLOR=\"" + bgColor1 + "\">");
		out.print("<TD valign=\"top\">" + ezyCode1 + "</TD>");
		out.print("<TD valign=\"top\">" + partNumber1 + "</TD>");
		out.print("<TD>" + orderItemName1);
		
		if (orderItemComments1 != null && orderItemComments1.trim().length() != 0) {
			out.print("<BR /><BR /> <b>Comments:</b> <BR />" + orderItemComments1 +"<BR /><BR /></TD>");
		} else {
			out.print("</TD>");
		}
		
		out.print("<TD valign=\"top\" align=\"center\">" + unitOfMeasure1 + "</TD>");
		out.print("<TD valign=\"top\" align=\"right\">" + orderItemPrice1 + "</TD>");
		out.print("<TD valign=\"top\" align=\"center\">" + orderItemQuantity1 + "</TD>");
		
		out.print("<TD valign=\"top\" align=\"right\">" + itemSubTotal1 + "</TD>");
		
		
 	}
	
 	
	out.print("<TR>");
	out.print("<TD colspan=6 align=\"right\"><b>"+pSTotalLabel+"</b></TD>");
	out.print("<TD align=\"right\">" + pSTotal + "</TD>");
	out.println("</TR>");
 	
 	if(displayOrderChargeTax.equalsIgnoreCase("true")){		
 		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">" + orderReceivedOrderDiscount + "</TD>");
		out.print("<TD align=\"right\">" + orderLevelDiscountForDisplay + "</TD>");
		out.println("</TR>");			
 	}
 	
 	
 	if(getDiscountAdjustmentTotal.equalsIgnoreCase("true")){		
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">" + orderReceivedMinusAdjustmentString + "</TD>");
		out.print("<TD align=\"right\">" + orderReceivedMinusAdjustmentValue + "</TD>");
		out.println("</TR>");		
 	}
	
 	
 	if(getFormattedTotalShippingCharge.equalsIgnoreCase("true")){		
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">" + label + "</TD>");
		out.print("<TD align=\"right\">" + getFormattedTotalShippingCharges + "</TD>");
		out.println("</TR>");	
 	}
 	
 	
 	if(getFormattedTotalShippingTax.equalsIgnoreCase("true")){
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">" + orderReceivedShippingTaxString + "</TD>");
		out.print("<TD align=\"right\">" + orderReceivedShippingTaxValue + "</TD>");
		out.println("</TR>");
 	}
 	
	if (totalExGst != null && Double.valueOf(totalExGst) > 0.00) {
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">" + orderReceivedTaxString + "</TD>");
		out.print("<TD align=\"right\">" + orderReceivedTaxValue + "</TD>");
		out.println("</TR>");
	}
 	
	boolean checkTotal = false;
	java.text.DecimalFormat converter = new java.text.DecimalFormat("0.00");
	
	if(minChargeApply.equalsIgnoreCase("true")  && (Double.valueOf(oTotal) < Double.valueOf(minCharges))){ 	
		
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">Minimum Order Charges:</TD>");
		out.print("<TD align=\"right\">$"+minValue+"</TD>");
		out.println("</TR>");
		
		checkTotal = true;
		
	}
	
	out.print("<TR>");
	out.print("<TD colspan=6 align=\"right\"><b>" + orderReceivedOrderTotal + "<b></TD>");
	
	if(checkTotal){
		Double oFTotal = Double.valueOf(oTotal) + Double.valueOf(minValue) + Double.valueOf(scCharges);	
		out.print("<TD align=\"right\" bgcolor=\"#808080\" style=\"color: #FFFFFF\"><b>$" + converter.format(oFTotal) + "</b></TD>");

	}
	else{
		out.print("<TD align=\"right\" bgcolor=\"#808080\" style=\"color: #FFFFFF\"><b>" + grandTotal + "</b></TD>");
	}

	out.println("</TR>");
	
	
	
	if(promoCode != null && !"".equalsIgnoreCase(promoCode)){
		out.print("<TR>");
		out.print("<TD colspan=6 align=\"right\">Promotion Code:</TD>");
		out.print("<TD align=\"right\">"+promoCode+"</TD>");
		out.println("</TR>");
		checkTotal = true;
	}
	

	out.println("</TABLE>");
	
	out.println(HTML_LINEBREAK); 
	
	out.println("<table style=\"padding: 0; font-size:12;font-family:'Verdana','sans serif'\" width=\"100%\">");
	out.println("<tr>");
	out.println("<td width=\"10%\">");
	out.println("<b>Comment:</b>");
	out.println("</td>");
	out.println("<td>");	
	
	if (shippingInstructions != null  && !shippingInstructions.equalsIgnoreCase("None")) {
		out.println(shippingInstructions);
	}
	else {
		out.println("");		
	}
	
	if(stId.equalsIgnoreCase(String.valueOf("33101"))){
		out.println(" DOB: "+dob);
	}
	
	out.println("</td>");
	out.println("</tr>");
	out.println("</table>");

	
	}		
	
	
%>











