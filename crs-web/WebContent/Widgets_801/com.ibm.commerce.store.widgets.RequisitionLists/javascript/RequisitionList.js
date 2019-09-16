//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2014 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/** 
 * @fileOverview This file provides all the functions and variables to manage requisition lists and the items within.
 * This file is included in all pages with requisition list actions.
 */


/**
 * This class defines the functions and variables that customers can use to create, update, and view their requisition lists.
 * @class The RequisitionListJS class defines the functions and variables that customers can use to manage their requisition lists, 
 */
RequisitionListJS ={		
		
	/** 
	 * This variable stores the ID of the language that the store currently uses. Its default value is set to -1, which corresponds to United States English.
	 * @private
	 */
	langId: "-1",
	
	/** 
	 * This variable stores the ID of the current store. Its default value is empty.
	 * @private
	 */
	storeId: "",
	
	/** 
	 * This variable stores the ID of the catalog. Its default value is empty.
	 * @private
	 */
	catalogId: "",					
	
	/**
	 * Sets the common parameters for the current page. 
	 * For example, the language ID, store ID, and catalog ID.
	 *
	 * @param {Integer} langId The ID of the language that the store currently uses.
	 * @param {Integer} storeId The ID of the current store.
	 * @param {Integer} catalogId The ID of the catalog.
	 */
	setCommonParameters:function(langId,storeId,catalogId){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
		cursor_clear();
	},	
	
	/**
	 * Initialize the URL of Requisition List widget controller. 	 
	 *
	 * @param {object} widgetUrl The controller's URL.
	 */
	initRequisitionListUrl:function(widgetUrl){
		$("#RequisitionListTable_Widget").refreshWidget("updateUrl", widgetUrl);
	},
		
	/**
	 * Creates an empty requisition list.
	 * @param (object) formName The form which contains the name and type of the requisition list.
	 * @param (object) widgetName The widget name.
	 */
	createNewList:function() {			
		var form_name = document.getElementById("RequisitionList_NewListForm_Name");
		if (form_name !=null && this.isEmpty(form_name.value)) {
			MessageHelper.formErrorHandleClient(form_name.id,MessageHelper.messages["LIST_TABLE_NAME_EMPTY"]); return;
		}				
		service = wcService.getServiceById('requisitionListCreate');
		service.setFormId("newListDropdown");
		var params = {
		editable: "true",
		storeId: this.storeId,
		catalogId: this.catalogId,
		langId: this.langId
		};
			
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}			
		cursor_wait();
		wcService.invoke('requisitionListCreate',params);		
	},
	/**
	 * Deletes a requisition list
	 * @param (string) requisitionListId The identifier of the selected requisition list.
	 */
	deleteList:function (requisitionListId) {
		var params = {
		requisitionListId: requisitionListId,
		filterOption: "All",
		storeId: this.storeId,
		catalogId: this.catalogId,
		langId: this.langId		
		};
		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}			
		cursor_wait();
		wcService.invoke('AjaxRequisitionListDelete',params);
	},
	
	/**
	 * Create a duplicated requisition list.
	 * @param (object) name The name of the new requisition.
	 * @param (object) status The status of the new requisition.
	 * @param (string) orderId The order to create the requisition list from.
	 */
	duplicateReqList:function (name,status,orderId) {
		MessageHelper.hideAndClearMessage();
						
		var params = {
		editable: "true",
		storeId: this.storeId,
		catalogId: this.catalogId,
		langId: this.langId,
		orderId: orderId,	
		name: name,
		status: status
		};
			
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		wcService.invoke('requisitionListCopy',params);		
	},		
	
	/**
	 * This function sets the url for AjaxRequisitionListSubmit service and then it invokes the service to copy the old order.
	 * @param {string} AddToCartURL The url for the order copy service.
	 */
	addReqListToCart:function(AddToCartURL){

		/*For Handling multiple clicks. */
		if(!submitRequest()){
			return;
		}   		
		cursor_wait();
		
		wcService.getServiceById("addRequisitionListToCart").setUrl(AddToCartURL);
		wcService.invoke("addRequisitionListToCart");
	},
	
	/**
	 * Checks if a string is null or empty.
	 * @param (string) str The string to check.
	 * @return (boolean) Indicates whether the string is empty.
	 */
	isEmpty:function (str) {
		var reWhiteSpace = new RegExp(/^\s+$/);
		if (str == null || str =='' || reWhiteSpace.test(str) ) {
			return true;
		}
		return false;
	},
	
	/**
	 * Uploads a new requisition list file for processing.
	 * @param (object) formObj A reference to a form element containing the new requisition list CSV to upload.
	 * @param (object) inputObject A reference to an input element to show an error message against.
	 */		
	submitAndUploadReqList:function(formObj, inputObject) {
		MessageHelper.hideAndClearMessage();
		
		if (formObj.UpLoadedFile.value=='') {
			if (inputObject) {
				MessageHelper.formErrorHandleClient(inputObject.id,MessageHelper.messages["ERROR_REQUISITION_UPLOAD_FILENAME_EMPTY"]); 
			}
			return;
		}
		formObj.submit();
	},

	/**
	 * Show requisition list results based on page number
	 * @param (object) data The object contains page number, page size, linkId
	 */
	showResultsPageNumberForRequisitionList:function(data){
		var pageNumber = data['pageNumber'];
		var pageSize = data['pageSize'];
		pageNumber = Number(pageNumber);
		pageSize = Number(pageSize);
		
		setCurrentId(data["linkId"]);
		if(!submitRequest()){
			return;
		}
		
		var beginIndex = pageSize * (pageNumber -1);
		cursor_wait();
		wcRenderContext.updateRenderContext("RequisitionListTable_Context", {"beginIndex":beginIndex , "orderBy":""},"");
	}
}

/** 
 * Add a click event listener to the <i>uploadButton</i> on the requisition list page 
 * only if the browser is not IE.
*/ 
$( document ).ready(function() { 
    var ie_version = Utils.get_IE_version();
    if (!ie_version ) {
		var RequisitionListWidgetDom = $('#RequisitionListTable_Widget');
		if (RequisitionListWidgetDom) {		
				$(RequisitionListWidgetDom).on("click", "#uploadButton", function(e){
				$('#UpLoadedFile').click();
				if (e.preventDefault) {
					e.preventDefault();
				}				
			});
		}
	};
});
