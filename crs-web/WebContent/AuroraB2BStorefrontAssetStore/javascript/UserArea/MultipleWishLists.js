//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2010, 2016 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

MultipleWishLists = {

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
     * variable that stores the default gift list ID
     * @private
     */
    defaultListId: null,

    /**
     * indicate whether or not an item should be added after the wish list is created. 
     * @private
     */
    addItemAfterCreate: false,

    /**
     * stores the preferred default wish list name
     * @private
     */
    preferredDefaultWishListName: "",

    /**
     * stores the wish list prefix
     * @private
     */
    wishListPrefix: "",

    /**
     * Indicates whether to update wish list display context after switching to a new wish list
     */
    updateAfterSwitch: false,

    /**
     * This is the variable that controls how many characters from the wish list name are displayed before dots are added as suffix
     * @private
     */
    maxCharsToDisplay: 30,

    /**
     * Sets the common parameters for the current page. 
     * For example, the language ID, store ID, and catalog ID.
     *
     * @param {Integer} langId The ID of the language that the store currently uses.
     * @param {Integer} storeId The ID of the current store.
     * @param {Integer} catalogId The ID of the catalog.
     */
    setCommonParameters: function (langId, storeId, catalogId) {
        this.langId = langId;
        this.storeId = storeId;
        this.catalogId = catalogId;
    }

    /**
     * switch to show a different wish list, by switching to a new wish list, the newly selected wish list will
     * also become the default wish list
     * @param {string} newListId The wish list id of wish list to be switched to 
     */
    ,
    switchList: function (newListId) {

        /*For Handling multiple clicks. */
        if (!submitRequest()) {
            return;
        }
        cursor_wait();
        $("#multipleWishlistController_select").attr('disabled', 'true');
        this.updateAfterSwitch = true;
        this.setAsDefault(newListId);
    }

    /** update wish list display context after switching to a new wish list 
     * @param {string} newListId The wish list id of new default wish list 
     */
    ,
    updateContextPostSwitch: function (newListId) {
        if (this.updateAfterSwitch) {
            wcRenderContext.updateRenderContext('WishlistDisplay_Context', {
                'giftListId': newListId
            });
            wcRenderContext.updateRenderContext('WishlistSelect_Context', {
                'giftListId': newListId
            });
        }
        this.updateAfterSwitch = false;
    }

    /**
     * remove item from a wish list
     * @param {long} giftItemId ID of the wish list item to be removed
     */
    ,
    removeItem: function (giftItemId) {
        var params = {};
        params["storeId"] = this.storeId;
        params["catalogId"] = this.catalogId;
        params["langId"] = this.langId;
        params["quantity"] = 0;

        if (($("#multipleWishlistController_select") != null && $("#multipleWishlistController_select") != 'undefined') && $("#multipleWishlistController_select").val() != 0) {
            // get wish list ID
            params["giftListId"] = $("#multipleWishlistController_select").val();

            if (!this.empty(giftItemId)) {

                params["giftListItemId"] = giftItemId;

                /*For Handling multiple clicks. */
                if (!submitRequest()) {
                    return;
                }

                cursor_wait();
                wcService.invoke('ShoppingListServiceRemoveItem', params); //calling the service to save the new list name

            }
        }
    }

    /**
     * This function is used to set the selected wish list ID for the email form.
     * @param {string} formId  The formId of the email form.
     */
    ,
    getWishListIdForEmail: function (formId) {
        var form = document.getElementById(formId);
        if (($("#multipleWishlistController_select") != null && $("#multipleWishlistController_select") != 'undefined') && $("#multipleWishlistController_select").val() != 0) {
            form.giftListId.value=$('#multipleWishlistController_select').val();
        }
    }

    /**
     * This function is used to check user input in the wish list email form, if user input is valid, it invokes the InterestItemListMessage service to send out the email.
     * @param {string} formId  The formId of the email form.
     */
    ,
    checkSOAEmailForm: function (formId) {
        $("#WishListEmailSucMsg_Div").css('display', 'none');
        var form = document.getElementById(formId);
        form.sender_name.value = form.sender_name.value.replace(/^\s+/g, "");
        form.recipient.value = form.recipient.value.replace(/^\s+/g, "");

        if (form.recipient.value == '') {
            MessageHelper.formErrorHandleClient(document.getElementById('SendWishListForm_Recipient_Email').id, Utils.getLocalizationMessage("WISHLIST_MISSINGEMAIL"));
            return;
        }
        if (!MultipleWishLists.validateWishListEmailString(form.recipient.value)) {
            MessageHelper.formErrorHandleClient(document.getElementById('SendWishListForm_Recipient_Email').id, Utils.getLocalizationMessage("WISHLIST_INVALIDEMAILFORMAT"));
            return;
        }
        if (form.sender_name.value == '') {
            MessageHelper.formErrorHandleClient(document.getElementById('SendWishListForm_Sender_Name').id, Utils.getLocalizationMessage("WISHLIST_MISSINGNAME"));
            return;
        }
        if (!MultipleWishLists.validateWishListEmailString(form.sender_email.value)) {
            MessageHelper.formErrorHandleClient(document.getElementById('SendWishListForm_Sender_Email').id, Utils.getLocalizationMessage("WISHLIST_INVALIDEMAILFORMAT"));
            return;
        }
        if (form.giftListId.value == '' || form.wishListHasItem.value == "false" || form.giftListId.value == '-1') {
            MessageHelper.displayErrorMessage(Utils.getLocalizationMessage("WISHLIST_EMPTY"));
            return;
        }
        if (!MultipleWishLists.validateSenderName(form.sender_name.value)) {
            // show error message saying that
            form.sender_name.value = ''
            MessageHelper.displayErrorMessage(Utils.getLocalizationMessage("WISHLIST_INVALIDSENDERNAME"));
            return;
        }

        // maps email input to param required by AjaxGiftListAnnouncement
        form.recipientEmail.value = form.recipient.value;
        form.recipient.value = "";
        form.senderName.value = form.sender_name.value;
        if (form.sender_email.value != '') {
            form.senderEmail.value = form.sender_email.value;
        }
        if (form.wishlist_message.value != '') {
            form.message.value = form.wishlist_message.value;
        }

        /* Handles multiple clicks */
        if (!submitRequest()) {
            return;
        }

        cursor_wait();
        wcService.getServiceById("AjaxGiftListAnnouncement").setFormId(formId);
        wcService.invoke("AjaxGiftListAnnouncement");


        // reset values
        form.senderEmail.value = "SOAWishListEmail@SOAWishListEmail.com";
        form.message.value = "SOAWishListEmail";
    }

    /**
     * set a specified wish list as default wish list	 
     *	@param {long} giftListId ID of the wish list to be set as default
     */
    ,
    setAsDefault: function (giftListId) {

        if (giftListId != '-1') {
            var params = {};
            params["storeId"] = this.storeId;
            params["catalogId"] = this.catalogId;
            params["langId"] = this.langId;
            params["giftListId"] = giftListId;
            params["giftListState"] = 'Default';
            cursor_wait();
            wcService.invoke('AjaxGiftListServiceChangeGiftListStatus', params);
        } else {
            MultipleWishLists.setDefaultListId('-1');
            MultipleWishLists.updateContextPostSwitch('-1');
        }
    }

    /**
     *return true if a string is undefined or null
     *@param {string} String to be checked
     */
    ,
    empty: function (str) {
        return (str == null || str == undefined || str == "");
    }

    /**
     * sets the default wish list Id
     * @param {String} id the default wish list id
     */
    ,
    setDefaultListId: function (id) {
        this.defaultListId = id;
    }

    /**
     * returns the default wish list Id
     */
    ,
    getDefaultListId: function () {
        return this.defaultListId;
    }

    /**
     * sets the preferred default wish list name
     * @param {String} name default wish list name
     */
    ,
    setPreferredDefaultWishListName: function (name) {
        this.preferredDefaultWishListName = name;
    }

    /**
     * Sets the wish list prefix. It's the text displayed before the wish list name.
     * @param {String} prefix wish list prefix
     */
    ,
    setWishListPrefix: function (prefix) {
        this.wishListPrefix = prefix;
    }

   
    /**
     * validate the sender name
     */
    ,
    validateSenderName: function (senderName) {
            var invalidChars = "~!@#$%^&*()+=[]{};:,<>?/|`"; // invalid chars
            invalidChars += "\t\'\"\\\/"; // escape sequences

            // look for presence of invalid characters.  if one is
            // found return false.  otherwise return true
            for (var i = 0; i < senderName.length; i++) {
                if (invalidChars.indexOf(senderName.substring(i, i + 1)) >= 0) {
                    return false;
                }
            }
            return true;
        }
        /**
         * validate the email string (which can be a comma separated list)
         */
        ,
    validateWishListEmailString: function (emailString) {
        var allEmailsAreGood = true;
        var emails = emailString.split(",");
        // validate each email
        for (var i = 0; i < emails.length; i++) {
            if (!MessageHelper.isValidEmail(emails[i])) {
                allEmailsAreGood = false;
            }
        }
        return allEmailsAreGood;
    }
}
