<!-- BEGIN BlogListsPageContainer.jsp -->
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>
<!-- Blogs Styles -->
<link rel="stylesheet" href="${jspStoreImgDir}css/blogs.css" type="text/css" media="screen"/>
<!-- Include script files -->
<%@include file="../Common/CommonJSToInclude.jspf" %>
<div class="rowContainer blog-page" id="container_${pageDesign.layoutID}">
	<div class="row banner-row">
    	<div class="col12"> 
			<a class="allblogs">
			<img src="${jsAssetsDir}images/colors/color2/ONTrack_ON.jpg" title="On Track" alt="Office National Blog Page" />
			</a>
		</div>
	</div>

	<div class="row Blog-menu">
		<div class="col12">
			<a class="blog-category" id="beyond">BEYOND</a>	
			<a class="blog-category" id="green">GREEN</a>	
			<a class="blog-category" id="organisation">ORGANISATION</a>	
			<a class="blog-category" id="tech">TECH</a>	
			<a class="blog-category" id="wellbeing">WELLBEING</a>
      <a class="allblogs">ALL BLOGS</a>
		</div>
	</div>

	<div class="row">
		<div class="col12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
	</div>
</div>

<script src="${jsAssetsDir}javascript/Blog.js"></script>
<!-- END BlogListsPageContainer.jsp -->