<!-- 
========================================================================
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2003, 2008
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
========================================================================
--> 

<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.rfq.utils.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.tools.test.*" %>
<%@ page import="com.ibm.commerce.tools.util.*" %>
<%@ page import="com.ibm.commerce.ubf.util.*" %>

<%@ include file="../common/common.jsp" %>
<%@ include file="../common/NumberFormat.jsp" %>

<%
    CommandContext aCommandContext = (CommandContext)request.getAttribute("CommandContext");    
    Locale locale = null;
    Integer languageId = null; 
    String lang = null;
    String storeId = null;
    if ( aCommandContext!= null ) 
    {
   	locale = aCommandContext.getLocale();
   	languageId = aCommandContext.getLanguageId();	
    }
    if (locale == null) 
    {
	locale = new Locale("en","US");
    }
    if (languageId == null) 
    {
	languageId = new Integer(-1);
    }
    lang = languageId.toString();
    storeId = aCommandContext.getStoreId().toString();
    Hashtable rfqNLS = (Hashtable)ResourceDirectory.lookup("rfq.rfqNLS",locale);
          
    JSPHelper jspHelper = new JSPHelper(request);
    String rfqId = jspHelper.getParameter("requestId");
    String prodCatentryId = jspHelper.getParameter("catentryId");
    String prodPartNumber = jspHelper.getParameter("partNumber");
    String prodName = jspHelper.getParameter("prodName");
    String prodType = jspHelper.getParameter("prodType");       
    String prodDesc = jspHelper.getParameter("prodDesc");
%>

