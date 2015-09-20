<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRetirementGoals.aspx.cs" Inherits="Zurich.Layouts.Zurich.RetirementGoals.ShowRetirementGoals" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
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
        if (!isNaN(document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value) && document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value != "") {
            futureValue = parseFloat(document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value);
        }

        var exitingAssets = 0;
        if (!isNaN(document.getElementById('<%= existingAssets2.ClientID %>').value) && document.getElementById('<%= existingAssets2.ClientID %>').value != "") {
            exitingAssets = parseFloat(document.getElementById('<%= existingAssets2.ClientID %>').value);
        }

        var maturityValue = 0;
        if (!isNaN(document.getElementById('<%= maturityValue2.ClientID %>').value) && document.getElementById('<%= maturityValue2.ClientID %>').value != "") {
            maturityValue = parseFloat(document.getElementById('<%= maturityValue2.ClientID %>').value);
        }

        var shortFall = (exitingAssets + maturityValue) - futureValue;
        
        var yrstoAccumulate = 0;

        if (!isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && document.getElementById('<%= yearsToRetirement.ClientID %>').value != "") {
            yrstoAccumulate = parseFloat(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
        }

        var moduleName = 2;

        calculateSavingOptions(shortFall, yrstoAccumulate, moduleName);
        graph.update([regularSumValue1, regularSumValue2, regularSumValue3, regularSumValue4]);
        graph2.update([lumpSumValue1, lumpSumValue2, lumpSumValue3, lumpSumValue4]);

    }
    
</script>

<% 
    int easizeself = 0;

    if (ViewState["noofassets"] != null)
    {
        easizeself = Int32.Parse(ViewState["noofassets"].ToString());
    }
%>
    
