<!-- BEGIN HomePageContainer.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div class="rowContainer" id="container_${pageDesign.layoutId}">
        <div class="row">
                <div class="col6 acol12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
                <div class="col6 acol12" data-slot-id="2"><wcpgl:widgetImport slotId="2"/></div>
        </div>
        <div class="row margin-true">
                <div class="col12" data-slot-id="3"><img id="contentImage_1" src="/wcsstore/AuroraStorefrontAssetStore//images/one.jpeg" alt="AuroraStorefrontAssetStore"></div>
        </div>
        <div class="row margin-true">
                <div class="col8 acol12" data-slot-id="4"><img id="contentImage_2" src="/wcsstore/AuroraStorefrontAssetStore//images/two.jpeg" alt="AuroraStorefrontAssetStore"></div>
                <div class="col4 acol12" data-slot-id="5"><img id="contentImage_3" src="/wcsstore/AuroraStorefrontAssetStore//images/three.jpeg" alt="AuroraStorefrontAssetStore"></div>
        </div>
        <div class="row margin-true">
                <div class="col4 acol12" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
                <div class="col4 acol12" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
                <div class="col4 acol12" data-slot-id="8"><wcpgl:widgetImport slotId="8"/></div>
        </div>
        <div class="row">
                <div class="col12" data-slot-id="9"><wcpgl:widgetImport slotId="9"/></div>
        </div>
</div>

<!-- END HomePageContainer.jsp -->
