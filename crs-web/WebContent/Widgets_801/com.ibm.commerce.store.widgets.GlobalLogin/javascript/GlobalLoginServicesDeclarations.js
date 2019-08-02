//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2014, 2016 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/**
 * @fileOverview This javascript is used by the Global Login widget to handle the services
 * @version 1.10
 */

/* global document, window, $, wc, Utils, WCParamJS, MessageHelper, cursor_clear, getAbsoluteURL */


/**
 * This service allows customer to sign in
 * @constructor
 */
wcService.declare({
    id: "globalLoginAjaxLogon",
    actionId: "globalLoginAjaxLogon",
    url: getAbsoluteURL() + "AjaxLogon",
    formId: "",

    /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
    successHandler: function (serviceResponse) {
        cursor_clear();
        var errorMessage = "";
        if (serviceResponse.ErrorCode != null) {
            var errorCode = Number(serviceResponse.ErrorCode);
            switch (errorCode) {
            case 2000:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2000"];
                break;
            case 2010:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2010"];
                break;
            case 2020:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2020"];
                break;
            case 2030:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2030"];
                break;
            case 2110:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2110"];
                break;
            case 2300:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2300"];
                break;
            case 2340:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2340"];
                break;
            case 2400:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2400"];
                break;
            case 2410:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2410"];
                break;
            case 2420:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2420"];
                break;
            case 2430:
                document.location.href = "ResetPasswordForm?storeId=" + WCParamJS.storeId + "&catalogId=" + WCParamJS.catalogId + "&langId=" + WCParamJS.langId + "&errorCode=" + errorCode;
                break;
            case 2170:
                document.location.href = "ChangePassword?storeId=" + WCParamJS.storeId + "&catalogId=" + WCParamJS.catalogId + "&langId=" + WCParamJS.langId + "&errorCode=" + errorCode + "&logonId=" + serviceResponse.logonId;
                break;
            case 2570:
                errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2570"];
                    break;
                case 2440:
                    errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2440"];
                    break;
                case 2450:
                    errorMessage = MessageHelper.messages["GLOBALLOGIN_SIGN_IN_ERROR_2450"];
                    break;
            }
            if (document.getElementById(serviceResponse.widgetId + "_logonErrorMessage_GL") != null) {
                document.getElementById(serviceResponse.widgetId + "_logonErrorMessage_GL").innerHTML = errorMessage;
                document.getElementById(serviceResponse.widgetId + "_WC_AccountDisplay_FormInput_logonId_In_Logon_1").setAttribute("aria-invalid", "true");
                document.getElementById(serviceResponse.widgetId + "_WC_AccountDisplay_FormInput_logonId_In_Logon_1").setAttribute("aria-describedby", "logonErrorMessage_GL_alt");
                document.getElementById(serviceResponse.widgetId + "_WC_AccountDisplay_FormInput_logonPassword_In_Logon_1").setAttribute("aria-invalid", "true");
                document.getElementById(serviceResponse.widgetId + "_WC_AccountDisplay_FormInput_logonPassword_In_Logon_1").setAttribute("aria-describedby", "logonErrorMessage_GL_alt");
            }
        } else {

            var url = serviceResponse.URL[0].replace(/&amp;/g, '&'),
                languageId = serviceResponse.langId;
            if (languageId != null && document.getElementById('langSEO' + languageId) != null) { // Need to switch language.

                var browserURL = document.location.href,
                    currentLangSEO = '/' + $('#currentLanguageSEO').val() + '/';

                if (browserURL.indexOf(currentLangSEO) !== -1) {
                    // If it's SEO URL.
                    var preferLangSEO = '/' + $('#langSEO' + languageId).val() + '/';

                    var query = url.substring(url.indexOf('?') + 1, url.length),
                        parameters = Utils.queryToObject(query);
                    if (parameters["URL"] != null) {
                        var redirectURL = parameters["URL"],
                            query2 = redirectURL.substring(redirectURL.indexOf('?') + 1, redirectURL.length),
                            parameters2 = Utils.queryToObject(query2);
                        // No redirect URL
                        if (parameters2["URL"] != null) {
                            var finalRedirectURL = parameters2["URL"];
                            if (finalRedirectURL.indexOf(currentLangSEO) != -1) {
                                // Get the prefer language, and replace with prefer language.
                                finalRedirectURL = finalRedirectURL.replace(currentLangSEO, preferLangSEO);
                                parameters2["URL"] = finalRedirectURL;
                            }
                            query2 = $.param(parameters2);
                            redirectURL = redirectURL.substring(0, redirectURL.indexOf('?')) + '?' + query2;
                        } else {
                            //Current URL is the final redirect URL.
                            redirectURL = redirectURL.toString().replace(currentLangSEO, preferLangSEO);
                        }
                        parameters["URL"] = redirectURL;
                    }
                    query = $.param(parameters);
                    url = url.substring(0, url.indexOf('?')) + '?' + query;

                } else {
                    // Not SEO URL.
                    // Parse the parameter and check whether if have langId parameter.
                    if (url.contains('?')) {
                        var query = url.substring(url.indexOf('?') + 1, url.length),
                            parameters = Utils.queryToObject(query);
                        if (parameters["langId"] != null) {
                            parameters["langId"] = languageId;
                            var query2 = $.param(parameters);
                            url = url.substring(0, url.indexOf('?')) + '?' + query2;
                        } else {
                            url = url + "&langId=" + languageId;
                        }
                    } else {
                        url = url + "?langId=" + languageId;
                    }
                }
            }
            if (getCookie('WC_PrivacyNoticeVersion_' + WCParamJS.storeId) != serviceResponse.privacyNoticeVersion
                    || getCookie('WC_MarketingTrackingConsent_' + WCParamJS.storeId) != serviceResponse.marketingTrackingConsent){
                        setCookie("WC_PrivacyNoticeVersion_" + WCParamJS.storeId, null, {path: "/", domain: cookieDomain, expires: -1});
            }

            if (serviceResponse["MERGE_CART_FAILED_SHOPCART_THRESHOLD"] == "1") {
                setCookie("MERGE_CART_FAILED_SHOPCART_THRESHOLD", "1", {path: "/", domain: cookieDomain});
            }
            window.location = url;
        }
    },

    /**
     * display an error message.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
    failureHandler: function (serviceResponse) {
        if (serviceResponse.errorMessage) {
            MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
        } else {
            if (serviceResponse.errorMessageKey) {
                MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
            }
        }
        cursor_clear();
    }
}),


wcService.declare({
    id: "OauthLoginAjaxLogon",
    actionId: "OauthLoginAjaxLogon",
    url: getAbsoluteURL() + "OauthLogon",
    formId: ""

        /**
         *  Copies all the items from the existing order to the shopping cart and redirects to the shopping cart page.
        *  @param (object) serviceResponse The service response object, which is the
        *  JSON object returned by the service invocation.
        */
    ,successHandler: function(serviceResponse) {
    	cursor_clear();
    	//if (serviceResponse.redirectUrl != null) {
    	var currUri = window.location.href;
    	var url = serviceResponse.redirectUrl.replace(/&amp;/g, '&');
    	var postLogonUrl = serviceResponse.URL.replace(/&amp;/g, '&');
    	var provider = serviceResponse.provider;
    	var redirectUrl = currUri.substring(0, currUri.lastIndexOf("\/")) + '/OauthLoginView?storeId=' +WCParamJS.storeId+ '&provider='+provider+ '&URL=' +postLogonUrl;
    	//alert(currUri);
    	//redirectUrl = redirectUrl.replace('&', /&amp;/g);
    	url = url + "&redirect_uri=" +encodeURIComponent(redirectUrl);
    	//alert(url);
    	window.location = url;
    	//}
    	
    }

    /**
    * display an error message.
    * @param (object) serviceResponse The service response object, which is the
    * JSON object returned by the service invocation.
    */
    ,failureHandler: function(serviceResponse) {
        console.log('failed!');
        cursor_clear();
    }
})