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
<!-- BEGIN QuickInfoPopup.jsp -->
<%@ include file="/Widgets_801/Common/EnvironmentSetup.jspf" %>

<c:if test="${!pageloaded_quickInfoPopupJSPF}">
	<div id="quickInfoPopup" role="dialog" data-widget-type="wc.WCDialog" style="display:none;" onkeypress="QuickInfoJS.setFocus" aria-label="<wcst:message key="QUICK_VIEW" bundle="${widgetText}"/>">

	<div id="grayOutPopup"></div>
		<div class="widget_quick_info_popup">
			
			<!-- Top Border Styling -->
			<div class="top">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
			<!-- Main Content Area -->
			<div class="middle">
				<div class="content_left_border">
					<div class="content_right_border">
					<span id="quickInfoRefreshArea_ACCE_Label" class="spanacce"><wcst:message key="QUICK_VIEW_CONTENT_ACCE" bundle="${widgetText}"/></span>
					<jsp:include page="/Widgets_801/com.ibm.commerce.store.widgets.PDP_AddToRequisitionLists/AddToRequisitionLists.jsp" flush="true">
						<jsp:param name="buttonStyle" value="none"/>
						<jsp:param name="nestedAddToRequisitionListsWidget" value="true"/>
						<jsp:param name="parentPage" value="widget_quick_info_popup"/>
						<jsp:param name="includeReqListJS" value="true" />
					</jsp:include>
                    
                    <wcf:url var="QuickInfoControllerURL" value="QuickInfoDetailsViewV2" type="Ajax">
                        <wcf:param name="storeId" value="${WCParam.storeId}"  />
                        <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
                        <wcf:param name="langId" value="${WCParam.langId}" />
                        <wcf:param name="ajaxStoreImageDir" value="${jspStoreImgDir}" />
                    </wcf:url>
                                                
					<div id="quickInfoRefreshArea" class="content" wcType="RefreshArea" declareFunction="CommonControllersDeclarationJS.declareQuickInfoDetails()" refreshurl="<c:out value='${QuickInfoControllerURL}'/>" ariaMessage="<wcst:message key="ACCE_Status_Quick_View_Content_updated" bundle="${widgetText}"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="quickInfoRefreshArea_ACCE_Label">

						</div>
					<!-- End content_right_border -->
					</div>
				<!-- End content_left_border -->
				</div>
			</div>
			<div class="clear_float"></div>
			<!-- Bottom Border Styling -->
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
		</div>
	</div>

	<c:set var="pageloaded_quickInfoPopupJSPF" value="true" scope="request"/>
</c:if>

<!-- END QuickInfoPopup.jsp -->
