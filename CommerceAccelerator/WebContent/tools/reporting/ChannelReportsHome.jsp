<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* 5697-D24
//*
//* (c) Copyright IBM Corp. 2002, 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
 %>

<%@page import="com.ibm.commerce.tools.xml.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@page import="com.ibm.commerce.tools.common.*" %>
<%@page import="com.ibm.commerce.command.*" %>
<%@page import="com.ibm.commerce.server.*" %>
<%@page import="java.util.*" %>

<%@include file="../common/common.jsp" %>
<SCRIPT>
	function getHelp()
	{
		return "MC.reporting.ChannelReportsHomeView.Help";
	}
</SCRIPT>

<%
 		CommandContext commandContext = (CommandContext)request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
 		Locale locale = commandContext.getLocale();
		Hashtable resourceBundle = (Hashtable) ResourceDirectory.lookup("reporting.reportStrings", locale);
%>

<html>
<head>
<title></title>
<link rel=stylesheet href="<%= UIUtil.getCSSFile(locale) %>" type="text/css">
<META name="GENERATOR" content="IBM WebSphere Studio">
</head>
<body class="entry" BGCOLOR="FFFFFF">
<table CELLPADDING="0" CELLSPACING="0" BORDER="0" HEIGHT="100%" WIDTH="100%">
  <tr> 
    <td> 
      <table CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%" HEIGHT="1%">
        <tr> 
          <td class="entry_space">&nbsp;&nbsp;&nbsp;</td>
          <td class="entry_text"><B><%=resourceBundle.get("ChannelReportsTitle")%></B>
        </tr>
        <tr> 
          <td class="entry_space">&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td class="entry_space">&nbsp;&nbsp;&nbsp;</td>
          <td class="entry_text"> <a href="/webapp/wcs/tools/servlet/DialogView?XMLFile=reporting.MarketPlaceUsageByAllResellerStoresReportDialog"><%=resourceBundle.get("ChannelReportsMarketPlaceUsageReportTitle")%></a></td>
          <td class="entry_text"><%=resourceBundle.get("ChannelReportsMarketPlaceUsageReportDescription")%></td>
        </tr>
        <tr> 
          <td class="entry_space">&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td class="entry_space">&nbsp;&nbsp;&nbsp;</td>
          <td class="entry_text" > <a href="/webapp/wcs/tools/servlet/DialogView?XMLFile=reporting.StorePerformanceReportDialog"><%=resourceBundle.get("ChannelReportsStorePerformanceReportTitle")%></a></td>
          <td class="entry_text"><%=resourceBundle.get("ChannelReportsStorePerformanceReportDescription")%></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td valign="bottom"><br>
      <table CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%" HEIGHT="14" BGCOLOR="32428A">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

