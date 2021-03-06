<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>


<wcf:getData
    type="com.ibm.commerce.member.facade.datatypes.PersonType[]"
    var="personGroups"
    expressionBuilder="findByUniqueID"
    varShowVerb="showVerb">

    <wcf:contextData name="storeId" data="${param.storeId}" />
    <wcf:param name="personId" value="${memberId}" />
    <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:forEach var="person" items="${personGroups}">
    <c:set var="showVerb" value="${showVerb}" scope="request"/>
    <c:set var="businessObject" value="${person}" scope="request"/>
    <jsp:directive.include file="SerializeCustomer.jspf" />
</c:forEach>


