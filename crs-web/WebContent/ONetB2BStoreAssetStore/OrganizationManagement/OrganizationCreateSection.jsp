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
<wcf:url var="organizationsAndUsersViewURL" value="OrganizationsAndUsersView" >
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="orgEntityId" value="${param.parentOrgEntityId}" />
</wcf:url>
<script>
function addCostCentre(field, fieldId) {
	var newCostCentre = field.value;
	addToCostCentreList(newCostCentre, field, fieldId);
	drawCostCentreBox(field, fieldId);
}
function addToCostCentreList(newCostCentre, field, fieldId) {
	//newCostCentre = trimString(newCostCentre);
	//alert("In Add " + newCostCentre);
	if (newCostCentre != "") {
		var costCentreOptionNew = document.createElement('option');
		costCentreOptionNew.text = newCostCentre;
		costCentreOptionNew.value = newCostCentre;
		var costCentreList = getCostCenterList(fieldId);
		var optArray = new Array(costCentreList.options.length); 
		var optArray1 = new Array(); 
		var costLength = costCentreList.options.length;
		
		try {
			costCentreList.add(costCentreOptionNew, null); // standards compliant; doesn't work in IE
		}
		catch(ex) {
			costCentreList.add(costCentreOptionNew); // IE only
		}
	}
	else{
		alert("Invalid value.");
	}
	drawCostCentreBox(field, fieldId);
	if(costLength > 0 ){
		optArray1[0] = costCentreList.options[costLength].value;
		for(var i=0; i<costLength; i++){
			optArray [i] = costCentreList.options[i].value;				
		}
		for(var i2=0; i2<costLength+1; i2++){
			costCentreList.options[0].remove();			
		}
		var b = true;
		
		for (var i3 = 0; i3<optArray.length+1; i3++) {
			if(b){
				b = false;
				var temp = document.createElement('option');
				temp.text = optArray1[0];
				temp.value = optArray1[0];
				try {
					costCentreList.add(temp, null); // standards compliant; doesn't work in IE
				} 
				catch(ex) {
					costCentreList.add(temp); // IE only
				}
				drawCostCentreBox(field, fieldId);
				i3 = 0;
			}
			else{
				var temp = document.createElement('option');
				temp.text = optArray[i3-1];
				temp.value = optArray[i3-1];
				try {
					costCentreList.add(temp, null); // standards compliant; doesn't work in IE
				} 
				catch(ex) {
					costCentreList.add(temp); // IE only
				}
				drawCostCentreBox(field, fieldId);
			}
		}
	}
}

function drawCostCentreBox(field, fieldId) {
	field.value = "";
	var costCentreList = getCostCenterList(fieldId);
	if (costCentreList.length > 4) {
		costCentreList.size = 4;
	} 
	else {
		costCentreList.size = costCentreList.length;
	}
	var costCentreBox = getCostCentreBox(fieldId);
	if (costCentreList.length > 0) {
		costCentreBox.style.display = 'block';
	} else {
		costCentreBox.style.display = 'none';
	}
	combineCostCentre(costCentreList, fieldId);
}


function getCostCenterList(fieldId){
	var costCentreList = '';
	if(fieldId == 'usr_'){		
		costCentreList = document.getElementById('costCentreList_usr');
	}
	else if(fieldId == 'org_'){
		costCentreList = document.getElementById('costCentreList_org');
	}
	else{
		costCentreList = document.getElementById('costCentreList');
	}
	
	return costCentreList;
}

function getCostCentreBox(fieldId){
	var costCentreBox = '';
	if(fieldId == 'usr_'){		
		costCentreBox = document.getElementById('costCentreBox_usr');
	}
	else if(fieldId == 'org_'){
		costCentreBox = document.getElementById('costCentreBox_org');
	}
	else{
		costCentreBox = document.getElementById('costCentreBox');
	}
	
	return costCentreBox;
}
 
function removeCostCentre(field, fieldId) {
	var costCentreList = getCostCenterList(fieldId);
	
	var i;
	for (i = costCentreList.length - 1; i>=0; i--) {
		if (costCentreList.options[i].selected) {
			costCentreList.remove(i);
		}
	}
	drawCostCentreBox(field, fieldId);
}
 
function combineCostCentre(costCentreList1, fieldId) {
	var costCentreList = getCostCenterList(fieldId);
	var i;
	var combinedString = "";
	for (i = 0; i<costCentreList.length; i++) {
		if (i != 0) {
			combinedString = combinedString + ";";
		}
		combinedString = combinedString + costCentreList.options[i].value;
	}
	
	if(fieldId == 'usr_'){		
		document.getElementById('costCentreCombined_usr').value = combinedString;
	}
	else if(fieldId == 'org_'){
		document.getElementById('costCentreCombined_org').value = combinedString;
	}
	else{
		document.getElementById('costCentreCombined').value = combinedString;
	}
	
}
function loadCostCentreList() {
	var string1 = "";
	var tarray = new Array();
	tarray = string1.split(";");
	for (i = 0; i < tarray.length; i++) {
		addToCostCentreList(tarray[i]);
	}
	drawCostCentreBox();
}
</script>

