<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<span class="spanacce" id="orgNameForAcce">
	<fmt:message bundle="${storeText}" key="ORG_CREATE_ORG_NAME"/><c:out value='${orgEntityDetails.displayName}'/>
</span>
<%-- <div id="PageHeader_CreateEditOrganization" style="margin-bottom:0px;" tabindex="0" aria-labelledby="orgNameForAcce">
	<h1 style="padding: 0px 0px;"><c:out value='${orgEntityDetails.displayName}'/></h1>
</div> --%>

<div class="row">
	<div class="col12 organizationEditPage">
		
		<div class="col12 row">
			<div class="col6 acol12 addJustWidth">
				<fieldset class="organizationDetails">
				<legend><label>Organization Details</label></legend>
				<%out.flush();%>
					<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationSummary/OrganizationSummary.jsp">
						<wcpgl:param name="orgSummaryType" value="edit"/>
						<wcpgl:param name="orgSummaryBasicEdit" value="true"/>
						<wcpgl:param name="orgSummaryAddressEdit" value="true"/>
						<wcpgl:param name="orgSummaryContactInfoEdit" value="true"/>
						<wcpgl:param name="orgEntityId" value="${orgEntityId}"/>
					</wcpgl:widgetImport>
				<%out.flush();%>
			</fieldset>

			<c:if test = "${(env_shopOnBehalfSessionEstablished eq 'false' && env_shopOnBehalfEnabled_CSR eq 'false')}">
			<%-- This is a normal buyerAdmin session or buyerAdmin on-behalf-session for another buyerAdmin. Not a CSR session --%>
			<div class="col6 acol12 row adjustOnIpad">
				<div class="col12">
					<fieldset class="orgFinancialsField">
					<legend>Financials</legend>
					<div class="column row">
					<div class="row col12">
						 <div  class="column_label col3"> Cost Centre:</div>
						<div class="col7"><input class="inputField" type="text"   maxlength="30" size="35" id="new_cost_centre" name="new_cost_centre">
				 		<input type="hidden" name="userField1" value="" id="costCentreCombined" autocomplete="off"></div>
				 		<div class="col2 acol2"><a class="button_primary" onclick="addCostCentre(document.getElementById('new_cost_centre'), '');">Add</a></div><br>
					</div>
					<br>
					<span class="col10" name="costCentreBox" id="costCentreBox" style="display: block; margin-top: 5px;">
					 		 
					 		<select id="costCentreList" multiple="multiple"  size="2">
					 		</select>
					 		<br> &nbsp;
					</span>
					<br clear="all"> 
					<a class="button_secondary" style="margin-top:0px;text-align:center;" onclick="removeCostCentre('');">Remove Selected</a>
					 
					</div>
					<br/>
					</fieldset>	
				</div>
				<div class="col12">
				<fieldset class="organizationApprovals">
				<legend><label>Approvals</label></legend>
				<%out.flush();%>
					<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationMemberApprovalGroups/OrganizationMemberApprovalGroups.jsp"/>
				<%out.flush();%>
				</fieldset>
				</div>
				<div class="col12">
					<fieldset class="orgSystemDetails">
					<legend>System Details:</legend>
					 	<div class="col12 row">
					 		<div class="col3">
					 			<span>Store	ID:</span>
					 		</div>
					 		<div class="col9"><span>&nbsp;</span></div>
					 		<div class="col3">
					 			<span>Account ID:</span>
					 		</div>
					 		<div class="col9"><span>&nbsp;</span></div>
					 		<div class="col3">
					 			<span>Applicable Contracts:</span>
					 		</div>
					 		<div class="col9">
					 			<!-- <ul>
					 				<li>Item 1</li>
					 				<li>Item 2</li>
					 				<li>Item 3</li>
					 				<li>Item 4</li>
					 			</ul> -->
					 		</div>
					 	</div>
					 	<br/>
					</fieldset>	
				</div>
			</div>
			
			
		</div>
			<%-- <%out.flush();%>
				<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationRoles/OrganizationRoles.jsp"/>
			<%out.flush();%> --%>
		</c:if>
	</div>
</div>
<input type="hidden" id="authToken" value="${authToken}"/>
<div id="overlay" class="nodisplay"></div>
