<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PriorityDetails.aspx.cs" Inherits="Zurich.Layouts.Zurich.PriorityDetails" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<!-- <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Site.css" /> -->
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />



<style type="text/css">
        .errorStyle
        {
            background-color:#FFCCCC;
        }
        
        .noerrorStyle
        {
            background-color:#FFFFFF;
        }
        
        .textBox1
        {
            width: 17px;top: 30%;left: 15%;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px; 
        }        
        .box {
            width: 680px;
            background:#fff;
            font-family:Times New Roman ,Arial, Helvetica, sans-serif;
            font-size:12pt;
            margin-left:auto;
            margin-right:auto;
            margin-top:15px;
            padding:30px;
            border-top:1px solid #CCCCCC;
            border-left:1px solid #CCCCCC;
            border-right:1px solid #999999;
            border-bottom:1px solid #999999;
            -moz-border-radius: 8px;
            -webkit-border-radius: 8px;
            }
            
            .textStyle
            {
                   color:Black;
                   font-size:9pt;
                   font-weight:normal;
                   font-family:Verdana, Times New Roman;
                   padding-bottom:1px;
            }
            
            
            .rounds
            {
                
            -moz-border-radius:5px;  
            border-radius: 5px;  
            -webkit-border-radius: 5px;     
                
            }
            
            .textStyleHeader
            {
                   color:#2B77B2;
            }
    </style>
    <script type="text/javascript">

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


     function validateAllFields(oSrc, args) {
         
         var priorityValueCount = new Array();
         for( var t=1; t<9;t++)
         {
             var sum = 0;
             for (var k = 1; k <= t; k++) {
                 sum += k;
             }
             priorityValueCount[t] = sum;
         }

         
         var arrPriority = new Array();
         var priorityCount = 0;
         var summation = 0;

         if (!isNaN(document.getElementById('<%= priorityNeed1.ClientID %>').value) && document.getElementById('<%= priorityNeed1.ClientID %>').value != "") {
             
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed1.ClientID %>').value);
         }

         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed2.ClientID %>').value) && document.getElementById('<%= priorityNeed2.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed2.ClientID %>').value);
         }

         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed3.ClientID %>').value) && document.getElementById('<%= priorityNeed3.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed3.ClientID %>').value);
         }

         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed4.ClientID %>').value) && document.getElementById('<%= priorityNeed4.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed4.ClientID %>').value);
         }
         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed5.ClientID %>').value) && document.getElementById('<%= priorityNeed5.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed5.ClientID %>').value);
         }

         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed6.ClientID %>').value) && document.getElementById('<%= priorityNeed6.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed6.ClientID %>').value);
         }

         //alert("priorityCount - " + priorityCount + " summation - " + summation);

         if (!isNaN(document.getElementById('<%= priorityNeed7.ClientID %>').value) && document.getElementById('<%= priorityNeed7.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed7.ClientID %>').value);
         }

         if (!isNaN(document.getElementById('<%= priorityNeed8.ClientID %>').value) && document.getElementById('<%= priorityNeed8.ClientID %>').value != "") {
             priorityCount += 1;
             summation += parseInt(document.getElementById('<%= priorityNeed8.ClientID %>').value);
         }

         if (priorityCount == 0 && summation == 0) {
             args.IsValid = true;
         }
         else 
            {
                 if (priorityValueCount[priorityCount] != summation) {
                     args.IsValid = false;
            }
         }
         
     }

     function ValidateFormValues(oSrc, args) {

            args.IsValid = true;
            var elem = document.forms[0].elements;

            var arrPriority = new Array();
            var priorityCount = 0;
            for (var i = 0; i < elem.length; i++) {
                if (elem[i].type == 'text') {
                    arrPriority[priorityCount] = parseInt(elem[i].value);
                    priorityCount++;
                }
            }
            for (var i = 0; i < arrPriority.length; i++) {
                for (var j = i + 1; j <= arrPriority.length; j++) {
                    if (arrPriority[i] == arrPriority[j]) {
                        args.IsValid = false;
                        break;
                    }
                }
            }

        }

        function next() {
            window.location.href = '/AssetLiability/ShowAssetLiability';

        }

        function back() {
            window.location.href = '/FactFind/PersonalDetails';

        }

        function printpg() {
            document.getElementById('printpage').value = "true";
            document.forms[0].submit();
        }

        function allowOnlyNumbers() {
            if (event.keyCode < 46 || event.keyCode > 57) {
                event.returnValue = false;
            }
            else {

            }
        }
        
	</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<asp:HiddenField ID="activityId" runat="server"  />
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
                <li class="chassis_application_navigation_selected_tab2">
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
                        <asp:Label ID="lblPdSummarySaveSuccess" runat="server" class="chassis_application_save_success"
                            Text="• Priority Details saved successfully"></asp:Label>
                        <asp:Label ID="lblPdSummarySaveFailed" runat="server" class="chassis_application_feedback_error"
                            Text="• Failed to save Priority Details"></asp:Label>
                        <asp:Label ID="lblStatusSubmitted" runat="server" class="chassis_application_save_success"
                            Text="• Case Status submitted successfully" Visible = "false"></asp:Label>
                        <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                            Text="• Failed to Submit Case Status" Visible = "false"></asp:Label>
                    </td>
                </tr>
            </table>
            <asp:Repeater ID="ErrorRepeater" runat="server">
                <ItemTemplate>
                    <tr>
                        <td align="left">
                            <label class="chassis_application_feedback_error">• <%# Container.DataItem %></label>    
                        </td>
                    </tr>       
                </ItemTemplate>
             </asp:Repeater>
            <table class="chassis_four_column_list" summary="Adviser details">
            <thead>
                <tr>
                    <td colspan="2">Priority Details</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="2">
