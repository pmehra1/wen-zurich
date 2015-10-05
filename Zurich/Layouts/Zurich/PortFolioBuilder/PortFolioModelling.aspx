<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PortFolioModelling.aspx.cs" Inherits="Zurich.Layouts.Zurich.PortFolioBuilder.PortFolioModelling" DynamicMasterPageFile="~masterurl/custom.master" MaintainScrollPositionOnPostback="true"  EnableSessionState="True" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Import Namespace="System.Collections.Generic" %>
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
    <script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<script type='text/javascript'>
    _spSuppressFormOnSubmitWrapper = true;
</script>
<script language="javascript" type="text/javascript">
//function pageLoad()
//{
//    $(function () {
//        $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
//        $('#portfolioBuilder').addClass("chassis_application_navigation_selected_tab1");
//        var status = document.getElementById('<%=cst.ClientID %>').value;
//        if (status == 'complete') {            
//            $('#portfoliotab').addClass("chassis_application_page_complete");
//        }
//        else if (status == 'incomplete') {            
//            $('#portfoliotab').addClass("chassis_application_page_warnings");
//        }
//    });

//}

   function calculateAmountGrdNonCoreFunds(percentage, assetName) {
        calculateAmount(document.getElementById('<%=grdNonCoreFunds.ClientID %>'));
    }   

    function calculateAmountGrdFundsSelection() {
        calculateAmount(document.getElementById('<%=grdFundsSelection.ClientID %>'));
    }

    function calculateAmountGrdFundRiskPlotter() {
        calculateAmountWithSecondaryFunds(document.getElementById('<%=grdFundRiskPlotter.ClientID %>'), document.getElementById('<%=grdSecondaryFunds.ClientID %>'));
    }

    /*function calculateAmountGrdSecondaryFunds() {
        calculateAmount(document.getElementById('<%=grdSecondaryFunds.ClientID %>'));
    }*/

    function calculateAmount(grid) {        
        var premium = document.getElementById('<%= premium.ClientID %>').value;

        var col1;
        var col2;
        var totalcol1 = 0;
        var totalAmt = 0;    

        for (i = 0; i < grid.rows.length; i++) {
            col1 = grid.rows[i].cells[2];
            col2 = grid.rows[i].cells[3];             
            

            for (j = 0; j < col1.childNodes.length; j++) {
                if (col1.childNodes[j].type == "text") {
                    if (!isNaN(col1.childNodes[j].value) && col1.childNodes[j].value != "") {
                        totalcol1 += parseInt(col1.childNodes[j].value)

                        col2.childNodes[j].value = Math.round(parseInt(col1.childNodes[j].value) * .01 * premium * 100) / 100;                       
                        totalAmt += parseFloat(col2.childNodes[j].value);
                    }
                }
            }            
        }

        document.getElementById('<%=txtTotalPremium.ClientID %>').value = totalcol1;
        document.getElementById('<%=txtAllocationAmtTotal.ClientID %>').value = Math.round(totalAmt * 100) / 100;
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

    function calculateAmountWithSecondaryFunds(grdFundRiskPlotter, grdSecondaryFunds) {
        var premium = document.getElementById('<%= premium.ClientID %>').value;

        var col1;
        var col2;

        var totalcol1 = 0;
        var totalcol2 = 0;
        var totalAmt = 0;       

        for (i = 0; i < grdFundRiskPlotter.rows.length; i++) {
            col1 = grdFundRiskPlotter.rows[i].cells[2];
            col2 = grdFundRiskPlotter.rows[i].cells[3];


            for (j = 0; j < col1.childNodes.length; j++) {
                if (col1.childNodes[j].type == "text") {
                    if (!isNaN(col1.childNodes[j].value) && col1.childNodes[j].value != "") {
                        totalcol1 += parseInt(col1.childNodes[j].value)

                        col2.childNodes[j].value = Math.round(parseInt(col1.childNodes[j].value) * .01 * premium * 100) / 100;
                        totalAmt += parseInt(col2.childNodes[j].value);
                    }
                }
            }
        }

        for (i = 0; i < grdSecondaryFunds.rows.length; i++) {
            col1 = grdSecondaryFunds.rows[i].cells[2];
            col2 = grdSecondaryFunds.rows[i].cells[3];


            for (j = 0; j < col1.childNodes.length; j++) {
                if (col1.childNodes[j].type == "text") {
                    if (!isNaN(col1.childNodes[j].value) && col1.childNodes[j].value != "") {
                        totalcol2 += parseInt(col1.childNodes[j].value)

                        col2.childNodes[j].value = Math.round(parseInt(col1.childNodes[j].value) * .01 * premium * 100) / 100;                        
                        totalAmt += parseFloat(col2.childNodes[j].value);
                    }
                }
            }
        }

        document.getElementById('<%=txtTotalPremium.ClientID %>').value = totalcol1 + totalcol2;
        document.getElementById('<%=txtAllocationAmtTotal.ClientID %>').value = Math.round(totalAmt * 100) / 100;
    }
    
    function roundOffValues() {
        if (!isNaN(document.getElementById('<%= premium.ClientID %>').value) && document.getElementById('<%= premium.ClientID %>').value != "") {
            document.getElementById('<%= premium.ClientID %>').value = Math.round(document.getElementById('<%= premium.ClientID %>').value);
        }
        if (!isNaN(document.getElementById('<%= txtTotalPremium.ClientID %>').value) && document.getElementById('<%= txtTotalPremium.ClientID %>').value != "") {
            document.getElementById('<%= txtTotalPremium.ClientID %>').value = Math.round(document.getElementById('<%= txtTotalPremium.ClientID %>').value);
        }
        if (!isNaN(document.getElementById('<%= txtAllocationAmtTotal.ClientID %>').value) && document.getElementById('<%= txtAllocationAmtTotal.ClientID %>').value != "") {
            document.getElementById('<%= txtAllocationAmtTotal.ClientID %>').value = Math.round(document.getElementById('<%= txtAllocationAmtTotal.ClientID %>').value);
        }
    }


    function confirmAction() {
//        if (confirm('Are you sure, you want to execute this action???')) {
//            // you clicked the OK button.  
//            // you can allow the form to post the data.  
//            return true;
//        }
//        else {
//            // you clicked the Cancel button.  
//            // you can disallow the form submission.  
//            return false;
        //        }
        return true;
    }  
   
</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<%--<asp:HiddenField ID="riskProfile" runat="server" Value = "ViewData["profileName"])"  />--%>
<asp:HiddenField ID="activityId" runat="server" />
<asp:HiddenField ID="cst" runat="server" />
<asp:HiddenField ID="portfolioBuilderMenu" runat="server" value= "portfolioBuilder"/>
<asp:HiddenField ID="backToCase" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
   <FNAMenutag:FNAMenu runat="server" id="FNAMenu1" />
<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">
    <table class="chassis_four_column_list" summary="Error Details">
        <tr>
            <td colspan="2">
                <asp:Label ID = "lblFundSplitterErrorMessage1" runat = "server" class = "chassis_application_feedback_error" Text = "• Please ensure that the secondary funds allocation is less than or equeal to the limit prescribed below."></asp:Label>
                <asp:Label ID = "lblFundSplitterErrorMessage2" runat = "server" class = "chassis_application_feedback_error" Text = "• Please ensure that the total allocation is exactly 100%."></asp:Label>
                <asp:Label ID = "lblSubmitMessage" runat = "server" class = "chassis_application_save_success" Text = "• Portfolio saved successfully."></asp:Label>
                <asp:Label ID = "lblSubmitMessageLessThan100" runat = "server" class = "chassis_application_feedback_error" Text = "• Portfolio saved successfully. However the Total Allocation Percentage is less than 100%"></asp:Label>
                <asp:Label ID = "lblAllocationLessThan100" runat = "server" class = "chassis_application_feedback_error" Text = "• Total Allocation Percentage is less than 100%"></asp:Label>
                <asp:Label ID = "lblErrorMessage" runat = "server" class = "chassis_application_feedback_error" Text = "• Please ensure that the funds allocation percentage add up to the asset class allocation percentage."></asp:Label>
                <asp:Label ID = "lblErrorMsgGreaterthan100" runat = "server" class = "chassis_application_feedback_error" Text = "• Please ensure that the total allocation is exactly 100%."></asp:Label>
                <asp:Label ID = "lblErrorMsgNotRecommendedPercent" runat = "server" class = "chassis_application_feedback_error" Text = "• Please ensure that Allocation percentage for each asset class following the recommended percentage."></asp:Label>
                <asp:Label ID = "lblErrorMsgAgreeWithRiskProfile" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select the option whether you agree with Risk Profile."></asp:Label>
                <asp:Label ID = "lblErrorMsgPreferredRiskProfile" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select any preferred Risk Profile."></asp:Label>
            
                <asp:Label ID = "lblErrorMsgFollowAsset" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select any option for asset allocation based on Risk Profile."></asp:Label>
                <asp:Label ID = "lblErrorMsgAllocationOnRiskProfile" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select any option from Funds Risk Plotter/ Fund Selection."></asp:Label>
                <asp:Label ID = "lblErrorMsgCoreNonCore" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select option for including Core/ Non Core Funds."></asp:Label>
                <asp:Label ID = "lblErrorMsgSingleRegularPremium" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select an option from Single Premium/ Regular Premium."></asp:Label>
                <asp:Label ID = "lblErrorMsgPremiumAmt" runat = "server" class = "chassis_application_feedback_error" Text = "• Please Premium Amount."></asp:Label>
                <asp:Label ID = "lblErrorMsgPaymentMode" runat = "server" class = "chassis_application_feedback_error" Text = "• Please select Payment Mode."></asp:Label>
            </td>
        </tr>
    </table>
    <table summary="four column design layout" class="chassis_three_column_list">
        <thead>
        <tr>
            <td colspan="4">Portfolio Disclaimer</td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="4">
                The information shown contains confidential and proprietary information of Mercer. Any information, opinion, projections and/or ratings expressed or provided is not a guarantee as to the future performance of the investment products/portfolios, asset classes or capital markets discussed. The information takes into account past information which may not be a reliable indicator of future returns. Various factors may arise in the future which may affect the actual returns. It is only provided to illustrate the potential risk and returns of each customer risk profile. It is intended for your general reference only, and it is not intended to be investment advice. Neither Mercer, Nexus Financial Services Pte Ltd nor your Nexus Adviser accepts any responsibility or liability in connection with your use of such information.
            </td>
        </tr>
        </tbody>
    </table>
    <table summary="four column design layout" class="chassis_three_column_list">
        <thead>
        <tr>
            <td colspan="4"><asp:label runat = "server" ID = "lblLineGraph" Text = "Range of Returns with Core Assets"></asp:label></td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="4">
                <asp:Image ID="imgRangeOfReturns" ImageUrl="" runat="server" Width="100%" />
            </td>
        </tr>
        </tbody>
    </table>

<%--<div class="chassis_application_navigation_container">
              <ul>
                <li class="chassis_application_navigation_selected">
                  <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                    <div class="chassis_application_navigation_inner">
                      <span class="chassis_application_page_complete">
                        <a href="/_layouts/Zurich/PortFolioBuilder/PortFolioModelling.aspx?caseid=<%=ViewState["caseid"] %>">PortFolio Builder</a>
                      </span>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="chassis_application_navigation_outer">
                    <div class="chassis_application_navigation_inner">
                      <span class="chassis_application_page_complete">
                        <a href="/_layouts/Zurich/PortFolioBuilder/ShowPortFolioModel.aspx?caseid=<%=ViewState["caseid"] %>">PortFolio Model</a>
                      </span>
                    </div>
                  </div>
                </li>                
              </ul>
            </div>--%>
<table class="chassis_four_column_list" summary="Adviser details">   
     <tbody>
     <tr>
     <td>

    <table class="chassis_two_column_list">
        <tr>
            <td class="chassis_label_column">Your Risk Profile based on Profile</td>
            <td class="chassis_data_column" align = "left"><asp:Label ID = "lblRiskProfile" runat = "server"></asp:Label> </td>            
        </tr> 
        <tr>
            <td class="chassis_label_column"><asp:Label ID = "lblAgreeRiskProfile" runat = "server" Text = "Do you agree with the above risk profile"></asp:Label></td>
            <td class="chassis_data_column" align = "left">
                <asp:radiobuttonlist id="optnAgreeRiskProfile" runat="server" class="chassis_radio" RepeatDirection = "Horizontal"  AutoPostBack = "true" OnSelectedIndexChanged = "optnAgreeRiskProfile_SelectedIndexChanged">
                    <asp:listitem id="optnAgreeRiskProfileYes" runat="server" value="1" Text = "&nbsp;Yes&nbsp;&nbsp;" />
                    <asp:listitem id="optnAgreeRiskProfileNo" runat="server" value="0" Text = "&nbsp;No&nbsp;&nbsp;"/>
                </asp:radiobuttonlist>
            </td>
        </tr>
        <tr>
            <td class="chassis_label_column"><asp:Label ID = "lblPreferredRiskProfile" runat = "server" Text = "Your preferred Risk Profile if differs from profile"></asp:Label></td>
            <td class="chassis_data_column" align = "left">               
                    <asp:DropDownList ID="ddlRiskProfileList" runat="server" CssClass="chassis_application_medium_select_list" AutoPostBack = "true"
                    OnSelectedIndexChanged = "ddlRiskProfileList_SelectedIndexChanged" Width="175px">
                        <asp:ListItem Value="-1">-- Select -- </asp:ListItem>
                        <asp:ListItem Value="0">Capital Preservation</asp:ListItem>
                        <asp:ListItem Value="1">Cautious</asp:ListItem>
                        <asp:ListItem Value="2">Moderately Cautious</asp:ListItem>
                        <asp:ListItem Value="3">Balanced</asp:ListItem>
                        <asp:ListItem Value="4">Moderately Adventurous</asp:ListItem>
                        <asp:ListItem Value="5">Adventurous</asp:ListItem>
                    </asp:DropDownList>               
            </td>            
        </tr>         
        <tr>
            <td class="chassis_label_column">I have agreed to follow the portfolio recommended based on my Risk Profile</td>
            <td class="chassis_data_column">
                <asp:radiobuttonlist id="followAssetAllocationOnRiskProfile" runat="server" class="chassis_radio" RepeatDirection = "Horizontal"  AutoPostBack="true" OnSelectedIndexChanged = "followAllocationBasedOnRiskProfile_SelectedIndexChanged">
                    <asp:listitem id="optnAssetAllocRiskProfile1" runat="server" value="1" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                    <asp:listitem id="optnAssetAllocRiskProfile2" runat="server" value="0" Text = "&nbsp;No&nbsp;&nbsp;"/>
                </asp:radiobuttonlist>
            </td>            
        </tr>
        <tr>
            <td class="chassis_label_column"><asp:Label ID = "lblIncludeNonCoreFunds" runat = "server" Text = "Include Non Core funds"></asp:Label></td>
            <td class="chassis_data_column">
                <asp:radiobuttonlist id="nonCoreFunds" runat="server" class="chassis_radio" RepeatDirection = "Horizontal" AutoPostBack="true" OnSelectedIndexChanged = "nonCoreFunds_SelectedIndexChanged">
                    <asp:listitem id="optnNonCoreFunds1" runat="server" value="1" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                    <asp:listitem id="optnNonCoreFunds2" runat="server" value="0" Text = "&nbsp;No&nbsp;&nbsp;"/>
                </asp:radiobuttonlist>
                <asp:radiobuttonlist id="allocationBasedOnRiskProfile" runat="server" class="chassis_radio" RepeatDirection = "Horizontal" AutoPostBack="true" OnSelectedIndexChanged = "onAllocationBasedOnRiskProfile_SelectedIndexChanged">
                    <asp:listitem id="optnAllocRiskProfile1" runat="server" value="0" Text = "&nbsp;Funds Risk Plotter&nbsp;&nbsp;"/>
                    <asp:listitem id="optnAllocRiskProfile2" runat="server" value="1" Text = "&nbsp;Fund Selection&nbsp;&nbsp;"/>
                </asp:radiobuttonlist> 
            </td>                
        </tr>        
      </table> 
      <table class="chassis_two_column_list">
         <thead>
            <tr>
                <td colspan="2">Investible Funds Availaible</td>
            </tr>
         </thead>
         <tbody>
            <tr >                
                <td class="chassis_label_column">
                    <asp:radiobuttonlist id="premiumSelect" runat="server" class="chassis_radio" RepeatDirection = "Horizontal" AutoPostBack="true" OnSelectedIndexChanged = "premiumSelect_SelectedIndexChanged">
                        <asp:listitem id="optnPremiumSelect1" runat="server" value="0" Text = "&nbsp;Single Premium ($)&nbsp;&nbsp;"/>
                        <asp:listitem id="optnPremiumSelect2" runat="server" value="1" Text = "&nbsp;Regular Premium ($)&nbsp;&nbsp;"/>                    
                    </asp:radiobuttonlist>               
                </td>
                <td class="chassis_data_column">                    
                    <asp:TextBox ID = "premium" Text = "0" runat= "server" CssClass="chassis_application_medium_text_box" Width="100px"  OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="chassis_label_column">Premium Mode</td>
                <td class="chassis_data_column" align = "left">
                    <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="chassis_application_medium_select_list">
                        <asp:ListItem Value="-1">-- Select --</asp:ListItem>
                        <asp:ListItem Value="1">Monthly</asp:ListItem>
                        <asp:ListItem Value="2">Quarterly</asp:ListItem>
                        <asp:ListItem Value="3">SemiAnnual</asp:ListItem>
                        <asp:ListItem Value="4">Annual</asp:ListItem>
                    </asp:DropDownList> 
                </td>
            </tr> 
            <tr>
                <td class="chassis_label_column">
                    <asp:Label ID = "lblTotal" Text = "Allocation Total Percentage" runat = "server"></asp:Label>
                </td>
                <td class="chassis_data_column">
                    <asp:TextBox ID = "txtTotalPremium" Text = "" ReadOnly = "true" runat= "server" CssClass="chassis_application_medium_text_box" Width="100px" ></asp:TextBox>&nbsp;%
                </td>
            </tr>
            <tr>
                <td >
                    <table  cellpadding = "0" cellspacing = "0" width = "100%">
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;<asp:Label ID = "lblAllocationAmtTotal" Text = "Allocation Total" runat = "server"></asp:Label>
                            </td>
                            <td align = "right">
                                SGD
                            </td>
                        </tr>
                    </table>                    
                </td>
                <td class="chassis_data_column">
                    <asp:TextBox ID = "txtAllocationAmtTotal" Text = "" ReadOnly = "true" runat= "server" CssClass="chassis_application_medium_text_box" Width="100px" ></asp:TextBox>
                </td>
            </tr>    
         </tbody>
    </table>            
    <div id="fundsCoreNoncore" runat = "server">
        <table id="fundsTableNoncore" class="chassis_single_column_list">            
            <tr>
            <td class="chassis_label_column">
                <asp:GridView ID="grdNonCoreFunds" runat="server" cellpadding="5" cellspacing="1" OnRowCreated="grdNonCoreFunds_OnRowCreated" 
                AutoGenerateColumns="false" Width = "100%" OnRowDataBound = "grdNonCoreFunds_RowDataBound" OnPreRender = "grdNonCoreFunds_PreRender">
                    <HeaderStyle ForeColor="White" Font-Bold="false" BorderColor = "White"
                    BackColor="#003399" HorizontalAlign = "Center"></HeaderStyle>
                    <RowStyle ForeColor="Black" BorderColor = "White" BackColor="#E2E8F1"></RowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Asset Classes">
                            <ItemTemplate>
                                <asp:Label ID="lblAssetClasses" runat="server" Text='<%# Bind("assetName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Funds">
                            <ItemTemplate>
                                <asp:Label ID="lblFunds" runat="server" Text='<%# Bind("fundName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Allocation (%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAllocation" runat="server" Text='<%# Bind("allocationPercentage") %>' CssClass="chassis_application_medium_text_box"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Eval("amount", "{0:0}") %>' CssClass="chassis_application_medium_text_box" ReadOnly = "true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblPercentage" runat="server" Text='<%# Bind("percentage") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>
                         <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetName" runat="server" Text='<%# Bind("assetName") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>                    
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetId" runat="server" Text='<%# Bind("asset_id") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("fund_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblColor" runat="server" Text='<%# Bind("colour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>                        
                    </Columns>
                </asp:GridView>
            </td>
        </tr>         
        </table>
    </div>    
    <div id="fundRiskPlotter" runat = "server">
        <div id="disclaimer" runat = "server">
            <table>
                <tr style="font-weight:bold;color:Red;">
                    <td colspan="4" >
                        Please note that this option is done without proper recommendation by the advisor. You need<br />
                        to complete and pass the Customer Knowledge Assesment before you can select specific funds.<br />
                    </td>
                </tr>
            </table>
        </div>

        <table id="fundRiskPlotterTable" width="100%">            
            <tr>
            <td>
                <asp:GridView ID="grdFundRiskPlotter" cellpadding="5" cellspacing="1" runat="server" OnRowCreated="grdFundRiskPlotter_OnRowCreated" AutoGenerateColumns="false" Width = "100%" OnRowDataBound = "grdFundRiskPlotter_RowDataBound">
                    <HeaderStyle ForeColor="White" Font-Bold="false" BorderColor = "White"
                    BackColor="#003399" HorizontalAlign = "Center"></HeaderStyle>
                    <RowStyle ForeColor="Black" BorderColor = "White" BackColor="#E2E8F1"></RowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Asset Classes">
                            <ItemTemplate>
                                <asp:Label ID="lblAssetClasses" runat="server" Text='<%# Bind("assetName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Funds">
                            <ItemTemplate>
                                <asp:Label ID="lblFunds" runat="server" Text='<%# Bind("fundName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Allocation (%)" >
                            <ItemTemplate>
                                <asp:TextBox ID="txtAllocation" runat="server" Text='<%# Bind("allocationPercentage") %>' CssClass="chassis_application_medium_text_box" ></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Eval("amount", "{0:0}") %>' CssClass="chassis_application_medium_text_box" ReadOnly= "true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetId" runat="server" Text='<%# Bind("asset_id") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("fund_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblColor" runat="server" Text='<%# Bind("colour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr runat = "server" id = "trProfilePercent">
            <td colspan="4" style='background-color:#003399;color: #FFFFFF;'>
           <b> <asp:Label id = "lblProfilePercent" runat = "server" text = ""></asp:Label>
             </b></td>                
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grdSecondaryFunds" cellpadding="5" cellspacing="1" runat="server" OnRowCreated="grdSecondaryFunds_OnRowCreated" AutoGenerateColumns="false" Width = "100%" OnRowDataBound = "grdSecondaryFunds_RowDataBound">
                    <HeaderStyle ForeColor="White" Font-Bold="false" BorderColor = "White"
                    BackColor="#003399" HorizontalAlign = "Center"></HeaderStyle>
                    <RowStyle ForeColor="Black"  BorderColor = "White" BackColor="#EDEDED"></RowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Asset Classes" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetClasses" runat="server" Text='<%# Bind("assetName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Funds">
                            <ItemTemplate>
                                <asp:Label ID="lblFunds" runat="server" Text='<%# Bind("fundName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Allocation (%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAllocation" runat="server" Text='<%# Bind("allocationPercentage") %>' CssClass="chassis_application_medium_text_box" ></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Eval("amount", "{0:0}") %>' CssClass="chassis_application_medium_text_box" ReadOnly = "true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetId" runat="server" Text='<%# Bind("asset_id") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("fund_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblColor" runat="server" Text='<%# Bind("colour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>    
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grdFundsSelection" cellpadding="5" cellspacing="1" runat="server" OnRowCreated="grdFundsSelection_OnRowCreated" AutoGenerateColumns="false" Width = "100%" OnRowDataBound = "grdFundsSelection_RowDataBound">
                    <HeaderStyle ForeColor="White" Font-Bold="false" BorderColor = "White"
                    BackColor="#003399" HorizontalAlign = "Center"></HeaderStyle>
                    <RowStyle ForeColor="Black"  BorderColor = "White" BackColor="#E2E8F1"></RowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Asset Classes">
                            <ItemTemplate>
                                <asp:Label ID="lblAssetClasses" runat="server" Text='<%# Bind("assetName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Funds">
                            <ItemTemplate>
                                <asp:Label ID="lblFunds" runat="server" Text='<%# Bind("fundName") %>' class="chassis_label_column"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="40%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Allocation (%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAllocation" runat="server" Text='<%# Bind("allocationPercentage") %>' CssClass="chassis_application_medium_text_box" ></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Eval("amount", "{0:0}") %>' CssClass="chassis_application_medium_text_box" ReadOnly = "true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblAssetId" runat="server" Text='<%# Bind("asset_id") %>'></asp:Label>
                            </ItemTemplate>                            
                        </asp:TemplateField>
                        <asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("fund_id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField Visible = "false" >
                            <ItemTemplate>
                                <asp:Label ID="lblColor" runat="server" Text='<%# Bind("colour") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        </table>
    </div>

    <div id="fundplotterButton" runat = "server" class="chassis_application_pane">
        <table width="100%">
            <tr>
                <td width="100%" align = "right">
                    <asp:Button id = "btnPrintRiskPlotter" runat = "server" class = "chassis_application_button_xxxlarge" Text = "Generate PDF" OnClick = "printRiskPlotter_Click" />                    
                    <asp:Button ID="btnBackFundPlotter" runat = "server" class = "chassis_application_button_medium" Text = "Previous" OnClick = "savePortFolioBuilderAndBack" />
                    <asp:Button ID="btnSaveFundPloter" runat = "server" class = "chassis_application_button_medium" Text = "Save" OnClick = "SaveFundPlotter_Click" />
                    <asp:Button ID="btnNextFundPlotter" runat = "server" class = "chassis_application_button_medium" Text = "Next" OnClick = "savePortFolioBuilderAndNext" />
                    <asp:Button ID="Button1" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>
                </td>
            </tr>
        </table>
    </div>

    <div id="portfoliomodelSaveButton" runat = "server" class="chassis_application_pane">
        <table width="100%">
            <tr>
                <td width="100%" align = "right">
                    <asp:Button id = "btnPrint" runat = "server" class = "chassis_application_button_xxxlarge" Text = "Generate PDF" OnClick = "printAssetBasedPortfolioModel_Click" />
                    <asp:Button ID="btnBackPortFolioModel" runat = "server" class = "chassis_application_button_medium" Text = "Previous" OnClick = "savePortFolioBuilderAndBack" />
                    <asp:Button ID="btnSavePortFolioModel" runat = "server" class = "chassis_application_button_medium" Text = "Save" OnClick = "SavePortFolioModel_Click" />
                    <asp:Button ID="btnNextPortFolioModel" runat = "server" class = "chassis_application_button_medium" Text = "Next" OnClick = "savePortFolioBuilderAndNext" />
                    <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>
                &nbsp;&nbsp;</td>
            </tr>
        </table>
    </div>

</td>
     </tr>
     </tbody>
</table>
</div>
</div>
</div>
</div>
</ContentTemplate>
 <triggers>
    <asp:postbacktrigger controlid="btnPrintRiskPlotter"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnBackFundPlotter"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnSaveFundPloter"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnNextFundPlotter"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="Button1"></asp:postbacktrigger>

    <asp:postbacktrigger controlid="btnPrint"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnBackPortFolioModel"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnSavePortFolioModel"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="btnNextPortFolioModel"></asp:postbacktrigger>
    <asp:postbacktrigger controlid="Button4"></asp:postbacktrigger>    
 </triggers>
  </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
	Portfolio Builder
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
	Portfolio Builder
</asp:Content>