<jsp:useBean id="rfq" class="com.ibm.commerce.utf.beans.RFQDataBean" >
<jsp:setProperty property="*" name="rfq" />
</jsp:useBean>
<%
    boolean endresult_to_contract = false;
    String endresult = null;
    if (rfqId != null && rfqId.length() > 0) 
    {
        rfq.setRfqId(rfqId);
        com.ibm.commerce.beans.DataBeanManager.activate(rfq, request);
        endresult = rfq.getEndResult();
        if (endresult.equals(com.ibm.commerce.utf.utils.UTFConstants.EC_UTF_ENDRESULT_CONTRACT.toString())) 
        {
            endresult_to_contract = true;
    	}
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= UIUtil.getCSSFile(locale)%>" type="text/css" />
<title></title>
<script type="text/javascript" src="/wcs/javascript/tools/rfq/rfqUtile.js"></script>
<script type="text/javascript" src="/wcs/javascript/tools/common/Util.js"></script>

<script type="text/javascript">
    var prodCatentryId = '<%= prodCatentryId %>';
    var prodPartNumber = '<%= UIUtil.toJavaScript(prodPartNumber) %>';
    var prodName = '<%= UIUtil.toJavaScript(prodName) %>';
    var prodType = '<%= UIUtil.toJavaScript(prodType) %>';
    var prodDesc = '<%= UIUtil.toJavaScript(prodDesc) %>';
    
    var endresult_to_contract = top.getData("endresult_to_contract");  
    if (endresult_to_contract == undefined) 
    {
    	endresult_to_contract = <%= endresult_to_contract %>;
    	top.saveData(endresult_to_contract,"endresult_to_contract");
    }
    
    var anProduct = new Object();
    anProduct = top.getData("anProduct", 1);
    var allProducts = new Array();
    allProducts = top.getData("allPercentagePricingDynamicKits", 1);
    if (prodCatentryId == undefined || prodCatentryId == null || isEmpty(prodCatentryId)) 
    {
    	prodCatentryId = anProduct.<%=RFQConstants.EC_OFFERING_CATENTRYID%>;
    }
    if (prodPartNumber == undefined || prodPartNumber == null || isEmpty(prodPartNumber)) 
    {
    	prodPartNumber = anProduct.product_partnumber;
    }
    if (prodName == undefined || prodName == null || isEmpty(prodName)) 
    {
    	prodName = anProduct.product_name;
    }
    if (prodType == undefined || prodType == null || isEmpty(prodType)) 
    {
    	prodType = anProduct.product_type;
    }
    if (prodDesc == undefined || prodDesc == null || isEmpty(prodDesc)) 
    {
    	prodDesc = anProduct.product_description; 
    }
    
    var VPDResult;
    
    function savePanelData() 
    {
    	VPDResult = validatePanelData0();
    	if (!VPDResult) 
    	{
    	    return;
    	}
    	var form = document.rfqDynamicKitPPForm;
    	var resCatentryId = '<%= prodCatentryId %>';
    	if (resCatentryId != null && !isEmpty(resCatentryId)) 
    	{
    	    anProduct.<%=RFQConstants.EC_OFFERING_CATENTRYID%> = resCatentryId;
    	}
        var resPartNumber = '<%= UIUtil.toJavaScript(prodPartNumber) %>';
        if (resPartNumber != null && !isEmpty(resPartNumber))
        {
            anProduct.product_partnumber = resPartNumber;
        }
        var resProdType = '<%= UIUtil.toJavaScript(prodType) %>';
        if (resProdType != null && !isEmpty(resProdType))
        {
            anProduct.product_type = resProdType;
        }
        var resProdDesc = '<%= UIUtil.toJavaScript(prodDesc) %>';
        if (resProdDesc != null && !isEmpty(resProdDesc)) {
            anProduct.product_description = resProdDesc;
        }
        var resName = '<%= UIUtil.toJavaScript(prodName) %>';
        if (resName != null && !isEmpty(resName)) {
            anProduct.product_name = resName;
        }
        
        if (endresult_to_contract == false) 
        {
            var unitInfo = form.unit[form.unit.selectedIndex].value.split(","); 
            if (unitInfo[0] != undefined && unitInfo[0]!=null) 
	    {
	    	anProduct.<%=RFQConstants.EC_OFFERING_UNIT%> = unitInfo[0];
	    }
	    if (unitInfo[1] != undefined && unitInfo[1]!=null) 
	    {
	    	anProduct.UnitDsc = unitInfo[1];
	    }
	    anProduct.<%=RFQConstants.EC_OFFERING_QUANTITY%> = parent.strToNumber(form.quantity.value,"<%=lang%>");
	    anProduct.product_res_quantity = form.quantity.value;
	}
        
        anProduct.<%=RFQConstants.EC_OFFERING_PRICEADJUSTMENT%> = parent.strToNumber('-' + form.priceAdjustment.value,"<%=lang%>");    
    	anProduct.product_res_priceAdjustment = '-' + form.priceAdjustment.value;
    	anProduct.<%= RFQConstants.EC_OFFERING_RESPOND_TO_PRODUCT %> = "<%= RFQConstants.EC_RFQ_RESPOND_TO_PRODUCT_YES %>";
    	
    	for(var i = 0;i < allProducts.length;i++) 
    	{
    	    if (allProducts[i].<%=RFQConstants.EC_RFQ_OFFERING_PRODUCTID%> == anProduct.<%=RFQConstants.EC_RFQ_OFFERING_PRODUCTID%>) 
    	    {
    		allProducts[i].<%=RFQConstants.EC_OFFERING_RESPOND_TO_PRODUCT%> = anProduct.<%=RFQConstants.EC_OFFERING_RESPOND_TO_PRODUCT%>;
    		allProducts[i].<%=RFQConstants.EC_OFFERING_PRICEADJUSTMENT%> = anProduct.<%=RFQConstants.EC_OFFERING_PRICEADJUSTMENT%>;
    		allProducts[i].product_res_priceAdjustment = anProduct.product_res_priceAdjustment;
    		break; 
    	    }
    	}
    	top.sendBackData(allProducts, "allPercentagePricingDynamicKits");
    }
    
    function validatePanelData0() 
    {
    	var form=document.rfqDynamicKitPPForm;
    	var flag=true, quant=false, curr=false, priceleng=false;
    	
	if (endresult_to_contract == false) 
	{
	    //validates quantity
	    if ((form.quantity.value == null)||(form.quantity.value =="")) 
	    {
	    	alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgEmptyResponseValue")) %>");
	    	return false;
	    }	
	    if (form.quantity.value!= null && form.quantity.value!="") 
	    {
	    	if (!parent.isValidNumber(form.quantity.value,"<%=lang%>",false)) 
	    	{
		    quant=true;
	 	    flag=false;
	    	}
	    	if (form.quantity.value.charAt(0) == '-') 
	    	{ 
		    form.quantity.focus();
		    alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgNegativeNumber")) %>");
		    return false;
	    	}
	    }
	    if (quant) 
	    {
	    	alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgInvalidNumber")) %>");
	    }	
	}
    	
	if ((form.priceAdjustment.value == null)||(form.priceAdjustment.value =="")) 
	{
	    alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgEmptyResponseValue")) %>");
	    return false;
	}	
    	if (form.priceAdjustment.value!= null && form.priceAdjustment.value!="") 
    	{
    	    if (!parent.isValidNumber(form.priceAdjustment.value,"<%=lang%>",false)) 
    	    {
    		form.priceAdjustment.focus();
    		alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgInvalidNumber")) %>");
    		return false;
    	    }		    
    	    if (form.priceAdjustment.value < 0 || form.priceAdjustment.value > 99) 
    	    {	    
    		form.priceAdjustment.focus();
    		alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgInvalidNumber")) %>");
    		return false;
    	    }	        
    	    if (form.priceAdjustment.value.charAt(0) == '-') 
    	    {
    		form.priceAdjustment.focus();
    		alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("msgNegativeNumber")) %>");
    		return false;
    	    }
    	}
        var resCatentryId = '<%= prodCatentryId %>';
        if (resCatentryId != null && !isEmpty(resCatentryId) && endresult_to_contract == true) 
        {
            for (var i = 0;i < allProducts.length;i++) 
            {
            	if (allProducts[i].<%=RFQConstants.EC_RFQ_OFFERING_PRODUCTID%> != anProduct.<%=RFQConstants.EC_RFQ_OFFERING_PRODUCTID%> && allProducts[i].<%=RFQConstants.EC_OFFERING_CATENTRYID%> == resCatentryId) 
            	{    
    	    	    alertDialog("<%= UIUtil.toJavaScript(rfqNLS.get("RFQ_DUPLICATE_CATENTRY3"))%>");
    		    flag = false;
    		    break;
           	}
       	    }
        }
    	return flag;
    }
    
    function validatePanelData()
    {
        return VPDResult;
    }

    function retrievePanelData() 
    {
      	var priceAdjustment = anProduct.<%= RFQConstants.EC_OFFERING_PRICEADJUSTMENT %>;
       	if (priceAdjustment != null && priceAdjustment != "" && priceAdjustment != undefined) 
       	{
       	    document.rfqDynamicKitPPForm.priceAdjustment.value = numberToStr((priceAdjustment * -1), <%= languageId %>, null);
        }
      	if (endresult_to_contract == false) 
      	{	
      	    document.rfqDynamicKitPPForm.quantity.value = anProduct.product_res_quantity;
      	}      	
    }
    
    function initializeState()
    {
    	parent.setContentFrameLoaded(true);
    }

    function getFindBCT()
    {
        return "<%= UIUtil.toJavaScript(rfqNLS.get("rfq_bct_find_product")) %>";
    }

    function findCatalogEntries()
    {
        var redirectURL = "/webapp/wcs/tools/servlet/NewDynamicListView" ;
        var redirectXML = "rfq.rfqResponseCatentrySearchResult";
        var redirectCmd = "RFQResponseCatentrySearchResult";

        url="/webapp/wcs/tools/servlet/DialogView?XMLFile=rfq.rfqResponseCatentrySearch&amp;catentry_id="+ prodCatentryId + "&amp;redirectURL=" + redirectURL + "&amp;redirectCmd=" + redirectCmd + "&amp;redirectXML=" + redirectXML;
        top.setContent(getFindBCT(), url, true);
    } 
