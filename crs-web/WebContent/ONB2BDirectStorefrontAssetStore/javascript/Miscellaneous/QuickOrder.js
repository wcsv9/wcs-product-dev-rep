//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2009, 2016 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/**
* @fileOverview This javascript contains javascript functions used by the quick order function
*/

quickOrderJS={
	/** language ID to be used, default to -1 (English) */
	langId: "-1",
	
	/** store ID to be used */
	storeId: "",
	
	/** catalog ID to be used */
	catalogId: "",
	
	/** used to hold error messages when bad SKU is entered */
	skuErrorMessage: "", 
	
	/** used to hold error messages when bad quantity is entered */
	qtyErrorMessage: "",
	
	/** 
	 * This constant stores the number of items that are allowed to be submitted in a single quick order.
	 * @private
	 * @constant
	 */
	numberOfItemsSupportedPerQuickOrder: "12",

	/** 
	* Sets common parameters used by this javascript object
	* @param {String} langId language ID to use
	* @param {String} storeId store ID to use
	* @param {String} catalog Catalog ID to use
	* @param {String} skuErrorMessage Error message to use when bad SKU is entered 
	* @param {String} qtyErrorMessage Error message to use when bad quantity is entered 
	*/	
	setCommonParameters:function(langId,storeId,catalogId,skuErrorMessage,qtyErrorMessage){
			this.langId = langId;
			this.storeId = storeId;
			this.catalogId = catalogId;
			this.skuErrorMessage = skuErrorMessage;
			this.qtyErrorMessage = qtyErrorMessage;
	},
	
	/**
	 * Creates an empty Custom requisition list.
	 * @param (object) formName The form which contains the name and type of the requisition list.
	 * @param (object) widgetName The widget name.
	 */
	createQuickListCustom:function(formName) {		
		var params = [];
		var form = document.forms[formName];
		
		params.name = form.name.value;
		params.editable = true
		params.status = form.status.value;
		params.quickOrder = form.quickOrder.value;
		params.storeId = form.storeId.value;
		params.catalogId = form.catalogId.value;
		params.langId = form.langId.value;

		var orderItemsCount = 0;
		for(var i=1; i<=this.numberOfItemsSupportedPerQuickOrder; i++){
			var currentPartNumberInputFieldId = form["partNumber_" + i].id;
			var currentQuantityInputFieldId = form["quantity_" + i].id;
			var currentPartNumber = trim(form["partNumber_" + i].value);
			var currentQuantity = trim(form["quantity_" + i].value);
			if((currentPartNumber != null && currentPartNumber != "") || (currentQuantity != null && currentQuantity != "")){
				if(currentPartNumber == null || currentPartNumber == ""){
					MessageHelper.formErrorHandleClient(currentPartNumberInputFieldId, this.skuErrorMessage);
					return;
				}
				if(!isPositiveInteger(currentQuantity)){
					MessageHelper.formErrorHandleClient(currentQuantityInputFieldId, this.qtyErrorMessage);
					return;
				}
				orderItemsCount = orderItemsCount + 1;
				form["partNumber_" + i].value = currentPartNumber;
				form["quantity_" + i].value = currentQuantity;
				this.updateParamObject(params,"partNumber_"+orderItemsCount, form["partNumber_" + i].value);
				this.updateParamObject(params,"quantity_"+orderItemsCount, form["quantity_" + i].value);
			}
		}
		
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}			
		cursor_wait();
		wcService.invoke('quickOrderListAddItemCustom',params);		
		
	},
	
	/**
	* This function validates the SKU input values and their corresponding quantities on the quick order form before sending the request to the server to add the SKUs to the order.
	* An error message would be displayed if an input is invalid and the requested will be stopped.
	* @param {String} formName The name of the quick order form..
	*/
	addToOrderAjax:function(formName){
		if (browseOnly){
			MessageHelper.displayErrorMessage(storeNLS['ERROR_ADD2CART_BROWSE_ONLY']); 
			return;
		}
		var params = [];
		var form = document.forms[formName];
		params.storeId = form.storeId.value;
		params.catalogId = form.catalogId.value;
		params.langId = form.langId.value;
		// Remove calculations for performance
		// params.calculationUsage = "-1,-2,-3,-4,-5,-6,-7";
		params.calculateOrder="0";
		
		var orderItemsCount = 0;
		for(var i=1; i<=this.numberOfItemsSupportedPerQuickOrder; i++){
			var currentPartNumberInputFieldId = form["partNumber_" + i].id;
			var currentQuantityInputFieldId = form["quantity_" + i].id;
			var currentPartNumber = trim(form["partNumber_" + i].value);
			var currentQuantity = trim(form["quantity_" + i].value);
			if((currentPartNumber != null && currentPartNumber != "") || (currentQuantity != null && currentQuantity != "")){
				if(currentPartNumber == null || currentPartNumber == ""){
					MessageHelper.formErrorHandleClient(currentPartNumberInputFieldId, this.skuErrorMessage);
					return;
				}
				if(!isPositiveInteger(currentQuantity)){
					MessageHelper.formErrorHandleClient(currentQuantityInputFieldId, this.qtyErrorMessage);
					return;
				}
				orderItemsCount = orderItemsCount + 1;
				form["partNumber_" + i].value = currentPartNumber;
				form["quantity_" + i].value = currentQuantity;
				this.updateParamObject(params,"partNumber_"+orderItemsCount, form["partNumber_" + i].value);
				this.updateParamObject(params,"quantity_"+orderItemsCount, form["quantity_" + i].value);
			}
		}
		
		if(orderItemsCount > 0){
			//For Handling multiple clicks
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			wcService.invoke("QuickOrderAddOrderItem", params);
		}
	},
	
	checkPartNumber:function(formName, forFav){		
		var params = [];
		var form = document.forms[formName];
		params.storeId = form.storeId.value;
		params.catalogId = form.catalogId.value;
		params.langId = form.langId.value;
		
		params.calculateOrder="0";
		
		var orderItemsCount = 0;
		var pNumbers = "";
		var qty = "";
		for(var i=1; i<=this.numberOfItemsSupportedPerQuickOrder; i++){
			var currentPartNumber = trim(form["partNumber_" + i].value);				
			var currentQty = trim(form["quantity_" + i].value);
			if((currentPartNumber != null && currentPartNumber != "") ){
				pNumbers = pNumbers + currentPartNumber + ",";
				qty = qty + currentQty + ",";
			}			
		}
		
		if(forFav == "true"){
			params["isFavourites"] = "true";
			
			var newListNameId = form["MQuickOrderForm_NewListForm_Name"].id;
			var newListNameValue = trim(form["MQuickOrderForm_NewListForm_Name"].value);
			if(newListNameValue == null || newListNameValue == ""){
				MessageHelper.formErrorHandleClient(newListNameId, "Provide a name for your new Favourites list.");
				return;
			}
		} else {
			params["isQuickOrder"] = "true";
		}
		
		if(pNumbers == ""){
			MessageHelper.displayErrorMessage("Product cant be empty.");
			return
		} else {
			params["currentPartNumber"] = pNumbers;
		} 
		
		params["qty"] = qty;		
		
		wcService.invoke("checkPartNumber", params);
	},
	
	/**
	* This function updates the given params object with Key value pair.
	* It is useful while making a service call which excepts few paramters of type array
	* @param {Object} params Object containing data to be passed to commerce services
	* @param {String} key Key to store and retrieve the parameter 
	* @param {String} value	Value of the parameter
	* @return {Object} params A JavaScript Object having key - value pair.
	*/
	updateParamObject:function(params, key, value, index){
		if(params == null){
			params = [];
		}

		if(index != null && index !== "" && index !== -1){
			//overwrite the old value at specified index
			params[key+"_"+index] = value;
		}else if(index === -1){
			var i = 1;
			while(params[key + "_" + i] != null){
				i++;
			}
			params[key + "_" + i] = value;
		}else{
			params[key] = value;
		}
		return params;
	},
	
	getProdDesc:function(formName, partNumber, index){
		var params = [];

		if(partNumber == "" || partNumber.length < 5){
			$("#quantity_"+index).val(""); 
			$("#description_"+index).val("");
			return;
		} else {
			params["partNumber"] = partNumber;
			params["index"] = index;
		}

		var form = document.forms[formName];
		params.storeId = form.storeId.value;
		params.catalogId = form.catalogId.value;
		params.langId = form.langId.value;
		
		wcService.invoke("getProductDescscription", params);
	},
	
	/**
	* This function clears all the input fields of the form passed in by parameter
	* @param {String} formName The name of the form containing the input fields.	
	*/
	 clearForm:function(formName){
		var form = document.forms[formName];
		for(var i=0; i<form.elements.length; i++) {
			if (form.elements[i].type == "text") {
				form.elements[i].value = "";
			}
		}
	}
}


