<!-- Including the class file on the page that contains the data type required by query template -->

<%@page import="java.util.Vector"%>

<!-- BEGIN ProductQuickFind.jsp -->
<div id="quickFind">
	<div id="quickFind_body">
		<div id="quickfind_box_left">
			<h2 class="heading" style="display: block;">Your Ink & Toner Finder</h2>
		</div>
		<div class="col12 row">	
			<wcf:url var="SortURL1" value="SearchDisplay" type="Ajax">
				<wcf:param name="searchTerm" value="Paper" />
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				<wcf:param name="pageView" value="detailed" />
				<wcf:param name="beginIndex" value="0" />
				<wcf:param name="pageSize" value="12" />
				<wcf:param name="searchType" value="simpleSearch" />
				<wcf:param name="sType" value="SimpleSearch" />
				<wcf:param name="resultCatEntryType" value="2" />
				<wcf:param name="showResultsPage" value="true" />
				<wcf:param name="errorViewName" value="SearchDisplayView" />
			</wcf:url>

			<wcf:url var="searchProduct" value="QuickFindResultsView">
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				<wcf:param name="categoryId" value="${WCParam.categoryId}" />
				<wcf:param name="pageView" value="detailed" />
				<wcf:param name="beginIndex" value="0" />
				<wcf:param name="pageSize" value="12" />
				<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
				<wcf:param name="minPrice" value="${WCParam.minPrice}" />
				<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
				<wcf:param name="searchType" value="simpleSearch" />
				<wcf:param name="sType" value="SimpleSearch" />
				<wcf:param name="metaData" value="${metaData}" />
				<wcf:param name="resultCatEntryType" value="2" />
				<wcf:param name="showResultsPage" value="true" />
				<wcf:param name="searchTermScope" value="1" />
			</wcf:url>
			
			<wcf:rest var="printerBrand" url="store/{storeId}/productQuickFind/printerBrand" scope="request" cached="true">
				<wcf:var name="storeId" value="${storeId}" encode="true"/>
			</wcf:rest>
			<div class="col3 acol12">
			<select name="brand" id="brand"	onchange="showModel(this.value, 'GetModelView');">
				<option value="">SELECT PRINTER BRAND</option>								
				<c:forEach items="${printerBrand.brand }" var="brandName" varStatus="index">
			        <option value="${brandName.name}">${brandName.name}</option>
			    </c:forEach>
			</select>
			</div>
			
			<div id="modelno" class="col3 acol12">
				<select name="chapterDropDown" id="chapterDropDown" onchange="showResults2(this.value);">
				</select>
			</div>

			<c:set var="searchView" value="SearchDisplay" />
			<c:set var="searchDisplayView" value="SearchDisplayView" />
			<!-- SearchForm used for invoking the searchCommand is reused here to invoke the searchDisplay view -->

			<form id="CatalogSearchForm1" name="CatalogSearchForm1" method="get" action="${searchView}">
				<input id="WC_CachedHeaderDisplay_FormInput_categoryId_In_CatalogSearchForm_2" name="categoryId" type="hidden" />
				<input name="storeId" value="${storeId}" type="hidden" />
				<input name="catalogId" value="${catalogId}" type="hidden" />
				<input name="langId" value="${langId}" type="hidden" />
				<input name="sType" value="SimpleSearch" type="hidden" />
				<input name="resultCatEntryType" value="2" type="hidden" />
				<input name="showResultsPage" value="true" type="hidden" />
				<input name="searchSource" value="Q" type="hidden" />
				<input name="pageView" value="${env.defaultPageView}" type="hidden" /> 
				<input name="beginIndex" value="0" type="hidden" /> 
				<input name="pageSize" value="${empty pageSize ? 12 : pageSize}" type="hidden" /> 
				<input type="hidden" name="searchType" value="1" id="searchType"> 
				<input type="hidden" name="searchTerm" id="SimpleSearchForm_SearchTerm1" value="" />
			</form>
			
			<div class="col6 acol12 row">
			<div class="or col2 acol12"></div>
			<div class="radio col10 acol12">
				<div class="tonerRadioBtns"><div class="tonerInps"><input type="radio" id="cartridgeno" name="cartridge_printer" value="cartridge" onclick="select()" /></div> 
				<div class="tonerLbls"><label for="cartridge">Cartridge Number</label></div> 
			 	<div class="tonerInps"><input type="radio" id="printermo" name="cartridge_printer" value="printer" /></div> 
				<div class="tonerLbls"><label for="printer">Printer model</label><br></div>
				</div>
				<div class="clearFloat"></div>
				<div>
				<input type="text" id="chapterDropDown1" name="chapterD" /> 
				<input type="submit" class="chapterButton1" value="GO" onclick="go();" />
				</div>
			</div>
			</div>	
		</div>
		<div class="right" id="quickfind_box_right">
			<!--Ink and Toner Page Right Banner -->


			<!--Ink and Toner Page Right Banner -->
		</div>
		<div class="line"></div>
		<!--Ink and Toner Page Small Banners -->
	</div>
	<div class="line"></div>
</div>
<!-- END ProductQuickFind.jsp -->