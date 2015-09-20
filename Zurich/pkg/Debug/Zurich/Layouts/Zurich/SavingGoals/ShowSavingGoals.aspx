<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowSavingGoals.aspx.cs" Inherits="Zurich.Layouts.Zurich.SavingGoals.ShowSavingGoals" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<link type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/ui-lightness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="/_layouts/Zurich/styles/savingOptionJs/html5-canvas-bar-graph.js"></script>
<script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<!-- Saving Options Js -->

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/savingOptions.js"></script>

<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>

<script language="javascript" type="text/javascript">

    function popitup(url, width, height) {
        newwindow = window.open(url, 'name', 'height=' + height + ',width=' + width + ', scrollbars=yes');
        if (window.focus) { newwindow.focus() }
        return false;
    }

    function DeleteRow(param) {
        var answer = confirm("Delete Existing Asset ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
            tempCalculate();
            calculateAmountNeededFutureValue();
        }
        document.getElementById('<%= noofmembers.ClientID %>').value = count;
    }


    function popupshowfactfindassets(url) {
        newwindow = window.open(url, 'name', 'height=500,width=1000,scrollbars=1');
        if (window.focus) { newwindow.focus() }
        return false;
    }


    function popupassets(url) {
        newwindow = window.open(url, 'name', 'height=500,width=1000');
        if (window.focus) { newwindow.focus() }
        return false;
    }

    window.closingPopup = function () {
        document.getElementById('<%= popupclose.ClientID %>').value = 'true';
        document.getElementById('<%= addclicked.ClientID %>').value = '';
        document.forms[0].submit();
    };

    window.popUpEditSavingGoalClosed = function () {
        var savinggoalid = document.getElementById('<%= savinggoalid.ClientID %>').value;
        document.forms[0].action = '/SavingGoals/ShowSavingGoals/' + savinggoalid;
        document.forms[0].method = "get";

        document.getElementById('<%= printpage.ClientID %>').value = "false";

        //var noOfExistingAssets = $("#existingAssetTable >tbody > tr").size();
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;

        document.forms[0].submit();
    };


    function roundOffValues() {
        if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
            document.getElementById('<%= yrstoAccumulate.ClientID %>').value = Math.round(document.getElementById('<%= yrstoAccumulate.ClientID %>').value);
        }
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            document.getElementById('<%= futureValue.ClientID %>').value = Math.round(document.getElementById('<%= futureValue.ClientID %>').value);
        }
        if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
            document.getElementById('<%= existingAssets.ClientID %>').value = Math.round(document.getElementById('<%= existingAssets.ClientID %>').value);
        }
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            document.getElementById('<%= maturityValue.ClientID %>').value = Math.round(document.getElementById('<%= maturityValue.ClientID %>').value);
        }
    }

    function calculateAmountNeededFutureValue() {

        //roundOffValues();

        var yearsToAccumulate = 0;
        if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
            document.getElementById('<%= yrstoAccumulate.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= yrstoAccumulate.ClientID %>').value);
            yearsToAccumulate = Math.round(parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value));
        }

        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            document.getElementById('<%= futureValue.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= futureValue.ClientID %>').value);
            futureValue = fixedToZero(Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value) * 100) / 100);
            document.getElementById('<%= futureValue.ClientID %>').value = futureValue;
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
            document.getElementById('<%= existingAssets.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= existingAssets.ClientID %>').value);
            exitingAssets = fixedToZero(Math.round(parseFloat(document.getElementById('<%= existingAssets.ClientID %>').value) * 100) / 100);
            document.getElementById('<%= existingAssets.ClientID %>').value = exitingAssets;
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            document.getElementById('<%= maturityValue.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= maturityValue.ClientID %>').value);
            maturityValue = fixedToZero(Math.round(parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value) * 100) / 100);
            document.getElementById('<%= maturityValue.ClientID %>').value = maturityValue;
        }

        var shortfall = fixedToZero(Math.round(((parseFloat(exitingAssets) + parseFloat(maturityValue)) - parseFloat(futureValue)) * 100) / 100);

        document.getElementById('<%= totalShortfallSurplus.ClientID %>').value = Math.abs(shortfall);
        
        

        if (shortfall < 0) {
            $('#surplus_shortfall_family_needs').text('Shortfall');
            $('#surplus_shortfall_family_needs').css('color', 'red');
        }
        else if (shortfall > 0) {
            $('#surplus_shortfall_family_needs').text('Surplus');
            $('#surplus_shortfall_family_needs').css('color', 'black');
        }
        else {
            $('#surplus_shortfall_family_needs').text('Shortfall / Surplus');
            $('#surplus_shortfall_family_needs').css('color', 'black');
        }


        document.getElementById('<%= noofmembers.ClientID %>').value = count;

        calculateOptions();
    }

    function AddSavingGoal() {
        document.getElementById('<%= addclicked.ClientID %>').value = 'true';
        document.getElementById('<%= popupclose.ClientID %>').value = '';
        document.forms[0].submit();
    }

    function submitSavingGoals() {
        document.getElementById('<%= addclicked.ClientID %>').value = '';
        document.getElementById('<%= popupclose.ClientID %>').value = '';

        document.getElementById('<%= printpage.ClientID %>').value = "false";

        //var noOfExistingAssets = $("#existingAssetTable >tbody > tr").size();
        //alert(count);
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;

        document.forms[0].submit();
    }

    function printpg() {
        //var noOfExistingAssets = $("#existingAssetTable >tbody > tr").size();
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;
        document.getElementById('<%= printpage.ClientID %>').value = "true";

        document.forms[0].submit();
    }

    function onBackToCase() {
        onSave();
        var response = confirm("Do you want to Generate PDF before Back to the Case?");
        if (response == true) {
            document.getElementById('<%=backToCase.ClientID %>').value = true;
        }
        else {
            document.getElementById('<%=backToCase.ClientID %>').value = false;
        }
    }

    function tempCalculate() {

        //count = $("#existingAssetTable >tbody > tr").size();
        var presentvalueid = 'pri_';
        var percentagevalueid = 'sec_';
        var sum = 0;
        for (var i = 1; i <= count; i++) {
            var pvid = presentvalueid + (i);
            var paid = percentagevalueid + (i);

            var docpvid = document.getElementById(pvid);
            var docpaid = document.getElementById(paid);
            
            if ((docpvid != null) || (docpaid != null)) {
                docpvid.value = removeTrailingZeroes(docpvid.value);
                docpaid.value = removeTrailingZeroes(docpaid.value);

                var presentvalue = parseFloat(docpvid.value);
                var percentagepa = parseFloat(docpaid.value);

                var yrstoAccumulate = 0;
                if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
                    yrstoAccumulate = parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value);
                }
                
                
                if (!(isNaN(percentagepa)) && (!(isNaN(presentvalue)))) {
                    var step1 = (1 + (percentagepa / 100));
                    //  alert('step1-' + step1);
                    var step2 = Math.pow(step1, yrstoAccumulate);
                    // alert('step2-' + step2);
                    var step3 = step2 * presentvalue;
                    // alert('step3-' + step3);
                    sum += step3;
                }
            }
        }
        document.getElementById('<%= existingAssets.ClientID %>').value = Math.round(sum * 100) / 100;
        calculateAmountNeededFutureValue();

    }

    function calculateOptions() {

        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            futureValue = parseFloat(document.getElementById('<%= futureValue.ClientID %>').value);
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
            exitingAssets = parseFloat(document.getElementById('<%= existingAssets.ClientID %>').value);
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            maturityValue = parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value);
        }

        var shortFall = (exitingAssets + maturityValue) - futureValue;
        
        var yrstoAccumulate = 0;

        if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
            yrstoAccumulate=parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value);
        }

        var moduleName = 1;
        calculateSavingOptions(shortFall, yrstoAccumulate, moduleName);
        graph.update([regularSumValue1, regularSumValue2, regularSumValue3, regularSumValue4]);
        graph2.update([lumpSumValue1, lumpSumValue2, lumpSumValue3, lumpSumValue4]);

    }

    function onEdit(selectedrowindex) {
        document.getElementById('<%=savinggoalid.ClientID %>').value = selectedrowindex;
        document.getElementById('<%=saveclicked.ClientID %>').value = "0";
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
    }

    function onDelete(selectedrowindex) {
        var response = confirm("Are you sure you want to delete the Saving Goal?");
        if (response == true) {
            document.getElementById('<%=savinggoalid.ClientID %>').value = selectedrowindex;
            document.getElementById('<%=saveclicked.ClientID %>').value = "0";
            document.getElementById('<%=addclicked.ClientID %>').value = "0";
            document.getElementById('<%=delclicked.ClientID %>').value = "1";
        }
        else {
            return false;
        }
    }

    function onSave() {
        calculateAmountNeededFutureValue();

        document.getElementById('<%=saveclicked.ClientID %>').value = "1";

        var addVal = document.getElementById('<%=addclicked.ClientID %>').value;
        if (addVal == "1") {
            document.getElementById('<%=addandsave.ClientID %>').value = "1";
        }

        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
    }

    function onAdd() {
        document.getElementById('<%=addclicked.ClientID %>').value = "1";
        document.getElementById('<%=savinggoalid.ClientID %>').value = "";
        document.getElementById('<%=saveclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
    }

    function onNext() {
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=saveclicked.ClientID %>').value = "1";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
    }

    function onPrevious() {
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=saveclicked.ClientID %>').value = "1";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
    }

</script>

<%
    int easize = 0;
    if (ViewState["noofassets"] != null)
    {
        easize = Int32.Parse(ViewState["noofassets"].ToString());
    }
%>

<script type="text/javascript">

    var a = 0;
    var b = 0;
    var c = 0;
    var d = 0;

    var e = 0;
    var f = 0;
    var g = 0;
    var h = 0;

    var graph;

    var graph2;


    function createCanvas(divName) {

        var div = document.getElementById(divName);
        var canvas = document.createElement('canvas');
        div.appendChild(canvas);
        if (typeof G_vmlCanvasManager != 'undefined') {
            canvas = G_vmlCanvasManager.initElement(canvas);
        }

        var ctx = canvas.getContext("2d");

        return ctx;
    }

</script>

<script language="javascript" type="text/javascript">
 var count=0;

var graph;
var graph2;

 count = <%=easize %>;
 $(document).ready(function () {
    
         $('#<%=savingGoalNeeded.ClientID %>').change(function () {
            enableDisableSavingGoalFields()
        });
        enableDisableSavingGoalFields();
        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            futureValue = parseFloat(document.getElementById('<%= futureValue.ClientID %>').value);
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
            exitingAssets = parseFloat(document.getElementById('<%= existingAssets.ClientID %>').value);
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            maturityValue = parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value);
        }

        var shortFall = (exitingAssets + maturityValue) - futureValue;

        var yrstoAccumulate = 0;

        if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
            yrstoAccumulate=parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value);
        }
         
            var moduleName = 1;
            calculateSavingOptions(shortFall, yrstoAccumulate, moduleName);
            var ctx = createCanvas("graphDiv1");
            
            graph = new BarGraph(ctx);
	        graph.margin = 2;
	        graph.colors = ["#49a0d8", "#d353a0", "#ffc527", "#df4c27"];
	        graph.xAxisLabelArr = [lowest+" %", low+" %", high+" %", highest+" %"];
	        graph.update([regularSumValue1, regularSumValue2, regularSumValue3, regularSumValue4]);
            
	        ctx = createCanvas("graphDiv2");

            graph2 = new BarGraph(ctx);
	        graph2.margin = 2;
	        graph2.colors = ["#49a0d8", "#d353a0", "#ffc527", "#df4c27"];
	        graph2.xAxisLabelArr = [lowest+" %", low+" %", high+" %", highest+" %"];
	        graph2.update([lumpSumValue1, lumpSumValue2, lumpSumValue3, lumpSumValue4]);

            /*if (shortFall > 0) {
                $("#canvasTable").hide();
            }
            else
                $("#canvasTable").show();*/

 entPoints();
 
 $('#plus').click(function () {
            count+=1;
            var str = 'existingAssetrowId' + count;
            var row1 = $("<tr id='existingAssetrowId" + count + "' width=100%><td align='left'><input type='text' class='chassis_application_medium_text_box'  id='pridesc-"+count+"' name='pridesc-"+count+"'/></td><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' value=0 id='pri_"+(count)+"' name='pri_"+(count)+"' class='chassis_application_small_text_box' onblur='tempCalculate()' onkeypress = 'javascript:allowOnlyNumbers(this.value)'/></td><td align='left'><input type='text' value=0 id='sec_"+(count)+"' name='sec_"+(count)+"' class='chassis_application_small_text_box' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='tempCalculate()'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
            $("#existingAssetTable").append(row1);
            $("#existingAssetTable >tbody > tr:last").focusin();

            document.getElementById('<%= noofmembers.ClientID %>').value = count;

    });

    $('#existingsgtoggle').click(function () {
        var visibility = $('#existingsgspan').css('visibility');
        if(visibility == 'visible'){
            $('#existingsgspan').css({visibility:"hidden"});
            $('#existingsgspan').hide();
        }else{
            $('#existingsgspan').css({visibility:"visible"});
            $('#existingsgspan').show();
        }
    });
    
    

 });

 $(function () {
            $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
            $('#InvestmentGoals').addClass("chassis_application_navigation_selected_tab1");

            var sgclass = $('#<%=savinggoaltab.ClientID %>').attr("class");
            var rgclass = $('#<%=retirementgoaltab.ClientID %>').attr("class");
            var egclass = $('#<%=educationgoaltab.ClientID %>').attr("class");

            if((sgclass == 'chassis_application_page_complete') && (rgclass == 'chassis_application_page_complete') && (egclass == 'chassis_application_page_complete')){
                $("#investmentgoalstab").addClass("chassis_application_page_complete");    
            }else{
                if((sgclass == 'chassis_application_page_warnings') || (rgclass == 'chassis_application_page_warnings') || (egclass == 'chassis_application_page_warnings')){
                    $("#investmentgoalstab").addClass("chassis_application_page_warnings");
                }
            }
});

 

