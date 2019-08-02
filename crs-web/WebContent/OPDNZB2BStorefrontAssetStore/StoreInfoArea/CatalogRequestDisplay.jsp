<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>

<!-- BEGIN CatalogRequestDisplay.jsp -->

<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>


<c:set var="countryBean" value="${requestScope.countryBean}"/>

<c:if test="${empty countryBean || countryBean == null}">
	<c:set var="key1" value="store/${WCParam.storeId}/country/country_state_list+${langId}+${paramSource.country}"/>
	<c:set var="countryBean" value="${cachedOnlineStoreMap[key1]}"/>
	<c:if test="${empty countryBean}">
		<wcf:rest var="countryBean" url="store/{storeId}/country/country_state_list" cached="true">
			<wcf:var name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="countryCode" value="${paramSource.country}"/>
		</wcf:rest>
		<wcf:set target = "${cachedOnlineStoreMap}" key="${key1}" value="${countryBean}"/>
	</c:if>
</c:if>
<c:if test="${empty countryListSelectionHelperInitialized || countryListSelectionHelperInitialized != 'true'}">
	<div id="countryListSelectionHelper" style="display: none">
	
	{ "countries" : [ 
		
		<c:forEach var="country" items="${countryBean.countries}"  varStatus='outerStatus'>
		
			{ 
				"code" : "<c:out value="${country.code}"/>",
				"displayName" : "<c:out value="${country.displayName}"/>",
				"callingCode" : "<c:out value="${country.callingCode}"/>",
				"states" : [
					<c:forEach var="stateObj" items="${country.states}" varStatus="innerStatus">
				  			 { "code" : "<c:out value="${stateObj.code}"/>",
				  			   "displayName" : "<c:out value="${stateObj.displayName}"/>"
				  			 }
				  			 <c:if test="${!innerStatus.last}">, </c:if>
				  	</c:forEach>
				  		   ] 			 
			}
			<c:if test="${!outerStatus.last}">, </c:if>
		</c:forEach>
	]}
	</div>
	<c:set var="countryListSelectionHelperInitialized" value="true" scope="request"/>
</c:if>

<script type="text/javascript">
	$( document ).ready(function() { 
		AddressHelper.setStateDivName("stateDiv");
	});
</script>

<c:set var="plPageId" value="${WCParam.pageId}"/>
<c:set var="pageCategory" value="Browse" scope="request"/>
<c:if test="${empty plPageId}">
	<%-- Check if we can get it from pageName --%>
	<c:set var="tempPageName" value="${WCParam.pageName}"/>
	<c:if test="${empty tempPageName}">
		<%-- If we are forwarded here by a command, then pageName will be available in request attribute rather than request parameter --%>
		<c:set var="tempPageName" value="${pageName[0]}"/>
	</c:if>
	<c:if test="${!empty tempPageName}">
		<wcf:rest var="getPageResponse" url="store/{storeId}/page">
			<wcf:var name="storeId" value="${storeId}" encode="true"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="q" value="byNames"/>
			<wcf:param name="name" value="${tempPageName}"/>
			<wcf:param name="profileName" value="IBM_Store_Details"/>
		</wcf:rest>
		<c:set var="page" value="${getPageResponse.resultList[0]}"/>
		<c:set var="plPageId" value="${page.pageId}"/>
	</c:if>
</c:if>

