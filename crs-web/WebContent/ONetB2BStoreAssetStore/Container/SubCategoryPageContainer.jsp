<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN SubCategoryPageContainer.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf"%>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div class="rowContainer subCatePage"
	id="container_${pageDesign.layoutId}">
	<div class="row margin-true">
		<div class="col12" data-slot-id="1">
			<wcpgl:widgetImport slotId="1" />
		</div>
	</div>
	<div class="row">
		<div class="col12 acol12" data-slot-id="2"><wcpgl:widgetImport slotId="2"/>
			<c:choose>
				<c:when test="${requestScope.longname eq 'INKS & TONERS'}">
					<%@ include file="../InkAndToner/ProductQuickFind.jsp"%>
				</c:when>
			</c:choose>
		</div>
		<%-- <div class="col6 acol12" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div> --%>
	</div>
	<div class="row margin-true">
		<div class="col12 acol12 ccol12 right headerTxt" data-slot-id="4">
			<wcpgl:widgetImport slotId="4" />
		</div>
		<%-- <div class="col4 acol12 ccol3" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
		<div class="col8 acol12 ccol9 right" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>--%>

		<c:catch var="searchServerException">
			<wcf:rest var="category"
				url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${WCParam.categoryId}">
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="currency" value="${env_currencyCode}" />
				<wcf:param name="responseFormat" value="json" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			</wcf:rest>
		</c:catch>

		<div class="cat-description">
			<c:out value="${category.catalogGroupView[0].longDescription }"
				escapeXml="false" />
		</div>
		<br /> <br />
		<div class="row cateItems">
			<c:if test="${requestScope.pageGroup == 'Category'}">
				<%@ include file="SubCategoriesListDisplay.jspf"%>
			</c:if>
		</div>

		<div class="col4 acol12 ccol3 center-align" id="cat-nav"
			data-slot-id="5">
			<wcpgl:widgetImport slotId="5" />
		</div>
		<div class="col8 acol12 ccol9 right center-align" id="cat-pro"
  			 data-slot-id="6">
			<wcpgl:widgetImport slotId="6" />
		</div>
	</div>

	<c:choose>
		<c:when
			test="${category.catalogGroupView[0].identifier eq 'INKS AND TONERS'}">
			<%--  <div class="row margin-true">
               <div class="col8 acol12 ccol9 right center-align" id="cat-pro" data-slot-id="6">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="LatestArticleSpotTxt2" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
         </div> --%>
			<%-- <div class="row margin-true">
            <div class="col4 center-align" data-slot-id="7">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog1_INKS_&_TONERS" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%></div>
            <div class="col4 center-align" data-slot-id="8">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog2_INKS_&_TONERS" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>		
            </div>
            <div class="col4 center-align" data-slot-id="9">
                    <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                  <c:param name="storeId" value="${WCParam.storeId}" />
                  <c:param name="emsName" value="Blog3_INKS_&_TONERS" />
                  <c:param name="numberContentPerRow" value="1" />
                  <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>
                </div>
         </div> --%>
		</c:when>

		<c:when
			test="${category.catalogGroupView[0].identifier eq 'OFFICE SUPPLIES'}">
			<%-- <div class="row margin-true">
               <div class="col8 acol12 ccol9 right center-align" id="cat-pro" data-slot-id="6">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="LatestArticleSpotTxt2" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
         </div> --%>
			<%-- <div class="row margin-true">
            <div class="col4 center-align" data-slot-id="7">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog1_OFFICE_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%></div>
            <div class="col4 center-align" data-slot-id="8">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog2_OFFICE_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>		
            </div>
            <div class="col4 center-align" data-slot-id="9">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog3_OFFICE_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>
            </div>
         </div> --%>
		</c:when>

		<c:when
			test="${category.catalogGroupView[0].identifier eq 'FACILITIES SUPPLIES'}">
			<%-- <div class="row margin-true">
               <div class="col8 acol12 ccol9 right center-align" id="cat-pro" data-slot-id="6">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="LatestArticleSpotTxt2" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
         </div> --%>
			<%-- <div class="row margin-true">
            <div class="col4 center-align" data-slot-id="7">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog1_FACILITIES_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%></div>
            <div class="col4 center-align" data-slot-id="8">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog2_FACILITIES_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>		
            </div>
            <div class="col4 center-align" data-slot-id="9">
               <%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Blog3_FACILITIES_SUPPLIES" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />
                  </c:import>
               <%out.flush();%>
                </div>
         </div> --%>
		</c:when>

		<c:otherwise>
			<c:if test="${not empty WCParam.categoryId}">
				<%-- <wcbase:useBean id="categoryDesc" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />            
            
            <!-- THIS CODE WILL GET EXECUTED IF THE CATEGORY IS NOT A PARENT CATEGORY -->
            <c:if test="${categoryDesc.childCategory eq true}">
               <div class="row margin-true">
                  <div class="col4 center-align" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
                  <div class="col4 center-align" data-slot-id="8"><wcpgl:widgetImport slotId="8"/></div>
                  <div class="col4 center-align" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
               </div>
            </c:if>
                        
            <!-- THIS CODE WILL GET EXECUTED IF THE CATEGORY IS A PARENT CATEGORY BUT NOT FROM THE ONE SPECIFIED IN ABOVE WHEN-->
            <c:if test="${categoryDesc.childCategory eq false}"> --%>
				<%-- <div class="row margin-true">
               <div class="col8 acol12 ccol9 right center-align" id="cat-pro" data-slot-id="6">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="LatestArticleSpotTxt2" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
            </div> --%>
				<%-- <div class="row margin-true">
               <div class="col4 center-align" data-slot-id="7">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="Blog1_${category.catalogGroupView[0].identifier}" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
               <div class="col4 center-align" data-slot-id="8">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="Blog2_${category.catalogGroupView[0].identifier}" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>		
               </div>
               <div class="col4 center-align" data-slot-id="9">
                  <%out.flush();%>
                     <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                        <c:param name="storeId" value="${WCParam.storeId}" />
                        <c:param name="emsName" value="Blog3_${category.catalogGroupView[0].identifier}" />
                        <c:param name="numberContentPerRow" value="1" />
                        <c:param name="catalogId" value="${WCParam.catalogId}" />
                     </c:import>
                  <%out.flush();%>
               </div>
            </div> --%>
				<%-- </c:if> --%>
			</c:if>
		</c:otherwise>
	</c:choose>

	<%-- <div class="row margin-true">
		<div class="col12">
			<flow:ifEnabled feature="PredictiveIntelligence">
			<div id="igdrec_1"></div>
				<c:set var="igoURL" value="https://7217209.recs.igodigital.com/a/v2/7217209/category/recommend.js?category=${requestScope.categoryNameForPI}"/>
				<script src="${igoURL}" type="text/javascript"></script>
			</flow:ifEnabled>
		</div>
	</div> --%>

	<div class="row margin-true">
		<div class="col12 center-align" data-slot-id="10">
			<wcpgl:widgetImport slotId="10" />
		</div>
	</div>
</div>

<!-- END SubCategoryPageContainer.jsp -->