</script>
<script language="javascript" type="text/javascript">
    var countForPlotting = 0;

    var countForPlottingBar = 0;

    var inter;
    var inter1;
    var inter4;

    var points = {

        linePoint: []

    };


    var barPoints = {

        barPoint: []

    }

    var startpointx = 9;
    var startpointy = 220;
    var endPoint = 375;

    var barStartpointy = 220;
    var barX = 410;
    var barYMaximum = 30;

    function Point(x, y) {

        this.x = x;

        this.y = y;

    }

    function entPoints() {

        for (i = 0; i < 370; i++) {

            var x = startpointx;
            x = x + i + 10;

            var t = x / 73;
            var y = (startpointy + 1) - Math.exp(t);
            points.linePoint.push(new Point(x, y));
        }

        for (i = barStartpointy; i >= barYMaximum; i--) {

            barPoints.barPoint.push(new Point(barX, i));

        }


        inter = setInterval("drawPoints()", 10);
        inter1 = setInterval("drawBarChart()", 10);
        inter4 = setInterval("writeTextOnCanvas()", 10);

    }

    var textStatus = "false"
    function writeTextOnCanvas() {
        if (textStatus == "false") {
            canvas = document.getElementById('ex1');
            context = canvas.getContext("2d");
            context.font = "bold 10px verdana";
            
            var futureValue = 0;
            if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
                futureValue = Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value)*100)/100;
            }

            var exitingAssets = 0;
            if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
                exitingAssets = Math.round(document.getElementById('<%= existingAssets.ClientID %>').value);
            }

            var maturityValue = 0;
            if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
                maturityValue = Math.round(document.getElementById('<%= maturityValue.ClientID %>').value);
            }

            var existingValue = Math.round(parseFloat(exitingAssets) + parseFloat(maturityValue));


            context.fillText("Amount Needed Future Value $" + futureValue, 210, 20);

            var yearsToAccumulateForChart = 0;
            if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
                yearsToAccumulateForChart = Math.round(parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value));
            }

            var shortFallSurplusForChart = futureValue - existingValue;
            var shortFallOrSurplusText="Shortfall"
            if (shortFallSurplusForChart <= 0)
                shortFallOrSurplusText="Surplus"

            context.font = "bold 11px verdana";

            context.fillText("Number of Years: " + yearsToAccumulateForChart, 120, 260);

            context.fillText("Your " + shortFallOrSurplusText + " is: $" + Math.abs(shortFallSurplusForChart), 120, 280);

            context.beginPath();
            context.lineWidth = 2;
            context.moveTo(5, 245);
            context.lineTo(425, 245);
            context.strokeStyle = 'black';
            context.stroke();



            textStatus = "true";
        }
    }

    var show_very_low_value_asset = "true";

    function drawBarChart() {

        var yearsToAccumulate = 0;
        if (!isNaN(document.getElementById('<%= yrstoAccumulate.ClientID %>').value) && document.getElementById('<%= yrstoAccumulate.ClientID %>').value != "") {
            yearsToAccumulate = Math.round(parseFloat(document.getElementById('<%= yrstoAccumulate.ClientID %>').value));
        }

        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            futureValue = Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value));
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssets.ClientID %>').value) && document.getElementById('<%= existingAssets.ClientID %>').value != "") {
            exitingAssets = document.getElementById('<%= existingAssets.ClientID %>').value;
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            maturityValue = document.getElementById('<%= maturityValue.ClientID %>').value;
        }

        var existingValue = Math.round(parseFloat(exitingAssets) + parseFloat(maturityValue));
        var existingValue_toshow = Math.round((parseFloat(exitingAssets) + parseFloat(maturityValue))*100)/100;
        

        var limit = 0
        if (existingValue < futureValue)
            limit = (existingValue / futureValue) * 100;
        else
            limit = 100;
        
        var cutoff = Math.round(220 - ((limit * 190) / 100));

        if (show_very_low_value_asset == "true") {
            if (cutoff == 220) {
                context.font = "bold 9px verdana";
                context.fillText("Existing Assets $" + existingValue_toshow, 240, 219);
                show_very_low_value_asset = "false"
            }
        }

        var calculatedLimit = 220 - cutoff;

        

        canvas = document.getElementById('ex1');

        context = canvas.getContext("2d");

        context.strokeStyle = "#475B7E";
        context.lineWidth = 20;
        context.beginPath();
        
        if (countForPlottingBar == 189) {
            clearInterval(inter1);
        }


        if (countForPlottingBar < 235) {

            if (countForPlottingBar == 0) {
                context.moveTo(barX, barStartpointy);
            }
            else {
                context.moveTo(barPoints.barPoint[countForPlottingBar].x, barPoints.barPoint[countForPlottingBar].y);
            }

           
            if (countForPlottingBar == (calculatedLimit-1)) {
                context.font = "bold 9px verdana";
                context.fillText("Existing Assets $" + existingValue_toshow, barPoints.barPoint[countForPlottingBar + 1].x - 200, barPoints.barPoint[countForPlottingBar + 1].y);
            }

            context.lineTo(barPoints.barPoint[countForPlottingBar + 1].x, barPoints.barPoint[countForPlottingBar + 1].y);
            

            if (countForPlottingBar > calculatedLimit) {
                
                context.strokeStyle = "#FF4500";
            }

            context.stroke();
            
            countForPlottingBar = countForPlottingBar+1;
        }

        
    }

    function drawPoints() {

        canvas = document.getElementById('ex1');

        context = canvas.getContext("2d");

        context.strokeStyle = "#475B7E";
        if (countForPlotting < endPoint - 20) {
            context.lineWidth = (countForPlotting + 5) * 3 * .015;

            context.beginPath();

            if (countForPlotting == 0) {

                context.moveTo(startpointx, startpointy);

            } else {

                context.moveTo(points.linePoint[countForPlotting - 1].x, points.linePoint[countForPlotting - 1].y);

            }

            context.lineTo(points.linePoint[countForPlotting].x, points.linePoint[countForPlotting].y);

            context.stroke();

            countForPlotting++;


        }
        if (countForPlotting >= (endPoint - 20) && countForPlotting < endPoint) {
            if (countForPlotting == (endPoint - 20)) {
                lineWidth = (countForPlotting + 5) * 3 * .04;
            }
            lineWidth = lineWidth - 3;
            if (lineWidth < 0) {
                context.lineWidth = 0;
            }
            else
                context.lineWidth = lineWidth;
            context.beginPath();
            context.moveTo(points.linePoint[countForPlotting - 1].x,
            points.linePoint[countForPlotting - 1].y);
            context.lineTo(points.linePoint[countForPlotting].x, points.linePoint[countForPlotting].y);
            if (lineWidth >= 0) {
                context.stroke();
            }
            countForPlotting++;
            if (lineWidth < 0) {
                countForPlotting = endPoint;
            }
        }

        if (countForPlotting == endPoint) {

            clearInterval(inter);

        }


        if (countForPlotting == endPoint) {

            clearInterval(inter);

        }
    }

    function enableDisableSavingGoalFields() {

        var sgNeededSel = $('#<%=savingGoalNeeded.ClientID %> input:checked').val();

        if (sgNeededSel == "2") {
            $('[id$=addsggoal]').attr('disabled', false);
            $('[id$=addsggoal]').show();

            $("#sgaddTbl :input").attr("disabled", false);

            $('#existingAssetTblHeading').show();
            $('#existingAssetTbl').show();

            $('#sgDynamicChart').css("display", "block");

            $('#goalsAddedHeading').show();
            $('#existingsgtoggle').show();
            
            $('#existingsgspan').css({ visibility: "visible" });
            $('#existingsgspan').show();
        }
        else if (sgNeededSel == "1" || sgNeededSel == "0") {
            $('[id$=addsggoal]').attr('disabled', true);
            $('[id$=addsggoal]').hide();

            $("#sgaddTbl :input").attr("disabled", true);

            $('#existingAssetTblHeading').hide();
            $('#existingAssetTbl').hide();

            $('#sgDynamicChart').css("display", "none");

            $('#goalsAddedHeading').hide(); 
            $('#existingsgtoggle').hide();
            
            $('#existingsgspan').css({ visibility: "hidden" });
            $('#existingsgspan').hide();
        }

    }