<c:if test="${!empty plPageId}">
	<c:if test="${empty page}">
		<wcf:rest var="getPageResponse" url="store/{storeId}/page/{pageId}">
			<wcf:var name="storeId" value="${storeId}" encode="true"/>
			<wcf:var name="pageId" value="${plPageId}" encode="true"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="profileName" value="IBM_Store_Details"/>
		</wcf:rest>
		<c:set var="page" value="${getPageResponse.resultList[0]}"/>
	</c:if>
	<c:set var="pageGroup" value="Content" scope="request"/>
	<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="q" value="byObjectIdentifier"/>
		<wcf:param name="objectIdentifier" value="${plPageId}"/>
		<wcf:param name="deviceClass" value="${deviceClass}"/>
		<wcf:param name="pageGroup" value="${pageGroup}"/>
		<c:catch>
			<c:forEach var="aParam" items="${WCParamValues}">
				<c:forEach var="aValue" items="${aParam.value}">
					<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='logonPasswordVerify' && aParam.key !='URL' && aParam.key !='currency' && aParam.key !='storeId' && aParam.key !='catalogId' && aParam.key !='logonPasswordOld' && aParam.key !='logonPasswordOldVerify' && aParam.key !='account' && aParam.key !='cc_cvc' && aParam.key !='check_routing_number' && aParam.key !='plainString' && aParam.key !='xcred_logonPassword'}">
						<wcf:param name="${aParam.key}" value="${aValue}"/>
					</c:if>
				</c:forEach>
			</c:forEach>
		</c:catch>
	</wcf:rest>
	
	<c:set var="pageName" value="${page.name}"/>
	<c:set var="emsNameLocalPrefix" value="${fn:replace(pageName,' ','')}" scope="request"/>
	<c:set var="emsNameLocalPrefix" value="${fn:replace(emsNameLocalPrefix,'\\\\','')}"/>
	<c:set var="contentPageTitle" value="${page.title}" scope="request"/>	
	<c:set var="contentPageName" value="${pageName}" scope="request"/>
</c:if>

<%-- If CategoryNavigationWidget is included in this page, then do not display the productCount. Content pages will have count set to '0' always --%>
<c:set var="displayProductCount" value="false" scope="request"/>

<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<%@ include file="../Common/CommonCSSToInclude.jspf" %>
	<%@ include file="../Common/CommonJSToInclude.jspf" %>
	
	<script type="text/javascript">
	<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
		document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
		</c:if>
	</script>
		
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Request Catalogue</title>
	<meta name="description" content="<c:out value="${page.metaDescription}"/>"/>
	<meta name="keywords" content="<c:out value="${page.metaKeyword}"/>"/>
	<meta name="pageIdentifier" content="<c:out value="${pageName}"/>"/>	
	<meta name="pageId" content="<c:out value="${plPageId}"/>"/>
	<meta name="pageGroup" content="<c:out value="${requestScope.pageGroup}"/>"/>

