<!-- BEGIN ContractAdmin.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
 --%>
 
 
<div class="row" role="main"> 

					<c:set var="contractName" value="${WCParam.contractName }" scope="page"/>
					<c:set var="contractId" value="${WCParam.contractId }" scope="page"/>
					<c:set var="addFlag" value="${WCParam.addFlag }" scope="page"/>
					<c:set var="storeIds" value="${WCParam.storeIds }" scope="page"/>
					<c:set var="storeName" value="${WCParam.storeName }" scope="page"/>
					
					
	<c:if test="${addFlag eq 'add'}">
		
			<wcf:rest var="insertStore" url="store/${WCParam.storeId}/adminPannel/insertStore/${WCParam.contractId}/${WCParam.storeIds}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
				<wcf:var name="contractId" value = "${WCParam.contractId }" encode="true"/>
				<wcf:var name="stId" value = "${WCParam.storeIds }" encode="true"/>		
			</wcf:rest>	

	</c:if>

	<c:if test="${addFlag eq 'remove'}">

			<wcf:rest var="removeStore" url="store/${WCParam.storeId}/adminPannel/removeStore/${WCParam.contractId}/${WCParam.storeIds}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
				<wcf:var name="contractId" value = "${WCParam.contractId }" encode="true"/>
				<wcf:var name="stId" value = "${WCParam.storeIds }" encode="true"/>		
			</wcf:rest>		
	
	</c:if>


	<div class="col4">
		<h2>Non Participating Stores</h2> 
		
			<wcf:rest var="nonParticipatingStores" url="store/${WCParam.storeId}/adminPannel/getNonParticipatingStores/${WCParam.contractId}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
				<wcf:var name="contractId" value = "${WCParam.contractId}" encode="true"/>	
			</wcf:rest>	


		<select id="addPartStore" multiple size="8">
			<c:forEach var="storeList" items="${nonParticipatingStores.storeData}">
				<option value="${storeList.stId}">${storeList.storeName}</option>
			</c:forEach>		
		</select>
	</div>
	
	
	<div class="col3 add-remove">
		<input type="button" class="button_primary" onclick="javascript:AdminPannelJS.setContract('add');" value="ADD"/><br/>
		<input type="button" class="button_primary" onclick="javascript:AdminPannelJS.setContract('remove');" value="REMOVE"/>	
	</div>	
	
	
	<div class="col4">
		<h2>Participating Stores</h2>
		
			<wcf:rest var="participatingStores" url="store/${WCParam.storeId}/adminPannel/getParticipatingStores/${WCParam.contractId}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
				<wcf:var name="contractId" value = "${WCParam.contractId}" encode="true"/>	
			</wcf:rest>	


		<select id="removePartStore" multiple size="8">
			<c:forEach var="storeList" items="${participatingStores.storeData}">
				<option value="${storeList.stId}">${storeList.storeName}</option>
			</c:forEach>		
		</select>
	</div>	
	
	

</div>

<!-- END ContractAdmin.jsp -->