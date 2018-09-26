<!-- ========================================================================
  Licensed Materials - Property of IBM

  5724-A18

  (c) Copyright IBM Corp. 2001, 2002

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 ===========================================================================-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">

<%@page import="java.util.*" %>
<%@page import="com.ibm.commerce.command.CommandContext"%>
<%@page import="com.ibm.commerce.server.ECConstants"%>

<%!
private String generateStatOption(String container, Hashtable biNLS, String title)
{
   
   String result = 	"<FORM NAME=" + container + ">\n" +
                   			"   <TABLE border=0 bordercolor=red CELLPADDING=0 CELLSPACING=0 width=400>" + 
	                        "	 <TR>\n" +

							"         <TD ALIGN=left VALIGN=TOP>\n" +						    							
							"			<TABLE border=0 bordercolor=black CELLPADDING=0 CELLSPACING=0 width=200>" + 
						    "			 <TR HEIGHT=5>\n" +
							"			   <TD ALIGN=left VALIGN=TOP>\n" +
						    "            <INPUT TYPE=RADIO NAME=rbname VALUE=All id=s1>\n" +
								"			<label for= s1>" +
						    "               " + biNLS.get("eMailActivityID") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +
							"            <BR>\n" +
                       	    "            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s2>\n" +
								"			<label for= s2>" +
						    "               " + biNLS.get("eMailActivityName") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +
							"            <BR>\n" +
							"            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s3>\n" +
								"			<label for= s3>" +
						    "               " + biNLS.get("viewRate") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +	
							"            <BR>\n" +
							"            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s4>\n" +
								"			<label for= s4>" +
						    "               " + biNLS.get("clickThruRate") + "\n </label> " +
						    "			 </INPUT>\n" +

							"            <BR>\n" +
							"            <BR>\n" +
                       	    "            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s5>\n" +
								"			<label for= s5>" +
						    "               " + biNLS.get("shopCartAbandonRate") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +
							"            <BR>\n" +
							"            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s6>\n" +
								"			<label for= s6>" +
						    "               " + biNLS.get("optOutRate") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +	
							"            <BR>\n" +
							"            <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s7>\n" +
								"			<label for= s7>" +
						    "               " + biNLS.get("conversionRate") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +	
						    "         </TD>\n" +
						    "      </TR>\n" +
						    "   </TABLE>\n" +
						    "         </TD>\n" +

							"         <TD>&nbsp;</TD>\n" +

	            			"         <TD ALIGN=left VALIGN=TOP>\n" +
							"			<TABLE border=0 bordercolor=black CELLPADDING=0 CELLSPACING=0 width=200>" + 
						    "			 <TR HEIGHT=5>\n" +
							"			   <TD ALIGN=left VALIGN=TOP>\n" +
						    "            <INPUT TYPE=RADIO  NAME=rbsort VALUE=All id=ord1>\n" +
									"			<label for= ord1>" +
						    "               " + biNLS.get("descend") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +
							"            <BR>\n" +
						    "            <INPUT TYPE=RADIO NAME=rbsort VALUE=PayA id=ord2>\n" +
									"			<label for= ord1>" +
						    "               " + biNLS.get("ascend") + "\n </label> " +
						    "			 </INPUT>\n" +
						    "            <BR>\n" +						            		
							"         </TD>\n" +
							"      </TR>\n" +
						    "   </TABLE>\n" +
						    "         </TD>\n" +
						    "      </TR>\n" +
							"   </TABLE>\n" +
						    " </FORM>\n";
   return result;
}

%>

<HEAD>
   <META name="GENERATOR" content="IBM WebSphere Studio">
</HEAD>
 
