<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetAndLiabilityPopUp.aspx.cs" Inherits="Zurich.Layouts.Zurich.AssetAndLiabilityPopUp" MasterPageFile="~/_layouts/Zurich/master/minimal.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui-i18n.min.js" type="text/javascript"></script>

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />



<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        $('input').attr("readonly", true);
        calculateAssets();

        $(function () {
            $('#chassis_page_navigation_selected').attr('id', '');
            $('a[name=factFind]').attr('id', 'chassis_page_navigation_selected');
        });

    });

    function sumOthersInvestedAssetsCash() {

        var sumCash = 0;

        var count = $("#othersInvestedAssets >tbody > tr").size();
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherscash-' + i) != null && document.getElementById('priotherscash-' + i).value != '' && !isNaN(document.getElementById('priotherscash-' + i).value)) {
                    sumCash += parseFloat(document.getElementById('priotherscash-' + i).value);
                }
            }
        }
        return sumCash;
    }


    function sumOthersInvestedAssetsCpf() {

        var sumCpf = 0;
        var count = $("#othersInvestedAssets >tbody > tr").size();
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherscpf-' + i) != null && document.getElementById('priotherscpf-' + i).value != '' && !isNaN(document.getElementById('priotherscpf-' + i).value)) {
                    sumCpf += parseFloat(document.getElementById('priotherscpf-' + i).value);
                }
            }
        }
        return sumCpf;
    }


    function sumOthersPersonalAssetsCash() {

        var sumCash = 0;

        var count = $("#otherPersonalAssets >tbody > tr").size();
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherspucash-' + i) != null && document.getElementById('priotherspucash-' + i).value != '' && !isNaN(document.getElementById('priotherspucash-' + i).value)) {
                    sumCash += parseFloat(document.getElementById('priotherspucash-' + i).value);
                }
            }
        }
        return sumCash;
    }


    function sumOthersPersonalAssetsCpf() {
        var sumCpf = 0;
        var count = $("#otherPersonalAssets >tbody > tr").size();
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherspucpf-' + i) != null && document.getElementById('priotherspucpf-' + i).value != '' && !isNaN(document.getElementById('priotherspucpf-' + i).value)) {
                    sumCpf += parseFloat(document.getElementById('priotherspucpf-' + i).value);
                }
            }
        }
        return sumCpf;
    }


    function sumOthersLiabilities() {
        var sumLiabilities = 0;

        var count = $("#otherLiabilities >tbody > tr").size();
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherslbamount-' + i) != null && document.getElementById('priotherslbamount-' + i).value != '' && !isNaN(document.getElementById('priotherslbamount-' + i).value)) {
                    sumLiabilities += parseFloat(document.getElementById('priotherslbamount-' + i).value);
                }
            }
        }
        return sumLiabilities;
    }


    function calculateAssets() {
        var sumCashAssets = 0;
        var sumCpfAssets = 0;
        var sumAssets = 0;
        var sumLiabilities = 0;


        if (document.getElementById('<%=homeMortgage.ClientID %>') != null && document.getElementById('<%=homeMortgage.ClientID %>').value != '' && !isNaN(document.getElementById('<%=homeMortgage.ClientID %>').value)) {
            sumLiabilities += parseFloat(document.getElementById('<%=homeMortgage.ClientID %>').value);
        }
        if (document.getElementById('<%=vehicleLoan.ClientID %>') != null && document.getElementById('<%=vehicleLoan.ClientID %>').value != '' && !isNaN(document.getElementById('<%=vehicleLoan.ClientID %>').value)) {
            sumLiabilities += parseFloat(document.getElementById('<%=vehicleLoan.ClientID %>').value);
        }

        if (document.getElementById('<%=cashLoan.ClientID %>') != null && document.getElementById('<%=cashLoan.ClientID %>').value != '' && !isNaN(document.getElementById('<%=cashLoan.ClientID %>').value)) {
            sumLiabilities += parseFloat(document.getElementById('<%=cashLoan.ClientID %>').value);
        }
        if (document.getElementById('<%=creditCard.ClientID %>') != null && document.getElementById('<%=creditCard.ClientID %>').value != '' && !isNaN(document.getElementById('<%=creditCard.ClientID %>').value)) {
            sumLiabilities += parseFloat(document.getElementById('<%=creditCard.ClientID %>').value);
        }



        if (document.getElementById('<%=bankAcctCash.ClientID %>') != null && document.getElementById('<%=bankAcctCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=bankAcctCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=bankAcctCash.ClientID %>').value);
        }

        if (document.getElementById('<%=cpfoaBal.ClientID %>') != null && document.getElementById('<%=cpfoaBal.ClientID %>').value != '' && !isNaN(document.getElementById('<%=cpfoaBal.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=cpfoaBal.ClientID %>').value);
        }

        if (document.getElementById('<%=cpfsaBal.ClientID %>') != null && document.getElementById('<%=cpfsaBal.ClientID %>').value != '' && !isNaN(document.getElementById('<%=cpfsaBal.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=cpfsaBal.ClientID %>').value);
        }

        if (document.getElementById('<%=srsBal.ClientID %>') != null && document.getElementById('<%=srsBal.ClientID %>').value != '' && !isNaN(document.getElementById('<%=srsBal.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=srsBal.ClientID %>').value);
        }

        if (document.getElementById('<%=stocksSharesCash.ClientID %>') != null && document.getElementById('<%=stocksSharesCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=stocksSharesCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=stocksSharesCash.ClientID %>').value);
        }

        if (document.getElementById('<%=stocksSharesCpf.ClientID %>') != null && document.getElementById('<%=stocksSharesCpf.ClientID %>').value != '' && !isNaN(document.getElementById('<%=stocksSharesCpf.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=stocksSharesCpf.ClientID %>').value);
        }

        if (document.getElementById('<%=unitTrustsCash.ClientID %>') != null && document.getElementById('<%=unitTrustsCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=unitTrustsCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=unitTrustsCash.ClientID %>').value);
        }

        if (document.getElementById('<%=unitTrustsCpf.ClientID %>') != null && document.getElementById('<%=unitTrustsCpf.ClientID %>').value != '' && !isNaN(document.getElementById('<%=unitTrustsCpf.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=unitTrustsCpf.ClientID %>').value);
        }

        if (document.getElementById('<%=ilpCash.ClientID %>') != null && document.getElementById('<%=ilpCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=ilpCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=ilpCash.ClientID %>').value);
        }

        if (document.getElementById('<%=ilpCpf.ClientID %>') != null && document.getElementById('<%=ilpCpf.ClientID %>').value != '' && !isNaN(document.getElementById('<%=ilpCpf.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=ilpCpf.ClientID %>').value);
        }



        if (document.getElementById('<%=srsInvCash.ClientID %>') != null && document.getElementById('<%=srsInvCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=srsInvCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=srsInvCash.ClientID %>').value);
        }

        if (document.getElementById('<%=invPropCash.ClientID %>') != null && document.getElementById('<%=invPropCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=invPropCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=invPropCash.ClientID %>').value);
        }

        if (document.getElementById('<%=invPropCpf.ClientID %>') != null && document.getElementById('<%=invPropCpf.ClientID %>').value != '' && !isNaN(document.getElementById('<%=invPropCpf.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=invPropCpf.ClientID %>').value);
        }

        if (document.getElementById('<%=cpfMediSaveBalance.ClientID %>') != null && document.getElementById('<%=cpfMediSaveBalance.ClientID %>').value != '' && !isNaN(document.getElementById('<%=cpfMediSaveBalance.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=cpfMediSaveBalance.ClientID %>').value);
        }



        if (document.getElementById('<%=resPropCash.ClientID %>') != null && document.getElementById('<%=resPropCash.ClientID %>').value != '' && !isNaN(document.getElementById('<%=resPropCash.ClientID %>').value)) {
            sumCashAssets += parseFloat(document.getElementById('<%=cpfMediSaveBalance.ClientID %>').value);
        }

        if (document.getElementById('<%=resPropCpf.ClientID %>') != null && document.getElementById('<%=resPropCpf.ClientID %>').value != '' && !isNaN(document.getElementById('<%=resPropCpf.ClientID %>').value)) {
            sumCpfAssets += parseFloat(document.getElementById('<%=resPropCpf.ClientID %>').value);
        }

        sumCashAssets += sumOthersInvestedAssetsCash();
        sumCashAssets += sumOthersPersonalAssetsCash();

        sumCpfAssets += sumOthersInvestedAssetsCpf();
        sumCpfAssets += sumOthersPersonalAssetsCpf();

        sumLiabilities += sumOthersLiabilities();




        document.getElementById('<%=totalLiabilitiesOthers.ClientID %>').value = sumLiabilities;
        document.getElementById('<%=personalUseAssetsTotalCash.ClientID %>').value = sumCashAssets;
        document.getElementById('<%=personalUseAssetsTotalCPF.ClientID %>').value = sumCpfAssets;

        sumAssets = sumCashAssets + sumCpfAssets;
        document.getElementById('<%=netWorth.ClientID %>').value = sumAssets - sumLiabilities;

    }

    function next() {
        window.location.href = '/FactFind/IncomeExpensesInsurance';

    }

    function back() {
        window.location.href = '/FactFind/PriorityDetails';

    }

    function formsubmit() {
        var noofothers = $("#othersInvestedAssets >tbody > tr").size();
        document.getElementById('noofothers').value = noofothers;

        var noofotherspersonaluse = $("#otherPersonalAssets >tbody > tr").size();
        document.getElementById('noofotherspersonaluse').value = noofotherspersonaluse;

        var noofothersliabilities = $("#otherLiabilities >tbody > tr").size();
        document.getElementById('noofothersliabilities').value = noofothersliabilities;

        document.getElementById('printpage').value = "false";
        document.forms[0].submit();
    }

    function printpg() {
        var noofothers = $("#othersInvestedAssets >tbody > tr").size();
        document.getElementById('noofothers').value = noofothers;

        var noofotherspersonaluse = $("#otherPersonalAssets >tbody > tr").size();
        document.getElementById('noofotherspersonaluse').value = noofotherspersonaluse;

        var noofothersliabilities = $("#otherLiabilities >tbody > tr").size();
        document.getElementById('noofothersliabilities').value = noofothersliabilities;

        document.getElementById('printpage').value = "true";
        document.forms[0].submit();
    }

    function allowOnlyNumbers() {
        if (event.keyCode < 45 || event.keyCode > 57) {
            event.returnValue = false;
        }
    } 


