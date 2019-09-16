

<%




//String userName=(String)pageContext.getAttribute("loyaltyUserName");
//String password=(String)pageContext.getAttribute("loyaltyPassword");
String webid=(String)pageContext.getAttribute("logonid");
//String loyaltyServiceUrl=(String)pageContext.getAttribute("loyaltyServiceUrl");
String loyaltyWebIdCheck = null;

java.io.InputStream in = null;
java.io.BufferedReader reader = null;
StringBuilder sb = null;
			
javax.xml.parsers.DocumentBuilderFactory fac = null;
javax.xml.parsers.DocumentBuilder db = null;
org.w3c.dom.Document doc = null;
org.w3c.dom.NodeList Message = null;
org.w3c.dom.NodeList nodeList = null;
org.w3c.dom.NodeList nodeLength = null;
org.w3c.dom.NodeList nodeLoyaltyPointsEnabled = null;
org.w3c.dom.NodeList nodeDate = null;
org.w3c.dom.NodeList nodeTransactionNumber = null;
org.w3c.dom.NodeList nodePointsGained = null;
org.w3c.dom.NodeList nodePointsUsed = null;



		
try {
	//System.out.println("......11111111111111");

	StringBuilder sSoapMsg = new StringBuilder();
	sSoapMsg.append("<?xml version='1.0' encoding='UTF-8'?>");

	sSoapMsg.append("<soap:Envelope xmlns:soap='http://www.w3.org/2003/05/soap-envelope' xmlns:typ='http://schemas.servicestack.net/types'>");

	sSoapMsg.append("<soap:Header></soap:Header>");

	sSoapMsg.append("<soap:Body>");
	sSoapMsg.append("<GetLoyaltyStatement xmlns:i='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://schemas.datacontract.org/2004/07/ReadysellOfficeBrandsInterface.Models.Loyalty.RequestObjects'>");
	sSoapMsg.append("<RequestHeader xmlns:d2p1='http://readysell.com.au/ExternalServiceEndpoint'>");
	sSoapMsg.append("<d2p1:Environment>Production");
	sSoapMsg.append("</d2p1:Environment>");
	sSoapMsg.append("<d2p1:UserName>"+userName+"</d2p1:UserName>");			
	sSoapMsg.append("<d2p1:Password>"+password+"</d2p1:Password>");	
	sSoapMsg.append("</RequestHeader>");			
	sSoapMsg.append("<WebID>"+webid+"</WebID>");
	sSoapMsg.append("</GetLoyaltyStatement>");
	sSoapMsg.append("</soap:Body>");
	sSoapMsg.append("</soap:Envelope>");
	java.net.URL endpoint = new java.net.URL(loyaltyServiceUrl);
   // System.out.println("Soap Msg"+sSoapMsg);
	java.net.HttpURLConnection urlc = (java.net.HttpURLConnection) endpoint.openConnection();
	urlc.setRequestMethod("POST");
	urlc.setDoOutput(true);
	urlc.setDoInput(true);
	urlc.setUseCaches(false);

	urlc.setRequestProperty("Content-Length",Integer.toString(sSoapMsg.length()));
	urlc.setRequestProperty("SOAPAction", "\"\"");
	urlc.setRequestProperty("Content-type", "text/xml; charset=utf-8");
	java.io.OutputStream out1 = urlc.getOutputStream();
	java.io.Writer writer = new java.io.BufferedWriter(new java.io.OutputStreamWriter(out1,"UTF-8"));
	writer.write(sSoapMsg.toString());
	writer.flush();
	out1.flush();
	writer.close();
	in = urlc.getInputStream();
	reader = new java.io.BufferedReader(new java.io.InputStreamReader(in));
	sb = new StringBuilder(); // this will contain the
											// response from the web
													// service
			
			
			
	fac = javax.xml.parsers.DocumentBuilderFactory.newInstance();
	db = fac.newDocumentBuilder();
	doc = db.parse(in);
	Message = doc.getElementsByTagName("Message");
	nodeList = doc.getElementsByTagName("d4p1:PointsBalance");
	nodeLength = doc.getElementsByTagName("d4p1:LoyaltyTransaction");
	nodeLoyaltyPointsEnabled = doc.getElementsByTagName("d4p1:LoyaltyPointsEnabled");
	nodeDate = doc.getElementsByTagName("d4p1:Date");
	nodeTransactionNumber = doc.getElementsByTagName("d4p1:TransactionNumber");
	nodePointsGained = doc.getElementsByTagName("d4p1:PointsGained");
	nodePointsUsed = doc.getElementsByTagName("d4p1:PointsUsed");
	if(Message.item(0)!=null){
		pageContext.setAttribute("loyaltyEnabled1", "null");
		//out.println("..........."+Message.item(0).getTextContent());
	}
	else{
		String belancepoint1=nodeList.item(0).getTextContent();
		loyaltyWebIdCheck  = nodeLoyaltyPointsEnabled.item(0).getTextContent();
		
		pageContext.setAttribute("belancepoint1", belancepoint1);
		pageContext.setAttribute("loyaltyWebIdCheck", loyaltyWebIdCheck);
	}
		
	reader.close();
	in.close();
	urlc.disconnect();
}
catch(Exception exp ){
	exp.printStackTrace();
	
}

try{	
%>
	
 
	

	
	
			
			<!-- Start Loyalty Point Changes May082013-->
			<div class="loyalty-banner"></div>
		
			<div class="reward-points">Welcome back <c:out value="${firstName}"/>&nbsp;<c:out value="${lastName}"/>! I see you`ve got
				<%
				String temp1 = pageContext.getAttribute("belancepoint1").toString();
				char strArray1[] = temp1.toCharArray();
				for(int ii=0; ii<strArray1.length; ii++){
				%>
					<span class="reward-points-no"><span class="star"><%=strArray1[ii]%></span></span>
				<%}%>
				rewards points
			</div>
			<!-- End Loyalty Point Changes May082013-->
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
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
				<% 
				for(int i=0; i<nodeLength.getLength(); i++){
				%>
					<tr>
						<td height="25" style="border-left:1px solid #DDDDDD;padding-left:4px;">
							<% 
							out.println(nodeTransactionNumber.item(i).getTextContent());
							%>
						</td>
						<td>
						<% 
						String date=nodeDate.item(i).getTextContent();
						pageContext.setAttribute("date", date);
						out.println(date);
						%>
					</td>
					<td>
						<%
						if(nodePointsGained.item(i).getNodeName().equals("d4p1:PointsGained") && !nodePointsGained.item(i).getTextContent().equals("0.00") ){
							out.println("Purchase");
						%>
							</td>
							<td style="border-right:1px solid #DDDDDD">
								<% out.println(nodePointsGained.item(i).getTextContent());%>
							</td>  
						<%}%>
						<%
						if(nodePointsUsed.item(i).getNodeName().equals("d4p1:PointsUsed") && !nodePointsUsed.item(i).getTextContent().equals("0.00") ){
							out.println("Redeem");
						%>
							</td>
							<td style="border-right:1px solid #DDDDDD">
								<% out.println(nodePointsUsed.item(i).getTextContent());%>
							</td>  
						<%}%>
					</tr>
					<tr>
						<td colspan="4" height="1" bgcolor="#DDDDDD"></td>
					</tr>
				<%
				
				
				}%>
			</table>
		
<%
}
catch(Exception e ){
	e.printStackTrace();
}	
%>





<!-- END AwardListTableDisplay.jsp -->