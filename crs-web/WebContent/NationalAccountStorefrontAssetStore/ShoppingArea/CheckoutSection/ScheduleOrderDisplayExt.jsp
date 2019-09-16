<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP file renders the schedule order section on the shipping and billing page, order summary page and order confirmation page in the checkout flow.
  * This section is only displayed if the 'recurring order' flex flow option is enabled. 
  * Parameters for order scheduling can be edited on the shipping and billing page, but not on the order summary or confirmation page. 
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>

<c:if test="${!empty param.frequency}">
	<c:set value="${param.frequency }" var="frequency"/>
	<c:set value="${param.startDate }" var="startDate"/>
	<c:set value="${param.endDate }" var="endDate"/>
	<c:set value="${param.ScheduleOrderTime }" var="ScheduleOrderTime"/>
	<c:set value="${param.ScheduleOrderAP }" var="ScheduleOrderAP"/>
</c:if>

<c:set var="orderId" value="${param.orderId}"/>
<c:set var="subscriptionId" value="${param.subscriptionId}" />
<c:if test="${WCParam.originalOrderId != null}">
	<c:set var="orderId" value="${WCParam.originalOrderId}"/>
</c:if>
<wcf:url var="OrderCalculateURL" value="OrderShippingBillingView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />						
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="shipmentType" value="single" />
	
</wcf:url>
<wcf:url var="PhysicalStoreSelectionURL" value="CheckoutStoreSelectionView">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="fromPage" value="ShoppingCart" />
</wcf:url>
<input type="hidden" id="orderIdToSchedule" name="orderIdToSchedule" value="${param.orderId}"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_interval"/>
<c:set var="interval" value="${cookie[key].value}"/>

<c:set var="key" value="WC_ScheduleOrder_${orderId}_strStartDate"/>
<c:set var="strStartDate" value="${cookie[key].value}"/>

<c:set var="strStartDate" value="${fn:replace(strStartDate, '%3A', ':')}"/>

<c:set var="key" value="endDate"/>
<c:set var="strEndDate" value="${cookie[key].value}"/>

<c:if test="${(interval == null || strStartDate == null) && !empty requestScope.order}">
	<c:set var="order" value="${requestScope.order}"/>
	<c:set var="interval" value="${order.orderScheduleInfo.interval}"/>
	<c:set var="strStartDate" value="${order.orderScheduleInfo.startTime}"/>
</c:if>

<c:catch>
	<fmt:parseDate parseLocale="${dateLocale}" var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
</c:catch>
<c:if test="${empty strStartDate}">
	<c:catch>
		<fmt:parseDate parseLocale="${dateLocale}" var="strStartDate" value="${strStartDate}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="GMT"/>
	</c:catch>
</c:if>

