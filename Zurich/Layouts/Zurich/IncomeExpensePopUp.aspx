<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncomeExpensePopUp.aspx.cs" Inherits="Zurich.Layouts.Zurich.IncomeExpensePopUp" MasterPageFile="~/_layouts/Zurich/master/minimal.master" %>


<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">


<link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
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

<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        $('input').attr("readonly", true);
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

        $(function () {
            $('#chassis_page_navigation_selected').attr('id', '');
            $('a[name=factFind]').attr('id', 'chassis_page_navigation_selected');
        });
    });

    function CalculateSurplusShortfall() {

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
        document.getElementById('<%=monthlySavings.ClientID %>').value = monthlySavings;

    }


    function DeleteRow(param) {
        var answer = confirm("Delete Other Existing Insurance Plans ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
            calculateAssets();
        }
        else {

        }


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

    function allowOnlyNumbers() {
        if (event.keyCode < 46 || event.keyCode > 57) {
            event.returnValue = false;
        }
    } 

    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="otherIncomeInsuranceExpenseNumber" runat="server"  />
<asp:HiddenField ID="savingsPlusNumber" runat="server"  />
<asp:HiddenField ID="retirementPlusNumber" runat="server"  />
<asp:HiddenField ID="educationPlusNumber" runat="server"  />
<asp:HiddenField ID="PersonName" runat="server"  />

<asp:HiddenField ID="caseId" runat="server"  />
<asp:HiddenField ID="activityId" runat="server"  />
<div id="chassis_outer_container">
<div class="chassis_page_container">

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
                    Text="• Case Status submitted successfully" Visible = "false"></asp:Label>
                <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                    Text="• Failed to Submit Case Status" Visible = "false"></asp:Label>
                    </td>
                </tr>
            </table>
        <table class="chassis_two_column_list">
        <thead>
                <tr>
                    <td colspan="2">Income & Expense / Existing Arrangements</td>
                </tr>
            </thead>
        </table>

        <table class="chassis_four_column_list">
        <thead>
                <tr>
                    <td colspan="4">Liquidity</td>
                </tr>
         </thead>
         <tbody>
         <tr>
            <td class="chassis_label_column">Emergency Funds Needed</td>
            <td class="chassis_data_column">
                S$<asp:TextBox ID="emergencyFundsNeeded" OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_small_text_box" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="emergencyFundsNeeded" Display="None" ErrorMessage="Please enter Emergency Funds Needed" runat="server" ID="vPriorityNeed1" >*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="emergencyFundsNeeded" ErrorMessage="Emergency Funds Needed has to be a numeric field" ValidationExpression="\d+" Display="None" />
            </td>
             <td class="chassis_data_column">Any factors that will significantly affect your Income/Expenses in the next 12 Months?</td>
             <td class="chassis_data_column">
                <asp:DropDownList ID="shortTermGoals" CssClass="chassis_application_medium_select_list" runat="server" Width="100px">
                    <asp:ListItem Value="No">No</asp:ListItem>
                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                </asp:DropDownList> 
             </td>
         </tr>
         <tr id="significantFactorDetails">
            <td class="chassis_label_column"></td>
            <td class="chassis_data_column"></td>
            <td class="chassis_data_column" style="vertical-align: top;">
                If Yes, please provide details
            </td>
            <td class="chassis_data_column">
                <asp:TextBox ID="extraDetails" TextMode="MultiLine" Width="200px" Height="50px" runat="server"></asp:TextBox>
            </td>
         </tr>
         </tbody>
        </table>
        
        <table class="chassis_four_column_list">
        <thead>
                <tr>
                    <td colspan="4">Income & Expense</td>
                </tr>
         </thead>
         <tbody>
               <tr>
                <td class="chassis_label_column"> Monthly income after CPF</td>
                <td class="chassis_data_column">
                    <asp:TextBox CssClass="chassis_application_small_text_box" ID="netMonthlyIncomeAfterCpf" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="netMonthlyIncomeAfterCpf" Display="None" ErrorMessage="Please enter Net Monthly Income After CPF" runat="server" ID="RequiredFieldValidator1" >*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="netMonthlyIncomeAfterCpf" ErrorMessage="Net Monthly Income After CPF has to be a numeric field" ValidationExpression="\d+" Display="None" />
                
                </td>
                <td class="chassis_label_column">
                    Monthly Expenses
                </td>
                <td class="chassis_data_column">
                    <asp:TextBox CssClass="chassis_application_small_text_box"  ID="netMonthlyExpenses" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                </td>
             </tr>

             <tr>
                <td class="chassis_label_column"> Other Sources of income, e.g. rental, business?</td>
                <td class="chassis_data_column">
                    <asp:TextBox CssClass="chassis_application_small_text_box"  ID="otherSourcesOfIncome" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='CalculateSurplusShortfall()'></asp:TextBox>
                </td>
                <td class="chassis_label_column">
                    Surplus / Shortfall
                </td>
                <td class="chassis_data_column">
                    <asp:TextBox ID="monthlySavings" CssClass="chassis_application_small_text_box" runat="server" ReadOnly="true" BackColor="#E0E0E0" ></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="monthlySavings" Display="None" ErrorMessage="Please enter Monthly Saving Details" runat="server" ID="RequiredFieldValidator2" >*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="monthlySavings" ErrorMessage="Monthly Savings has to be a numeric field" ValidationExpression="\d+" Display="None" />
                </td>
             </tr>
         </tbody>
        </table>


        <table class="chassis_four_column_list">
        <thead>
                <tr>
                    <td colspan="7">Existing Arrangements Towards Protection &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:xx-small;color:Gray;">Specify and mention the value only in case where the applicant is the Life to be Assured</span></td>
                </tr>
            </thead>
            <tbody>
                <tr class="table_header">
                    <td class="chassis_label_column"/>
                    <td class="chassis_label_column"> Death<br />
                    (Term)</td>
                    <td class="chassis_label_column"> Death<br />
                    (Whole Life)</td>
                    <td class="chassis_label_column"> Death<br />
                    (CPF-funded)</td>
                    <td>Total Permanent Disability</td>
                    <td class="chassis_label_column">Critical Illness Protection</td>
                    <td class="chassis_label_column">Mortgage Protection</td>
                </tr>
                <tr style="color:Black;background-color:#E2E8F1;">
                    <td class="chassis_label_column"><b>Sum Assured</b></td>
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsuranceSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsuranceSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsuranceSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="lifeInsuranceSA" Display="None" ErrorMessage="Please enter Life Insurance SA details" runat="server" ID="RequiredFieldValidator3" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="lifeInsuranceSA" ErrorMessage="Life Insurance SA has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="tpdcSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="tpdcSA" Display="None" ErrorMessage="Please enter Total Permanent Disability Cover Sum Assured details" runat="server" ID="RequiredFieldValidator8" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="tpdcSA" ErrorMessage="Total Permanent Disability Cover Sum Assured has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="criticalIllnessSA" Display="None" ErrorMessage="Please enter Critical Illness Sum Assured details" runat="server" ID="RequiredFieldValidator12" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="criticalIllnessSA" ErrorMessage="Critical Illness Sum Assured has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox Width="100px" ID="mortgageSA" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="mortgageSA" Display="None" ErrorMessage="Please enter Mortgage Sum Assured details" runat="server" ID="RequiredFieldValidator22" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator22" runat="server" ControlToValidate="mortgageSA" ErrorMessage="Mortgage Sum Assured Details has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                </tr>
                <tr style="color:Black;background-color:#F8F8F8;">
                    <td class="chassis_label_column"><b>Term</b></td>
                    
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsuranceTerm" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsuranceTerm" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>

                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsuranceMV" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="lifeInsuranceMV" Display="None" ErrorMessage="Please enter Life Insurance MV details" runat="server" ID="RequiredFieldValidator4" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="lifeInsuranceMV" ErrorMessage="Life Insurance MV has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                       <asp:TextBox  CssClass="chassis_application_small_text_box" ID="tpdcMV" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                       <asp:RequiredFieldValidator ControlToValidate="tpdcMV" Display="None" ErrorMessage="Please enter Total Permanent Disability Cover Maturity Value details" runat="server" ID="RequiredFieldValidator9" >*</asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="tpdcMV" ErrorMessage="Total Permanent Disability Cover Maturity Value has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessMV" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="criticalIllnessMV" Display="None" ErrorMessage="Please enter Critical Illness Maturity Value details" runat="server" ID="RequiredFieldValidator13" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="criticalIllnessMV" ErrorMessage="Critical Illness Maturity Value has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox width="100px" ID="mortgageMV" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="mortgageMV" Display="None" ErrorMessage="Please enter Mortgage Maturity Value details" runat="server" ID="RequiredFieldValidator23" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server" ControlToValidate="mortgageMV" ErrorMessage="Mortgage Maturity Value Details has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                </tr>
                <tr style="color:Black;background-color:#E2E8F1;">
                    <td class="chassis_label_column"><b>Premium</b></td>
                    
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathTermInsurancePremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>
                    <td >
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="DeathWholeLifeInsurancePremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                    </td>

                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="lifeInsurancePremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="lifeInsurancePremium" Display="None" ErrorMessage="Please enter Life Insurance Premium details" runat="server" ID="RequiredFieldValidator6" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="lifeInsurancePremium" ErrorMessage="Life Insurance Premium has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="tpdcPremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="tpdcPremium" Display="None" ErrorMessage="Please enter Total Permanent Disability Cover Premium details" runat="server" ID="RequiredFieldValidator11" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="tpdcPremium" ErrorMessage="Total Permanent Disability Cover Premium has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox CssClass="chassis_application_small_text_box" ID="criticalIllnessPremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="criticalIllnessPremium" Display="None" ErrorMessage="Please enter Critical Illness Premium details" runat="server" ID="RequiredFieldValidator15" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator15" runat="server" ControlToValidate="criticalIllnessPremium" ErrorMessage="Critical Illness Premium has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                    <td class="chassis_label_column">
                        <asp:TextBox  Width="100px" ID="mortgagePremium" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="mortgagePremium" Display="None" ErrorMessage="Please enter Mortgage Premium details" runat="server" ID="RequiredFieldValidator25" >*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator25" runat="server" ControlToValidate="mortgagePremium" ErrorMessage="Mortgage Premium details has to be a numeric field" ValidationExpression="\d+" Display="None" />
                    </td>
                </tr>
            </tbody>
        </table>

        <br/>
        <br/>
         <br/>
         <br/>

        <table class="chassis_four_column_list" id="savingsPlusTable">
            <thead>
                <tr>
                    <td colspan="6">
                    Existing Arrangements Towards Savings &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:xx-small;color:Gray;">Specify and mention the value only in case where the applicants are Policy Owners</span></td>
                </tr>
            </thead>
            <tbody>
                    <tr class="table_header">
                        <td class="chassis_label_column">Policy Owner</td>
                        <td class="chassis_label_column">Purpose of the Plan</td>
                        <td class="chassis_label_column">Company</td>
                        <td class="chassis_label_column">Contribution</td>
                        <td class="chassis_label_column">Term</td>
                        <td class="chassis_label_column">Current Fund Value</td>
                      </tr>


                      <asp:Repeater ID="incomeInsuranceExpenseSavingRepeater" runat="server">
                        <ItemTemplate>
                            <tr id='savingsPlusrowId<%# Container.ItemIndex+1%>'>
                                    
                                    <td>
                                        <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;'  id="savingsOwnerName<%# Container.ItemIndex+1%>" name="savingsOwnerName<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("natureOfPlan") %>' id="savingsNatureOfPlan<%# Container.ItemIndex+1%>" name="savingsNatureOfPlan<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("company") %>' style='width: 100px;'  id="savingsCompany<%# Container.ItemIndex+1%>" name="savingsCompany<%# Container.ItemIndex+1%>"/>    
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("contribution") %>' id="savingsContribution<%# Container.ItemIndex+1%>" name="savingsContribution<%# Container.ItemIndex+1%>" style="width: 100px;" onkeypress = "javascript:allowOnlyNumbers()"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("term") %>' style='width: 100px;'  id="savingsTerm<%# Container.ItemIndex+1%>" name="savingsTerm<%# Container.ItemIndex+1%>" onkeypress = "javascript:allowOnlyNumbers()"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("fundValue") %>' id="savingsCurrentFundValue<%# Container.ItemIndex+1%>" name="savingsCurrentFundValue<%# Container.ItemIndex+1%>" style="width: 100px;" onkeypress = "javascript:allowOnlyNumbers()"/>    
                                        &nbsp;&nbsp;
                                    </td>
                                </tr>       
                        </ItemTemplate>
                    </asp:Repeater>

            </tbody>
        </table>
        <br/>
        <br/>
        <br/>
        <br/>

        <table class="chassis_four_column_list" id="retirementPlusTable">
        <thead>
                <tr>
                    <td colspan="6">
                        Existing Arrangements Towards Retirement &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:xx-small;color:Gray;">Specify and mention the value only in case where the applicants are Policy Owners</span></td>
                </tr>
            </thead>
            <tbody>
                    <tr class="table_header">
                        <td class="chassis_label_column">Policy Owner</td>
                        <td class="chassis_label_column">Company/Plan</td>
                        <td class="chassis_label_column">Contribution</td>
                        <td class="chassis_label_column">Maturity Date</td>
                        <td class="chassis_label_column">Projected Lumpsum at Maturity</td>
                        <td class="chassis_label_column">Projected Income at Maturity</td>
                      </tr>

                       <asp:Repeater ID="incomeInsuranceExpenseRetirementRepeater" runat="server">
                        <ItemTemplate>
                            <tr id='retirementPlusTable<%# Container.ItemIndex+1%>'>
                                    <td>
                                        <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;'  id="retirementOwnerName<%# Container.ItemIndex+1%>" name="retirementOwnerName<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("company") %>' style='width: 100px;'  id="retirementCompany<%# Container.ItemIndex+1%>" name="retirementCompany<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("contribution") %>' onkeypress = "javascript:allowOnlyNumbers()" id="retirementContribution<%# Container.ItemIndex+1%>" name="retirementContribution<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("maturityDate") %>' onkeypress = "javascript:allowOnlyNumbers()" style='width: 100px;'  id="retirementMaturityDate<%# Container.ItemIndex+1%>" name="retirementMaturityDate<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("projectedLumpSumMaturity") %>' onkeypress = "javascript:allowOnlyNumbers()" id="retirementLumpSumMaturity<%# Container.ItemIndex+1%>" name="retirementLumpSumMaturity<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("projectedIncomeMaturity") %>' onkeypress = "javascript:allowOnlyNumbers()" id="retirementProjectedIncomeMaturity<%# Container.ItemIndex+1%>" name="retirementProjectedIncomeMaturity<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                        &nbsp;&nbsp;
                                    </td>
                                </tr>       
                        </ItemTemplate>
                    </asp:Repeater>
            </tbody>
        </table>
        <br/>
        <br/>
        <br/>
        <br/>
        <table class="chassis_four_column_list" id="educationPlusTable">
        <thead>
                <tr>
                    <td colspan="6">
                        Existing Arrangements Towards Children's Education<span style="font-size:x-small;"></span> &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:xx-small;color:Gray;">Specify and mention the value only in case where the applicants are Policy Owners</span></td>
                </tr>
            </thead>
            <tbody>
                    <tr class="table_header">
                        <td class="chassis_label_column">Policy Owner </td>
                        <td class="chassis_label_column">Company/Plan</td>
                        <td class="chassis_label_column">Contribution</td>
                        <td class="chassis_label_column">Maturity Date</td>
                        <td class="chassis_label_column">Projected Lumpsum at Maturity</td>
                        <td class="chassis_label_column">Projected Income at Maturity</td>
                      </tr>


                       <asp:Repeater ID="incomeInsuranceExpenseEducationRepeater" runat="server">
                        <ItemTemplate>
                            <tr id='educationPlusrowId<%# Container.ItemIndex+1%>'>
                                    <td>
                                        <input type='text' value='<%# Eval("policyOwnerName") %>' style='width: 100px;'  id="educationOwnerName<%# Container.ItemIndex+1%>" name="educationOwnerName<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("company") %>' style='width: 100px;'  id="educationCompany<%# Container.ItemIndex+1%>" name="educationCompany<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("contribution") %>' onkeypress = "javascript:allowOnlyNumbers()" id="educationContribution<%# Container.ItemIndex+1%>" name="educationContribution<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                    </td>
                                    <td>
                                        <input type='text' value='<%# Eval("maturityDate") %>' onkeypress = "javascript:allowOnlyNumbers()" style='width: 100px;'  id="educationMaturityDate<%# Container.ItemIndex+1%>" name="educationMaturityDate<%# Container.ItemIndex+1%>"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("projectedLumpSumMaturity") %>' onkeypress = "javascript:allowOnlyNumbers()" id="educationLumpSumMaturity<%# Container.ItemIndex+1%>" name="educationLumpSumMaturity<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                    </td>
                                    <td>
                                        <input type='text'  value='<%# Eval("projectedIncomeMaturity") %>' onkeypress = "javascript:allowOnlyNumbers()" id="educationProjectedIncomeMaturity<%# Container.ItemIndex+1%>" name="educationProjectedIncomeMaturity<%# Container.ItemIndex+1%>" style="width: 100px;"/>
                                        &nbsp;&nbsp;
                                    </td>
                                </tr>       
                        </ItemTemplate>
                    </asp:Repeater>
            </tbody>
        </table>

        <table width="100%">
        <tr>
        <td>&nbsp;</td>
        </tr>
        </table>

</div>
</div>
</div>
</div>
</asp:Content>


<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Income Insurance Expense
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Income & Expense / Existing Arrangements
</asp:Content>
