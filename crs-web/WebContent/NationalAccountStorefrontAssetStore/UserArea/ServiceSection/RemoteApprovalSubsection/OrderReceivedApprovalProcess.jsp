
<!-- BEGIN OrderReceivedApprovalProcess.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>

<c:set var="ONOrderReceivedEmailIncludeXML" value="true" />

<c:set var="storeId" value="${WCParam.storeId}"  scope="page"/>
<c:set var="catalogId" value="${WCParam.catalogId}"  scope="page"/>
<%-- <c:set var="approverId" value="${WCParam.approverId}"  scope="page"/> --%>
<%-- <c:set var="approverLogonId" value="${WCParam.approverLogonId}"  scope="page"/> --%>
<c:set var="approvalStatusId" value="${WCParam.approvalStatusId}"  scope="page"/>
<c:set var="langId" value="${WCParam.langId}"  scope="page"/>

<c:set var="hostName" value="${WCParam.ONOrderReceivedApprovalByEmailHost}"  scope="page"/>

<c:set var="forwardParameter" value="${WCParam.forwardParameter}" scope="page" />


	<c:if test="${forwardParameter != null}">

		<c:set var="replaceAND" value='${fn:replace(forwardParameter, ":AND:", "&")}' />
		<c:set var="replaceOR" value='${fn:replace(replaceAND, ":EQ:", "=")}' />
		<c:set var="splitparams" value='${fn:split(replaceOR, "&")}' />  				

		<c:set var="modifyOrder" value="${fn:split(splitparams[2], '=')}" />	 
		<c:set var="modifyOrder_key" value="${modifyOrder[0]}" />
		<c:set var="modifyOrder_value" value="${modifyOrder[1]}" />

		<c:set var="aprv_act" value="${fn:split(splitparams[3], '=')}" />	 
		<c:set var="aprv_act_key" value="${aprv_act[0]}" />
		<c:set var="aprv_act_value" value="${aprv_act[1]}" />
		
		<c:if test="${aprv_act_value == null}">
			<c:set var="aprv_act_value" value="null" />	
		</c:if>	

		<c:set var="editOrder" value="${fn:split(splitparams[4], '=')}" />	 
		<c:set var="editOrder_key" value="${edit[0]}" />
		<c:set var="editOrder_value" value="${edit[1]}" />	
		
		<c:if test="${editOrder_value == null}">
			<c:set var="editOrder_value" value="null" />	
		</c:if>	

		<c:set var="ordButtonApp" value="${fn:split(splitparams[5], '=')}" />	 
		<c:set var="ordButtonApp_key" value="${ordButtonApp[0]}" />
		<c:set var="ordButtonApp_value" value="${ordButtonApp[1]}" />	
		
		<c:if test="${ordButtonApp_value == null}">
			<c:set var="ordButtonApp_value" value="null" />	
		</c:if>	

		<c:set var="ordButtonRej" value="${fn:split(splitparams[6], '=')}" />	 
		<c:set var="ordButtonRej_key" value="${ordButtonRej[0]}" />
		<c:set var="ordButtonRej_value" value="${ordButtonRej[1]}" />	
		
		
		<c:if test="${ordButtonRej_value == null}">
			<c:set var="ordButtonRej_value" value="null" />	
		</c:if>	


	</c:if>	

	<wcf:rest var="orderApprovalProcess" url="store/${WCParam.storeId}/orderApproval/ONOrderApprovalProcess/${WCParam.catalogId}/${WCParam.langId}/${WCParam.orderId}/${approvalStatusId}/${aprv_act_value}/${modifyOrder_value}/${editOrder_value}/${ordButtonRej_value}/${ordButtonApp_value}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
      		<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="orderId" value="${WCParam.orderId}"/>
			<wcf:var name="approvalStatusId" value="${approvalStatusId}"/>
			<wcf:var name="aprv_act" value="${aprv_act_value}"/>
      		<wcf:var name="modifyOrder" value="${modifyOrder_value}"/>	
      		<wcf:var name="editOrder" value="${editOrder_value}"/>	
       		<wcf:var name="ordButtonRej" value="${ordButtonRej_value}"/>	
      		<wcf:var name="ordButtonApp" value="${ordButtonApp_value}"/>	     		
	</wcf:rest>	
	
	<c:set var="message" value="${orderApprovalProcess.message}" />
	<c:set var="appMailAddress" value="${orderApprovalProcess.appMailAddress}" />
	
	<c:if test="${message != null}">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Order Received Approval Process</title>
			</head>
				
			<body class="logon">
				<div style="display: hidden">
					<form name="approvalSubmitDisplayForm" action="OrderReceivedApprovalSubmittedDisplay" method="post">   
					    <input type="hidden" id="orderId" name="orderId" value="${WCParam.orderId}" />
						<input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
					    <input type="hidden" id="message" name="message" value="${message}" /> 
					    <input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
					    <input type="hidden" id="appMailAddress" name="appMailAddress" value="${appMailAddress}" />
					</form>
				</div>
		
				<script type="text/javascript" language="javascript">
				<!--<![CDATA[
					document.approvalSubmitDisplayForm.submit();
				//[[>-->
				</script>
	<!-- aliraza --> 
	
		<wcf:url var="SavedOrderListDisplayURL" value="OrderReceivedApprovalSubmittedDisplay">
			<wcf:param name="storeId"   value="${WCParam.storeId}"  />
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="langId" value="${WCParam.langId}" />  
			<wcf:param name="orderId" value="${WCParam.orderId}" /> 
			<wcf:param name="modifyOrder" value="true" /> 
		</wcf:url>
	
 	<!-- end ali raza -->			
			</body>
		</html>		
		
	
	</c:if>
	
<c:if test="${message == null}">

	<c:if test = "${fn:containsIgnoreCase(modifyOrder_value, 'false')}">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<title>Order Received Approval Process</title>
		</head>

		<body class="logon">
			<div style="display: hidden">
				<form name="commentsForm" action="RESTHandleApprovals" method="post">   
				   
				    <input type="hidden" id="approvalStatusId" name="approvalStatusId" value="${approvalStatusId}" />
				     <input type="hidden" id="aprv_act" name="aprv_act" value="${aprv_act_value}" />
				    <input type="hidden" id="viewtask" name="viewtask" value="${forwardURL}" />
				    <input type="hidden" name="authToken" value="${authToken}" />

		    		<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
				    <input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
				    <input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />				    
				    
 					<input type="hidden" name="URL" value="OrderReceivedApprovalSubmittedDisplay" />
					
					 <input type="hidden" id="orderId" name="orderId" value="${WCParam.orderId}" />
					  <input type="hidden" id="message" name="message" value="${message}" />
					 <input type="hidden" id="userId" name="userId" value="${WCParam.userId}" />
					 <input type="hidden" id="appMailAddress" name="appMailAddress" value="${appMailAddress}" />

					<input type="hidden" name="ONOrderReceivedEmailIncludeXML" value="<c:out value="${ONOrderReceivedEmailIncludeXML}"/>" id="ONOrderReceivedEmailIncludeXML"/>
				</form>
			</div>
		
			<script type="text/javascript" language="javascript">
			<!--<![CDATA[
				document.commentsForm.submit();
			//[[>-->
			</script>
		</body>

		</html>	
	
	</c:if>


	
	<c:if test = "${fn:containsIgnoreCase(modifyOrder_value, 'true')}">
	
	<c:set var="orderStatus" value="${orderApprovalProcess.orderStatus}" />	
	<c:set var="formattedActualShipDate" value="${orderApprovalProcess.formattedActualShipDate}" />	
	<c:set var="formattedEstimatedShipDate" value="${orderApprovalProcess.formattedEstimatedShipDate}" />	
	<c:set var="poNumber" value="${orderApprovalProcess.poNumber}" />
	<c:set var="costCenter" value="${orderApprovalProcess.costCenter}" />
	<c:set var="comments" value="${orderApprovalProcess.comments}" />
	<c:set var="editOrder" value="${WCParam.edit}" />
	
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<title>Order Approval</title>	
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>	
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreCommonUtilities.js"/>"></script>
		</head>
		
		<body style="background-image: none;">
		
		<img alt="<c:out value="${storeName}" />" src="<c:out value='${jspStoreImgDir}images/ON-logo.png'/>" />
		<br/><br/>
		
			<form name="approvalOrderDisplay" action="OrderReceivedApprovalUpdate"> 
			
				<table cellpadding="8" cellspacing="0" width="95%" style="margin-left:15px;" class="noBorder" id="WC_OrderDetailDisplay_Table_2">
					<tr>
						<td id="WC_OrderDetailDisplay_TableCell_3">
						
						<h1>Order ${orderApprovalProcess.displayMsg } &nbsp;&nbsp;&nbsp; <span style="font-size:15px">Order Number:  ${WCParam.orderId}</span></h1>
						
						<table>
							<c:if test="${!empty orderStatus}">
								<tr>
									<span class="c_headings">
										<c:choose>
											<c:when test="${orderStatus eq 'S'}">
												<td>Shipment Date:</td>
												<td><c:out value="${formattedActualShipDate}"/></td>	
											</c:when>
											<c:otherwise>
												<td>Estimated Shipment Date:</td>
												<td><c:out value="${formattedEstimatedShipDate}"/></td>																			
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
									<c:set var="poNumber" value="${poNumber}" />
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
						
						</td>
					</tr>

				<%-- ******************************************************************************************************************************* --%>
				<%-- * Get order item details - must be same retrieval as "ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp" * --%>
				<%-- ******************************************************************************************************************************* --%>					
	
				<tr> 
				 <td>
		 
					 <br/>
					 <c:choose>
					 <c:when test = "${fn:containsIgnoreCase(WCParam.edit, 'false')}">
					 
					 <input style="width:110px" type="hidden" value="<c:out value="${poNumber}" />" id="purchase_order_number" name="purchase_order_number"/>
					 
					 </c:when>
					 <c:otherwise>
					 
						<fmt:message key="PONUMBER" bundle="${storeText}"/>:
						<input style="width:110px" type="text" value="<c:out value="${poNumber}" />" id="purchase_order_number" name="purchase_order_number"/> 
					 
					 </c:otherwise>
					 </c:choose>
					 <input type="hidden" name="POId" id="POId" value="${poNumber}" />
					 
					 <flow:ifEnabled feature="ShippingInstructions">
				     	<c:set var="ZZOrderId" value="${WCParam.orderId}"/>
				     	<wcf:rest var="orderIdd" url="store/${WCParam.storeId}/order/{orderId}" scope="request">
							<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
							<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
				      		<wcf:var name="langId" value="${WCParam.langId}"/>
							<wcf:var name="orderId" value="${ZZOrderId}"/>	     		
						</wcf:rest>	
					 
					 <c:set var="shipInstructions" value=""/>
					 <input type="hidden" name="ship" id="ship" value="${shipInstructions}" />
<!-- 					add this line -->
 					<c:set var="shippingInstructionsChecked" value="true"/>		

				      <c:if test = "${fn:containsIgnoreCase(editOrder, 'false')}">
				         <c:set var="shippingInstructionsDivDisplay" value="none"/>
				      </c:if>

		
					  <c:choose>
					 	<c:when test="${shipInstructions == 'None' }">
					 		<div name="shippingInstructionsDiv" id="shippingInstructionsDiv" style="display:<c:out value='${shippingInstructionsDivDisplay}'/>">
								<p>
								<span>
									<textarea id="shipInstructions" name="shipInstructions" rows="5" cols="90" onchange="JavaScript:setCurrentId(this.id); CheckoutHelperJS.updateShippingInstructionsForAllItems()"></textarea>
								</span>
								</p>
							</div>
					 	</c:when>
					 	<c:otherwise>
					 		<div name="shippingInstructionsDiv" id="shippingInstructionsDiv" style="display:<c:out value='${shippingInstructionsDivDisplay}'/>">
								<p>
								<span>
									<textarea id="shipInstructions" name="shipInstructions" rows="5" cols="90" onchange="JavaScript:setCurrentId(this.id); CheckoutHelperJS.updateShippingInstructionsForAllItems()"><c:out value="${shipInstructions}" /></textarea>
								</span>
								</p>
							</div>
					 	</c:otherwise>
					</c:choose>					 
		 
					 </flow:ifEnabled>
					 
				 </td>	
				</tr>
	
					<tr>
						<td>
							<br/>	
							<c:if test = "${fn:containsIgnoreCase(ordButtonApp_value, 'true')}">
							<div class="shopping_cart_box" style="float:left;">
								<div id="shopcartCheckoutButton">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_ApprovalPage">   
												<a class="button primary" style="font-size:12px" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'" onclick="javascript:SubmitOrderApprovalUpdate(document.approvalOrderDisplay, 'Approve')" >
													Approve
												</a>
											</span>
										</span>	
									</span>
								</div>
							</div>
							</c:if>
							
							<c:if test = "${fn:containsIgnoreCase(ordButtonRej_value, 'true')}">
							<div class="shopping_cart_box" style="float:left;margin-left:100px;">
								<div id="shopcartCheckoutButton">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_ApprovalPage">   
												<a class="button primary" style="font-size:12px" onmouseover="this.style.cursor='pointer'" onmouseout="this.style.cursor='auto'" onclick="javascript:SubmitOrderApprovalUpdate(document.approvalOrderDisplay, 'Reject')" >
													Reject
												</a>
											</span>
										</span>	
									</span>
								</div>
							</div>
							</c:if>
						</td>
					</tr>	
										
				</table>

				<input type="hidden" id="approval_order_orderId" name="approval_order_OrderId" value="${WCParam.orderId}" />
				<input type="hidden" id="approval_order_action" name="approval_order_action" value="" />
				<input type="hidden" id="approval_approvalStatusId" name="approval_approvalStatusId" value="${approvalStatusId}" />				

				<input type="hidden" name="ONOrderReceivedEmailIncludeXML" value="<c:out value="${ONOrderReceivedEmailIncludeXML}"/>" id="ONOrderReceivedEmailIncludeXML"/>				
				

				<c:url var="OrderReceivedApprovalSubmittedDisplayURL" value="OrderReceivedApprovalSubmittedDisplay">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="orderId" value="${WCParam.orderId }"/>
					<c:param name="appMailAddress" value="${appMailAddress }"/>
				</c:url>

				<input type="hidden" id="URL" name="URL" value="<c:out value="${OrderReceivedApprovalSubmittedDisplayURL}" />" />
OrderReceivedApprovalSubmittedDisplayURL :: ${OrderReceivedApprovalSubmittedDisplayURL }
				<c:url var="ONOrderReceivedApprovalProcessUrl" value="OrderReceivedApprovalProcess">
					<c:param name="storeId" value="${storeId}"/>
					<c:param name="catalogId" value="${catalogId}"/>
					<c:param name="langId" value="${langId}"/>
					<c:param name="orderId" value="${WCParam.orderId}"/>
					<c:param name="approvalStatusId" value="${approvalStatusId}"/>
				</c:url>
				<input type="hidden" id="ErrorURL" name="ErrorURL" value="<c:out value="${ONOrderReceivedApprovalProcessUrl}" />" />
				
			</form>
		
		</body>
		
	<c:set var="ZZOrderId" value="${WCParam.orderId}"/>	
	
		<wcf:rest var="ZZpagorder" url="store/${WCParam.storeId}/order/{orderId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="orderId" value="${ZZOrderId}"/>	     		
		</wcf:rest>			


<script type="text/javascript" language="javascript">		
		
var ZZItemIndex = 0;		
		
function constructQuantityInputs() {
	ZZItemIndex = 0;

	<%-- ******************************************************************************************************************************* --%>
	<%-- * Get order item details - must be same retrieval as "ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp" * --%>
	<%-- ******************************************************************************************************************************* --%>
	<c:set var="ZZOrderId" value="${WCParam.orderId}"/>	
	
		<wcf:rest var="ZZpagorder" url="store/${WCParam.storeId}/order/{orderId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="orderId" value="${ZZOrderId}"/>	     		
		</wcf:rest>	

	<%-- ********************************************************************************************************************* --%>
	<%-- * loop thru order items - same sequence as "ShoppingArea/CheckoutSection/SingleShipment/OrderItemDetailSummary.jsp" * --%>
	<%-- ********************************************************************************************************************* --%>		

	
	var ZZItemQuantityElement = null;
	
	<c:forEach var="ZZorderItem" items="${ZZpagorder.orderItem}" varStatus="ZZstatus">
		<fmt:formatNumber var="ZZquickCartOrderItemQuantity" value="${ZZorderItem.quantity}" type="number" maxFractionDigits="0"/>
		<%-- ************************************************** --%>
		<%-- * change quantity output field as quantity input * --%>
		<%-- ************************************************** --%>
		
		ZZItemQuantityElement = document.getElementById('WC_OrderItemDetailsSummaryf_td_2_<c:out value="${ZZstatus.count}"/>');
		ZZItemQuantityElement.innerHTML =
			'<p class="item-quantity">' +
			'<input type="input" id="approval_detail_orderItemQty_2_<c:out value="${ZZstatus.count}"/>" name="approval_detail_orderItemQty_2_<c:out value="${ZZstatus.count}"/>" value="<c:out value="${ZZquickCartOrderItemQuantity}" />" onChange="changeQty(this.id);" size="3"/>' +
			'<input type="hidden" id="approval_detail_orderItemId_2_<c:out value="${ZZstatus.count}"/>" name="approval_detail_orderItemId_2_<c:out value="${ZZstatus.count}"/>" value="<c:out value="${ZZorderItem.orderItemId}" />" />' +
			'</p>';
		ZZItemIndex = ZZItemIndex + 1;
	</c:forEach>
	
	
	
}		


	function disableAllLinks() {
		var ZZlinks = document.getElementsByTagName("a");
		for (var i=0;i<ZZlinks.length;i++) {
			ZZlinks[i].removeAttribute("href");
		}
	}

	function changeQty(count){
		var id = count;
		var qty = document.getElementById(id).value/1;
		if(isNaN(qty)){
			alert('Invalid value in Qty field.');
			return;
		}
		var count = id.substr(id.length-1, id.length-1);
		var price1 = document.getElementById("priceForOrderApp1_"+count).value/1;
		var price2 = document.getElementById("priceForOrderApp2_"+count).value/1;
		var price3 = document.getElementById("priceForOrderApp3_"+count).value/1;
		
		price1 = price1.toFixed(2);
		price2 = price2.toFixed(2);
		price3 = price3.toFixed(2);
		
		var updatePrice1 = qty * price1;
		var updatePrice2 = qty * price2;
		var updatePrice3 = qty * price3;
		
		updatePrice1 = updatePrice1.toFixed(2);
		updatePrice2 = updatePrice2.toFixed(2);
		updatePrice3 = updatePrice3.toFixed(2);
		
		document.getElementById("updatePrice1_"+count).innerHTML = "$"+updatePrice1;
		document.getElementById("updatePrice2_"+count).innerHTML = "$"+updatePrice2;
		document.getElementById("updatePrice3_"+count).innerHTML = "$"+updatePrice3;
		
	}
	
	function validQuantity(inElement) {
		var numChars = '0123456789';
		var strChar;
		if (inElement == null) {return false;}
		if (inElement.value == null) {return false;}
		if (inElement.value.length == 0) {
			inElement.value = 0;
		}

		for (vali=0; vali<inElement.value.length;vali++) {
			strChar = inElement.value.charAt(vali);
			if (numChars.indexOf(strChar) == -1) {
				return false;
			}
		}
		return true;
	}	
	
	

	function SubmitOrderApprovalUpdate(form, approvalAction) {

		for (wi=0; wi<ZZItemIndex;wi++) {
			orderQtyField = document.getElementById('approval_detail_orderItemQty_2_'+(wi+1));
			
			if (validQuantity(orderQtyField) == false) {
				alert('Invalid Order Quantity entered');
				orderQtyField.focus();
				return false;
			}
		}
		document.getElementById('approval_order_action').value = approvalAction;

		form.submit();
	
	}
	
	
	
	//<!-- ali raza code-->
	function updateInfo(){

		var purchaseOrderNumber = document.getElementById("purchase_order_number").value;
		//alert(purchaseOrderNumber);
		/*
		if(!MessageHelper.isValidUTF8length(purchaseOrderNumber, 128)){
			MessageHelper.formErrorHandleClient(purchaseOrderNumber,MessageHelper.messages["ERROR_PONumberTooLong"]);
			return;
		}
		*/
		//alert("ali:"+purchaseOrderNumber);
		var shippingInstructions = document.getElementById("shipInstructions").value;
		var resultUrl = '<c:out value='${SavedOrderListDisplayURL}' escapeXml='false'/>'+'&poNum='+purchaseOrderNumber+'&shipInst='+shippingInstructions;
		//alert("ali raza:"+purchaseOrderNumber);
		document.location.href= resultUrl;
	}

	//<!--end code-->		
	

		
</script>		
		
		
				<c:if test = "${fn:containsIgnoreCase(editOrder, 'true')}">
				Before -- 
					<script>
						constructQuantityInputs();
						disableAllLinks();
						
					</script>
				-- After
				</c:if>		
			
		</html>
		
		</c:if>
	
	
</c:if>
		