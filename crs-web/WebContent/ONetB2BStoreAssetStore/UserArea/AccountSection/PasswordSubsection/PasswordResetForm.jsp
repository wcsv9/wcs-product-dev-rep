

<%-- 
  *****
  * This JSP displays an entry box prompting the customers to enter their Logon ID. 
  * The customers type their Logon ID and click 'Send me my password' button. 
  * The system then sends the password to the user's registered e-mail address if no error occurs.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<c:set var="pageCategory" value="MyAccount" scope="request"/>

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN PasswordResetForm.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<%@ include file="../../../Common/CommonCSSToInclude.jspf"%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message bundle="${storeText}" key="FORGET_PASS_TITLE"/></title>

	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	
</head>
<body>
<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<!-- Page Start -->
<div id="page">
	<!-- Header Nav Start -->
	<c:if test="${b2bStore eq 'true'}">
    	<c:if test="${userType =='G'}">
			<c:set var="hideHeader" value="true"/>
		</c:if>
	</c:if>
	<!-- Header Widget -->
	<div class="header_wrapper_position" id="headerWidget">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
	</div>
	<!-- Main Content Start -->
	<div class="content_wrapper_position" role="main">
		<div class="content_wrapper">
			<div class="content_left_shadow">
				<div class="content_right_shadow">
					<div class="main_content">
						<div class="container_full_width" id="content_wrapper_border">
							<!-- Content Start -->
							<div id="box">	
								<wcf:url var="RegisterURL" value="Logoff">
									<wcf:param name="langId" value="${langId}" />
									<wcf:param name="storeId" value="${WCParam.storeId}" />
									<wcf:param name="catalogId" value="${WCParam.catalogId}" />
									<wcf:param name="registerNew" value="Y" />
									<wcf:param name="myAcctMain" value="1" />
								</wcf:url>
								<div class="sign_in_registration" id="WC_PasswordResetForm_div_1">
									<div class="title" id="WC_PasswordResetForm_div_2">
										<h1><fmt:message bundle="${storeText}" key="FORGOT_PASS"/></h1>
									</div>					

									<div class="forgot_password_container" id="WC_PasswordResetForm_div_3">
										<div class="myaccount_header" id="WC_PasswordResetForm_div_4">
											<h2 class="registration_header"><fmt:message bundle="${storeText}" key="LET_US_HELP"/></h2>
										</div>
										<div class="forgot_password_content" id="WC_PasswordResetForm_div_6">
											<div class="align" id="WC_PasswordResetForm_div_7">
												<fmt:message bundle="${storeText}" key="DONOT_PASS"> 
													<fmt:param>
													<a href="<c:out value="${RegisterURL}"/>" class="myaccount_link" id="WC_PasswordResetForm_links_1">
														<fmt:message bundle="${storeText}" key="CLICK_HERE"/>
													</a>
													</fmt:param>
												</fmt:message>

												<span class="strongtext"><fmt:message bundle="${storeText}" key="VALIDATION_CODE_FORGOT_TEXT"/></span><br/>
												<c:if test="${!empty errorMessage}">
													<span class="error_msg" id="error_msg"><c:out value="${errorMessage}"/></span>
													<c:set var="aria_invalid" value="aria-invalid=true"/>
													<script type="text/javascript">
														$(document).ready(function() {
															increaseHeight("WC_PasswordResetForm_div_7", 15);
														});
													</script>
												</c:if>
																			
												<form name="ResetPasswordForm" method="post" action="PersonChangeServicePasswordForgottenReset" id="ResetPasswordForm">
													<input type="hidden" name="challengeAnswer" value="-" id="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1"/>
													<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1"/>
													<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1"/>
													<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1"/>
													<input type="hidden" name="state" value="passwdconfirm" id="WC_PasswordResetForm_FormInput_state_In_ResetPasswordForm_1"/>
													<input type="hidden" name="URL" value="ResetPasswordForm" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
													<input type="hidden" name="errorViewName" value="ResetPasswordErrorView" id="WC_PasswordResetForm_FormInput_errorViewName_In_ResetPasswordForm_1"/>
													<input type="hidden" name="authToken" value="${authToken}"  id="WC_PasswordResetForm_FormInput_authToken_In_ResetPasswordForm_1"/>
																		<br />
                                    							<div id="check">
                                        
                                    							</div>
                                    							<div id="DataFields">
                                    							<h4>I know my Email but forgotten my Logon ID or Password</h4>
                                    							<br/>								 
													<span class="strongtext">
													
													<label for="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_2">
                                            Email Address :
                                        </label>
                                    </span>
                                    <br />
                                    <input size="25" name="emailId" onchange="javascript:MyAccountDisplay.disableLogonId();" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_2"/>
                                    <br/>
                                    <br/>
                                    <h2>OR</h2>
                                    <br/>
                                    <h4>I know my Logon ID but forgotten the Password or Email </h4>
                                    <br/>
                                    
                                    				<span class="strongtext">
														<label for="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1">
															<fmt:message bundle="${storeText}" key="LOGON_ID2"/>
														</label>
													</span>
													<br/>
													
													<input size="25" name="logonId" onchange="javascript:MyAccountDisplay.disableEmailId();" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1"/>
                                    <br/>
                                    <br/>
                                    <a href="#" class="button_primary" onclick="javascript:MyAccountDisplay.submitForm1(document.ResetPasswordForm,'<c:out value="${ForgetPasswordURL}"/>');return false;"  id="WC_PasswordResetForm_Link_2">
                                                            
                                                            Send Me My Password
                                                            
														</a>
													</div>
												</form>
											</div>
											<div class="footer" id="WC_PasswordResetForm_div_10">
                                <div class="left_corner" id="WC_PasswordResetForm_div_11"></div>
                                <div class="left" id="WC_PasswordResetForm_div_12"></div>
                                <div class="right_corner" id="WC_PasswordResetForm_div_13"></div>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>

					<div class="clear">
					</div>

					<div style="clear:both;"></div>
					<!-- Footer Start End -->
				</div>
				
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

<style>

div#check h3 {
    margin: 0px 0px 19px 0px ;
}
div#check {
    font-size: 13px;
}
div#check input[type="radio"] {
    margin: 0px 12px 9px 0px;
    vertical-align: sub;
}


</style>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview category="MISC"/></flow:ifEnabled>
 
<c:set var="storeId" value="${WCParam.storeId }"/>
<%
String email=request.getParameter("emailId");
%>
<wcf:rest var="passwordReset" url="store/{storeId}/password/reset/{email}" scope="request" cached="true">
<wcf:var name="storeId" value="${storeId}" encode="true"/>
<wcf:var name="email" value="${email}"/>
</wcf:rest>

<%
if(email !=null && !(email.equalsIgnoreCase("")))
{
	java.util.Vector listRecords = null;
    String storeId = pageContext.getAttribute("storeId").toString(); 
  //String[] logonid=null;
    String sql="Select LOGONID from userreg where users_id in (select member_id from mbrrole where member_id in(select member_id from address where  upper(email1) =upper('"+email+"') and status='P') and orgentity_id in(select member_id from storeent where storeent_id='"+storeId+"') and role_id=-29) and CHALlENGEQUESTION is not null and CHALlENGEANSWER is not null";
     
    
}

%>

	<!-- Footer Start Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div> 
    <!-- Footer Start End -->
</div>

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>
</html>
<!-- END PasswordResetForm.jsp -->
