<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowExistingSavingGoals.aspx.cs" Inherits="Zurich.Layouts.Zurich.SavingGoals.ShowExistingSavingGoals" MasterPageFile="~/_layouts/Zurich/master/minimal.master" EnableEventValidation="false" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />

<!-- popup libraries -->

<link type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/ui-lightness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-1.8.17.custom.min.js"></script>

<script type="text/javascript">

    function onEdit(rowid) {
        alert(window.opener.document.getElementById('savinggoalid'));
        //window.opener.document.getElementById('savinggoalid').value = rowid;
        window.close();
    }

</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<asp:HiddenField ID="editclicked" runat="server" />

<table class="chassis_four_column_list">
<tbody>
    <tr>
        <td>

        <asp:DataGrid ID="existingsggrid" runat="server" AutoGenerateColumns="false" OnEditCommand="existingsggrid_Edit" OnDeleteCommand="existingsggrid_Delete">
            <Columns>
                <asp:TemplateColumn HeaderText="Id" Visible="false" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "id") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Goal" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblgoal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "goal") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Years to Accumulate" ItemStyle-Width="10%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblyrstoaccumulate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "yrstoaccumulate") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount Needed Future Value" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblamtneededfv" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "amtneededfv") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Maturity Value" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblmaturityvalue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "maturityvalue") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Total" ItemStyle-Width="20%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbltotal" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "total") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Edit" ItemStyle-Width="5%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <a href="" onclick="javascript:onEdit(6)">Edit</a>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:ButtonColumn CommandName="Delete" HeaderText="Delete" Text="Delete" ItemStyle-Width="5%" ItemStyle-CssClass="chassis_label_column" HeaderStyle-CssClass="table_header" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center">
                </asp:ButtonColumn>
            </Columns>
        </asp:DataGrid>

        </td>
    </tr>
</tbody>
</table>
    
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Existing Saving Goals
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Existing Saving Goals
</asp:Content>
