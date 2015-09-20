<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowProtectionGoals.aspx.cs"
    Inherits="Zurich.Layouts.Zurich.ProtectionGoals.ShowProtectionGoals" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>

<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" Src="~/_controltemplates/Zurich/FNAMenu.ascx" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.barRenderer.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pointLabels.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.css" />
    <!-- popup libraries -->
    <link type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/ui-lightness/jquery-ui-1.8.17.custom.css"
        rel="stylesheet" />
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-1.8.17.custom.min.js"></script>
    <%--Move all these references to layouts folder--%>
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />    
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
    <script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="/_layouts/Zurich/styles/css/jquery-ui-i18n.min.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
    <script type="text/javascript" src="/_Layouts/Zurich/styles/js/Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="/_Layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
    <script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

    <script type='text/javascript'>

        _spSuppressFormOnSubmitWrapper = true;

    </script>
    
    <%
        int assetsSize = 0;
        if (ViewState["assetsSize"] != null)
        {
            assetsSize = Int32.Parse(ViewState["assetsSize"].ToString());
        }
    %>
    
    
    <script language="javascript" type="text/javascript">
        
         function popitup(url, width, height) {
        newwindow = window.open(url, 'name', 'height=' + height + ',width=' + width + ', scrollbars=yes');
        if (window.focus) { newwindow.focus() }
        return false;
    }

       var numberOfAssets=0;
       var countFamilyNeeds = 0;
       countFamilyNeeds = <%=assetsSize%>;
       var countmyNeedplus = 0;
       countmyNeedplus = $("#existingAssetsMyNeedsCriticalTable >tbody > tr").size();

        var countmyNeedplusPart2 = 0;
        countmyNeedplusPart2 = $("#existingAssetsMyNeedsDisabilityTable >tbody > tr").size();
        $(document).ready(function () {
            entPoints();
            calculate();
            $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });

            $('#familyNeedplus').click(function () {
            
                countFamilyNeeds += 1;
                var str = 'existingAssetFamilyNeedrowId' + countFamilyNeeds;
                var row1 = $("<tr id='existingAssetFamilyNeedrowId" + countFamilyNeeds + "' width=100%><td align='center' style='width:45%'><input type='text' style='width: 100px;'  id='prifamily-" + countFamilyNeeds + "' name='prifamily-" + countFamilyNeeds + "'/></td><td align='center' style='width:50%'><input type='text' value=0 id='prifamilyneeds_" + (countFamilyNeeds) + "' name='prifamilyneeds_" + (countFamilyNeeds) + "' style='width: 100px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculate()'/>&nbsp;&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td><td align='center' style='width:5%'>&nbsp;&nbsp;</td></tr>");
                $("#existingAssetFamilyNeedTable").append(row1);
                $("#existingAssetFamilyNeedTable >tbody > tr:last").focusin();
                document.getElementById('<%=noofmembers.ClientID %>').value = countFamilyNeeds;
            });


            $('#myNeedsCriticalplus').click(function () {
                countmyNeedplus += 1;
                var str = 'existingAssetMyNeedrowId' + countmyNeedplus;
                var row1 = $("<tr id='existingAssetMyNeedrowId" + countmyNeedplus + "' width=100%><td align='center' style='width:45%'><input type='text' style='width: 100px;'  id='primyneedscritical-" + countmyNeedplus + "' name='primyneedscritical-" + countmyNeedplus + "'/></td><td align='center' style='width:50%'><input type='text' value=0 id='primyneedplus_" + (countmyNeedplus) + "' name='primyneedplus_" + (countmyNeedplus) + "' style='width: 100px;' onblur='calculate()'/></td><td align='center' style='width:5%'>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
                $("#existingAssetsMyNeedsCriticalTable").append(row1);
                $("#existingAssetsMyNeedsCriticalTable >tbody > tr:last").focusin();
                document.getElementById('<%=noofcriticalassets.ClientID %>').value = countmyNeedplus;
            });

            $('#myNeedsDisabilityplus').click(function () {
                countmyNeedplusPart2 += 1;
                var str = 'existingAssetMyNeed2rowId' + countmyNeedplusPart2;
                var row1 = $("<tr id='existingAssetMyNeed2rowId" + countmyNeedplusPart2 + "' width=100%><td align='center' style='width:45%'><input type='text' style='width: 100px;'  id='primyneedsdisb-" + countmyNeedplusPart2 + "' name='primyneedsdisb-" + countmyNeedplusPart2 + "'/></td><td align='center' style='width:50%'><input type='text' value=0 id='primyneedpluspart2_" + (countmyNeedplusPart2) + "' name='primyneedpluspart2_" + (countmyNeedplusPart2) + "' style='width: 100px;' onblur='tempCalculateMyneedspart2()'/></td><td align='center' style='width:5%'>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
                $("#existingAssetsMyNeedsDisabilityTable").append(row1);
                $("#existingAssetsMyNeedsDisabilityTable >tbody > tr:last").focusin();
                document.getElementById('<%=noofdisabilityassets.ClientID %>').value = countmyNeedplusPart2;
            });

            $(function () {
                $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                $('#protectionGoal').addClass("chassis_application_navigation_selected_tab1");

                var fnclass = $('#<%=familyneedstab.ClientID %>').attr("class");
                var mynclass = $('#<%=myneedstab.ClientID %>').attr("class");

                if((fnclass == 'chassis_application_page_complete') && (mynclass == 'chassis_application_page_complete')){
                    $("#protectionGoaltab").addClass("chassis_application_page_complete");    
                }else{
                    if((fnclass == 'chassis_application_page_warnings') || (mynclass == 'chassis_application_page_warnings')){
                        $("#protectionGoaltab").addClass("chassis_application_page_warnings");
                    }
                }

            });

            $('#<%=familyIncPrNeeded.ClientID %>').change(function () {
                enableDisableFamilyIncFields();
            });

            $('#<%=mortgagePrNeeded.ClientID %>').change(function () {
                enableDisableMortgageFields();
            });

            enableDisableFamilyIncFields();
            enableDisableMortgageFields();
        });

        var totalShortfallSurplusForChart=0;

        function roundOffValuesFamilyneeds() {


            if (!isNaN(document.getElementById('<%= txtReplacementIncome.ClientID %>').value) && document.getElementById('<%= txtReplacementIncome.ClientID %>').value != "") {
                var replacement_income=Math.round(parseFloat(document.getElementById('<%= txtReplacementIncome.ClientID %>').value)*100);
                document.getElementById('<%= txtReplacementIncome.ClientID %>').value = replacement_income/100;
            }
            
            if (!isNaN(document.getElementById('<%= txtYrsOfSupport.ClientID %>').value) && document.getElementById('<%= txtYrsOfSupport.ClientID %>').value != "") {
                document.getElementById('<%= txtYrsOfSupport.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtYrsOfSupport.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtLumpSumRequired.ClientID %>').value) && document.getElementById('<%= txtLumpSumRequired.ClientID %>').value != "") {
                document.getElementById('<%= txtLumpSumRequired.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtLumpSumRequired.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtOtherLiabilities.ClientID %>').value) && document.getElementById('<%= txtOtherLiabilities.ClientID %>').value != "") {
                document.getElementById('<%= txtOtherLiabilities.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtOtherLiabilities.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtEmergencyFundsNeeded.ClientID %>').value) && document.getElementById('<%= txtEmergencyFundsNeeded.ClientID %>').value != "") {
                document.getElementById('<%= txtEmergencyFundsNeeded.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtEmergencyFundsNeeded.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtFinalExpenses.ClientID %>').value) && document.getElementById('<%= txtFinalExpenses.ClientID %>').value != "") {
                document.getElementById('<%= txtFinalExpenses.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtFinalExpenses.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtOtherFundingNeeds.ClientID %>').value) && document.getElementById('<%= txtOtherFundingNeeds.ClientID %>').value != "") {
                document.getElementById('<%= txtOtherFundingNeeds.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtOtherFundingNeeds.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtTotalRequired.ClientID %>').value) && document.getElementById('<%= txtTotalRequired.ClientID %>').value != "") {
                document.getElementById('<%= txtTotalRequired.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtTotalRequired.ClientID %>').value));
            }

            
            if (!isNaN(document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value) && document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value != "") {
                document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value));
            }

            if (!isNaN(document.getElementById('<%= txtMortgageProtectionOutstanding.ClientID %>').value) && document.getElementById('<%= txtMortgageProtectionOutstanding.ClientID %>').value != "") {
                document.getElementById('<%= txtMortgageProtectionOutstanding.ClientID %>').value = parseFloat(document.getElementById('<%= txtMortgageProtectionOutstanding.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= txtMortgageProtectionInsurances.ClientID %>').value) && document.getElementById('<%= txtMortgageProtectionInsurances.ClientID %>').value != "") {
                document.getElementById('<%= txtMortgageProtectionInsurances.ClientID %>').value = parseFloat(document.getElementById('<%= txtMortgageProtectionInsurances.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= txtMortgageProtectionTotal.ClientID %>').value) && document.getElementById('<%= txtMortgageProtectionTotal.ClientID %>').value != "") {
                document.getElementById('<%= txtMortgageProtectionTotal.ClientID %>').value = Math.abs(parseFloat(document.getElementById('<%= txtMortgageProtectionTotal.ClientID %>').value));
                document.getElementById('<%= hiddentxtMortgageProtectionTotal.ClientID %>').value = parseFloat(document.getElementById('<%= txtMortgageProtectionTotal.ClientID %>').value);
                
            }
        }

        function onBackToCase() {
            var response = confirm("Do you want to save the changes to PDF before Back to the Case?");
            if (response == true) {
                document.getElementById('<%=backToCase.ClientID %>').value = true;
            }
            else {
                document.getElementById('<%=backToCase.ClientID %>').value = false;
            }
        }

        function roundOffValuesMyneeds() {
            if (!isNaN(document.getElementById('txtlumpSumRequiredForTreatment').value) && document.getElementById('txtlumpSumRequiredForTreatment').value != "") {
                document.getElementById('txtlumpSumRequiredForTreatment').value = Math.round(parseFloat(document.getElementById('txtlumpSumRequiredForTreatment').value));
            }
            if (!isNaN(document.getElementById('txtCriticalIllnessInsurance').value) && document.getElementById('txtCriticalIllnessInsurance').value != "") {
                document.getElementById('txtCriticalIllnessInsurance').value = Math.round(parseFloat(document.getElementById('txtCriticalIllnessInsurance').value));
            }
            if (!isNaN(document.getElementById('txtExistingAssetsMyNeedsCritical').value) && document.getElementById('txtExistingAssetsMyNeedsCritical').value != "") {
                document.getElementById('txtExistingAssetsMyNeedsCritical').value = Math.round(parseFloat(document.getElementById('txtExistingAssetsMyNeedsCritical').value));
            }
            if (!isNaN(document.getElementById('txtTotalShortfallSurplusMyNeeds').value) && document.getElementById('txtTotalShortfallSurplusMyNeeds').value != "") {
                document.getElementById('txtTotalShortfallSurplusMyNeeds').value = Math.round(parseFloat(document.getElementById('txtTotalShortfallSurplusMyNeeds').value));
            }
            if (!isNaN(document.getElementById('txtMonthlyIncomeDisabilityIncome').value) && document.getElementById('txtMonthlyIncomeDisabilityIncome').value != "") {
                document.getElementById('txtMonthlyIncomeDisabilityIncome').value = Math.round(parseFloat(document.getElementById('txtMonthlyIncomeDisabilityIncome').value));
            }
            if (!isNaN(document.getElementById('txtMonthlyCoverageRequired').value) && document.getElementById('txtMonthlyCoverageRequired').value != "") {
                document.getElementById('txtMonthlyCoverageRequired').value = Math.round(parseFloat(document.getElementById('txtMonthlyCoverageRequired').value));
            }
            if (!isNaN(document.getElementById('txtDisabilityInsuranceMyNeeds').value) && document.getElementById('txtDisabilityInsuranceMyNeeds').value != "") {
                document.getElementById('txtDisabilityInsuranceMyNeeds').value = Math.round(parseFloat(document.getElementById('txtDisabilityInsuranceMyNeeds').value));
            }
            if (!isNaN(document.getElementById('txtExistingAssetsMyneedsDisability').value) && document.getElementById('txtExistingAssetsMyneedsDisability').value != "") {
                document.getElementById('txtExistingAssetsMyneedsDisability').value = Math.round(parseFloat(document.getElementById('txtExistingAssetsMyneedsDisability').value));
            }
            if (!isNaN(document.getElementById('txtShortfallSurplusMyNeeds').value) && document.getElementById('txtShortfallSurplusMyNeeds').value != "") {
                document.getElementById('txtShortfallSurplusMyNeeds').value = Math.round(parseFloat(document.getElementById('txtShortfallSurplusMyNeeds').value));
            }
        }


        function DeleteRow(param) {
            var answer = confirm("Delete Existing Assets ?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
                tempCalculateFamilyneeds();
                calculate();
            }
            document.getElementById('<%= noofmembers.ClientID %>').value = countFamilyNeeds;
        }

        function tempCalculateFamilyneeds() {
            var presentvalueid = 'prifamilyneeds_';
            var sum = 0;
            for (var i = 1; i <= countFamilyNeeds; i++) {
                var pvid = presentvalueid + (i);
                if (document.getElementById(pvid) != null) {
                    var presentvalue = parseFloat(document.getElementById(pvid).value);
                    document.getElementById(pvid).value=presentvalue;
                    if (!(isNaN(presentvalue))) {
                        sum += presentvalue;
                    }
                }
            }
            document.getElementById('<%= txtExistingAssetsFamilyneeds.ClientID %>').value = Math.round(sum * 100) / 100;
        }

        function tempCalculateMyneeds() {

            var presentvalueid = 'primyneedplus_';
            var sum = 0;
            for (var i = 1; i <= countmyNeedplus; i++) {
                var pvid = presentvalueid + (i);
                if (document.getElementById(pvid) != null) {
                    var presentvalue = parseFloat(document.getElementById(pvid).value);
                    if (!(isNaN(presentvalue))) {
                        sum += presentvalue;
                    }
                }
            }
            document.getElementById('txtExistingAssetsMyNeedsCritical').value = Math.round(sum * 100) / 100;
            calculateTab2();

        }

        function tempCalculateMyneedspart2() {

            var presentvalueid = 'primyneedpluspart2_';
            var sum = 0;
            for (var i = 1; i <= countmyNeedplusPart2; i++) {
                var pvid = presentvalueid + (i);
                if (document.getElementById(pvid) != null) {
                    var presentvalue = parseFloat(document.getElementById(pvid).value);
                    if (!(isNaN(presentvalue))) {
                        sum += presentvalue;
                    }
                }
            }
            document.getElementById('txtExistingAssetsMyneedsDisability').value = Math.round(sum * 100) / 100;
            calculateTab2();

        }

        function popupshowfactfindassets(url) {
            newwindow = window.open(url, 'name', 'height=500,width=1000,scrollbars=1');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function popupassets(url) {
            newwindow = window.open(url, 'name', 'height=500,width=500');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function popUpClosed() {
            window.location.reload();
        }

        window.closingPopup = function () {
            document.getElementById('popupclose').value = 'true';
            document.forms[0].submit();
        };

        function saveProtectionGoals() {
           
            document.getElementById('<%= noofmembers.ClientID %>').value = count;
            document.getElementById('<%= noofcriticalassets.ClientID %>').value = eaCriticalCount;
            document.getElementById('<%= noofdisabilityassets.ClientID %>').value = eaDisabilityCount;

            document.forms[0].submit();
        }

        function printProtectionGoal() {
            /* alert('printProtectionGoal : ' + count);
            document.getElementById('<%= noofmembers.ClientID %>').value = count;
            document.getElementById('<%= noofcriticalassets.ClientID %>').value = eaCriticalCount;
            document.getElementById('<%= noofdisabilityassets.ClientID %>').value = eaDisabilityCount;

            document.forms[0].submit();      */
        }


        function calculate() {
            
            roundOffValuesFamilyneeds();
            
            var replacementIncomeRequired = 0;
            if (!isNaN(document.getElementById("<%=txtReplacementIncome.ClientID %>").value) && document.getElementById("<%=txtReplacementIncome.ClientID %>").value != "") {
                replacementIncomeRequired = Math.round(parseFloat(document.getElementById("<%=txtReplacementIncome.ClientID %>").value));
            }
            
            

            var yearsOfSupportRequired = 0;
            if (!isNaN(document.getElementById("<%=txtYrsOfSupport.ClientID %>").value) && document.getElementById("<%=txtYrsOfSupport.ClientID %>").value != "") {
                yearsOfSupportRequired = Math.round(parseFloat(document.getElementById("<%=txtYrsOfSupport.ClientID %>").value));
            }

            
            

            var inflationAdjustedReturns = 0;
            if (!isNaN(document.getElementById("<%=txtInflationAdjustedReturns.ClientID %>").value) && document.getElementById("<%=txtInflationAdjustedReturns.ClientID %>").value != "") {
                inflationAdjustedReturns = parseFloat(document.getElementById("<%=txtInflationAdjustedReturns.ClientID %>").value);
            }



            //Kartik, error happening here.
            var lumpSumRequired = 0;

            if(inflationAdjustedReturns==0)
            {
                lumpSumRequired = replacementIncomeRequired*yearsOfSupportRequired;
                lumpSumRequired = Math.round(lumpSumRequired*100)/100;
            }
            else
            {
                var rz = (inflationAdjustedReturns * .01);
                var rzb = rz + 1;
                var rzn = Math.pow(rzb, -1 * yearsOfSupportRequired);
                if (rz != 0) {
                    var innerCalc=replacementIncomeRequired * (1 - rzn);
                    var innerCalc2=innerCalc / rz;
                    lumpSumRequired = Math.round(innerCalc2 * rzb*100)/100;
                }
            }


            var lumpSumRequiredWith2Zeroes=fixedToZero(lumpSumRequired);
            document.getElementById('<%=txtLumpSumRequired.ClientID %>').value = lumpSumRequiredWith2Zeroes;

            var otherLiabilities = 0;
            if (!isNaN(document.getElementById("<%=txtOtherLiabilities.ClientID %>").value) && document.getElementById("<%=txtOtherLiabilities.ClientID %>").value != "") {
                otherLiabilities = parseFloat(document.getElementById("<%=txtOtherLiabilities.ClientID %>").value);
            }

            var emergencyFundsNeeded = 0;
            if (!isNaN(document.getElementById("<%=txtEmergencyFundsNeeded.ClientID %>").value) && document.getElementById("<%=txtEmergencyFundsNeeded.ClientID %>").value != "") {
                emergencyFundsNeeded = parseFloat(document.getElementById("<%=txtEmergencyFundsNeeded.ClientID %>").value);
            }

            var finalExpenses = 0;
            if (!isNaN(document.getElementById("<%=txtFinalExpenses.ClientID %>").value) && document.getElementById("<%=txtFinalExpenses.ClientID %>").value != "") {
                finalExpenses = parseFloat(document.getElementById("<%=txtFinalExpenses.ClientID %>").value);
            }

            var otherFundingNeeds = 0;
            if (!isNaN(document.getElementById("<%=txtOtherFundingNeeds.ClientID %>").value) && document.getElementById("<%=txtOtherFundingNeeds.ClientID %>").value != "") {
                otherFundingNeeds = parseFloat(document.getElementById("<%=txtOtherFundingNeeds.ClientID %>").value);
            }

            var mortgageOutstanding = 0;
            if (!isNaN(document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value) && document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value != "") {
                mortgageOutstanding = parseFloat(document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value);
            }

            var totalRequired = lumpSumRequired + otherLiabilities + emergencyFundsNeeded + finalExpenses + otherFundingNeeds;
            
            if(!isNaN(totalRequired))
                document.getElementById("<%=txtTotalRequired.ClientID %>").value = fixedToZero(Math.round(parseFloat(totalRequired)*100)/100);
            else
                document.getElementById("<%=txtTotalRequired.ClientID %>").value = fixedToZero(0);

            $("#lblYearsOfSupportRequiredGraph").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + yearsOfSupportRequired);

            $("#lblInflationAdjustedReturnsGraph").text(inflationAdjustedReturns);

            var existingLifeInsurance = 0;
            if (!isNaN(document.getElementById("<%=txtExistingLifeInsurance.ClientID %>").value) && document.getElementById("<%=txtExistingLifeInsurance.ClientID %>").value != "") {
                existingLifeInsurance = Math.round(parseFloat(document.getElementById("<%=txtExistingLifeInsurance.ClientID %>").value));
            }

            tempCalculateFamilyneeds();

            var existingAsset = 0;
            if (!isNaN(document.getElementById("<%=txtExistingAssetsFamilyneeds.ClientID %>").value) && document.getElementById("<%=txtExistingAssetsFamilyneeds.ClientID %>").value != "") {
                existingAsset = parseFloat(document.getElementById("<%=txtExistingAssetsFamilyneeds.ClientID %>").value);
            }
            
            
            
            var totalShortfallSurplus = Math.round(((parseFloat(existingAsset) + parseFloat(existingLifeInsurance)) - parseFloat(totalRequired))*100)/100;
            
            totalShortfallSurplusForChart=0;

            if(!isNaN(totalShortfallSurplus))
            {
                document.getElementById("<%=txtTotalShortfallSurplus.ClientID %>").value = Math.abs(fixedToZero(totalShortfallSurplus));
                document.getElementById("<%=hiddenTotalShortfallSurplus.ClientID %>").value = fixedToZero(totalShortfallSurplus);
                totalShortfallSurplusForChart=totalShortfallSurplus;
            }
            else
                {
                    document.getElementById("<%=hiddenTotalShortfallSurplus.ClientID %>").value = fixedToZero(0);
                    document.getElementById("<%=txtTotalShortfallSurplus.ClientID %>").value = fixedToZero(0);
                }
                

            var mortgageOutstanding = 0;
            if (!isNaN(document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value) && document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value != "") {
                mortgageOutstanding = parseFloat(document.getElementById("<%=txtMortgageProtectionOutstanding.ClientID %>").value);
            }

            var mortgageInsurances = 0;
            if (!isNaN(document.getElementById("<%=txtMortgageProtectionInsurances.ClientID %>").value) && document.getElementById("<%=txtMortgageProtectionInsurances.ClientID %>").value != "") {
                mortgageInsurances = parseFloat(document.getElementById("<%=txtMortgageProtectionInsurances.ClientID %>").value);
            }

            var mortgageInsurancesTotal = Math.round((parseFloat(mortgageInsurances)- parseFloat(mortgageOutstanding))*100)/100;
            
            if (!isNaN(mortgageInsurancesTotal))
                {
                document.getElementById("<%=txtMortgageProtectionTotal.ClientID %>").value = Math.abs(mortgageInsurancesTotal);
                document.getElementById('<%= hiddentxtMortgageProtectionTotal.ClientID %>').value = mortgageInsurancesTotal;
                }
                
            else
            {
                document.getElementById('<%= hiddentxtMortgageProtectionTotal.ClientID %>').value = 0;
                document.getElementById("<%=txtMortgageProtectionTotal.ClientID %>").value = 0;
            }
                

            if(mortgageInsurancesTotal>=0)
            {
                $("#spanShortfall").hide();
                $("#spanSurplus").show();
            }
            else
            {
                $("#spanShortfall").show();
                $("#spanSurplus").hide();
            }

            
            if(totalShortfallSurplus>=0)
            {
                $("#totalShortfallForProtection").hide();
                $("#totalSurplusForProtection").show();
            }
            else
            {
                $("#totalShortfallForProtection").show();
                $("#totalSurplusForProtection").hide();
            }


            

            

            $("#replacementIncomeChart").html("&nbsp;&nbsp;&nbsp;" + replacementIncomeRequired);
            $("#lumpSumRequiredChart").text(totalRequired);
            $("#existingSumRequiredChart").text(Math.round((parseFloat(existingAsset) + parseFloat(existingLifeInsurance))));
            $("#shortFallSumRequiredChart").text(totalShortfallSurplus);


            if (totalShortfallSurplus < 0) {
                $('#surplus_shortfall_family_needs').text('Shortfall');
                $('#surplus_shortfall_family_needs').css('color', 'red');
            }
            else if (totalShortfallSurplus > 0) {
                $('#surplus_shortfall_family_needs').text('Surplus');
                $('#surplus_shortfall_family_needs').css('color', 'black');
            }
            else {
                $('#surplus_shortfall_family_needs').text('Total (Shortfall / Surplus)');
                $('#surplus_shortfall_family_needs').css('color', 'black');
            }

            
            
        }


        function calculateTab2() {

            roundOffValuesMyneeds();

            var lumpsumRequiredForTreatment = 0;
            if (!isNaN(document.getElementById("txtlumpSumRequiredForTreatment").value) && document.getElementById("txtlumpSumRequiredForTreatment").value != "") {
                lumpsumRequiredForTreatment = Math.round(parseFloat(document.getElementById("txtlumpSumRequiredForTreatment").value));
            }

            var criticalIllnessInsurance = parseFloat(document.getElementById("txtCriticalIllnessInsurance").value);
            if (!isNaN(document.getElementById("txtCriticalIllnessInsurance").value) && document.getElementById("txtCriticalIllnessInsurance").value != "") {
                criticalIllnessInsurance = Math.round(parseFloat(document.getElementById("txtCriticalIllnessInsurance").value));
            }

            var existingAssets = parseFloat(document.getElementById("txtExistingAssetsMyNeedsCritical").value);
            if (!isNaN(document.getElementById("txtExistingAssetsMyNeedsCritical").value) && document.getElementById("txtExistingAssetsMyNeedsCritical").value != "") {
                existingAssets = Math.round(parseFloat(document.getElementById("txtExistingAssetsMyNeedsCritical").value));
            }

            var existing = criticalIllnessInsurance + existingAssets;

            var totalShortfallSurplusMyNeeds = Math.round(existing - lumpsumRequiredForTreatment);
            document.getElementById("txtTotalShortfallSurplusMyNeeds").value = totalShortfallSurplusMyNeeds;

            document.getElementById("lumpSumMyNeeds").value = document.getElementById("txtlumpSumRequiredForTreatment").value;
            document.getElementById("existingSumMyNeeds").value = existing;
            document.getElementById("shortfallSumMyNeeds").value = totalShortfallSurplusMyNeeds;

            var monthlyIncomeDisabilityIncome = 0;
            if (!isNaN(document.getElementById("txtMonthlyIncomeDisabilityIncome").value) && document.getElementById("txtMonthlyIncomeDisabilityIncome").value != "") {
                monthlyIncomeDisabilityIncome = Math.round(parseFloat(document.getElementById("txtMonthlyIncomeDisabilityIncome").value));
            }

            var perOfIncomeCoverageRequired = parseFloat(document.getElementById("txtPercentOfIncomeCoverageRequired").value);
            if (!isNaN(document.getElementById("txtPercentOfIncomeCoverageRequired").value) && document.getElementById("txtPercentOfIncomeCoverageRequired").value != "") {
                perOfIncomeCoverageRequired = Math.round(parseFloat(document.getElementById("txtPercentOfIncomeCoverageRequired").value));
            }

            var monthlyCoverageRequired = monthlyIncomeDisabilityIncome * (perOfIncomeCoverageRequired / 100);
            document.getElementById("txtMonthlyCoverageRequired").value = Math.round(parseFloat(monthlyCoverageRequired));

            var disabilityInsuranceMyNeeds = 0;
            if (!isNaN(document.getElementById("txtDisabilityInsuranceMyNeeds").value) && document.getElementById("txtDisabilityInsuranceMyNeeds").value != "") {
                disabilityInsuranceMyNeeds = Math.round(parseFloat(document.getElementById("txtDisabilityInsuranceMyNeeds").value));
            }

            var existingAssetsMyNeeds = parseFloat(document.getElementById("txtExistingAssetsMyneedsDisability").value);
            if (!isNaN(document.getElementById("txtExistingAssetsMyneedsDisability").value) && document.getElementById("txtExistingAssetsMyneedsDisability").value != "") {
                existingAssetsMyNeeds = Math.round(parseFloat(document.getElementById("txtExistingAssetsMyneedsDisability").value));
            }

            document.getElementById("txtShortfallSurplusMyNeeds").value = Math.round((disabilityInsuranceMyNeeds + existingAssetsMyNeeds) - monthlyCoverageRequired);

            document.getElementById("monthlyAmountMyNeeds").value = document.getElementById("txtMonthlyCoverageRequired").value;
            document.getElementById("existingMyNeeds").value = disabilityInsuranceMyNeeds + existingAssetsMyNeeds;

            document.getElementById("shortfallMyNeeds").value = Math.round((disabilityInsuranceMyNeeds + existingAssetsMyNeeds) - monthlyCoverageRequired);

            var totalShortfallSurplus = (disabilityInsuranceMyNeeds + existingAssetsMyNeeds) - monthlyCoverageRequired;

            if (totalShortfallSurplusMyNeeds < 0) {
                $('#total_shortFall_tab2').text('Shortfall');
                $('#total_shortFall_tab2').css('color', 'red');
            }
            else if (totalShortfallSurplusMyNeeds > 0) {
                $('#total_shortFall_tab2').text('Surplus');
                $('#total_shortFall_tab2').css('color', 'black');
            }
            else {
                $('#total_shortFall_tab2').text('Total (Shortfall / Surplus)');
                $('#total_shortFall_tab2').css('color', 'black');
            }


            if (totalShortfallSurplus < 0) {
                $('#shortfall_surplus').text('Shortfall');
                $('#shortfall_surplus').css('color', 'red');
            }
            else if (totalShortfallSurplus > 0) {
                $('#shortfall_surplus').text('Surplus');
                $('#shortfall_surplus').css('color', 'black');
            }
            else {
                $('#shortfall_surplus').text('Total (Shortfall / Surplus)');
                $('#shortfall_surplus').css('color', 'black');
            }

            document.getElementById("txtTotalShortfallSurplusMyNeeds").value = Math.round(Math.abs(totalShortfallSurplusMyNeeds));
            document.getElementById("txtShortfallSurplusMyNeeds").value = Math.round(Math.abs(totalShortfallSurplus));
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

       var yAxisPoints = {

           yAxisPoint: []

       };


       var startpointx = 70;
       var startpointy = 30;
       var lastPoint = 200;

       function Point(x, y) {

           this.x = x;

           this.y = y;

       }
       var inter;
       var inter1;
       var inter2;
       var inter3;
       var inter4;

       function entPoints() {

           for (i = 0; i <= 200; i++) {

               var y = startpointy;
               y = y + i + 10;

               var t = y / 50;

               var x = (startpointx + 1) + 2*Math.exp(t);

               points.linePoint.push(new Point(x, y));

           }

           for (i = barStartpointy; i > barYMaximum; i--) {

               barPoints.barPoint.push(new Point(barX, i));

           }

           for (i = barStartpointy; i > barYMaximum; i--) {

               yAxisPoints.yAxisPoint.push(new Point(barX-10, i));

           }
          
           inter = setInterval("drawPoints()", 10);
           inter1 = setInterval("drawBarChart()", 10);
           inter3 = setInterval("drawXAxis()", 10);
           inter4 = setInterval("writeTextOnCanvas()", 10);
           

       }

       var lineWidth = 0;
       var barStartpointy = 250;
       var barX = 30;
       var barYMaximum = 30;
       var countForPlottingBar = 0;
       var countForPlottingYaxis = 0;


       var yaxis = "false";
       var xaxis = "false";

       

       function drawYAxis() {

           if (yaxis == "false") {
               canvas = document.getElementById('ex1');
               context = canvas.getContext("2d");
               context.strokeStyle = "#000000";
               context.lineWidth = 3;
               context.beginPath();
               context.moveTo(2,barStartpointy)
               context.lineTo(2,10);
               context.stroke();
               yaxis = "true";
           }

       }

       var textStatus="false"
       function writeTextOnCanvas() {
           if (textStatus == "false") {
               context = canvas.getContext("2d");
               context.font = "bold 10px verdana";
               context.fillText("Years of Support : " + document.getElementById('<%=txtYrsOfSupport.ClientID %>').value, 260, 275);

               context.fillText("Inflated Adjusted Returns : " + document.getElementById('<%=txtInflationAdjustedReturns.ClientID %>').value+"%", 130, 150);


               context.fillText("Total Required : $" + document.getElementById('<%=txtTotalRequired.ClientID %>').value, 10, 15);

               textStatus = "true";

               var replacementIncomeRequiredForChart = 0;
               if (!isNaN(document.getElementById('<%= txtReplacementIncome.ClientID %>').value) && document.getElementById('<%= txtReplacementIncome.ClientID %>').value != "") {
                   replacementIncomeRequiredForChart = Math.round(parseFloat(document.getElementById('<%= txtReplacementIncome.ClientID %>').value));
               }

               context.fillText("Replacement Income $" + replacementIncomeRequiredForChart, 13, 275);

              

               context.font = "bold 12px verdana";
               if (totalShortfallSurplusForChart > 0)
                   context.fillText("Your Surplus is $" + Math.abs(totalShortfallSurplusForChart), 90, 295);
               else
                   context.fillText("Your Shortfall is $" + Math.abs(totalShortfallSurplusForChart), 90, 295);

           }

       }

       function drawXAxis() {

           if (xaxis == "false") {
               canvas = document.getElementById('ex1');
               context = canvas.getContext("2d");
               context.strokeStyle = "#000000";
               context.lineWidth = 2;
               context.beginPath();
               context.moveTo(2, barStartpointy);
               context.lineTo(465, barStartpointy);
               context.stroke();
               yaxis = "true";
           }

       }

       var limit = 0;
       var cutoff = 0;
       var calculatedLimit = 0;
       var totalExistingForBarChart = 0;
       var flagforDynamicExistingAssets = "true";
       var flagForExistingAsset = "true";
        var flagForExistingAsset99 = "true";
        var anotherFlagFor99="false";
       function drawBarChart() {
           var existingAssetsSurplus = "false";
           var totalRequiredForBarChart = 0;
           if (!isNaN(document.getElementById('<%= txtTotalRequired.ClientID %>').value) && document.getElementById('<%= txtTotalRequired.ClientID %>').value != "") {
               totalRequiredForBarChart = Math.round(parseFloat(document.getElementById('<%= txtTotalRequired.ClientID %>').value));
           }

           var totalExitingAssetsBarChart = 0;
           if (!isNaN(document.getElementById('<%= txtExistingAssetsFamilyneeds.ClientID %>').value) && document.getElementById('<%= txtExistingAssetsFamilyneeds.ClientID %>').value != "") {
               totalExitingAssetsBarChart = Math.round(document.getElementById('<%= txtExistingAssetsFamilyneeds.ClientID %>').value);
           }

           var existingLifeInsuranceBarChart = 0;
           if (!isNaN(document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value) && document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value != "") {
               existingLifeInsuranceBarChart = Math.round(document.getElementById('<%= txtExistingLifeInsurance.ClientID %>').value);
           }

           totalExistingForBarChart=existingLifeInsuranceBarChart + totalExitingAssetsBarChart;

           var shortfallSurplusBarChart = 0;
           shortfallSurplusBarChart = totalRequiredForBarChart - totalExistingForBarChart;

           limit = 0
           if (totalExistingForBarChart < totalRequiredForBarChart) {
               limit = (totalExistingForBarChart / totalRequiredForBarChart) * 100;
               if (limit > 99)
                   anotherFlagFor99 = "true";
           }
           else {
               existingAssetsSurplus = "true";
               limit = 100;
           }



           if (flagForExistingAsset99 == "true") {
               if (anotherFlagFor99 == "true") {
                   context.font = "bold 10px verdana";
                   context.fillText("Existing Assets $" + totalExistingForBarChart, 60, 40);
                   flagForExistingAsset99 = "false";
               }
           }

           
           if (flagForExistingAsset == "true") {
               if (existingAssetsSurplus == "true") {
                   context.font = "bold 10px verdana";
                   context.fillText("Existing Assets $" + totalExistingForBarChart, 60, 40);
                   flagForExistingAsset = "false";
               }
               
           }
        
           cutoff = Math.round(220 - ((limit * 220) / 100));

           calculatedLimit = 220 - cutoff;

           canvas = document.getElementById('ex1');

           context = canvas.getContext("2d");

           context.strokeStyle = "#475B7E";
           context.lineWidth = 30;
           context.beginPath();
           
           if (countForPlottingBar == 219) {
               clearInterval(inter1);
           }

           if (countForPlottingBar < 235) {

               if (countForPlottingBar == 0) {
                   context.moveTo(barX, barStartpointy);
               }
               else {
                   context.moveTo(barPoints.barPoint[countForPlottingBar].x, barPoints.barPoint[countForPlottingBar].y);
               }
               context.lineTo(barPoints.barPoint[countForPlottingBar + 1].x, barPoints.barPoint[countForPlottingBar + 1].y);
               if (countForPlottingBar > calculatedLimit) {
                   if (flagforDynamicExistingAssets == "true") {
                       context.font = "bold 10px verdana";
                       context.fillText("Existing Assets $" + totalExistingForBarChart, 60, barPoints.barPoint[countForPlottingBar + 1].y);
                       flagforDynamicExistingAssets = "false";
                   }
                   context.strokeStyle = "#FF4500";
               }

               context.stroke();
               countForPlottingBar++;
           }
       }

       var status = "true";
       function drawPoints() {

           if (status == "true") {
               canvas = document.getElementById('ex1');

               context = canvas.getContext("2d");

               context.strokeStyle = "#475B7E";

               context.lineWidth = (countForPlotting + 5) * 3 * .015;

               context.beginPath();
               context.lineWidth = 20;
               context.moveTo(20, 40);
               context.lineTo(400, 200);
               context.stroke();
           }   
           status = "false";
       }


       function drawPoints() {
           canvas = document.getElementById('ex1');

           context = canvas.getContext("2d");

           context.strokeStyle = "#475B7E";
           if (countForPlotting < lastPoint - 20) {


               context.lineWidth = (countForPlotting + 10) * 5 * .015;

               context.beginPath();

               if (countForPlotting == 0) {

                   //context.moveTo(startpointx, startpointy);

               } else {

                   context.moveTo(points.linePoint[countForPlotting].x,

                 points.linePoint[countForPlotting].y);

               }

               context.lineTo(points.linePoint[countForPlotting+1].x, points.linePoint[countForPlotting+1].y);

               context.stroke();

               countForPlotting++;

           }
           if (countForPlotting >= lastPoint - 20 && countForPlotting < lastPoint) {

               if (countForPlotting == lastPoint - 20) {
                   lineWidth = (countForPlotting + 10) * 3 * .04;
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
                   countForPlotting = lastPoint;
               }
           }

           if (countForPlotting == lastPoint) {

               clearInterval(inter);

           }
       }

       function enableDisableFamilyIncFields(){

           var familyNeededSel = $('#<%=familyIncPrNeeded.ClientID %> input:checked').val();

           if (familyNeededSel == "2") {
               $("#familyIncTbl :input").attr("disabled", false);

               $('#eaTbl').show();

           }
           else if (familyNeededSel == "1" || familyNeededSel == "0") {
               $("#familyIncTbl :input").attr("disabled", true);

               $('#eaTbl').hide();

           }

       }

       function enableDisableMortgageFields() {

           var mortgageNeededSel = $('#<%=mortgagePrNeeded.ClientID %> input:checked').val();

           if (mortgageNeededSel == "2") {
               $("#mortgageTbl :input").attr("disabled", false);

           }
           else if (mortgageNeededSel == "1" || mortgageNeededSel == "0") {
               $("#mortgageTbl :input").attr("disabled", true);

           }

       }

</script>
   
   
    <%
        /*    int easize = 0;
    if (ViewState["noofassets"] != null)
    {
        easize = Int32.Parse(ViewState["noofassets"].ToString());
    }

    int EACriticalSize = 0;
    if (ViewState["noofcriticalassets"] != null)
    {
        EACriticalSize = Int32.Parse(ViewState["noofcriticalassets"].ToString());
    }

    int EADisabilitySize = 0;
    if (ViewState["noofdisablityassets"] != null)
    {
        EADisabilitySize = Int32.Parse(ViewState["noofdisablityassets"].ToString());
    }
  */  
    %>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:HiddenField ID="noofmembers" runat="server" />
    <asp:HiddenField ID="hiddenTotalShortfallSurplus" runat="server" />
    <asp:HiddenField ID="noofcriticalassets" runat="server" />
    <asp:HiddenField ID="noofdisabilityassets" runat="server" />
    <asp:HiddenField ID="activityId" runat="server" />
    <asp:HiddenField ID="hiddentxtMortgageProtectionTotal" runat="server" />
    <asp:HiddenField ID="backToCase" runat="server"  />

        <div id="chassis_outer_container">
            <div class="chassis_page_container">
                <FNAMenutag:FNAMenu runat="server" ID="menu1" />

                <div class="chassis_application_navigation_container">
              <ul>
                <li class="chassis_application_navigation_selected_tab2">
                  <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                      <span id="familyneedstab" runat="server">
                        <asp:LinkButton ID="LinkFamilyNeeds" Text="Family Needs" OnClick="menuClick" CommandArgument="protectionGoals" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="myneedstab" runat="server">
                        <asp:LinkButton ID="LinkMyNeeds" Text="My Needs" OnClick="menuClick" CommandArgument="protectionGoalsMyNeeds" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
              </ul>
            </div>


                <div class="chassis_application_pane">
                    <div id="chassis_application_content" class="chassis_application_body">
             
             <table class="chassis_four_column_list">
                <thead>
                <tr>
                  <td colspan="4">Family Income Protection</td>
                </tr>
              </thead>
             </table>
             <table class="chassis_two_column_list">
                <tbody>
                <tr>
                    <td class="chassis_label_column">Do you require planning for this need?</td>
                    <td class="chassis_data_column"><asp:radiobuttonlist id="familyIncPrNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                            <asp:listitem id="familyIncPrNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                            <asp:listitem id="familyIncPrNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                            <asp:listitem id="familyIncPrNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                        </asp:radiobuttonlist>
                    </td>
                </tr>
                </tbody>
            </table>
             <table class="chassis_two_column_list">
                <tr>
                    <td style="width:50%">
                      
            <table summary="four column design layout" class="chassis_two_column_list" id="familyIncTbl">
              
              <tbody>
                <tr>
                    <td class="chassis_data_column">Replacement Income Required
                    &nbsp;
                    
                    </td>
                    <td class="chassis_data_column">
                        S$<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="txtReplacementIncome" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                   </td>
                    
                </tr>
                <tr>
                    <td class="chassis_data_column">Years of Support required</td>
                    <td class="chassis_data_column">
                       &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtYrsOfSupport" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>&nbsp;&nbsp;years
                   </td>
                   
                </tr>
                
                <tr>
                    <td class="chassis_data_column">Inflation Adjusted Returns</td>
                    <td class="chassis_data_column">
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="txtInflationAdjustedReturns" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>&nbsp;%
                    </td>
                    
                </tr>

                <tr>
                    <td class="chassis_data_column">Lump Sum Required</td>
                    <td class="chassis_data_column">
                        S$<asp:TextBox ID="txtLumpSumRequired"  BackColor="#E0E0E0" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                    </td>
                    
                </tr>



                <tr>
                    <td class="chassis_data_column">Other Liabilities&nbsp;&nbsp; </td>
                    <td class="chassis_data_column">
                       S$<asp:TextBox ID="txtOtherLiabilities" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                   </td>
                   
                </tr>

                <tr>
                    <td class="chassis_data_column">Emergency Funds Needed </td>
                    <td class="chassis_data_column">
                     S$<asp:TextBox ID="txtEmergencyFundsNeeded" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                   </td>
                    
                </tr>

                <tr>
                    <td class="chassis_data_column">Final Expenses&nbsp;&nbsp;</td>
                    <td class="chassis_data_column">
                      S$<asp:TextBox ID="txtFinalExpenses" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                    </td>
                    
                </tr>

                <tr>
                    <td class="chassis_data_column">Other Funding Needs <br/>  &nbsp;&nbsp;</td>
                    <td class="chassis_data_column">
                        S$<asp:TextBox ID="txtOtherFundingNeeds" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                    </td>
                    
                </tr>

                <tr>
                    <td class="chassis_data_column">Total Required <br/>  &nbsp;&nbsp;</td>
                    <td class="chassis_data_column">
                         S$<asp:TextBox ID="txtTotalRequired" BackColor="#E0E0E0" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                    </td>
                    
                </tr>
                
                <tr>
                    <td class="chassis_data_column">Existing Life Insurance&nbsp;&nbsp;Less</td>
                    <td class="chassis_data_column">
                        S$<asp:TextBox ID="txtExistingLifeInsurance" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
                   </td>
                   
                </tr>

                <tr>
                    
                   <td class="chassis_data_column"></td>
                   <td class="chassis_data_column"/>
                   
                </tr>
                
              </tbody>
            </table>

                    </td>
                    <td style="width:50%;vertical-align: top;">
                    <fieldset>
                    <legend> Family Protection</legend>
                        <canvas id="ex1" width="435px" height="300px" style="solid #cccccc;position:absolute;z-index:1;">
		                    HTML5 Canvas not supported
                        </canvas>
                        <div style="background-image:url(/_layouts/Zurich/images/family_protection_canvas.jpg); background-repeat:no-repeat;">
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
                        <br />
                        <img src="/_layouts/Zurich/images/Content/Legend.png" alt=""/>
                        </fieldset>
                        <br />
                        <br />

                         <table class="chassis_two_column_list">
                                <thead>
                                    <tr>
                                          <td colspan="2">Mortgage Protection</td>
                                    </tr>
                                  </thead>
                         </table>
                         <table class="chassis_two_column_list">
                         <tr>
                            <td class="chassis_label_column">Do you require planning for this need?</td>
                            <td class="chassis_data_column">
                                <asp:radiobuttonlist id="mortgagePrNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                                    <asp:listitem id="mortgagePrNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                                    <asp:listitem id="mortgagePrNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                                    <asp:listitem id="mortgagePrNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                                </asp:radiobuttonlist>
                            </td>
                        </tr>
                         </table>
                         <table class="chassis_two_column_list" id="mortgageTbl">
                                  <tbody>                              
                                    <tr>
                                        <td class="chassis_data_column chassis_no_padding_right">
                                            Mortgage Outstanding
                                        </td>
                                        <td class="chassis_data_column chassis_no_padding_right" align = "right">
                                            S$<asp:TextBox ID="txtMortgageProtectionOutstanding" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_small_text_box"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="chassis_data_column chassis_no_padding_right">
                                            Mortgage Insurance
                                        </td>
                                        <td class="chassis_data_column chassis_no_padding_right" align = "right">
                                            Less S$<asp:TextBox ID="txtMortgageProtectionInsurances" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_small_text_box"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="table_footer">
                                        <td class="chassis_data_column chassis_no_padding_right">
                                           <b> Total </b><span id="spanShortfall" style="color:Red"><b>Shortfall</b></span>  <span id="spanSurplus"><b>Surplus</b></span>
                                        </td>
                                        <td class="chassis_data_column chassis_no_padding_right" align = "right">
                                            S$<asp:TextBox ID="txtMortgageProtectionTotal" runat="server" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" BackColor="#E0E0E0" CssClass="chassis_application_small_text_box"></asp:TextBox>
                                        </td>
                                    </tr>

                                  </tbody>
                            </table>

                    </td>
                </tr>
             </table>

            <table summary="four column design layout" class="chassis_three_column_list" id="eaTbl">
              <thead>
                <tr>
                  <td colspan="4">Total Existing Assets (SGD)<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="txtExistingAssetsFamilyneeds"  BackColor="#E0E0E0" runat="server" CssClass="chassis_application_small_text_box" Width="100px"></asp:TextBox></td>
                </tr>
              </thead>
              <tbody>
                <tr>
                <td colspan="4">
                    <fieldset style = "width:92%">
                        <legend><a href="#" id="familyNeedplus">
                            <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a>
                            <asp:LinkButton CssClass="chassis_hyperlink" ID="lnkExistingAssetsFamilyneeds" runat="server">Existing Assets</asp:LinkButton></legend>
                        <table width="100%" id="existingAssetFamilyNeedTable">
                            <tr class="table_header">
                                <td align="center">
                                   <b>Asset</b> 
                                </td>
                                <td align="center">
                                    <b>Present Value</b>
                                </td>
                            </tr>
                            <asp:Repeater ID="familyNeedsAssetList" runat="server">
                                <ItemTemplate>
                                    <tr id='existingAssetFmlyNdRowId<%# (Container.ItemIndex+1)%>'>
                                        <td align="center" style="width:45%">
                                            <input type='text' style='width: 100px;' id='prifamily-<%# (Container.ItemIndex+1)%>'
                                                name='prifamily-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                        </td>
                                        <td align="center" style="width:50%">
                                            <input type='text' onkeypress = 'javascript:allowOnlyNumbers(this.value)' value='<%# Eval("presentvalue") %>' id='prifamilyneeds_<%# (Container.ItemIndex+1)%>' 
                                                name='prifamilyneeds_<%# (Container.ItemIndex+1)%>' style='width: 100px;' onblur='calculate()' />
                                                &nbsp;&nbsp;
                                                <a onclick="DeleteRow('existingAssetFmlyNdRowId<%# (Container.ItemIndex+1)%>')"><img
                                                alt="" style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                        </td>
                                        <td align="center" style="width:5%"> 
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </fieldset>
                    <table width="100%">
                            <tr style="background-color:#DDDDDD;">
                                <td align="center" class="chassis_label_column">
                                    <b>Total <span id="totalShortfallForProtection" style="color:Red">Shortfall</span>  <span id="totalSurplusForProtection">Surplus</span></b> 
                                </td>
                                <td align="left" class="chassis_data_column" style="padding-left:215px;" >
                                    S$<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" BackColor="#E0E0E0" ID="txtTotalShortfallSurplus" runat="server" CssClass="chassis_application_small_text_box"></asp:TextBox>
                                </td>
                           </tr>
                       </table>
                </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
              </tbody>
            </table>
                       
                        <table width="100%">
                            <tr align="right">
                                <td>
                                    <asp:Button ID="Button1" runat="server" Text="Generate Pdf" OnClick="createFamilyneedsPdf" class="chassis_application_button_xxxlarge" />
                                    <asp:Button ID = "btnBack" class = "chassis_application_button_medium" runat = "server"
                                        Text = "Previous" OnClick = "saveProtectionGoalsAndBack"/>
                                    <asp:Button ID="btnSave" class="chassis_application_button_medium" runat="server"
                                        Text="Save" OnClick="saveProtectionGoals" />
                                    <asp:Button ID = "btnNextAndSave" class = "chassis_application_button_medium" runat = "server"
                                        Text = "Next" OnClick = "saveProtectionGoalsAndNext"/>
                                     <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClientClick="onBackToCase()" OnClick="redirectToCasePortal" />   
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    
</asp:Content>