<SCRIPT>

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Validate is done by the HTML radio button
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   function validateStatOption(container)
   {
      return true;
   }

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // initialize function for the status dates
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
     
   function onLoadStatOption(container)
   {
	  var myContainer = parent.get(container, null);
    	
	  // If this is the first time set it to the default.	    	
      if (myContainer == null) {
			myContainer = new Object();
	
			myContainer.StatusChosen = 1;
			
			with (document.forms[container]) {
				rbname[0].checked = true;
				rbsort[0].checked = true;
			}
			parent.put(container, myContainer);
			return;  	    
      } else {
      		// If it is not the first time set it to the last selected.

			 if(myContainer.StatusChosen == 14){
				document.forms[container].rbname[6].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 
			else if(myContainer.StatusChosen == 13){
				document.forms[container].rbname[6].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			else if(myContainer.StatusChosen == 12){
				document.forms[container].rbname[5].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 
			else if(myContainer.StatusChosen == 11){
				document.forms[container].rbname[5].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			else if(myContainer.StatusChosen == 10){
				document.forms[container].rbname[4].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 
			else if(myContainer.StatusChosen == 9){
				document.forms[container].rbname[4].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			else if(myContainer.StatusChosen == 8){
				document.forms[container].rbname[3].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 		
			 else if(myContainer.StatusChosen == 7){
				document.forms[container].rbname[3].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			else if(myContainer.StatusChosen == 6){
				document.forms[container].rbname[2].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 		
			 else if(myContainer.StatusChosen == 5){
				document.forms[container].rbname[2].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			 else if(myContainer.StatusChosen == 4){
				document.forms[container].rbname[1].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 		
			 else if(myContainer.StatusChosen == 3){
				document.forms[container].rbname[1].checked = true;
				document.forms[container].rbsort[0].checked = true;
			} 
			 else if(myContainer.StatusChosen == 2){
				document.forms[container].rbname[0].checked = true;
				document.forms[container].rbsort[1].checked = true;
			} 
			 else {
				document.forms[container].rbname[0].checked = true;
				document.forms[container].rbsort[0].checked = true;
			}
			parent.put(container, myContainer);
      		return;
      }
   }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // save function for the Staus selected
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
  function saveStatOption(container)
   {
        myContainer = parent.get(container,null);
      if (myContainer == null) return;

      with (document.forms[container]) {
		  
	    	 
			 if (rbname[6].checked){
				 if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 14;
				 else
					myContainer.StatusChosen = 13;
	      	 }
			 else if (rbname[5].checked){
				 if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 12;
				 else
					myContainer.StatusChosen = 11;
	      	 }
			 else if (rbname[4].checked){
				 if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 10;
				 else
					myContainer.StatusChosen = 9;
	      	 }
			 else if (rbname[3].checked){
				 if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 8;
				 else
					myContainer.StatusChosen = 7;
	      	 }
					
			 else if (rbname[2].checked){
				 if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 6;
				 else
					myContainer.StatusChosen = 5;
	      	 }

			 else if (rbname[1].checked){
	      	 	if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 4;
				 else
					myContainer.StatusChosen = 3;
	      	 }

			 else{
	      	 	if(rbsort[1].checked)
	      	 		myContainer.StatusChosen = 2;
				 else
					myContainer.StatusChosen = 1;
	      	 }
      }
      parent.put(container, myContainer);
   }


   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Return the Status Chosen
   ///////////////////////////////////////////////////////////////////////////////////////////////////////  
   function returnStatOptionEMailActivityID(container) {
      return document.forms[container].rbname[0].checked;
   }
   function returnStatOptionEMailActivityName(container) {
      return document.forms[container].rbname[1].checked;
   }

   function returnStatOptionViewRate(container) {
      return document.forms[container].rbname[2].checked;
   }

   function returnStatOptionClickThroughRate(container) {
      return document.forms[container].rbname[3].checked;
   }

   function returnStatOptionShopcartAbandonmentRate(container) {
      return document.forms[container].rbname[4].checked;
   }

   function returnStatOptionOptOutRate(container) {
      return document.forms[container].rbname[5].checked;
   }

   function returnStatOptionConversionRate(container) {
      return document.forms[container].rbname[6].checked;
   }

 ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Return the Orderby Status Chosen
   ///////////////////////////////////////////////////////////////////////////////////////////////////////  
    function returnOrderbyDesc(container) {
      return document.forms[container].rbsort[0].checked;
   }

    function returnOrderbyAsc(container) {
      return document.forms[container].rbsort[1].checked;
   }
</SCRIPT>
