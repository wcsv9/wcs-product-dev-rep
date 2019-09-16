<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN PrintPDP.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@include file="../Common/EnvironmentSetup.jspf"%>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Product Detail</title>
		<link rel="stylesheet" href="/wcsstore/ONB2BDirectStorefrontAssetStore/css/PrintPDP.css" type="text/css"/>
		<link rel="stylesheet" href="/wcsstore/ONB2BDirectStorefrontAssetStore/css/common1_1.css" type="text/css"/>
		<link rel="stylesheet" href="/wcsstore/ONB2BDirectStorefrontAssetStore/css/base.css" type="text/css"/>
		
		<%@ include file="../Common/CommonJSToInclude.jspf"%>
		
	</head>
	<!--<body onload="window.print();window.close();">-->
	<style>
	
	table tr td { padding:0px;}
	h1, h2, h5,h6{padding:0px; margin: 0px;}
	.print{padding: 2px; border: solid 2px #000; margin: auto;  text-align: left; font-family: Gotham, "Helvetica Neue", Helvetica, Arial, "sans-serif"}
	.print a{color: #00060c;    font-weight: normal; text-decoration: none;}
	.print h1 {        font-size: 20px;    font-weight: bold;    padding-top: 4px;}
	.print-products td {    width: 128px;    padding: 6px;    font-size: 12px;    color: #172c75;}
	.print td.p_logo {    margin: 0;    padding: 0;    vertical-align: top;}
	.print td.p_logo a img {    width: 220px;}
	.print td.product-image img#productMainImage {width: 70%;}
	.print-products td img {    width: 68px;    height: auto;}
	
	table.print-products h2 {    font-size: 9px;    color: #000;}
	
	table.quantaty_Price th {    background: #9e9e9e;    padding: 8px;    font-size: 12px;}
	table.quantaty_Price td {    background: #FFF;    padding: 8px;    font-size: 12px;}
	.product-tittle span.Price {      font-size: 15px;    font-weight: bold;}
	.product-tittle span.Price b {    font-size: 18px;    font-weight: bold;    padding-left: 23px;   padding-right: 13px;}
	.product-tittle {       padding: 14px 8%;    vertical-align: text-bottom;    font-size: 13px;    font-weight: bold;}
	.product-tittle br {    border-bottom: solid 2px #000;    display: block;}	
	.print_main_tittle{padding-left:8%;}
	.print .igo_boxhead {    display: none;}

	.print span.igo_product_product_name_value {    font-size: 10px;    height: 40px;    overflow: hidden;}
	.print .bulk-heading {    display: none;}
	.print .bulk-qty, .bulk-price {      float: left;
    width: 37%;
    padding: 2px 13px;
    font-size: 15px;}
	
	.product-tittle p {
    border-bottom: solid 1px #000;
    padding: 0;
    margin: 0;
}
.print-footer {
    text-align: left;
    border-top: solid 2px #000;
    margin-top: 6px;
    width: 100%;
}
table.print-footer td {
    padding: 0px 4% 5px;
    font-size: 12px;
    color: #2b5b8e;
}
.print-footer th {
    font-size: 12px;
}
	</style>
	<body onload="window.print();">
	

		<script>
			var catId = ${WCParam.catent_id};			
			var logo = window.opener.document.getElementById("logo").innerHTML;
			var altProducts = window.opener.document.getElementById("igdrec_1").innerHTML;
			var mainImages = window.opener.document.getElementById("mainImages").innerHTML;
			var productInfoName = window.opener.document.getElementById("ProductInfoName_"+catId).value;
			var offerPirce = window.opener.document.getElementById("offerPrice_"+catId).innerHTML;
			var productCode = window.opener.document.getElementById("product_SKU_"+catId).innerHTML;
			var productDesc = window.opener.document.getElementById("product_longdescription").innerHTML;
			var productAttr = window.opener.document.getElementById("PDP_tab-2").innerHTML;
			var priceRange = window.opener.document.getElementById("priceRange_"+catId).innerHTML;
			var curDate = new Date();
			//

			/*document.write('<div id="logo">'+logo+'</div>');
			document.write('<div id="SiteTitle">'+siteTitle+'</div>');	
			document.write('<div id="findStore">'+findStore+'</div>');
			document.write('</br><div id="footerStoreAddress">'+footerStoreAddress+'</div>');
			document.write('</br><div id="customerDetail1">'+customerDetail+'</div>');
			document.write('</br><div id="orderNumber" style="margin-top:20px;text-align: left;margin-left: 17px">Order Number: <strong>${WCParam.orderId}</strong></div></br>');
			document.write('</br><div id="currentDate" style="margin-top:-57px;text-align: right;margin-right: 8px;">Date: <strong>'+new Date()+'</strong></div></br>');*/
		</script>

		<table class="print"  cellpadding="0" cellspacing="0"  style="text-align: left; padding:2px; border:solid 1px #000;" bo width="750" height="599" border="0" >
			<tbody>
				<tr>
					<td scope="row">
						<table style="border-bottom: solid 2px #000;"  cellpadding="0" cellspacing="0" width="100%" border="0">
							<tbody>
								<tr>
									<td class="p_logo"  width="184">
										<script>document.write(logo);</script>
									</td>
									<td class="print_main_tittle"  width="268">
										<h1>Product Information Sheet</h1>
										<h6 style="font-size: 10px;    color: #424040;    font-weight: normal;">
											Printed: <script>document.write(curDate);</script>
										</h6>
									</td>
								</tr>
								<tr>
									<td class="product-image" style="text-align: center;">
										<script>document.write(mainImages);</script>
									</td>
									<td class="product-tittle">
										<p><script>document.write(productInfoName);</script></p>
										<br><br>
										<span class="Price"><script>document.write(offerPirce);</script></span>
										<span class="productCode" style="font-size: 10px;"><br><br><script>document.write(productCode);</script></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="border-bottom: solid 2px #000;"></td>
								</tr>
								<tr>
									<td colspan="2" style="font-size: 12px; text-align: left; padding: 11px; font-weight: normal;" >
										<script>document.write(productDesc);</script>
									</td>
								</tr>
								<tr>
									<td style="font-size: 12px; text-align: left; padding: 11px; font-weight: normal;" >
										<script>document.write(productAttr);</script>
									</td>
								</tr>
							</tbody>
						</table>
						<table style="padding: 0; " cellpadding="0" cellspacing="0"  width="100%" border="0">
							<tr>
								<th style="padding: 8px; text-align:left;">Alternate Products</th>
							</tr>
							<tr>
								<td><script>document.write(altProducts);</script></td>
							</tr>
						</table>
						
						<table style="padding: 0; " cellpadding="0" cellspacing="0"  width="100%" border="0">
							<tr>
								<th style="background: #9e9e9e;    padding: 8px; text-align:center;">Bulk Pricing</th>
							</tr>
							<tr>
								<td colspan="2" width="100%"><script>document.write(priceRange);</script></td>
							</tr>
						</table>
						<table class="print-footer" style="padding: 0; " cellpadding="0" cellspacing="0"  width="100%" border="0">
							<tr>
								<th style="padding: 8px;"> Additional References Material</th>
							</tr>
							<tr>
								<td  width="100%">Specification Sheet</td>
							</tr>
							<tr>
								<td  width="100%">Environmental Certification</td>
							</tr>
							<tr>
								<td  width="100%">Initiative Paper Advertisment</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</body>
</html>
<!-- END PrintPDP.jsp -->