</head>

	<body>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
		
		<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
		<c:set var="layoutPageName" value="${page.name}"/>
		<div id="page">
			<div id="headerWrapper">
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
					<c:param name="omitHeader" value="${WCParam.omitHeader}" />
				</c:import>
				<%out.flush();%>
			</div>
			
			<div id="contentWrapper">
				<div id="content" role="main">
					<div class="requestCatalogPage">
					<table width="100%" cellpadding="8" border="0" id="WC_CatalogRequestDisplay_Table_1">
  <tbody>
    <tr>
      <td class="title" id="WC_CatalogRequestDisplay_TableCell_1">
		<h1>Request Catalogue</h1>
		<br/>
		<hr class="requestCatelogLine"/>
		<div class="description">
		Please fill in the following and we will send you a full colour catalogue of our products
		</div>
		<hr/>
		<div class="logontxt">
			<div class="required-field"> * </div><span>Indicates a required field.</span>
				<c:if test="${!empty errorMessage}">
					<br/><span class="warning"><c:out value="${errorMessage}"/></span>
				</c:if>
			</span>
			<br/><br/>
		</div>
		<form name="CatalogRequestForm" method="post" action="CatalogRequestReceivedNotification" id="CatalogRequestForm">

		<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_CatalogRequestFormForm_FormInput_1"/>
		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_CatalogRequestFormForm_FormInput_2"/>
		<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_CatalogRequestFormForm_FormInput_3"/>
		<input type="hidden" name="URL" value="CatalogRequestSubmittedView" id="WC_CatalogRequestFormForm_FormInput_4"/>
		
		<input type="hidden" id="WC_CatalogRequestFormForm_FormInput_catReq_Latitude" name="catReq_Latitude" value=""/>
		<input type="hidden" id="WC_CatalogRequestFormForm_FormInput_catReq_Logitude" name="catReq_Logitude" value=""/>

		<table cellpadding="0" class="bodyTable"  cellspacing="7" border="0" width="100%" id="WC_CatalogRequestForm_Table_1">

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_1">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_NameTitle">Title</label>
					<br/>
					<c:set var="Reg_Drop1">Mr.</c:set>
					<c:set var="Reg_Drop2">Mrs.</c:set>
					<c:set var="Reg_Drop3">Ms.</c:set>
					<c:set var="Reg_Drop4">Dr.</c:set>
			
					<select class="logon select titleSelect" id="WC_CatalogRequestFormForm_FormInput_catReq_NameTitle" name="catReq_NameTitle">
						<option value=""<c:if test="${empty parm_NameTitle}"> selected="selected"</c:if>/>
						<option value="<c:out value="${Reg_Drop1}"/>"<c:if test="${parm_NameTitle == Reg_Drop1}"> selected="selected"</c:if>><c:out value="${Reg_Drop1}"/></option>
						<option value="<c:out value="${Reg_Drop2}"/>"<c:if test="${parm_NameTitle == Reg_Drop2}"> selected="selected"</c:if>><c:out value="${Reg_Drop2}"/></option>
						<option value="<c:out value="${Reg_Drop3}"/>"<c:if test="${parm_NameTitle == Reg_Drop3}"> selected="selected"</c:if>><c:out value="${Reg_Drop3}"/></option>
						<option value="<c:out value="${Reg_Drop4}"/>"<c:if test="${parm_NameTitle == Reg_Drop4}"> selected="selected"</c:if>><c:out value="${Reg_Drop4}"/></option>
					</select>
				</td>
			</tr>
 
			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_3">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_FirstName"><fmt:message key="FIRST_NAME" bundle="${storeText}"/></label>
					<br/>
					<input class="logon input" type="text" maxlength="40" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_FirstName" name="catReq_FirstName" value="<c:out value="${parm_FirstName}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_5">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_LastName"><fmt:message key="LAST_NAME" bundle="${storeText}"/></label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="40" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_LastName" name="catReq_LastName" value="<c:out value="${parm_LastName}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_7">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_CompanyName">Company:</label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="40" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_CompanyName" name="catReq_CompanyName" value="<c:out value="${parm_CompanyName}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_9">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_Address1"><fmt:message key="STREET_ADDRESS" bundle="${storeText}"/></label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" style="margin-bottom:0px;" type="text" maxlength="49" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_Address1" name="catReq_Address1" title="<fmt:message key="STREET_ADDRESS_LINE1" bundle="${storeText}"/>" value="<c:out value="${parm_Address1}"/>"/>
				</td>
			</tr>
			<tr>
				<td id="WC_CatalogRequestForm_TableCell_10a">
					<input class="logon input" type="text" maxlength="49" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_Address2" name="catReq_Address2" title="<fmt:message key="STREET_ADDRESS_LINE2" bundle="${storeText}"/>" value="<c:out value="${parm_Address2}"/>"/>
				</td>
			</tr>
			
			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_11">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_City"><fmt:message key="CITY" bundle="${storeText}"/></label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="40" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_City" name="catReq_City" value="<c:out value="${parm_City}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_13">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_State">State:</label><div class="required-field"> * </div>
					<br/>
				<div id="WC_CatalogRequestForm_stateDiv" />
					
				<%-- Retrieve states list from existing databean --%>
				<c:forEach var="country" items="${countryBean.countries}"  varStatus='outerStatus'>
					<c:if test="${country.code eq 'AU'}">
						<c:set var="countryCodeStates" value="${country.states}"/>
					</c:if>
				</c:forEach>
				<c:choose>
					<c:when test="${!empty countryCodeStates}">
						<div id="<c:out value='${paramPrefix}stateDiv'/>">
							<c:set var="selectOptions" value='{"wcMenuClass": "wcSelectMenu"}' />						
							<select class="logon select" data-widget-type="wc.Select" class="wcSelect inputField" data-widget-options="${fn:escapeXml(selectOptions)}" aria-required="true" id="<c:out value='${paramPrefix}WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}state_1'/>" name="<c:out value="${paramPrefix}catReq_State"/>">
								<c:forEach var="state1" items="${countryCodeStates}">
									<option value="<c:out value="${state1.code}"/>"
										<c:if test="${state1.code eq state || state1.displayName eq state}">
											selected="selected"
										</c:if>
									>
										<c:out value="${state1.displayName}"/>
									</option>
								</c:forEach>
							</select>
						</div>
					</c:when>
					<c:otherwise>
						<div id="<c:out value='${paramPrefix}stateDiv'/>">
							<input class="inputField" type="text" maxlength="40" size="35" id="<c:out value='${paramPrefix}WC_${pageName}_AddressEntryForm_FormInput_${paramPrefix}state_1'/>" name="<c:out value="${paramPrefix}state"/>" value="<c:out value='${state}'/>"/>
						</div>
					</c:otherwise>
				</c:choose>
				
				</div>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_15">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_Country">Country:</label><div class="required-field"> * </div>
					<br/>
					<select class="logon select" id="WC_CatalogRequestFormForm_FormInput_catReq_Country" name="catReq_Country" onchange="javascript:AddressHelper.loadStatesUI(CatalogRequestForm)" >
						<c:forEach var="country" items="${countryBean.countries}">
						<c:if test="${country.code eq 'AU' || country.code eq 'NZ'}">
							<option value="<c:out value="${country.code}"/>"
								<c:if test="${country.code eq parm_Country || country.displayName eq parm_Country}">
									selected="selected"
								</c:if>
							><c:out value="${country.displayName}"/></option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>

			<tr>	
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_17">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_ZipCode">
					Postal Code:</label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="30" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_ZipCode" name="catReq_ZipCode" value="<c:out value="${parm_ZipCode}"/>"/>
				</td>
			</tr>

			<tr>	
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_19">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_Phone"><fmt:message key="PHONE_NUMBER" bundle="${storeText}"/></label><div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="32" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_Phone" name="catReq_Phone" value="<c:out value="${parm_Phone}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2" id="WC_CatalogRequestForm_TableCell_21">
					<label for="WC_CatalogRequestFormForm_FormInput_catReq_Email">E-mail address:</label>
					<div class="required-field"> * </div>
					<br/>
					<input class="logon input" type="text" maxlength="80" size="35" id="WC_CatalogRequestFormForm_FormInput_catReq_Email" name="catReq_Email" value="<c:out value="${parm_Email}"/>"/>
				</td>
			</tr>

			<tr>
				<td class="logonheading t_td2 checkboxHolder" id="WC_CatalogRequestForm_TableCell_23">
					<input type="hidden" name="catReq_ReceiveEmail" value="" id="WC_CatalogRequestFormForm_FormInput_catReq_ReceiveEmail"/>
					<input type="checkbox" name="catReq_SendMeEmail" id="WC_CatalogRequestFormForm_FormInput_catReq_SendMeEmail" <c:if test="${parm_ReceiveEmail}"> checked="checked" </c:if>/>
					<span>Send me e-mails about store specials.</span>
				</td>
			</tr>

			<tr>
				<td>
					
						
					
				</td>
			</tr>

			<tr>
				<td valign="bottom" class="button" id="WC_CatalogRequestForm_TableCell_24">
					<br/>
					<a href="javascript:AddressHelper.submitFormRequestCatalog('CatalogRequestForm')" class="button_primary" id="WC_CatalogRequestForm_Link_1"><div class="button_text">Submit</div></a>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr> 
		
		</table>
		</form>
		</td>
		</tr>
		</tbody>
		</table>
		</div>
				</div>
			</div>
			
			<div id="footerWrapper">
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp">
					<c:param name="omitHeader" value="${WCParam.omitHeader}" />
				</c:import>
				<%out.flush();%>
			</div>
		</div>
	
	<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
	<c:set var="layoutPageName" value="${page.name}"/>
	<%@ include file="../Common/LayoutPreviewSetup.jspf"%>

	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../Common/JSPFExtToInclude.jspf"%> 
	</body>
	<c:if test = "${!empty plPageId}">
		<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${plPageId}"/>
	</c:if>
</html>
<!-- END CatalogRequestDisplay.jsp -->