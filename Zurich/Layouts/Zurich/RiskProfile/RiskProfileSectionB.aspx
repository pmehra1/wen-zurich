<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RiskProfileSectionB.aspx.cs" Inherits="Zurich.Layouts.Zurich.RiskProfile.RiskProfileSectionB" DynamicMasterPageFile="~masterurl/custom.master" %>
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

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />

<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });

        $(function () {
            $('#chassis_page_navigation_selected').attr('id', '');
            //alert($('#chassis_page_navigation_selected').attr('id'));
            $('a[name=riskProfile]').attr('id', 'chassis_page_navigation_selected');
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

    </script>
</asp:Content>



<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="caseNumber" runat="server"  />
<asp:HiddenField ID="isPreferredRiskProfile" runat="server"  />
<asp:HiddenField ID="activityId" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
    <FNAMenutag:FNAMenu runat="server" ID="menu1" />
<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">

<div class="chassis_application_navigation_container">
    <ul>
    <li>
        <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
        <div class="chassis_application_navigation_inner">
            <span>
            <a href="/_layouts/Zurich/RiskProfile/RiskProfile.aspx?caseid=<%=ViewState["caseId"] %>">Section A: Measuring Risk Appetite</a>
            </span>
        </div>
        </div>
    </li>
    <li class="chassis_application_navigation_selected">
        <div class="chassis_application_navigation_outer">
        <div class="chassis_application_navigation_inner">
            <span>
            <a href="/_layouts/Zurich/RiskProfile/RiskProfileSectionB.aspx?caseid=<%=ViewState["caseId"] %>">Section B: Measuring Risk Taking Ability</a>
            </span>
        </div>
        </div>
    </li>
    <li>
                  <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                      <span>
                        <a href="/_layouts/Zurich/RiskProfile/Cka.aspx?caseid=<%=ViewState["caseId"] %>">Customer Knowledge Assessment</a>
                      </span>
                    </div>
                  </div>
                </li>
    </ul>
</div>

<table summary="four column design layout" class="chassis_three_column_list">
    <thead>
    <tr>
        <td colspan="4">
            Section B: Measuring <b>Risk Taking Ability</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Total Score&nbsp;&nbsp;<label id="SectionBRiskProfileValue" runat="server"></label>
        </td>
    </tr>
    </thead>
</table>

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
                            <asp:RadioButton id="measuringRiskTakingAbilityQuestion1option2" Text=""   GroupName="riskApetiteQuestion2" runat="server"/>
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

<br />
<br />

                <table width=100%>
                <tr width=100%>
                        <td width="50%"></td>
                        <td width="50%" align="left">
                        <input id="Button1" class="chassis_application_button_medium" type="button" value="Print" onclick="printpg()" />
                        <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="saveRiskProfileBack" />
                        <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server" Text="Save" OnClick="riskProfileSubmit"/>            
                        <asp:Button ID="ShowPortfolioModelButton" class="chassis_application_button_xxxlarge" runat="server" Text="Show  Portfolio"  />            
                        <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="saveRiskProfileNext" />
                    </td>
                </tr>
            </table>

<br />
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
