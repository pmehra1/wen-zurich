<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GapSummary.aspx.cs" Inherits="Zurich.Layouts.Zurich.PortFolioBuilder.GapSummary"
    DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>

<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" Src="~/_controltemplates/Zurich/FNAMenu.ascx" %>
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
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css"
        media="all" />
    <link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css"
        media="all" />
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
                $('#gapSummary').addClass("chassis_application_navigation_selected_tab1");
            });
        });

        function allowOnlyNumbers() {
            if (event.keyCode < 45 || event.keyCode > 57) {
                event.returnValue = false;
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
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:HiddenField ID="activityId" runat="server" />
    <asp:HiddenField ID="backToCase" runat="server"  />
    <div id="chassis_outer_container">
        <div class="chassis_page_container">
            <FNAMenutag:FNAMenu runat="server" ID="FNAMenu1" />
            <div class="chassis_application_pane">
                <div id="chassis_application_content" class="chassis_application_body">
                    <table class="chassis_single_column_list" summary="Error Details">
                        <tr>
                            <td>
                                <asp:Label ID="lblGapSummarySaveSuccess" runat="server" class="chassis_application_save_success"
                                    Text="• Priorities saved successfully"></asp:Label>
                                <asp:Label ID="lblGapSummarySaveFailed" runat="server" class="chassis_application_feedback_error"
                                    Text="• Failed to save Priorities"></asp:Label>
                                <asp:Label ID="lblPrioritiesSequence" runat="server" class="chassis_application_feedback_error"
                                    Text="• Priorities are not specified sequentially"></asp:Label>
                                <asp:Label ID="lblNotNumeric" runat="server" class="chassis_application_feedback_error"
                                    Text="• Priorities should have only numeric values"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table summary="single column design layout" class="chassis_single_column_list">
                        <thead>
                            <tr>
                                <td>
                                    What are my Gaps?
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="chassis_label_column">
                                    <asp:GridView ID="grdGapSummary" runat="server" CellPadding="5" CellSpacing="1" AutoGenerateColumns="false"
                                        Width="100%" OnRowDataBound="grdGapSummary_RowDataBound" OnRowCreated = "grdGapSummary_RowCreated" OnPreRender="grdGapSummary_PreRender">
                                        <HeaderStyle ForeColor="White" Font-Bold="false" BorderColor="White" BackColor="#003399"
                                            HorizontalAlign="Center"></HeaderStyle>
                                        <%--<RowStyle ForeColor="Black" BorderColor="White" BackColor="#E2E8F1"></RowStyle>--%>
                                        <RowStyle ForeColor="Black" BorderColor="White" BackColor="white"></RowStyle>
                                        <AlternatingRowStyle ForeColor="Black" BorderColor="White" BackColor="#F0F0F6" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="&nbsp;">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHeader" runat="server" Text='<%# Bind("Title") %>' class="chassis_label_column"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Needs">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNeeds" runat="server" Text='<%# Bind("Needs") %>' class="chassis_label_column"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount Required" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmtRequired" runat="server" Text='<%# Bind("AmountRequired") %>'
                                                        class="chassis_label_column"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Existing Arrangements" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExtArrangements" runat="server" Text='<%# Bind("ExistingArrangements") %>'
                                                        class="chassis_label_column"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Current Shortfall (-) / Surplus (+)" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCurrShortfall" runat="server" Text='<%# Bind("CurrentShortfall") %>'
                                                        class="chassis_label_column"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="My Priorities" HeaderStyle-HorizontalAlign = "center" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMyPriorities" runat="server" Text='<%# Bind("MyPriorities") %>'
                                                        class="chassis_label_column"></asp:Label>                                                    
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNeedId" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGapSummaryTypeID" runat="server" Text='<%# Bind("gapSummaryTypeId") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssetId" runat="server" Text='<%# Bind("") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFundId" runat="server" Text='<%# Bind("") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnPrint" runat="server" class="chassis_application_button_xxxlarge"
                                        Text="Generate PDF" OnClick="printGapSummary_Click" />                                    
                                    <asp:Button ID="btnBackGapSummary" runat="server" class="chassis_application_button_medium"
                                        Text="Previous" OnClick="saveGapSummaryAndBack" />                                    
                                    <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClick="redirectToCasePortal" OnClientClick="onBackToCase()"/>
                                    &nbsp;
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
    Application Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Application Page
</asp:Content>