</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<asp:HiddenField ID="addclicked" runat="server" />
<asp:HiddenField ID="popupclose" runat="server" />
<asp:HiddenField ID="saveclicked" runat="server" />
<asp:HiddenField ID="delclicked" runat="server" />
<asp:HiddenField ID="savinggoalid" runat="server" />
<asp:HiddenField ID="noofmembers" runat="server" />
<asp:HiddenField ID="printpage" runat="server" />
<asp:HiddenField ID="caseidsg" runat="server" />
<asp:HiddenField ID="activityId" runat="server" />
<asp:HiddenField ID="addandsave" runat="server" />
<asp:HiddenField ID="backToCase" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
   <FNAMenutag:FNAMenu runat="server" id="FNAMenu1" />
   <div class="chassis_application_navigation_container">
    <ul>
    <li class="chassis_application_navigation_selected_tab2">
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span id="savinggoaltab" runat="server">
                <asp:LinkButton ID="LinkSavingGoals" Text="Saving Goals" OnClientClick="onSave()" OnClick="menuClick" CommandArgument="savingGoals" runat="server" />
            </span>
        </div>
        </div>
    </li>
    <li>
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span id="retirementgoaltab" runat="server">
                <asp:LinkButton ID="LinkButtonRetirementGoals" Text="Retirement Goals" OnClientClick="onSave()" OnClick="menuClick" CommandArgument="retirementGoals" runat="server" />
            </span>
        </div>
        </div>
    </li>
    <li>
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span id="educationgoaltab" runat="server">
                <asp:LinkButton ID="LinkButtonEducationalGoals" Text="Education Goals" OnClientClick="onSave()" OnClick="menuClick" CommandArgument="educationGoals" runat="server" />
            </span>
        </div>
        </div>
    </li>
    </ul>
