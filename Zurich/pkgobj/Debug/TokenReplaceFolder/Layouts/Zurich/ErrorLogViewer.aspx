<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorLogViewer.aspx.cs" Inherits="Zurich.Layouts.Zurich.ErrorLogViewer" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:label runat="server" id = "lblMessage" text = "Please execute only one Select Statement at a time. Please do not write any Update Statements and Delete Statements"></asp:label>
<br />
<asp:label runat = "server" id = "lblPassword" text = "Password" Width="100px" Height="15px"></asp:label>
<asp:textbox runat = "server" id = "txtPassword" text = "" Width="100px" Height="15px"></asp:textbox>
<br />
<asp:textbox runat = "server" id = "txtSQLText" text = "" TextMode="MultiLine" Width="830px" Height="150px"></asp:textbox>
<br />
<asp:Button runat = "server" ID = "btnRefresh" Text = "Show Exception Log" OnClick = "btnRefreshExceptionLogClick" />
<asp:Button runat = "server" ID = "btnExecuteQry" Text = "Execute Query" OnClick = "btnExecuteQryClick" />
<br />
<asp:label runat="server" id = "lblErrorMessage" text = "" ForeColor = "red" Width = "100%"></asp:label>
<br />
      <asp:GridView ID="grdErrorViewer" runat="server" AutoGenerateColumns="true" 
            CellPadding="4" 
            ForeColor="#333333" GridLines="None" 
            AllowPaging="True">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <%--<Columns>
                <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id" />
                <asp:BoundField DataField="message" HeaderText="Message" SortExpression="message" />
                <asp:BoundField DataField="source" HeaderText="Source" SortExpression="source" />
                <asp:BoundField DataField="stacktrace" HeaderText="Stack Trace" SortExpression="stacktrace" />
                <asp:BoundField DataField="targetsitename" HeaderText="Target Site Name" SortExpression="targetsitename" />                
            </Columns>--%>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>        
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Error Log Viewer
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Error Log Viewer
</asp:Content>
