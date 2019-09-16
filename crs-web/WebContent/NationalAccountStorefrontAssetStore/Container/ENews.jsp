<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN ENews.jsp -->
<div class="row">
	<div class="col6 kcol12 eNews-title">
		 eNews stay updated with our latest news and specials. 
	</div>
	<div class="col6 kcol12 right">
		<input type="text" name="eNewsMail" id="${param.eNewsCall}_eNewsMail" value="" placeholder="enter your email address"/>
		<input type="button" name="eNewsButton" id="eNewsButton" value="SIGN UP" onClick="javascript:GlobalLoginJS.validateENewsEmail('${param.eNewsCall}', '${param.storeId}', '${param.eNewsCall}_eNewsMail');"/>
	</div>
</div>
<!-- END ENews.jsp -->