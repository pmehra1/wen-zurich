<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMyNeedProtectionGoals.aspx.cs" Inherits="Zurich.Layouts.Zurich.ProtectionGoals.ShowMyNeedProtectionGoals" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" Src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.min.js"></script>
    <script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jqplot/jquery.jqplot.min.js"></script>
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
    <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
    <script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>
    <script type='text/javascript'>

        _spSuppressFormOnSubmitWrapper = true;

    </script>
    
    <%
        int myCriticalNeedsSize = 0;
        if (ViewState["noofcriticalassets"] != null)
        {
            myCriticalNeedsSize = Int32.Parse(ViewState["noofcriticalassets"].ToString());
        }

        int myDisabilityNeedsSize = 0;
        if (ViewState["noofdisablityassets"] != null)
        {
            myDisabilityNeedsSize = Int32.Parse(ViewState["noofdisablityassets"].ToString());
        }

        string anyExPl = "0";
        if (ViewState["anyExPl"] != null && ViewState["anyExPl"].ToString() != "")
        {
            anyExPl = ViewState["anyExPl"].ToString();
        }

        string oldageExPl = "0";
        if (ViewState["oldageExPl"] != null && ViewState["oldageExPl"].ToString() != "")
        {
            oldageExPl = ViewState["oldageExPl"].ToString();
        }

        string personalExPl = "0";
        if (ViewState["personalExPl"] != null && ViewState["personalExPl"].ToString() != "")
        {
            personalExPl = ViewState["personalExPl"].ToString();
        }
        
    %>

    <script language="javascript" type="text/javascript">
       
        function popitup(url, width, height) {
        newwindow = window.open(url, 'name', 'height=' + height + ',width=' + width + ', scrollbars=yes');
        if (window.focus) { newwindow.focus() }
        return false;
        }


        var countFamilyNeeds = 0;
        countFamilyNeeds = <%=myCriticalNeedsSize%>;

        var countmyNeedplus = 0;
        var countmyNeedplusPart2 = <%=myDisabilityNeedsSize%>;

        var ddlExistingPlanList = "<%=anyExPl%>";
        var ddlEpOldageYesNo = "<%=oldageExPl%>";
        var ddlEpPersonalYesNo = "<%=personalExPl%>";

        $(document).ready(function () {
                
             document.getElementById('<%=noofcriticalassets.ClientID %>').value = countFamilyNeeds;
             document.getElementById('<%=noofdisabilityassets.ClientID %>').value = countmyNeedplusPart2;

            $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });
            
             if ((ddlExistingPlanList == "1")||(ddlEpOldageYesNo == "1")||(ddlEpPersonalYesNo == "1"))
                {
                    $('#detail_existing_plans').show();
                }
                else
                {
                    $('#detail_existing_plans').hide();
                 }   


             $('#<%=ddlExistingPlanList.ClientID %>').change(function(){
                    var ddlExistingPlanList1 = $("#<%=ddlExistingPlanList.ClientID %> option:selected").val();
                    var ddlEpOldageYesNo1 = $("#<%=ddlEpOldageYesNo.ClientID %> option:selected").val();
                    var ddlEpPersonalYesNo1 = $("#<%=ddlEpPersonalYesNo.ClientID %> option:selected").val();


                     if ((ddlExistingPlanList1 == "1")||(ddlEpOldageYesNo1 == "1")||(ddlEpPersonalYesNo1 == "1"))
                        {
                            $('#detail_existing_plans').show();
                        }
                        else
                        {
                            $('#detail_existing_plans').hide();
                         }
                 });


                  $('#<%=ddlEpOldageYesNo.ClientID %>').change(function(){
                    var ddlExistingPlanList2 = $("#<%=ddlExistingPlanList.ClientID %> option:selected").val();
                    var ddlEpOldageYesNo2 = $("#<%=ddlEpOldageYesNo.ClientID %> option:selected").val();
                    var ddlEpPersonalYesNo2 = $("#<%=ddlEpPersonalYesNo.ClientID %> option:selected").val();


                     if ((ddlExistingPlanList2 == "1")||(ddlEpOldageYesNo2 == "1")||(ddlEpPersonalYesNo2 == "1"))
                        {
                            $('#detail_existing_plans').show();
                        }
                        else
                        {
                            $('#detail_existing_plans').hide();
                         }
                 });


                 $('#<%=ddlEpPersonalYesNo.ClientID %>').change(function(){
                    var ddlExistingPlanList3 = $("#<%=ddlExistingPlanList.ClientID %> option:selected").val();
                    var ddlEpOldageYesNo3 = $("#<%=ddlEpOldageYesNo.ClientID %> option:selected").val();
                    var ddlEpPersonalYesNo3 = $("#<%=ddlEpPersonalYesNo.ClientID %> option:selected").val();


                     if ((ddlExistingPlanList3 == "1")||(ddlEpOldageYesNo3 == "1")||(ddlEpPersonalYesNo3 == "1"))
                        {
                            $('#detail_existing_plans').show();
                        }
                        else
                        {
                            $('#detail_existing_plans').hide();
                         }
                 });



            $('#myNeedsCriticalplus').click(function () {
                countFamilyNeeds +=1;
                var str = 'existingAssetMyNeedrowId' + countFamilyNeeds;
                var row1 = $("<tr id='existingAssetMyNeedrowId" + countFamilyNeeds + "' width=100%><td align='center' style='width:45%'><input type='text' style='width: 100px;'  id='primyneedscritical-" + countFamilyNeeds + "' name='primyneedscritical-" + countFamilyNeeds + "'/></td><td align='center' style='width:50%'><input type='text' onkeypress = 'javascript:allowOnlyNumbers(this.value)' value=0 id='primyneedplus_" + (countFamilyNeeds) + "' name='primyneedplus_" + (countFamilyNeeds) + "' style='width: 100px;' onblur='calculate()'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td><td align='center' style='width:5%'>&nbsp;&nbsp;</td></tr>");
                $("#existingAssetsMyNeedsCriticalTable").append(row1);
                $("#existingAssetsMyNeedsCriticalTable >tbody > tr:last").focusin();
                document.getElementById('<%=noofcriticalassets.ClientID %>').value = countFamilyNeeds;
                document.getElementById('<%=noofdisabilityassets.ClientID %>').value = countmyNeedplusPart2;
                
            });

            $('#myNeedsDisabilityplus').click(function () {
                countmyNeedplusPart2+=1
                var str = 'existingAssetMyNeed2rowId' + countmyNeedplusPart2;
                var row1 = $("<tr id='existingAssetMyNeed2rowId" + countmyNeedplusPart2 + "' width=100%><td align='center' style='width:45%'><input type='text' style='width: 100px;'  id='primyneedsdisb-" + countmyNeedplusPart2 + "' name='primyneedsdisb-" + countmyNeedplusPart2 + "'/></td><td align='center' style='width:50%'><input type='text' value=0 onkeypress = 'javascript:allowOnlyNumbers(this.value)' id='primyneedpluspart2_" + (countmyNeedplusPart2) + "' name='primyneedpluspart2_" + (countmyNeedplusPart2) + "' style='width: 100px;' onblur='calculate()'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td><td align='center' style='width:5%'>&nbsp;&nbsp;</td></tr>");
                $("#existingAssetsMyNeedsDisabilityTable").append(row1);
                $("#existingAssetsMyNeedsDisabilityTable >tbody > tr:last").focusin();
                document.getElementById('<%=noofdisabilityassets.ClientID %>').value = countmyNeedplusPart2;
                document.getElementById('<%=noofcriticalassets.ClientID %>').value = countFamilyNeeds;
            });

            $(function () {
                $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
                $('#protectionGoal').addClass("chassis_application_navigation_selected_tab1");

                var fnclass = $('#<%=familyneedstab.ClientID %>').attr("class");
                var mynclass = $('#<%=myneedstab.ClientID %>').attr("class");

                if((fnclass == 'chassis_application_page_complete') && (mynclass == 'chassis_application_page_complete')){
                    $("#protectionGoaltab").addClass("chassis_application_page_complete");    
                }else{
                    if((fnclass == 'chassis_application_page_warnings') || (mynclass == 'chassis_application_page_warnings')){
                        $("#protectionGoaltab").addClass("chassis_application_page_warnings");
                    }
                }

            });
            calculate();

            $('#<%=criticalIllnessPr.ClientID %>').change(function () {
                enableDisableCriticalIllnessFields()
            });

            $('#<%=disabilityPr.ClientID %>').change(function () {
                enableDisableDisabilityPrFields()
            });

            $('#<%=hospitalmedCoverNeeded.ClientID %>').change(function () {
                enableDisableHospitalCoverFields()
            });

            $('#<%=accidentalHealthCoverNeeded.ClientID %>').change(function () {
                enableDisableAccidentalCoverFields()
            });

            enableDisableCriticalIllnessFields();
            enableDisableDisabilityPrFields();
            enableDisableHospitalCoverFields();
            enableDisableAccidentalCoverFields();
        });

        

        function roundOffValuesMyneeds() {
            if (!isNaN(document.getElementById('<%=txtlumpSumRequiredForTreatment.ClientID %>').value) && document.getElementById('<%=txtlumpSumRequiredForTreatment.ClientID %>').value != "") {
                document.getElementById('<%=txtlumpSumRequiredForTreatment.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtlumpSumRequiredForTreatment.ClientID %>').value));
            }
            if (!isNaN(document.getElementById('<%=txtCriticalIllnessInsurance.ClientID %>').value) && document.getElementById('<%=txtCriticalIllnessInsurance.ClientID %>').value != "") {
                document.getElementById('<%=txtCriticalIllnessInsurance.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtCriticalIllnessInsurance.ClientID %>').value));
            }
            if (!isNaN(document.getElementById('<%=txtExistingAssetsMyNeedsCritical.ClientID %>').value) && document.getElementById('<%=txtExistingAssetsMyNeedsCritical.ClientID %>').value != "") {
                document.getElementById('<%=txtExistingAssetsMyNeedsCritical.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtExistingAssetsMyNeedsCritical.ClientID %>').value));
            }
            if (!isNaN(document.getElementById('<%=txtTotalShortfallSurplusMyNeeds.ClientID %>').value) && document.getElementById('<%=txtTotalShortfallSurplusMyNeeds.ClientID %>').value != "") {
                document.getElementById('<%=txtTotalShortfallSurplusMyNeeds.ClientID %>').value =Math.abs(Math.round(parseFloat(document.getElementById('<%=txtTotalShortfallSurplusMyNeeds.ClientID %>').value)));
                document.getElementById('<%=hiddentxtTotalShortfallSurplusMyNeeds.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtTotalShortfallSurplusMyNeeds.ClientID %>').value));
            }
            if (!isNaN(document.getElementById('<%=txtExistingAssetsMyneedsDisability.ClientID %>').value) && document.getElementById('<%=txtExistingAssetsMyneedsDisability.ClientID %>').value != "") {
                document.getElementById('<%=txtExistingAssetsMyneedsDisability.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtExistingAssetsMyneedsDisability.ClientID %>').value));
            }
            if (!isNaN(document.getElementById('<%=txtShortfallSurplusMyNeeds.ClientID %>').value) && document.getElementById('<%=txtShortfallSurplusMyNeeds.ClientID %>').value != "") {
                document.getElementById('<%=txtShortfallSurplusMyNeeds.ClientID %>').value = Math.abs(Math.round(parseFloat(document.getElementById('<%=txtShortfallSurplusMyNeeds.ClientID %>').value)));
                document.getElementById('<%=hiddentxtShortfallSurplusMyNeeds.ClientID %>').value = Math.round(parseFloat(document.getElementById('<%=txtShortfallSurplusMyNeeds.ClientID %>').value));
            }
        }


        function removeZeroesMyProtectionGoals() {
            if (!isNaN(document.getElementById('<%= replacementIncomeRequired.ClientID %>').value) && document.getElementById('<%= replacementIncomeRequired.ClientID %>').value != "") {
                document.getElementById('<%= replacementIncomeRequired.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= replacementIncomeRequired.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= yearsOfSupportRequired.ClientID %>').value) && document.getElementById('<%= yearsOfSupportRequired.ClientID %>').value != "") {
                document.getElementById('<%= yearsOfSupportRequired.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= yearsOfSupportRequired.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= txtlumpSumRequiredForTreatment.ClientID %>').value) && document.getElementById('<%= txtlumpSumRequiredForTreatment.ClientID %>').value != "") {
                document.getElementById('<%= txtlumpSumRequiredForTreatment.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= txtlumpSumRequiredForTreatment.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= txtCriticalIllnessInsurance.ClientID %>').value) && document.getElementById('<%= txtCriticalIllnessInsurance.ClientID %>').value != "") {
                document.getElementById('<%= txtCriticalIllnessInsurance.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= txtCriticalIllnessInsurance.ClientID %>').value);
            }



            if (!isNaN(document.getElementById('<%= disabilityProtectionReplacementIncomeRequired.ClientID %>').value) && document.getElementById('<%= disabilityProtectionReplacementIncomeRequired.ClientID %>').value != "") {
                document.getElementById('<%= disabilityProtectionReplacementIncomeRequired.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= disabilityProtectionReplacementIncomeRequired.ClientID %>').value);
            }

            if (!isNaN(document.getElementById('<%= disabilityYearsOfSupport.ClientID %>').value) && document.getElementById('<%= disabilityYearsOfSupport.ClientID %>').value != "") {
                document.getElementById('<%= disabilityYearsOfSupport.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= disabilityYearsOfSupport.ClientID %>').value);
            }


            if (!isNaN(document.getElementById('<%= disabilityInsurance.ClientID %>').value) && document.getElementById('<%= disabilityInsurance.ClientID %>').value != "") {
                document.getElementById('<%= disabilityInsurance.ClientID %>').value = removeTrailingZeroes(document.getElementById('<%= disabilityInsurance.ClientID %>').value);
            }
        }


        function DeleteRow(param) {
            var answer = confirm("Delete Existing Assets ?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
                calculate();
            }
            
            document.getElementById('<%= noofcriticalassets.ClientID %>').value = countFamilyNeeds;
            document.getElementById('<%= noofdisabilityassets.ClientID %>').value = countmyNeedplusPart2;
            
            

        }

        function tempCalculateMyneeds() {
            var presentvalueid = 'primyneedplus_';
            var sum = 0;
            for (var i = 1; i <= countFamilyNeeds; i++) {
                var pvid = presentvalueid + (i);
                if (document.getElementById(pvid) != null) {
                    var presentvalue = parseFloat(document.getElementById(pvid).value);
                    document.getElementById(pvid).value=presentvalue;
                    if (!(isNaN(presentvalue))) {
                        sum += presentvalue;
                    }
                }
            }
            document.getElementById('<%= txtExistingAssetsMyNeedsCritical.ClientID %>').value = Math.round(sum * 100) / 100;
            

        }

        function tempCalculateMyneedspart2() {

            var presentvalueid = 'primyneedpluspart2_';
            var sum = 0;
            for (var i = 1; i <= countmyNeedplusPart2; i++) {
                var pvid = presentvalueid + (i);
                if (document.getElementById(pvid) != null) {
                    var presentvalue = parseFloat(document.getElementById(pvid).value);
                    document.getElementById(pvid).value=presentvalue;
                    if (!(isNaN(presentvalue))) {
                        sum += presentvalue;
                    }
                }
            }
            document.getElementById('<%= txtExistingAssetsMyneedsDisability.ClientID %>').value = Math.round(sum * 100) / 100;
            //calculateTab2();

        }

        function popupshowfactfindassets(url) {
            newwindow = window.open(url, 'name', 'height=500,width=1000,scrollbars=1');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function popupassets(url) {
            newwindow = window.open(url, 'name', 'height=500,width=500');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function popUpClosed() {
            window.location.reload();
        }

        window.closingPopup = function () {
            document.getElementById('popupclose').value = 'true';
            document.forms[0].submit();
        };

        function saveProtectionGoals() {
            alert('saveProtectionGoals : ' + count);
            document.getElementById('<%= noofmembers.ClientID %>').value = count;
            document.getElementById('<%= noofcriticalassets.ClientID %>').value = eaCriticalCount;
            document.getElementById('<%= noofdisabilityassets.ClientID %>').value = eaDisabilityCount;

            document.forms[0].submit();
        }

        function printProtectionGoal() {
            /* alert('printProtectionGoal : ' + count);
            document.getElementById('<%= noofmembers.ClientID %>').value = count;
            document.getElementById('<%= noofcriticalassets.ClientID %>').value = eaCriticalCount;
            document.getElementById('<%= noofdisabilityassets.ClientID %>').value = eaDisabilityCount;

            document.forms[0].submit();      */
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

        function calculate() {
            
            removeZeroesMyProtectionGoals();
            
            var replacementIncomeRequired = 0;

            if (!isNaN(document.getElementById("<%=replacementIncomeRequired.ClientID %>").value) && document.getElementById("<%=replacementIncomeRequired.ClientID %>").value != "") {
                replacementIncomeRequired = Math.round(parseFloat(document.getElementById("<%=replacementIncomeRequired.ClientID %>").value));
            }

            var yearsOfSupportRequired = 0;
            if (!isNaN(document.getElementById("<%=yearsOfSupportRequired.ClientID %>").value) && document.getElementById("<%=yearsOfSupportRequired.ClientID %>").value != "") {
                yearsOfSupportRequired = Math.round(parseFloat(document.getElementById("<%=yearsOfSupportRequired.ClientID %>").value));
            }

            var inflationAdjustedReturns = 0;
            if (!isNaN(document.getElementById("<%=inflatedAdjustedReturns.ClientID %>").value) && document.getElementById("<%=inflatedAdjustedReturns.ClientID %>").value != "") {
                inflationAdjustedReturns = parseFloat(document.getElementById("<%=inflatedAdjustedReturns.ClientID %>").value);
            }

            tempCalculateMyneeds();
            tempCalculateMyneedspart2();

            var lumpSumRequired = 0;
             if(inflationAdjustedReturns==0)
            {
                lumpSumRequired = replacementIncomeRequired*yearsOfSupportRequired;
                lumpSumRequired = Math.round(lumpSumRequired*100)/100;
            }
            else
            {
                var rz = inflationAdjustedReturns / 100;
                var rzb = rz + 1;
                var rzn = Math.pow(rzb, -1 * yearsOfSupportRequired);
            
                if (rz != 0) {
                    var calculate1=replacementIncomeRequired * (1 - rzn);
                    var calculate2=calculate1 / rz;
                    lumpSumRequired = Math.round(calculate2 * rzb*100)/100;
                }
            }

            if(isNaN(lumpSumRequired))
                document.getElementById('<%=replacementAmountRequired.ClientID %>').value = fixedToZero(0);
            else
                document.getElementById('<%=replacementAmountRequired.ClientID %>').value = fixedToZero(lumpSumRequired);    

            var lumpSumRequiredForTreatment = 0;
            if (!isNaN(document.getElementById("<%=txtlumpSumRequiredForTreatment.ClientID %>").value) && document.getElementById("<%=txtlumpSumRequiredForTreatment.ClientID %>").value != "") {
                lumpSumRequiredForTreatment = Math.round(parseFloat(document.getElementById("<%=txtlumpSumRequiredForTreatment.ClientID %>").value)*100)/100;
            }
           var totalRequired = lumpSumRequired + lumpSumRequiredForTreatment;
           if(isNaN(totalRequired))
           {
            document.getElementById("<%=totalRequired.ClientID %>").value = "0";
           }
           else
           document.getElementById("<%=totalRequired.ClientID %>").value = fixedToZero(totalRequired);

           var totalAssets = 0;

           var ExistingAssets = 0;
           if (!isNaN(document.getElementById("<%=txtExistingAssetsMyNeedsCritical.ClientID %>").value) && document.getElementById("<%=txtExistingAssetsMyNeedsCritical.ClientID %>").value != "") {
               ExistingAssets = Math.round(parseFloat(document.getElementById("<%=txtExistingAssetsMyNeedsCritical.ClientID %>").value)*100)/100;
           }

           var criticalIllnessNumber  = 0;
           if (!isNaN(document.getElementById("<%=txtCriticalIllnessInsurance.ClientID %>").value) && document.getElementById("<%=txtCriticalIllnessInsurance.ClientID %>").value != "") {
               criticalIllnessNumber = Math.round(parseFloat(document.getElementById("<%=txtCriticalIllnessInsurance.ClientID %>").value)*100)/100;
           }
           
           totalAssets = ExistingAssets + criticalIllnessNumber;
           
           document.getElementById("<%=txtTotalShortfallSurplusMyNeeds.ClientID %>").value =fixedToZero(Math.abs(fixedToZero(totalAssets - totalRequired)));
           document.getElementById("<%=hiddentxtTotalShortfallSurplusMyNeeds.ClientID %>").value =fixedToZero(totalAssets - totalRequired);

           var totalShortfallSurplusForCriticalNeeds=totalAssets - totalRequired;

            if(totalShortfallSurplusForCriticalNeeds>=0)
            {
                $("#totalShortfallForCriticalIllness").hide();
                $("#totalSurplusForCriticalIllness").show();
            }
            else
            {
                $("#totalShortfallForCriticalIllness").show();
                $("#totalSurplusForCriticalIllness").hide();
            }

           var disabilityProtectionReplacementIncomeRequired=0;
           if (!isNaN(document.getElementById("<%=disabilityProtectionReplacementIncomeRequired.ClientID %>").value) && document.getElementById("<%=disabilityProtectionReplacementIncomeRequired.ClientID %>").value != "") {
               disabilityProtectionReplacementIncomeRequired = Math.round(parseFloat(document.getElementById("<%=disabilityProtectionReplacementIncomeRequired.ClientID %>").value)*100)/100;
           }

           var disabilityYearsOfSupport=0;
           if (!isNaN(document.getElementById("<%=disabilityYearsOfSupport.ClientID %>").value) && document.getElementById("<%=disabilityYearsOfSupport.ClientID %>").value != "") {
               disabilityYearsOfSupport = Math.round(parseFloat(document.getElementById("<%=disabilityYearsOfSupport.ClientID %>").value)*100)/100;
           }


           var disabilityInflationAdjustedReturns=0;
           if (!isNaN(document.getElementById("<%=inflationAdjustedReturns.ClientID %>").value) && document.getElementById("<%=inflationAdjustedReturns.ClientID %>").value != "") {
               disabilityInflationAdjustedReturns = parseFloat(document.getElementById("<%=inflationAdjustedReturns.ClientID %>").value);
           }

           var lumpSumRequiredDisability = 0;

           if(disabilityInflationAdjustedReturns==0)
            {
                lumpSumRequiredDisability = disabilityProtectionReplacementIncomeRequired*disabilityYearsOfSupport;
                lumpSumRequiredDisability = Math.round(lumpSumRequiredDisability*100)/100;
            }
            else
            {
                var rz1 = disabilityInflationAdjustedReturns / 100;
                var rzb1 = rz1 + 1;
                var rzn1 = Math.pow(rzb1, -1 * disabilityYearsOfSupport);
                if (rz1 != 0) {
                    lumpSumRequiredDisability = Math.round(((disabilityProtectionReplacementIncomeRequired * (1 - rzn1)) / rz1 * rzb1)*100)/100;
                }
            }

            if(isNaN(lumpSumRequiredDisability))
            {
                document.getElementById('<%=disabilityReplacementAmountRequired.ClientID %>').value = "0";
            }
            else
                document.getElementById('<%=disabilityReplacementAmountRequired.ClientID %>').value = fixedToZero(lumpSumRequiredDisability);
            

            var disabilityInsurance=0;
           if (!isNaN(document.getElementById("<%=disabilityInsurance.ClientID %>").value) && document.getElementById("<%=disabilityInsurance.ClientID %>").value != "") {
               disabilityInsurance = Math.round(parseFloat(document.getElementById("<%=disabilityInsurance.ClientID %>").value)*100)/100;
           }


           var txtShortfallSurplusMyNeeds=0;
           

           var disabilityExistingAssets=0;
           if (!isNaN(document.getElementById("<%=txtExistingAssetsMyneedsDisability.ClientID %>").value) && document.getElementById("<%=txtExistingAssetsMyneedsDisability.ClientID %>").value != "") {
               disabilityExistingAssets = Math.round(parseFloat(document.getElementById("<%=txtExistingAssetsMyneedsDisability.ClientID %>").value)*100)/100;
           }


           var totalInsurancePlusExistingAssets=disabilityInsurance+disabilityExistingAssets;
           txtShortfallSurplusMyNeeds=totalInsurancePlusExistingAssets-lumpSumRequiredDisability;
           document.getElementById("<%=txtShortfallSurplusMyNeeds.ClientID %>").value=Math.abs(fixedToZero(txtShortfallSurplusMyNeeds));
           document.getElementById("<%=hiddentxtShortfallSurplusMyNeeds.ClientID %>").value=fixedToZero(txtShortfallSurplusMyNeeds); 
           
            if(txtShortfallSurplusMyNeeds>=0)
            {
                $("#totalDisabilityProtectionForShortfall").hide();
                $("#totalDisabilityProtectionForSurplus").show();
            }
            else
            {
                $("#totalDisabilityProtectionForShortfall").show();
                $("#totalDisabilityProtectionForSurplus").hide();
            }

        }
        
        function enableDisableCriticalIllnessFields(){

            var criticalIllnessNeededSel = $('#<%=criticalIllnessPr.ClientID %> input:checked').val();
            
            if(criticalIllnessNeededSel == "2"){
                $("#criticalIllnessTbl :input").attr("disabled", false);
                $('#criticalIllnessTotalExAssets').css("display", "block");
                $('#criticalIllnessAssets').css("display", "block");
            }
            else if (criticalIllnessNeededSel == "1" || criticalIllnessNeededSel == "0"){
                $("#criticalIllnessTbl :input").attr("disabled", true);
                $('#criticalIllnessTotalExAssets').css("display", "none");
                $('#criticalIllnessAssets').css("display", "none");
            }

        }
        
        function enableDisableDisabilityPrFields(){

            var disabilityPrNeededSel = $('#<%=disabilityPr.ClientID %> input:checked').val();
            
            if(disabilityPrNeededSel == "2"){
                $("#disabilityPrTbl :input").attr("disabled", false);
                $('#disabilityPrTtlEa').css("display", "block");
                $('#disabilityPrEa').css("display", "block");
            }
            else if(disabilityPrNeededSel == "1" || disabilityPrNeededSel == "0"){
                $("#disabilityPrTbl :input").attr("disabled", true);
                $('#disabilityPrTtlEa').css("display", "none");
                $('#disabilityPrEa').css("display", "none");
            }

        }
        
        function enableDisableHospitalCoverFields(){
            
            var hospitalCoverNeededSel = $('#<%=hospitalmedCoverNeeded.ClientID %> input:checked').val();
            
            if(hospitalCoverNeededSel == "2"){
                $("#hospitalCoverTbl :input").attr("disabled", false);             
            }
            else if(hospitalCoverNeededSel == "1" || hospitalCoverNeededSel == "0"){
                $("#hospitalCoverTbl :input").attr("disabled", true);
            }

            if(ddlExistingPlanList == ""){
                    ddlExistingPlanList = $("#<%=ddlExistingPlanList.ClientID %> option:selected").val();
            }
            if(ddlEpOldageYesNo == ""){
                ddlEpOldageYesNo = $("#<%=ddlEpOldageYesNo.ClientID %> option:selected").val();
            }
            if(ddlEpPersonalYesNo == ""){
                ddlEpPersonalYesNo = $("#<%=ddlEpPersonalYesNo.ClientID %> option:selected").val();
            }

            if (ddlExistingPlanList == "1" || ddlEpOldageYesNo == "1" || ddlEpPersonalYesNo == "1")
            {
                $('#detail_existing_plans').show();
            }
            else{
                $('#detail_existing_plans').hide();
            }

        }
        
        function enableDisableAccidentalCoverFields(){

            var accidentalCoverNeededSel = $('#<%=accidentalHealthCoverNeeded.ClientID %> input:checked').val();
            
            if(accidentalCoverNeededSel == "2"){
                $("#accidentalCoverTbl :input").attr("disabled", false);
            }
            else if(accidentalCoverNeededSel == "1" || accidentalCoverNeededSel == "0"){
                $("#accidentalCoverTbl :input").attr("disabled", true);
            }

            if(ddlExistingPlanList == ""){
                    ddlExistingPlanList = $("#<%=ddlExistingPlanList.ClientID %> option:selected").val();
            }
            if(ddlEpOldageYesNo == ""){
                ddlEpOldageYesNo = $("#<%=ddlEpOldageYesNo.ClientID %> option:selected").val();
            }
            if(ddlEpPersonalYesNo == ""){
                ddlEpPersonalYesNo = $("#<%=ddlEpPersonalYesNo.ClientID %> option:selected").val();
            }

            if (ddlExistingPlanList == "1" || ddlEpOldageYesNo == "1" || ddlEpPersonalYesNo == "1")
            {
                $('#detail_existing_plans').show();
            }
            else{
                $('#detail_existing_plans').hide();
            }

        } 

    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="noofmembers" runat="server" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="noofdisabilityassets" runat="server" />
    <asp:HiddenField ID="activityId" runat="server" />
    <asp:HiddenField ID="noofcriticalassets" runat="server" />
    <asp:HiddenField ID="hiddentxtShortfallSurplusMyNeeds" runat="server" />
    <asp:HiddenField ID="hiddentxtTotalShortfallSurplusMyNeeds" runat="server" />
    <asp:HiddenField ID="backToCase" runat="server"  />
    

<div id="chassis_outer_container">
            <div class="chassis_page_container">
                <FNAMenutag:FNAMenu runat="server" ID="menu1" />
                  <div class="chassis_application_navigation_container">
                      <ul>
                        <li>
                          <div class="chassis_application_navigation_outer chassis_application_nav_first_entry">
                            <div class="chassis_application_navigation_inner">
                              <span id="familyneedstab" runat="server">
                                <asp:LinkButton ID="LinkFamilyNeeds" Text="Family Needs" OnClick="menuClick" CommandArgument="protectionGoals" runat="server" />
                              </span>
                            </div>
                          </div>
                        </li>
                        <li class="chassis_application_navigation_selected_tab2">
                          <div class="chassis_application_navigation_outer">
                            <div class="chassis_application_navigation_inner">
                              <span id="myneedstab" runat="server">
                                <asp:LinkButton ID="LinkMyNeeds" Text="My Needs" OnClick="menuClick" CommandArgument="protectionGoalsMyNeeds" runat="server" />
                              </span>
                            </div>
                          </div>
                        </li>
                      </ul>
                    </div>

                    <div class="chassis_application_pane">
                        <div id="chassis_application_content" class="chassis_application_body">
                       

  <table summary="four column design layout" class="chassis_four_column_list">
  <tbody>
  <tr>
        <td class="chassis_label_column" style="vertical-align:top">
        <table summary="four column design layout" class="chassis_three_column_list">
            <tr>
                <td class="chassis_label_column">Do you require planning for this need?</td>
                <td class="chassis_data_column">
                    <asp:radiobuttonlist id="criticalIllnessPr" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                        <asp:listitem id="criticalIllnessPr2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="criticalIllnessPr1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                        <asp:listitem id="criticalIllnessPr0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                </td>
            </tr>
        </table>
        </td>
        <td class="chassis_label_column" style="vertical-align:top">
        <table summary="four column design layout" class="chassis_three_column_list">
            <tr>
                <td class="chassis_label_column">Do you require planning for this need?</td>
                <td class="chassis_data_column">
                    <asp:radiobuttonlist id="disabilityPr" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                        <asp:listitem id="disabilityPr2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="disabilityPr1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                        <asp:listitem id="disabilityPr0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                </td>
            </tr>
        </table>
        </td>            
    </tr>
  <tr>
    <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_three_column_list" id="criticalIllnessTbl">
    <thead>
    <tr>
        <td colspan="2">Critical Illness</td>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td class="chassis_label_column">
                Replacement Income Required
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="replacementIncomeRequired" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
            
        </tr>
        <tr>
            <td class="chassis_label_column">Years of Support Required</td>
            <td class="chassis_data_column">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="yearsOfSupportRequired" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="chassis_label_column">Inflation Adjusted Returns</td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="inflatedAdjustedReturns" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="chassis_label_column">Replacement Amount Required</td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="replacementAmountRequired" BackColor="#E0E0E0" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
        </tr>
         <tr>
            <td class="chassis_label_column">Lump Sum Required For Treatment</td>
            <td class="chassis_data_column">
                S$&nbsp;<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="txtlumpSumRequiredForTreatment" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
                    
        </tr>
        <tr>
            <td class="chassis_label_column">Total Required</td>
            <td class="chassis_data_column">
                &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox BackColor="#E0E0E0"  ID="totalRequired" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
            
        </tr>
        <tr>
            <td class="chassis_label_column">Critical Illness Insurance</td>
            <td class="chassis_data_column">
                S$&nbsp;<asp:TextBox ID="txtCriticalIllnessInsurance" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>&nbsp;&nbsp;
            </td>
            

        </tr>
        <tr>
            <td colspan=2>
              
            </td>
        </tr>
        
    </tbody>
    </table>
    </td>
    <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_three_column_list" id="disabilityPrTbl">
    <thead>
    <tr>
        <td colspan="2">Disability Protection</td>
    </tr>
    </thead>
    <tbody>

     <tr>
            <td class="chassis_label_column">Replacement Income Required
                &nbsp;
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="disabilityProtectionReplacementIncomeRequired" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
                
        </tr>
        <tr>
            <td class="chassis_label_column">
                Years of Support Required
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="disabilityYearsOfSupport" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
                
        </tr>
        <tr>
            <td class="chassis_label_column">
                Inflation Adjusted Returns
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="inflationAdjustedReturns" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
                
        </tr> 
        <tr>
            <td class="chassis_label_column">
                Replacement Amount Required
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" ID="disabilityReplacementAmountRequired" BackColor="#E0E0E0" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
                
        </tr>
        <tr>
            <td class="chassis_label_column">
                Disability Insurance
            </td>
            <td class="chassis_data_column">
               &nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox OnKeyPress="javascript:allowOnlyNumbers(this.value)" ID="disabilityInsurance" runat="server" CssClass="chassis_application_zplan_small_text_box"></asp:TextBox>
            </td>
        </tr>  
        
    </tbody>
    </table>
    </td>
  </tr>
  <tr>
    <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_three_column_list">
              <thead id="criticalIllnessTotalExAssets">
                <tr>
                  <td colspan="4">Total Existing Assets (SGD) </td>
                </tr>
              </thead>
              <tbody>
                <tr>
                <td colspan="2">
                    <table width="100%">
                        <tr>
                            <td>
                                <fieldset id="criticalIllnessAssets">
                                    <legend><a href="#" id="myNeedsCriticalplus">
                                        <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a>&nbsp;<asp:LinkButton
                                            ID="lnkExistingAssetsMyNeedsCritical" runat="server">Existing Assets</asp:LinkButton>&nbsp;&nbsp;S$<asp:TextBox
                                              ReadOnly="true" BackColor="#E0E0E0" ID="txtExistingAssetsMyNeedsCritical" OnKeyPress = "javascript:allowOnlyNumbers(this.value)" runat="server" CssClass="chassis_application_medium_text_box"
                                                Width="100px"></asp:TextBox></legend>
                                    <table width="100%" id="existingAssetsMyNeedsCriticalTable">
                                        <tr class="table_header">
                                            <td align="center" class="chassis_label_column">
                                                Asset
                                            </td>
                                            <td align="center" class="chassis_label_column">
                                                Present Value
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="myNeedsCriticalAssetList" runat="server">
                                            <ItemTemplate>
                                                <tr id='existingAssetMyNdCrtclRowId<%# (Container.ItemIndex+1)%>'>
                                                    <td align="center" style="width:45%">
                                                        <input type='text' style='width: 100px;' id='primyneedscritical-<%# (Container.ItemIndex+1)%>'
                                                            name='primyneedscritical-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                                    </td>
                                                    <td align="center" style="width:50%">
                                                        <input type='text' onkeypress='javascript:allowOnlyNumbers(this.value)' value='<%# Eval("presentvalue") %>' id='primyneedplus_<%# (Container.ItemIndex+1)%>'
                                                            name='primyneedplus_<%# (Container.ItemIndex+1)%>' style='width: 100px;' onblur='calculate()' />
                                                            <a onclick="DeleteRow('existingAssetMyNdCrtclRowId<%# (Container.ItemIndex+1)%>')"><img
                                                            alt="" style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                                    </td>
                                                    <td align="center" style="width:5%">
                                                        &nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                    
                                    
                                </fieldset>
                                <table width="100%">
                                        <tr style="background-color: #DDDDDD;">
                                            <td align="center" class="chassis_label_column">
                                                <b>Total <span id="totalShortfallForCriticalIllness" style="color:Red">Shortfall</span>  <span id="totalSurplusForCriticalIllness">Surplus</span>
                                                </b> 
                                            </td>
                                            <td align="center" class="chassis_data_column chassis_no_padding_right" >
                                                S$&nbsp;<asp:TextBox OnKeyPress = "javascript:allowOnlyNumbers(this.value)" BackColor="#E0E0E0" ID="txtTotalShortfallSurplusMyNeeds" runat="server" CssClass="chassis_application_medium_text_box" Width="100px" ></asp:TextBox>
                                            </td>
                                       </tr>
                                   </table>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
                 
                
              </tbody>
            </table>            
    </td>
    <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_three_column_list">
    <thead id="disabilityPrTtlEa">
        <tr>
            <td colspan="4">Total Existing Assets (SGD) </td>
        </tr>
     </thead>
     <tbody>
        <tr>
                <td colspan="2">
                <fieldset id="disabilityPrEa">
                    <legend><a href="#" id="myNeedsDisabilityplus">
                        <img alt="" style='width: 15px; height: 15px;' src="/_layouts/Zurich/images/Content/add-icon.jpg" /></a>&nbsp;<asp:LinkButton
                            ID="lnkExistingAssetsMyneedsDisability" runat="server">Existing Assets</asp:LinkButton>&nbsp;&nbsp;S$<asp:TextBox
                                ID="txtExistingAssetsMyneedsDisability" runat="server" ReadOnly="true" BackColor="#E0E0E0"  CssClass="chassis_application_medium_text_box"
                                Width="100px"></asp:TextBox></legend>
                    <table width="100%" id="existingAssetsMyNeedsDisabilityTable">
                        <tr class="table_header">
                            <td align="center" class="chassis_label_column">
                                Asset
                            </td>
                            <td align="center" class="chassis_label_column">
                                Present Value
                            </td>
                        </tr>
                        <asp:Repeater ID="myNeedsDisabilityAssetList" runat="server">
                            <ItemTemplate>
                                <tr id='existingAssetMyNdDisbtyRowId<%# (Container.ItemIndex+1)%>'>
                                    <td align="center" style="width:45%">
                                        <input type='text' style='width: 100px;' id='primyneedsdisb-<%# (Container.ItemIndex+1)%>'
                                            name='primyneedsdisb-<%# (Container.ItemIndex+1)%>' value='<%# Eval("asset") %>' />
                                    </td>
                                    <td align="center" style="width:50%">
                                        <input type='text' onkeypress='javascript:allowOnlyNumbers(this.value)' value='<%# Eval("presentvalue") %>' id='primyneedpluspart2_<%# (Container.ItemIndex+1)%>'
                                            name='primyneedpluspart2_<%# (Container.ItemIndex+1)%>' style='width: 100px;'
                                            onblur='calculate()' />
                                            <a onclick="DeleteRow('existingAssetMyNdDisbtyRowId<%# (Container.ItemIndex+1)%>')"><img
                                            alt="" style='width: 15px; height: 15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                                    </td>
                                    <td align="center" style="width:5%">
                                        
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </fieldset>
                </td>
                </tr>
     </tbody>
    </table>
    <table>
    <tr style="background-color: #DDDDDD;">
            <td class="chassis_label_column">
                <b><span id="shortfall_surplus">
                Total <span id="totalDisabilityProtectionForShortfall" style="color:Red">Shortfall</span>  <span id="totalDisabilityProtectionForSurplus">Surplus</span>
                </span></b>
            </td>                                                                                    
            <td class="chassis_data_column chassis_no_padding_right" align="right">
                S$&nbsp; <asp:TextBox OnKeyPress="javascript:allowOnlyNumbers(this.value)" BackColor="#E0E0E0" ID="txtShortfallSurplusMyNeeds" runat="server" CssClass="chassis_application_medium_text_box"
                    Width="100px"></asp:TextBox>
            </td>
        </tr>
    </table>
            
    </td>
  </tr>

  <tr>
        <td class="chassis_label_column" style="vertical-align:top">
        <table summary="four column design layout" class="chassis_three_column_list">
            <tr>
                <td class="chassis_label_column">Do you require planning for this need?</td>
                <td class="chassis_data_column">
                    <asp:radiobuttonlist id="hospitalmedCoverNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                        <asp:listitem id="hospitalmedCoverNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="hospitalmedCoverNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                        <asp:listitem id="hospitalmedCoverNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                </td>
            </tr>
        </table>
        </td>
        <td class="chassis_label_column" style="vertical-align:top">
        <table summary="four column design layout" class="chassis_three_column_list">
            <tr>
                <td class="chassis_label_column">Do you require planning for this need?</td>
                <td class="chassis_data_column">
                    <asp:radiobuttonlist id="accidentalHealthCoverNeeded" class="chassis_radio" RepeatDirection = "Horizontal" runat="server">
                        <asp:listitem id="accidentalHealthCoverNeeded2" value="2" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="accidentalHealthCoverNeeded1" value="1" Text = "&nbsp;No&nbsp;&nbsp;"/>
                        <asp:listitem id="accidentalHealthCoverNeeded0" value="0" Text = "&nbsp;Not Applicable&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                </td>
            </tr>
        </table>
        </td>            
    </tr>

  <tr>
  <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_two_column_list" id="hospitalCoverTbl">
    <thead>
    <tr>
        <td colspan="3">Hospital and Medical Coverage</td>
    </tr>

    </thead>
    <tbody>
        <tr>
            <td colspan=3>
                If you are hospitalized, what type of coverage are you looking at
            </td>
        </tr>
            <tr class="table_header">
                <td width="40%" class="chassis_label_column">
                    
                </td>
                <td width="27%" align="center" class="chassis_label_column">
                    Coverage
                </td>
                <td width="33%" align="center" class="chassis_label_column">
                    Any Existing Plans
                </td>
            </tr>
            <tr>
                <td class="chassis_label_column">
                    Type of Hospital
                </td>
                <td>
                    <asp:DropDownList ID="ddlHospitalTypeList" runat="server" CssClass="chassis_application_medium_select_list">
                        <asp:ListItem Value="">-Select-</asp:ListItem>
                        <asp:ListItem Value="Public">Public</asp:ListItem>
                        <asp:ListItem Value="Private">Private</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td rowspan="2">
                    <asp:DropDownList ID="ddlExistingPlanList" runat="server" CssClass="chassis_application_medium_select_list">
                        <asp:ListItem Value="">-Select-</asp:ListItem>
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="chassis_label_column">
                    Type of Room
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlRoomTypeList" runat="server" CssClass="chassis_application_medium_select_list">
                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                    <asp:ListItem Value="1">1 Bed</asp:ListItem>
                                    <asp:ListItem Value="2">2 Bed</asp:ListItem>
                                    <asp:ListItem Value="3">3 Bed</asp:ListItem>
                                    <asp:ListItem Value="4">4 Bed</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
    </tbody>
    </table>
  </td>
  <td class="chassis_label_column" style="vertical-align:top">
    <table summary="four column design layout" class="chassis_two_column_list" id="accidentalCoverTbl">
        <thead>
            <tr>
                <td colspan="3">Accident and Health Coverage</td>
            </tr>
        </thead>
        <tbody>
        <tr>
        <td style="height:20px;"></td>
        </tr>
            <tr class="table_header">
                <td width="40%" class="chassis_label_column">
                    
                </td>
                <td width="27%" align="center" class="chassis_label_column">
                    Coverage
                </td>
                <td width="33%" align="center" class="chassis_label_column">
                    Any Existing Plans
                </td>
            </tr>
            <tr>
                <td class="chassis_label_column">
                    To be covered for old age disability
                </td>
                <td>
                    <asp:DropDownList ID="ddlCoverageOldageYesNo" runat="server" CssClass="chassis_application_medium_select_list">
                        <asp:ListItem Value="">-Select-</asp:ListItem>
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddlEpOldageYesNo" runat="server" CssClass="chassis_application_medium_select_list">
                        <asp:ListItem Value="">-Select-</asp:ListItem>
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>        
            <tr>
            <td class="chassis_label_column">
                To be covered for personal accident
            </td>
            <td>
                <asp:DropDownList ID="ddlCoveragePersonalYesNo" runat="server" CssClass="chassis_application_medium_select_list">
                    <asp:ListItem Value="">-Select-</asp:ListItem>
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlEpPersonalYesNo" runat="server" CssClass="chassis_application_medium_select_list">
                    <asp:ListItem Value="">-Select-</asp:ListItem>
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>    
    </tbody>
    </table>
  </td>
  </tr>


  </tbody>
    
 </table>
 <span id="detail_existing_plans">
    <b>Details of existing plans</b>
     <br/>
     <asp:TextBox ID="DetailsOfExistingPlans" TextMode="MultiLine" Width="830px" Height="150px" runat="server" ></asp:TextBox>
 </span>

               <table width="100%">
                <tr align="right">
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Generate Pdf" OnClick="createMyneedsPdf" class="chassis_application_button_xxxlarge" />
                        <asp:Button ID = "btnBack" class = "chassis_application_button_medium" runat = "server"
                            Text = "Previous" OnClick = "saveProtectionGoalsAndBack"/>
                        <asp:Button ID="btnSave" class="chassis_application_button_medium" runat="server"
                            Text="Save" OnClick="saveProtectionGoals" />
                        <asp:Button ID = "btnNextAndSave" class = "chassis_application_button_medium" runat = "server"
                            Text = "Next" OnClick = "saveProtectionGoalsAndNext"/>
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
Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
