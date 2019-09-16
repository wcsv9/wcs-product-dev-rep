<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="pageCategory" value="MyAccount" scope="request"/>

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

<!-- BEGIN OrderStatusDisplay.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
    <%@ include file="../../../Common/CommonCSSToInclude.jspf"%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><fmt:message bundle="${storeText}" key="MO_MYORDERS"/></title>

    <%@ include file="../../../Common/CommonJSToInclude.jspf"%>

    <%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
<script type="text/javascript" language="javascript">  
function ResponsiveMenu(){
	 var x = document.getElementById("accDetailMenu");
	  if (x.className === "normalMenu") {
	    x.className = " responsive";
	  } else {
	    x.className = "normalMenu";
	  }
}	
</script>
</head>

<body>
<!-- Page Start -->
<div id="page">
    <div id="grayOut"></div>
    <!-- Header Widget -->
    <div id="headerWidget">
        <%out.flush();%>
        <c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
        <%out.flush();%>
    </div>

    <c:choose>
        <c:when test="${WCParam.isQuote eq true}">
            <fmt:message bundle="${storeText}" key="MO_MYQUOTES" var="contentPageName" scope="request"/>
        </c:when>
        <c:when test="${WCParam.isRecurringOrder eq true}">
            <fmt:message bundle="${storeText}" key="MA_SCHEDULEDORDERS" var="contentPageName" scope="request"/>
        </c:when>
        <c:when test="${WCParam.isSubscription eq true}">
            <fmt:message bundle="${storeText}" key="MA_SUBSCRIPTIONS" var="contentPageName" scope="request"/>
        </c:when>
        <c:otherwise>
            <fmt:message bundle="${storeText}" key="MA_ORDER_HISTORY" var="contentPageName" scope="request"/>
        </c:otherwise>
    </c:choose>
    
    <!-- Main Content Start -->
    <div id="contentWrapper">
        <div id="content" role="main">
            <div class="row margin-true">
                <div class="col12">
                    <%out.flush();%>
                        <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
                            <wcpgl:param name="pageGroup" value="Content"/>
                        </wcpgl:widgetImport>
                    <%out.flush();%>
                </div>
            </div>
            <div class="rowContainer" id="container_MyAccountDisplayB2B">
                <div class="row margin-true">
                    <%-- <div class="col4 acol12 ccol3">
                        <%out.flush();%>
                            <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.MyAccountNavigation/MyAccountNavigation.jsp"/>
                        <%out.flush();%>
                    </div> --%>
                    <div class="col12 acol12 ccol12 right">
                        <%-- <div id="OrderListPageHeading dfff">
                            <h1>${contentPageName}</h1>
                        </div> --%>
                        <c:if test="${contentPageName == 'Order History' || contentPageName == 'Recurring Orders'}">
	                        <div class="row headInsideMenu">
									<div class="col1">&nbsp;</div>
									<div class="col10 userIconLine">
										<c:if test="${contentPageName == 'Recurring Orders'}">
											<div class="recurringOrderUserIcon"> </div>
										</c:if>
										<c:if test="${contentPageName == 'Order History'}">
											<div class="orderHistoryPageUserIcon"> </div>
										</c:if>
										<hr/>
									</div>
									<div class="col1">&nbsp;</div>
								<div class="col12"><p>${contentPageName}</p></div>
								<div class="col12 links">
									<div class="normalMenu" id="accDetailMenu">
										 <%out.flush();%>
									        <c:import url="${env_jspStoreDir}Common/MyAccountPageURLs.jsp"/>
									    <%out.flush();%>
									</div>
								</div>
							</div>
						</c:if>
                        <c:choose>
                            <c:when test="${WCParam.isRecurringOrder eq true}">
                                <%out.flush();%>
                                    <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
                                        <wcpgl:param name="storeId" value="${WCParam.storeId}"/>
                                        <wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
                                        <wcpgl:param name="langId" value="${langId}"/>
                                        <wcpgl:param name="showPONumber" value="${showPONumber}"/>
                                        <wcpgl:param name="isRecurringOrder" value="true"/>
                                    </wcpgl:widgetImport>
                                <%out.flush();%>
                            </c:when>
                            <c:when test="${WCParam.isSubscription eq true}">
                                <%out.flush();%>
                                    <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
                                        <wcpgl:param name="storeId" value="${WCParam.storeId}"/>
                                        <wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
                                        <wcpgl:param name="langId" value="${langId}"/>
                                        <wcpgl:param name="showPONumber" value="${showPONumber}"/>
                                        <wcpgl:param name="isSubscription" value="true"/>
                                    </wcpgl:widgetImport>
                                <%out.flush();%>
                            </c:when>
                            <%@ include file="OrderStatusDisplay_body_ext.jspf"%>
                            <c:otherwise>
                                <c:if test="${WCParam.isQuote eq true}">
                                    <c:set var="isQuote" value="true"/>
                                </c:if>
                                <c:choose>
                                    <c:when test="${showWaitingForApprovalOrders == false}">
                                        <%out.flush();%>
                                            <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
                                                <wcpgl:param name="storeId" value="${WCParam.storeId}"/>
                                                <wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
                                                <wcpgl:param name="langId" value="${langId}"/>
                                                <wcpgl:param name="showPONumber" value="${showPONumber}"/>
                                                <wcpgl:param name="selectedTab" value="PreviouslyProcessed"/>
                                                <wcpgl:param name="isQuote" value="${isQuote}"/>
                                            </wcpgl:widgetImport>
                                        <%out.flush();%>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Tabs in Order History Page for B2B --%>
                                        <c:set var="tabSlotNames" value="${fn:split('PreviouslyProcessed;WaitingForApproval;Invoices', ';')}"/>
                                        <c:set var="tabSlotHeadings" value="${fn:split('MO_PREVIOUSLY_PROCESSED;MO_WAITING_FOR_APPROVAL;MO_INVOICES', ';')}"/>
                                        <c:set var="selectedTabIndex" value="0"/>
                                        <div class="tabButtonContainer" role="tablist">
                                            <div class="tab_header tab_header_double">
                                                <c:forEach var="tabSlotHeading" items="${tabSlotHeadings}" varStatus="status">
                                                    <c:choose>
                                                        <c:when test="${selectedTabIndex == status.index}">
                                                            <c:set var="tabClass" value="tab_container active_tab" />
                                                            <c:set var="tabIndex" value="0" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="tabClass" value="tab_container inactive_tab" />
                                                            <c:set var="tabIndex" value="-1" />
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <div id="tab${status.count}" tabindex="${tabIndex}" class="${tabClass}" aria-labelledby="OrderList_tab${status.count}" aria-controls="tab${status.count}Widget"
                                                            onfocus="ProductTabJS.focusTab('tab${status.count}');" onblur="ProductTabJS.blurTab('tab${status.count}');" role="tab" aria-setsize="${fn:length(tabSlotHeadings)}" 
                                                            aria-posinset="${status.count}" aria-selected="${status.first == true ? 'true' : 'false'}" onclick="ProductTabJS.selectTab('tab${status.count}');" 
                                                            onkeydown="ProductTabJS.selectTabWithKeyboard('${status.count}','${fn:length(tabSlotHeadings)}', event);">
                                                            <fmt:message bundle="${storeText}" key="${tabSlotHeading}" />
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        
                                        <c:forEach var="tabSlotName" items="${tabSlotNames}" varStatus="status">
                                            <c:set var="tabStyle" value="" />
                                            <c:if test="${selectedTabIndex != status.index}">
                                                <c:set var="tabStyle" value="style='display:none'" />
                                            </c:if>
                                            <div role="tabpanel" class="tab left" id="tab${status.count}Widget" aria-labelledby="tab${status.count}" ${tabStyle}>
                                                <div class="content">
                                                    <%out.flush();%>
                                                        <wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.OrderList/OrderList.jsp">
                                                            <wcpgl:param name="storeId" value="${WCParam.storeId}"/>
                                                            <wcpgl:param name="catalogId" value="${WCParam.catalogId}"/>
                                                            <wcpgl:param name="langId" value="${langId}"/>
                                                            <wcpgl:param name="showPONumber" value="${showPONumber}"/>
                                                            <wcpgl:param name="selectedTab" value="${tabSlotName}"/>
                                                            <wcpgl:param name="isQuote" value="${isQuote}"/>
                                                        </wcpgl:widgetImport>
                                                    <%out.flush();%>
                                                </div>
                                            </div>
                                            <c:remove var="tabStyle" />
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Main Content End -->

    <!-- Footer Start -->
    <div class="footer_wrapper_position">
        <%out.flush();%>
            <c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
        <%out.flush();%>
    </div>
    <!-- Footer End -->
</div>

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>
</html>
<!-- END OrderStatusDisplay.jsp -->
