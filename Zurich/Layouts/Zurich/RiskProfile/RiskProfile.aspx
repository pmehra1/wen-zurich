<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RiskProfile.aspx.cs" Inherits="Zurich.Layouts.Zurich.RiskProfile.RiskProfile" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
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
        $('#calculateRiskProfileImage').hide();
        $('#showRiskProfileImagePlus').click(function () {

            $('#calculateRiskProfileImage').toggle(500);
        });
        $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });



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
                <li class="chassis_application_navigation_selected_tab2">
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
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="ckatab" runat="server">
                        <asp:LinkButton ID="LinkButton1" Text="Customer Knowledge Assessment" OnClick="menuClick" CommandArgument="cka" runat="server" />
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
                        <asp:Label ID="riskProfileSaveSuccess" runat="server" class="chassis_application_save_success"
                            Text="• Risk Profile saved successfully"></asp:Label>
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


            <table summary="four column design layout" class="chassis_three_column_list">
              <thead>
                <tr>
                  <td colspan="4">Risk Profiling Questionnaire&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Your Risk Profile is &nbsp;&nbsp;<label id="finalRiskProfile" runat="server"></label>
                  </td>
                </tr>
              </thead>
              <tbody>
                <tr>
                    <td colspan="4">
                        This questionnaire and the strategic asset allocation models are provided by Nexus Financial Services Pte Ltd based on research conducted by Mercer (Singapore) Pte Ltd. (“Mercer”). The results of this questionnaire and the asset allocation models are derived from information that you have provided to Nexus Financial Services Pte Ltd, and only serve as a reference for your consideration when making your own investment decision. This questionnaire and the results are not an offer to sell or a solicitation for an offer to buy any financial products and services that they should not be considered as investment advice.  Nexus Financial Services Pte Ltd and Mercer accept no responsibility or liability as to the accuracy or completeness of the information given in the questionnaire or the results derived therefrom. &nbsp;&nbsp;&nbsp;(How Risk Profile is calculated)
                        &nbsp;&nbsp;<a href="#" id="showRiskProfileImagePlus"><img alt="" style='width:15px;height:15px;' src="/_layouts/Zurich/images/add-icon.jpg" /></a>
                    </td>
                </tr>
                <tr>
                <td colspan="4">
                <br />
                <div id="calculateRiskProfileImage">
                <img alt="" style='width:733px;height:317px;' src="/_layouts/Zurich/images/Content/Risk%20Profile_Calc.png" />
                </div>
                <table class="chassis_single_column_list" summary="Checkbox">
                <thead>
                    <tr>
                        <td>Section A: Measuring <b>Risk Appetite</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Total Score&nbsp;&nbsp;<label id="riskTakingAppetiteLabel" runat="server"></label>
                        </td>
                    </tr>
                </thead>
                </table>
                </td>
                </tr>
                </tbody>
                </table>
                <br />
                <br />
                <table width="100%">
                <tbody>
                    <tr>
                       <td style="width:10%"><b>Question 1</b>
                       The graph below shows the hypothetical results of 5 sample portfolios over a one-year period. The 
                       potential gains and losses of each portfolio are presented.
                       </td>
                </tr>
                    <tr>
                       <td>
                            <img src="/_layouts/Zurich/images/Content/RiskProfileChart.png" alt="Risk Profile Static Chart"/>
                            <br />
                            <span style="font-size:small">* The return ranges are for illustration only</span>
                       </td>
                </tr>
                </tbody>
                </table>

                <br />
                <br />

                <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Which portfolio would you prefer to hold? </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option1" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>
                        </td>
                        <td>
                            None of the above, because I cannot accept any loss of my capital
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option2" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>
                        </td>
                        <td>
                            Portfolio A – Cautious 
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option3" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>
                        </td>
                        <td>
                            Portfolio B – Moderately Cautious  
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option4" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>
                        </td>
                        <td>
                            Portfolio C – Balanced
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option5" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>
                        </td>
                        <td>
                            Portfolio D – Moderately Adventurous 
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion1option6" Text=""   GroupName="riskApetiteQuestion1" runat="server"/>    
                        </td>
                        <td>
                            Portfolio E – Adventurous 
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 2: What would you do if your long term investment drops by more than 20% over a short period of time?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion2option1" Text=""   GroupName="riskApetiteQuestion2" runat="server"/>
                        </td>
                        <td>
                            Sell the whole investment – I wouldn’t want to lose any more money
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion2option2" Text=""   GroupName="riskApetiteQuestion2" runat="server"/>
                        </td>
                        <td>
                            Sell part of the investment – it could go back up, but I don’t want to risk everything just in case it doesn’t 
                             
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion2option3" Text=""   GroupName="riskApetiteQuestion2" runat="server"/>
                        </td>
                        <td>
                            Hold the investment – it’s likely that it will increase in value again soon  
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion2option4" Text=""   GroupName="riskApetiteQuestion2" runat="server"/>
                        </td>
                        <td>
                            Hold the investment and buy more while the value is low – when the value goes up, I’ll make a good return
                            
                            
                        </td>
                    </tr>
                </table>

                <br />
                <br />


                <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 3: What is the riskiest asset that you would consider investing in the future ?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                             <asp:RadioButton id="riskApetiteQuestion3option1" Text=""   GroupName="riskApetiteQuestion3" runat="server"/>
                        </td>
                        <td>
                            Savings account, time deposits and money market instruments
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion3option2" Text=""   GroupName="riskApetiteQuestion3" runat="server"/>
                        </td>
                        <td>
                            Bonds and bond funds 
                             
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion3option3" Text=""   GroupName="riskApetiteQuestion3" runat="server"/>
                        </td>
                        <td>
                            Stocks and equity mutual funds
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion3option4" Text=""   GroupName="riskApetiteQuestion3" runat="server"/>
                        </td>
                        <td>
                            Non-guaranteed structured products like equity linked notes
                            
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion3option5" Text=""   GroupName="riskApetiteQuestion3" runat="server"/>
                        </td>
                        <td>
                            Options, futures, warrants
                            
                            
                        </td>
                    </tr>
                </table>

                    <br />
                    <br />

                <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 4: How would you describe your investment preference?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                             <asp:RadioButton id="riskApetiteQuestion4option1" Text=""   GroupName="riskApetiteQuestion4" runat="server"/>
                        </td>
                        <td>
                            I prefer an investment that has little fluctuations in value, i.e., an investment with minimal chance of losing money.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion4option2" Text=""   GroupName="riskApetiteQuestion4" runat="server"/>
                        </td>
                        <td>
                            I have a long-term investment focus and will ride out the good times and the bad times.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="riskApetiteQuestion4option3" Text=""   GroupName="riskApetiteQuestion4" runat="server"/>
                        </td>
                        <td>
                            I actively trade investments in the short-term to take advantage of short-term market movements
                            
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                
                <table summary="four column design layout" class="chassis_three_column_list">
                    <thead>
                        <tr>
                          <td colspan="4">Section B: Measuring Risk Taking Ability&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Total Score&nbsp;&nbsp;<label id="riskTakingAbilityLabel" runat="server"></label>
                          </td>
                        </tr>
                      </thead>
                      <tbody></tbody>
                </table>
                <br />
                <br />
                <br />
                 <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 5: Which of the following statements most accurately describe your current situation?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion1option1" Text=""   GroupName="measuringRiskTakingAbilityQuestion1" runat="server"/>
                        </td>
                        <td>
                            My income is lower than my on-going expenses.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion1option2" Text=""   GroupName="measuringRiskTakingAbilityQuestion1" runat="server"/>
                        </td>
                        <td>
                            My income is approximately the same as my on-going expenses.
                             
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion1option3" Text=""   GroupName="measuringRiskTakingAbilityQuestion1" runat="server"/>
                        </td>
                        <td>
                            My income is higher (≤30%) than my on-going expenses.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion1option4" Text=""   GroupName="measuringRiskTakingAbilityQuestion1" runat="server"/>
                        </td>
                        <td>
                            My income is significantly higher (>30%) than my on-going expenses.
                            
                            
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                                    <span class="riskProfileScore"> On-going expenses exclude large one- time expense such as car purchase or home renovation expenses</span>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                 <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 6: How many years are you away from your retirement?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion2option1" Text=""   GroupName="measuringRiskTakingAbilityQuestion2" runat="server"/>
                        </td>
                        <td>
                            < 5 years or already retired
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion2option2" Text=""   GroupName="measuringRiskTakingAbilityQuestion2" runat="server"/>
                        </td>
                        <td>
                            5 – 10 years
                             
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion2option3" Text=""   GroupName="measuringRiskTakingAbilityQuestion2" runat="server"/>
                        </td>
                        <td>
                            > 10 years
                            
                        </td>
                    </tr>
                </table>
                <br />
                <br />
               <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 7: Which of the following statement best describes your investment needs?  </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion3option1" Text=""   GroupName="measuringRiskTakingAbilityQuestion3" runat="server"/>    
                        </td>
                        <td>
                            I need my investments to provide high level of income while maintaining stable value <br />
                            as I rely on my investments to support my current financial needs.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion3option2" Text=""   GroupName="measuringRiskTakingAbilityQuestion3" runat="server"/>    
                        </td>
                        <td>
                            I need my investments to provide high level of income with some capital growth to <br />
                            support my current and future financial needs.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion3option3" Text=""   GroupName="measuringRiskTakingAbilityQuestion3" runat="server"/>    
                        </td>
                        <td>
                            I am more concerned to achieve long-term growth as I need my investments to provide for my future financial needs.
                            
                        </td>
                    </tr>

                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion3option4" Text=""   GroupName="measuringRiskTakingAbilityQuestion3" runat="server"/>    
                        </td>
                        <td>
                            I do not rely on my investments to provide for my financial needs. The performance <br />
                             of my investments will not affect my standard of living negatively
                            
                        </td>
                    </tr>

                </table>
                <br />
                <br />
                <table width="100%">
                <tr>
                       <td colspan="2">
                           <b>Question 8: Is there a future financial need which will require you to liquidate more than 30% of your investments? </b>
                       </td>
                </tr>
                <tr>
                   <td colspan="2" style="height:10px;"> 
                           
                    </td>
                </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion4option1" Text=""   GroupName="measuringRiskTakingAbilityQuestion4" runat="server"/>    
                        </td>
                        <td>
                            Yes, the financial commitment will occur within the next 2 years.
                            
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion4option2" Text=""   GroupName="measuringRiskTakingAbilityQuestion4" runat="server"/>    
                        </td>
                        <td>
                            Yes, the financial commitment will occur within the next 2 to 5 years.
                             
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion4option3" Text=""   GroupName="measuringRiskTakingAbilityQuestion4" runat="server"/>    
                        </td>
                        <td>
                            Yes, the financial commitment will occur in more than 5 years’ time.
                            
                        </td>
                    </tr>

                    <tr>
                        <td width="5%">
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion4option4" Text=""   GroupName="measuringRiskTakingAbilityQuestion4" runat="server"/>    
                        </td>
                        <td>
                            No.
                            
                        </td>
                    </tr>

                </table>
                <table width=100%>
                <tr width=100%>
                        <td width="47%"></td>
                        <td width="53%" align="left">
                        <asp:Button ID="Button1" runat="server" Text="Generate PDF" OnClick="createRiskprofilePdf" class="chassis_application_button_xxxlarge" />
                        <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="saveRiskProfileBack" />
                        <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server" Text="Save" OnClick="riskProfileSubmit"/>            
                        <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="saveRiskProfileNext" />
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
Risk Profiling Questionnaire
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