/**
 * This service allows customer to add items to requisition list (Arsalan - Add Some Custom Fields).
 * @constructor
 */
wcService.declare({
	id:"quickOrderListAddItemCustom",
	actionId:"quickOrderListAddItemCustom",
	url: getAbsoluteURL() + "ONRESTRequisitionListUpdateItem",
	formId:""

	 /**
     * Hides all the messages and the progress bar.
     * @param (object) serviceResponse The service response object, which is the
     * JSON object returned by the service invocation.
     */
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		requestSubmitted = false;
		MessageHelper.displayStatusMessage("The requisition list has been successfully created.");
		document.location.href="QuickOrderView?catalogId="+serviceResponse.catalogId+"&storeId="+serviceResponse.storeId+"&langId="+serviceResponse.langId;
	}
		
	/**
	 * display an error message.
	 * @param (object) serviceResponse The service response object, which is the
	 * JSON object returned by the service invocation.
	 */
	,failureHandler: function(serviceResponse) {
		if (serviceResponse.errorMessageKey!=null) {
			var msgKey = serviceResponse.errorMessageKey;
			if (msgKey == '_ERR_GETTING_SKU' || msgKey =='_ERR_PROD_NOT_EXISTING') {
				MessageHelper.displayErrorMessage('Product ' + serviceResponse.errorMessageParam[0] + ' does not exist.');
			} if (msgKey == '_ERR_PS_ENTRY_INVALID') {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			} else {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
			}
		} else{					
			MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
		}
		cursor_clear();
	}			
}),

