<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE HTML>

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


				<div >
					<!--Params for User-->
					<c:set var="flags" value="${WCParam.flags }" scope="page"/>
					<c:set var="flagR" value="${WCParam.flagR }" scope="page"/>
					<c:set var="usrId" value="${WCParam.usrId }" scope="page"/>
					<c:set var="addValue" value="${WCParam.addValue }" scope="page"/>
					
					
						
						
			
			
			
					
					
					<c:if test="${flags eq 'userAdd'}">
						<%	
							
							String usrId = pageContext.getAttribute("usrId").toString();
							String addValue = pageContext.getAttribute("addValue").toString();
							String queryUpdateUsrProf = "update userprof set field2='"+addValue+"' where users_id='"+usrId+"'";
							System.out.println("queryAdd:"+queryUpdateUsrProf);
							
							try{
								com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean sjhaAdd = new com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean();
								sjhaAdd.executeUpdate(queryUpdateUsrProf);
													
									
								
							}
							catch(Exception e){
								e.printStackTrace();
							}
						%>
					
					</c:if>
					<c:if test="${flags eq 'userRemove'}">
						<%	
							
							String usrId = pageContext.getAttribute("usrId").toString();
							
							String queryUpdateUsrProf = "update userprof set field2='0' where users_id='"+usrId+"'";
							System.out.println("queryAdd:"+queryUpdateUsrProf);
							
							try{
								com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean sjhaAdd = new com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean();
								sjhaAdd.executeUpdate(queryUpdateUsrProf);
													
									
								
							}
							catch(Exception e){
								e.printStackTrace();
							}
						%>
					
					</c:if>
					<%	
							java.util.Vector recVector = null;
							java.util.Vector recVector1 = null;
							//String contractId = pageContext.getAttribute("contractId").toString();
							
							String orgName = "";
							String orgId = "";
							String dn = "";
							String orgNameM="";
							String orgIdM="";
							String field2M="";
							String contractNameM="";
							String storeNameM="";
							String logonId="";
							String usersId="";
							String field2="";
							String storeName="";
							
							String userQuery = "select b.users_id,b.logonid,c.dn from mbrrel a,userreg b,users c where a.ancestor_id in (select member_id from storeent where identifier = 'nationalaccount') and b.users_id=a.descendant_id and b.users_id=c.users_id";
							System.out.println("userQuery:"+userQuery);
							try{
								com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean sjha = new com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean();
								recVector = sjha.executeQuery(userQuery);
								//System.out.println("recVector.size()"+recVector.size());
								if(recVector.size() > 0){
									
									for(java.util.Enumeration proEnum = ((java.util.Vector)recVector).elements(); proEnum.hasMoreElements();){
										java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
										usersId += String.valueOf(codRec.elementAt(0))+":::";
										logonId += String.valueOf(codRec.elementAt(1))+":::";
										dn += String.valueOf(codRec.elementAt(2))+":::";
										System.out.println("dn:"+dn);	
									}
								}
								String[] usrSplit=usersId.split(":::");
								String[] dnSplit=dn.split(":::");
								System.out.println("dnSplit.length:"+dnSplit.length);
								
								for(int i=0; i<dnSplit.length;i++)
								{
									
									String[] dnValue=dnSplit[i].split(",");
									String userDn="";
									for(int j=0; j<dnValue.length;j++)
									{
										if(j>0)
										{
											if(j >=dnValue.length-1)
											{
												userDn+=dnValue[j];
											}
											else{
												userDn+=dnValue[j]+",";
											}
											
										}
										
									}
									
									String orgQuery="select orgentityname,orgentity_id from orgentity where dn in ('"+userDn+"')";
									String storeQuery="select storename,store_id from natstoreaddress where store_id in (select field2 from userprof  where users_id='"+usrSplit[i]+"')";
									String field="";
									System.out.println("userQuery:"+orgQuery);
									
									recVector = sjha.executeQuery(orgQuery);
									System.out.println("recVector.size:"+recVector.size());
									recVector1 = sjha.executeQuery(storeQuery);
									if(recVector.size() > 0){
									
										for(java.util.Enumeration proEnum = ((java.util.Vector)recVector).elements(); proEnum.hasMoreElements();){
											java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
											orgName = String.valueOf(codRec.elementAt(0))+":::";
											orgId = String.valueOf(codRec.elementAt(1))+":::";
											
												
										}
									}
									
									
									if(recVector1.size() > 0){
									
										for(java.util.Enumeration proEnum = ((java.util.Vector)recVector1).elements(); proEnum.hasMoreElements();){
											java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
											storeName = String.valueOf(codRec.elementAt(0))+":::";
											field2 = String.valueOf(codRec.elementAt(1))+":::";
											
												
										}
									}
									else{
										storeName = "Add Store By Store ID"+":::";
										field2 ="-"+":::";
									}
									
									orgNameM+=orgName;
									orgIdM+=orgId;
									field2M+=field2;
									storeNameM+=storeName;
									
								}
								
								String[] orgSplit=orgIdM.split(":::");
								System.out.println("orgSplit.length:"+orgSplit.length);
								
								for(int i=0; i<orgSplit.length;i++)
								{
									String contractName="";
									String newline = System.getProperty("line.separator");
									
									String contractQuery="select name from contract where contract_id in (select trading_id from trading where trading_id in (select trading_id from participnt where member_id like '%"+orgSplit[i]+"%')) and state='3'";
									//String field="";
									System.out.println("contractQuery:"+contractQuery);
									
									recVector = sjha.executeQuery(contractQuery);
									System.out.println("recVector.size():"+recVector.size());
									int recsize=recVector.size();
									int cVal=0;
									if(recVector.size() > 0){
									
										for(java.util.Enumeration proEnum = ((java.util.Vector)recVector).elements(); proEnum.hasMoreElements();){
											java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
											if( recsize>1 || (recsize>1 && recsize>= recVector.size()-1))
											{
												++cVal;
												contractName += " ("+cVal+") "+String.valueOf(codRec.elementAt(0))+"</br>";
												--recsize;
												
											}
											else{
												++cVal;
												contractName +=" ("+cVal+") "+ String.valueOf(codRec.elementAt(0));
											}
											
											
										}
										
									}
									contractNameM+=contractName+":::";
									
									
								}
								
									System.out.println("dn:"+dn);
									System.out.println("field2:"+field2M);
									System.out.println("orgNameM:"+orgNameM);
									System.out.println("orgId:"+orgIdM);	
									
								String[] orgN=orgNameM.split(":::");
								String[] usrN=logonId.split(":::");
								String[] field2N=field2M.split(":::");
								String[] usersIdN=usersId.split(":::");
								String[] storeNameN=storeNameM.split(":::");
								String[] contractNameN=contractNameM.split(":::");
								System.out.println("dnSplit.length:"+usrN.length);
							%>
							<table class="UserManagementTable" cellpadding="0" cellspacing="0">
								<tr>
									<th>Customer</th>
									<th>User</th>
									<th>Default Store</th>
									<th>Contracts</th>
								</tr>
							<%
							
								for(int i=0; i<usrN.length;i++)
								{	
							
							%>
									<tr>
										<td><%=orgN[i]%></td>
										<td><%=usrN[i]%></td>
									<%
										String fid = pageContext.getAttribute("flags").toString();
										String fR = pageContext.getAttribute("flagR").toString();
										String uid = "";
										if(fid.equals("userAddI") || fid.equals("userAddII")){
											uid = pageContext.getAttribute("usrId").toString();
										}							
										
										System.out.println("uid " + uid + " fid " + fid + " StoreName " + storeNameN[i] + "[]uid:" + usersIdN[i]);
										if(storeNameN[i].equals("Add Store By Store ID") && fR.equals("addEdit") && !usersIdN[i].equals(uid))
										{
										%>	
										<td style="width:404px;">
										<input type="button" class="button_primary" value="Add/Edit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('<%=i%>','userAddI')" /></td>
										<%									
										}
										else if(usersIdN[i].equals(uid) && (fid.equals("userAddI") || fid.equals("userAddII")))
										{
											System.out.println("in elseif: " + usersIdN[i] + ", " + uid);
										%>	
										<td style="width:404px;">
										<select style="width: 322px;" id="addPartStore_<%=i%>">
											<option value="-1">Select Default Store And Submit</option>
											<c:if test="${flags eq 'userAddII'}">
												<option value="0">Remove Default Store And Submit</option>	
											</c:if>
																				
											<%	
												java.util.Vector recVectorAdds = null;
												
												String queryAdds = "select a.store_id,a.storename from natstoreaddress a , store b where a.store_id=b.store_id and b.status=1  order by  a.storename";
												System.out.println("query:"+queryAdds);
												String storeIdAdds = "";
												String storeNameAdds = "";
												try{
													com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean sjhaAdds = new com.ibm.commerce.base.objects.ServerJDBCHelperAccessBean();
													recVectorAdds = sjhaAdds.executeQuery(queryAdds);
													System.out.println("recVector.size()"+recVectorAdds.size());
													if(recVectorAdds.size() > 0){
														
														for(java.util.Enumeration proEnum = ((java.util.Vector)recVectorAdds).elements(); proEnum.hasMoreElements();){
															java.util.Vector codRec = (java.util.Vector)proEnum.nextElement();
															storeIdAdds = String.valueOf(codRec.elementAt(0));
															storeNameAdds = String.valueOf(codRec.elementAt(1));
															
															pageContext.setAttribute("selectedstId",storeIdAdds);
											%>
											<c:if test="${WCParam.addValue eq selectedstId}">
												<option value=<%=storeIdAdds%> selected="selected"><%=storeNameAdds%></option>
											</c:if>
											<c:if test="${WCParam.addValue ne selectedstId}">
												<option value=<%=storeIdAdds%>><%=storeNameAdds%></option>
											</c:if>
										<%						
													}
												}
											}
											catch(Exception e){
												e.printStackTrace();
											}
										%>
										</select>
										<input type="button" class="button_primary" value="Submit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('<%=i%>','userAdd')" /></td>
										<%
										}
										else if(!storeNameN[i].equals("Add Store By Store ID")){											
										%>
										<td style="width:404px;">
											
										<input style="width:290px;" type="text" value="<%=storeNameN[i]%>" id="storeName_<%=i%>" />
										<input class="button_primary" type="button" value="Add/Edit" onClick="javascript:AdminPannelJS.getContractAndUserPannel('<%=i%>','userAddII')" /></td>
										<%
											}
										%>	
										<input type="hidden" value="<%=usersIdN[i]%>" id="usrId_<%=i%>"/>
										<input type="hidden" value="<%=field2N[i]%>" id="field2_<%=i%>"/>
										<td><%=contractNameN[i]%></td>
									</tr>	
							<%							
							}
							}
							catch(Exception e){
								e.printStackTrace();
							}
							%>
							</table>
			</div>

