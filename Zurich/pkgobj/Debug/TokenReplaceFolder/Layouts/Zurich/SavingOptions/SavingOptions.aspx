<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SavingOptions.aspx.cs" Inherits="Zurich.Layouts.Zurich.SavingOptions.SavingOptions" MasterPageFile="~/_layouts/Zurich/master/minimal.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/js/04.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/04.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/common.css" />


</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<h1>Ways to achieve your Saving Goals of $<asp:Label ID="shortfallString" runat="server"/> in <asp:Label ID="yrstoAccumulateString" runat="server"/> years</h1>

<div id="wrapper">
				<div class="chart1">
					<h2>Regular Annual Sum</h2>
				</div>

				<div class="chart2">
						<h2>Lump Sum</h2>
				</div>

		<table id="data-table1" border="1" cellpadding="10" cellspacing="0" >
					<caption></caption>
					<thead>
						<tr>
							
							<th scope="col">2% pa</th>
							<th scope="col">4% pa</th>
							<th scope="col">6% pa</th>
							<th scope="col">8% pa</th>
						</tr>
					</thead>
					<tbody>
											<tr>
												<th scope="row">Lowest</th>
												<td><asp:Label ID="lowest1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label14" runat="server"/>0</td>

                                                <td><asp:Label ID="Label16" runat="server"/>0</td>
                                                <td><asp:Label ID="Label15" runat="server"/>0</td>

											</tr>
											<tr>
												<th scope="row">Low</th>
                                                <td><asp:Label ID="Label17" runat="server"/>0</td>

												<td><asp:Label ID="low1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label18" runat="server"/>0</td>

                                                <td><asp:Label ID="Label19" runat="server"/>0</td>

											</tr>
											<tr>
												<th scope="row">High</th>
                                                <td><asp:Label ID="Label20" runat="server"/>0</td>

                                                <td><asp:Label ID="Label21" runat="server"/>0</td>

                                                <td><asp:Label ID="high1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label22" runat="server"/>0</td>

												
											</tr>
                                            <tr>
												<th scope="row">Highest</th>
                                                <td><asp:Label ID="Label23" runat="server"/>0</td>
                                                <td><asp:Label ID="Label24" runat="server"/>0</td>
                                                <td><asp:Label ID="Label25" runat="server"/>0</td>
                                                <td><asp:Label ID="highest1" runat="server" Text="" /></td>
											</tr>
					</tbody>
				</table>

        <table id="data-table2" border="1" cellpadding="10" cellspacing="0" >
					<caption></caption>
					<thead>
						<tr>
							
							
							<th scope="col">2% pa</th>
							<th scope="col">4% pa</th>
							<th scope="col">6% pa</th>
							<th scope="col">8% pa</th>
						</tr>
					</thead>
					<tbody>
											<tr>
												<th scope="row">Lowest</th>
												<td><asp:Label ID="lumpsumLowest1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label2" runat="server"/>0</td>
                                                <td><asp:Label ID="Label3" runat="server"/>0</td>
                                                <td><asp:Label ID="Label4" runat="server"/>0</td>
											</tr>
											<tr>
												<th scope="row">Low</th>
                                                <td><asp:Label ID="Label5" runat="server"/>0</td>
												<td><asp:Label ID="lumpsumLow1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label6" runat="server"/>0</td>
                                                <td><asp:Label ID="Label7" runat="server"/>0</td>

											</tr>
											<tr>
												<th scope="row">High</th>
                                                <td><asp:Label ID="Label8" runat="server"/>0</td>
                                                <td><asp:Label ID="Label9" runat="server"/>0</td>
												<td><asp:Label ID="lumpsumHigh1" runat="server" Text="" /></td>
                                                <td><asp:Label ID="Label10" runat="server"/>0</td>
												
											</tr>
                                            <tr>
												<th scope="row">Highest</th>
                                                <td><asp:Label ID="Label11" runat="server"/>0</td>
                                                <td><asp:Label ID="Label12" runat="server"/>0</td>
                                                <td><asp:Label ID="Label13" runat="server"/>0</td>
												<td><asp:Label ID="lumpsumHighest1" runat="server" Text="" /></td>
											</tr>
					</tbody>
				</table>

        </div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
My Saving Options
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Saving Options
</asp:Content>
