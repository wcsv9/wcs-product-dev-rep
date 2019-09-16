
<!-- BEGIN OrderReceivedApprovalSubmittedDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ page import="java.util.*" %>

<%@ page import="com.ibm.commerce.approval.objects.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.server.*" %>

<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>

	<wcf:rest var="ONOrderReceivedApprovalSubmittedDisplay" url="store/${WCParam.storeId}/orderApproval/ONOrderReceivedApprovalSubmittedDisplay/${WCParam.catalogId}/${WCParam.langId}/${WCParam.orderId}/${WCParam.appMailAddress}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
      		<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="orderId" value="${WCParam.orderId}"/>
			<wcf:var name="appMailAddress" value="${WCParam.appMailAddress}"/>	     		
	</wcf:rest>	

<c:set var="subLogonId" value="${ONOrderReceivedApprovalSubmittedDisplay.subLogonId}" />
<c:set var="subFirstName" value="${ONOrderReceivedApprovalSubmittedDisplay.subFirstName}" />
<c:set var="subLastName" value="${ONOrderReceivedApprovalSubmittedDisplay.subLastName}" />
<c:set var="notExp" value="${ONOrderReceivedApprovalSubmittedDisplay.notExp}" />
<c:set var="orderStatus" value="${ONOrderReceivedApprovalSubmittedDisplay.orderStatus}" />
<c:set var="formattedActualShipDate" value="${ONOrderReceivedApprovalSubmittedDisplay.formattedActualShipDate}" />
<c:set var="formattedEstimatedShipDate" value="${ONOrderReceivedApprovalSubmittedDisplay.formattedEstimatedShipDate}" />
<c:set var="poNumber" value="${ONOrderReceivedApprovalSubmittedDisplay.poNumber}" />
<c:set var="costCenter" value="${ONOrderReceivedApprovalSubmittedDisplay.costCenter}" />
<c:set var="comments" value="${ONOrderReceivedApprovalSubmittedDisplay.comments}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Order Approval</title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>

<body onload="OrderReceivedApprovalSubmittedDisplayInit()" style="background-image: none;">

	<table cellpadding="8" cellspacing="0" width="80%" class="noBorder" id="WC_OrderDetailDisplay_Table_2">
		<tr>
			<td id="WC_OrderDetailDisplay_TableCell_3">
				<h1>Order ${ONOrderReceivedApprovalSubmittedDisplay.displayMsg } <span style="font-size:15px">Order Number:  ${WCParam.orderId}</span></h1>
				
				<c:if test="${!empty subLogonId}">
					<strong>Order Submitted by:&nbsp;<c:out value="${subFirstName}"/>&nbsp;<c:out value="${subLastName}"/> (<c:out value="${subLogonId}"/>)</strong>
				</c:if>
		
				<c:if test = "${fn:containsIgnoreCase(notExp, 'true')}">					
					<table>
					<c:if test="${!empty orderStatus}">
						<tr>
							<span class="c_headings">
								<c:choose>
									<c:when test="${orderStatus eq 'S'}">
										<td>Shipment Date:</td>
										
									</c:when>
									<c:otherwise>
										<td>Estimated Shipment Date:</td>
			
									</c:otherwise>
								</c:choose>
							</span>
						</tr>
					</c:if>
						<tr>
							<td>
								Purchase Order No:
							</td>
							
						<td>
							<c:set var="poNumber" value="${ONOrderReceivedApprovalSubmittedDisplay.poNumber}" />
							<c:if test="${empty poNumber}">
									<c:out value="${poNumber}" />
							</c:if>
							
						</td>							
												
						</tr>
						<tr>
							<td>
								Cost Center:	
							</td>
							<td>
								<c:out value="${costCenter}" />
							</td>
						</tr>	
	
						<tr>
							<td valign="top">
								Comments:&nbsp;&nbsp;
							</td>
							<td valign="top">
								<c:out value="${comments}" />							
							</td>
						</tr>	
								
											
					</table>
					
					<%@ include file="OrderReceivedApprovalOrderItemDisplay.jspf"%>

				<%-- ******************************************************************************************************************************* --%>
				<%-- * Get order item details - must be same retrieval as "ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp" * --%>
				<%-- ******************************************************************************************************************************* --%>
				<c:set var="ZZOrderId" value="${WCParam.orderId}"/>


	<wcf:rest var="orderIdd" url="store/${WCParam.storeId}/order/{orderId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
      		<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="orderId" value="${ZZOrderId}"/>	     		
	</wcf:rest>	
	
				

				<%out.flush();%>
				<c:import url="/${sdb.jspStoreDir}/UserArea/ServiceSection/RemoteApprovalSubsection/SingleShipmentOrderTotalsSummaryForApproval.jsp">				
					<c:param name="fromPage" value="orderConfirmationPage"/>
				</c:import>
				<%out.flush();%>
				
				</c:if>
				
			</td>
		</tr>
	</table>


	<div style="display: hidden">
	<form name="forceLogoff" action="Logoff" method="post">
		<input type="hidden" name="langId" value="-1"/>
		<input type="hidden" name="storeId" value="${WCParam.storeId}"/>
		<input type="hidden" name="catalogId" value="10051"/>
		<input type="hidden" name="URL" value="\"/>
	</form>
	</div>


</body>

<script type="text/javascript" language="javascript">
function OrderReceivedApprovalSubmittedDisplayInit() {
	forceLogoffWindow = window.open("OrderReceivedApprovalLogoff?message=${WCParam.message}","forceLogoffWindow","width=1,height=1");
	disableAllLinks();
}

function disableAllLinks() {
	var links = document.getElementsByTagName("a");
	for (var i=0;i<links.length;i++) {
		links[i].removeAttribute("href");
	}
}
</script>
<!-- END OrderReceivedApprovalSubmittedDisplay.jsp -->



</html>