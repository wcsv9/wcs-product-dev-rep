//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/**
 * @fileOverview This file provides utility functions for the order check-out pages.
 

Dojo.require("dojox.collections.ArrayList");
Dojo.require("wc.widget.Tooltip");
*/

/**
 * The functions defined in this class are used for managing order information update during check-out.
 *
 * @class This CheckoutHelperJS class defines all the variables and functions for the page(s) used in the check-out process to udpate order related information, such as address, shipping method, shipping instruction, etc.
 *
 */
AdminPannelJS={

	/* Global variable declarations */

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

	
	setCommonParameters:function(langId,storeId,catalogId,userType){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
		this.userType = userType;
	},
	
	getContractAndUserPannel:function(id,flag) {
										
		if(id=='')
		{
			var flagR="addEdit";
			if(flag == 'user'){
				cursor_wait();
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flag, 'flagR':flagR, 'orgId':'0', 'usId':'0'});
			}
			else{
				cursor_wait();
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flag, 'flagR':flagR});
			}
						
		}
		
		if(flag == 'userAddI' || flag == 'userAddII'){
				var usrId=document.getElementById("usrId_"+id).value; 
				var flagR="addEdit";
				if(flag == 'userAddI'){
					var value=document.getElementById("addPartStore_"+id);					
				}else{
					var value=document.getElementById("field2_"+id).value;
				}
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flag, 'addValue':value,'usrId':usrId, 'flagR':flagR});
		}		
		else if(flag=='userAdd'){
			var value=document.getElementById("addPartStore_"+id);
			var checkVal=value.options[value.selectedIndex].value;
			var usrId=document.getElementById("usrId_"+id).value;
			var flagR="addEdit";
			
			if(checkVal=='0')
			{
				var flagR1="userRemove";
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flagR1,'addValue':value.options[value.selectedIndex].value,'usrId':usrId, 'flagR':flagR});
			}
			else if(checkVal=='-1')
			{
				alert("Select store to add default store.");
			}
			else{
				
				//var storeName = "storeName__"+id;
				//document.getElementById("storeName__"+id).value = value.options[value.selectedIndex].text;
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flag,'addValue':value.options[value.selectedIndex].value,'addValueText':value.options[value.selectedIndex].text,'usrId':usrId, 'flagR':flagR, 'id':id});


				
//				document.getElementById("storeName__"+id).value = value.options[value.selectedIndex].value;
				
			}
			
		}
		else if(flag=='userRemove'){
			var value=document.getElementById("field2_"+id).value;
			var usrId=document.getElementById("usrId_"+id).value;
			wcRenderContext.updateRenderContext('contractUserAdminContext',{'flags':flag,'addValue':value,'usrId':usrId});
		}

	},
	 setContract:function(flag) {
		
		//document.getElementById("temp").style.display = "none";
		if(flag=='contracts')
		{
			var contract = document.getElementById("contractIdName");
			var check=contract.options[contract.selectedIndex].value;
			if(check=='0')
			{
				this.getContractAndUserPannel('','contract');
			}
			wcRenderContext.updateRenderContext('contractUserAdminContext',{'contractName':contract.options[contract.selectedIndex].text,'contractId':contract.options[contract.selectedIndex].value,'flags':flag,'addFlag':flag});
		}
		else if(flag=='add')
		{
			var contract = document.getElementById("contractIdName");
			var store = document.getElementById("addPartStore");
			//var flags="contracts";
			wcRenderContext.updateRenderContext('contractUserAdminContext',{'contractName':contract.options[contract.selectedIndex].text,'contractId':contract.options[contract.selectedIndex].value,'storeName':store.options[store.selectedIndex].text,'storeIds':store.options[store.selectedIndex].value,'flags':flag,'addFlag':flag});
		}
		else{
			var contract = document.getElementById("contractIdName");
			var store = document.getElementById("removePartStore");
			//var flags="contracts";
			wcRenderContext.updateRenderContext('contractUserAdminContext',{'contractName':contract.options[contract.selectedIndex].text,'contractId':contract.options[contract.selectedIndex].value,'storeName':store.options[store.selectedIndex].text,'storeIds':store.options[store.selectedIndex].value,'flags':flag,'addFlag':flag});
		}
		
	},
	
	
	 setOrganizations:function(flag) {
			
			//document.getElementById("temp").style.display = "none";
			if(flag=='user')
			{
				var organization = document.getElementById("orgName");
				var check=organization.options[organization.selectedIndex].value;
				if(check=='0')
				{
					this.getContractAndUserPannel('','user');
				}
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'orgName':organization.options[organization.selectedIndex].text,'orgId':organization.options[organization.selectedIndex].value,'flags':flag,'addFlag':flag});
			}
			else if(flag=='add')
			{
				var organization = document.getElementById("orgName");
				var store = document.getElementById("addPartStore");
				//var flags="contracts";
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'orgName':organization.options[organization.selectedIndex].text,'orgId':organization.options[contract.selectedIndex].value,'flags':flag,'addFlag':flag});
			}
			else{
				var organization = document.getElementById("orgName");
				var store = document.getElementById("removePartStore");
				//var flags="contracts";
				wcRenderContext.updateRenderContext('contractUserAdminContext',{'orgName':organization.options[organization.selectedIndex].text,'orgId':organization.options[contract.selectedIndex].value,'flags':flag,'addFlag':flag});
			}
			
		},	
	
	
	ConAdd:function(getid,removeid) {
	   document.getElementById(getid).classList.add("active");
	   document.getElementById(removeid).classList.remove("active");
	}	
}
