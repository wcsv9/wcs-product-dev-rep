<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<!-- START AwardListTableDisplayRF.jsp -->


<wcf:rest var="getLoyaltyRestStatusEnabled" url="store/{storeId}/loyalty/getLoyaltyRestStatusEnabled/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${param.userId }" encode="true"/>
</wcf:rest>	


<c:set var="loyaltyEnabled" value="${getLoyaltyRestStatusEnabled.loyaltyEnabled}" scope="session" />

<c:set var="totalPoints" value="${getLoyaltyRestStatusEnabled.totalPoints}" scope="session" />

<c:set var="webid" value="${getLoyaltyRestStatusEnabled.webid}" scope="session"/> 


<c:choose>
	<c:when test="${not empty getLoyaltyRestStatusEnabled.totalPoints && getLoyaltyRestStatusEnabled.totalPoints ne '0'}">
		<c:set var="totalPoints" value="${totalPoints}" scope="session" />
	</c:when>
	<c:otherwise>
		<c:set var="totalPoints" value="0" scope="session" />
	</c:otherwise>
</c:choose>

<!-- END AwardListTableDisplayRF.jsp -->