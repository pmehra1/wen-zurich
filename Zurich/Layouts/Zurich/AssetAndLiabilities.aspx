<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetAndLiabilities.aspx.cs" Inherits="Zurich.Layouts.Zurich.AssetAndLiabilities" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

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
<script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>

<script language="javascript" type="text/javascript">

    var countOtherInvestedAssetsplus = 0;
    var countPersonalUseOthersplus = 0;
    var countOtherLiabilitiesplus = 0;


    $(document).ready(function () {

        $('#<%=assetLiabilitiesEnable.ClientID %>').change(function () {
            enableDisableAssetLiabilitiesFields()
        });


        $('#<%=premiumRecomended.ClientID %>').change(function () {
            premiumRecomendedFields();
        });



        enableDisableAssetLiabilitiesFields();
        premiumRecomendedFields();
        countOtherInvestedAssetsplus = $("#othersInvestedAssets >tbody > tr").size();
        $('#plus').click(function () {
            countOtherInvestedAssetsplus += 1;
            var count = 0;
            count = countOtherInvestedAssetsplus;
            var str = 'othersInvestedAssetsrowId' + count;
            var row1 = $("<tr id='othersInvestedAssetsrowId" + count + "' width=100%><td align='left'><input type='text' style='width: 82px'  id='priothers-" + count + "' name='priothers-" + count + "'/></td><td width='30px'></td><td><input type='text' value=0 id='priotherscash-" + count + "' name='priotherscash-" + count + "' style='width: 82px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculateAssets()'/></td><td width='30px'></td><td align='left'><input type='text' value=0 id='priotherscpf-" + count + "' name='priotherscpf-" + count + "' style='width: 82px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculateAssets()'/>&nbsp;&nbsp;<a onClick=DeleteRowOtherInvestedAssetsplus('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
            $("#othersInvestedAssets").append(row1);
            $("#othersInvestedAssets >tbody > tr:last").focusin();
            document.getElementById('<%=otherInvestedAssetsNumber.ClientID %>').value = count;
        });

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

        });


        countPersonalUseOthersplus = $("#otherPersonalAssets >tbody > tr").size();

        $('#otherPersonalUseOthersPlus').click(function () {
            countPersonalUseOthersplus += 1;
            var count = 0;
            count = countPersonalUseOthersplus;
            var str = 'otherPersonalAssets' + count;
            var row1 = $("<tr id='otherPersonalAssets" + count + "' width=100%><td align='left'><input type='text' style='width: 82px;'  id='priotherspu-" + count + "' name='priotherspu-" + count + "' onblur='calculateAssets()'/></td><td width='30px'></td><td><input type='text' value=0 id='priotherspucash-" + count + "' name='priotherspucash-" + count + "' style='width: 82px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculateAssets()'/></td><td width='30px'></td><td align='left'><input type='text' value=0 id='priotherspucpf-" + count + "' name='priotherspucpf-" + count + "' style='width: 82px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculateAssets()'/>&nbsp;&nbsp;<a onClick=DeleteRowOtherPersonalUseplus('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
            $("#otherPersonalAssets").append(row1);
            $("#otherPersonalAssets >tbody > tr:last").focusin();
            document.getElementById('<%=otherPersonalUsedAssetsNumber.ClientID %>').value = count;
        });

        countOtherLiabilitiesplus = $("#otherLiabilities >tbody > tr").size();

        $('#otherLiabilitiesPlus').click(function () {
            countOtherLiabilitiesplus += 1;
            var count = 0;
            count = countOtherLiabilitiesplus;
            var str = 'otherLiabilities' + count;
            var row1 = $("<tr id='otherLiabilities" + count + "' width=100%><td><input type='text' id='priotherslb-" + count + "' name='priotherslb-" + count + "' style='width: 82px;' /></td><td align='center'><input type='text' value=0 id='priotherslbamount-" + count + "' name='priotherslbamount-" + count + "' style='width: 82px;' onkeypress = 'javascript:allowOnlyNumbers(this.value)' onblur='calculateAssets()'/>&nbsp;&nbsp;<a onClick=DeleteRowLiabilitiesNumberplus('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td></tr>");
            $("#otherLiabilities").append(row1);
            $("#otherLiabilities >tbody > tr:last").focusin();
            document.getElementById('<%=otherLiabilitiesNumber.ClientID %>').value = count;
        });
        calculateAssets();
    });


    function DeleteRowOtherInvestedAssetsplus(param) {
        var answer = confirm("Delete Invested Assets Details ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
        }
        document.getElementById('<%=otherInvestedAssetsNumber.ClientID %>').value = countOtherInvestedAssetsplus;
        calculateAssets();
    }


    function DeleteRowOtherPersonalUseplus(param) {
        var answer = confirm("Delete Personal User Assets Details ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
        }
        document.getElementById('<%=otherPersonalUsedAssetsNumber.ClientID %>').value = countPersonalUseOthersplus;
        calculateAssets();
    }

    function DeleteRowLiabilitiesNumberplus(param) {
        var answer = confirm("Delete Liabilites Details ?")
        if (answer) {
            $('#' + param).slideUp('slow');
            $('#' + param).hide();
            $('#' + param).remove();
        }
        document.getElementById('<%=otherLiabilitiesNumber.ClientID %>').value = countOtherLiabilitiesplus;
        calculateAssets();
    }


    function sumOthersInvestedAssetsCash() {

        var sumCash = 0;

        var count = countOtherInvestedAssetsplus;
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherscash-' + i) != null && document.getElementById('priotherscash-' + i).value != '' && !isNaN(document.getElementById('priotherscash-' + i).value)) {
                    document.getElementById('priotherscash-' + i).value = removeTrailingZeroes(document.getElementById('priotherscash-' + i).value);
                    sumCash += parseFloat(document.getElementById('priotherscash-' + i).value);
                }
            }
        }
        return sumCash;
    }


    function sumOthersInvestedAssetsCpf() {

        var sumCpf = 0;
        var count = countOtherInvestedAssetsplus;
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherscpf-' + i) != null && document.getElementById('priotherscpf-' + i).value != '' && !isNaN(document.getElementById('priotherscpf-' + i).value)) {
                    document.getElementById('priotherscpf-' + i).value = removeTrailingZeroes(document.getElementById('priotherscpf-' + i).value);
                    sumCpf += parseFloat(document.getElementById('priotherscpf-' + i).value);
                }
            }
        }
        return sumCpf;
    }


    function sumOthersPersonalAssetsCash() {

        var sumCash = 0;

        var count = countPersonalUseOthersplus;
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherspucash-' + i) != null && document.getElementById('priotherspucash-' + i).value != '' && !isNaN(document.getElementById('priotherspucash-' + i).value)) {
                    document.getElementById('priotherspucash-' + i).value = removeTrailingZeroes(document.getElementById('priotherspucash-' + i).value);
                    sumCash += parseFloat(document.getElementById('priotherspucash-' + i).value);
                }
            }
        }
        return sumCash;
    }


    function sumOthersPersonalAssetsCpf() {
        var sumCpf = 0;
        var count = countPersonalUseOthersplus;
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherspucpf-' + i) != null && document.getElementById('priotherspucpf-' + i).value != '' && !isNaN(document.getElementById('priotherspucpf-' + i).value)) {
                    document.getElementById('priotherspucpf-' + i).value = removeTrailingZeroes(document.getElementById('priotherspucpf-' + i).value);
                    sumCpf += parseFloat(document.getElementById('priotherspucpf-' + i).value);
                }
            }
        }
        return sumCpf;
    }


    function sumOthersLiabilities() {
        var sumLiabilities = 0;

        var count = countOtherLiabilitiesplus;
        if (count > 0) {
            for (i = 0; i <= count; i++) {
                if (document.getElementById('priotherslbamount-' + i) != null && document.getElementById('priotherslbamount-' + i).value != '' && !isNaN(document.getElementById('priotherslbamount-' + i).value)) {
                    document.getElementById('priotherslbamount-' + i).value = removeTrailingZeroes(document.getElementById('priotherslbamount-' + i).value);
                    sumLiabilities += parseFloat(document.getElementById('priotherslbamount-' + i).value);
                }
            }
        }
        return sumLiabilities;
    }

    function removeZeroesIncomeExpense() {
        if (!isNaN(document.getElementById('<%= bankAcctCash.ClientID %>').value) && document.getElementById('<%= bankAcctCash.ClientID %>').value != "") {
            document.getElementById('<%= bankAcctCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= bankAcctCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= cpfoaBal.ClientID %>').value) && document.getElementById('<%= cpfoaBal.ClientID %>').value != "") {
            document.getElementById('<%= cpfoaBal.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= cpfoaBal.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= cpfsaBal.ClientID %>').value) && document.getElementById('<%= cpfsaBal.ClientID %>').value != "") {
            document.getElementById('<%= cpfsaBal.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= cpfsaBal.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= cpfMediSaveBalance.ClientID %>').value) && document.getElementById('<%= cpfMediSaveBalance.ClientID %>').value != "") {
            document.getElementById('<%= cpfMediSaveBalance.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= cpfMediSaveBalance.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= srsBal.ClientID %>').value) && document.getElementById('<%= srsBal.ClientID %>').value != "") {
            document.getElementById('<%= srsBal.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= srsBal.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= stocksSharesCash.ClientID %>').value) && document.getElementById('<%= stocksSharesCash.ClientID %>').value != "") {
            document.getElementById('<%= stocksSharesCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= stocksSharesCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= stocksSharesCpf.ClientID %>').value) && document.getElementById('<%= stocksSharesCpf.ClientID %>').value != "") {
            document.getElementById('<%= stocksSharesCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= stocksSharesCpf.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= unitTrustsCash.ClientID %>').value) && document.getElementById('<%= unitTrustsCash.ClientID %>').value != "") {
            document.getElementById('<%= unitTrustsCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= unitTrustsCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= unitTrustsCpf.ClientID %>').value) && document.getElementById('<%= unitTrustsCpf.ClientID %>').value != "") {
            document.getElementById('<%= unitTrustsCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= unitTrustsCpf.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= ilpCash.ClientID %>').value) && document.getElementById('<%= ilpCash.ClientID %>').value != "") {
            document.getElementById('<%= ilpCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= ilpCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= ilpCpf.ClientID %>').value) && document.getElementById('<%= ilpCpf.ClientID %>').value != "") {
            document.getElementById('<%= ilpCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= ilpCpf.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= srsInvCash.ClientID %>').value) && document.getElementById('<%= srsInvCash.ClientID %>').value != "") {
            document.getElementById('<%= srsInvCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= srsInvCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= invPropCash.ClientID %>').value) && document.getElementById('<%= invPropCash.ClientID %>').value != "") {
            document.getElementById('<%= invPropCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= invPropCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= invPropCpf.ClientID %>').value) && document.getElementById('<%= invPropCpf.ClientID %>').value != "") {
            document.getElementById('<%= invPropCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= invPropCpf.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= resPropCash.ClientID %>').value) && document.getElementById('<%= resPropCash.ClientID %>').value != "") {
            document.getElementById('<%= resPropCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= resPropCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= resPropCpf.ClientID %>').value) && document.getElementById('<%= resPropCpf.ClientID %>').value != "") {
            document.getElementById('<%= resPropCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= resPropCpf.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= homeMortgage.ClientID %>').value) && document.getElementById('<%= homeMortgage.ClientID %>').value != "") {
            document.getElementById('<%= homeMortgage.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= homeMortgage.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= vehicleLoan.ClientID %>').value) && document.getElementById('<%= vehicleLoan.ClientID %>').value != "") {
            document.getElementById('<%= vehicleLoan.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= vehicleLoan.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= cashLoan.ClientID %>').value) && document.getElementById('<%= cashLoan.ClientID %>').value != "") {
            document.getElementById('<%= cashLoan.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= cashLoan.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= creditCard.ClientID %>').value) && document.getElementById('<%= creditCard.ClientID %>').value != "") {
            document.getElementById('<%= creditCard.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= creditCard.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= regularSumCash.ClientID %>').value) && document.getElementById('<%= regularSumCash.ClientID %>').value != "") {
            document.getElementById('<%= regularSumCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= regularSumCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= regularSumCpf.ClientID %>').value) && document.getElementById('<%= regularSumCpf.ClientID %>').value != "") {
            document.getElementById('<%= regularSumCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= regularSumCpf.ClientID %>').value);
        }



        if (!isNaN(document.getElementById('<%= lumpSumCash.ClientID %>').value) && document.getElementById('<%= lumpSumCash.ClientID %>').value != "") {
            document.getElementById('<%= lumpSumCash.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= lumpSumCash.ClientID %>').value);
        }

        if (!isNaN(document.getElementById('<%= lumpSumCpf.ClientID %>').value) && document.getElementById('<%= lumpSumCpf.ClientID %>').value != "") {
            document.getElementById('<%= lumpSumCpf.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= lumpSumCpf.ClientID %>').value);
        }


    }




    function calculateAssets() {

        removeZeroesIncomeExpense();

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
            sumCashAssets += parseFloat(document.getElementById('<%=srsBal.ClientID %>').value);
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
            sumCashAssets += parseFloat(document.getElementById('<%=resPropCash.ClientID %>').value);
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

    function enableDisableAssetLiabilitiesFields() {

        var selection = $('#<%=assetLiabilitiesEnable.ClientID %> input:checked').val();

        if (selection == "0") {
            $("#mainForm :input").attr("disabled", false);
            $("#fundsForPlanningPart1 :input").attr("disabled", false);
            $("#fundsForPlanningPart2 :input").attr("disabled", false);

            $('#<%=assetLiabilitiesNotNeededReason.ClientID %>').val("");
            $('#<%=assetLiabilitiesNotNeededReason.ClientID %>').hide();
            $('#othersPersonalAssetsFieldSet').show();
            $('#otherLiabilitiesfieldSet').show();
            $('#othersAllAssetsFieldSet').show();
        }
        else if (selection == "1" || selection == "0") {
            $("#mainForm :input").attr("disabled", true);
            $("#fundsForPlanningPart1 :input").attr("disabled", false);
            $("#fundsForPlanningPart2 :input").attr("disabled", false);

            $('#<%=assetLiabilitiesNotNeededReason.ClientID %>').show();
            $('#othersPersonalAssetsFieldSet').hide();
            $('#otherLiabilitiesfieldSet').hide();
            $('#othersAllAssetsFieldSet').hide();
        }

    }

    function premiumRecomendedFields() {

        var selection = $('#<%=premiumRecomended.ClientID %> input:checked').val();

        if (selection == "0") {
            $('#percentAssetIncomeId').show();
        }
        else {
            $('#<%=assetIncomePercent.ClientID %>').val("");
            $('#percentAssetIncomeId').hide();
        }

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
<asp:HiddenField ID="activityId" runat="server"  />
<asp:HiddenField ID="otherInvestedAssetsNumber" runat="server"  />
<asp:HiddenField ID="otherPersonalUsedAssetsNumber" runat="server"  />
<asp:HiddenField ID="otherLiabilitiesNumber" runat="server"  />
<asp:HiddenField ID="caseId" runat="server"  />
<asp:HiddenField ID="backToCase" runat="server"  />

<div id="chassis_outer_container">
<div class="chassis_page_container">
<FNAMenutag:FNAMenu runat="server" id="menu1" />
<div class="chassis_application_navigation_container">
    <ul>
    <li>
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
    <li class="chassis_application_navigation_selected_tab2">
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
                        <asp:Label ID="lblPdSummarySaveSuccess" runat="server" class="chassis_application_save_success"
                            Text="• Asset and Liabilities details saved successfully"></asp:Label>
                        <asp:Label ID="lblPdSummarySaveFailed" runat="server" class="chassis_application_feedback_error"
                            Text="• Failed to save Asset and Liabilities details"></asp:Label>
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

             <table>
                <tr>
                    <td colspan="4">This information helps to ascertain the planning of your financial needs(s).
                Would you like your assets and liabilities to be taken into consideration for the Needs Analysis and Recommendations(s) ?
                 </tr>
                <tr>
                    <td colspan="4">
                    <asp:radiobuttonlist id="assetLiabilitiesEnable" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                        <asp:listitem value="0" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                
                    </td>
                </tr>
                <tr>
                    <td colspan="4" >
                    &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="chassis_data_column chassis_no_padding_right">
                        <asp:TextBox TextMode="MultiLine" Width="300px" Height="40px" ID="assetLiabilitiesNotNeededReason" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" >
                    &nbsp;
                    </td>
                </tr>
            </table>

        <table class="chassis_four_column_list" summary="Adviser details">
            <thead>
                <tr>
                    <td colspan="2">Assets and Liabilities</td>
                </tr>
            </thead>

          </table>  
          <table class="chassis_four_column_list" summary="Adviser details" id="mainForm">
            
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
                            <td ><asp:TextBox  ID="bankAcctCash" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox></td>
                            <td ></td>
                    </tr>
                    <tr class="odd">
                        <td >CPF-OA Balance</td>
                        <td ></td>
                        <td >
                            <asp:TextBox ID="cpfoaBal" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td >CPF-SA Balance</td>
                        <td ></td>
                        <td >
                             <asp:TextBox ID="cpfsaBal" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>CPF Medisave Balance</td>
                        <td></td>
                        <td>
                            <asp:TextBox ID="cpfMediSaveBalance" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td>SRS Balance</td>
                        <td>
                            <asp:TextBox ID="srsBal" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            
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
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)"  onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" ID="stocksSharesCash"  runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="stocksSharesCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Unit Trusts</td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="unitTrustsCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="unitTrustsCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>



                    <tr class="even">
                        <td >Investment-Linked Policies</td>
                        <td >
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="ilpCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="ilpCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>SRS</td>
                        <td>
                         <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="srsInvCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr class="even">
                        <td>Investment Properties</td>
                        <td>
                        <asp:TextBox  OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="invPropCash" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="invPropCpf" onblur='calculateAssets()' CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td colspan=3>
                            <fieldset id="othersAllAssetsFieldSet">
                        <legend>OTHERS:&nbsp;<a href="#" id="plus"><img style='width:15px;height:15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a></legend>
                             <table class="chassis_application_list_navigation" width=100%>
                                    <thead>
                                      <tr>
                                        <th class="header">ASSETS</th>
                                        <th class="header">CASH(SGD)</th>
                                        <th class="header">CPF(SGD)</th>
                                      </tr>
                                    </thead>
                             </table>
                             
                             <table id="othersInvestedAssets" width=100%>
                            <asp:Repeater ID="assetList" runat="server">
                                <ItemTemplate>
                                    <tr id='othersInvestedAssetsrowId<%# Container.ItemIndex%>'>
                                        <td align='left'>
                                            <input type='text' value='<%# Eval("assetDesc") %>' style='width: 82px;'  id="priothers-<%# Container.ItemIndex%>" name="priothers-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td width="30px"></td>
                                         <td>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers(this.value)" value='<%# Eval("cash") %>' id="priotherscash-<%# Container.ItemIndex%>"  name="priotherscash-<%# Container.ItemIndex%>" style='width: 82px;' onblur='calculateAssets()'/>
                                         </td>
                                         <td width="30px"></td>
                                         <td align='left'>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers(this.value)"  value='<%# Eval("cpf") %>' id="priotherscpf-<%# Container.ItemIndex%>" name="priotherscpf-<%# Container.ItemIndex%>" onblur='calculateAssets()' style="width: 82px;"/>&nbsp;&nbsp;<a onClick=DeleteRowOtherInvestedAssetsplus('othersInvestedAssetsrowId<%# Container.ItemIndex%>')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
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
                            <b>Personal Use Assets</b>
                        </td>
                    </tr>

                    <tr class="even">
                        <td>Residential Property</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="resPropCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="resPropCpf" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan=3>
                            <fieldset id="othersPersonalAssetsFieldSet">
                        <legend>OTHERS:&nbsp;<a href="#" id="otherPersonalUseOthersPlus"><img style='width:15px;height:15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a></legend>
                             
                             <table class="chassis_application_list_navigation" width=100%>
                                    <thead>
                                      <tr>
                                        <th class="header">ASSETS</th>
                                        <th class="header">CASH(SGD)</th>
                                        <th class="header">CPF(SGD)</th>
                                      </tr>
                                    </thead>
                             </table>
                             
                             <table id="otherPersonalAssets" width=100%>
                            <asp:Repeater ID="otherPersonalAssetsRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='otherPersonalAssets<%# Container.ItemIndex%>'>
                                        <td align='left'>
                                            <input type='text' onblur='calculateAssets()' value='<%# Eval("assetDesc") %>' style='width: 82px;'  id="priotherspu-<%# Container.ItemIndex%>" name="priotherspu-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td width="30px"></td>
                                         <td align='left'>
                                            <input onkeypress = "javascript:allowOnlyNumbers(this.value)" type='text' onblur='calculateAssets()'  value='<%# Eval("cash") %>' id="priotherspucash-<%# Container.ItemIndex%>" name="priotherspucash-<%# Container.ItemIndex%>" style="width: 82px;"/>
                                         </td>
                                         <td width="30px"></td>
                                         <td>
                                            <input onkeypress = "javascript:allowOnlyNumbers(this.value)" type='text' onblur='calculateAssets()' value='<%# Eval("cpf") %>' style='width: 82px;'  id="priotherspucpf-<%# Container.ItemIndex%>" name="priotherspucpf-<%# Container.ItemIndex%>"/>&nbsp;&nbsp;<a onClick=DeleteRowOtherPersonalUseplus('otherPersonalAssets<%# Container.ItemIndex%>')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
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
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="personalUseAssetsTotalCash" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="personalUseAssetsTotalCPF" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
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
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="homeMortgage" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Vehicle Loan</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="vehicleLoan" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="even">
                        <td>Overdraft</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="cashLoan" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td>Credit Card</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" onblur='calculateAssets()' ID="creditCard" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                        <td colspan=2>
                        
                        <fieldset id="otherLiabilitiesfieldSet"> 
                        <legend>OTHERS:&nbsp;<a href="#" id="otherLiabilitiesPlus"><img style='width:15px;height:15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a></legend>
                             <table id="otherLiabilities" width=100%>
                            <asp:Repeater ID="liabilitiesOtherRepeater" runat="server">
                                <ItemTemplate>
                                    <tr id='otherLiabilities<%# Container.ItemIndex-1%>'>
                                        <td align='left'>
                                            <input type='text' onblur='calculateAssets()' value='<%# Eval("liabilityDesc") %>' style='width: 82px;'  id="priotherslb-<%# Container.ItemIndex%>" name="priotherslb-<%# Container.ItemIndex%>"/>
                                         </td>
                                         <td>
                                            <input type='text' onkeypress = "javascript:allowOnlyNumbers(this.value)" onblur='calculateAssets()'  value='<%# Eval("cash") %>' id="priotherslbamount-<%# Container.ItemIndex%>" name="priotherslbamount-<%# Container.ItemIndex%>" style="width: 82px;"/>&nbsp;&nbsp;<a onClick=DeleteRowLiabilitiesNumberplus('otherLiabilities<%# Container.ItemIndex-1%>')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
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
                            <asp:TextBox ID="totalLiabilitiesOthers" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_extra_small_text_boxs" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    </tbody>
                    </table>
                
                  <table class="chassis_two_column_list" summary="Adviser details">
                    <thead>
                        <tr>
                            <td colspan="2"><b>NET WORTH (ASSETS - LIABILITIES)</b>
                            <asp:TextBox CssClass="chassis_application_extra_small_text_boxs" BackColor="#E0E0E0" ID="netWorth" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </thead>
                    </table>

                    <table class="chassis_two_column_list" summary="Disclaimer for Availaible funds for planning">
                        <tr>
                            <td colspan="2">This information is important for planning your financial needs(s). Please indicate below your available funds
                            for planning.
                            </td>
                        </tr>
                    </table>

                    <table summary="test" class="chassis_application_list_navigation" border="0"
                    cellpadding="0" cellspacing="1" id="fundsForPlanningPart1">

                    <thead>
                      <tr>
                        <th class="header">AVAILABLE FUNDS FOR PLANNING</th>
                        <th class="header">CASH(S$)</th>
                        <th class="header">CPF(S$)</th>
                      </tr>
                    </thead>
                    <tbody>
                    <tr class="odd">
                        <td>Regular Sum per Year</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="regularSumCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                         <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="regularSumCpf" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr class="even">
                        <td>Lump Sum</td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="lumpSumCash" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_small_text_box" ID="lumpSumCpf" onblur='calculateAssets()' runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    </tbody>
                    </table>

                    <table class="chassis_two_column_list" summary="Adviser details" id="fundsForPlanningPart2">
                        <tr>
                            <td colspan="2">Does the investment contribution recommended form a substantial portion of your assets / surplus?
                            <asp:radiobuttonlist id="premiumRecomended" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                                <asp:listitem value="0" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                                <asp:listitem value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                            </asp:radiobuttonlist>
                           <div id="percentAssetIncomeId">
                            Asset / Annual Income <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" CssClass="chassis_application_extra_small_text_boxs" ID="assetIncomePercent"  runat="server"></asp:TextBox>
                           </div>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">(Note : Budget is considered substantial if it is more than 50% of assets or surplus.)</td>
                        </tr>
                        <tr>
                            <td colspan="2">If your answer is "Yes". you may encounter a potential risk in the future of not being able to continue paying your premiums</td>
                        </tr>
                    </table>
               </td>
            </tr>
          </table>  

           <table width="100%">
            <tr align="right">
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Generate Pdf" OnClick="createAssetliabilityPdf" class="chassis_application_button_xxxlarge" />
                    <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="saveAssetLiabilitiesDetailsBack" />
                    <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server" Text="Save" OnClick="saveAssetLiabilitiesDetails" />
                    <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="saveAssetLiabilitiesDetailsNext" />
                    <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClientClick="onBackToCase()" OnClick="redirectToCasePortal" />
                </td>
            </tr>
        </table> 
    </div>
      </div>
    </div>
</div>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Asset and liabilities
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Asset and liabilities
</asp:Content>