wcService.declare({
	id: "checkPartNumber",
	actionId: "checkPartNumber",
	url: getAbsoluteURL() + "AjaxCheckPartNumberFile",
	formId: ""

	/**
	* display a success message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,successHandler: function(serviceResponse) {
		if(serviceResponse.result == "true"){
			if(serviceResponse.isQuickOrder == "true"){
				quickOrderJS.addToOrderAjax('MQuickOrderForm');
			} else if (serviceResponse.isFavourites == "true"){
				quickOrderJS.createQuickListCustom('MQuickOrderForm');
			}
			else{
				ShipmodeSelectionExtJS.addToOrderAjax("AddItemToCartForm","product");
			}
		}
		else{
			if((serviceResponse.isQuickOrder == "true" || serviceResponse.isMultiItems == "true") && serviceResponse.minQtyCheck == "true"){
				MessageHelper.displayErrorMessage("Product "+serviceResponse.errorPartNumber+" is not available for this store. Please select an alternative product.");
			}
			else{					
				MessageHelper.hideAndClearMessage();					
				if(serviceResponse.minQtyCheck == "false"){
					MessageHelper.displayErrorMessage("Product "+serviceResponse.errorPartNumber+" can only be purchased in a multiple of "+serviceResponse.minOrderQty+".");
				}
				else{
					MessageHelper.displayErrorMessage("Product "+serviceResponse.errorPartNumber+" is not available for this store. Please select an alternative product.");
				}
			}
		}
		console.log(serviceResponse);
	}

	/**
	* display an error message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,failureHandler: function(serviceResponse) {

		cursor_clear();
	}

}),

/**
* Add an item to a shopping cart in Ajax mode. A message is displayed after the service call.
* The URL "AjaxRESTOrderAddPreConfigurationToCart" is a superset of the URL
* "AjaxRESTOrderItemAdd", allowing dynamic kit partnumbers to be entered into the quick order form.
*/
wcService.declare({
	id: "QuickOrderAddOrderItem",
	actionId: "AjaxAddOrderItem",
	url: "AjaxRESTOrderAddPreConfigurationToCart",
	formId: ""
	
	/**
	* display a success message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,successHandler: function(serviceResponse) {
		MessageHelper.hideAndClearMessage();
		MessageHelper.displayStatusMessage(MessageHelper.messages["SHOPCART_ADDED"]);
		cursor_clear();
		quickOrderJS.clearForm("MQuickOrderForm");
	}
	
	/**
	* display an error message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,failureHandler: function(serviceResponse) {

		if (serviceResponse.errorMessage) {
		 	if(serviceResponse.errorMessageKey == "_ERR_NO_ELIGIBLE_TRADING"){
		 		MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_CONTRACT_EXPIRED_GOTO_ORDER"]);
		 	} else if (serviceResponse.errorMessageKey == "_ERR_RETRIEVE_PRICE") {
				MessageHelper.displayErrorMessage(MessageHelper.messages["ERROR_RETRIEVE_PRICE"]);
			} else {
				if (serviceResponse.errorMessage == "The user does not have the authority to run this command com.ibm.commerce.orderitems.commands.OrderConfigurationAddCmd.") {
					MessageHelper.displayErrorMessage("You must login before adding a product to your cart.");
					document.getElementById("Header_GlobalLogin_signInQuickLink").click();
				} else {
					MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
				}
			}
		} 
		else {
			 if (serviceResponse.errorMessageKey) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			 }
		}
		cursor_clear();
	}

}),

/**
* Get item description against the part number in Quick Order Page (Arsalan - Custom Service)
*/
wcService.declare({
	id: "getProductDescscription",
	actionId: "getProductDescscription",
	url: getAbsoluteURL() + "ONGetProductDescscription",
	formId: ""

	/**
	* display a success message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,successHandler: function(serviceResponse) {
		document.getElementById('description_' + serviceResponse.index).value = serviceResponse.description;
		console.log(serviceResponse);
	}

	/**
	* display an error message
	* @param (object) serviceResponse The service response object, which is the
	* JSON object returned by the service invocation
	*/
	,failureHandler: function(serviceResponse) {
		cursor_clear();
	}
})