<script type="text/javascript">
var count1=0;
var countMembersForSelf=<%=easizeself%>;

 count1 = <%=easizeself %>;

 var graph;

 var graph2;
 
    $(document).ready(function () {

    $('#<%=retirementGoalNeeded.ClientID %>').change(function () {
         enableDisableRetirementGoalFields()
     });
     
     enableDisableRetirementGoalFields();
    
    var futureValue = 0;
    if (!isNaN(document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value) && document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value != "") {
        futureValue = parseFloat(document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value);
    }

    var exitingAssets = 0;
    if (!isNaN(document.getElementById('<%= existingAssets2.ClientID %>').value) && document.getElementById('<%= existingAssets2.ClientID %>').value != "") {
        exitingAssets = parseFloat(document.getElementById('<%= existingAssets2.ClientID %>').value);
    }

    var maturityValue = 0;
    if (!isNaN(document.getElementById('<%= maturityValue2.ClientID %>').value) && document.getElementById('<%= maturityValue2.ClientID %>').value != "") {
        maturityValue = parseFloat(document.getElementById('<%= maturityValue2.ClientID %>').value);
    }

    var shortFall = (exitingAssets + maturityValue) - futureValue;

    var yrstoAccumulate = 0;

    if (!isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && document.getElementById('<%= yearsToRetirement.ClientID %>').value != "") {
        yrstoAccumulate=parseFloat(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
    }
         
    var moduleName = 2;
    
    calculateSavingOptions(shortFall, yrstoAccumulate, moduleName);


    var ctx = createCanvas("graphDiv1");

	graph = new BarGraph(ctx);
	graph.margin = 2;
	graph.colors = ["#49a0d8", "#d353a0", "#ffc527", "#df4c27"];
	graph.xAxisLabelArr = [lowest+" %", low+" %", high+" %", highest+" %"];
	graph.update([regularSumValue1, regularSumValue2, regularSumValue3, regularSumValue4]);
        
	var ctx = createCanvas("graphDiv2");

	graph2 = new BarGraph(ctx);

	graph2.margin = 2;
	graph2.colors = ["#49a0d8", "#d353a0", "#ffc527", "#df4c27"];
	graph2.xAxisLabelArr = [lowest+" %", low+" %", high+" %", highest+" %"];
	graph2.update([lumpSumValue1, lumpSumValue2, lumpSumValue3, lumpSumValue4]);

    calculateAmountNeededFutureValue('');
    entPoints();
    $('#plusSelf').click(function () {
            //var count = $("#existingAssetsSelf >tbody > tr").size()
            count1+=1;
            countMembersForSelf+=1;
            var str = 'existingAssetsSelfrowId' + count1;
            var row1 = $("<tr id='existingAssetsSelfrowId" + count1 + "' width=100%><td align='left'><input type='text' class='chassis_application_medium_text_box' id='pridesc-"+count1+"' name='pridesc-"+count1+"'/></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' value=0 id='pri_"+(count1)+"' name='pri_"+(count1)+"' class='chassis_application_small_text_box' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='tempCalculate1()'/></td><td align='left'><input type='text' value=0 id='sec_"+(count1)+"' name='sec_"+(count1)+"' class='chassis_application_small_text_box' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='tempCalculate1()' />&nbsp;&nbsp;<a onClick=DeleteRow1('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
            $("#existingAssetsSelf").append(row1);
            $("#existingAssetsSelf >tbody > tr:last").focusin();

            document.getElementById('<%= noofmembers.ClientID %>').value = count1;
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
        var response = confirm("Do you want to save the changes to PDF before Back to the Case?");
        if (response == true) {
            document.getElementById('<%=backToCase.ClientID %>').value = true;
        }
        else {
            document.getElementById('<%=backToCase.ClientID %>').value = false;
        }
    }

function tempCalculate1() {

    var presentvalueid = 'pri_';
    var percentagevalueid = 'sec_';
    var sum=0;
    for (var i = 1; i <= count1; i++) {
        var pvid = presentvalueid + (i);
        var paid = percentagevalueid + (i);
        if ((document.getElementById(pvid) != null) || (document.getElementById(paid) != null)) {
            document.getElementById(pvid).value = removeTrailingZeroes(document.getElementById(pvid).value);
            document.getElementById(paid).value = removeTrailingZeroes(document.getElementById(paid).value);
            
            var presentvalue = parseFloat(document.getElementById(pvid).value);
            var percentagepa = parseFloat(document.getElementById(paid).value);
           // alert(presentvalue + '-' + percentagepa);
            var yrstoAccumulate = parseFloat(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
            //alert('yrstoAccumulate=' + yrstoAccumulate);
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
    document.getElementById('<%= existingAssets2.ClientID %>').value = Math.round(sum*100)/100;
    calculateAmountNeededFutureValue('');

    }


    function DeleteRow1(param) {
        var answer = confirm("Delete Existing Assets ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
            tempCalculate1();
            calculateAmountNeededFutureValue('');
        }
    }

    function roundOffValuesSelf(){
        if(!isNaN(document.getElementById('<%= intendedRetirementAge.ClientID %>').value) && document.getElementById('<%= intendedRetirementAge.ClientID %>').value!=""){
            document.getElementById('<%= intendedRetirementAge.ClientID %>').value = Math.round(document.getElementById('<%= intendedRetirementAge.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && document.getElementById('<%= yearsToRetirement.ClientID %>').value!=""){
            document.getElementById('<%= yearsToRetirement.ClientID %>').value = Math.round(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value) && document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value!=""){
            document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value = Math.round(document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= futureIncomeNeeded.ClientID %>').value) && (document.getElementById('<%= futureIncomeNeeded.ClientID %>').value!="")){
            document.getElementById('<%= futureIncomeNeeded.ClientID %>').value = Math.round(document.getElementById('<%= futureIncomeNeeded.ClientID %>').value);
        }
        if(!isNaN(document.getElementById('<%= durationOfRetirement.ClientID %>').value) && (document.getElementById('<%= durationOfRetirement.ClientID %>').value!="")){
            document.getElementById('<%= durationOfRetirement.ClientID %>').value = Math.round(document.getElementById('<%= durationOfRetirement.ClientID %>').value);
        }
    }


    var futureIncomeChart=0;
    var inflationAdjustedReturns=0;
    var presentIncomeNeeded=0;
    var currentAge=0;
    var expectedRetirementAge=0;
    var ageAtEndOfRetirement = 0;
    var durationOfRetirement = 0;
    var annualInflationRate = 0;
    var currentAgeToRetirement = 0;
    var totalShortFallSurplusForRetirementChart=0;

    function calculateAmountNeededFutureValue(sourceDocId) {
        //roundOffValuesSelf();
        
        $('#expectedRetirementAge').text(0);

        var iretAge = 0;
        if(( !isNaN(document.getElementById('<%= intendedRetirementAge.ClientID %>').value) && (document.getElementById('<%= intendedRetirementAge.ClientID %>').value!="") ) && ( !isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && (document.getElementById('<%= yearsToRetirement.ClientID %>').value!="") )){
            document.getElementById('<%= intendedRetirementAge.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= intendedRetirementAge.ClientID %>').value);
            currentAgeToRetirement = parseInt(document.getElementById('<%= intendedRetirementAge.ClientID %>').value) - parseInt(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
            iretAge = parseInt(document.getElementById('<%= intendedRetirementAge.ClientID %>').value);
            $('#expectedRetirementAge').text(parseInt(document.getElementById('<%= intendedRetirementAge.ClientID %>').value));
        }
        
        var currentYearlyExpenses = 0;
        if(!isNaN(document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value) && document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value!=""){
            document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value);
            currentYearlyExpenses = fixedToZero(Math.round(parseFloat(document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value)*100)/100);
            document.getElementById('<%= incomeRequiredUponRetirement.ClientID %>').value = currentYearlyExpenses;
        }
        
        var yearsToRetirement=0;
        var ipownerdob = 0;
        if(!isNaN(document.getElementById('<%= pownerdob.ClientID %>').value) && document.getElementById('<%= pownerdob.ClientID %>').value!=""){
            ipownerdob = parseInt(document.getElementById('<%= pownerdob.ClientID %>').value);
            document.getElementById('<%= yearsToRetirement.ClientID %>').value = parseInt(iretAge) - ipownerdob;
            yearsToRetirement = parseInt(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
        }
        /*if(!isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && document.getElementById('<%= yearsToRetirement.ClientID %>').value!=""){
            document.getElementById('<%= yearsToRetirement.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
            yearsToRetirement = parseInt(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
        }*/
        
        
        if(!isNaN(document.getElementById('<%= annualInflationRate.ClientID %>').value) && document.getElementById('<%= annualInflationRate.ClientID %>').value!=""){
            document.getElementById('<%= annualInflationRate.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= annualInflationRate.ClientID %>').value);
            annualInflationRate = parseFloat(document.getElementById('<%= annualInflationRate.ClientID %>').value);
        }

        var AnnualInflationStaging = Math.pow((1 + (annualInflationRate / 100)), yearsToRetirement);
        var futureIncomeNeeded = Math.round((AnnualInflationStaging * currentYearlyExpenses)*100)/100;
        document.getElementById('<%= futureIncomeNeeded.ClientID %>').value = fixedToZero(parseFloat(futureIncomeNeeded));
        futureIncomeChart=futureIncomeNeeded
        presentIncomeNeeded=currentYearlyExpenses;
        
        if((!isNaN(document.getElementById('<%= durationOfRetirement.ClientID %>').value) && document.getElementById('<%= durationOfRetirement.ClientID %>').value!="") && (!isNaN(document.getElementById('<%= intendedRetirementAge.ClientID %>').value && document.getElementById('<%= intendedRetirementAge.ClientID %>').value!=""))){
            document.getElementById('<%= durationOfRetirement.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= durationOfRetirement.ClientID %>').value);
            ageAtEndOfRetirement = Math.round((parseFloat(document.getElementById('<%= durationOfRetirement.ClientID %>').value)) + parseFloat(document.getElementById('<%= intendedRetirementAge.ClientID %>').value));
        }
        
        inflationAdjustedReturns=document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value;
       
        var sourcesOfIncome = 0;
        if(!isNaN(document.getElementById('<%= sourcesOfIncome.ClientID %>').value) && document.getElementById('<%= sourcesOfIncome.ClientID %>').value!=""){
            document.getElementById('<%= sourcesOfIncome.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= sourcesOfIncome.ClientID %>').value);
            sourcesOfIncome = fixedToZero(Math.round(parseFloat(document.getElementById('<%= sourcesOfIncome.ClientID %>').value)*100)/100);
            document.getElementById('<%= sourcesOfIncome.ClientID %>').value = sourcesOfIncome;
        }
        
        var inflationAdjustedReturn = 0;
        if(!isNaN(document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value) && document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value!=""){
            document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value);
            inflationAdjustedReturn = parseFloat(document.getElementById('<%= inflationAdjustedReturn.ClientID %>').value);
        } 
        
        $('#inflationRate').text(annualInflationRate);

        var totalFirstYearIncomeNeeded = fixedToZero(Math.round((parseFloat(futureIncomeNeeded) - parseFloat(sourcesOfIncome))*100)/100);
        document.getElementById('<%= totalFirstYearIncomeNeeded.ClientID %>').value = totalFirstYearIncomeNeeded;
        $('#annualAmount').text(totalFirstYearIncomeNeeded);

        var strPoGender = document.getElementById('<%= pownergender.ClientID %>').value;
        
        if(sourceDocId == 'intendedra'){
            if(strPoGender == 'Male'){
                document.getElementById('<%= durationOfRetirement.ClientID %>').value = 83 - parseInt(iretAge);
            }else if(strPoGender == 'Female'){
                document.getElementById('<%= durationOfRetirement.ClientID %>').value = 88 - parseInt(iretAge);
            }  
        }
        
        if(!isNaN(document.getElementById('<%= durationOfRetirement.ClientID %>').value) && document.getElementById('<%= durationOfRetirement.ClientID %>').value!=""){
            document.getElementById('<%= durationOfRetirement.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= durationOfRetirement.ClientID %>').value);
            durationOfRetirement = parseFloat(document.getElementById('<%= durationOfRetirement.ClientID %>').value);
        }

        var lumpSumRequiredAtRetirement = 0;

        if(inflationAdjustedReturn!=0){
            var rz = inflationAdjustedReturn / 100;
            var rzb = 1 + rz;
            var rzn = Math.pow(rzb, (-1 * durationOfRetirement));
            var temp = totalFirstYearIncomeNeeded * (1 - rzn);
            var temp1 = 0;
            if(rz!=0){
                temp1=temp / rz;
            }
            var temp2 = temp1 * rzb;
            lumpSumRequiredAtRetirement = Math.round(temp2*100)/100;
        }else{
            lumpSumRequiredAtRetirement = Math.round((totalFirstYearIncomeNeeded*durationOfRetirement)*100)/100;
        }
        
        document.getElementById('<%= lumpSumRequiredAtRetirement.ClientID %>').value = fixedToZero(lumpSumRequiredAtRetirement);
        
        var existingAssets2 = 0;
        if(!isNaN(document.getElementById('<%= existingAssets2.ClientID %>').value) && document.getElementById('<%= existingAssets2.ClientID %>').value!=""){
            document.getElementById('<%= existingAssets2.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= existingAssets2.ClientID %>').value);
            existingAssets2 = fixedToZero(Math.round(parseFloat(document.getElementById('<%= existingAssets2.ClientID %>').value)*100)/100);
            document.getElementById('<%= existingAssets2.ClientID %>').value = existingAssets2;
        }
        var maturityValue2 = 0;
        if(!isNaN(document.getElementById('<%= maturityValue2.ClientID %>').value) && document.getElementById('<%= maturityValue2.ClientID %>').value!=""){
            document.getElementById('<%= maturityValue2.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= maturityValue2.ClientID %>').value);
            maturityValue2 = fixedToZero(Math.round(parseFloat(document.getElementById('<%= maturityValue2.ClientID %>').value)*100)/100);
            document.getElementById('<%= maturityValue2.ClientID %>').value = maturityValue2;
        }
        document.getElementById('<%= totalShortfallSurplus2.ClientID %>').value = Math.abs(fixedToZero((Math.round(((parseFloat(existingAssets2) + parseFloat(maturityValue2)) - parseFloat(lumpSumRequiredAtRetirement))*100))/100));
        
        totalShortFallSurplusForRetirementChart=0;
           
         var shortfall = fixedToZero((Math.round(((parseFloat(existingAssets2) + parseFloat(maturityValue2)) - parseFloat(lumpSumRequiredAtRetirement))*100))/100);

         totalShortFallSurplusForRetirementChart=shortfall;

         lumpsumForChart=lumpSumRequiredAtRetirement;
         existingForChart = parseFloat(existingAssets2) + parseFloat(maturityValue2);

          percentage = existingForChart / lumpsumForChart
          threshold = Math.round(percentage * 170);

         if (shortfall < 0) {
            $('#surplus_shortfall_family_needs').text('Shortfall');
            $('#surplus_shortfall_family_needs').css('color', 'red');
            $('#chartttlss').text('SHORTFALL');
        }
        else if (shortfall > 0) {
            $('#surplus_shortfall_family_needs').text('Surplus');
            $('#surplus_shortfall_family_needs').css('color', 'black');
            $('#chartttlss').text('SURPLUS');
        }
        else {
            $('#surplus_shortfall_family_needs').text('Total (Shortfall / Surplus)');
            $('#surplus_shortfall_family_needs').css('color', 'black');
            $('#chartttlss').text('TOTAL (SHORTFALL/SURPLUS)');
        }
        
        document.getElementById('<%= noofmembers.ClientID %>').value = count1;

        calculateOptions();
    }

    function onSave() {
        calculateAmountNeededFutureValue('');
    }

</script>


<script language="javascript" type="text/javascript">
    // increase the default animation speed to exaggerate the effect
    
    function popitup(url, width, height) {
        newwindow = window.open(url, 'name', 'height=' + height + ',width=' + width + ', scrollbars=yes');
        if (window.focus) { newwindow.focus() }
        return false;
    }

    
    var countForPlotting = 0;
    var countForReturnLinePlotting = 0;
    

    function Point(x, y) {

        this.x = x;

        this.y = y;

    }

    var chart1;
    var chart2;
    var chart3;

    
    var startpointx = 30;
    var startpointy = 220;
    var endPoint = 340;

    var startpoint1x = 500;
    var startpoint1y = 30;
    var lastPoint = 200;


    var points = {

        linePoint: []

    };

    var returnLinePoints = {

        returnlinePoint: []

    };

    var barPoints = {

        barPoint: []

    };

    var barStartpointy = 220;
    var barX = 450;
    var barYMaximum = 30;
    var countForPlottingBar = 0;


    var lumpsumForChart=0;
    var existingForChart = 0;

    var percentage;
    var threshold;

    function entPoints() {
        for (i = 0; i < endPoint; i++) {

            var x = startpointx;
            x = x + i + 10;

            var t = x / 73;
            var y = (startpointy + 1) - Math.exp(t);
            points.linePoint.push(new Point(x, y));
        }



        for (j = 0; j <= 200; j++) {

            var y1 = startpoint1y;
            y1 = y1 + j + 10;

            var t = y1 / 45;

            var x1 = (startpoint1x + 5) + 1.5* Math.exp(t);

            
            returnLinePoints.returnlinePoint.push(new Point(x1, y1));

        }

        for (i = barStartpointy; i > barYMaximum; i--) {

            barPoints.barPoint.push(new Point(barX, i));

        }

        chart1 = setInterval("drawPoints()", 10);
        chart2 = setInterval("drawPointsforReturnLine()", 10);
        chart3 = setInterval("drawBarChart()", 10);
        chart4 = setInterval("writeTextOnCanvas()", 10);
    }

    var textStatus = "false"

    function writeTextOnCanvas() {
        if (textStatus == "false") {
            canvas = document.getElementById('ex1');
            context = canvas.getContext("2d");
            
            context.font = "bold 9px verdana";
            
            context.fillText("Age at end of Retirement " + ageAtEndOfRetirement, 600, 240);
            context.fillText("Future Income Needed $ " + futureIncomeChart, 250, 50);
            context.fillText("Inflation Rate " + annualInflationRate + " %", 20, 120);
            context.fillText("Present Income Needed $" + presentIncomeNeeded, 20, 160);
            
            context.fillText("Inflation adjusted returns " + inflationAdjustedReturns + " %", 600, 120);

            var intendedRetirementAgeForChart = 0;
            if (!isNaN(document.getElementById('<%= intendedRetirementAge.ClientID %>').value) && document.getElementById('<%= intendedRetirementAge.ClientID %>').value != "") {
                intendedRetirementAgeForChart = Math.round(document.getElementById('<%= intendedRetirementAge.ClientID %>').value);
            }

            var numberOfYearsChart = 0;
            if (!isNaN(document.getElementById('<%= yearsToRetirement.ClientID %>').value) && document.getElementById('<%= yearsToRetirement.ClientID %>').value != "") {
                numberOfYearsChart = Math.round(document.getElementById('<%= yearsToRetirement.ClientID %>').value);
            }

            var ageForChart = intendedRetirementAgeForChart - numberOfYearsChart;
            context.fillText("Current Age " + ageForChart, 3, 230);

            var totalFirstYearIncomeNeededChart=0

            if (!isNaN(document.getElementById('<%= totalFirstYearIncomeNeeded.ClientID %>').value) && document.getElementById('<%= totalFirstYearIncomeNeeded.ClientID %>').value != "") {
                totalFirstYearIncomeNeededChart = Math.round(parseFloat(document.getElementById('<%= totalFirstYearIncomeNeeded.ClientID %>').value)*100)/100;
            }


            var totalShortfallSurplus2Chart = 0;
            if (!isNaN(document.getElementById('<%= totalShortfallSurplus2.ClientID %>').value) && document.getElementById('<%= totalShortfallSurplus2.ClientID %>').value != "") {
                totalShortfallSurplus2Chart = Math.round(parseFloat(document.getElementById('<%= totalShortfallSurplus2.ClientID %>').value)*100)/100;
            }


            context.fillText("Expected Retirement Age ", 395, 235);
            context.fillText("" + intendedRetirementAgeForChart, 440, 245);

            context.font = "bold 11px verdana";

            context.fillText("Number of Years: " + numberOfYearsChart, 150, 270);

            context.fillText("Duration of Retirement " + durationOfRetirement, 470, 270);

            context.fillText("Annual Amount: $" + fixedToZero(totalFirstYearIncomeNeededChart), 470, 290);

            
            if (totalShortFallSurplusForRetirementChart >= 0)
                context.fillText("Your surplus is: $" + fixedToZero(Math.abs(totalShortFallSurplusForRetirementChart)), 150, 290);
            else
                context.fillText("Your shortfall is: $" + fixedToZero(Math.abs(totalShortFallSurplusForRetirementChart)), 150, 290);


            if (existingForChart > lumpsumForChart) {
                context.font = "bold 9px verdana";
                context.fillText("Existing Assets: $" + existingForChart, 470, 55);
            }
                
            

            context.beginPath();
            context.lineWidth = 4;
            context.moveTo(10, 250);
            context.lineTo(870, 250);
            context.strokeStyle = 'black';
            context.stroke();


            textStatus = "true";
        }
    }

    function drawBarChart() {

        canvas = document.getElementById('ex1');
        context = canvas.getContext("2d");
        context.strokeStyle = "#475B7E";
        context.lineWidth = 30;
        context.beginPath();

        if (countForPlottingBar < 235) {

            if (countForPlottingBar == 0) {
                context.moveTo(barX, barStartpointy);
            }
            else {
                context.moveTo(barPoints.barPoint[countForPlottingBar].x, barPoints.barPoint[countForPlottingBar].y);
            }
            context.lineTo(barPoints.barPoint[countForPlottingBar + 1].x, barPoints.barPoint[countForPlottingBar + 1].y);
            if (countForPlottingBar > threshold) {
                if (countForPlottingBar == threshold + 1) {
                    context.font = "bold 9px verdana";
                    context.fillText("Existing Assets : $" + existingForChart, (barPoints.barPoint[countForPlottingBar + 1].x +15), barPoints.barPoint[countForPlottingBar + 1].y);
                }
                
                context.strokeStyle = "#FF4500";
            }

            if (countForPlottingBar > 170) {
                if (countForPlottingBar == 171) {
                    context.font = "bold 9px verdana";
                    context.fillText("Lump Sum Required : $" + lumpsumForChart, (barPoints.barPoint[countForPlottingBar + 1].x-30), (barPoints.barPoint[countForPlottingBar + 1].y-7));
                }
                
                ClearChart3();
            }

            context.stroke();
        }
        
            
        countForPlottingBar++;
    }
    
    
    
    var lineWidthReturn = 0;



    function drawPointsforReturnLine() {

    canvas = document.getElementById('ex1');

           context = canvas.getContext("2d");

           context.strokeStyle = "#475B7E";

           if (countForReturnLinePlotting < lastPoint - 30) {


               //context.lineWidth = (countForReturnLinePlotting + 10) * 5 * .015;
               context.lineWidth = (countForReturnLinePlotting + 5) * 6 * .015;

               context.beginPath();

               if (countForReturnLinePlotting == 0) {

                   //context.moveTo(startpoint1x, startpoint1y);

               } else {

                   context.moveTo(returnLinePoints.returnlinePoint[countForReturnLinePlotting].x,

                 returnLinePoints.returnlinePoint[countForReturnLinePlotting].y);

               }

               context.lineTo(returnLinePoints.returnlinePoint[countForReturnLinePlotting + 1].x, returnLinePoints.returnlinePoint[countForReturnLinePlotting + 1].y);

               context.stroke();

               countForReturnLinePlotting++;
           }
           else {
               if (countForReturnLinePlotting >= lastPoint - 30 && countForPlotting < lastPoint) {

                   if (countForReturnLinePlotting == (lastPoint - 30)) {
                       lineWidthReturn = 40;
                   }
                   else {
                       lineWidthReturn = lineWidthReturn-4;
                   }

                   if (lineWidthReturn < 0) {
                       context.lineWidth = 0;
                   }
                   else
                       context.lineWidth = lineWidthReturn;

                   context.beginPath();
                   context.moveTo(returnLinePoints.returnlinePoint[countForReturnLinePlotting - 1].x,
                    returnLinePoints.returnlinePoint[countForReturnLinePlotting - 1].y);
                   context.lineTo(returnLinePoints.returnlinePoint[countForReturnLinePlotting].x, returnLinePoints.returnlinePoint[countForReturnLinePlotting].y);
                   if (lineWidthReturn >= 3) {
                       context.stroke();
                   }

                   if (lineWidthReturn < 0) {
                       countForReturnLinePlotting >= lastPoint;
                   }
               }

               countForReturnLinePlotting++;

               if (countForReturnLinePlotting == lastPoint) {
                   ClearChart2();
               }

               

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
        else {

            if (countForPlotting >= endPoint - 20 && countForPlotting < endPoint) {

                if (countForPlotting == endPoint - 20) 
                {
                    lineWidth = (countForPlotting + 10) * 3 * .04;
                }
                lineWidth = lineWidth - 3;
                if (lineWidth < 0) 
                {
                    context.lineWidth = 0;
                }
                else
                    context.lineWidth = lineWidth;
                    context.beginPath();
                    context.moveTo(points.linePoint[countForPlotting - 1].x,
                    points.linePoint[countForPlotting - 1].y);
                    context.lineTo(points.linePoint[countForPlotting].x, points.linePoint[countForPlotting].y);
                    if (lineWidth >= 0) 
                    {
                        context.stroke();
                    }
                    countForPlotting++;
                    if (lineWidth < 0) {
                        countForPlotting = lastPoint;
                    }
                }
            else
            ClearChart1();

        }

    }

    function ClearChart1() {
        clearInterval(chart1);
    }

    function ClearChart2() {
        clearInterval(chart2);
    }

    function ClearChart3() {
        clearInterval(chart3);
    }

    function enableDisableRetirementGoalFields() {
        var rgNeededSel = $('#<%=retirementGoalNeeded.ClientID %> input:checked').val();

        if (rgNeededSel == "2") {
            $("#befRetTbl :input").attr("disabled", false);
            $("#atRetTbl :input").attr("disabled", false);
            
            $("#projectedmat :input").attr("disabled", false); 
            
            $('#eaHeading').show();
            $('#eaTbl').show();

            $('#sgDynamicChart').css("display", "block");

        }
        else if (rgNeededSel == "1" || rgNeededSel == "0") {
            $("#befRetTbl :input").attr("disabled", true);
            $("#atRetTbl :input").attr("disabled", true);

            $("#projectedmat :input").attr("disabled", true);

            $('#eaHeading').hide();
            $('#eaTbl').hide();

            $('#sgDynamicChart').css("display", "none");

        }

    }

</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<asp:HiddenField ID="popupclose" runat="server" />
<asp:HiddenField ID="noofmembers" runat="server" />
<asp:HiddenField ID="printpage" runat="server" />
<asp:HiddenField ID="caseidrg" runat="server" />
<asp:HiddenField ID="activityId" runat="server" />
<asp:HiddenField ID="pownerdob" runat="server" />
<asp:HiddenField ID="pownergender" runat="server" />
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
                <asp:LinkButton ID="LinkSavingGoals" Text="Saving Goals" OnClick="menuClick" CommandArgument="savingGoals" runat="server" />
            </span>
        </div>
        </div>
    </li>
    <li class="chassis_application_navigation_selected_tab2">
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span id="retirementgoaltab" runat="server">
                <asp:LinkButton ID="LinkButtonRetirementGoals" Text="Retirement Goals" OnClick="menuClick" CommandArgument="retirementGoals" runat="server" />
            </span>
        </div>
        </div>
    </li>
    <li>
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span id="educationgoaltab" runat="server">
                <asp:LinkButton ID="LinkButtonEducationalGoals" Text="Education Goals" OnClick="menuClick" CommandArgument="educationGoals" runat="server" />
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
            <asp:Label ID="lblRetirementGoalSuccess" runat="server" class="chassis_application_save_success"
                Text="• Retirement Goal saved successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblRetirementGoalFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to save Retirement Goal" Visible = "false"></asp:Label>
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
            <td colspan="2">Retirement Goals</td>
        </tr>
     </thead>
</table>

<table class="chassis_two_column_list">
    <tbody>
    <tr>
        <td class="chassis_label_column">Do you require planning for this need?</td>
        <td class="chassis_data_column"><asp:radiobuttonlist id="retirementGoalNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                <asp:listitem id="retirementGoalNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                <asp:listitem id="retirementGoalNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                <asp:listitem id="retirementGoalNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
            </asp:radiobuttonlist>
        </td>
    </tr>
    </tbody>
</table>
<table class="chassis_two_column_list">
    <tbody>
    <tr>
        <td width="49%">

            <table class="chassis_two_column_list">
                <thead>
                <tr>
                <td>Before Retirement</td>
                </tr>
                </thead>
            </table>
            <table width="100%" id="befRetTbl">
                <tr>
                <td class="chassis_label_column">Intended Retirement Age</td>
                <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="intendedRetirementAge" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/> &nbsp;yrs old</td></tr>
                <tr>
                <td class="chassis_label_column">Income Required Upon Retirement</td>
                <td class="chassis_data_column">S$<asp:TextBox ID="incomeRequiredUponRetirement" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/></td>
                </tr>
                <tr>
                <td class="chassis_label_column">Years To Retirement</td>
                <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="yearsToRetirement" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/>&nbsp;yrs</td>
                </tr>
                <tr>
                <td class="chassis_label_column">Annual Inflation Rate</td>
                <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="annualInflationRate" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/>%</td></tr>
                <tr style="background-color:#DDDDDD;">
                <td class="chassis_label_column"><b>Future Income Needed</b></td>
                <td class="chassis_data_column">S$<asp:TextBox ID="futureIncomeNeeded" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0"/></td></tr>
                <tr>
                <td class="chassis_label_column">Sources of Income</td>
                <td class="chassis_data_column">S$<asp:TextBox ID="sourcesOfIncome" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/></td>
                </tr>
                <tr style="background-color:#DDDDDD;">
                <td class="chassis_label_column"><b>Total(1st Year Income Needed)</b></td>
                <td class="chassis_data_column">S$<asp:TextBox ID="totalFirstYearIncomeNeeded" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0"/></td>
                </tr>
            </table>

        </td>
        <td width="2%">
        </td>
        <td width="49%">

            <table class="chassis_two_column_list">
                    <thead>
                    <tr>
                    <td>At Retirement</td>
                    </tr>
                    </thead>
            </table>
            <table width="100%" id="atRetTbl">
                    <tr>
                    <td class="chassis_label_column">Inflation Adjusted Return</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="inflationAdjustedReturn" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/>%</td></tr>
                    <tr>
                    <td class="chassis_label_column">Duration of Retirement</td>
                    <td class="chassis_data_column">&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="durationOfRetirement" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/>yrs</td>
                    </tr>
                    <tr style="background-color:#DDDDDD;" >
                    <td class="chassis_label_column"><b>Lump Sum Required At Retirement</b></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="lumpSumRequiredAtRetirement" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0"/></td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    </table>

                    <table width="100%" id="projectedmat">
                                    
                    <tr id="eaHeading">
                        <td colspan="2">
                            <a href="#" id="plusSelf"><img alt="" style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/add-icon.jpg' /></a>&nbsp;<asp:LinkButton ID="eaAssetLiability" runat="server">Existing Assets</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S$<asp:TextBox ID="existingAssets2" runat="server" class="chassis_application_small_text_box" BackColor="#E0E0E0"/>
                        </td>        
                     </tr>
                     <tr><td colspan="2">&nbsp;</td></tr>
                     <tr id="eaTbl">
                        <td colspan="2">
                                <table width="100%" id="existingAssetsSelf">
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
                                    <asp:Repeater ID="assetListSelf" runat="server">
                                        <ItemTemplate>
                                            <tr id='existingAssetsSelfrowId<%# (Container.ItemIndex+1)%>'>
                                                <td align="left">
                                                    <input type='text' class="chassis_application_medium_text_box" id='pridesc-<%# (Container.ItemIndex+1)%>' name='pridesc-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                                </td>
                                                <td align="left">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="chassis_application_small_text_box" value='<%# Eval("presentvalue") %>' id='pri_<%# (Container.ItemIndex+1)%>' name='pri_<%# (Container.ItemIndex+1)%>' onblur='tempCalculate1()' onkeypress = "javascript:allowOnlyNumbers(this.value)"/>
                                                </td>
                                                <td align="left">
                                                    <input type='text' class="chassis_application_small_text_box" value='<%# Eval("percentpa") %>' id='sec_<%# (Container.ItemIndex+1)%>' name='sec_<%# (Container.ItemIndex+1)%>' onblur='tempCalculate1()' onkeypress = "javascript:allowOnlyNumbers(this.value)"/>&nbsp;&nbsp;<a onclick="DeleteRow1('existingAssetsSelfrowId<%# (Container.ItemIndex+1)%>')"><img alt="" style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                                </td>                                                           
                                                </tr>       
                                
                                        </ItemTemplate>
                                    </asp:Repeater>
                                                   
                                </table>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                    <td class="chassis_label_column"><asp:LinkButton ID="mvalueLink" runat="server">Projected Maturity Value of Existing Insurance Policies</asp:LinkButton></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="maturityValue2" runat="server" CssClass="chassis_application_small_text_box" OnKeyPress = "javascript:allowOnlyNumbers(this.value)"/></td>
                    </tr>
                    </table>

                    <table width="100%">
                    <tr style="background-color:#DDDDDD;">
                    <td class="chassis_label_column"><span id="surplus_shortfall_family_needs" style="font-weight:bold"><asp:Label ID="ttlSSSelf" runat="server" Text="Total (Shortfall/Surplus)" Font-Bold="true" /></span></td>
                    <td class="chassis_data_column">S$<asp:TextBox ID="totalShortfallSurplus2" runat="server" CssClass="chassis_application_small_text_box" BackColor="#E0E0E0"/></td>
                    </tr>
                    
                    </table>

        </td>
    </tr>

    <tr>
        <td colspan="3">

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

        </td>
    </tr>

    <tr>
        <td colspan="3">

        <table width="100%">

            <tr>
                <td colspan="2">
                <fieldset style="width:875px; height:100%">
    
                <table width='100%' >
                <tr class="table_header" >
                <td width="100%" colspan="2">Retirement Goals</td>
                </tr>
                <tr>
                <td colspan=2>
                <table width='100%' >
                <tr>
                    <td width='20%'></td>
                    <td colspan=5 style="font-weight:bold"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                            <td colspan=5 height="290px">
                            <canvas id="ex1" width="900px" height="310px" 
		                           style="solid #cccccc;position:absolute;z-index:0;">
		                    HTML5 Canvas not supported
                        </canvas>
                   <div style="background-image:url(/_layouts/Zurich/images/retirement_canvas.jpg); background-repeat:no-repeat;">
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
                            </td>
                         
                     </tr>
                     <tr>
                        <td colspan="2" height="20px;" align=left>
                            <img src="/_layouts/Zurich/images/Content/Legend.png" alt=""/>
                        </td>
                     </tr>
           
                </table>
                
                </fieldset>
                </td>  
            </tr>
            <tr>
                <td colspan=2>
                
                </td>
            </tr>

        </table>

        </td>
    </tr>

    <tr>
        <td colspan="3">
        <table width="100%">
            <tr align="right">
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Generate PDF" OnClick="createRetirementGoalsPdf" class="chassis_application_button_xxxlarge" />
                    <asp:Button ID="Button4" runat="server" Text="Previous" OnClick="submitRetirementGoalsPrevious" class="chassis_application_button_medium" />
                    <asp:Button ID="Button3" runat="server" Text="Save" OnClientClick="onSave()" OnClick="submitRetirementGoals" class="chassis_application_button_medium" />
                    <asp:Button ID="Button1" runat="server" Text="Next" OnClick="submitRetirementGoalsNext" class="chassis_application_button_medium" />
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
Retirement Goals
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Retirement Goals
</asp:Content>
