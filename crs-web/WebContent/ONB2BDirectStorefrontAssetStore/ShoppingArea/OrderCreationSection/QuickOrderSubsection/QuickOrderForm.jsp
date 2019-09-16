<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  *	This JSP displays a form for adding partNumbers to an order in a quick manner.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<c:set var="topCategoryPage" value="true" scope="request" />
<c:set var="hasBreadCrumbTrail" value="true" scope="request" />
<c:set var="useHomeRightSidebar" value="true" scope="request" />
<c:set var="pageCategory" value="Browse" scope="request" />
<c:set var="needVfileStylesheet" value="true" scope="request" />

<!-- BEGIN QuickOrderForm.jsp -->
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<%@ include file="../../../Common/CommonCSSToInclude.jspf"%>
<title><fmt:message bundle="${storeText}" key="Quick_Title" /></title>
<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

<script type="text/javascript">
		<fmt:message bundle="${storeText}" key="ERR_RESOLVING_SKU" var="ERR_RESOLVING_SKU" />
		<fmt:message bundle="${storeText}" key="QUANTITY_INPUT_ERROR" var="QUANTITY_INPUT_ERROR" />
		<fmt:message bundle="${storeText}" key="WISHLIST_ADDED" var="WISHLIST_ADDED" />
		<fmt:message bundle="${storeText}" key="SHOPCART_ADDED" var="SHOPCART_ADDED" />
		<fmt:message bundle="${storeText}" key="SHOPCART_REMOVEITEM" var="SHOPCART_REMOVEITEM" />
		<fmt:message bundle="${storeText}" key="ERROR_MESSAGE_TYPE" var="ERROR_MESSAGE_TYPE" />
		<fmt:message bundle="${storeText}" key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message bundle="${storeText}" key="GENERICERR_MAINTEXT" var="ERROR_RETRIEVE_PRICE">
			<fmt:param><fmt:message bundle="${storeText}" key="GENERICERR_CONTACT_US" /></fmt:param>
		</fmt:message>

		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);

		$(document).ready(function() {
			quickOrderJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>', "<fmt:message bundle="${storeText}" key="Quick_Script_Empty_All"/>", "<fmt:message bundle="${storeText}" key="Quick_Script_Non_Integer"/>");
		});
	</script>
</head>

