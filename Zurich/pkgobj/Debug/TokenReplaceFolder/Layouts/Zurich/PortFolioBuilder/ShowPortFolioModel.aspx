<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowPortFolioModel.aspx.cs" Inherits="Zurich.Layouts.Zurich.PortFolioBuilder.ShowPortFolioModel" DynamicMasterPageFile="~masterurl/custom.master" MaintainScrollPositionOnPostback="true" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.min.js"></script>
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

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<script type='text/javascript'>
    _spSuppressFormOnSubmitWrapper = true;
</script>
<script language="javascript" type="text/javascript">
    $(document).ready(function () {



        $(function () {

            $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
            $('#riskProfile').addClass("chassis_application_navigation_selected_tab1");

            var riskprofile = document.getElementById('<%=riskProfileNameHidden.ClientID %>').value;
            if (riskprofile == 'Cautious' || riskprofile == 'Capital Preservation') {
                $('#<%=liCautious.ClientID %>').addClass("chassis_application_navigation_selected_tab1");
            }
            else if (riskprofile == 'Moderately Cautious') {
                $('#<%=liModeratelyCautious.ClientID %>').addClass("chassis_application_navigation_selected_tab1");
            }
            else if (riskprofile == 'Balanced') {
                $('#<%=liBalanced.ClientID %>').addClass("chassis_application_navigation_selected_tab1");
            }
            else if (riskprofile == 'Moderately Adventurous') {
                $('#<%=liModeratelyAdventurous.ClientID %>').addClass("chassis_application_navigation_selected_tab1");
            }
            else if (riskprofile == 'Adventurous') {
                $('#<%=liAdventurous.ClientID %>').addClass("chassis_application_navigation_selected_tab1");
            }

        });

        $(function () {
            $('#chassis_page_navigation_selected').attr('id', '');
            $('a[name=ShowPortFolioModel]').attr('id', 'chassis_page_navigation_selected');
        });

        $(function () {
            $('#chassis_application_navigation_selected_tab1').attr('id', '');
            $('a[name=ShowPortFolioModel]').attr('id', 'chassis_application_navigation_selected_tab1');
        });

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

</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="activityId" runat="server" />
<asp:HiddenField ID="riskProfileNameHidden" runat="server" />
<asp:HiddenField ID="backToCase" runat="server"  />
<div id="chassis_outer_container">
<div class="chassis_page_container">
   <FNAMenutag:FNAMenu runat="server" id="FNAMenu1" />

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
        <li class="chassis_application_navigation_selected_tab2">
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
                    <asp:LinkButton ID="LinkCka" Text="Customer Knowledge Assessment" OnClick="menuClick" CommandArgument="cka" runat="server" />
                </span>
            </div>
            </div>
        </li>
        </ul>
    </div>




<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">

    <div class="chassis_application_navigation_container">
        <ul>
            <li id = "liCautious" runat = "server">
                <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <a runat = "server" id = "lnkCautious" onserverclick = "lnkCautiousClicked" >Cautious</a>
                        </span>
                    </div>
                </div>
            </li>
            <li id = "liModeratelyCautious" runat = "server">
                <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <a runat = "server" id = "lnkModeratelyCautious" onserverclick = "lnkModeratelyCautiousClicked">Moderately Cautious</a>
                        </span>
                    </div>
                </div>
            </li>
            <li id = "liBalanced" runat = "server">
                <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <a runat = "server" id = "lnkBalanced" onserverclick = "lnkBalancedClicked">Balanced</a>
                        </span>
                    </div>
                </div>
            </li>
            <li id = "liModeratelyAdventurous" runat = "server">
                <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <a runat = "server" id = "lnkModeratelyAdventurous" onserverclick = "lnkModeratelyAdventurousClicked">Moderately Adventurous</a>
                        </span>
                    </div>
                </div>
            </li>
            <li id = "liAdventurous" runat = "server">
                <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                        <span>
                            <a runat = "server" id = "lnkAdventurous" onserverclick= "lnkAdventurousClicked">Adventurous</a>                        
                        </span>
                    </div>
                </div>
            </li>
        </ul>
    </div>

    
    
    <table summary="Core Non Core Selection" class="chassis_single_column_list">              
        <tbody>
            <tr>
                <td>
                    <asp:radiobuttonlist id="optnCoreNonCoreOptions" runat="server" class="chassis_radio" RepeatDirection = "Horizontal"  AutoPostBack="true" OnSelectedIndexChanged = "optnCoreNonCoreOptions_SelectedIndexChanged">
                        <asp:listitem id="optnCore" runat="server" value="1" Selected = "True" Text = "&nbsp;&nbsp;Core&nbsp;&nbsp;&nbsp;"/>
                        <asp:listitem id="optnNonCore" runat="server" value="0" Text = "&nbsp;&nbsp;Non Core&nbsp;&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>                     
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table width = "100%">                        
                        <tr>
                            <td align = "center" width="65%"><asp:label runat = "server" ID = "lblLineGraph" Text = "Range of Returns with Core Assets" Font-Bold = "true" ></asp:label></td>
                            <td align = "center"  width="35%"><asp:label runat = "server" ID = "lblPieChart" Text = "Strategic Assets Allocation" Font-Bold = "true"></asp:label></td>
                        </tr>                        
                    </table>
                </td>
            </tr>
            <tr>
                <td align = "center">                    
                    <asp:Image ID="imgPortFolioModel" ImageUrl="" runat="server" Width="100%" />                                       
                </td>
            </tr>               
            <tr>
                <td align = "right">
                    <asp:Button ID="Button1" runat="server" Text="Generate PDF" OnClick="createPortfoliomodelPdf" class="chassis_application_button_xxxlarge" />
                    <asp:Button ID="cmdPrevious" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="PortFolioModelPrevious" />
                    <asp:Button ID="cmdNext" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="PortFolioModelNext" />
                </td> 
            </tr>            
        </tbody>
    </table>

    </asp:UpdatePanel>  
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
