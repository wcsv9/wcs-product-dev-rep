
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

		

<c:set var="storeId" value="${storeId}"/>

<wcf:rest var="awardAccesBean" url="store/{storeId}/loyalty/getLoyaltyLocalTransactions/{userId}" scope="request">
	<wcf:var name="storeId" value="${WCParam.storeId}" encode="true"/>
	<wcf:var name="userId" value="${userId}" encode="true"/>
</wcf:rest>		

<c:set var="loyaltyEnabled" value="${awardAccesBean.loyaltyEnabled}" scope="session" />
<div class="loyaltyRewards">
	
			<!-- Start Loyalty Point Changes May082013-->
			<div class="loyalty-banner"></div>
				<c:set var="loyPoints" value="${awardAccesBean.userPoints}"/>
			
			<c:set var="firstName" value="${awardAccesBean.firstName}"/>
			<c:set var="lastName" value=""/>
			<c:set var="loyPoints" value="${awardAccesBean.userPoints}"/>
			<div class="reward-points">Welcome back <c:out value="${firstName}"/>&nbsp;<c:out value="${lastName}"/>! I see you`ve got
				<%--
				String temp = pageContext.getAttribute("loyPoints").toString();
				
				char strArray[] = temp.toCharArray();
				for(int i=0; i<strArray.length; i++){
				--%>
					<span class="reward-points-no"><span class="star">${awardAccesBean.userPoints }</span></span>
				<%--}--%>
				rewards points
			</div>
		<!-- End Loyalty Point Changes May082013-->
			<table cellpadding="0" class="rewardPointsTbl" cellspacing="0" border="0" width="100%">
				<tr><td colspan="4" bgcolor="#DDDDDDD" style="padding:4px">
						<b>Loyalty Points Detail</b>
				</td></tr>
				<tr><td colspan="4" height="1" bgcolor="DDDDDD"></td></tr>
				<tr>
					<th align="left" height="25" style="border-left:1px solid #DDDDDD;padding-left:4px;">Order Id</th>
					<th align="left">Date</th>
					<th align="left">Type Of Point</th>
					<th align="left" style="border-right:1px solid #DDDDDD">No Of Point</th>
				</tr>
				<tr><td colspan="4" height="1" bgcolor="DDDDDD"></td></tr>
				<c:forEach var="bean" items="${awardAccesBean.awardBeanList}" varStatus="status">
					<tr>
						<td height="25" style="border-left:1px solid #DDDDDD;padding-left:4px;">
							<c:out value='${bean.orderId}'/>
						</td>
						<td>
							${bean.orderDate}
						</td>
						<td>
							<c:if test="${bean.pointType eq	'1'}">
								Purchase
							</c:if>
							<c:if test="${bean.pointType eq	'2'}">
								Redeem
							</c:if>
							<c:if test="${bean.pointType eq	'3'}">
								Refund Purchase
							</c:if>
							<c:if test="${bean.pointType eq	'4'}">
								Refund Redeem
							</c:if>
						</td>
						<td style="border-right:1px solid #DDDDDD">
							<c:out value='${bean.points}'/>
						</td>              	   
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="#DDDDDD"></td>
					</tr>
				</c:forEach>
			</table>
</div>	
<!-- END LoyaltyPointLocal.jsp -->