</div>
<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">

<table class="chassis_single_column_list" summary="Error Details">
    <tr>
        <td>
            <asp:Label ID="lblSavingGoalSuccess" runat="server" class="chassis_application_save_success"
                Text="• Saving Goal saved successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblSavingGoalFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to save Saving Goal" Visible = "false"></asp:Label>
            <asp:Label ID="lblSavingGoalDelSuccess" runat="server" class="chassis_application_save_success"
                Text="• Saving Goal deleted successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblSavingGoalDelFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to delete Saving Goal" Visible = "false"></asp:Label>
            <asp:Label ID="lblStatusSubmitted" runat="server" class="chassis_application_save_success"
                Text="• Case Status submitted successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to Submit Case Status" Visible = "false"></asp:Label>                
        </td>
    </tr>
</table>

<table class="chassis_four_column_list" summary="Adviser details">
    <thead>
        <tr>
            <td colspan="2">Savings</td>
        </tr>
     </thead>
</table>

<table class="chassis_two_column_list">
        <tbody>
         <tr>
            <td class="chassis_label_column">Do you require planning for this need?</td>
            <td class="chassis_data_column">
                <asp:radiobuttonlist id="savingGoalNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                    <asp:listitem id="savingGoalNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                    <asp:listitem id="savingGoalNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                    <asp:listitem id="savingGoalNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                </asp:radiobuttonlist>
            </td>
         </tr>
         <tr>
            <td colspan="2">
                <asp:Button ID="addsggoal" runat="server" Text="Add Goal" OnClientClick="onAdd()" class="chassis_application_button_medium" />
            </td>
         </tr>
         
         </tbody>
