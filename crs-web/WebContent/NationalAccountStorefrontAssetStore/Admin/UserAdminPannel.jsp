<!-- BEGIN UserAdminPannel.jsp -->

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
 
 
 <div>
		<!--Params for User-->
	<c:set var="flags" value="${WCParam.flags }" scope="page"/>
	<c:set var="flagR" value="${WCParam.flagR }" scope="page"/>
	<c:set var="usrId" value="${WCParam.usrId }" scope="page"/>
	<c:set var="addValue" value="${WCParam.addValue }" scope="page"/>
	<c:set var="stId" value="${WCParam.storeId }" scope="page"/>
	<c:set var="orgId" value="${WCParam.orgId }" scope="page"/>
	<c:set var="usId" value="${WCParam.usId }" scope="page"/>
 
<!--  Params for User Pannel: <BR> -->
 
 	<div class="col12">
		<h2>Organizations</h2>
		
			<wcf:rest var="getOrganizations" url="store/${WCParam.storeId}/adminPannel/getOrganizations" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
			</wcf:rest>	
		
			<select id="orgName" onChange="javascript:AdminPannelJS.setOrganizations('user');">
				<option value="0">Select Organization</option>

					<c:forEach var="orgList" items="${getOrganizations.orgList}">

 					<c:if test="${WCParam.orgId eq orgList.orgId && (flags eq 'user' || flags eq 'add' || flags eq 'remove')}"> 
						
						<option value="${orgList.orgId}" selected="selected">${orgList.orgName}</option>
					</c:if>
					<c:if test="${WCParam.orgId ne orgList.orgId}">
						<option value="${orgList.orgId}" >${orgList.orgName}</option>
					</c:if>	
						
					</c:forEach>

			</select><br/><br/>		
			
			
			<div class="row" role="main"> 
								 
			<c:set var="orgName" value="${WCParam.orgName }" scope="page"/>
			<c:set var="orgId" value="${WCParam.orgId }" scope="page"/>
			<c:set var="addFlag" value="${WCParam.addFlag }" scope="page"/>
			<c:set var="storeIds" value="${WCParam.storeIds }" scope="page"/>
			<c:set var="storeName" value="${WCParam.storeName }" scope="page"/>
			<c:set var="usrId" value="${WCParam.usrId }" scope="page"/>
			<c:set var="addValue" value="${WCParam.addValue }" scope="page"/>
			<c:set var="addValueText" value="${WCParam.addValueText }" scope="page"/>
			<c:set var="usId" value="${WCParam.usId }" scope="page"/>
			<c:set var="flags" value="${WCParam.flags }" scope="page"/>
			<c:set var="flagR" value="${WCParam.flagR }" scope="page"/>
			<c:set var="id" value="${WCParam.id }" scope="page"/>
			<c:set var="i" value="0" scope="page"/>
			<c:set var="uid" value="" />
										
			<wcf:rest var="usersByOrgId" url="store/${WCParam.storeId}/adminPannel/getUsersByOrgId/${WCParam.orgId}" scope="request">
				<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
				<wcf:var name="orgId" value = "${WCParam.orgId}" encode="true"/>	
			</wcf:rest>		
													
										
			<table class="UserManagementTable" cellpadding="0" cellspacing="0">
			
				<tr>
					<th>Customer</th>
					<th>User</th>
					<th>Default Store</th>
					<th>Contracts</th>
				</tr>

			
			<c:forEach var="userList" items="${usersByOrgId.users}" varStatus="loop">
			
				<tr>
					<td> ${WCParam.orgName} </td>
					
					<input type="hidden" id="${userList.userId}" name="${userList.userId}" value="${userList.userId}"/>
					<c:set var="userIdd" value="${userList.userId}" scope="page"/>
	
					<td> <c:out value = "${userList.userName}"/> </BR> </td> 
					
		  			<wcf:rest var="getDefaultStore" url="store/${WCParam.storeId}/adminPannel/getField2byUserId/${userList.userId}" scope="request">
						<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
						<wcf:var name="usersId" value = "${userList.userId}" encode="true"/>	
					</wcf:rest>	
					
					<c:if test="${flags eq 'userAddI' || flags eq 'userAddII'}">
					
						<c:set var="uid" value="${usrId}" />
						
					</c:if>

					<c:choose>
					
					 <c:when test="${getDefaultStore.storeName eq 'Add Store By Store ID' && flagR eq 'addEdit' && userList.userId ne uid}">
										
					<td style="width:404px;">
					<input type="button" class="button_primary" value="Add/Edit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('${loop.index}','userAddI')" />
					</td>
					
					</c:when>
					
					<c:when test="${userList.userId eq usrId && (flags eq 'userAddI' || flags eq 'userAddII')}">
					
					<td style="width:404px;">
					
					<wcf:rest var="getStoreList" url="store/${WCParam.storeId}/adminPannel/getStoresList" scope="request">
						<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
					</wcf:rest>						
					
					
					<select style="width: 322px;" id="addPartStore_${loop.index}">
					
						<option value="-1">Select Default Store And Submit</option>
						
						<c:if test="${flags eq 'userAddII'}">
							<option value="0">Remove Default Store And Submit</option>	
						</c:if>
						
						<c:forEach var="storesList" items="${getStoreList.storeList}">
						
						<c:if test="${WCParam.addValue eq storesList.store_Id}">
							<option value="${storesList.store_Id}" selected="selected"> <c:out value = "${storesList.displayName}"/> </option>
						</c:if>

						<c:if test="${WCParam.addValue ne storesList.store_Id}">
							<option value="${storesList.store_Id}"> <c:out value = "${storesList.displayName}"/> </option>
						</c:if>	
						
						</c:forEach>				
					
					</select>	
					
					<input type="button" class="button_primary" value="Submit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('${loop.index}','userAdd')" /></td>
					
					</c:when>
					
					<c:when test="${getDefaultStore.storeName ne 'Add Store By Store ID'}">
						
					<td style="width:404px;">
					
					<c:if test="${WCParam.id eq  loop.index}">
						<input style="width:290px;" type="text" value="${WCParam.addValueText}" id="storeName__${loop.index}" />
					</c:if>
					<c:if test="${WCParam.id ne  loop.index}">
						<input style="width:290px;" type="text" value="${getDefaultStore.storeName}" id="storeName__${loop.index}" />
					</c:if>
					
					<input class="button_primary" type="button" value="Add/Edit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('${loop.index}','userAddII')" /></td>									
	
					</c:when>
					
					</c:choose>
					
					<input type="hidden" value="${userList.userId}" id="usrId_${loop.index}"/>
					<input type="hidden" value="${getDefaultStore.field2}" id="field2_${loop.index}"/>
				
					<wcf:rest var="getContractM" url="store/${WCParam.storeId}/adminPannel/getContractsByOrgId/${WCParam.orgId}" scope="request">
						<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
						<wcf:var name="orgId" value = "${WCParam.orgName}" encode="true"/>
					</wcf:rest>						


						<td> ${getContractM.contractNameM} </td>
					
				</tr>
				
				
			</c:forEach>
 
			
			</table>
			
								 
								 
		 </div>		
 

<c:if test="${flags eq 'userAdd'}">
	
		<wcf:rest var="addUserProf" url="store/${WCParam.storeId}/adminPannel/addUserProf/${WCParam.usrId}/${WCParam.addValue}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
			<wcf:var name="userId" value = "${WCParam.usrId}" encode="true"/>
			<wcf:var name="addValue" value = "${WCParam.addValue}" encode="true"/>		
		</wcf:rest>	

</c:if>	


<c:if test="${flags eq 'userRemove'}">

		<wcf:rest var="removeUserProf" url="store/${WCParam.storeId}/adminPannel/removeUserProf/${WCParam.usrId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
			<wcf:var name="userId" value = "${WCParam.usrId}" encode="true"/>	
		</wcf:rest>		

</c:if>

			
			
	</div>		
 
 
 </div>
 
 
 
<!-- END UserAdminPannel.jsp --> 