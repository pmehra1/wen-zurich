<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowEducationGoals.aspx.cs" Inherits="Zurich.Layouts.Zurich.EducationGoals.ShowEducationGoals" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
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
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/savingOptions.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/savingOptionJs/html5-canvas-bar-graph.js"></script>
<script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>

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

    function calculateOptions() {

        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            futureValue = parseFloat(document.getElementById('<%= futureValue.ClientID %>').value);
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value != "") {
            exitingAssets = parseFloat(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value);
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            maturityValue = parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value);
        }

        var shortFall = (exitingAssets + maturityValue) - futureValue;
       
        var yrstoAccumulate = 0;

        if (!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value != "") {
            yrstoAccumulate = parseFloat(document.getElementById('<%= yrsToSave.ClientID %>').value);
        }

        var moduleName = 3;

        calculateSavingOptions(shortFall, yrstoAccumulate, moduleName);
        graph.update([regularSumValue1, regularSumValue2, regularSumValue3, regularSumValue4]);
        graph2.update([lumpSumValue1, lumpSumValue2, lumpSumValue3, lumpSumValue4]);

    }
    
</script>

<script language="javascript" type="text/javascript">
    var countForPlotting = 0;
    var points = {

        linePoint: []

    };


    var barPoints = {

        barPoint: []

    };


    var startpointx = 150;
    var startpointy = 200;
    var lastPoint = 235;
    var inter;
    var inter1;
    var inter2;
    function Point(x, y) {

        this.x = x;

        this.y = y;

    }

    function entPoints() {

        for (i = 0; i < 235; i++) {

            var x = startpointx;
            x = x + i + 10;

            var t = x / 75;

            var y = (startpointy + 1) - Math.exp(t);



            points.linePoint.push(new Point(x, y));

        }

        for (i = barStartpointy; i > barYMaximum; i--) {

            barPoints.barPoint.push(new Point(barX, i));

        }


        inter = setInterval("drawPoints()", 10);
        inter1 = setInterval("drawBarChart()", 10);
        inter2 = setInterval("writeTextOnCanvas()", 10);

    }

    
    var textStatus = "false"
    function writeTextOnCanvas() {
        if (textStatus == "false") {


            var futureValue = 0;
            if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
                futureValue = parseFloat(document.getElementById('<%= futureValue.ClientID %>').value);
            }

            var exitingAssets = 0;
            if (!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value != "") {
                exitingAssets = document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value;
            }

            var maturityValue = 0;
            if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
                maturityValue = document.getElementById('<%= maturityValue.ClientID %>').value;
            }
            var shortfall = Math.round(((parseFloat(exitingAssets) + parseFloat(maturityValue)) - parseFloat(futureValue))*100)/100;
            
            var existingValue = Math.round((parseFloat(exitingAssets) + parseFloat(maturityValue))*100)/100;


            var yrsToSave = 0;
            if (!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value != "") {
                yrsToSave = Math.round(document.getElementById('<%= yrsToSave.ClientID %>').value);
            }

            var inflationRateForChart = 0;
            if (!isNaN(document.getElementById('<%= inflationRate.ClientID %>').value) && document.getElementById('<%= inflationRate.ClientID %>').value != "") {
                inflationRateForChart = Math.round(document.getElementById('<%= inflationRate.ClientID %>').value);
            }

            var currentAgeForChart = 0;
            if (!isNaN(document.getElementById('<%= currentAge.ClientID %>').value) && document.getElementById('<%= currentAge.ClientID %>').value != "") {
                currentAgeForChart = Math.round(document.getElementById('<%= currentAge.ClientID %>').value);
            }

            var ageWhenFundsNeededForChart = 0;
            if (!isNaN(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value) && document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value != "") {
                ageWhenFundsNeededForChart = Math.round(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value);
            }


            var futureCostChartValue = 0;
            if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
                futureCostChartValue = Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value)*100)/100;
            }

            var presentCostChartValue = 0;
            if (!isNaN(document.getElementById('<%= costEducation.ClientID %>').value) && document.getElementById('<%= costEducation.ClientID %>').value != "") {
                presentCostChartValue = Math.round(parseFloat(document.getElementById('<%= costEducation.ClientID %>').value)*100)/100;
            }
            

            context = canvas.getContext("2d");
            
            context.font = "bold 10px verdana";
            
            context.fillText("Inflation Rate : " + inflationRateForChart + "%", 110, 120);

            context.fillText("Child's Current Age : " + currentAgeForChart, 50, 220);

            context.fillText("Future Cost : $" + futureCostChartValue, 300, 30);

            context.fillText("Present Cost : $" + presentCostChartValue, 70, 180);

            context.fillText("Age when funds needed ", 280, 220);
            context.fillText(ageWhenFundsNeededForChart, 370, 230);

            var shortFallSurplus = "Shortfall";

            if (shortfall >= 0)
                shortFallSurplus = "Surplus";

            context.font = "bold 11px verdana";
            context.fillText("Number of Years : " + yrsToSave, 160, 250);
            context.fillText("Your " + shortFallSurplus + " is : $" + Math.abs(shortfall), 160, 265)
            textStatus = "true";
        }
    }


    var lineWidth = 0;
    var barStartpointy = 200;
    var barX = 410;
    var barYMaximum = 30;
    var countForPlottingBar = 0;

    var printed_value = "false";
    var print_value = "false";
    function drawBarChart() {

        canvas = document.getElementById('ex1');

        context = canvas.getContext("2d");

        context.strokeStyle = "#475B7E";
        context.lineWidth = 20;
        context.beginPath();

        var futureValue = 0;
        if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
            futureValue = Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value));
        }

        var exitingAssets = 0;
        var exitingAssets1 = 0;
        if (!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value != "") {
            exitingAssets = Math.round(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value);
            exitingAssets1 = document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value;
        }

        var maturityValue = 0;
        var maturityValue1 = 0;

        if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
            maturityValue = Math.round(document.getElementById('<%= maturityValue.ClientID %>').value);
            maturityValue1 = document.getElementById('<%= maturityValue.ClientID %>').value;
        }

        var existingValue = Math.round(parseFloat(exitingAssets) + parseFloat(maturityValue));
        var existingValue1 = Math.round((parseFloat(exitingAssets1) + parseFloat(maturityValue1))*100)/100;
        var limit = 0;
        if (existingValue < futureValue)
            limit = (existingValue / futureValue) * 100;
        else
            limit = 100;


        var cutoff = 200 - ((limit * 170) / 100);


        if (countForPlottingBar == 0) {
            context.moveTo(barX, barStartpointy);
        }
        else {
            context.moveTo(barPoints.barPoint[countForPlottingBar].x, barPoints.barPoint[countForPlottingBar].y);
        }


        if (existingValue >= futureValue) {
            if (print_value == "false") {
                context.font = "bold 9px verdana";
                context.fillText("Existing Assets $" + existingValue1, 200, 50);
            }
            print_value = "true";
        }

        if (countForPlottingBar >= 169)
            clearInterval(inter1);

        context.lineTo(barPoints.barPoint[countForPlottingBar + 1].x, barPoints.barPoint[countForPlottingBar + 1].y);
        if (countForPlottingBar > (200 - cutoff)) {
            context.strokeStyle = "#FF4500";
            if (printed_value == "false") {
                context.font = "bold 9px verdana";

                if (existingValue < futureValue) {
                    context.fillText("Existing Assets $" + existingValue1, (barPoints.barPoint[countForPlottingBar + 1].x - 200), barPoints.barPoint[countForPlottingBar + 1].y);
                }
                
                printed_value = "true";
            }
        }

        context.stroke();
        countForPlottingBar++;
     
    }





    function drawPoints() {
        canvas = document.getElementById('ex1');

        context = canvas.getContext("2d");

        context.strokeStyle = "#475B7E";
        if (countForPlotting < lastPoint - 20) {


            context.lineWidth = (countForPlotting + 5) * 3 * .015;

            context.beginPath();

            if (countForPlotting == 0) {

                //context.moveTo(startpointx, startpointy);

            } else {

                context.moveTo(points.linePoint[countForPlotting - 1].x,

                 points.linePoint[countForPlotting - 1].y);

            }

            context.lineTo(points.linePoint[countForPlotting].x, points.linePoint[countForPlotting].y);

            context.stroke();

            countForPlotting++;

        }
        if (countForPlotting >= lastPoint - 20 && countForPlotting < lastPoint) {

            if (countForPlotting == lastPoint - 20) {
                lineWidth = (countForPlotting + 5) * 3 * .04;
            }
            lineWidth = lineWidth - 3;
            if (lineWidth < 0) {
                context.lineWidth = 0;
            }
            else
                context.lineWidth = lineWidth;
            context.beginPath();
            context.moveTo(points.linePoint[countForPlotting - 1].x, points.linePoint[countForPlotting - 1].y);
            context.lineTo(points.linePoint[countForPlotting].x, points.linePoint[countForPlotting].y);
            if (lineWidth >= 0) {
                context.stroke();
            }
            countForPlotting++;
            if (lineWidth < 0) {
                countForPlotting = lastPoint;
            }
        }

        if (countForPlotting == lastPoint) {

            clearInterval(inter);

        }
    }