</table>
 
 <table class="chassis_two_column_list" id="sgaddTbl">        
         <tbody>
         <tr>
            <td width="49%">

            <table width="100%">
                         <tr>
                            <td class="chassis_label_column">Goal</td>
                            <td class="chassis_data_column">&nbsp;<asp:TextBox ID="goal" Width="205px" runat="server" CssClass="chassis_application_large_text_box"></asp:TextBox>
                            </td>
                            </tr>
                            <tr>
                            <td class="chassis_label_column">Years To Accumulate</td>
                            <td class="chassis_data_column">&nbsp;<asp:TextBox ID="yrstoAccumulate" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>yrs
                            </td>
                           </tr>
                </table>

                <table width="100%">
                         <tr style="background-color:#DDDDDD;" >
                            <td class="chassis_label_column"><b>Amount Needed (Future Value)</b></td>
                            <td class="chassis_data_column">S$<asp:TextBox ID="futureValue" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox></td>
                         </tr>
                         <tr><td colspan="2">&nbsp;</td></tr>
                         
                </table>

                <table width="100%">
                        <tr id="existingAssetTblHeading">
                        <td colspan="2">
                            <a href="#" id="plus"><img alt="" style='width:15px;height:15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a>&nbsp;<asp:LinkButton ID="eaAssetLiability" runat="server" >Existing Assets</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S$<asp:TextBox ID="existingAssets" runat="server" BackColor="#E0E0E0" CssClass="chassis_application_small_text_box"></asp:TextBox>
                        </td>
                        </tr>
                        <tr><td colspan="2">&nbsp;</td></tr>
                         <tr id="existingAssetTbl">
                           <td colspan="2">
                                    
                            <table width="100%" id="existingAssetTable">
                                <tr class="table_header">
                                    <td align="center" width="34%">
                                    Asset
                                    </td>
                                    <td align="center" width="33%">
                                    Present Value
                                    </td>
                                    <td align="center" width="33%">
                                    % p.a
                                    </td>
                                </tr>
                                <asp:Repeater ID="assetList" runat="server">
                                    <ItemTemplate>
                                        <tr id='existingAssetrowId<%# (Container.ItemIndex+1)%>'>
                                            <td>
                                                <input type='text' class="chassis_application_medium_text_box" id='pridesc-<%# (Container.ItemIndex+1)%>' name='pridesc-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;&nbsp;<input type='text' value='<%# Eval("presentvalue") %>' id='pri_<%# (Container.ItemIndex+1)%>' name='pri_<%# (Container.ItemIndex+1)%>' class="chassis_application_small_text_box" onblur='tempCalculate()' onkeypress = "javascript:allowOnlyNumbers(this.value)"/>
                                            </td>
                                            <td>
                                                <input type='text' value='<%# Eval("percentpa") %>' id='sec_<%# (Container.ItemIndex+1)%>' name='sec_<%# (Container.ItemIndex+1)%>' class="chassis_application_small_text_box" onblur='tempCalculate()' onkeypress = "javascript:allowOnlyNumbers(this.value)"/>&nbsp;&nbsp;<a onclick="DeleteRow('existingAssetrowId<%# (Container.ItemIndex+1)%>')"><img alt="" style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                            </td>                                                           
                                            </tr>       
                                
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                            
                            </td>
                           </tr>
                           <tr><td colspan="2">&nbsp;</td></tr>
                           <tr>
                            <td class="chassis_label_column"><asp:LinkButton ID="mvalueLink" runat="server">Projected Value of Existing Insurance Policies</asp:LinkButton></td>
                            <td class="chassis_data_column">S$<asp:TextBox ID="maturityValue" runat="server" Text="" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>
                            </td>
                            </tr>
                </table>

                <table width="100%">
                         <tr style="background-color:#DDDDDD;" >
                                <td class="chassis_label_column"><span id="surplus_shortfall_family_needs" style="font-weight:bold"><asp:Label ID="ttlSS" runat="server" Text="Shortfall/Surplus" Font-Bold="true" /></span></td>
                                <td class="chassis_data_column">S$<asp:TextBox ID="totalShortfallSurplus" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0"></asp:TextBox></td>
                             </tr>
                </table>
                


            </td>
            <td width="2%">&nbsp;</td>
            <td width="49%">

            <table width="100%" cellpadding="2">
                     
                     <tr>
                        <td valign="top">
                            <fieldset style="width:425px;">
                                <legend> Saving Goals</legend>
                    <canvas id="ex1" width="610px" height="290px" 
		                           style="solid #cccccc;position:absolute;z-index:0;">
		                    HTML5 Canvas not supported
                    </canvas>
                    <div style="background-image:url(/_layouts/Zurich/images/saving_goals_canvas.jpg); background-repeat:no-repeat;">
                    <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                           </div>
                            <br />
                            <br />
                    <img src="/_layouts/Zurich/images/Content/Legend.png" alt=""/>
             </fieldset>
                        </td> 
                    </tr>
     
                </table>

            </td>
        </tr>
    </tbody>
