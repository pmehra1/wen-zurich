<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="DTO" %>
<%@ Import Namespace="DAO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalDetails.aspx.cs" Inherits="Zurich.Layouts.Zurich.PersonalDetails" DynamicMasterPageFile="~masterurl/custom.master" EnableSessionState="True" %>
<%@ Register TagPrefix="FNAMenutag" TagName="FNAMenu" src="~/_controltemplates/Zurich/FNAMenu.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

<link rel="stylesheet" href="/_layouts/Zurich/styles/css/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/css/ui.theme.css" type="text/css" media="all" />
<script src="/_layouts/Zurich/styles/css/jquery.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery-ui.min.js" type="text/javascript"></script>
<script src="/_layouts/Zurich/styles/css/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>



<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<!-- <link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" /> -->
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />
<script src="/_layouts/Zurich/styles/js/utility.js" type="text/javascript"></script>

<script type='text/javascript'>

    _spSuppressFormOnSubmitWrapper = true;

</script>

<%
    int fmsize = 0;
    /*if (ViewState["familymembers"] != null)
    {
        EntitySet<familyMemberDetail> familyMembers = ViewState["familymembers"] as EntitySet<familyMemberDetail>;
        fmsize = familyMembers.Count;
    }*/
%>


<script language="javascript" type="text/javascript">
    
    function validateAllFields(oSrc, args) {
        args.IsValid = true;
        $('[id^="datepicker-"]').each(function() {
            var datePickerValue=$(this).val();
            if(datePickerValue!=null && datePickerValue!='')
            {
                var flag = isDate(datePickerValue);
                if(flag==false)
                {
                    $(this).addClass("dateBackGroundColour");
                    args.IsValid = false;
                }else{
                    var dateRegEx = /^[0-3][0-9][/][0-1][0-9][/](19|20)\d\d$/;
            
                    if(datePickerValue.match(dateRegEx) == null)
                    {
                        $(this).addClass("dateBackGroundColour");
                        args.IsValid = false;
                    }
                    else{
                        $(this).removeClass("dateBackGroundColour");
                    }
                }
            }
        });

    }

    function onBackToCase() {
        showNotification();
        
        var response = confirm("Do you want to save the changes to PDF before Back to the Case?");
        if (response == true) {
            document.getElementById('<%=backToCase.ClientID %>').value = true;
        }
        else {
            document.getElementById('<%=backToCase.ClientID %>').value = false;
        }
    }


    function calcYearsOfSupport(relationship,dob,yrsToSupport)
    {
        var rel = document.getElementById(relationship).value;
        rel = $.trim(rel);
        rel=rel.toLowerCase();
        var db = document.getElementById(dob).value;
        var currentTime = new Date();
        var yrs = document.getElementById(yrsToSupport).value;
        var age=0;
        
        if (rel != "" && db != "") {
        var parts = db.split("/");
        var dbd = calculateAge(parts[1],parts[0],parts[2]);
        
            switch (rel)
                {
                case "son":
                  if(dbd>=25)
                    age="";
                  else
                    age= 25-dbd;
                  break;
                case "daughter":
                    if(dbd>=22)
                        age="";
                      else
                    age= 22-dbd;
                break;
                case "father":
                    if(dbd>=83)
                        age="";
                      else
                    age= 83-dbd;
                  break;
                  case "husband":
                    if(dbd>=83)
                        age="";
                      else
                    age= 83-dbd;
                  break;
                  case "mother":
                    if(dbd>=88)
                        age="";
                      else
                    age= 88-dbd;
                  break;
                  case "wife":
                    if(dbd>=88)
                        age="";
                      else
                    age= 88-dbd;
                  break;
                default:
                  age="";
                }
            
            if(!isNaN(age))
            {
                document.getElementById(yrsToSupport).value=age;
            }
            else
                document.getElementById(yrsToSupport).value="";
            
        }
        else
        {
            document.getElementById(yrsToSupport).value="";
        }
        
    }

    $(function() {
    	       $('input[id^="datepicker"]').datepicker({
			    showOn: "button",
			    buttonImage: "/_layouts/Zurich/images/calendar.gif",
			    buttonImageOnly: true,
                changeMonth: true,
			    changeYear: true,
                dateFormat: 'dd/mm/yy',
                yearRange: "-70"
		    });
	    });

    var count = 0;

    count = <%= fmsize %>;

    $(document).ready(function () {
    

        var titleSelected = $("#<%=titleList.ClientID %> option:selected").val();
         if (titleSelected == "Other")
                $('#titleOthersDiv').show();
            else
                $('#titleOthersDiv').hide();


        var nationalitySelected = $("#<%=nationalityList.ClientID %> option:selected").val();
         if (nationalitySelected == "Other")
                $('#nationality_span').show();
            else
                $('#nationality_span').hide();

        var medicalSelected = $("#<%=medicalList.ClientID %> option:selected").val();
         if (medicalSelected == "Yes")
                {
                $('#medicalListConditions').show();
                }
            else
            {
                $('#medicalListConditions').hide();
             }   

        $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });

        $('#familyDetailsPlus').click(function () {
            var count = $("#familyDetails >tbody > tr").size()-1
            count += 1;
            var str = 'familyDetailsRowId' + count;
            var memberRelative = 'memberrel-' + count;
            var dob = 'memberrel-' + count;
            var yrssupport ='memberyrssupport-'+ count;
            var relative = "'input#memberrel-" + count+"'";
            var comboBox = "comboFamilyBox-"+count;

            var dummyComboBox = '<select id="'+comboBox+'" style="width: 100px;" onchange="$('+relative+').val($(this).val());">';
	                      dummyComboBox+="<option></option>";
                          dummyComboBox+="<option>Son</option>";
	                      dummyComboBox+="<option>Daughter</option>";
                          dummyComboBox+="<option>Father</option>"; 
	                      dummyComboBox+="<option>Mother</option>";
                          dummyComboBox+="<option>Husband</option>";
                          dummyComboBox+="<option>Wife</option>";
                          dummyComboBox+="</select>";

        
            var datepicker = 'datepicker-' + count;
            var row1 = $("<tr id='familyDetailsRowId" + count + "' width=100%>"
            + "<td align='center'><input type='text' id='membername-" + count + "' name='membername-" + count + "' style='width: 100px;'/></td>"
            + "<td align='center'> "+dummyComboBox+" <input type='text' id='memberrel-" + count + "' name='memberrel-" + count + "' style='width: 85px;margin-left: -103px;height: 1.2em; border: 0;' onchange=calcYearsOfSupport('" + memberRelative+ "','" + datepicker +"','" + yrssupport + "') onblur=calcYearsOfSupport('" + memberRelative+ "','" + datepicker +"','" + yrssupport + "') "+"/></td>"
            + "<td align='center'><input type='text' id=" + datepicker + " name=" + datepicker + " style='width: 100px;' maxlength='10' onkeypress=allowOnlyNumbersForDates() onchange=calcYearsOfSupport('" + memberRelative+ "','" + datepicker +"','" + yrssupport + "') onblur=calcYearsOfSupport('" + memberRelative+ "','" + datepicker +"','" + yrssupport + "') "+"/></td>"
            + "<td align='center'><input type='text' id='memberoccupation-" + count + "' name='memberoccupation-" + count + "' style='width: 100px;'/></td>"
            + "<td align='center'><input type='text' id='monthlyIncome-" + count + "' name='monthlyIncome-" + count + "' style='width: 100px;' onkeypress = 'javascript:allowOnlyNumbers()'/></td>"
            + "<td align='center'><input type='text' id='memberyrssupport-" + count + "' name='memberyrssupport-" + count + "' onkeypress = 'javascript:allowOnlyNumbers()' style='width: 100px;'/>&nbsp;&nbsp;<a onClick=DeleteRow('" + str + "')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a></td>"
            + "</tr>");
            $("#familyDetails").append(row1);
            $('input[id^="datepicker"]').datepicker({
			    showOn: "button",
			    buttonImage: "/_layouts/Zurich/images/calendar.gif",
			    buttonImageOnly: true,
                changeMonth: true,
			    changeYear: true,
                dateFormat: 'dd/mm/yy',
                yearRange: "-70"

		    });
            
            document.getElementById('<%=membernumber.ClientID %>').value = count;
           // alert(document.getElementById('<%=membernumber.ClientID %>').value);
            
        });

         $('#<%=titleList.ClientID %>').change(function(){
         var titleSelected = $("#<%=titleList.ClientID %> option:selected").val();
         if (titleSelected == "Other")
                $('#titleOthersDiv').show();
            else
                $('#titleOthersDiv').hide();
         });
        
         $('#<%=nationalityList.ClientID %>').change(function(){
         var nationalitySelected = $("#<%=nationalityList.ClientID %> option:selected").val();
         if (nationalitySelected == "Other")
                $('#nationality_span').show();
            else
                $('#nationality_span').hide();
         });

         $('#<%=medicalList.ClientID %>').change(function(){
         var medicalSelected = $("#<%=medicalList.ClientID %> option:selected").val();
         if (medicalSelected == "Yes")
                {
                $('#medicalListConditions').slideToggle("slow");
                $('#medicalListConditions').show();
                }
            else
            {
                $('#medicalListConditions').slideToggle("slow");
                $('#medicalListConditions').hide();
             }   
         });
         
        $('#<%=FamilyDetailsRequired.ClientID %>').change(function(){
            var confirm = $("#<%=FamilyDetailsRequired.ClientID %> input:checked").val();
            if (confirm == "0")
            {      
                document.getElementById("familyDetailsFieldSet").style.display = "none";
                $('#familyDetailsHeading').hide();
                $('#noteSpan').hide();
            }
            else                
            {                
                document.getElementById("familyDetailsFieldSet").style.display = "block";
                $('#familyDetailsHeading').show();
                $('#noteSpan').show();
            }
        });

        $('#<%=spokenLanguageOptions.ClientID %>').click(function()
        {           
            var chkGroup = $("input[id^=<%=spokenLanguageOptions.ClientID %>]");
        
            $txtbox = $('[id*="spokenLanguageOtherstxt"]');
            if (($(chkGroup[4]).attr('checked') == 'checked')) {                
                $txtbox.show();                
            }
            else {
                $txtbox.hide();                
                $txtbox.val("");
            }
        });

        $('#<%=writtenLanguageOptions.ClientID %>').click(function()
        {           
            var chkGroup = $("input[id^=<%=writtenLanguageOptions.ClientID %>]");
        
            $txtbox = $('[id*="writtenLanguageOtherstxt"]');
            if (($(chkGroup[4]).attr('checked') == 'checked')) 
            {
                 $txtbox.show();                
            }
            else 
            {                
                $txtbox.hide();
                $txtbox.val("");
            }
        });

        $('#<%=accompanyQuestion.ClientID %>').change(function(){
            var confirm = $("#<%=accompanyQuestion.ClientID %> input:checked").val();
            if (confirm == "0")
            {
                $('[id*="lblNRICAccompany"]').hide();
                $('[id*="lblClientRelationship"]').hide();
                $('[id*="lblTrustedIndividualName"]').hide();
                $('[id*="TrustedIndividualName"]').hide();
                $('[id*="ClientRelationship"]').hide();
                $('[id*="NRICAccompany"]').hide();                
            }
            else                
            {
                $('[id*="lblNRICAccompany"]').show();
                $('[id*="lblClientRelationship"]').show();
                $('[id*="lblTrustedIndividualName"]').show();
                $('[id*="TrustedIndividualName"]').show();
                $('[id*="ClientRelationship"]').show();
                $('[id*="NRICAccompany"]').show();                
            }
        });

        $('#<%=FamilyDetailsRequired.ClientID %>').trigger('change');
        $('#<%=accompanyQuestion.ClientID %>').trigger('change');
        $('#<%=spokenLanguageOptions.ClientID %>').trigger('click');
        $('#<%=writtenLanguageOptions.ClientID %>').trigger('click');
    });

    $(function () {
        $.datepicker.setDefaults($.datepicker.regional['']);

    });

    $(function () {
            $('.chassis_application_navigation_selected_tab1').removeClass("chassis_application_navigation_selected_tab1");
            $('#factFind').addClass("chassis_application_navigation_selected_tab1");

            var mzaclass = $('#<%=mzatab.ClientID %>').attr("class");
            var pdclass = $('#<%=personaldetailstab.ClientID %>').attr("class");
            var prdclass = $('#<%=prioritydetailstab.ClientID %>').attr("class");
            var ieclass = $('#<%=incomeexpensetab.ClientID %>').attr("class");
            var alclass = $('#<%=assetliabilitytab.ClientID %>').attr("class");

            if((mzaclass == 'chassis_application_page_complete') && (pdclass == 'chassis_application_page_complete') && (prdclass == 'chassis_application_page_complete') && (ieclass == 'chassis_application_page_complete') && (alclass == 'chassis_application_page_complete')){
                $("#factFindtab").addClass("chassis_application_page_complete");    
            }else{
                if((mzaclass == 'chassis_application_page_warnings') || (pdclass == 'chassis_application_page_warnings') || (prdclass == 'chassis_application_page_warnings') || (ieclass == 'chassis_application_page_warnings') || (alclass == 'chassis_application_page_warnings')){
                    $("#factFindtab").addClass("chassis_application_page_warnings");
                }
            }

        });

        function DeleteRow(param) 
        {
            var answer = confirm("Delete Family member?")
            if (answer) {
                $('#' + param).slideUp('slow');
                $('#' + param).hide();
                $('#' + param).remove();
        }
        else {

        }     
    }

    function showNotification(){
        var dobPerson = $("#<%=datepicker.ClientID %>").val();
        var dtDob = new Date(dobPerson.replace( /(\d{2})-(\d{2})-(\d{4})/, "$2/$1/$3"));
        var currentDate = new Date();
        var age = currentDate.getFullYear() - dtDob.getFullYear();
        var ageFactor = false;
        if(age >= 62){
            ageFactor = true;
        }

        var chkGroupSpokenLang = $("input[id^=<%=spokenLanguageOptions.ClientID %>]");
        var spokenLangChecked = false;
        if($(chkGroupSpokenLang[0]).attr('checked') == 'checked'){
            spokenLangChecked = true;
        }

        var chkGroupProficientLang = $("input[id^=<%=writtenLanguageOptions.ClientID %>]");
        var prLangChecked = false;
        if($(chkGroupProficientLang[0]).attr('checked') == 'checked'){
            prLangChecked = true;
        }

        var accQuestion = $("#<%=accompanyQuestion.ClientID %> input:checked").val();
        var accQuestionSel = false;
        if(accQuestion == '0'){
            accQuestionSel = true;
        }

        var toShowPopup = false;
        if(ageFactor == true && (spokenLangChecked == false || prLangChecked == false) && accQuestionSel == true){
            toShowPopup = true;
        }

        if(toShowPopup == true){
            alert('Applicant is potentially a \"Selected Customer\" where he/she has met 2 out of these 3 criteria:\n1. Aged 62 and above;\n2. Not proficient in spoken or written English\n3. Attained academic qualifications which are below GCE \'O\' level, \'N\' level certifications \nWould the applicant like to have a Trusted Individual present?');
        }
    }
      
 </script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<div id="chassis_outer_container">
