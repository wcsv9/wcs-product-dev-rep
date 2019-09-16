

<!-- BEGIN ONUserRegistrationApprovalProcess.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>


	
		<c:set var="forwardParameter" value="${WCParam.forwardParameter}" scope="page" />
		
		<c:set var="apruserId" value="${WCParam.userId}"/>

			<c:if test="${forwardParameter != null}">
		
				<c:set var="replaceAND" value='${fn:replace(forwardParameter, ":AND:", "&")}' />
				<c:set var="replaceOR" value='${fn:replace(replaceAND, ":EQ:", "=")}' />
				<c:set var="splitfwdparams" value="${fn:split(replaceOR, '&')}" />	
				
				<c:set var="regUserId" value="${fn:split(splitfwdparams[0], '=')}" />		
				<c:set var="regUserId_key" value="${regUserId[0]}" />
				<c:set var="regUserId_value" value="${regUserId[1]}" />
				
				<c:set var="usr_logonId" value="${fn:split(splitfwdparams[1], '=')}" />
				<c:set var="usr_logonId_key" value="${usr_logonId[0]}" />
				<c:set var="usr_logonId_value" value="${usr_logonId[1]}" />
						
				<c:set var="orgEntityId" value="${fn:split(splitfwdparams[2], '=')}" />
				<c:set var="orgEntityId_key" value="${orgEntityId[0]}" />
				<c:set var="orgEntityId_value" value="${orgEntityId[1]}" />
				
				<c:set var="approvalStatusId" value="${fn:split(splitfwdparams[3], '=')}" />
				<c:set var="approvalStatusId_key" value="${approvalStatusId[0]}" />
				<c:set var="approvalStatusId_value" value="${approvalStatusId[1]}" />
				
				<c:set var="aprv_act" value="${fn:split(splitfwdparams[4], '=')}" />
				<c:set var="aprv_act_key" value="${aprv_act[0]}" />
				<c:set var="aprv_act_value" value="${aprv_act[1]}" />
		
			</c:if>

	<wcf:rest var="approvalProcess" url="store/${WCParam.storeId}/registrationApproval/ONUserRegistrationApprovalProcess/${WCParam.catalogId}/${WCParam.langId}/${regUserId_value}/${orgEntityId_value}/${approvalStatusId_value}/${aprv_act_value}/${apruserId}" scope="request">
			<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>
			<wcf:var name="catalogId" value="${WCParam.catalogId}"/>
      		<wcf:var name="langId" value="${WCParam.langId}"/>
			<wcf:var name="regUserId" value="${regUserId_value}"/>
			<wcf:var name="orgEntityId" value="${orgEntityId_value}"/>
			<wcf:var name="approvalStatusId" value="${approvalStatusId_value}"/>
      		<wcf:var name="approvalAction" value="${aprv_act_value}"/>	
      		<wcf:var name="apruserId" value="${apruserId}"/>	
	</wcf:rest>
	
	
	<c:set var="message" value="${approvalProcess.message}" />

		<c:if test="${message != null}">
		
				<html xmlns="http://www.w3.org/1999/xhtml">
				<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">	

				<head>
				<title>User Registration Approval Process</title>
				</head>				
									
					<body class="logon">
						<div style="display: hidden">
							<form name="approvalSubmitDisplayForm" action="ONUserRegistrationApprovalSubmittedDisplay" method="post">   
							    <input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
							    <input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
							    <input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />
							    <input type="hidden" id="userId" name="userId" value="${regUserId_value}" />
							    <input type="hidden" id="apruserId" name="apruserId" value="${apruserId}" />
							    <input type="hidden" id="orgEntityId" name="orgEntityId" value="${orgEntityId_value}" />
							    <input type="hidden" id="message" name="message" value="${message}" />
							</form>
						</div>
				
						<script type="text/javascript" language="javascript">
						<!--<![CDATA[
							document.approvalSubmitDisplayForm.submit();
						//[[>-->
						</script>
					</body>		
				</html>		
		
		</c:if>

		<c:if test="${message == null}">
			
			<c:set var="approvalStatusIdRange" value="${approvalProcess.approvalStatusIdRange}" />
			<c:set var="forwardURL" value="${approvalProcess.forwardURL}" />


				<c:if test="${aprv_act_value == '1'}">
					<c:set var="forwardURL" value="${approvalProcess.forwardURL}" />
				</c:if>
			
				<c:if test="${aprv_act_value == '2'}">
					<c:set var="forwardURL" value="${approvalProcess.forwardURL}" />
				</c:if>

			
			<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
			<title>User Registration Approval Process</title>
			</head>
			
			<body class="logon">
				<div style="display: hidden">
					<form name="commentsForm" action="RESTHandleApprovals" method="post">   
					    <input type="hidden" id="aprv_act" name="aprv_act" value="${aprv_act_value}" />
					    <input type="hidden" id="aprv_ids" name="aprv_ids" value="${approvalStatusIdRange}" />
					    <input type="hidden" id="viewtask" name="viewtask" value="${forwardURL}" />
					    <input type="hidden" name="authToken" value="${authToken}" />
					    
			    		<input type="hidden" id="langId" name="langId" value="${WCParam.langId}" />
					    <input type="hidden" id="storeId" name="storeId" value="${WCParam.storeId}" />
					    <input type="hidden" id="catalogId" name="catalogId" value="${WCParam.catalogId}" />
						<input type="hidden" id="approvalStatusId" name="approvalStatusId" value="${approvalStatusId_value}" />
						
						<input type="hidden" name="URL" value="ONUserRegistrationApprovalSubmittedDisplay" />
						<input type="hidden" name="URL" value="ONUserRegistrationApprovalSubmittedDisplay" />
					    
					    <input type="hidden" id="userId" name="userId" value="${regUserId_value}" />
					    <input type="hidden" id="apruserId" name="apruserId" value="${apruserId}" />
					    <input type="hidden" id="orgEntityId" name="orgEntityId" value="${orgEntityId_value}" />
					    <input type="hidden" id="message" name="message" value="${message}" />
					    
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


<!-- END ONUserRegistrationApprovalProcess.jsp -->
	
