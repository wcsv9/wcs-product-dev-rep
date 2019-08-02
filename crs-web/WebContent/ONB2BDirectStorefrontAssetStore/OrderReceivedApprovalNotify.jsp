<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2006
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ page import="java.util.*" %>

<%
	out.println("<span style=\"color: blue; font-weight: bold; font-size: 14; font-family: 'Verdana','sans serif'\">THE FOLLOWING ORDER REQUIRES YOUR APPROVAL.</span>");
	out.println("<BR/>");
	out.println("<BR/>");
%>

<%-- Include Order Received details --%>
<%@ include file="OrderReceived.jsp"%>


<%-- Approve / Reject link --%>

<c:set var="approverId" value="${WCParam.approverId}"  scope="page"/>
<c:set var="approverLogonId" value="${WCParam.approverLogonId}"  scope="page"/>
<c:set var="approvalStatusId" value="${WCParam.approvalStatusId}"  scope="page"/>
<c:set var="langId" value="${WCParam.langId}"  scope="page"/>
<c:set var="catalogId" value="${WCParam.catalogId}"  scope="page"/>
<c:set var="hostName" value="${WCParam.ONOrderReceivedApprovalByEmailHost}"  scope="page"/>

<c:if test="${empty hostName || hostName == null}">  
	<c:set var="hostName" value="localhost:8443"  scope="page"/>
</c:if>

<%

	String approverId = pageContext.getAttribute("approverId").toString();
	String approverLogonId = pageContext.getAttribute("approverLogonId").toString();
	String approvalStatusId = pageContext.getAttribute("approvalStatusId").toString();
	String langId = pageContext.getAttribute("langId").toString();
	String catalogId = pageContext.getAttribute("catalogId").toString();
	String hostName = pageContext.getAttribute("hostName").toString(); 

		String commonParameters = "langId=" + langId +
		"&storeId=" + stId +
		"&catalogId=" + catalogId +
		"&userId=" + approverId +
		"&logonId=" + approverLogonId +
		"&logonPassword=system" +
		"&reLogonURL=LogonForm" +
		"&URL=LogonForm" + 
		"&forwardCommand=OrderReceivedApprovalProcess" +
		"&forwardParameter=" +
			"orderId:EQ:" + orderId +
			":AND:approvalStatusId:EQ:" + approvalStatusId;

		out.println("commonParameters" + commonParameters);	
		
	// link to Approve or Reject Order (no change of the Order)
	
	String approveLink = "https://" + hostName + "/wcs/shop/ONLogonWithoutPasswordCmd?"	+ commonParameters + ":AND:modifyOrder:EQ:false:AND:aprv_act:EQ:1:AND:edit:EQ::AND:ordButtonApp:EQ::AND:ordButtonRej:EQ:";

	String rejectLink = "https://" + hostName + "/wcs/shop/ONLogonWithoutPasswordCmd?" + commonParameters + ":AND:modifyOrder:EQ:false:AND:aprv_act:EQ:2:AND:edit:EQ::AND:ordButtonApp:EQ::AND:ordButtonRej:EQ:";

	// link to Approve or Reject Order (allow change of the Order)
	
	String approvalModifyLink = "https://" + hostName + "/wcs/shop/ONLogonWithoutPasswordCmd?" + commonParameters + ":AND:modifyOrder:EQ:true:AND:aprv_act:EQ::AND:edit:EQ:true:AND:ordButtonApp:EQ:true:AND:ordButtonRej:EQ:true";
	
	
	
	
	out.println("<BR/><BR/>");
	out.println("<span style=\"color: blue; font-weight: bold; font-size: 12; font-family: 'Verdana','sans serif'\">Please click on the following to Approve the Order (allow changing of the Order) :</span><BR/><BR>");
	out.println("<a href=\"" + approvalModifyLink + "\" target=\"_blank\">Order Approval with modify</a>");
	out.println("<BR/><BR/><BR/>");
	out.println("<span style=\"color: blue; font-weight: bold; font-size: 12; font-family: 'Verdana','sans serif'\">OR click on the following to Approve or Reject the Order (no change of the Order):</span><BR/><BR>");

	
	
	if(stId.equalsIgnoreCase("11903") || stId.equalsIgnoreCase("33101") || stId.equalsIgnoreCase("12401")){
		
		String approvalModifyLinkNotEditApp = "https://" + hostName + "/wcs/shop/ONLogonWithoutPasswordCmd?" + ":AND:modifyOrder:EQ:true:AND:edit:EQ:false:AND:ordButtonApp:EQ:true:AND:ordButtonRej:EQ:false";	
		
		out.println("<a href=\"" + approvalModifyLinkNotEditApp + "\" target=\"_blank\">Approve Order</a>");
		out.println("&nbsp;&nbsp;");
		
		String approvalModifyLinkNotEditRej = "https://" + hostName + "/wcs/shop/ONLogonWithoutPasswordCmd?" + commonParameters + ":AND:modifyOrder:EQ:true:AND:edit:EQ:false:AND:ordButtonApp:EQ:false:AND:ordButtonRej:EQ:true";
		
		out.println("<a href=\"" + approvalModifyLinkNotEditRej + "\" target=\"_blank\">Reject Order</a>");
	}
	else{
		
		out.println("<a href=\"" + approveLink + "\" target=\"_blank\">Approve Order</a>");
		out.println("&nbsp;&nbsp;");
		out.println("<a href=\"" + rejectLink + "\" target=\"_blank\">Reject Order</a>");		
	}
	
	out.println("<BR/><BR/>");
	
%>