<div class="chassis_page_container">
    <FNAMenutag:FNAMenu runat="server" ID="menu1" />
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
                <li class="chassis_application_navigation_selected_tab2">
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
                <asp:Label ID="lblPersonalDetailSuccess" runat="server" class="chassis_application_save_success"
                    Text="• Personal Details saved successfully" Visible = "false"></asp:Label>
                <asp:Label ID="lblPersonalDetailFailed" runat="server" class="chassis_application_feedback_error"
                    Text="• Failed to save Personal Details" Visible = "false"></asp:Label>
                <asp:Label ID="lblStatusSubmitted" runat="server" class="chassis_application_save_success"
                    Text="• Case Status submitted successfully" Visible = "false"></asp:Label>
                <asp:Label ID="lblStatusSubmissionFailed" runat="server" class="chassis_application_feedback_error"
                    Text="• Failed to Submit Case Status" Visible = "false"></asp:Label>
                <asp:Label ID="casestatuslbl" runat="server" class="chassis_application_save_success"
                    Text="" Visible = "false"></asp:Label>                
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
    <div >
        <asp:validationsummary id="valSummary" runat="server" ShowMessageBox="false" />
    </div>
    <table class="chassis_four_column_list" summary="Adviser details">
    <thead>
        <tr>
            <td colspan="4">Personal Details</td>
        </tr>
     </thead>
     <tbody>
     <tr>
     <td colspan=4>
        <div >
            
       <span>
            <asp:CustomValidator id="CustomValidator" 
             runat="server" ControlToValidate="titleList" Display="None" ValidateEmptyText="True"
             ErrorMessage="Date of birth is invalid (dd/mm/yyyy expected)" ClientValidationFunction="validateAllFields"
             />
        </span>

        </div>
      
      </td>
     </tr>
        <tr>
        <td class="chassis_label_column"><label>Title</label></td>
        <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox ID="titleList" CssClass="chassis_application_medium_text_box" runat="server" BackColor="#E0E0E0"></asp:TextBox>
            <span id="titleOthersDiv" style="">&nbsp; Others&nbsp;<asp:TextBox CssClass="chassis_application_medium_text_box"  ID="titleOthers" runat="server"></asp:TextBox></span>
        </td>
        <td class="chassis_label_column"><label>Given Name</label></td>
        <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox ID="name" CssClass="chassis_application_medium_text_box" runat="server" BackColor="#E0E0E0"></asp:TextBox>
        </td>
        </tr>

        
         <tr>
         <td class="chassis_label_column"><label>Gender</label></td>
          <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="genderList" runat="server" BackColor="#E0E0E0"></asp:TextBox>
        </td>
        <td class="chassis_label_column"><label>Surname</label></td>
        <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox ID="surname" CssClass="chassis_application_medium_text_box" runat="server" BackColor="#E0E0E0"></asp:TextBox>
        </td>
        </tr>
        
        <tr>
            <td class="chassis_label_column"><label>Nationality</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox CssClass="chassis_application_medium_text_box" ID="nationalityList" runat="server" BackColor="#E0E0E0"></asp:TextBox>
                <span id="nationality_span" style="">Others&nbsp;<asp:TextBox class="chassis_application_medium_text_box" ID="nationalityOthers" runat="server"></asp:TextBox></span>
            </td>
            <td class="chassis_label_column"><label>NRIC / Passport number</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox CssClass="chassis_application_medium_text_box" ID="nric" runat="server" BackColor="#E0E0E0"></asp:TextBox>     
            </td>
          </tr>
        
        <tr>
            <td class="chassis_label_column"><label>Marital status</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
             <asp:DropDownList CssClass="chassis_application_medium_select_list" ID="maritalList" runat="server">
                <asp:ListItem Value="">-Select-</asp:ListItem>
                <asp:ListItem Value="Single">Single</asp:ListItem>
                <asp:ListItem Value="Married">Married</asp:ListItem>
                <asp:ListItem Value="Separated">Separated</asp:ListItem>
                <asp:ListItem Value="Divorced">Divorced</asp:ListItem>
                <asp:ListItem Value="Widowed">Widowed</asp:ListItem>
            </asp:DropDownList>
            </td>
            <td class="chassis_label_column"><label>Date of Birth(DD/MM/YYYY)</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox CssClass="chassis_application_medium_text_box" ID="datepicker" runat="server" BackColor="#E0E0E0"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td class="chassis_label_column"><label>Residential Address</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox TextMode="MultiLine" Width="300px" Height="40px" ID="address" runat="server"></asp:TextBox>
            </td>
            <td class="chassis_label_column"><label>Smoker</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="smokerList" runat="server" BackColor="#E0E0E0"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td class="chassis_label_column"><label>Occupation</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox TextMode="MultiLine" ID="occupation" runat="server" Width="300px" Height="30px" BackColor="#E0E0E0"></asp:TextBox>
            </td>
            <td class="chassis_label_column"><label>Employment Status</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:DropDownList CssClass="chassis_application_medium_select_list" ID="employmentList" runat="server">
                    <asp:ListItem Value="">-Select-</asp:ListItem>
                    <asp:ListItem Value="Full time">Full time</asp:ListItem>
                    <asp:ListItem Value="Self employed">Self employed</asp:ListItem>
                    <asp:ListItem Value="Part time">Part time</asp:ListItem>
                    <asp:ListItem Value="Not employed">Not employed</asp:ListItem>
            </asp:DropDownList>
            </td>
        </tr>
        
        <tr>
        <td class="chassis_label_column" valign="top"><label>Contact Number</label> </td>
        <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="contactNumber" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox> (Home)<br /> 
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="contactNumberOffice" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox> (Office)<br /> 
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="contactNumberHp" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox> (Hp)<br /> 
            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="contactNumberFax" runat="server" OnKeyPress = "javascript:allowOnlyNumbers()"></asp:TextBox> (Fax)
        </td>
        <td class="chassis_label_column"><label>Company Name</label> </td>
        <td class="chassis_data_column chassis_no_padding_right">
            <asp:TextBox TextMode="MultiLine" Width="200px" Height="30px" ID="companyName" runat="server"></asp:TextBox>
        </td>
        </tr>
    
        <tr>
            <td class="chassis_label_column"><label>Highest Educational level</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
            <asp:DropDownList CssClass="chassis_application_medium_select_list" ID="educationList" runat="server">
                <asp:ListItem Value="">-Select-</asp:ListItem>
                <asp:ListItem Value="Primary">Primary</asp:ListItem>
                <asp:ListItem Value="Secondary">Secondary</asp:ListItem>
                <asp:ListItem Value="Pre-U/JC">Pre-U/JC</asp:ListItem>
                <asp:ListItem Value="Diploma">Diploma</asp:ListItem>
                <asp:ListItem Value="Degree">Degree</asp:ListItem>
                <asp:ListItem Value="Post Graduate">Post Graduate</asp:ListItem>
            </asp:DropDownList>
            </td>
            <td class="chassis_label_column"><label>Email Address</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
                <asp:TextBox CssClass="chassis_application_large_text_box" ID="emailId" runat="server"></asp:TextBox>
            </td>
        </tr>
        
         <tr>
        <td class="chassis_label_column"><label>Do you have a nominee for your CPF monies ?</label></td>
        <td class="chassis_data_column chassis_no_padding_right">
        <asp:DropDownList CssClass="chassis_application_medium_select_list" ID="nomineeList" runat="server">
            <asp:ListItem Value="">-Select-</asp:ListItem>
            <asp:ListItem Value="No">No</asp:ListItem>
            <asp:ListItem Value="Yes">Yes</asp:ListItem>
        </asp:DropDownList>
        </td>
        <td class="chassis_label_column"><label>Do you have any medical condition that requires regular attention from doctor?</label></td>
            <td class="chassis_data_column chassis_no_padding_right">
            <asp:DropDownList CssClass="chassis_application_medium_select_list" ID="medicalList" runat="server">
                <asp:ListItem Value="">-Select-</asp:ListItem>
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Yes">Yes</asp:ListItem>
            </asp:DropDownList>
            </td>
        </tr>

        <tr>
        <td class="chassis_label_column"><label>Do you have a will ?</label></td>
        <td class="chassis_data_column chassis_no_padding_right">
        <asp:DropDownList ID="willList" runat="server" CssClass="chassis_application_medium_select_list">
            <asp:ListItem Value="">-Select-</asp:ListItem>
            <asp:ListItem Value="No">No</asp:ListItem>
            <asp:ListItem Value="Yes">Yes</asp:ListItem>
        </asp:DropDownList>
        </td>
        <td class="chassis_label_column" colspan="2">
            <span id="medicalListConditions">
            Details <br /><asp:TextBox TextMode="MultiLine" Width="450px" Height="100px"  ID="medicalConditions" runat="server"></asp:TextBox> 
            </span>
        </td>
        </tr>
        <tr>
        <td>&nbsp;</td><td></td></tr>
        <tr>
        <td colspan=4>
            <table class="chassis_two_column_list">
                <tr>
                    <td colspan="2">This information helps you to facilitate your planning for the financial needs of your dependants.  
                    Would you like your dependents(s) to be taken into consideration for the Needs Analysis and Recommendations(s)?
                    <asp:radiobuttonlist id="FamilyDetailsRequired" runat="server" class="chassis_radio" RepeatDirection = "Horizontal">
                        <asp:listitem id="AnswerYes" runat="server" value="1" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="AnswerNo" runat="server" value="0" Text = "&nbsp;No&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>
                    </td>
                </tr>
            </table>                    
            <table class="chassis_two_column_list" summary="Adviser details" id="familyDetailsHeading">
                <thead>
                    <tr>
                        <td colspan="2"><b>Details of my Family (e.g Spouse, Children, Parents) </b></td>
                    </tr>                    
                 </thead>
             </table>
        </td>
        </tr>        
        <tr>
            <td colspan=4>
            <fieldset id = "familyDetailsFieldSet">
            <legend><b>Family Details</b>&nbsp;<a href="#" id="familyDetailsPlus"><img alt="" style='width:15px;height:15px;' src="/_layouts/Zurich/images/add-icon.jpg" /></a></legend>
                <table id="familyDetails" width="100%">
                <tr class="table_header">
                    <td align="center">Name</td>
                    <td align="center">Relationship</td>
                    <td align="center">Date of birth(dd/mm/yyyy)</td>
                    <td align="center">Occupation</td>
                    <td align="center">Monthly Income</td>
                    <td align="center">No. of Years to Support*</td>
                </tr>

                <asp:Repeater ID="personalDetailsOtherRepeater" runat="server">
                    <ItemTemplate>
                        <tr id='familyDetailsRowId<%# Container.ItemIndex+1%>'>
                            <td align='center'>
                                <input type='text' value='<%# Eval("name") %>' style='width: 100px;'  id="membername-<%# Container.ItemIndex+1%>" name="membername-<%# Container.ItemIndex+1%>"/>
                            </td>
                            
                             <td align='center'>
                                
                                <select id="comboFamilyBox-<%# Container.ItemIndex+1%>" style="width: 100px;" onchange="$('input#memberrel-<%# Container.ItemIndex+1%>').val($(this).val());">
	                                <option></option>
                                    <option>Son</option>
	                                <option>Daughter</option>
                                    <option>Father</option>
	                                <option>Mother</option>
                                    <option>Husband</option>
                                    <option>Wife</option>
                                </select>
                                <input type='text' value='<%# Eval("relationship") %>' style='width: 85px;margin-left: -103px;height: 1.2em; border: 0;'   id="memberrel-<%# Container.ItemIndex+1%>" name="memberrel-<%# Container.ItemIndex+1%>" onblur="javascript:calcYearsOfSupport('memberrel-<%# Container.ItemIndex+1%>','datepicker-<%# Container.ItemIndex+1%>','memberyrssupport-<%# Container.ItemIndex+1%>')"/>
                            </td>

                            <td align='center'>
                                <input type='text' value='<%# Eval("dob") %>' style='width: 100px;' maxlength='10'  id="datepicker-<%# Container.ItemIndex+1%>" name="datepicker-<%# Container.ItemIndex+1%>"  onblur="javascript:calcYearsOfSupport('memberrel-<%# Container.ItemIndex+1%>','datepicker-<%# Container.ItemIndex+1%>','memberyrssupport-<%# Container.ItemIndex+1%>')" onkeypress = "javascript:allowOnlyNumbersForDates()"  onchange="javascript:calcYearsOfSupport('memberrel-<%# Container.ItemIndex+1%>','datepicker-<%# Container.ItemIndex+1%>','memberyrssupport-<%# Container.ItemIndex+1%>')" />
                            </td>

                             <td align='center'>
                                <input type='text' value='<%# Eval("occupation") %>' style='width: 100px;'  id="memberoccupation-<%# Container.ItemIndex+1%>" name="memberoccupation-<%# Container.ItemIndex+1%>" />
                            </td>

                             <td align='center'>
                                <input type='text' value='<%# Eval("monthlyIncome") %>' style='width: 100px;'  id="monthlyIncome-<%# Container.ItemIndex+1%>" name="monthlyIncome-<%# Container.ItemIndex+1%>" onkeypress = "javascript:allowOnlyNumbers()" />
                            </td>

                            <td align="center"> 
                                <input type='text'  value='<%# Eval("yrstosupport") %>' id="memberyrssupport-<%# Container.ItemIndex+1%>"  name="memberyrssupport-<%# Container.ItemIndex+1%>" onkeypress = "javascript:allowOnlyNumbers()"  style="width: 100px;" />&nbsp;&nbsp;<a onClick=DeleteRow('familyDetailsRowId<%# Container.ItemIndex+1%>')><img style='width:15px;height:15px;' src='/_layouts/Zurich/images/Content/delete-icon.png' /></a>
                            </td>
                            </tr>       
                    </ItemTemplate>
                </asp:Repeater>
                </table>
            </fieldset>
            </td>            
        </tr>
        <tr>
             <td colspan=4>
                <span style="font-size:xx-small;color:Gray;" id="noteSpan">
                    <b> * Years to Support </b> Son: to Age 25 |  Daughter: to Age 22 | Male: to Age 83 | Female: to Age 88  <br />
                         Based on financial planning practise, years to support for male and female are derived by adding 8 years to the average life expectancy age for male and female respectively.
                 </span>
             </td>
        </tr>
        <tr>
            <td colspan=4>
                <table class="chassis_two_column_list">
                <thead>
                    <tr>
                        <td colspan="2"><b>Language Proficiency </b></td>
                    </tr>                    
                 </thead>
               </table>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <table width="100%">
                    <tr>
                        <td width="10%">
                             Conversant in Spoken Language
                        </td>                        
                        <td width="40%">
                            <asp:CheckBoxList ID="spokenLanguageOptions" runat="server" RepeatDirection="Vertical">
                                <asp:ListItem Value="1" Text=" English" />
                                <asp:ListItem Value="2" Text=" Mandarin" />
                                <asp:ListItem Value="3" Text=" Malay" />
                                <asp:ListItem Value="4" Text=" Tamil" />
                                <asp:ListItem Value="5" Text=" Others"/>
                            </asp:CheckBoxList>
                        </td>
                        <td width="10%">                
                                Proficient in Written Language
                        </td>
                        <td width="40%">
                            <asp:CheckBoxList ID="writtenLanguageOptions" runat="server" RepeatDirection="Vertical">
                                <asp:ListItem Value="1" Text=" English" />
                                <asp:ListItem Value="2" Text=" Mandarin" />
                                <asp:ListItem Value="3" Text=" Malay" />
                                <asp:ListItem Value="4" Text=" Tamil" />
                                <asp:ListItem Value="5" Text=" Others"/>
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td></tr>
                    <tr>
                        <td width="10%"></td>
                        <td width="40%">&nbsp;&nbsp;<asp:TextBox ID="spokenLanguageOtherstxt" runat="server" class="usermessage" TextMode="MultiLine" Width="250px" Height="40px"/></td>
                        <td width="10%"></td>
                        <td width="40%">&nbsp;&nbsp;<asp:TextBox ID="writtenLanguageOtherstxt" runat="server" class="usermessage" TextMode="MultiLine" Width="250px" Height="40px"/></td>
                    </tr>
                </table>
            </td>
        </tr>        
        <tr>
            <td colspan=4>
                <table class="chassis_two_column_list">
                <thead>
                    <tr>
                        <td colspan="2"><b>Client's Accompaniment </b></td>
                    </tr>                    
                 </thead>
               </table>                
            </td>
        </tr>
        <tr>
            <td colspan=4 class="chassis_label_column">
                Would you like to be accompanied by a Trusted Individual? (If Yes, please complete the details below)<br />                
                    <asp:radiobuttonlist id="accompanyQuestion" runat="server" class="chassis_radio" RepeatDirection = "Horizontal">
                        <asp:listitem id="accompanyAnswerYes" runat="server" value="1" Text = "&nbsp;Yes&nbsp;&nbsp;"/>
                        <asp:listitem id="accompanyAnswerNo" runat="server" value="0" Text = "&nbsp;No&nbsp;&nbsp;"/>
                    </asp:radiobuttonlist>                    
            </td>
        </tr>
        <tr>
            <td colspan=4>
                <table border="0" cellpadding="0" cellspacing="0">            
                    <tr>
                        <td class="chassis_label_column">
                            <label id="lblTrustedIndividualName">Name of Trusted Individual</label>                            
                        </td>
                        <td class="chassis_data_column chassis_no_padding_right" >
                            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="TrustedIndividualName" runat="server" ></asp:TextBox>                                                            
                        </td>
                    </tr>  
                    <tr>
                        <td class="chassis_label_column"><label id="lblClientRelationship">Relationship to Client</label></td>
                        <td class="chassis_data_column chassis_no_padding_right" >
                            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="ClientRelationship" runat="server" ></asp:TextBox>                
                        </td>          
                    </tr>       
                    <tr>
                        <td class="chassis_label_column"><label id="lblNRICAccompany">NRIC No.</label></td>
                        <td class="chassis_data_column chassis_no_padding_right" >
                            <asp:TextBox CssClass="chassis_application_medium_text_box" ID="NRICAccompany" runat="server" ></asp:TextBox>                
                        </td>               
                    </tr>                                
                </table>
            </td>
        </tr>         
        <tr>
            <td colspan="4" >
                <span style="color:Gray;">
                    Note: It is recommended for you to be accompanied by a Trusted Individual if you belong to <b>two of the following profile:</b> (i) Attained academic qualifications which are below GCE 'O' level, 'N' level certifications (ii) Not conversant in spoken or written English (iii) Age 62 and above
                </span>
            </td>
        </tr>                 
     </tbody>
    </table>
<asp:HiddenField ID="membernumber" runat="server"  />
<asp:HiddenField ID="backToCase" runat="server"  />
<asp:HiddenField ID="activityId" runat="server"  />
    <table width="100%">
        <tr align="right">
            <td>
                <asp:Button ID="PrintButton" class="chassis_application_button_xxxlarge" runat="server" Text="Generate Pdf" OnClientClick="showNotification()" OnClick="printpg" />
                <asp:Button ID="Button3" class="chassis_application_button_medium" runat="server" Text="Previous" OnClientClick="showNotification()" OnClick="savePersonaldetailsAndBack" />
                <asp:Button ID="Button2" class="chassis_application_button_medium" runat="server" Text="Save" OnClientClick="showNotification()" OnClick="savePersonaldetails" />
                <asp:Button ID="Button1" class="chassis_application_button_medium" runat="server" Text="Next" OnClientClick="showNotification()" OnClick="savePersonaldetailsAndNext" />
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