<c:if test="${param.isShippingBillingPage || param.isMyAccountPage || (interval != null && strStartDate != null && strStartDate != '' && (strStartDate.year+1900 != 1970)) || param.startDate != null}">
	
	<c:set var="formattedTimeZone" value="${fn:replace(cookie.WC_timeoffset.value, '%2B', '+')}"/>
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.75', ':45')}"/>	
	<c:set var="formattedTimeZone" value="${fn:replace(formattedTimeZone, '.5', ':30')}"/>
	<fmt:formatDate value="${strStartDate}" type="date" pattern="MM/dd/yyyy" var="formattedstrStartDate" dateStyle="long" timeZone="${formattedTimeZone}"/>
	<div class="ordShipBillHeaders" id="WC_ScheduleOrder_div_1_1" onclick="ShowHideItem('headPlus0','scheduleBody');">
		<c:choose>	
			<c:when test="${param.isMyAccountPage}">
				<div class="ordShipHeaderSign headPlus0">+</div>
				<div class="ordShipBillHeaderTxt"><span class="main_header_text">Modify Schedule Order</span></div>
				<div class="collaps-icon-plus"></div>
			</c:when>
			<c:otherwise>
				<div class="ordShipHeaderSign headPlus0">+</div>
				<div class="ordShipBillHeaderTxt"><span class="main_header_text">Schedule Order</span></div>
				<div class="collaps-icon-plus"></div>
			</c:otherwise>
		</c:choose>	
	</div>
	<div class="ordShipBillHeaders" style="display:none;" id="WC_ScheduleOrder_div_1_2" onclick="ShowHideItem('headPlus0','scheduleBody');">
		<c:choose>	
			<c:when test="${param.isMyAccountPage}">
				<div class="ordShipHeaderSign headPlus0">+</div>
				<div class="ordShipBillHeaderTxt"><span class="main_header_text">Modify Schedule Order</span></div>
				<div class="collaps-icon-ninus"></div>
			</c:when>
			<c:otherwise>
				<div class="ordShipHeaderSign headPlus0">+</div>
				<div class="ordShipBillHeaderTxt"><span class="main_header_text">Schedule Order</span></div>
				<div class="collaps-icon-ninus"></div>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<div class="scheduleBody" style="display: none;">
	<div id="scheduleOrderBody">
		<c:choose>
			<c:when test="${empty order || order.orderScheduleInfo.startTime == null || empty order.orderScheduleInfo.startTime}">
				<div class="" id="WC_ScheduleOrder_div_5">
					<div class="left_corner" id="WC_ScheduleOrder_div_6"></div>
					<div class="left headerTxt" id="WC_ScheduleOrder_div_7">
						<span class="content_text" id="WC_ScheduleOrder_span_2"><fmt:message key="SCHEDULE_ORDER_HEADER_MESSAGE" bundle="${storeText}"/></span>
					</div>
					<div class="right_corner" id="WC_ScheduleOrder_div_8"></div>
				</div>
			</c:when>
			<c:otherwise>
				<div id="WC_ScheduleOrder_div_15" class="contentline"></div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="clear_float"></div>

		<div class="row col12">
			<div class="col6 acol12 row addjustWidth"
				id="scheduleOrderInputSection">
				<div id="WC_ScheduleOrder_div_9" class="col3 acol12">
					<div id="WC_ScheduleOrder_div_10" class="title"
						<label for="ScheduleOrderFrequency">
						<span class="required-field">*</span>
						<fmt:message bundle="${storeText}" key="SCHEDULE_ORDER_INTERVAL_TITLE" />				
					</label></div>
					<div id="WC_ScheduleOrder_div_11">

						<c:choose>
							<c:when
								test="${param.isShippingBillingPage || param.startDate != null || param.isMyAccountPage}">
								<select class="drop_down_shipping" name="ScheduleOrderFrequency"
									id="ScheduleOrderFrequency"
									onchange="JavaScript:CheckoutPayments.scheduleSelected();this.blur();">
									<option value="undefined"
										<c:if test="${frequency == null}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_DROP_DOWN_SELECT_FREQUENCY"
											bundle="${storeText}" /></option>
									<option value="0"
										<c:if test="${frequency == '0'}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_1" bundle="${storeText}" /></option>
									<option value="86400"
										<c:if test="${frequency == 86400}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_2" bundle="${storeText}" /></option>
									<option value="604800"
										<c:if test="${frequency == 604800}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_3" bundle="${storeText}" /></option>
									<option value="1209600"
										<c:if test="${frequency == 1209600}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_4" bundle="${storeText}" /></option>
									<option value="1814400"
										<c:if test="${frequency == 1814400}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_5" bundle="${storeText}" /></option>
									<option value="2419200"
										<c:if test="${frequency == 2419200}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_6" bundle="${storeText}" /></option>
									<option value="2592000"
										<c:if test="${frequency == 2592000}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_7" bundle="${storeText}" /></option>
									<option value="7776000"
										<c:if test="${frequency == 7776000}">selected="selected"</c:if>><fmt:message
											key="SCHEDULE_ORDER_INTERVAL_8" bundle="${storeText}" /></option>
								</select>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${empty (fn:trim(interval)) || interval == 0}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_1"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 86400}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_2"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 604800}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_3"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 1209600}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_4"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 1814400}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_5"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 2419200}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_6"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 2592000}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_7"
											bundle="${storeText}" />
									</c:when>
									<c:when test="${interval == 7776000}">
										<fmt:message key="SCHEDULE_ORDER_INTERVAL_8"
											bundle="${storeText}" />
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div id="WC_ScheduleOrder_div_12" class="col3 acol4">
					<div id="WC_ScheduleOrder_div_13" class="title">
						<label for="ScheduleOrderStartDate"> <span
							class="required-field">*</span> <fmt:message
								bundle="${storeText}" key="SCHEDULE_ORDER_START_DATE_TITLE" />
						</label>
					</div>
					<div id="ScheduleOrderStartDate_inputField"
						class="dijitCalendarWidth">
						<c:choose>
							<c:when
								test="${param.isShippingBillingPage || param.startDate != null || param.isMyAccountPage}">
								<c:set var="dateRegex"
									value="^\\\\d\\\\d/\\\\d\\\\d/\\\\d\\\\d\\\\d\\\\d$" />
								<c:set var="widgetNames"
									value='["datepicker", "wc.ValidationTextbox"]' />
								<c:set var="datepickerOptions"
									value='{"altField": "#requestedShippingDate"}' />
								<c:set var="textboxOptions"
									value='{"regExp": "${dateRegex}", "canBeEmpty": false, "submitButton": "#shippingBillingPageNext"}' />
								<input id="ScheduleOrderStartDate" name="ScheduleOrderStartDate"
									size="6" data-widget-type="${fn:escapeXml(widgetNames)}"
									data-widget-options="[${fn:escapeXml(datepickerOptions)}, ${fn:escapeXml(textboxOptions)}]"
									value="<c:if test="${strStartDate != null}"><c:out value="${formattedstrStartDate}"/></c:if>"
									onblur="JavaScript:CheckoutHelperJS.validateDate(this, 'ScheduleOrderStartDate');"
									class="wcDatePickerButtonInner" />
								<script type="text/javascript">
								$("#ScheduleOrderStartDate").datepicker({
									onSelect: function() { 
										CheckoutHelperJS.validateDate(this, "ScheduleOrderStartDate");
										if ("fireEvent" in document.getElementById(this.id) && Utils.get_IE_version() < 9) {
											document.getElementById(this.id).fireEvent("onchange");
										} else {
											var evt=document.createEvent("HTMLEvents");
											evt.initEvent("change", true, false);
											document.getElementById(this.id).dispatchEvent(evt);
										}
									},
									minDate: new Date()
								});
							</script>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${strStartDate.year+1900 != 1970}">
										<c:out value="${formattedstrStartDate}" />
										<br />
									</c:when>
									<c:otherwise>
										<c:out value="${formattedstrStartDate}" />
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="col3 row acol4">
					<div class="col12 row">
						<div id="WC_ScheduleOrder_div_122" class="col6">
							<div class="title">&nbsp;</div>
							<div style="height: 44px">
								<c:set var="orderTime" value="${param.ScheduleOrderTime}"
									scope="page" />
								<select class="drop_down" name="ScheduleOrderTime"
									id="ScheduleOrderTime">
									<option value="12:00">12:00</option>
									<option value="12:30">12:30</option>
									<%
								String temp = "";
								String selected = "";
								String ScheduleOrderTimeValue = (String) pageContext.getAttribute("ScheduleOrderTime");						
								for(int i=1; i<12; i++){
									temp = ""+ i + ":00";
									if(temp.equalsIgnoreCase("7:00") && ScheduleOrderTimeValue==null){
										selected = "selected";
									}
									if(ScheduleOrderTimeValue!=null && ScheduleOrderTimeValue.equalsIgnoreCase(temp)){
										selected = "selected";
									} 
							%>
									<option value="<%=temp%>" <%=selected%>><%=temp%></option>
									<%
									temp = ""+ i + ":30";
									if(ScheduleOrderTimeValue!=null && ScheduleOrderTimeValue.equalsIgnoreCase(temp)){
										selected = "selected";
									}
									else{
										selected = "";
									}
							%>
									<option value="<%=temp%>" <%=selected%>><%=temp%></option>
									<%selected = "";} %>
								</select>
							</div>

						</div>
						<div class="col1">&nbsp;</div>
						<div id="WC_ScheduleOrder_div_123" class="col5">
							<div class="title">&nbsp;</div>
							<c:set var="orderAP" value="${param.ScheduleOrderAP}"
								scope="page" />
							<select class="drop_down" name="ScheduleOrderAP"
								id="ScheduleOrderAP">
								<%
								String ScheduleOrderAPValue = (String)pageContext.getAttribute("ScheduleOrderAP");
								if(ScheduleOrderAPValue!=null && ScheduleOrderAPValue.equalsIgnoreCase("AM"))
								{
							 %>
								<option value="AM" selected>AM</option>
								<%
								}
								else if(ScheduleOrderAPValue!=null && ScheduleOrderAPValue.equalsIgnoreCase("PM"))
								{
							 %>
								<option value="PM" selected>PM</option>
								<%
								}
								else{
							 %>
								<option value="AM">AM</option>
								<option value="PM">PM</option>
								<%} %>
							</select>
						</div>
					</div>
					<div class="row col12">
						<div class="ordShipTimeTxt">This is the time that the order
							will be submitted to the store</div>
					</div>
				</div>
				<div id="WC_ScheduleOrder_div_1254" class="col3 acol12">
					<div id="WC_ScheduleOrder_div_13" class="title">
						<label for="ScheduleOrderStartDate"> End Date </label>
					</div>
					<div id="ScheduleOrderStartDate_inputField"
						class="dijitCalendarWidth">
						<c:choose>
							<c:when
								test="${param.isShippingBillingPage || param.startDate != null || param.isMyAccountPage}">
								<input id="ScheduleOrderEndDate" name="ScheduleOrderEndDate"
									size="6" data-widget-type="${fn:escapeXml(widgetNames)}"
									data-widget-options="[${fn:escapeXml(datepickerOptions)}, ${fn:escapeXml(textboxOptions)}]"
									value="<c:if test="${strStartDate != null}"><c:out value="${formattedstrStartDate}"/></c:if>"
									onblur="JavaScript:CheckoutHelperJS.validateDate(this, 'ScheduleOrderEndDate');"
									class="wcDatePickerButtonInner" />
								<script type="text/javascript">
								$("#ScheduleOrderEndDate").datepicker({
									onSelect: function() { 
										CheckoutHelperJS.validateDate(this, "ScheduleOrderEndDate");
										if ("fireEvent" in document.getElementById(this.id) && Utils.get_IE_version() < 9) {
											document.getElementById(this.id).fireEvent("onchange");
										} else {
											var evt=document.createEvent("HTMLEvents");
											evt.initEvent("change", true, false);
											document.getElementById(this.id).dispatchEvent(evt);
										}
									},
									minDate: new Date()
								});
							</script>
							</c:when>
							<c:otherwise>
								<c:set var="strEndDateTemp" value="${strEndDate}" scope="page" />
								<%
									String strEndDateTemp = (String) pageContext.getAttribute("strEndDateTemp");
												String[] eD = strEndDateTemp.split("-");
												String endDate = eD[2] + "/" + eD[1] + "/" + eD[0];
								%>
								<%=strEndDateTemp%>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div id="ScheduleOrder_clearFloatDiv" class="clear_float"></div>
			</div>
			<!-- Col6 End here -->
			<c:if test="${userType ne 'G'}">
				<div class="col6 acol12 row addjustWidth addjustWidth2">
					<input type="hidden" name="fromSaveSchOrderButton"
						id="fromSaveSchOrderButton" value="false" />

					<c:if test="${!param.isMyAccountPage}">
						<div class="right btnPaddingSet" id="WC_ScheduleOrder_div_32_2">
							<a id="WC_ScheduleOrder_div_32_2_2" class="button_primary"
								href="javascript: setCurrentId('WC_ScheduleOrder_div_32_2_2');document.getElementById('fromSaveSchOrderButton').value='true'; CheckoutPayments.processCheckout('PaymentForm','','true');  ">
								Save Schedule Order </a>
						</div>
					</c:if>
					<c:if test="${param.isMyAccountPage}">
						<wcf:url var="ScheduledOrderStatusTableDetailsURL"
							value="/OrderStatusTableDetailsHelper" type="Ajax">
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="langId" value="${WCParam.langId}" />
							<wcf:param name="selectedTab" value="Scheduled" />
						</wcf:url>

						<wcf:url var="trackOrderStatusURL" value="OrderScheduleUpdate">
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="langId" value="${langId}" />
						</wcf:url>

						<div class="right" id="WC_ScheduleOrder_div_32_2">
							<span class="primary_button button_fit"> <span
								class="button_container"> <span class="button_bg">
										<span class="button_top"> <span class="button_bottom">
												<a id="WC_ScheduleOrder_div_32_2_2" class="button_primary"
												href="javascript:MyAccountDisplay.updateScheduleOrder('<c:out value="${trackOrderStatusURL}"/>', <c:out value="${order.orderId}"/>);">
													Update Schedule Order </a>
										</span>
									</span>
								</span>
							</span>
							</span>
						</div>
					</c:if>
				</div>
			</c:if>
		</div>
	</div>
</c:if>

<%
	String url = request.getRequestURL().toString();
	if (url.contains("OrderShippingBillingConfirmationPage.jsp")) {
%>
	<c:remove var="startDate" />
	<c:remove var="endDate" />
	<c:remove var="frequency" />
	<c:remove var="ScheduleOrderTime" />
	<c:remove var="ScheduleOrderAP" />
<%
	}
%>
<script>
function ShowHideItem(icon, bodyName){
	//alert(icon+bodyName);
	$("."+bodyName).toggle(300);
	if($("."+icon).html()=="+"){
		$("."+icon).html("-");
	}
	else{
		$("."+icon).html("+");
	}
	
}
$("#ScheduleOrderStartDate, #ScheduleOrderEndDate").keyup(function(){
	setCalendarGUI();
});
$("#ScheduleOrderStartDate, #ScheduleOrderEndDate").click(function(){
	setCalendarGUI();
});
function setCalendarGUI(){
	if($("#ui-datepicker-div").show()){
		$("#ui-datepicker-div").css("margin-top", "-78px");
	}
}
</script>