</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="activityId" runat="server"  />
<asp:HiddenField ID="otherInvestedAssetsNumber" runat="server"  />
<asp:HiddenField ID="otherPersonalUsedAssetsNumber" runat="server"  />
<asp:HiddenField ID="otherLiabilitiesNumber" runat="server"  />
<asp:HiddenField ID="caseId" runat="server"  />
<div id="chassis_outer_container">
<div class="chassis_page_container">
    <div class="chassis_application_pane">
        <div id="chassis_application_content" class="chassis_application_body">
    
    <table class="chassis_four_column_list" summary="Adviser details">
            <thead>
                <tr>
                    <td colspan="2">Assets and Liabilities</td>
                </tr>
            </thead>

          </table>  
          <table class="chassis_four_column_list" summary="Adviser details">
            
            <tr>
            <td class="chassis_data_column">
                
                <table summary="test" class="chassis_application_list_navigation" border="0"
                    cellpadding="0" cellspacing="1">

                    <thead>
                      <tr>
                        <th class="header">ASSETS</th>
                        <th class="header">CASH(SGD)</th>
                        <th class="header">CPF(SGD)</th>
                      </tr>
                    </thead>
                    <tbody>
                        <tr class="odd">
                            <td colspan=3><b>Cash & Equivalents</b></td>
                        </tr>
                        <tr class="even">
                            <td >Bank Account</td>
                            <td ><asp:TextBox  ID="bankAcctCash" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox></td>
                            <td ></td>
                    </tr>
                    <tr class="odd">
                        <td >CPF-OA Balance</td>
                        <td ></td>
                        <td >
                            <asp:TextBox ID="cpfoaBal" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td >CPF-SA Balance</td>
                        <td ></td>
                        <td >
                             <asp:TextBox ID="cpfsaBal" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>CPF Medisave Balance</td>
                        <td></td>
                        <td>
                            <asp:TextBox ID="cpfMediSaveBalance" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td>SRS Balance</td>
                        <td></td>
                        <td>
                            <asp:TextBox ID="srsBal" OnKeyPress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr class="odd">
                        <td colspan=3 align=center>
                            <b>Invested Assets</b>
                        </td>
                    </tr>

                    <tr class="even">
                        <td>Stocks & Shares</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()"  onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" ID="stocksSharesCash"  runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="stocksSharesCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Unit Trusts</td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="unitTrustsCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="unitTrustsCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>



                    <tr class="even">
                        <td >Investment-Linked Policies</td>
                        <td >
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="ilpCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="ilpCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>SRS</td>
                        <td>
                         <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" ID="srsInvCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr class="even">
                        <td>Investment Properties</td>
                        <td>
                        <asp:TextBox  OnKeyPress = "javascript:allowOnlyNumbers()" ID="invPropCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="invPropCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td colspan=3>
                            <fieldset>
                        <legend>OTHERS:&nbsp;<a href="#" id="plus"></legend>
                             <table id="othersInvestedAssets" width=100%>
                            <asp:Repeater ID="assetList" runat="server">
                                <ItemTemplate>
                                    <tr id='othersInvestedAssetsrowId<%# Container.ItemIndex%>'>
                                        <td align='left'>
                                            <input type='text' value='<%# Eval("assetDesc") %>' style='width: 82px;'  id="priothers-<%# Container.ItemIndex%>" name="priothers-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers()" value='<%# Eval("cash") %>' id="priotherscash-<%# Container.ItemIndex%>"  name="priotherscash-<%# Container.ItemIndex%>" style='width: 82px;' onblur='calculateAssets()'/>
                                         </td>
                                         <td align='left'>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers()"  value='<%# Eval("cpf") %>' id="priotherscpf-<%# Container.ItemIndex%>" name="priotherscpf-<%# Container.ItemIndex%>" onblur='calculateAssets()' style="width: 82px;"/>&nbsp;&nbsp;
                                        </td>
                                     </tr>       
                                
                                </ItemTemplate>
                            </asp:Repeater>
                            </table>
                        </fieldset>
                        </td>
                    </tr>

                    <tr class="odd">
                        <td colspan=3 align=center>
                            <b>Residential Property</b>
                        </td>
                    </tr>

                    <tr class="even">
                        <td>Residential Property</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" ID="resPropCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="resPropCpf" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan=3>
                            <fieldset>
                        <legend>OTHERS:&nbsp;<a href="#" id="otherPersonalUseOthersPlus"></legend>
                             <table id="otherPersonalAssets" width=100%>
                            <asp:Repeater ID="otherPersonalAssetsRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='otherPersonalAssets<%# Container.ItemIndex%>'>
                                        <td align='left'>
                                            <input type='text' onblur='calculateAssets()' value='<%# Eval("assetDesc") %>' style='width: 82px;'  id="priotherspu-<%# Container.ItemIndex%>" name="priotherspu-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td align='left'>
                                            <input onkeypress = "javascript:allowOnlyNumbers()" type='text' onblur='calculateAssets()'  value='<%# Eval("cash") %>' id="priotherspucash-<%# Container.ItemIndex%>" name="priotherspucash-<%# Container.ItemIndex%>" style="width: 82px;"/>
                                         </td>
                                         <td>
                                            <input onkeypress = "javascript:allowOnlyNumbers()" type='text' onblur='calculateAssets()' value='<%# Eval("cpf") %>' style='width: 82px;'  id="priotherspucpf-<%# Container.ItemIndex%>" name="priotherspucpf-<%# Container.ItemIndex%>"/>&nbsp;&nbsp;
                                         </td>
                                     </tr>       
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                        </fieldset>
                        </td>
                    </tr>
                   
                    <tr class="odd">
                        <td ><b>Total</b></td>
                        <td >
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="personalUseAssetsTotalCash" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" ID="personalUseAssetsTotalCPF" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    </tbody>

                </table>

            </td>
            <td class="chassis_data_column" style="vertical-align:top">
                
                <table summary="test" class="chassis_application_list_navigation" border="0"
                    cellpadding="0" cellspacing="1">

                    <thead>
                      <tr>
                        <th class="header">LIABILITIES</th>
                        <th class="header">(SGD)</th>
                      </tr>
                    </thead>
                    <tbody>
                    <tr class="even">
                        <td>Home Mortgage</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="homeMortgage" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Vehicle Loan</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="vehicleLoan" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td>Overdraft</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="cashLoan" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Credit Card</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="creditCard" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                        <td colspan=2>
                        
                        <fieldset> 
                        <legend>OTHERS:&nbsp;<a href="#" id="otherLiabilitiesPlus"></legend>
                             <table id="otherLiabilities" width=100%>
                            <asp:Repeater ID="liabilitiesOtherRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='otherLiabilities<%# Container.ItemIndex-1%>'>
                                        <td align='left'>
                                            <input type='text' onblur='calculateAssets()' value='<%# Eval("liabilityDesc") %>' style='width: 82px;'  id="priotherslb-<%# Container.ItemIndex%>" name="priotherslb-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers()" onblur='calculateAssets()'  value='<%# Eval("cash") %>' id="priotherslbamount-<%# Container.ItemIndex%>" name="priotherslbamount-<%# Container.ItemIndex%>" style="width: 82px;"/>&nbsp;&nbsp;
                                         </td>
                                     </tr>       
                                </ItemTemplate>
                            </asp:Repeater>
                         </table>
                        </fieldset>
                        
                        </td>

                    <tr>
                    
                    
                    </tr>
                    <tr class="even">
                        <td ><b>Total</b></td>
                        <td>
                            <asp:TextBox ID="totalLiabilitiesOthers" OnKeyPress = "javascript:allowOnlyNumbers()" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    </tbody>
                    </table>
                
                  <table class="chassis_two_column_list" summary="Adviser details">
                    <thead>
                        <tr>
                            <td colspan="2"><b>NET WORTH (ASSETS - LIABILITIES)</b>
                            <asp:TextBox CssClass="chassis_application_extra_small_text_boxs" ReadOnly="true" BackColor="#E0E0E0" ID="netWorth" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </thead>
                    </table>

                    <table summary="test" class="chassis_application_list_navigation" border="0"
                    cellpadding="0" cellspacing="1">

                    <thead>
                      <tr>
                        <th class="header">FREE FUNDS FOR PLANNING</th>
                        <th class="header">CASH(S$)</th>
                        <th class="header">CPF(S$)</th>
                      </tr>
                    </thead>
                    <tbody>
                    <tr class="odd">
                        <td>Regular Sum per Year</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" ID="regularSumCash" runat="server"></asp:TextBox>
                        </td>
                         <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" ID="regularSumCpf" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr class="even">
                        <td>Lump Sum</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_extra_small_text_boxs" ID="lumpSumCash" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers()" CssClass="chassis_application_small_text_box" ID="lumpSumCpf" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    </tbody>
                    </table>
               </td>
            </tr>
          </table>  
 
    </div>
      </div>
    </div>
</div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Asset and Liabilities
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Asset and Liabilities
</asp:Content>
