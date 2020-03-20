<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<style>div#page div#contentWrapper .row.margin-true .col12 img#contentImage_1 {
    width: 100%;
}

div#page div#contentWrapper .row.margin-true .col8.acol12 {
    width: 100%;
}
div#page div#contentWrapper .row.margin-true .col8.acol12 img#contentImage_2 {
    width: 100%;
    
}
div#page div#contentWrapper .row.margin-true .col4.acol12 {
    width: 100%;
}
div#page div#contentWrapper .row.margin-true .col4.acol12 img#contentImage_3 {
    width: 100%;
}
div#page div#contentWrapper .row.margin-true .col4.acol12 img#contentImage_4 {
    width: 100%;
}
        
    div#page div#contentWrapper .row.margin-true {
    max-width: 1100px;
    margin: 0 auto;
}
div#page div#contentWrapper .row .col6.acol12 {
    width: 100%;
    max-width: 1100px;
    margin: 0 auto;
    float: none;
}
    
.social-media {border-top: solid 1px lightgray;text-align: center;}
.social-media ul {    border: solid lightgray;    border-width: 0 1px;    -webkit-transform: translateY(-50%);    transform: translateY(-50%);}
.social-media ul {   display: inline-block;    padding: 0 20px;    background: #fefefe;    margin: 0 auto;    width: 272px;    text-align: center;}
.social-media li {    display: inline-block;}
.social-media img {    font-size: 25px;    padding: 0 10px;    color: black;} 
</style>
<div class="rowContainer" id="container_${pageDesign.layoutId}">
        <div class="row">
                <div class="col6 acol12" data-slot-id="2"><wcpgl:widgetImport slotId="2"/></div>
        </div>
        <div class="row margin-true">
                <div class="col12" data-slot-id="3"><img id="contentImage_1" src="/wcsstore/AuroraStorefrontAssetStore//images/one.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
        <div class="row margin-true">
                <div class="col8 acol12" data-slot-id="4"><img id="contentImage_2" src="/wcsstore/AuroraStorefrontAssetStore//images/two.jpeg" alt="AuroraStorefrontAssetStore"></div>
                <div class="col4 acol12" data-slot-id="5"><img id="contentImage_3" src="/wcsstore/AuroraStorefrontAssetStore//images/three.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
        <div class="row margin-true">
                <div class="col4 acol12" data-slot-id="6"><img id="contentImage_4" src="/wcsstore/AuroraStorefrontAssetStore//images/four.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
        <div class="row margin-true">
                <div class="col4 acol12" data-slot-id="7"><img id="contentImage_4" src="/wcsstore/AuroraStorefrontAssetStore//images/5.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
    <div class="row margin-true">
                <div class="col4 acol12" data-slot-id="8"><img id="contentImage_4" src="/wcsstore/AuroraStorefrontAssetStore//images/6.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
    <div class="row margin-true">
                <div class="col4 acol12" ><img id="contentImage_4" src="/wcsstore/AuroraStorefrontAssetStore//images/7.jpg" alt="AuroraStorefrontAssetStore"></div>
        </div>
    
    
    
    
        <div class="row">
                <div class="col12" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
        </div>
</div>

<!-- END HomePageContainer.jsp -->
