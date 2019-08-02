<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
	

		<c:set var="storeentId" value="${WCParam.storeId}"/>
		
 <wcf:rest var="getLoyaltyStatus" url="store/{storeId}/loyalty/getLoyaltyStatus/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${param.userId }" encode="true"/>
</wcf:rest>


	<c:if test="${getLoyaltyStatus.source ne 'nothing' }">		
		<c:set var="content" value="${getLoyaltyStatus.content}" scope="session" />
        <c:set var="state" value="${getLoyaltyStatus.state}" scope="session" />
	</c:if>	
		
		 <c:choose>
		
			<c:when test="${getLoyaltyStatus.source eq 'REST'}">
			
			 
			<%out.flush();%>
				
				<c:import url= "${env_siteWidgetsDir}com.royalcyber.loyalty.point/AwardListTableDisplayRF.jsp">
					
					<c:param name="storeentId"   value="${WCParam.storeId}"  />
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="logonid" value="${getLoyaltyStatus.logonid}"/> 
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="userId" value="${param.userId}" />
					</c:import>				
				<%out.flush();%>
				
				
			</c:when>
			
			
			<c:when test="${getLoyaltyStatus.source eq 'SOAP' }"> 
			
			<%out.flush();%>
			
					<c:import url= "${env_siteWidgetsDir}com.royalcyber.loyalty.point/AwardListTableDisplay.jsp">
					
					<c:param name="storeentId"   value="${WCParam.storeId}"  />
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="logonid" value="${getLoyaltyStatus.logonid}"/>
					<c:param name="langId" value="${WCParam.langId}" />
					<c:param name="userId" value="${param.userId}" />
					</c:import>
				<%out.flush();%>
			
				
			</c:when>
			<c:when test="${getLoyaltyStatus.source eq 'LOCAL' }"> 
			
			
				<c:set var="loyaltyEnabled" value="true" scope="session" />
				<c:set var="loyPoints" value="${getLoyaltyStatus.userPoints}"/> 
				<c:set var="totalPoints" value="${loyPoints}" scope="session" />
			
				
			</c:when>
			<c:otherwise>
				
				
				
			</c:otherwise>
		</c:choose>
			
		



 