</script>
</head>

<body class="content">
<h1><%= rfqNLS.get("rfqrespondtodynamickitpercentagepricing") %></h1>
<%= rfqNLS.get("instruction_PDresponse_dk_pp") %>

<form name="rfqDynamicKitPPForm" action="">
<table border="0" width="100%">
    <tr>
  	<td><b><%= rfqNLS.get("resrequest") %></b></td>
    </tr>
    <tr>
    	<td><%= rfqNLS.get("product_partno") %>:
<script type="text/javascript">		
	    document.write(ToHTML(anProduct.product_req_partnumber)); 
</script>
    	</td>
    </tr>
    <tr>
    	<td><%= rfqNLS.get("product_name") %>:
<script type="text/javascript">
            document.write(ToHTML(anProduct.product_req_name));
</script>
    	</td>
    </tr> 
    

    <tr>
    	<td><%= rfqNLS.get("Description") %>:
<script type="text/javascript">
	    document.write(ToHTML(anProduct.product_req_description));
</script>
    	</td>
    </tr>     
    
    <tr>
        <td><%= rfqNLS.get("rfqproducttype") %>:
<script type="text/javascript">
            document.write(ToHTML(anProduct.product_req_type));
</script>
        </td>
    </tr>
 
<script type="text/javascript">					
	if (endresult_to_contract == false) 
	{	
	    document.writeln("    <tr>");
	    document.writeln("        <td>");
	    document.write('<%= rfqNLS.get("quantity") %>:');
	    document.write(anProduct.product_req_quantity);
	    document.write('<i>  '+anProduct.product_req_unit +'</i>');
	    document.writeln("        </td>");
	    document.writeln("    </tr>");
	} 
</script>
   
    <tr>
    	<td><%= rfqNLS.get("rfqpriceadjustment") %>:
<script type="text/javascript">		
	    document.write(ToHTML(anProduct.product_req_priceAdjustment));	    	
	    document.write('<%=rfqNLS.get("percentagemark")%>');
</script>
 	</td>
    </tr>    
    <tr>
    	<td><br /><b><%= rfqNLS.get("resresponse") %></b></td>
    </tr>
    <tr>
    	<td><%= rfqNLS.get("product_partno") %>:
<script type="text/javascript">
	    document.write(ToHTML(prodPartNumber));
</script>
    	</td>
    </tr>
    <tr>
    	<td><%= rfqNLS.get("product_name") %>:
<script type="text/javascript">
    	if (prodName == null || isEmpty(prodName)) 
    	{
            document.write("<%= UIUtil.toJavaScript(rfqNLS.get("RFQModifyDisplay_MadeToOrder")) %>");
    	} else {
            document.write(ToHTML(prodName));
    	}
</script>
    	</td>
    </tr>  
    

    <tr>
    	<td><%= rfqNLS.get("Description") %>:
<script type="text/javascript">
            document.write(ToHTML(prodDesc));
</script>
    	</td>
    </tr>     
    
    <tr>
        <td><%= rfqNLS.get("rfqproducttype") %>:
<script type="text/javascript">
            document.write(ToHTML(prodType));
</script>
        </td>
    </tr>    

    <tr><td>&nbsp;</td></tr>    
    
<script type="text/javascript">					
	if (endresult_to_contract == false) 
	{
	    document.writeln("    <tr>");
	    document.writeln("        <td>");
	    document.writeln("            <label for=\"quantity\">");
	    document.write('<%= rfqNLS.get("quantity") %>:');
	    document.write('<br />');
	    document.write('<input type=\"text\" name=\"quantity\" id=\"quantity\" size=\"20\" maxlength=\"200\" /> &nbsp;');	
	    document.writeln("            </label>");
	    document.writeln("        </td>");
	    document.writeln("    </tr>");    	

	    document.writeln("    <tr>");
	    document.writeln("        <td>");
	    document.writeln("            <label for=\"units\">");
	    document.write('<%= rfqNLS.get("rfqunits") %>:');
	    document.write('<br />');
	    document.write('<select name=\"unit\" id=\"units\">');	 
	    document.write('<option value=\",\" selected=\"selected\"></option>'); 		
<%
    	  try 
    	  {
	    QuantityUnitDescriptionAccessBean quab = new QuantityUnitDescriptionAccessBean();
	    java.util.Enumeration enumeration = quab.findByLanguage(languageId);
	    while ( enumeration != null && enumeration.hasMoreElements() ) 
	    {
	    	QuantityUnitDescriptionAccessBean quab2 =  (QuantityUnitDescriptionAccessBean)enumeration.nextElement();
	    	String unit_id = quab2.getQuantityUnitId();
	    	String unit_desc = quab2.getDescription();
%>
	        if (anProduct.<%=RFQConstants.EC_OFFERING_UNIT%> == "<%=UIUtil.toJavaScript(unit_id)%>") 
	    	{
	            document.write("<option value=\"<%=UIUtil.toJavaScript(unit_id)%>, <%=UIUtil.toJavaScript(unit_desc)%>\" selected=\"selected\" >");
	            document.write("<%=UIUtil.toJavaScript(unit_desc)%>");
	            document.write("</option>");
	    	} 
	    	else 
	    	{
	            document.write("<option value=\"<%=UIUtil.toJavaScript(unit_id)%>, <%=UIUtil.toJavaScript(unit_desc)%>\" >");
	            document.write("<%= UIUtil.toJavaScript(unit_desc)%>");
	            document.write("</option>");
	    	}
<%
	    } //end while
    	  } 
    	  catch (Exception e) 
    	  {
	    out.println("Error - " + e.toString());
    	  }
%>
	    document.writeln("                </select>");
	    document.writeln("            </label>");
	    document.writeln("        </td>");
	    document.writeln("    </tr>"); 
	 }    
</script>
     
    <tr>
        <td>
            <label for="priceAdjustment">
    	    <%= rfqNLS.get("rfqpriceadjustment") %>:<br />
    	    <input type="text" name="priceAdjustment" id="priceAdjustment" size="20" maxlength="200" /> &nbsp;<%=rfqNLS.get("percentagemark")%>&nbsp;<%=rfqNLS.get("rfqpercentagemarkdown")%>
            </label>
        </td>
    </tr>    
    <tr><td>&nbsp;</td></tr>    
</table>
</form>

<script type="text/javascript">
    retrievePanelData();
    initializeState();
</script>
</body>
</html>
