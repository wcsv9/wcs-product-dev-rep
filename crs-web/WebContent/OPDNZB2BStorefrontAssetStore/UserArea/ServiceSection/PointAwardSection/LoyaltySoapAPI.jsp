
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<c:set var="storeId" value="${storeId}"/>

<wcf:rest var="getLoyaltySoapTransactions" url="store/{storeId}/loyalty/getLoyaltySoapTransactions/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${userId}" encode="true"/>
</wcf:rest>
<br /><br />
<div class="loyaltyRewards">        
<div class="reward-points df">
	Welcome back
	<c:out value="${getLoyaltySoapTransactions.firstName}" />
	&nbsp;
	<c:out value="${lastName}" />
	! I see you`ve got
	<%--
				String temp = LoyaltyStatement.get("PointsBalance").toString();
				char strArray[] = temp.toCharArray();
				for(int i=0; i<strArray.length; i++){
				--%>
				
	<c:choose>
		<c:when test="${getLoyaltySoapTransactions.response eq 'no response' }">
			<span class="reward-points-no"><span class="star">0</span></span>
		</c:when>
		<c:otherwise>
			<c:forEach var="strArray" items="${getLoyaltySoapTransactions.strArray}" varStatus="status">
				<span class="reward-points-no"><span class="star">${strArray}</span></span>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
		
	<%--} --%>
	rewards points
</div>


<table cellpadding="0" class="rewardPointsTbl" cellspacing="0" border="0" width="100%">
	<tr>
		<td colspan="4" bgcolor="#DDDDDDD" style="padding: 4px"><b>Loyalty
				Points Detail</b></td>
	</tr>
	<tr>
		<td colspan="4" height="1" bgcolor="DDDDDD"></td>
	</tr>
	<tr>
		<th align="left" height="25"
			style="border-left: 1px solid #DDDDDD; padding-left: 4px;">Invoice ID</th>
		<th align="left">Date</th>
		<th align="left">Type Of Point</th>
		<th align="right" style="border-right: 1px solid #DDDDDD">Points
			Gained/Used</th>
	</tr>
	<tr>
		<td colspan="4" height="1" bgcolor="DDDDDD"></td>
	</tr>
   
<c:choose>
		<c:when test="${getLoyaltySoapTransactions.response eq 'no response' }">
			<tr>
					<td height="1" colspan="4" bgcolor="#DDDDDD">No Record Found</td>
				</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="transaction" items="${getLoyaltySoapTransactions.loyaltyTransactions}" varStatus="status">
		


				<tr>
					<td height="25"
						style="border-left: 1px solid #DDDDDD; padding-left: 4px;">${transaction.transactionNumber}</td>
					<td>${transaction.date}</td>
					<td>${transaction.purchase}</td>
					<td style="border-right: 1px solid #DDDDDD;text-align: right;">${transaction.pointsGained}</td>
				</tr>
				<tr>
					<td height="1" colspan="4" bgcolor="#DDDDDD"></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>	










 </table></div>
 <br /><br /><br />

