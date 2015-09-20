<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cka.aspx.cs" Inherits="Zurich.Layouts.Zurich.RiskProfile.Cka" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Site.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />

<link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui-i18n.min.js" type="text/javascript"></script>
<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />


<script language="javascript" type="text/javascript">
    $(document).ready(function () {



        isCKAFilled();

        $("input[type=radio]").click(function () {
            isCKAFilled();
        });

        $(function () {
            $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
            $('#riskProfile').addClass("chassis_application_navigation_selected_tab1");

            var rpclass = $('#<%=riskprofiletab.ClientID %>').attr("class");
            var ckaclass = $('#<%=ckatab.ClientID %>').attr("class");

            if ((rpclass == 'chassis_application_page_complete') && (ckaclass == 'chassis_application_page_complete')) {
                $("#riskprofiletab").addClass("chassis_application_page_complete");
            } else {
                if ((rpclass == 'chassis_application_page_warnings') || (ckaclass == 'chassis_application_page_warnings')) {
                    $("#riskprofiletab").addClass("chassis_application_page_warnings");
                }
            }

        });
    });
    </script>
    <script language="javascript" type="text/javascript">
        function popitup(url) {
            newwindow = window.open(url, 'name', 'height=900,width=1200');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function changerpcalculated() {
            document.getElementById('riskprofile').value = document.getElementById('riskProfileList')[document.getElementById('riskProfileList').selectedIndex].text;
        }

        function riskProfileSubmit() {
            document.getElementById('printpage').value = "false";
            document.getElementById('riskprofile').value = document.getElementById('riskProfileList')[document.getElementById('riskProfileList').selectedIndex].text;
            document.forms[0].submit();
        }

        function printpg() {

            document.getElementById('printpage').value = "true";
            document.forms[0].submit();
        }

        function isCKAFilled() {
            var investmentExperienceOption1 = $('#<%=investmentExperienceOption1.ClientID %>').is(':checked');
            var workingExperienceOption1 = $('#<%=workingExperienceOption1.ClientID %>').is(':checked');
            var educationalExperienceOption1 = $('#<%=educationalExperienceOption1.ClientID %>').is(':checked');

            var investmentExperienceOption2 = $('#<%=investmentExperienceOption2.ClientID %>').is(':checked');
            var workingExperienceOption2 = $('#<%=workingExperienceOption2.ClientID %>').is(':checked');
            var educationalExperienceOption2 = $('#<%=educationalExperienceOption2.ClientID %>').is(':checked');

            var investmentOption = areBothEmpty(investmentExperienceOption1, investmentExperienceOption2);
            var workingOption = areBothEmpty(workingExperienceOption1, workingExperienceOption2);
            var educationOption = areBothEmpty(educationalExperienceOption1, educationalExperienceOption2);

           

            if (investmentExperienceOption2 == true) {
                $('#investmentExperienceListdiv').hide();
                $('#<%=investmentExperienceList.ClientID %>').val("");                
            }

            if (workingExperienceOption2 == true) {
                $('#workingExperienceListDiv').hide();
                $('#<%=workingExperienceList.ClientID %>').val("");
            }


            if (educationalExperienceOption2 == true) {
                $('#qualificationslistdiv').hide();
                $('#<%=qualificationslist.ClientID %>').val("");
            }

            if (investmentExperienceOption1 == true) {
                $('#investmentExperienceListdiv').show();
            }

            if (workingExperienceOption1 == true) {
                $('#workingExperienceListDiv').show();
            }


            if (educationalExperienceOption1 == true) {
                $('#qualificationslistdiv').show();
            }

            if (investmentOption == true) {
                $('#investmentExperienceListdiv').hide();
            }

            if (workingOption == true) {
                $('#workingExperienceListDiv').hide();
            }

            if (educationOption == true) {
                $('#qualificationslistdiv').hide();
            }


            if ((investmentOption == true) || (workingOption == true) || (educationOption == true)) {
               

            }
            else {
                calculateCKA();
            }
        }

        function areBothEmpty(param1, param2) {
            if ((param1 == false) && (param2 == false)) {
                return true;
            }
            else
                return false;
        }

        function calculateCKA() {
            var investmentExperienceOption = $('#<%=investmentExperienceOption1.ClientID %>').is(':checked');
            var workingExperienceOption = $('#<%=workingExperienceOption1.ClientID %>').is(':checked');
            var educationalExperienceOption = $('#<%=educationalExperienceOption1.ClientID %>').is(':checked');
            
            if ((investmentExperienceOption == true) || (workingExperienceOption == true) || (educationalExperienceOption == true)) {
                $('#<%=csaOutcomeOption1.ClientID %>').attr("checked", true);
            }
            else {
                $('#<%=csaOutcomeOption2.ClientID %>').attr("checked", true);
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

       

    </script>
</asp:Content>

<asp:Content ID="Main"  ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="caseNumber" runat="server"  />
<asp:HiddenField ID="isPreferredRiskProfile" runat="server"  />
<asp:HiddenField ID="activityId" runat="server"  />
<asp:HiddenField ID="backToCase" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
    <FNAMenutag:FNAMenu runat="server" ID="menu1" />

    

     <div class="chassis_application_navigation_container">
        <ul>
        <li>
            <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
            <div class="chassis_application_navigation_inner">
                <span id="riskprofiletab" runat="server">
                    <asp:LinkButton ID="LinkRiskProfile" Text="Risk Profile Questionnaire" OnClick="menuClick" CommandArgument="riskProfile" runat="server" />
                </span>
            </div>
            </div>
        </li>
        <li>
            <div class="chassis_application_navigation_outer">
            <div class="chassis_application_navigation_inner">
                <span class="chassis_application_page_complete">
                <asp:LinkButton ID="LinkPortfolioModel" Text="Portfolio Model" OnClick="menuClick" CommandArgument="riskPortfolioModel" runat="server" />
                </span>
            </div>
            </div>
        </li>
        <li class="chassis_application_navigation_selected_tab2">
            <div class="chassis_application_navigation_outer">
            <div class="chassis_application_navigation_inner">
                <span id="ckatab" runat="server">
                    <asp:LinkButton ID="LinkCka" Text="Customer Knowledge Assessment" OnClick="menuClick" CommandArgument="cka" runat="server" />
                </span>
            </div>
            </div>
        </li>
        </ul>
    </div>



<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">

<table class="chassis_single_column_list" summary="Error Details">
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
            <table summary="four column design layout" class="chassis_three_column_list">
            <tr>
                <td width="1%"></td>
                <td colspan="3">
                    <b>Important notice to client on completion of Customer Knowledge Assessment:</b> The purpose of the Customer Knowledge Assessment (CKA) is to assess if you have the relevant knowledge or experience to understand the features and associated risk of an Unlisted Specific Investment Product, such as Collective Investment Scheme (CIS) or Investment Linked Policy (ILP).
                    <br />
                    If you satisfy any of the CKA criteria, you are deemed to possess the knowledge or experience in a CIS or an ILP. However, if you do not wish to receive advice or accept the representative's recommendations <br />
                    (i)it is your responsibility to ensure the suitability of the CIS or ILP selected and (ii) you will not be able to rely on Section 27 of the FAA to file a civil claim in the event you allege you have suffered a loss and (iii) your request to transact in the CIS or ILP will be subjected to the Company's senior management's review and approval.
                    Any inaccurate or incomplete information provided by you may affect the assessment outcome and the suitability of the the product recommended, if any.  
                </td>
            </tr>
            </table>
            <table summary="four column design layout" class="chassis_three_column_list">
              <thead>
                <tr>
                  <td colspan="4">Customer Knowledge Assessment</td>
                </tr>
              </thead>  
            </table>
                <br />
                

                <!--
                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td><b>Finance Related Knowledge</b></td>
                    </tr>
                </thead>
                </table>

                <table width="100%">
                <tbody>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:79%">
                       Do you have a professional finance-related qualification?<br />
                       <span style="font-size:smaller">Example: Chartered Financial Analyst (CFA), the Association of Chartered Certified Accountants (ACCA)</span>
                       </td>
                       <td style="width:20%">
                       <asp:RadioButton id="financeRelatedKnowledgeOption1" Text=""   GroupName="financeRelatedKnowledge" runat="server" />
                        &nbsp;Yes&nbsp;&nbsp;
                       <asp:RadioButton id="financeRelatedKnowledgeOption2" Text=""   GroupName="financeRelatedKnowledge" runat="server"/>    
                       &nbsp;No
                       </td>
                    </tr>
                </tbody>
                </table>
                -->
                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td><b>Education / Professional Qualification</b></td>
                    </tr>
                </thead>
                </table>
                <table width="100%">
                <tbody>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:79%">
                            Do you have a Diploma or higher qualifications in any of the following?
                            <br />
                            <span style="font-size:smaller">
                            Type of Qualification: Accountancy, Actuarial Science, Business; Business Administration; Business Management; Business Studies; Capital Markets; Computational Finance; Commerce; Economics; Finance; Financial Engineering; Financial Planning; Insurance; CFA or ACCA
                            </span>
                       </td>
                       <td style="width:20%">
                       <asp:RadioButton id="educationalExperienceOption1" Text=""   GroupName="educationalExperience" runat="server" />
                        &nbsp;Yes&nbsp;&nbsp;
                       <asp:RadioButton id="educationalExperienceOption2" Text=""   GroupName="educationalExperience" runat="server"/>    
                       &nbsp;No&nbsp;&nbsp;
                       </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="chassis_data_column chassis_no_padding_right">
                            <div id="qualificationslistdiv">
                                Please provide extra details
                                <br />
                                <asp:TextBox TextMode="MultiLine" Width="100%" Height="40px" ID="qualificationslist" runat="server" MaxLength = "500"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                </tbody>
                </table>
                <br />
                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td><b>Investment Experience</b></td>
                    </tr>
                </thead>
                </table>
                <table width="100%">
                <tbody>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:79%">
                       Have you transacted in collective investment schemes<br />
                       (e.g. unit trusts) or investment-linked life insurance policies (ILPs) <b> at least 6 times </b> in the<b> preceding 3 years?</b>
                       </td>
                       <td style="width:20%">
                       <asp:RadioButton id="investmentExperienceOption1" Text=""   GroupName="investmentExperience" runat="server" />
                        &nbsp;Yes&nbsp;&nbsp;
                       <asp:RadioButton id="investmentExperienceOption2" Text=""   GroupName="investmentExperience" runat="server"/>    
                       &nbsp;No&nbsp;&nbsp;
                       </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="chassis_data_column chassis_no_padding_right">
                        <div id="investmentExperienceListdiv">
                                Please provide extra details
                                <br />
                                <asp:TextBox TextMode="MultiLine" Width="100%" Height="40px" ID="investmentExperienceList" runat="server" MaxLength = "500"></asp:TextBox>
                            </div>
                            
                        </td>
                    </tr>
                </tbody>
                </table>
                <br />

                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td><b>Working Experience</b></td>
                    </tr>
                </thead>
                </table>
                <table width="100%">
                <tbody>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:79%">
                            Do you have at least 3 consecutive years of working experience in any of the following for the last 10 years? 
                            <br />
                            <span style="font-size:smaller">Type of Work Experience: Accountancy, Actuarial Science, Treasury, Financial Risk Management, Provision of legal advice in the areas relating to the development, structuring, management, training, sale, trading, research on and analysis of investment products</span>
                       </td>
                       <td style="width:20%">
                       <asp:RadioButton id="workingExperienceOption1" Text=""   GroupName="workingExperience" runat="server" />
                        &nbsp;Yes&nbsp;&nbsp;
                       <asp:RadioButton id="workingExperienceOption2" Text=""   GroupName="workingExperience" runat="server"/>    
                       &nbsp;No&nbsp;&nbsp;
                       </td>
                    </tr>
                    <tr>
                        <td colspan="3" class="chassis_data_column chassis_no_padding_right">
                        <div id="workingExperienceListDiv">
                                Please provide extra details
                                <br />
                                <asp:TextBox TextMode="MultiLine" Width="100%" Height="40px" ID="workingExperienceList" runat="server" MaxLength = "500"></asp:TextBox>
                            </div>


                            
                        </td>
                    </tr>
                </tbody>
                </table>
                <br />
                
                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td><b>Outcome of Customer Knowledge Assessment</b></td>
                    </tr>
                </thead>
                </table>
                <table width="100%">
                <tbody>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:9%">
                            <asp:RadioButton id="csaOutcomeOption1" Text="" onclick="javascript: return false;"   GroupName="csaOutcome" runat="server" />
                       </td>
                       <td style="width:90%">
                            <b>I have met</b> the Customer Knowledge Assessment criteria and am deemed to possess the knowledge or experience for transactions in a Collective Investment Scheme or an Investment Linked Policy.
                       </td>
                       
                    </tr>
                    <tr>
                       <td width="1%"></td>
                       <td style="width:9%">
                        <asp:RadioButton id="csaOutcomeOption2" Text="" onclick="javascript: return false;"   GroupName="csaOutcome" runat="server" />
                       </td>
                       <td style="width:90%">
                            <b>I have not met</b> the Customer Knowledge Assessment criteria and am deemed not to possess the knowledge or experience for transactions in a Collective Investment Scheme or an Investment Linked Policy.
                       </td>
                       
                    </tr>
                </tbody>
                </table>
                
                
                <br />
                
                <table width=100%>
                <tr width=100%>
                        <td width="47%"></td>
                        <td width="53%" align="left">
                        <asp:Button ID="Button1" runat="server" Text="Generate PDF" OnClick="createCkaPdf" class="chassis_application_button_xxxlarge" />
                        <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="ckaSubmitBack" />
                        <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server" Text="Save" OnClick="ckaSubmit"/>            
                        <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="ckaSubmitNext" />
                        <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>
                    </td>
                </tr>
            </table>
            </div>
        </div>
</div>
</div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
