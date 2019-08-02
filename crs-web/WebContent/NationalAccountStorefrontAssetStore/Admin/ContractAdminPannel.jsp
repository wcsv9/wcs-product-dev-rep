<!-- BEGIN ContractAdminPannel.jsp -->

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


<br> flags :: ${WCParam.flags } <br>  usrId :: ${WCParam.usrId } <br> addValue :: ${WCParam.addValue } --%>

			<div id="tabdata" role="main">
					<!--Params for User-->
					<c:set var="flags" value="${WCParam.flags }" scope="page"/>
					<c:set var="usrId" value="${WCParam.usrId }" scope="page"/>
					<c:set var="addValue" value="${WCParam.addValue }" scope="page"/>	
					<c:set var="orgId" value="${WCParam.orgId }" scope="page"/>	
					<c:set var="usId" value="${WCParam.usId }" scope="page"/>	

					<!--Params for contracts-->
					<c:set var="stdid" value="${WCParam.storeId }" scope="page"/>
					<c:set var="contractName" value="${WCParam.contractName }" scope="page"/>
					<c:set var="contractId" value="${WCParam.contractId }" scope="page"/>
					<c:set var="addFlag" value="${WCParam.addFlag }" scope="page"/>
					<c:set var="storeIds" value="${WCParam.storeIds }" scope="page"/>
					<c:set var="storeName" value="${WCParam.storeName }" scope="page"/>					
			
					<c:if test="${flags eq 'contract' || flags eq 'contracts' || flags eq 'add' || flags eq 'remove'}">	
						<br/>
						
						<wcf:rest var="getContracts" url="store/${WCParam.storeId}/adminPannel/getContracts" scope="request">
								<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
						</wcf:rest>			
													
						<select id="contractIdName" onChange="javascript:AdminPannelJS.setContract('contracts');">
							<option value="0">Select Contract</option>
								<c:forEach var="contractList" items="${getContracts.contracts}">
									<c:if test="${WCParam.contractId eq contractList.selectedContractId && (flags eq 'contracts' || flags eq 'add' || flags eq 'remove')}">								
										<option value="${contractList.selectedContractId}" selected="selected">${contractList.contractName}</option>
									</c:if>
									
									<c:if test="${WCParam.contractId ne contractList.selectedContractId}">
										<option value="${contractList.selectedContractId}">${contractList.contractName}</option>
									</c:if>	
								</c:forEach>	
						</select><br/><br/>
					
					</c:if>		
 
					<c:if test="${flags eq 'contracts' || flags eq 'add' || flags eq 'remove' }">
						<%out.flush();%>
							<c:import url="${env_jspStoreDir}Admin/ContractAdmin.jsp">
								
								<c:param name="contractName" value="${contractName}"/>
								<c:param name="contractId" value="${contractId}"/>
								<c:param name="storeIds" value="${storeIds}"/>
								<c:param name="storeName" value="${storeName}"/>
								<c:param name="addFlag" value="${WCParam.flags}"/>
								
							</c:import>
						<%out.flush();%> 
					</c:if>							
 
						<c:if test="${flags eq 'user' || flags eq 'userAdd' || flags eq 'userRemove' || flags eq 'userAddI' || flags eq 'userAddII'}">	
							<br/>
							<%out.flush();%>
								<c:import url="${env_jspStoreDir}Admin/UserAdminPannel.jsp">
									<c:param name="addValue" value="${addValue}"/>
									<c:param name="addValueText" value="${addValueText}"/>
									<c:param name="usrId" value="${usrId}"/>
									<c:param name="flags" value="${WCParam.flags}"/>
									<c:param name="flagR" value="${WCParam.flagR}"/>
									<c:param name="orgId" value="${WCParam.orgId}"/>	
									<c:param name="usId" value="${WCParam.usId}"/>	
									<c:param name="id" value="${id}"/>					
								</c:import>
							<%out.flush();%>
						</c:if>						
						
						
			
			</div>
			
			
<!-- END ContractAdminPannel.jsp -->			