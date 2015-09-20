<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyZurichAdviser.aspx.cs" Inherits="Zurich.Layouts.Zurich.MyZurichAdvisor.MyZurichAdvisor" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>

<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>

<script language="javascript" type="text/javascript">

    $(document).ready(function () {

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

            checkboxClicked();
            $(":checkbox").click(checkboxClicked);


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

    function checkboxClicked() {

        var chkGroup = $("input[id^=<%=mzaoptions.ClientID %>]");
        
        if (($(chkGroup[3]).attr('checked') == 'checked')) {
            $(".usermessage").show();
        }
        else {
            $(".usermessage").hide();
            $(".usermessage").val("");
           
        }

    }

    

</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<asp:HiddenField ID="activityId" runat="server" />
<asp:HiddenField ID="backToCase" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
   <FNAMenutag:FNAMenu runat="server" id="FNAMenu1" />

    <div class="chassis_application_navigation_container">
              <ul>
                <li class="chassis_application_navigation_selected_tab2">
                  <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                      <span id="mzatab" runat="server">
                        <asp:LinkButton ID="LinkZurichAdvisor" Text="My Zurich Advisor" OnClick="menuClick" CommandArgument="zurichAdvisor" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="personaldetailstab" runat="server">
                        <asp:LinkButton ID="LinkPersonalDetail" Text="Personal Details" OnClick="menuClick" CommandArgument="personalDetail" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="prioritydetailstab" runat="server">
                        <asp:LinkButton ID="LinkPriorityDetails" Text="Priority Details" OnClick="menuClick" CommandArgument="priorityDetails" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="incomeexpensetab" runat="server">
                        <asp:LinkButton ID="LinkIncomeExpense" Text="Income & Expense" OnClick="menuClick" CommandArgument="incomeExpense" runat="server" />
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span id="assetliabilitytab" runat="server">
                        <asp:LinkButton ID="LinkAssetLiabilities" Text="Assets / Liabilities" OnClick="menuClick" CommandArgument="assetLiabilities" runat="server" />
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
            <asp:Label ID="lblZurichAdvSuccess" runat="server" class="chassis_application_save_success"
                Text="• My Zurich Adviser saved successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblZurichAdvFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to save My Zurich Adviser" Visible = "false"></asp:Label>
            <asp:Label ID="lblStatusSubmitted" runat="server" class="chassis_application_save_success"
                Text="• Case Status submitted successfully" Visible = "false"></asp:Label>
            <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                Text="• Failed to Submit Case Status" Visible = "false"></asp:Label>                
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

<table class="chassis_four_column_list" summary="Adviser details">
    <thead>
        <tr>
            <td colspan="2">An Important Notice to You</td>
        </tr>
     </thead>
</table>

<table class="chassis_two_column_list">
    <tbody>
        <tr>
            <td class="chassis_label_column">Your Zurich Adviser is a representative of Zurich Life Singapore, which is an exempt Financial Adviser under the Financial Advisers Act (Cap110). Zurich Life Singapore is authorized to arrange and advise on life, accident and health and investment-linked insurance contracts provided by it and other insurance providers who it may partner from time to time.</td>
        </tr>
        <tr>
            <td class="chassis_label_column">Your Zurich Adviser is authorized to arrange and provide advice on the following products:</td>
        </tr>
        <tr>
            <td class="chassis_label_column">
                <asp:CheckBoxList ID="mzaoptions" runat="server" RepeatDirection="Vertical">
                    <asp:ListItem Value="1" Text=" Life Insurance and Investment-Linked Products" />
                    <asp:ListItem Value="2" Text=" Critical Illness, Hospital Income Benefit" />
                    <asp:ListItem Value="3" Text=" Hospital and Surgical Plans, Disability Income Plans, Long-Term Care Plans" />
                    <asp:ListItem Value="4" Text=" Others (please specify)"/>
                </asp:CheckBoxList>
                &nbsp;&nbsp;<asp:TextBox ID="otherstxt" runat="server" class="usermessage" TextMode="MultiLine" Width="500px" Height="125px"/>
            </td>
        </tr>
        <tr>
            <td class="chassis_label_column"><b>Policies and/or financial products purchased without the completion of the Z Plan, or following partial or inaccurate completion, may not be appropriate for your needs.</b></td>
        </tr>
        <tr>
            <td class="chassis_label_column">Completion of the Z Plan will enable your Zurich Adviser to obtain information to conduct an overall needs analysis and to offer you suitable advice to address your core wealth needs and lifestyle goals. We would like to assure you that any information you provide will be treated with strictest confidence.</td>
        </tr>
        <tr>
        <td>
        <table width="100%">
            <tr align="right">
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Generate PDF" OnClick="createMzaPdf" class="chassis_application_button_xxxlarge" />
                    <asp:Button ID="Button3" runat="server" Text="Save" OnClick="submitMza" class="chassis_application_button_medium" />
                    <asp:Button ID="Button1" runat="server" Text="Next" OnClick="submitMzaNext" class="chassis_application_button_medium" />
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
My Zurich Adviser
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Zurich Adviser
</asp:Content>
