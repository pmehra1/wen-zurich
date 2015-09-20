<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FNAMenu.ascx.cs" Inherits="Zurich.ControlTemplates.Zurich.FNAMenu" %>

<link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>



<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<script type="text/javascript">
    function pageLoad() {
    //$(document).ready(function () {

        $(function () {
            var factfindstatus = document.getElementById('<%=factfindstatus.ClientID %>').value;
            if (factfindstatus == "complete") {
                $("#factFindtab").addClass("chassis_application_page_complete");
            } else if (factfindstatus == "incomplete") {
                $("#factFindtab").addClass("chassis_application_page_warnings");
            }

            var protectiongoalstatus = document.getElementById('<%=protectiongoalstatus.ClientID %>').value;
            if (protectiongoalstatus == "complete") {
                $("#protectionGoaltab").addClass("chassis_application_page_complete");
            } else if (protectiongoalstatus == "incomplete") {
                $("#protectionGoaltab").addClass("chassis_application_page_warnings");
            }

            var investmentgoalsstatus = document.getElementById('<%=investmentgoalsstatus.ClientID %>').value;
            if (investmentgoalsstatus == "complete") {
                $("#investmentgoalstab").addClass("chassis_application_page_complete");
            } else if (investmentgoalsstatus == "incomplete") {
                $("#investmentgoalstab").addClass("chassis_application_page_warnings");
            }

            var riskprofilestatus = document.getElementById('<%=riskprofilestatus.ClientID %>').value;
            if (riskprofilestatus == "complete") {
                $("#riskprofiletab").addClass("chassis_application_page_complete");
            } else if (riskprofilestatus == "incomplete") {
                $("#riskprofiletab").addClass("chassis_application_page_warnings");
            }

            var portfoliobuilderstatus = document.getElementById('<%=portfoliobuilderstatus.ClientID %>').value;
            var portfolioBuilderMenuFNAMenu = document.getElementById('<%=portfolioBuilderMenuFNAMenu.ClientID %>').value;
            var portfolioBuilderCstStatus = document.getElementById('<%=portfolioBuilderCst.ClientID %>').value;

            if (portfoliobuilderstatus == "complete") {
                if (portfolioBuilderMenuFNAMenu == "portfolioBuilder") {
                    $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                    $('#portfolioBuilder').addClass("chassis_application_navigation_selected_tab1");

                    if (portfolioBuilderCstStatus == 'complete') {
                        $('#portfoliotab').addClass("chassis_application_page_complete");
                    }
                    else if (portfolioBuilderCstStatus == 'incomplete') {
                        $('#portfoliotab').addClass("chassis_application_page_warnings");
                    }
                }               
                $("#portfoliotab").addClass("chassis_application_page_complete");               

            } else if (portfoliobuilderstatus == "incomplete") {
                if (portfolioBuilderMenuFNAMenu == "portfolioBuilder") {
                    $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                    $('#portfolioBuilder').addClass("chassis_application_navigation_selected_tab1");

                    if (portfolioBuilderCstStatus == 'complete') {
                        $('#portfoliotab').addClass("chassis_application_page_complete");
                    }
                    else if (portfolioBuilderCstStatus == 'incomplete') {
                        $('#portfoliotab').addClass("chassis_application_page_warnings");
                    }
                }               
                $("#portfoliotab").addClass("chassis_application_page_warnings");
            } else {
                if (portfolioBuilderMenuFNAMenu == "portfolioBuilder") {
                    $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                    $('#portfolioBuilder').addClass("chassis_application_navigation_selected_tab1");
                }
            }

        });
}
//})

function tabstatus(status) {
    if (status == 'complete') {
        $('#portfoliotab').addClass("chassis_application_page_complete");
    }
    else if (status == 'incomplete') {
        $('#portfoliotab').addClass("chassis_application_page_warnings");
    }
}

</script>

<table width="100%" cellpadding ="0" cellspacing ="0" align="center">

<tr>
<td align="center">
<div class="chassis_application_navigation_container">
              <ul>
                
               <li id="factFind" class="chassis_application_navigation_selected_tab1">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span id="factFindtab">
                            <asp:LinkButton ID="LinkZurichAdvisor" Text="Fact Find" OnClick="Menu_Click" CommandArgument="zurichAdvisor" runat="server" />
                        </span>
                    </div>
                </div>
               </li>
               
               <li id="protectionGoal">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span id="protectionGoaltab">
                            <asp:LinkButton ID="LinkProtectionGoals" Text="Protection Goals" OnClick="Menu_Click" CommandArgument="protectionGoals" runat="server" />
                        </span>
                    </div>
                </div>
               </li>

               <li id="InvestmentGoals">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span id="investmentgoalstab">
                            <asp:LinkButton ID="LinkInvestmentGoals" Text="Investment Goals" OnClick="Menu_Click" CommandArgument="investmentGoals" runat="server" />
                        </span>
                    </div>
                </div>
               </li>
               
               <li id="riskProfile" >
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span id="riskprofiletab">
                            <asp:LinkButton ID="LinkRiskProfile" Text="Risk Profile" OnClick="Menu_Click" CommandArgument="riskProfile" runat="server" />
                        </span>
                    </div>
                </div>
               </li>
               <li id="portfolioBuilder">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span id="portfoliotab">
                            <asp:LinkButton ID="LinkPortfolioBuilder" Text="Portfolio Builder" OnClick="Menu_Click" CommandArgument="portfolioBuilder" runat="server" />
                        </span>
                    </div>
                </div>
               </li>
              
               <li id="gapSummary">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <asp:LinkButton ID="LinkGapSummary" Text="My Gaps" OnClick="Menu_Click" CommandArgument="gapSummary" runat="server" />
                        </span>
                    </div>
                </div>
               </li>
               
     </ul>
 </div>
</td>
</tr>



</table>

<asp:HiddenField id="caseId" runat="server" />
<asp:HiddenField id="factfindstatus" runat="server" />
<asp:HiddenField id="protectiongoalstatus" runat="server" />
<asp:HiddenField id="investmentgoalsstatus" runat="server" />
<asp:HiddenField id="riskprofilestatus" runat="server" />
<asp:HiddenField id="portfoliobuilderstatus" runat="server" />
<asp:HiddenField ID="portfolioBuilderMenuFNAMenu" runat="server" />
<asp:HiddenField ID="portfolioBuilderCst" runat="server" />
