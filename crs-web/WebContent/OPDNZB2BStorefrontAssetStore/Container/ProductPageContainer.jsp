<%--
 =================================================================
  Licensed Materials - Property of IBM
  WebSphere Commerce
  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.
  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN ProductPageContainer.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@include file="../Common/EnvironmentSetup.jspf"%>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>
<!--Start Page Content-->
<div id="contentWrapper">
	<div class="product_page_content rowContainer <c:if test='${foundCurrentSlot7 == true}'>bundle_package_page</c:if>" id="container_${pageDesign.layoutId}" role="main">		
		<div class="row margin-true">
			<div class="col12 slot1" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
		</div>
		<div id="printProductPage" class="pdpPage">
		<div itemscope itemtype="http://schema.org/Product">
		<div id="printArea">
		<div class="row margin-true">
			
			<div class="col6 fcol12" data-slot-id="2"><wcpgl:widgetImport slotId="2"/></div>
			<div class="col6 fcol12 button-bar" data-slot-id="11">
				<div class="navBase2">
					<div class="nav2 noSticky">
						<div class="sticky-max">
							<div class="stiky-half">
								<wcpgl:widgetImport slotId="11"/>
								<a id="printBtn" class="button_primary" onclick="javascript:PrintProductDetailPage();" tabindex="0" role="button" href="#">
									<div class="left_border"></div>
									<div class="button_text">Print Product</div>
									<div class="right_border"></div>
								</a>
							</div>
						</div>
					</div>
				</div>
				<script>
					$(window).scroll(function(){
						var yourTop = $('.navBase2').position().top;
						if( $(this).scrollTop() > yourTop ){
							$(".nav2").addClass("sticky");
							$(".nav2").removeClass("noSticky");
						}
						else if( $(this).scrollTop() < yourTop ){
							$(".nav2").removeClass("sticky");
							$(".nav2").addClass("noSticky");
						}
					});
				</script>
			</div>
			<div class="col6 acol12 slot3" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div>
			<%--
			<div class="col6 fcol12" data-slot-id="3"><wcpgl:widgetImport slotId="3"/>				
				<c:set var="catId" value="${WCParam.productId}"/>
				
				<%	
				java.util.Vector recVector = null;
				String catId = pageContext.getAttribute("catId").toString();
				String catQuery = "select auxdescription1 from catentdesc where catentry_id in (select catentry_id from catentry where catentry_id="+catId+")";
				String auxDesc = "";
				try{
					com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean sjha = new com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean();
					recVector = sjha.executeQuery(catQuery);
					if(recVector.size() > 0){
						for(java.util.Enumeration proEnum = ((java.util.Vector)recVector).elements(); proEnum.hasMoreElements();){
							java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
							auxDesc = String.valueOf(codRec.elementAt(0));
						}
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
				%>
				<%
				if (auxDesc != null && !"".equalsIgnoreCase(auxDesc) && !auxDesc.equalsIgnoreCase("null")) {
				%>
				<div class="prod-promotion"><%=auxDesc%></div>
				<% } %>
			</div> --%>
		</div>
		
		<wcf:rest var="getAuxdesc" url="store/{storeId}/moq/getMoq/{catentryId}" scope="request">
			<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
			<wcf:var name="catentryId" value="${WCParam.productId}" encode="true"/>
		</wcf:rest>
		<div class="row margin-true">
			<div class="col12 center-align long-description" data-slot-id="4">
			
				<div class="container">
					<ul class="tabs multipleTabs">
						
						<li class="tab-link current" data-tab="PDP_tab-0" id="PDP_tab-00">Details</li>
						<li class="tab-link" data-tab="PDP_tab-1" id="PDP_tab-11">Specifications</li>
						<li class="tab-link" data-tab="PDP_tab-2" id="PDP_tab-22">Attributes</li>
						<%--<li class="tab-link" data-tab="PDP_tab-3">Also Available</li> --%>
						<%--<li class="tab-link" data-tab="PDP_tab-4">More Information</li> --%>
						<li class="tab-link" data-tab="PDP_tab-4" id="PDP_tab-44">Document</li>
						<li class="tab-link" data-tab="PDP_tab-5" id="PDP_tab-55">Media</li>
					</ul>
					
					
							<div id="PDP_tab-0" class="tab-content">
								
								<c:if test="${getAuxdesc.auxdesc2 ne 'noDesc' && getAuxdesc.auxdesc2 ne 'null' && getAuxdesc.auxdesc2 ne 'NULL'}">
									<c:set var="auxdesc2" value="${getAuxdesc.auxdesc2}"/>
									<c:choose>
									
									<c:when test="${fn:contains(auxdesc2, '| ')}">
										<c:forEach var="num" items="${fn:split(auxdesc2, '|')}" varStatus="lngDescCounter">
											<c:if test="${lngDescCounter.count == '1'}">
												<p style="font-weight: bold;">
													 <c:out value="${num}" /><br/>
												</p> 
											</c:if>
											<ul>
											<c:if test="${lngDescCounter.count > '1'}">
												<li>
													<c:out value="${num}" />
												</li>
											</c:if>
											</ul>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:out value="${auxdesc2}" />
									</c:otherwise>
									</c:choose>
								</c:if>	
							
						</div>
					
					
					<div id="PDP_tab-1" class="tab-content">
						<wcpgl:widgetImport slotId="4"/>
					</div>
					<div id="PDP_tab-2" class="tab-content">
						<%--<wcpgl:widgetImport slotId="9"/>--%>
						<c:import url="/Widgets_801/com.ibm.commerce.store.widgets.PDP_DescriptiveAttributes/DescriptiveAttributes.jsp"/>
					</div>
					<%--
					<div id="PDP_tab-3" class="tab-content current">
						<div class="row margin-true">
							<div class="col12" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
						</div>
						<flow:ifEnabled feature="PredictiveIntelligence">
							<div id="igdrec_1"></div>						
						</flow:ifEnabled>
					</div>
					 --%>
					
					<div id="PDP_tab-5" class="tab-content">
						<wcpgl:widgetImport slotId="8"/>
					</div>
					 
					<div id="PDP_tab-4" class="tab-content">
						<%out.flush();%>
							<c:import url="${env_siteWidgetsDir}com.ibm.commerce.store.widgets.PDP_AssociatedAssets/AssociatedAssets.jsp">
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="langId" value="${WCParam.langId}" />
								<c:param name="productId" value="${WCParam.productId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="excludeUsageStr" value="${excludeUsageStr}" />
								<c:param name="displayAttachmentCount" value="${displayAttachmentCount}" />
							</c:import>
						<%out.flush();%>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			
			 
				<div class="row margin-true col12 pdpCarousel">
					<div class="col12" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
				</div>
				<flow:ifEnabled feature="PredictiveIntelligence">
					<div id="igdrec_1"></div>						
				</flow:ifEnabled>
		 
			<c:if test="${requestScope.secondCatName eq 'Chairs' ||
						requestScope.secondCatName eq 'Cupboards, Bookcases and Credenzas' ||
						requestScope.secondCatName eq 'Desking' ||
						requestScope.secondCatName eq 'Ergonomic Furniture' ||
						requestScope.secondCatName eq 'Filing and Storage' ||
						requestScope.secondCatName eq 'Workplace Screens' ||
						requestScope.secondCatName eq 'Tables' ||
						requestScope.secondCatName eq 'Furniture Accessories' ||
						requestScope.secondCatName eq 'Chairmats'}">
				<%out.flush();%>
                  <c:import url= "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
                     <c:param name="storeId" value="${WCParam.storeId}" />
                     <c:param name="emsName" value="Freight_Charge_espot" />
                     <c:param name="numberContentPerRow" value="1" />
                     <c:param name="catalogId" value="${WCParam.catalogId}" />					 	
                  </c:import>
               <%out.flush();%>	
			</c:if>
		</div></div>
		</div>
		</div>				
		<div class="row margin-true"  >
			<div class="col12 acol12" data-slot-id="6"><%--<p style="font-size: 30px;margin-left: 60px;margin-bottom: -25px;margin-top:20px;font-family:Arial Black, Gadget, sans-serif;">Customers also bought</p> --%><wcpgl:widgetImport slotId="6"/></div>
			<div class="col5 center-align" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
		</div>
		<div class="row margin-true">
			<div class="col4 center-align" data-slot-id="8"><wcpgl:widgetImport slotId="8"/></div>
			<div class="col4 center-align" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
			<div class="col4 center-align" data-slot-id="10"><wcpgl:widgetImport slotId="10"/></div>
		</div>
		
		<div class="row margin-true">
		
	
			<div class="col12 pdp-banner">
		
			</div>
		</div>
		<div class="clear_float"></div>				
	</div>
</div>
<script>
$(document).ready(function(){
	$('#PDP_tab-3').removeClass('current');
	$('#PDP_tab-0').addClass('current');
	//alert($('#pdp-tab-4di').html().trim().length);
	if ($('#PDP_tab-5').html().trim().length != 0){
		//alert("data");
	}
	else{
		//alert("no data");
		$('#PDP_tab-5').hide();
		$('#PDP_tab-55').hide();
		
	}
	/*
	if ($('#PDP_tab-0').html().trim().length != 0){
		//alert("data");
		
	}
	else{
		//alert("no data");
		$('#PDP_tab-0').hide();
		$('#PDP_tab-00').hide();
		$('#PDP_tab-0').removeClass('current');
		$('#PDP_tab-1').addClass('current');
		
	}
	if ($('#PDP_tab-1').html().trim().length != 0){
		//alert("data");
		
	}
	else{
		//alert("no data");
		$('#PDP_tab-1').hide();
		$('#PDP_tab-11').hide();
		
	}
	if ($('#PDP_tab-2').html().trim().length != 0){
		//alert("data");
	}
	else{
		//alert("no data");
		$('#PDP_tab-2').hide();
		$('#PDP_tab-22').hide();
		
	}*/
	if ($('#pdp-tab-4di').html().trim().length > 64){
		//alert("data");
	}
	else{
		//alert("no data");
		$('#PDP_tab-4').hide();
		$('#PDP_tab-44').hide();
		
	}
	
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');
		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');
		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})
})
</script>
<script>
function PrintProductDetailPage(){
	//var dispSetting="width=800,height=800,left=100,top=25,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no,resizable=yes";
	//window.open("/shop/${sdb.jspStoreDir}/Container/PrintPDP.jsp?catent_id=${WCParam.productId}","",dispSetting);
	
	//window.href.location("PrintPDPView?catent_id=${WCParam.productId}");
	window.open("PrintPDPView?catent_id="+${WCParam.productId}); 
	//window.location.href = "PrintPDPView?catent_id="+${WCParam.productId};
}
</script>
<!-- END ProductPageContainer.jsp -->