</script>
<%
    int easize = 0;
    if (ViewState["noofassets"] != null)
    {
        easize = Int32.Parse(ViewState["noofassets"].ToString());
    }
    
%>
<script language="javascript" type="text/javascript">

  var count=0;
 count = <%=easize %>;

 var graph;

 var graph2;

    $(document).ready(function () {
    
    $('#<%=educationGoalNeeded.ClientID %>').change(function () {
             enableDisableEducationGoalFields()
    });

    enableDisableEducationGoalFields();
    
    var futureValue = 0;
    if (!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value != "") {
        futureValue = parseFloat(document.getElementById('<%= futureValue.ClientID %>').value);
    }

    var exitingAssets = 0;
    if (!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value != "") {
        exitingAssets = parseFloat(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value);
    }

    var maturityValue = 0;
    if (!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value != "") {
        maturityValue = parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value);
    }

    var shortFall = (exitingAssets + maturityValue) - futureValue;

    var yrstoAccumulate = 0;

    if (!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value != "") {
        yrstoAccumulate=parseFloat(document.getElementById('<%= yrsToSave.ClientID %>').value);
    }
         
    var moduleName = 3;
    
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
    
    entPoints();
        
        $('#plus').click(function () {
             count+=1;
             var str = 'existingAssetsrowId' + count;
             var row1 = $("<tr id='existingAssetsrowId" + count + "' width=100%><td align='left'><input type='text' class='chassis_application_medium_text_box' id='pri-" + count + "' name='pri-" + count + "'/></td><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' value=0 id='pri_" + (count) + "' name='pri_" + (count) + "' class='chassis_application_small_text_box' onblur='tempCalculate()' onkeypress = 'javascript:allowOnlyNumbers(this.value)'/></td><td align='left'><input type='text' value=0 id='sec_" + (count) + "' name='sec_" + (count) + "' class='chassis_application_small_text_box' onblur='tempCalculate()' onkeypress = 'javascript:allowOnlyNumbers(this.value)'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
             $("#existingAssets").append(row1);
             $("#existingAssets >tbody > tr:last").focusin();

             document.getElementById('<%= noofmembers.ClientID %>').value = count;
         });

         $('#existingegtoggle').click(function () {
            var visibility = $('#existingegspan').css('visibility');
            if(visibility == 'visible'){
                $('#existingegspan').css({visibility:"hidden"});
                $('#existingegspan').hide();
            }else{
                $('#existingegspan').css({visibility:"visible"});
                $('#existingegspan').show();
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

    function onBackToCase() {
        onSave();
        var response = confirm("Do you want to save the changes to PDF before Back to the Case?");
        if (response == true) {
            document.getElementById('<%=backToCase.ClientID %>').value = true;
        }
        else {
            document.getElementById('<%=backToCase.ClientID %>').value = false;
        }
    }

    function tempCalculate() {

    // count = $("#existingAssetTable >tbody > tr").size();
    var presentvalueid = 'pri_';
    var percentagevalueid = 'sec_';
    var sum=0;
    for (var i = 1; i <= count; i++) {
        var pvid = presentvalueid + (i);
        var paid = percentagevalueid + (i);
        if ((document.getElementById(pvid) != null) || (document.getElementById(paid) != null)) {
            document.getElementById(pvid).value = removeTrailingZeroes(document.getElementById(pvid).value);
            document.getElementById(paid).value = removeTrailingZeroes(document.getElementById(paid).value);

            var presentvalue = parseFloat(document.getElementById(pvid).value);
            var percentagepa = parseFloat(document.getElementById(paid).value);
           
            var yrstoAccumulate = 0;
           if(!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value!=""){
            yrstoAccumulate = parseFloat(document.getElementById('<%= yrsToSave.ClientID %>').value);
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
    document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value = Math.round(sum * 100) / 100;
    calculateAmountNeededFutureValue();

    }

    function DeleteRow(param) {
        var answer = confirm("Delete Existing Assets ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
            tempCalculate();
            calculateAmountNeededFutureValue();
        }
    }
     function popupshowfactfindassets(url) {
         newwindow = window.open(url, 'name', 'height=500,width=1000,scrollbars=1');
         if (window.focus) { newwindow.focus() }
         return false;
     }

     function popupshowcountrycost(url) {
         newwindow = window.open(url, 'name', 'height=500,width=700,scrollbars=1');
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
         document.getElementById('<%= countrySelChanged.ClientID %>').value = '';

         document.forms[0].submit();
     };

      window.popUpEditEducationGoalClosed = function () {
        var educationgoalid = document.getElementById('<%= educationgoalid.ClientID %>').value;
        document.forms[0].action = '/EducationGoal/ShowEducationGoals/' + educationgoalid;
        document.forms[0].method = "get";

        document.getElementById('<%= printpage.ClientID %>').value = "false";

        //var noOfExistingAssets = $("#existingAssets >tbody > tr").size();
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;

        document.forms[0].submit();
    };

     function changepopupclosestatus() {
         document.getElementById('<%= popupclose.ClientID %>').value = '';
         document.getElementById('<%= countrySelChanged.ClientID %>').value = '';

         document.getElementById('<%= printpage.ClientID %>').value = "false";

        //var noOfExistingAssets = $("#existingAssets >tbody > tr").size();
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;

         document.forms[0].submit();
     }

     function printpg() {
        document.getElementById('<%= printpage.ClientID %>').value = "true";

        //var noOfExistingAssets = $("#existingAssets >tbody > tr").size();
        var noOfExistingAssets = count;
        document.getElementById('<%= noofmembers.ClientID %>').value = noOfExistingAssets;

        document.forms[0].submit();
    }

     function changecountryselected() {
         document.getElementById('<%= popupclose.ClientID %>').value = '';
         document.getElementById('<%= countrySelChanged.ClientID %>').value = 'true';

         document.getElementById('country').value = document.getElementById('countryList')[document.getElementById('countryList').selectedIndex].text;

         calculateAmountNeededFutureValue();

         document.forms[0].submit();
     }

     function roundOffValues(){
        if(!isNaN(document.getElementById('<%= currentAge.ClientID %>').value) && document.getElementById('<%= currentAge.ClientID %>').value!=""){
            document.getElementById('<%= currentAge.ClientID %>').value = Math.round(document.getElementById('<%= currentAge.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value) && document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value!=""){
            document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value = Math.round(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value!=""){
            document.getElementById('<%= yrsToSave.ClientID %>').value = Math.round(document.getElementById('<%= yrsToSave.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value!=""){
            document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value = Math.round(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value!=""){
            document.getElementById('<%= maturityValue.ClientID %>').value = Math.round(document.getElementById('<%= maturityValue.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value!=""){
            document.getElementById('<%= futureValue.ClientID %>').value = Math.round(document.getElementById('<%= futureValue.ClientID %>').value);
        }
     }
     
     function calculateAmountNeededFutureValue() {
        //roundOffValues();
         var currentAge = 0;
         if(!isNaN(document.getElementById('<%= currentAge.ClientID %>').value) && document.getElementById('<%= currentAge.ClientID %>').value!=""){
            document.getElementById('<%= currentAge.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= currentAge.ClientID %>').value);
            currentAge = parseInt(document.getElementById('<%= currentAge.ClientID %>').value);
         }
         
         var ageWhenFundsNeeded = 0;
         if(!isNaN(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value) && document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value!=""){
            document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value);
            ageWhenFundsNeeded = parseInt(document.getElementById('<%= ageWhenFundsNeeded.ClientID %>').value);
         }

         document.getElementById('<%= yrsToSave.ClientID %>').value = ageWhenFundsNeeded - currentAge;

         var costOfEducation = 0;
         if(!isNaN(document.getElementById('<%= costEducation.ClientID %>').value) && document.getElementById('<%= costEducation.ClientID %>').value!=""){
            document.getElementById('<%= costEducation.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= costEducation.ClientID %>').value);
            costOfEducation = fixedToZero(Math.round(parseFloat(document.getElementById('<%= costEducation.ClientID %>').value)*100)/100);
            document.getElementById('<%= costEducation.ClientID %>').value = costOfEducation;
            $('#presentCost').text(costOfEducation);
         }

         var yrsToSave = 0;
         if(!isNaN(document.getElementById('<%= yrsToSave.ClientID %>').value) && document.getElementById('<%= yrsToSave.ClientID %>').value!=""){
            document.getElementById('<%= yrsToSave.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= yrsToSave.ClientID %>').value);
            yrsToSave = parseFloat(document.getElementById('<%= yrsToSave.ClientID %>').value);
         }

         var inflationRate = 0;
         if(!isNaN(document.getElementById('<%= inflationRate.ClientID %>').value) && document.getElementById('<%= inflationRate.ClientID %>').value!=""){
            document.getElementById('<%= inflationRate.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= inflationRate.ClientID %>').value);
            inflationRate = parseFloat(document.getElementById('<%= inflationRate.ClientID %>').value);
         }
         
         document.getElementById('<%= futureValue.ClientID %>').value = fixedToZero(Math.round((costOfEducation * Math.pow((1 + (inflationRate / 100)), yrsToSave))*100)/100);
         
         var existingAssetsEducationGoals = 0;
         if(!isNaN(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value) && document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value!=""){
            document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value);
            existingAssetsEducationGoals = fixedToZero(Math.round(parseFloat(document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value)*100)/100);
            document.getElementById('<%= existingAssetsEducationGoals.ClientID %>').value = existingAssetsEducationGoals;
         }
         
         var maturityValue = 0;
         if(!isNaN(document.getElementById('<%= maturityValue.ClientID %>').value) && document.getElementById('<%= maturityValue.ClientID %>').value!=""){
            document.getElementById('<%= maturityValue.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= maturityValue.ClientID %>').value);
            maturityValue = fixedToZero(Math.round(parseFloat(document.getElementById('<%= maturityValue.ClientID %>').value)*100)/100);
            document.getElementById('<%= maturityValue.ClientID %>').value = maturityValue;
         }

         var futureValue = 0;
         if(!isNaN(document.getElementById('<%= futureValue.ClientID %>').value) && document.getElementById('<%= futureValue.ClientID %>').value!=""){
            document.getElementById('<%= futureValue.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= futureValue.ClientID %>').value);
            futureValue = fixedToZero(Math.round(parseFloat(document.getElementById('<%= futureValue.ClientID %>').value)*100)/100);
            document.getElementById('<%= futureValue.ClientID %>').value = futureValue;
         }
         
         var shortfall = fixedToZero(Math.round(((parseFloat(existingAssetsEducationGoals) + parseFloat(maturityValue)) - parseFloat(futureValue))*100)/100);
         if(!isNaN(shortfall)){
            shortfall = fixedToZero(Math.round(parseFloat(shortfall)*100)/100);
         }else{
            shortfall = fixedToZero(0);
         }
         
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
        document.getElementById('<%= totalShortfallSurplus.ClientID %>').value = Math.abs(shortfall);

        document.getElementById('<%= noofmembers.ClientID %>').value = count;

        calculateOptions();
     }

     function AddEducationGoal() {
        document.getElementById('<%= addclicked.ClientID %>').value = 'true';
        document.getElementById('<%= popupclose.ClientID %>').value = '';
        document.forms[0].submit();
    }

     function popitup(url, width, height) {
        newwindow = window.open(url, 'name', 'height=' + height + ',width=' + width + ', scrollbars=yes');
        if (window.focus) { newwindow.focus() }
        return false;
     }

     function onEdit(selectedrowindex) {
        document.getElementById('<%=educationgoalid.ClientID %>').value = selectedrowindex;
        document.getElementById('<%=saveclicked.ClientID %>').value = "0";
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
    }
     
     function onDelete(selectedrowindex) {
        var response = confirm("Are you sure you want to delete the Education Goal?");
        if(response == true){
            document.getElementById('<%=educationgoalid.ClientID %>').value = selectedrowindex;
            document.getElementById('<%=saveclicked.ClientID %>').value = "0";
            document.getElementById('<%=addclicked.ClientID %>').value = "0";
            document.getElementById('<%=delclicked.ClientID %>').value = "1";
            document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
        }else{
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
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
    }

    function onAdd() {
        document.getElementById('<%=addclicked.ClientID %>').value = "1";
        document.getElementById('<%=educationgoalid.ClientID %>').value = "";
        document.getElementById('<%=saveclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
    }

    function onNext() {
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=saveclicked.ClientID %>').value = "1";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
    }

    function onPrevious() {
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=saveclicked.ClientID %>').value = "1";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "0";
    }

    function selectedCountryChanged(){
        document.getElementById('<%=addclicked.ClientID %>').value = "0";
        document.getElementById('<%=saveclicked.ClientID %>').value = "0";
        document.getElementById('<%=delclicked.ClientID %>').value = "0";
        document.getElementById('<%=selectedcountrychanged.ClientID %>').value = "1";
        __doPostBack('countryList','');
    }

    function enableDisableEducationGoalFields() {

        var egNeededSel = $('#<%=educationGoalNeeded.ClientID %> input:checked').val();

        if (egNeededSel == "2") {
            $('[id$=addsggoal]').attr('disabled', false);
            $('[id$=addsggoal]').show();

            $("#sgaddTbl :input").attr("disabled", false);

            $('#existingAssetTblHeading').show();
            $('#existingAssetTbl').show();

            $('#sgDynamicChart').css("display", "block");

            $('#goalsAddedHeading').show();
            $('#existingegtoggle').show();
            
            $('#existingegspan').css({ visibility: "visible" });
            $('#existingegspan').show();
        }
        else if (egNeededSel == "1" || egNeededSel == "0") {
            $('[id$=addsggoal]').attr('disabled', true);
            $('[id$=addsggoal]').hide();

            $("#sgaddTbl :input").attr("disabled", true);

            $('#existingAssetTblHeading').hide();
            $('#existingAssetTbl').hide();

            $('#sgDynamicChart').css("display", "none");

            $('#goalsAddedHeading').hide(); 
            $('#existingegtoggle').hide();
            
            $('#existingegspan').css({ visibility: "hidden" });
            $('#existingegspan').hide();
        }

    }

 </script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

 <asp:HiddenField ID="popupclose" runat="server" />
 <asp:HiddenField ID="addclicked" runat="server" />
 <asp:HiddenField ID="countrySelChanged" runat="server" />
 <asp:HiddenField ID="saveclicked" runat="server" />
 <asp:HiddenField ID="delclicked" runat="server" />
 <asp:HiddenField ID="selectedcountrychanged" runat="server" />
 <asp:HiddenField ID="educationgoalid" runat="server" />
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
    <li>
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
    <li class="chassis_application_navigation_selected_tab2">
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
            <asp:Label ID="lblEducationGoalSuccess" runat="server" class="chassis_application_save_success"
                Text="• Education Goal saved successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblEducationGoalFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to save Education Goal" Visible = "false"></asp:Label>
            <asp:Label ID="lblEducationGoalDelSuccess" runat="server" class="chassis_application_save_success"
                Text="• Education Goal deleted successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblEducationGoalDelFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to delete Education Goal" Visible = "false"></asp:Label>
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
            <td colspan="2">Education Goal</td>
        </tr>
     </thead>
</table>

<table class="chassis_two_column_list">
        <tbody>
         <tr>
            <td class="chassis_label_column">Do you require planning for this need?</td>
            <td class="chassis_data_column">
                <asp:radiobuttonlist id="educationGoalNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                    <asp:listitem id="educationGoalNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                    <asp:listitem id="educationGoalNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                    <asp:listitem id="educationGoalNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                </asp:radiobuttonlist>
            </td>
         </tr>
         <tr>
            <td colspan="2">
                <asp:Button ID="addsggoal" runat="server" Text="Add Child" OnClientClick="onAdd()" class="chassis_application_button_medium" />
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
                    <td class="chassis_label_column">Name of Child</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="nameofChild" runat="server" CssClass="chassis_application_small_text_box"></asp:TextBox></td></tr>
                    <tr>
                    <td class="chassis_label_column">Current Age</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="currentAge" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>yrs old</td></tr>
                    <tr>
                    <td class="chassis_label_column">Age when Funds Needed</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="ageWhenFundsNeeded" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>yrs old</td></tr>
                    <tr>
                    <td class="chassis_label_column">Number of Years to Save</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="yrsToSave"  BackColor="#E0E0E0" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>yrs</td></tr>
                    <tr>
                    <td class="chassis_label_column">Country of Study</td>
                    <td class="chassis_data_column chassis_no_padding_right">&nbsp;&nbsp;&nbsp;
                    <asp:DropDownList ID="countryList" runat="server" CssClass="chassis_application_medium_select_list" AutoPostBack="true" OnSelectedIndexChanged="updateCountryCostofEducation" >
                    </asp:DropDownList>
                    </td>
                    </tr>
                    <tr>
                    <td class="chassis_label_column">Present Cost of Education</td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="costEducation" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox></td></tr>
                    <tr>
                    <td class="chassis_label_column">Inflation Rate of Education</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="inflationRate" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox>%</td>
                    </tr>
                    <tr style="background-color:#DDDDDD;" >
                    <td class="chassis_label_column"><b>Future Cost of Education</b></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="futureValue" runat="server" BackColor="#E0E0E0" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box"></asp:TextBox></td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                  </table>

                  <table width="100%">
                    <tr id="existingAssetTblHeading">
                    <td colspan="2">
                        <a href="#" id="plus"><img alt="" style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/add-icon.jpg' /></a>&nbsp;<asp:LinkButton ID="eaAssetLiability" runat="server">Existing Assets</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S$<asp:TextBox ID="existingAssetsEducationGoals" runat="server" BackColor="#E0E0E0" CssClass="chassis_application_small_text_box"></asp:TextBox>
                    </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr id="existingAssetTbl">
                        <td colspan="2">
                        <table width="100%" id="existingAssets">
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
                                        <td align="left">
                                            <input type='text' class="chassis_application_medium_text_box" id='pri-<%# (Container.ItemIndex+1)%>' name='pri-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                        </td>
                                        <td align="left">
                                            &nbsp;&nbsp;&nbsp;&nbsp;<input type='text' onkeypress = "javascript:allowOnlyNumbers(this.value)" class="chassis_application_small_text_box" value='<%# Eval("presentvalue") %>' id='pri_<%# (Container.ItemIndex+1)%>' name='pri_<%# (Container.ItemIndex+1)%>' style='width: 80px;' onblur='tempCalculate()'/>
                                        </td>
                                        <td align="left">
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers(this.value)" class="chassis_application_small_text_box" value='<%# Eval("percentpa") %>' id='sec_<%# (Container.ItemIndex+1)%>' name='sec_<%# (Container.ItemIndex+1)%>' style='width: 80px;' onblur='tempCalculate()'/>&nbsp;&nbsp;<a onclick="DeleteRow('existingAssetrowId<%# (Container.ItemIndex+1)%>')"><img alt="" style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                        </td>                                                           
                                        </tr>       
                                
                                </ItemTemplate>
                            </asp:Repeater>     
                        </table>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                    <td class="chassis_label_column"><asp:LinkButton ID="mvalueLink" runat="server">Maturity Value of Existing Insurance Policies</asp:LinkButton></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="maturityValue" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box" runat="server" Text=""></asp:TextBox></td>
                    </tr>
                  </table>

                  <table width="100%">
                    <tr style="background-color:#DDDDDD;" >
                    <td class="chassis_label_column"><span id="surplus_shortfall_family_needs" style="font-weight:bold"><asp:Label ID="ttlSS" runat="server" Text="Shortfall/Surplus" Font-Bold="true" /></span></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="totalShortfallSurplus" runat="server" BackColor="#E0E0E0" CssClass="chassis_application_small_text_box" Text=""></asp:TextBox></td>
                    </tr>
                    
                  </table>

            </td>
            <td width="2%">
            </td>
            <td width="49%">
            
            <table width="100%">
             <tr>
            <td valign="top">
            <fieldset style="width:425px;">
            <legend>Education Goals</legend>
            <div>
            <canvas id="ex1" width="630px" height="350px" style="solid #cccccc;position:absolute;z-index:0;">
		        HTML5 Canvas not supported
            </canvas>
            
                 <table style="background-color:'#FEEED2';background-image:url(/_layouts/Zurich/images/Content/SavingGoalChart.png); background-repeat:no-repeat;">
                    <tr>
                    <td colspan="2">
                    <table width='100%'>
            
                    <tr>
                        <td align="right"></td>
                    </tr>
                    </table>
                    </td>
                </tr>
               <tr>
                <td width="4%"></td>
                <td>
                  <br />
                <br />
                <br /> <br />
                <br />
                <br />
               
                </td>
                </tr>  
                <tr>
                <td colspan="2" height="20px;" align=left>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                    <img src="/_layouts/Zurich/images/Content/Legend.png" alt=""/>
                </td>
                </tr>      
                </table>
                </div>
                </fieldset>
                </td>
            </tr>
           </table>
           <table width="100%">
             <tr><td>&nbsp;</td></tr>
           </table>
           <table width="100%">
                <tr>
                    <td colspan=5> Average annual cost of university education  
                    </td>
                </tr>
                <tr>
                    <td colspan=5></td>
                </tr>
                <tr style="background-color:#FEDEC1;">
                    <td></td>
                    <td>Singapore </td>
                    <td> Australia</td>
                    <td> US &nbsp;&nbsp;</td>
                    <td> UK &nbsp;&nbsp; </td>
                </tr>
                <tr>
                    <td>University <br />Fees</td>
                    <td>SGD24,618</td>
                    <td>SGD31,305</td>
                    <td>SGD32,288</td>
                    <td>SGD27,775</td>
                </tr>
                <tr>
                    <td>Cost of <br />living</td>
                    <td>SGD26,380</td>
                    <td>SGD23,416</td>
                    <td>SGD15,146</td>
                    <td>SGD17,784</td>
                </tr>
                <tr>
                    <td>Total</td>
                    <td style="color:#cc6f2f;">SGD50,998</td>
                    <td style="color:#cc6f2f;">SGD54,721</td>
                    <td style="color:#cc6f2f;">SGD47,434</td>
                    <td style="color:#cc6f2f;">SGD45,559</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                 <tr>
                    <td colspan="5">
                    <span style="font-size:10px;">
                    <b>*Sources:</b> 'The Value of Education' published in 2014 by HSBC Holdings plc. All figures are converted from USD to SGD 
                    </span>
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
            <td colspan="2"><a href="#" id="existingegtoggle">&gt;</a>&nbsp;Education Goals Added</td>
        </tr>
 </thead>
 <tbody>
         <tr><td colspan="2">&nbsp;</td></tr>
         <tr>
            <td colspan="2" align="center">
            <span id="existingegspan" style="visibility:visible;">
            <asp:DataGrid ID="existingeggrid" runat="server" AutoGenerateColumns="false" Width="100%">
                <Columns>
                    <asp:TemplateColumn HeaderText="Id" Visible="false" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "id") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Name of Child" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblgoal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "nameofchild") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Number of Years to Save" ItemStyle-Width="10%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblyrstoaccumulate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "noofyrstosave") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Future Cost" ItemStyle-Width="10%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblfc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "futurecost") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Maturity Value" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblmaturityvalue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "maturityvalue") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Existing Assets" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbleattlvalue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "existingassetstotal") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Total (Shortfall/Surplus)" ItemStyle-Width="25%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
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
                <asp:Button ID="Button2" runat="server" Text="Generate PDF" OnClientClick="onSave()" OnClick="createEducationGoalsPdf" class="chassis_application_button_xxxlarge" />
                <asp:Button ID="Button3" runat="server" Text="Previous" OnClientClick="onPrevious()" OnClick="submitEducationGoalsPrevious" class="chassis_application_button_medium" />
                <asp:Button ID="Button6" runat="server" Text="Save" OnClientClick="onSave()" OnClick="submitEducationGoals" class="chassis_application_button_medium" />
                <asp:Button ID="Button1" runat="server" Text="Next" OnClientClick="onNext()" OnClick="submitEducationGoalsNext" class="chassis_application_button_medium" />
                <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>
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
Education Goals
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Education Goals
</asp:Content>
