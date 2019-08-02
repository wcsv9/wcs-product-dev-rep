<%@include file="../Common/EnvironmentSetup.jspf"%>

<%
	//Start: Search by brand and model No.
	String br = request.getParameter("brandval");
	pageContext.setAttribute("brandval", br);

	String storeId = request.getParameter("storeId");
	pageContext.setAttribute("storeId", storeId);

	String catId = request.getParameter("catalogId");
	pageContext.setAttribute("catalogId", catId);
%>

<wcf:rest var="printerModel" url="store/{storeId}/productQuickFind/printerModel/{brand}" scope="request" cached="true">
	<wcf:var name="storeId" value="${storeId}" encode="true" />
	<wcf:var name="brand" value="${brandval }"/>
</wcf:rest>

<select name="chapterDropDown" id="chapterDropDown" onchange="javascript:showResults2(this.value);">
	<option value="">SELECT PRINTER MODEL</option>
	<c:forEach items="${printerModel.model }" var="model" varStatus="index">
        <option value="${model.name}">${model.name}</option>
    </c:forEach>
</select>