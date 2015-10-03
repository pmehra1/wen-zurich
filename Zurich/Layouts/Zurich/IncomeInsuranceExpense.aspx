<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncomeInsuranceExpense.aspx.cs"
    Inherits="Zurich.Layouts.Zurich.IncomeInsuranceExpense" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>

<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" Src="~/_controltemplates/Zurich/FNAMenu.ascx" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css"
        media="all" />
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css"
        media="all" />
    <script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
    <script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="/_layouts/Zurich/styles/css/jquery-ui-i18n.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
    <script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>
    <script type='text/javascript'>

        _spSuppressFormOnSubmitWrapper = true;

    </script>
    <script language="javascript" type="text/javascript">

        var countEducationplus = 0;
        var countRetirementplus = 0;
        var countSavingsplus = 0;

        $(document).ready(function () {

            $('#<%=assecertainingAffordabilityEnable.ClientID %>').change(function () {
                enableassecertainingAffordabilityReason()
            });

            enableassecertainingAffordabilityReason();
            CalculateSurplusShortfall();

            $('#<%=incomeInsuranceEnable.ClientID %>').change(function () {
                enableDisableIncomeExpenseFields()
            });
            enableDisableIncomeExpenseFields();
            var shortTermGoals = $("#<%=shortTermGoals.ClientID %> option:selected").val();
            if (shortTermGoals == "Yes")
                $('#significantFactorDetails').show();
            else
                $('#significantFactorDetails').hide();

            $('#<%=shortTermGoals.ClientID %>').change(function () {
                var shortTermGoals = $("#<%=shortTermGoals.ClientID %> option:selected").val();
                if (shortTermGoals == "Yes")
                    $('#significantFactorDetails').show();
                else
                    $('#significantFactorDetails').hide();
            });


            var countSavingsplus = $("#savingsPlusTable >tbody > tr").size();

            $('#savingsPlus').click(function () {
                countSavingsplus += 1;
                var count = 0;
                count = countSavingsplus;
                var name = document.getElementById("<%=PersonName.ClientID %>").value;
                var str = 'savingsPlusrowId' + count;
                var contributionRemoveZero = 'savingsContribution' + count;
                var savingsTermRemoveZero = 'savingsTerm' + count;
                var savingsCurrentFundValueRemoveZero = 'savingsCurrentFundValue' + count;

                var savingFrequencyCounter = 'savingsFrequency' + count;
                var savingFrequency = "<select style='width:100px' id='" + savingFrequencyCounter + "' name='" + savingFrequencyCounter + "'>";
                savingFrequency += "<option value='Single'>Single</option>";
                savingFrequency += "<option value='Annual'>Annual</option>";
                savingFrequency += "</select>";


                var row1 = $("<tr id='savingsPlusrowId" + count + "' width=100%><td align='left'><input type='text' value='" + name + "' id='savingsOwnerName" + count + "' name='savingsOwnerName" + count + "' style='width: 100px;'/></td><td><input type='text' id='savingsNatureOfPlan" + count + "' name='savingsNatureOfPlan" + count + "' style='width: 100px;'/></td><td><input type='text'  id='savingsCompany" + count + "' name='savingsCompany" + count + "' style='width: 100px;' onblur ='calculateAssets()'/></td><td><input type='text' id='savingsContribution" + count + "' name='savingsContribution" + count + "' style='width: 100px;' onblur=removeTrailingZeroesForDynamicRows('" + contributionRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)'/></td><td align='left'>" + savingFrequency + "</td><td><input type='text' id='savingsTerm" + count + "' name='savingsTerm" + count + "' style='width: 100px;' onblur=removeTrailingZeroesForDynamicRows('" + savingsTermRemoveZero + "') onblur ='calculateAssets()' onkeypress = 'javascript:allowOnlyNumbers(this.value)'/></td><td align='left'><input type='text' id='savingsCurrentFundValue" + count + "' name='savingsCurrentFundValue" + count + "' style='width: 70px;' onblur=removeTrailingZeroesForDynamicRows('" + savingsCurrentFundValueRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)'/>&nbsp;&nbsp;&nbsp;&nbsp;<a onClick=DeleteSavingsRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
                $("#savingsPlusTable").append(row1);
                $("#savingsPlusTable >tbody > tr:last").focusin();
                document.getElementById('<%=savingsPlusNumber.ClientID %>').value = count;
            });

            countRetirementplus = $("#retirementPlusTable >tbody > tr").size();

            $('#retirementPlus').click(function () {
                countRetirementplus += 1;
                var name = document.getElementById("<%=PersonName.ClientID %>").value;
                var count = 0;
                count = countRetirementplus;

                var contributionRemoveZero = 'retirementContribution' + count;
                var retirementLumpSumMaturityRemoveZero = 'retirementLumpSumMaturity' + count;
                var retirementProjectedIncomeMaturityRemoveZero = 'retirementProjectedIncomeMaturity' + count;
                var retirementFrequencyCounter = 'retirementFrequency' + count;
                var retirementFrequency = "<select style='width:100px' id='" + retirementFrequencyCounter + "' name='" + retirementFrequencyCounter + "'>";
                retirementFrequency += "<option value='Single'>Single</option>";
                retirementFrequency += "<option value='Annual'>Annual</option>";
                retirementFrequency += "</select>";

                var str = 'retirementPlusrowId' + count;
                var row1 = $("<tr id='retirementPlusrowId" + count + "' width=100%><td align='left'><input type='text' value='" + name + "' id='retirementOwnerName" + count + "' name='retirementOwnerName" + count + "' style='width: 100px;'/></td><td><input type='text' id='retirementCompany" + count + "' name='retirementCompany" + count + "' style='width: 100px;' /></td><td><input type='text' id='retirementContribution" + count + "' name='retirementContribution" + count + "' style='width: 100px;' onblur=removeTrailingZeroesForDynamicRows('" + contributionRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)'  /></td><td align='left'>" + retirementFrequency + "</td><td><input type='text' maxlength='10' onkeypress = 'javascript:allowOnlyNumbersForDates()' id='retirementMaturityDate" + count + "' name='retirementMaturityDate" + count + "' style='width: 100px;' /></td><td><input type='text'  id='retirementLumpSumMaturity" + count + "' name='retirementLumpSumMaturity" + count + "'  onblur=removeTrailingZeroesForDynamicRows('" + retirementLumpSumMaturityRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)' style='width: 100px;'/></td><td align='left'><input type='text' id='retirementProjectedIncomeMaturity" + count + "' name='retirementProjectedIncomeMaturity" + count + "' style='width: 70px;'  onblur=removeTrailingZeroesForDynamicRows('" + retirementProjectedIncomeMaturityRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)'/><a onClick=DeleteRetirementRow('" + str + "')>&nbsp;&nbsp;&nbsp;&nbsp;<img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
                $("#retirementPlusTable").append(row1);
                $("#retirementPlusTable >tbody > tr:last").focusin();
                document.getElementById('<%=retirementPlusNumber.ClientID %>').value = count;

                $('input[id^="retirementMaturityDate"]').datepicker({
                    showOn: "button",
                    buttonImage: "/_layouts/Zurich/images/calendar.gif",
                    buttonImageOnly: true,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd/mm/yy',
                    yearRange: "-70:+70"

                });

            });



            countEducationplus = $("#educationPlusTable >tbody > tr").size();

            $('#educationPlus').click(function () {
                var count = 0;
                countEducationplus += 1;
                count = countEducationplus;
                var name = document.getElementById("<%=PersonName.ClientID %>").value;

                var contributionRemoveZero = 'educationContribution' + count;
                var educationLumpSumMaturityRemoveZero = 'educationLumpSumMaturity' + count;
                var educationProjectedIncomeMaturityRemoveZero = 'educationProjectedIncomeMaturity' + count;

                var educationFrequencyCounter = 'educationFrequency' + count;
                var educationFrequency = "<select style='width:100px' id='" + educationFrequencyCounter + "' name='" + educationFrequencyCounter + "'>";
                educationFrequency += "<option value='Single'>Single</option>";
                educationFrequency += "<option value='Annual'>Annual</option>";
                educationFrequency += "</select>";



                var str = 'educationPlusrowId' + count;
                var row1 = $("<tr id='educationPlusrowId" + count + "' width=100%><td align='left'><input type='text' value='" + name + "' id='educationOwnerName" + count + "' name='educationOwnerName" + count + "' style='width: 100px;'/></td><td><input type='text' id='educationCompany" + count + "' name='educationCompany" + count + "' style='width: 100px;' /></td><td><input type='text' id='educationContribution" + count + "' name='educationContribution" + count + "' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur=removeTrailingZeroesForDynamicRows('" + contributionRemoveZero + "') style='width: 100px;'/></td><td align='left'>" + educationFrequency + "</td><td><input type='text' maxlength='10' onkeypress = 'javascript:allowOnlyNumbersForDates()' id='educationMaturityDate" + count + "' name='educationMaturityDate" + count + "' style='width: 100px;' /></td><td><input type='text'  id='educationLumpSumMaturity" + count + "' name='educationLumpSumMaturity" + count + "'  onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur=removeTrailingZeroesForDynamicRows('" + educationLumpSumMaturityRemoveZero + "') style='width: 100px;'/></td><td align='left'><input type='text' id='educationProjectedIncomeMaturity" + count + "' name='educationProjectedIncomeMaturity" + count + "' style='width: 70px;'  onblur=removeTrailingZeroesForDynamicRows('" + educationProjectedIncomeMaturityRemoveZero + "') onkeypress = 'javascript:allowOnlyNumbers(this.value)'/><a onClick=DeleteEducationRow('" + str + "')>&nbsp;&nbsp;&nbsp;&nbsp;<img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
                $("#educationPlusTable").append(row1);
                $("#educationPlusTable >tbody > tr:last").focusin();
                document.getElementById('<%=educationPlusNumber.ClientID %>').value = count;

                $('input[id^="educationMaturityDate"]').datepicker({
                    showOn: "button",
                    buttonImage: "/_layouts/Zurich/images/calendar.gif",
                    buttonImageOnly: true,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd/mm/yy',
                    yearRange: "-70:+70"

                });
            });

            $(function () {
                $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                $('#factFind').addClass("chassis_application_navigation_selected_tab1");

                var mzaclass = $('#<%=mzatab.ClientID %>').attr("class");
                var pdclass = $('#<%=personaldetailstab.ClientID %>').attr("class");
                var prdclass = $('#<%=prioritydetailstab.ClientID %>').attr("class");
                var ieclass = $('#<%=incomeexpensetab.ClientID %>').attr("class");
                var alclass = $('#<%=assetliabilitytab.ClientID %>').attr("class");

                if ((mzaclass == 'chassis_application_page_complete') && (pdclass == 'chassis_application_page_complete') && (prdclass == 'chassis_application_page_complete') && (ieclass == 'chassis_application_page_complete') && (alclass == 'chassis_application_page_complete')) {
                    $("#factFindtab").addClass("chassis_application_page_complete");
                } else {
                    if ((mzaclass == 'chassis_application_page_warnings') || (pdclass == 'chassis_application_page_warnings') || (prdclass == 'chassis_application_page_warnings') || (ieclass == 'chassis_application_page_warnings') || (alclass == 'chassis_application_page_warnings')) {
                        $("#factFindtab").addClass("chassis_application_page_warnings");
                    }
                }

            });
        });

        $(function () {
            $('input[id^="retirementMaturityDate"]').datepicker({
                showOn: "button",
                buttonImage: "/_layouts/Zurich/images/calendar.gif",
                buttonImageOnly: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
                yearRange: "-70:+70"
            });
        });

        $(function () {
            $('input[id^="educationMaturityDate"]').datepicker({
                showOn: "button",
                buttonImage: "/_layouts/Zurich/images/calendar.gif",
                buttonImageOnly: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
                yearRange: "-70:+70"
            });
        });


        function enableassecertainingAffordabilityReason() {

            var selection = $('#<%=assecertainingAffordabilityEnable.ClientID %> input:checked').val();

            if (selection == "0") {
                $("#liquidityForm :input").attr("disabled", false);
                $("#incomeExpenseForm :input").attr("disabled", false);
                $("#exitingArrangementTowardsProtection :input").attr("disabled", false);
                $("#savingsPlusTable :input").attr("disabled", false);
                $("#retirementPlusTable :input").attr("disabled", false);
                $("#educationPlusTable :input").attr("disabled", false);




                $('#<%=assecertainingAffordabilityReason.ClientID %>').val("");
                $('#<%=assecertainingAffordabilityReason.ClientID %>').hide();
                $('#liquidityForm').show();
                $('#incomeExpenseForm').show();
                //$('#incomeInsuranceEnableTable').show();


            }
            else if (selection == "1" || selection == "0") {
                $("#liquidityForm :input").attr("disabled", true);
                $("#incomeExpenseForm :input").attr("disabled", true);
                $("#exitingArrangementTowardsProtection :input").attr("disabled", true);
                $("#savingsPlusTable :input").attr("disabled", true);
                $("#retirementPlusTable :input").attr("disabled", true);
                $("#educationPlusTable :input").attr("disabled", true);


                $('#<%=assecertainingAffordabilityReason.ClientID %>').show();
                $('#liquidityForm').hide();
                $('#incomeExpenseForm').hide();
                //$('#incomeInsuranceEnableTable').hide();


            }

        }


        function removeZeroesIncomeExpense() {
            if (!isNaN(document.getElementById('<%= emergencyFundsNeeded.ClientID %>').value) && document.getElementById('<%= emergencyFundsNeeded.ClientID %>').value != "") {
                document.getElementById('<%= emergencyFundsNeeded.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= emergencyFundsNeeded.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= netMonthlyIncomeAfterCpf.ClientID %>').value) && document.getElementById('<%= netMonthlyIncomeAfterCpf.ClientID %>').value != "") {
                document.getElementById('<%= netMonthlyIncomeAfterCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= netMonthlyIncomeAfterCpf.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= netMonthlyExpenses.ClientID %>').value) && document.getElementById('<%= netMonthlyExpenses.ClientID %>').value != "") {
                document.getElementById('<%= netMonthlyExpenses.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= netMonthlyExpenses.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= otherSourcesOfIncome.ClientID %>').value) && document.getElementById('<%= otherSourcesOfIncome.ClientID %>').value != "") {
                document.getElementById('<%= otherSourcesOfIncome.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= otherSourcesOfIncome.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathTermInsuranceSA.ClientID %>').value) && document.getElementById('<%= DeathTermInsuranceSA.ClientID %>').value != "") {
                document.getElementById('<%= DeathTermInsuranceSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathTermInsuranceSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathWholeLifeInsuranceSA.ClientID %>').value) && document.getElementById('<%= DeathWholeLifeInsuranceSA.ClientID %>').value != "") {
                document.getElementById('<%= DeathWholeLifeInsuranceSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathWholeLifeInsuranceSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= lifeInsuranceSA.ClientID %>').value) && document.getElementById('<%= lifeInsuranceSA.ClientID %>').value != "") {
                document.getElementById('<%= lifeInsuranceSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= lifeInsuranceSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= tpdcSA.ClientID %>').value) && document.getElementById('<%= tpdcSA.ClientID %>').value != "") {
                document.getElementById('<%= tpdcSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= tpdcSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= criticalIllnessSA.ClientID %>').value) && document.getElementById('<%= criticalIllnessSA.ClientID %>').value != "") {
                document.getElementById('<%= criticalIllnessSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= criticalIllnessSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= mortgageSA.ClientID %>').value) && document.getElementById('<%= mortgageSA.ClientID %>').value != "") {
                document.getElementById('<%= mortgageSA.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= mortgageSA.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathTermInsuranceTerm.ClientID %>').value) && document.getElementById('<%= DeathTermInsuranceTerm.ClientID %>').value != "") {
                document.getElementById('<%= DeathTermInsuranceTerm.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathTermInsuranceTerm.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathWholeLifeInsuranceTerm.ClientID %>').value) && document.getElementById('<%= DeathWholeLifeInsuranceTerm.ClientID %>').value != "") {
                document.getElementById('<%= DeathWholeLifeInsuranceTerm.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathWholeLifeInsuranceTerm.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= lifeInsuranceMV.ClientID %>').value) && document.getElementById('<%= lifeInsuranceMV.ClientID %>').value != "") {
                document.getElementById('<%= lifeInsuranceMV.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= lifeInsuranceMV.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= tpdcMV.ClientID %>').value) && document.getElementById('<%= tpdcMV.ClientID %>').value != "") {
                document.getElementById('<%= tpdcMV.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= tpdcMV.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= criticalIllnessMV.ClientID %>').value) && document.getElementById('<%= criticalIllnessMV.ClientID %>').value != "") {
                document.getElementById('<%= criticalIllnessMV.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= criticalIllnessMV.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= mortgageMV.ClientID %>').value) && document.getElementById('<%= mortgageMV.ClientID %>').value != "") {
                document.getElementById('<%= mortgageMV.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= mortgageMV.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathTermInsurancePremium.ClientID %>').value) && document.getElementById('<%= DeathTermInsurancePremium.ClientID %>').value != "") {
                document.getElementById('<%= DeathTermInsurancePremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathTermInsurancePremium.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= DeathWholeLifeInsurancePremium.ClientID %>').value) && document.getElementById('<%= DeathWholeLifeInsurancePremium.ClientID %>').value != "") {
                document.getElementById('<%= DeathWholeLifeInsurancePremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= DeathWholeLifeInsurancePremium.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= lifeInsurancePremium.ClientID %>').value) && document.getElementById('<%= lifeInsurancePremium.ClientID %>').value != "") {
                document.getElementById('<%= lifeInsurancePremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= lifeInsurancePremium.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= tpdcPremium.ClientID %>').value) && document.getElementById('<%= tpdcPremium.ClientID %>').value != "") {
                document.getElementById('<%= tpdcPremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= tpdcPremium.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= criticalIllnessPremium.ClientID %>').value) && document.getElementById('<%= criticalIllnessPremium.ClientID %>').value != "") {
                document.getElementById('<%= criticalIllnessPremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= criticalIllnessPremium.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= mortgagePremium.ClientID %>').value) && document.getElementById('<%= mortgagePremium.ClientID %>').value != "") {
                document.getElementById('<%= mortgagePremium.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= mortgagePremium.ClientID %>').value);
            }


        }

        function CalculateSurplusShortfall() {

            removeZeroesIncomeExpense();

            var monthlyIncomeAfterCPF = 0;

            if (!isNaN(document.getElementById("<%=netMonthlyIncomeAfterCpf.ClientID %>").value) && document.getElementById("<%=netMonthlyIncomeAfterCpf.ClientID %>").value != "") {
                monthlyIncomeAfterCPF = Math.round(parseFloat(document.getElementById("<%=netMonthlyIncomeAfterCpf.ClientID %>").value));
            }


            var otherSourcesOfIncome = 0;

            if (!isNaN(document.getElementById("<%=otherSourcesOfIncome.ClientID %>").value) && document.getElementById("<%=otherSourcesOfIncome.ClientID %>").value != "") {
                otherSourcesOfIncome = Math.round(parseFloat(document.getElementById("<%=otherSourcesOfIncome.ClientID %>").value));
            }



            var netMonthlyExpenses = 0;

            if (!isNaN(document.getElementById("<%=netMonthlyExpenses.ClientID %>").value) && document.getElementById("<%=netMonthlyExpenses.ClientID %>").value != "") {
                netMonthlyExpenses = Math.round(parseFloat(document.getElementById("<%=netMonthlyExpenses.ClientID %>").value));
            }


            var monthlySavings = 0;
            monthlySavings = (monthlyIncomeAfterCPF + otherSourcesOfIncome) - netMonthlyExpenses;
            document.getElementById('<%=monthlySavings.ClientID %>').value = Math.abs(monthlySavings);

            if (monthlySavings >= 0) {
                $("#totalShortfall").hide();
                $("#totalSurplus").show();
            }
            else {
                $("#totalShortfall").show();
                $("#totalSurplus").hide();
            }

        }


        function removeTrailingZeroesForDynamicRows(param) {
            var temp = $('#' + param).val();
            $('#' + param).val(removeTrailingZeroes(temp));
        }


        function DeleteEducationRow(param) {
            var answer = confirm("Delete Other Education Insurance Plans ?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
                calculateAssets();
            }
            document.getElementById('<%=educationPlusNumber.ClientID %>').value = countEducationplus;
        }


        function DeleteSavingsRow(param) {
            var answer = confirm("Delete Other Savings Insurance Plans ?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
                calculateAssets();
            }
            document.getElementById('<%=savingsPlusNumber.ClientID %>').value = countSavingsplus;
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


        function DeleteRetirementRow(param) {
            var answer = confirm("Delete Other Retirement Insurance Plans ?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
                calculateAssets();
            }
            document.getElementById('<%=retirementPlusNumber.ClientID %>').value = countRetirementplus;
        }




        $(function () {

            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();
            $("#datepicker3").datepicker();
            $("#datepicker4").datepicker();
            $("#datepicker5").datepicker();
            $("#datepicker6").datepicker();
            $("#datepicker7").datepicker();
            $.datepicker.setDefaults($.datepicker.regional['']);


        });

        function printpg() {
            var noofothers = $("#othersplusTable >tbody > tr").size();
            document.getElementById('noofothers').value = noofothers;

            document.getElementById('printpage').value = "true";
            document.forms[0].submit();
        }

        function back() {
            window.location.href = '/AssetLiability/ShowAssetLiability';
        }


        function clearAllErrors() {
            $('[id^="retirementMaturityDate"]').removeClass("dateBackGroundColour");
            $('[id^="educationMaturityDate"]').removeClass("dateBackGroundColour");
        }

        function validateAllFields(oSrc, args) {
            var error1 = false;
            var error2 = false;

            clearAllErrors();

            $('[id^="retirementMaturityDate"]').each(function () {
                var datePickerValue = $(this).val();
                if (datePickerValue != null && datePickerValue != '') {
                    var flag = isDate(datePickerValue);
                    if (flag == false) {
                        $(this).addClass("dateBackGroundColour");
                        error1 = true;
                    }
                }
            });

            $('[id^="educationMaturityDate"]').each(function () {
                var datePickerValue1 = $(this).val();
                if (datePickerValue1 != null && datePickerValue1 != '') {
                    var flag1 = isDate(datePickerValue1);
                    if (flag1 == false) {
                        $(this).addClass("dateBackGroundColour");
                        error2 = true;
                    }
                }
            });

            if (error1 == true || error2 == true)
                args.IsValid = false;
            else
                args.IsValid = true;
        }


        function enableDisableIncomeExpenseFields() {

            var selection = $('#<%=incomeInsuranceEnable.ClientID %> input:checked').val();

            if (selection == "0") {
                $("#exitingArrangementTowardsProtection :input").attr("disabled", false);
                $("#savingsPlusTable :input").attr("disabled", false);
                $("#retirementPlusTable :input").attr("disabled", false);
                $("#educationPlusTable :input").attr("disabled", false);
                $("#exitingArrangementTowardsProtection").show();
                $('#savingsPlusTable').show();
                $('#retirementPlusTable').show();
                $('#educationPlusTable').show();
                $('#<%=incomeExpenseNotNeededReason.ClientID %>').val("");
                $('#<%=incomeExpenseNotNeededReason.ClientID %>').hide();

            }
            else {
                $("#exitingArrangementTowardsProtection :input").attr("disabled", true);
                $("#savingsPlusTable :input").attr("disabled", true);
                $("#retirementPlusTable :input").attr("disabled", true);
                $("#educationPlusTable :input").attr("disabled", true);
                $("#exitingArrangementTowardsProtection").hide();
                $('#savingsPlusTable').hide();
                $('#retirementPlusTable').hide();
                $('#educationPlusTable').hide();

                $('#<%=incomeExpenseNotNeededReason.ClientID %>').show();
            }

        }

    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:HiddenField ID="otherIncomeInsuranceExpenseNumber" runat="server" />
    <asp:HiddenField ID="savingsPlusNumber" runat="server" />
    <asp:HiddenField ID="retirementPlusNumber" runat="server" />
    <asp:HiddenField ID="educationPlusNumber" runat="server" />
    <asp:HiddenField ID="PersonName" runat="server" />
    <asp:HiddenField ID="caseId" runat="server" />
    <asp:HiddenField ID="activityId" runat="server" />
    <asp:HiddenField ID="backToCase" runat="server"  />
    <div id="chassis_outer_container">
        <div class="chassis_page_container">
            <FNAMenutag:FNAMenu runat="server" ID="menu1" />
            <div class="chassis_application_navigation_container">
                <ul>
                    <li>
                        <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                            <div class="chassis_application_navigation_inner">
                                <span id="mzatab" runat="server">
                                    <asp:LinkButton ID="LinkZurichAdvisor" Text="My Zurich Advisor" OnClick="menuClick"
                                        CommandArgument="zurichAdvisor" runat="server" />
                                </span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="chassis_application_navigation_outer">
                            <div class="chassis_application_navigation_inner">
                                <span id="personaldetailstab" runat="server">
                                    <asp:LinkButton ID="LinkPersonalDetail" Text="Personal Details" OnClick="menuClick"
                                        CommandArgument="personalDetail" runat="server" />
                                </span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="chassis_application_navigation_outer">
                            <div class="chassis_application_navigation_inner">
                                <span id="prioritydetailstab" runat="server">
                                    <asp:LinkButton ID="LinkPriorityDetails" Text="Priority Details" OnClick="menuClick"
                                        CommandArgument="priorityDetails" runat="server" />
                                </span>
                            </div>
                        </div>
                    </li>
                    <li class="chassis_application_navigation_selected_tab2">
                        <div class="chassis_application_navigation_outer">
                            <div class="chassis_application_navigation_inner">
                                <span id="incomeexpensetab" runat="server">
                                    <asp:LinkButton ID="LinkIncomeExpense" Text="Income & Expense" OnClick="menuClick"
                                        CommandArgument="incomeExpense" runat="server" />
                                </span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="chassis_application_navigation_outer">
                            <div class="chassis_application_navigation_inner">
                                <span id="assetliabilitytab" runat="server">
                                    <asp:LinkButton ID="LinkAssetLiabilities" Text="Assets / Liabilities" OnClick="menuClick"
                                        CommandArgument="assetLiabilities" runat="server" />
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
                                <asp:Label ID="lblPdSummarySaveSuccess" runat="server" class="chassis_application_save_success"
                                    Text="• Income Insurance Expense details saved successfully"></asp:Label>
                                <asp:Label ID="lblPdSummarySaveFailed" runat="server" class="chassis_application_feedback_error"
                                    Text="• Failed to save Income Insurance Expense details"></asp:Label>
                                <asp:Label ID="lblStatusSubmitted" runat="server" class="chassis_application_save_success"
                                    Text="• Case Status submitted successfully" Visible="false"></asp:Label>
                                <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                                    Text="• Failed to Submit Case Status" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <asp:Repeater ID="ErrorRepeater" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td align="left">
                                    <label class="chassis_application_feedback_error">• <%# Container.DataItem %></label>    
                                </td>
                            </tr>       
                        </ItemTemplate>
                    </asp:Repeater>
                    </table>
                    <div>
                        <asp:ValidationSummary ID="valSummary" runat="server" ShowMessageBox="false" />
                    </div>


                    <table>
                        <tr>
                            <td colspan="4">
                            This information helps to ascertain the affordability of the recommendation(s) and plan(s)
                            for your financial need(s). Would you like your cashflow to be taken into consideration for the Needs Analysis
                            and Recommendation(s)?
                            </td>
                            </tr>
                        <tr>
                            <td colspan="4">
                                <asp:radiobuttonlist id="assecertainingAffordabilityEnable" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                                    <asp:listitem  value="0" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                                    <asp:listitem  value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                                </asp:radiobuttonlist>
                            </td>
                        </tr>
                        <tr>
                         <td colspan="4" >
                         &nbsp;
                         </td>
                        </tr>
                    <tr>
                        <td colspan="4" >
                            <asp:TextBox TextMode="MultiLine" Width="300px" Height="40px" ID="assecertainingAffordabilityReason" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    </table>


                    <table class="chassis_four_column_list" id="liquidityForm">
                        <thead>
                            <tr>
                                <td colspan="4">
                                    Liquidity
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="chassis_label_column">
                                    Emergency Funds Needed
                                </td>
                                <td class="chassis_data_column">
                                    S$<asp:TextBox ID="emergencyFundsNeeded" OnKeyPress="javascript:allowOnlyNumbers(this.value)"
                                        CssClass="chassis_application_small_text_box" runat="server"></asp:TextBox>
                                </td>
                                <td class="chassis_data_column">
                                    Any factors that will significantly affect your Income/Expenses in the next 12 Months?
                                </td>
                                <td class="chassis_data_column">
                                    <asp:DropDownList ID="shortTermGoals" CssClass="chassis_application_medium_select_list"
                                        runat="server" Width="100px">
                                        <asp:ListItem Value="No">No</asp:ListItem>
                                        <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr id="significantFactorDetails">
                                <td class="chassis_label_column">
                                </td>
                                <td class="chassis_data_column">
                                </td>
                                <td class="chassis_data_column" style="vertical-align: top;">
                                    If Yes, please provide details
                                </td>
                                <td class="chassis_data_column">
                                    <asp:TextBox ID="extraDetails" TextMode="MultiLine" Width="200px" Height="50px" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="chassis_four_column_list" id="incomeExpenseForm">
                        <thead>
                            <tr>
                                <td colspan="4">
                                    Income & Expense
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="chassis_label_column">
                                    Monthly income after CPF
                                </td>
                                <td class="chassis_data_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="netMonthlyIncomeAfterCpf"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    Monthly Expenses
                                </td>
                                <td class="chassis_data_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="netMonthlyExpenses"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="chassis_label_column">
                                    Other Sources of income, e.g. rental, business?
                                </td>
                                <td class="chassis_data_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="otherSourcesOfIncome"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <b>Total <span id="totalShortfall" style="color: Red">Shortfall</span> <span id="totalSurplus">
                                        Surplus</span></b>
                                </td>
                                <td class="chassis_data_column">
                                    <asp:TextBox ID="monthlySavings" CssClass="chassis_application_small_text_box" runat="server"
                                        ReadOnly="true" BackColor="#E0E0E0"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table id="incomeInsuranceEnableTable">
                        <tr>
                            <td colspan="4">This information helps to evaluate if your existing insurance portfolio is adequate in meeting your financial needs(s).
                            Would you like your existing insurance portfolio to be taken into consideration for the Needs Analysis and Recommendations(s)?</td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:radiobuttonlist id="incomeInsuranceEnable" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                                    <asp:listitem  value="0" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                                    <asp:listitem  value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                                </asp:radiobuttonlist>
                            </td>
                        </tr>
                        <tr>
                         <td colspan="4" >
                         &nbsp;
                         </td>
                        </tr>
                    <tr>
                        <td colspan="4" >
                            <asp:TextBox TextMode="MultiLine" Width="300px" Height="40px" ID="incomeExpenseNotNeededReason" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    </table>
                     
                   
                    <table class="chassis_four_column_list" id="exitingArrangementTowardsProtection">
                        <thead>
                            <tr>
                                <td colspan="7">
                                    Existing Arrangements Towards Protection &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: xx-small;
                                        color: Gray;">Specify the value only in case where the applicant is the Life to
                                        be Assured</span>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table_header">
                                <td class="chassis_label_column" />
                                <td class="chassis_label_column">
                                    Death<br />
                                    (Term)
                                </td>
                                <td class="chassis_label_column">
                                    Death<br />
                                    (Whole Life)
                                </td>
                                <td class="chassis_label_column">
                                    Death<br />
                                    (CPF-funded)
                                </td>
                                <td>
                                    Total Permanent Disability
                                </td>
                                <td class="chassis_label_column">
                                    Critical Illness Protection
                                </td>
                                <td class="chassis_label_column">
                                    Mortgage Protection
                                </td>
                            </tr>
                            <tr style="color: Black; background-color: #E2E8F1;">
                                <td class="chassis_label_column">
                                    <b>Sum Assured</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsuranceSA"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsuranceSA"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsuranceSA" runat="server"
                                        OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="tpdcSA" runat="server"
                                        OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessSA"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox Width="100px" ID="mortgageSA" runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: Black; background-color: #F8F8F8;">
                                <td class="chassis_label_column">
                                    <b>Term</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsuranceTerm"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsuranceTerm"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsuranceMV" runat="server"
                                        OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="tpdcMV" runat="server"
                                        OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessMV"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox Width="100px" ID="mortgageMV" runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="color: Black; background-color: #E2E8F1;">
                                <td class="chassis_label_column">
                                    <b>Premium (per year)</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsurancePremium"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsurancePremium"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsurancePremium"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="tpdcPremium" runat="server"
                                        OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessPremium"
                                        runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                                <td class="chassis_label_column">
                                    <asp:TextBox Width="100px" ID="mortgagePremium" runat="server" OnKeyPress="javascript:allowOnlyNumbers(this.value)"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <table class="chassis_four_column_list" id="savingsPlusTable">
                        <thead>
                            <tr>
                                <td colspan="7">
                                    <a href="#" id="savingsPlus">
                                        <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/add-icon.jpg" /></a>
                                    Existing Arrangements Towards Savings &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: xx-small;
                                        color: Gray;">Specify the value only in case where the applicants are Policy Owners</span>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table_header">
                                <td class="chassis_label_column">
                                    Policy Owner
                                </td>
                                <td class="chassis_label_column">
                                    Purpose of the Plan
                                </td>
                                <td class="chassis_label_column">
                                    Company
                                </td>
                                <td class="chassis_label_column">
                                    Contribution
                                </td>
                                <td class="chassis_label_column">
                                    Frequency
                                </td>
                                <td class="chassis_label_column">
                                    Term
                                </td>
                                <td class="chassis_label_column">
                                    Current Fund Value
                                </td>
                            </tr>
                            <asp:Repeater ID="incomeInsuranceExpenseSavingRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='savingsPlusrowId<%# Container.ItemIndex+1%>'>
                                        <td>
                                            <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;' id="savingsOwnerName<%# Container.ItemIndex+1%>"
                                                name="savingsOwnerName<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("natureOfPlan") %>' id="savingsNatureOfPlan<%# Container.ItemIndex+1%>"
                                                name="savingsNatureOfPlan<%# Container.ItemIndex+1%>" style="width: 100px;" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("company") %>' style='width: 100px;' id="savingsCompany<%# Container.ItemIndex+1%>"
                                                name="savingsCompany<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("contribution") %>' id="savingsContribution<%# Container.ItemIndex+1%>"
                                                name="savingsContribution<%# Container.ItemIndex+1%>" style="width: 100px;" onkeypress="javascript:allowOnlyNumbers(this.value)" onblur="javascript:removeTrailingZeroesForDynamicRows('savingsContribution<%# Container.ItemIndex+1%>')" />
                                        </td>
                                        <td align=left>
                                            <select style="width:100px" id="savingsFrequency<%# Container.ItemIndex+1%>" name="savingsFrequency<%# Container.ItemIndex+1%>">
                                                <option value="Single" <%# Eval("frequency").ToString().Trim() =="Single" ? "Selected":"" %> >Single</option>
                                                <option value="Annual" <%# Eval("frequency").ToString().Trim() =="Annual" ? "Selected":"" %> >Annual</option>
                                            </select>
                                        </td>

                                        <td>
                                            <input type='text' value='<%# Eval("term") %>' style='width: 100px;' id="savingsTerm<%# Container.ItemIndex+1%>"
                                                name="savingsTerm<%# Container.ItemIndex+1%>" onkeypress="javascript:allowOnlyNumbers(this.value)" onblur="javascript:removeTrailingZeroesForDynamicRows('savingsTerm<%# Container.ItemIndex+1%>')" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("fundValue") %>' id="savingsCurrentFundValue<%# Container.ItemIndex+1%>"
                                                name="savingsCurrentFundValue<%# Container.ItemIndex+1%>" style="width: 70px;"
                                                onkeypress="javascript:allowOnlyNumbers(this.value)" onblur="javascript:removeTrailingZeroesForDynamicRows('savingsCurrentFundValue<%# Container.ItemIndex+1%>')"/>
                                            &nbsp;&nbsp;<a onclick="DeleteSavingsRow('savingsPlusrowId<%# Container.ItemIndex+1%>')">
                                                <img style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png'
                                                    alt='' /></a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    <table class="chassis_four_column_list" id="retirementPlusTable">
                        <thead>
                            <tr>
                                <td colspan="7">
                                    <a href="#" id="retirementPlus">
                                        <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/add-icon.jpg" /></a>
                                    Existing Arrangements Towards Retirement &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: xx-small;
                                        color: Gray;">Specify the value only in case where the applicants are Policy Owners</span>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table_header">
                                <td class="chassis_label_column">
                                    Policy Owner
                                </td>
                                <td class="chassis_label_column">
                                    Company/Plan
                                </td>
                                <td class="chassis_label_column">
                                    Contribution
                                </td>
                                <td class="chassis_label_column">
                                    Frequency
                                </td>
                                <td class="chassis_label_column">
                                    Maturity Date
                                </td>
                                <td class="chassis_label_column">
                                    Projected Lumpsum at Maturity
                                </td>
                                <td class="chassis_label_column">
                                    Projected Income at Maturity
                                </td>
                            </tr>
                            <asp:Repeater ID="incomeInsuranceExpenseRetirementRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='retirementPlusTable<%# Container.ItemIndex+1%>'>
                                        <td>
                                            <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;' id="retirementOwnerName<%# Container.ItemIndex+1%>"
                                                name="retirementOwnerName<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("company") %>' style='width: 100px;' id="retirementCompany<%# Container.ItemIndex+1%>"
                                                name="retirementCompany<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("contribution") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="retirementContribution<%# Container.ItemIndex+1%>" name="retirementContribution<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('retirementContribution<%# Container.ItemIndex+1%>')"
                                                style="width: 100px;" />
                                        </td>
                                        <td align=left>
                                            <select style="width:100px" id="retirementFrequency<%# Container.ItemIndex+1%>" name="retirementFrequency<%# Container.ItemIndex+1%>">
                                                <option value="Single" <%# Eval("frequency").ToString().Trim() =="Single" ? "Selected":"" %> >Single</option>
                                                <option value="Annual" <%# Eval("frequency").ToString().Trim() =="Annual" ? "Selected":"" %> >Annual</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("maturityDate") %>' onkeypress="javascript:allowOnlyNumbersForDates()"
                                                style='width: 100px;' maxlength='10' id="retirementMaturityDate<%# Container.ItemIndex+1%>"
                                                name="retirementMaturityDate<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("projectedLumpSumMaturity") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="retirementLumpSumMaturity<%# Container.ItemIndex+1%>" name="retirementLumpSumMaturity<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('retirementLumpSumMaturity<%# Container.ItemIndex+1%>')"
                                                style="width: 100px;" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("projectedIncomeMaturity") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="retirementProjectedIncomeMaturity<%# Container.ItemIndex+1%>" name="retirementProjectedIncomeMaturity<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('retirementProjectedIncomeMaturity<%# Container.ItemIndex+1%>')"
                                                style="width: 70px;" />
                                            &nbsp;&nbsp;<a onclick="DeleteRetirementRow('retirementPlusTable<%# Container.ItemIndex+1%>')">
                                                <img style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png'
                                                    alt='' /></a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    <table class="chassis_four_column_list" id="educationPlusTable">
                        <thead>
                            <tr>
                                <td colspan="7">
                                    <a href="#" id="educationPlus">
                                        <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/add-icon.jpg" /></a>
                                    Existing Arrangements Towards Children's Education<span style="font-size: x-small;"></span>
                                    &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: xx-small; color: Gray;">Specify the
                                        value only in case where the applicants are Policy Owners</span>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="table_header">
                                <td class="chassis_label_column">
                                    Policy Owner
                                </td>
                                <td class="chassis_label_column">
                                    Company/Plan
                                </td>
                                <td class="chassis_label_column">
                                    Contribution
                                </td>
                                <td class="chassis_label_column">
                                    Frequency
                                </td>
                                <td class="chassis_label_column">
                                    Maturity Date
                                </td>
                                <td class="chassis_label_column">
                                    Projected Lumpsum at Maturity
                                </td>
                                <td class="chassis_label_column">
                                    Projected Income at Maturity
                                </td>
                            </tr>
                            <asp:Repeater ID="incomeInsuranceExpenseEducationRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='educationPlusrowId<%# Container.ItemIndex+1%>'>
                                        <td>
                                            <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;' id="educationOwnerName<%# Container.ItemIndex+1%>"
                                                name="educationOwnerName<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("company") %>' style='width: 100px;' id="educationCompany<%# Container.ItemIndex+1%>"
                                                name="educationCompany<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("contribution") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="educationContribution<%# Container.ItemIndex+1%>" name="educationContribution<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('educationContribution<%# Container.ItemIndex+1%>')"
                                                style="width: 100px;" />
                                        </td>
                                        <td align=left>
                                            <select style="width:100px" id="educationFrequency<%# Container.ItemIndex+1%>" name="educationFrequency<%# Container.ItemIndex+1%>">
                                                <option value="Single" <%# Eval("frequency").ToString().Trim() =="Single" ? "Selected":"" %> >Single</option>
                                                <option value="Annual" <%# Eval("frequency").ToString().Trim() =="Annual" ? "Selected":"" %> >Annual</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type='text' maxlength='10' value='<%# Eval("maturityDate") %>' onkeypress="javascript:allowOnlyNumbersForDates()"
                                                style='width: 100px;' id="educationMaturityDate<%# Container.ItemIndex+1%>" name="educationMaturityDate<%# Container.ItemIndex+1%>" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("projectedLumpSumMaturity") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="educationLumpSumMaturity<%# Container.ItemIndex+1%>" name="educationLumpSumMaturity<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('educationLumpSumMaturity<%# Container.ItemIndex+1%>')"
                                                style="width: 100px;" />
                                        </td>
                                        <td>
                                            <input type='text' value='<%# Eval("projectedIncomeMaturity") %>' onkeypress="javascript:allowOnlyNumbers(this.value)"
                                                id="educationProjectedIncomeMaturity<%# Container.ItemIndex+1%>" name="educationProjectedIncomeMaturity<%# Container.ItemIndex+1%>"
                                                onblur="javascript:removeTrailingZeroesForDynamicRows('educationProjectedIncomeMaturity<%# Container.ItemIndex+1%>')"
                                                style="width: 70px;" />
                                            &nbsp;&nbsp;<a onclick="DeleteEducationRow('educationPlusrowId<%# Container.ItemIndex+1%>')">
                                                <img style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png'
                                                    alt='' /></a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    <table width="100%">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CustomValidator ID="CustomValidator" runat="server" ControlToValidate="emergencyFundsNeeded"
                                    Display="None" ValidateEmptyText="True" ErrorMessage="Maturity Date is invalid"
                                    ClientValidationFunction="validateAllFields" />
                            </td>
                        </tr>
                    </table>

                    <table class="chassis_two_column_list">
                    <tbody>
                        <tr>
                        <td colspan="3">
                        <table width="100%">
                            <tr align="right">
                                <td>

                                <asp:Button ID="Button1" runat="server" Text="Generate Pdf" OnClick="createIncomeexpensePdf"
                                    class="chassis_application_button_xxxlarge" />
                                <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server"
                                    Text="Previous" OnClick="saveIncomeAndInsuranceDetailsBack" />
                                <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server"
                                    Text="Save" OnClick="saveIncomeInsuranceExpenseDetails" />
                                <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server"
                                    Text="Next" OnClick="saveIncomeInsuranceExpenseNext" />
                                <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server"
                                    Text="Back To Case Portal" OnClientClick="onBackToCase()" OnClick="redirectToCasePortal" />

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
    Income Insurance Expense
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    Income Insurance Expense
</asp:Content>