</table>
<br/>
<table>
    <tr>
        <td style="width:20px;height:20px;">
        &nbsp;&nbsp;
        </td>
    </tr>
</table>
<fieldset style = "width:97%" id="sgDynamicChart">
<table width="100%" id="canvasTable">
<tr>
    <td colspan=5>
        <span id="canvasText" style="font-weight:bold"></span>
    </td>
</tr>
<tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td align="center"><b>Regular Sum ($)</b></td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td align="center"> <b>LumpSum ($)</b></td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
	<tr>
			<td style="width:150px;">&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>
				<div id="graphDiv1"></div>					
			</td>
			<td style="width:125px;">&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td> 
				<div id="graphDiv2"></div>
			</td>
            <td style="width:150px;">&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>

</table>
</fieldset>



<table class="chassis_two_column_list">
 <thead id="goalsAddedHeading">
        <tr>
            <td colspan="2"><a href="#" id="existingsgtoggle">&gt;</a>&nbsp;Saving Goals Added</td>
        </tr>
 </thead>
 <tbody>
         <tr><td colspan="2">&nbsp;</td></tr>
         <tr>
            <td colspan="2" align="center">
            <span id="existingsgspan" style="visibility:visible;">
            <asp:DataGrid ID="existingsggrid" runat="server" AutoGenerateColumns="false" Width="100%">
                <Columns>
                    <asp:TemplateColumn HeaderText="Id" Visible="false" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "id") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Goal" ItemStyle-Width="15%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblgoal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "goal") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Years to Accumulate" ItemStyle-Width="10%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblyrstoaccumulate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "yrstoaccumulate") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Amount Needed Future Value" ItemStyle-Width="15%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblamtneededfv" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "amtneededfv") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Maturity Value" ItemStyle-Width="15%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblmaturityvalue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "maturityvalue") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Existing Assets" ItemStyle-Width="15%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbleattlvalue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "existingassetstotal") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Total (Shortfall/Surplus)" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbltotal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "total") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Edit" ItemStyle-Width="5%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="editbtn" runat="server" Text="Edit" OnClientClick='<%#String.Format("onEdit({0})", DataBinder.Eval(Container.DataItem, "id"))%>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Delete" ItemStyle-Width="5%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="delbtn" runat="server" Text="Delete" OnClientClick='<%#String.Format("return onDelete({0})", DataBinder.Eval(Container.DataItem, "id"))%>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            </span>
            </td>
        </tr>
         <tr><td colspan="2">&nbsp;</td></tr>
 </tbody>
 </table>

<table class="chassis_two_column_list">
    <tbody>
        <tr>
        <td colspan="3">
        <table width="100%">
            <tr align="right">
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Generate PDF" OnClientClick="onSave()" OnClick="createSavingGoalsPdf" class="chassis_application_button_xxxlarge" />
                    <asp:Button ID="Button4" runat="server" Text="Previous" OnClientClick="onPrevious()" OnClick="submitToPreviousGoal" class="chassis_application_button_medium" />
                    <asp:Button ID="Button3" runat="server" Text="Save" OnClientClick="onSave()" OnClick="submitSavingGoals" class="chassis_application_button_medium" />
                    <asp:Button ID="Button2" runat="server" Text="Next" OnClientClick="onNext()" OnClick="submitSavingGoalsNext" class="chassis_application_button_medium" />
                    <asp:Button ID="Button5" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>

                </td>
            
            </tr>
        </table>
        </td>
        </tr>

    </tbody>
</table>



</div>
</div>
</div>
</div>

</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Saving Goals
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Saving Goals
</asp:Content>