<body>

	<!-- Page Start -->
	<div id="page" class="nonRWDPage">
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

		<!-- Import Header Widget -->
		<div class="header_wrapper_position" id="headerWidget">
			<% out.flush(); %>
			<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
			<% out.flush(); %>
		</div>
		<!-- Header Nav End -->

		<!-- Main Content Start -->
		<div class="content_wrapper_position v9_quick_order_page v9_gen_form">
			<div class="content_wrapper">
				<div class="content_left_shadow">
					<div class="content_right_shadow">
						<div class="main_content">
							<div class="row margin-true">
								<div class="col12">
									<!-- breadcrumb -->
									<% out.flush(); %>
									<wcpgl:widgetImport
										useIBMContextInSeparatedEnv="${isStoreServer}"
										url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
										<wcpgl:param name="pageGroup" value="Content" />
									</wcpgl:widgetImport>
									<% out.flush(); %>
								</div>
							</div>
							<br />
							<div class="row headInsideMenu">
								<div class="col1">&nbsp;</div>
								<div class="col10 userIconLine">
									<div class="quickOrderUserIcon"></div>
									<hr>
								</div>
								<div class="col1">&nbsp;</div>
								<div class="col12">
									<p>Quick Order</p>
								</div>
								<div class="col12 links">
									<div class="normalMenu" id="accDetailMenu">
										<% out.flush(); %>
										<c:import url="${env_jspStoreDir}Common/MyAccountPageURLs.jsp" />
										<% out.flush(); %>
									</div>
								</div>
							</div>
							<div class="container_content_rightsidebar">
								<div class="row">
									<div class="col12">
										<h2>
											<fmt:message bundle="${storeText}" key="Quick_LIST_Title" />
										</h2>
									</div>
								</div>

								<!-- List Table Starts -->
								<div class="row margin-true">
									<div class="col12">
										<div class="v9_quick-order-lists listTable orderHistoryPage">
											<%@include file="QuickOrderLists.jspf"%>
										</div>
									</div>
								</div>
								<!-- List Table Ends -->

								<div class="row margin-true">
									<div class="col12">
										<h2>
											<fmt:message bundle="${storeText}" key="Quick_Title" />
										</h2>
									</div>
								</div>
								<div class="row margin-true">
									<div class="col12">
										<div class="body" id="WC_QuickOrderForm_div_5">
											<div id="quick_order">
												<span><fmt:message bundle="${storeText}" key="Quick_Text" /></span>
												<br clear="left" />
												<br />
												<%-- display error message if any --%>
												<div class="error_text" id="WC_QuickOrderForm_div_6">
													<c:if test="${!empty errorMessage}">
														<span class="error"><c:out value="${errorMessage}" /><br /> <br /> </span>
													</c:if>
												</div>
											</div>

											<div class="input_form orderHistoryPage col12 acol12" id="WC_QuickOrderForm_div_7" role="grid">
												<form name="MQuickOrderForm" method="post" action="RESTOrderItemAdd" id="MQuickOrderForm">
													<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="WC_QuickOrderForm_FormInput_storeId_In_MQuickOrderForm_1" />
													<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="WC_QuickOrderForm_FormInput_catalogId_In_MQuickOrderForm_1" />
													<input type="hidden" name="langId" value="<c:out value='${langId}'/>" id="WC_QuickOrderForm_FormInput_langId_In_MQuickOrderForm_1" />
													<input type="hidden" name="URL" value="AjaxOrderItemDisplayView?storeId=<c:out value='${WCParam.storeId}'/>&catalogId=<c:out value='${WCParam.catalogId}'/>&langId=<c:out value='${WCParam.langId}'/>" id="WC_QuickOrderForm_FormInput_url_${catalogEntryID}" />
													<input type="hidden" name="outOrderName" value="orderId" id="WC_QuickOrderForm_FormInput_outOrderName_In_MQuickOrderForm_1" />
													<input type="hidden" name="errorViewName" value="QuickOrderView" id="WC_QuickOrderForm_FormInput_errorViewName_<c:out value='${catalogEntryID}'/>" />
													<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_QuickOrderForm_FormInput_calcUsage_<c:out value='${catalogEntryID}'/>" />
													
													<c:set var="x" value="102" />
													
													<fmt:message bundle="${storeText}" key="ACCE_REGION_SKUTYPEAHEAD" var="autoSuggestBySKULabel" />

													<div class="createTableList">
														<label for="MQuickOrderForm_NewListForm_Name"><fmt:message key="${widgetNameCaps}_CREATE_LIST" bundle="${storeText}" /></label>
														<input id="MQuickOrderForm_NewListForm_Name" type="text" aria-label="<fmt:message key="LISTTABLE_ENTER_NAME" bundle="${storeText}"/>" name="name" placeholder="<fmt:message key="LISTTABLE_ENTER_NAME" bundle="${storeText}"/>" role="menuitem" class="input_field" maxlength="254">
														<c:if test="${!hidePublicPrivateDropdown eq 'true'}">
															<div id="newListPublicPrivateDropdown" class="selectWrapper col4 acol8">
																<c:set var="selectOptions" value='{"appendTo": "#newListPublicPrivateDropdown"}' />
																<select name="status" data-widget-type="wc.Select" data-widget-options="${fn:escapeXml(selectOptions)}" title="<fmt:message key='SN_SORT_BY_USAGE' bundle='${storeText}'/>" id="listType" baseClass="wcSelect dijitValidationTextBox orderBySelect">
																	<option selected="selected" value="Z"><fmt:message key="${widgetNameCaps}_TYPE_SHARED" bundle="${storeText}" /></option>
																	<option value="Y"><fmt:message key="${widgetNameCaps}_TYPE_PRIVATE" bundle="${storeText}" /></option>
																</select>
															</div>
														</c:if>
														<input type="hidden" name="quickOrder" value="Q" id="MQuickOrderForm_Quick_Order" />
														<div class="clearFloat"></div>
													</div>
													
													<div class="row margin-true">
														<div class="col12" id="WC_QuickOrderForm_div_8" role="row">
															<div class="row tableHeader FavouritesPageHeader skuHeader fullView ">
																<div class="sku-item col2" role="columnheader">
																	<div class="cell">
																		<span>
																			<fmt:message bundle="${storeText}" key="Quick_Col0">
																			</fmt:message>
																		</span>
																	</div>
																</div>
																<div class="_SKU col3" role="columnheader" id="WC_QuickOrderForm_div_9">
																	<div class="cell">
																		<span>
																			<fmt:message bundle="${storeText}" key="Quick_Col1">
																				<fmt:param value="" />
																			</fmt:message>
																		</span>
																	</div>
																</div>
																<div class="_QTY col2" role="columnheader"
																	id="WC_QuickOrderForm_div_10">
																	<div class="cell">
																		<span>
																			<fmt:message bundle="${storeText}" key="Quick_Col2">
																				<fmt:param value="" />
																			</fmt:message>
																		</span>
																	</div>
																</div>
																<div class="_QTY col5" role="columnheader"
																	id="WC_QuickOrderForm_div_10">
																	<div class="cell">
																		<span>
																			<fmt:message bundle="${storeText}" key="Quick_Col3">
																				 <fmt:param value="" />
																			</fmt:message>
																		</span>
																	</div>
																</div>
															</div>
														</div>
													</div>

													<div class="fullView FavouritesFullViewPage setInputWidth">
														<c:forEach begin="1" end="${x}" var="k" step="1" varStatus="b">
															<c:choose>
																<c:when test="${count == 1}">
																	<c:set var="p" value="${count + k - 1}" />
																</c:when>
																<c:otherwise>
																	<c:set var="p" value="${count + k}" />
																</c:otherwise>
															</c:choose>

															<c:set var="partNumber_p" value="partNumber_${p}" />
															<c:set var="suffix" value="_${partNumber_p}" />
															<c:set var="autoSKUSuggestInputField" value="${partNumber_p}" />
															<c:set var="quantity_p" value="quantity_${p}" />
															<c:set var="description_p" value="description_${p}" />

															<c:choose>
																<c:when test="${b.count < 13}">
																	<div role="row" class="row entry"
																		id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>">
																		<div class="col2 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="line_number" role="gridcell" id="WC_QuickOrderForm_div_12_<c:out value='${b.count}'/>">
																					<c:out value="${p}" />
																					.
																				</div>
																			</div>
																		</div>
																		<div class="col3 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields v9_subFields"
																					role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_9"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_1">
																					<input name="<c:out value="${partNumber_p}"/>"
																						role="textbox"
																						id="<c:out value="${partNumber_p}"/>" type="text"
																						class="SKU_field"
																						onKeyPress="if(event.keyCode==13 || event.keyCode == 9){quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);}"
																						onchange="quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);"
																						onblur="quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);" 
																						onfocusout="hideAddSearch(<c:out value='${b.count}'/>)"/>
																				</div>
																			</div>
																		</div>
																		<div class="col2 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields" role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_10"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_2">
																					<input name="<c:out value="${quantity_p}"/>"
																						role="textbox" id="<c:out value="${quantity_p}"/>"
																						type="text" size="4" class="QTY_field" />
																				</div>
																			</div>
																		</div>
																		<div class="col5 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields" role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_11"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_3">
																					<input name="<c:out value="${description_p}"/>"
																						role="textbox"
																						id="<c:out value="${description_p}"/>" type="text"
																						class="DESC_field" />
																				</div>
																			</div>
																		</div>
																		<% out.flush(); %>
																		<wcpgl:widgetImport
																			useIBMContextInSeparatedEnv="${isStoreServer}"
																			url="${env_siteWidgetsDir}Common/MyAccountList/AutoSKUSuggest_UI.jsp">
																			<wcpgl:param name="suffix" value="${suffix}" />
																			<wcpgl:param name="autoSKUSuggestInputField"
																				value="${autoSKUSuggestInputField}" />
																			<wcpgl:param name="autoSuggestBySKULabel"
																				value="${autoSuggestBySKULabel}" />
																		</wcpgl:widgetImport>
																		<% out.flush(); %>
																	</div>
																</c:when>
																<c:otherwise>
																	<div role="row" class="row entry"
																		id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>"
																		style="display: none;">
																		<div class="col2 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="line_number" role="gridcell"
																					id="WC_QuickOrderForm_div_12_<c:out value='${b.count}'/>">
																					<c:out value="${p}" />
																					.
																				</div>
																			</div>
																		</div>
																		<div class="col3 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields v9_subFields"
																					role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_9"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_1">
																					<input name="<c:out value="${partNumber_p}"/>"
																						role="textbox"
																						id="<c:out value="${partNumber_p}"/>" type="text"
																						class="SKU_field"
																						onKeyPress="if(event.keyCode==13 || event.keyCode == 9){quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);}"
																						onchange="quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);"
																						onblur="quickOrderJS.getProdDesc('MQuickOrderForm',this.value,<c:out value='${p}'/>);" />
																				</div>
																			</div>
																		</div>
																		<div class="col2 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields" role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_10"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_2">
																					<input name="<c:out value="${quantity_p}"/>"
																						role="textbox" id="<c:out value="${quantity_p}"/>"
																						type="text" size="4" class="QTY_field" />
																				</div>
																			</div>
																		</div>
																		<div class="col5 name" role="gridcell">
																			<div class="cell fileName">
																				<div class="input_sub_fields" role="gridcell"
																					aria-describedby="WC_QuickOrderForm_div_11"
																					id="WC_QuickOrderForm_div_11_<c:out value='${b.count}'/>_3">
																					<input name="<c:out value="${description_p}"/>"
																						role="textbox"
																						id="<c:out value="${description_p}"/>" type="text"
																						class="DESC_field" />
																				</div>
																			</div>
																		</div>
																		<% out.flush(); %>
																		<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}Common/MyAccountList/AutoSKUSuggest_UI.jsp">
																			<wcpgl:param name="suffix" value="${suffix}" />
																			<wcpgl:param name="autoSKUSuggestInputField" value="${autoSKUSuggestInputField}" />
																			<wcpgl:param name="autoSuggestBySKULabel" value="${autoSuggestBySKULabel}" />
																		</wcpgl:widgetImport>
																		<% out.flush(); %>
																	</div>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														<div id="productDiv"></div>
													</div>
													<a href="#" class="addNewField" onClick="javascript:addProductField('WC_QuickOrderForm_div_11_');">+Add more items</a> <br />
													<div class="order_button" id="WC_QuickOrderForm_div_13">
														<flow:ifEnabled feature="AjaxAddToCart">
															<a href="#" class="button_primary" id="WC_QuickOrderForm_link_1" tabindex="0" onclick="javaScript: setCurrentId('WC_QuickOrderForm_link_1'); quickOrderJS.checkPartNumber('MQuickOrderForm','false');">
																<div class="left_border"></div>
																<div class="button_text">
																	<fmt:message bundle="${storeText}" key="Quick_Add_To_Order" />
																</div>
																<div class="right_border"></div>
															</a>
														</flow:ifEnabled>
														<flow:ifDisabled feature="AjaxAddToCart">
															<a href="#" class="button_primary" id="WC_QuickOrderForm_link_2" tabindex="0" onclick="javaScript: quickOrderJS.addToOrderAjax('MQuickOrderForm');">
																<div class="left_border"></div>
																<div class="button_text">
																	<fmt:message bundle="${storeText}" key="Quick_Add_To_Order" />
																</div>
																<div class="right_border"></div>
															</a>
														</flow:ifDisabled>
														<a id="MQuickOrderForm_NewListForm_Save" class="button_secondary" role="button" href="#" onclick="javascript:quickOrderJS.checkPartNumber('MQuickOrderForm','true');" role="menuitem">
															<div class="left_border"></div>
															<div class="button_text">
																<span>
																	<fmt:message key="LISTTABLE_SAVE" bundle="${storeText}" />
																</span>
															</div>
															<div class="right_border"></div>
														</a>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>

								<div class="right_column">
									<%out.flush();%>
									<wcpgl:widgetImport
										useIBMContextInSeparatedEnv="${isStoreServer}"
										url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.CatalogEntryRecommendation/CatalogEntryRecommendation.jsp">
										<wcpgl:param name="emsName" value="ShoppingCartRight_CatEntries" />
										<wcpgl:param name="widgetOrientation" value="vertical" />
										<wcpgl:param name="pageSize" value="2" />
									</wcpgl:widgetImport>
									<%out.flush();%>
								</div>
							</div>

							<div class="footer" id="WC_QuickOrderForm_div_19">
								<div class="left_corner" id="WC_QuickOrderForm_div_20"></div>
								<div class="tile" id="WC_QuickOrderForm_div_21"></div>
								<div class="right_corner" id="WC_QuickOrderForm_div_22"></div>
							</div>
						</div>
						<!-- Content End -->
					</div>
					<!-- Main Content End -->
				</div>
			</div>
		</div>
	</div>

	<!-- Footer Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
		<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
	<!-- Footer End -->

	<flow:ifEnabled feature="Analytics">
		<cm:pageview />
	</flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%>
</body>
</html>
<script language="javascript">
var counter = 13;
function addProductField(divID){
	if(divID == "WC_QuickOrderForm_div_11_"){		
		var i;
		for (i = 0; i <= 4; i++) {
			$('#WC_QuickOrderForm_div_11_'+counter).css('display','block');
			counter++;
		}
	}
	quickOrderJS.numberOfItemsSupportedPerQuickOrder = (counter - 1);
}

function hideAddSearch(i) {	
	window.setTimeout(function() { $('#skuAddSearch_partNumber_'+i).css('display','none') }, 700);
}

</script>
<!-- END QuickOrderForm.jsp -->