<!--<div style="height:800px;" > -->
    <div>
        <div id="error" align="center">
        
        </div>
        <div >
        <asp:validationsummary id="valSummary" runat="server" ShowMessageBox="false" />
        </div>
        <div id="Div1" align="center">
        <font color='green'><b></b></font>
        </div>
        <div id="table1" style="height:800px;width:950px;background-image:url(/_layouts/zurich/images/priority_bgd.png);position:relative; background-repeat:no-repeat;background-size:90%;" >
        
        <span class="textStyleHeader" style="top: 22%;left: 17%;position:absolute;">Step 2 : <b>Protection</b></span>
        <asp:TextBox ID="priorityNeed1" MaxLength=1 name="priorityNeed1" style="top: 25%;left: 15%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"/> <span class="textStyle" style="top: 25%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Insuring My Mortgage</a></span>
        
        
        <asp:TextBox ID="priorityNeed8" MaxLength=1 name="priorityNeed5" style="top: 29%;left: 15%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" /> <span class="textStyle" style="top: 27.5%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Insuring my</a></span>
        
        <span class="textStyle" style="top: 30%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Hospitalisation Expenses</a></span>

        
        
        <asp:TextBox ID="priorityNeed2" MaxLength=1 name="priorityNeed2" style="top: 34%;left: 15%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" /> <span class="textStyle" style="top: 33%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Protecting Against</a></span>
        
        <span class="textStyle" style="top: 36%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Critical Illnesses</a></span>
        <asp:TextBox ID="priorityNeed3" MaxLength=1 name="priorityNeed3" style="top: 40%;left: 15%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"/> <span class="textStyle" style="top: 40%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Protecting Against</a></span>
        
        <span class="textStyle" style="top: 43%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Pre-mature Death</a></span>
        
        <asp:TextBox ID="priorityNeed7" MaxLength=1 name="priorityNeed7" style="top: 46%;left: 15%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"/> <span class="textStyle" style="top: 45%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Protecting Against</a></span>
        <span class="textStyle" style="top: 47%;left: 18%;position:absolute;"><a href='/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Disability</a></span>

       <span class="textStyleHeader" style="top: 10%;left: 68%;position:absolute;">Step 3 : <b>Savings</b></span>
        <asp:TextBox ID="priorityNeed4" MaxLength=1 name="priorityNeed4" OnKeyPress = "javascript:allowOnlyNumbers()" style="top: 14.2%;left: 63.5%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" /> <span class="textStyle" style="top: 14.5%;left: 66%;position:absolute;"><a href='/_layouts/Zurich/RetirementGoals/ShowRetirementGoals.aspx?caseid=<%=ViewState["caseId"] %>'>What I Need At Retirement</a></span>
        
        <asp:TextBox ID="priorityNeed5" MaxLength=1 name="priorityNeed5" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()" style="top: 17.8%;left: 63.3%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;"/> <span class="textStyle" style="top: 18%;left: 66%;position:absolute;"><a href='/_layouts/Zurich/EducationGoals/ShowEducationGoals.aspx?caseid=<%=ViewState["caseId"] %>'>What My Children Need</a></span>
        
        <span class="textStyle" style="top: 20%;left: 66%;position:absolute;"><a href='/_layouts/Zurich/EducationGoals/ShowEducationGoals.aspx?caseid=<%=ViewState["caseId"] %>'>for Education</a></span>
        <asp:TextBox ID="priorityNeed6" MaxLength=1 name="priorityNeed6" OnKeyPress = "javascript:allowOnlyNumbers()" style="top: 22.5%;left: 63.5%;position:absolute; width: 17px;position:absolute;-moz-border-radius:10px;border-radius: 10px;-webkit-border-radius: 10px;padding-bottom:1px;padding-left:3px;" runat="server" /> <span class="textStyle" style="top: 23%;left: 66%;position:absolute;"><a href='/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Making My Money</a></span>
        
        <span class="textStyle" style="top: 25%;left: 66%;position:absolute;"><a href='/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx?caseid=<%=ViewState["caseId"] %>'>Work Harder</a></span>
       
        <img alt=""  style='top: 42%;left: 58%;position:absolute;width:15px;height:15px;' src="/_layouts/Zurich/images/checkmark.jpg" />
        <span class="textStyleHeader" style="top: 42%;left: 60%;position:absolute;">Step 1 : <b>Liquidity</b></span>
        <span class="textStyle" style="top: 45%;left: 60%;position:absolute;">Emergency Funds</span>
        <span class="textStyle" style="top: 48%;left: 60%;position:absolute;">Short-term Goals</span>
        <span class="textStyle" style="top: 50%;left: 60%;position:absolute;">(less than 1 year)</span>
        
        <span class="textStyle" style="top: 1%;left: 1%;position:absolute;font-size:small "><b>Please rank your priorities in order 1 (most important) to 8 (least important)</b></span>

        <span class="textStyle" style="top: 72%;left: 50%;position:absolute;font-size:small "></span>
        <span style="top: 72%;left: 43%;position:absolute;font-size:small;font-family: Verdana;font-size: 1.0em;">
            <asp:Button ID="Button1" runat="server" Text="Generate Pdf" OnClick="createPrioritydetailsPdf" class="chassis_application_button_xxxlarge" />
            <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Previous" OnClick="savePriorityDetailsAndBack" />
            <asp:Button ID="Button5" class="chassis_application_button_medium" runat="server" Text="Save" OnClick="savePriorityDetails" />
            <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Next" OnClick="savePrioritydetailsAndNext" />
            <asp:Button ID="Button4" class="chassis_application_button_xxxlarge" runat="server" Text="Back To Case Portal" OnClientClick="onBackToCase()" OnClick="redirectToCasePortal" />
        </span>
        <span class="textStyle" style="top: 72%;left: 70%;position:absolute;font-size:small ">
            
            
        <asp:CustomValidator id="CustomValidator1" 
             runat="server" ControlToValidate="priorityNeed6" Display="None" ValidateEmptyText="True"
             ErrorMessage="Priorities should be in a proper sequence or should not be repeated" ClientValidationFunction="validateAllFields"
             />

        </span>
        <span class="textStyle" style="top: 72%;left: 80%;position:absolute;font-size:small "></span>
        
        </div>
    
    </div>
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

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
