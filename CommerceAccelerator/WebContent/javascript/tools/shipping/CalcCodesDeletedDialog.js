//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*

function calcCodesList () {
	// check if document and function exist
	if (self.CONTENTS == null) return;
	if (self.CONTENTS.calcCodesList == undefined) return;

	self.CONTENTS.calcCodesList();
}
