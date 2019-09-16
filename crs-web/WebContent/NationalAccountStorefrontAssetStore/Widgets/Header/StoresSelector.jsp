<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>   
<%@ include file= "../../Common/EnvironmentSetup.jspf" %> 
<%@include file="../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>

<c:set var="person" value="${requestScope.person}"/>
<c:if test="${empty person || person==null}">
	<wcf:rest var="person" url="store/{storeId}/person/@self" scope="request">
		<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	</wcf:rest>
</c:if>	

<c:set var="logonId" value="${person.logonId}" />

	<c:set var="street" value="${person.addressLine[0]}"/>
	<c:set var="city" value="${person.city}"/>
	<c:set var="state" value="${person.state}"/>
	<c:set var="country1" value="${person.country}"/>
	<c:set var="zipCode" value="${person.zipCode}"/>
	<c:set var="uAddress" value="${zipCode}, ${street}, ${city}, ${state}, ${country1}"/>
				
<wcf:rest var="storeSelector" url="store/98552/adminPannel/storeSelector/${logonId}/${uAddress}" scope="request">
		<wcf:var name="storeId" value = "${WCParam.storeId}" encode="true"/>	
		<wcf:var name="logonId" value = "${LogonID}" encode="true"/>
		<wcf:var name="uAddress" value = "${uAddress}" encode="true"/>
</wcf:rest>		


<c:if test = "${fn:contains(storeSelector, 'aStoreName')}">

<c:set var="defaultStoreId" value="${storeSelector.defaultStoreId}" scope="page"/>
<c:set var="aStoreName" value="${storeSelector.aStoreName}" scope="page"/>

	<div class="topRow-select">	

		<select id="stIdSelector" onChange="changeDefStoreId(this.value);">
			<option value="${defaultStoreId}" selected="selected">${aStoreName}</option>
		</select>	
		
		<script>					
			function changeDefStoreId(val){
				localStorage.setItem('selectedStoreIdForON',val);
			}
			if(localStorage.getItem('selectedStoreIdForON') != null && localStorage.getItem('selectedStoreIdForON') != '' &&
				localStorage.getItem('selectedStoreIdForON') != 'null'){
				$(function(){
					//Set the value of your TypeId <select> list to the element with value '33'
					$('#stIdSelector').val(localStorage.getItem('selectedStoreIdForON'));
				});
			}
			else{
				$(function(){
					//Set the value of your TypeId <select> list to the element with value '33'
					localStorage.setItem('selectedStoreIdForON',$('#stIdSelector').val());
				});
			}	
		</script>
		<c:set var="defaultStoreId" value="${defaultStoreId}" scope="request"/>		
	
	</div>

</c:if>


<c:if test = "${fn:contains(storeSelector, 'loopCounter')}">

		<c:set var="loopCounter" value="${storeSelector.loopCounter}" scope="page"/>
		<c:set var="defaultStoreId2" value="${storeSelector.defaultStoreId}" scope="page"/>

	<div class="topRow-select">	
		
		<select id="stIdSelector" onChange="changeDefStoreId(this.value);">
		
		<c:set var="sIdsCounter" value="0"/>

			<c:forEach var="storeList" items="${storeSelector.sIds}">
				<c:if test="${storeList.storeId eq defaultStoreId2}">
				
					<option value="${storeList.storeId }" selected="selected">${storeList.storeName }</option>
				</c:if>
				
				<c:if test="${storeList.storeId ne defaultStoreId2}">
				
					<option value="${storeList.storeId }" >${storeList.storeName }</option>	
				</c:if>
				
			</c:forEach>

		</select>
	
		<script>					
			//var element = document.getElementById('stIdSelector');
			//element.value = localStorage.getItem('selectedStoreIdForON');
			//alert(localStorage.getItem('selectedStoreIdForON'));
			function changeDefStoreId(val){
				localStorage.setItem('selectedStoreIdForON',val);
				//dojo.cookie("selectedStoreIdForON", val, {path:'/'});
				$.cookie("selectedStoreIdForON", val, {path:'/'});
			}
			if(localStorage.getItem('selectedStoreIdForON') != null && localStorage.getItem('selectedStoreIdForON') != '' && localStorage.getItem('selectedStoreIdForON') != 'null'){
				$(function(){
					//Set the value of your TypeId <select> list to the element with value '33'
					$('#stIdSelector').val(localStorage.getItem('selectedStoreIdForON'));
					//dojo.cookie("selectedStoreIdForON", val, {path:'/'});
					$.cookie("selectedStoreIdForON", val, {path:'/'});
				});
			}
		</script>		
		
			<c:choose>
				<c:when test="${!empty cookie.selectedStoreIdForON.value && cookie.selectedStoreIdForON.value != null}">
					<c:set var="defaultStoreId" value="${cookie.selectedStoreIdForON.value}" scope="request"/>
				</c:when>
				<c:otherwise>
					<c:set var="defaultStoreId" value="${defaultStoreId2}" scope="request"/>
				</c:otherwise>
			</c:choose>	
			
					
		
	</div>	

</c:if>