<div style="margin-bottom:0px;" id="PageHeader_CreateOrganization" tabindex="0">
	<h1 style="padding: 0px 0px;" class="RequisitionListHeader"><fmt:message key="ORG_CREATE_ORG_HEADING" bundle="${storeText}"/></h1>
	<p class="required"> * <fmt:message key="REQUIRED_FIELDS" bundle="${storeText}"/></p>
</div>

<div class="row organizationCreatePage">
	<div class="col6 acol12 addJustWidth ">
		<fieldset class="organizationDetails">
				<legend><label>Organization Details</label></legend>
		<%out.flush();%>
			<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationSummary/OrganizationSummary.jsp">
				<wcpgl:param name="orgSummaryType" value="create"/>
			</wcpgl:widgetImport>
		<%out.flush();%>
		</fieldset>
		
		<fieldset class="organizationDetails">
				<legend><label>Parent Organization</label></legend>
		<div class="pageSection">
			<div id="orgDetailsEdit">
				<div class="field col12 row">
					<span class="spanacce">
						<label for="orgName">
							<fmt:message bundle="${storeText}" key="ORG_CREATE_ORG_NAME"/>
						</label>
					</span>
					<div class="col5"><span><fmt:message key="ORG_CREATE_ORG_NAME" bundle="${storeText}"/></span><span class="required">*</span></div>
					<div class="col7"><input type="text" id="orgName" name="orgName"/></div>
				</div>
				<c:set var="orgListHeading">
					<fmt:message key="ORG_CREATE_ORG_PARENT_ORG_NAME" bundle="${storeText}"/>
				</c:set>
				<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationList/OrganizationList.jsp">
					<wcpgl:param name="showOrgSummary" value="false"/>
					<wcpgl:param name="forParentOrg" value="true"/>
					<wcpgl:param name="parentOrgEntityId" value="${param.parentOrgEntityId}"/>
					<wcpgl:param name="createOrgPage" value="true"/>
					<wcpgl:param name="orgListHeading" value="${orgListHeading}"/>
					<wcpgl:param name="orgListHeading_2" value=" "/>
				</wcpgl:widgetImport>
			</div>
		</div>
		</fieldset>
		<%-- <c:if test = "${(env_shopOnBehalfSessionEstablished eq 'false' && env_shopOnBehalfEnabled_CSR eq 'false')}">
			This is a normal buyerAdmin session or buyerAdmin on-behalf-session for another buyerAdmin. Not a CSR session
			<%out.flush();%>
				<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrganizationRoles/OrganizationRoles.jsp">
					<wcpgl:param name="roleDisplayType" value="create"/>
					<wcpgl:param name="orgEntityId" value="${param.parentOrgEntityId}"/>
				</wcpgl:widgetImport>
			<%out.flush();%>
		</c:if> --%>

		<div class="row">
			<div class="col12">
				<div style="margin:10px 10px 40px 10px;">
					<div class="editActions">
						<a class="button_primary" role="button" id="orgEntityCreate" onclick="javascript:organizationSummaryJS.createOrgEntity(this.id);return false;" href="#">
							<div class="button_text"><span><fmt:message bundle="${storeText}" key="ORG_SUBMIT"/></span></div>
						</a>

						<a class="button_secondary" role="button" id="orgEntityCreateCancel" onclick="javascript:widgetCommonJS.redirect('${organizationsAndUsersViewURL}');" href="#">
							<div class="button_text"><span><fmt:message bundle="${storeText}" key="ORG_CANCEL"/></span></div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col6 acol12 row adjustOnIpad">
		<div class="col12">
			<fieldset class="orgFinancialsField">
				<legend>Financials</legend>
				<div class="column row">
					<div class="row col12">
						<div class="column_label col3">Cost Centre:</div>
						<div class="col7">
							<input class="inputField" type="text" maxlength="30" size="35"
								id="new_cost_centre" name="new_cost_centre"> <input
								type="hidden" name="userField1" value=""
								id="costCentreCombined" autocomplete="off">
						</div>
						<div class="col2 acol2">
							<a class="button_primary"
								onclick="addCostCentre(document.getElementById('new_cost_centre'), '');">Add</a>
						</div>
						<br>
					</div>
					<br> <span class="col10" name="costCentreBox"
						id="costCentreBox" style="display: block; margin-top: 5px;">

						<select id="costCentreList" multiple="multiple" size="2">
							
					</select> <br> &nbsp;
					</span> <br clear="all"> <a class="button_secondary"
						style="margin-top: 0px; text-align: center;"
						onclick="removeCostCentre('');">Remove Selected</a>

				</div>
				<br>
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

<input type="hidden" id="authToken" value="${authToken}"/>