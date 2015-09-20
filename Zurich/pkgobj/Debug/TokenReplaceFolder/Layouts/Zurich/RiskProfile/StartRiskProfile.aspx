<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcBasicWalkthrough.Models.RiskProfile>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Risk Profiling Questionnaire
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form1" runat="server" method="post" >
<%= Html.Hidden("printpage") %>
<table width=100%>
    <tr width=100%>
        <td width=100%>
            <div class="user_panel">
            <table width=100%>
                <tr width=100%>
                    <td width=30%>Risk Profile</td>
                    <td align=left><font color='green'><b><%=ViewData["successMessage"]%></b></font>
                     </td>
                </tr>
            </table>
        </div>
        </td>
    </tr>
    

    <tr>
        <td width=60%></td><td width=40%/>
    </tr>
<!--    <tr>
        <td width=40%><font color='green'><b><%=ViewData["profileName"]%></b></font></td><td/>
    </tr>
-->
    
</table>
<div id="Div2" align="center">
    
</div>
<div id="tabvanilla" class="widget">

            <ul class="tabnav">
                <li><a href="#sectionA">Section A: Measuring Risk Appetite</a></li>
                <li><a href="#sectionB">Section B: Measuring Risk Taking Ability</a></li>
                <li><a href="#sectionC">Section C: Edit Risk Profile</a></li>
            </ul>

            <div id="sectionA" class="tabdiv">
                
                <b>Risk Profiling Questionnaire</b>
                <br /><br />

                <u><b>Question 1</b></u>
                <br />
                The graph below shows the hypothetical results of 5 sample portfolios over a one-year period. The <br />
                potential gains and losses of each portfolio are presented.

                <table>
                    <tr>
                        <td>
                            <img src="../../Content/RiskProfileChart.png" alt="Risk Profile Static Chart"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            * The return ranges are for illustration only
                        </td>
                    </tr>
                </table>
                
                <table width=100%>
                    <tr>
                        <td colspan=2>Which portfolio would you prefer to hold?</td>
                    </tr>
                    <tr>
                        <td width=60%>
                            a)	None of the above, because I cannot accept any loss of my capital
                        </td>
                        <td width=40%>
                            <%= Html.RadioButton("riskApetiteQuestion1", "-16")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	Portfolio A – Cautious
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion1", "-3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	Portfolio B – Moderately Cautious
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion1", "2")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	Portfolio D – Moderately Adventurous
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion1", "8")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            e)	Portfolio D – Moderately Adventurous
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion1", "12")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            f)	Portfolio E – Adventurous
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion1", "16")%> 
                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <u><b>Question 2</b></u>
                            <br />
                            What would you do if your long term investment drops by more than 20% over a short period of time?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	Sell the whole investment – I wouldn’t want to lose any more money
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("riskApetiteQuestion2", "1")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	Sell part of the investment – it could go back up, but I don’t want to risk everything just in case it doesn’t 
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion2", "2")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	Hold the investment – it’s likely that it will increase in value again soon
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion2", "4")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	Hold the investment and buy more while the value is low – when the value goes up, I’ll make a good return
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion2", "5")%> 
                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <u><b>Question 3</b></u>
                            <br />
                            What is the riskiest asset that you would consider investing in the future?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	Savings account, time deposits and money market instruments
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("riskApetiteQuestion3", "-4")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	Bonds and bond funds 
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion3", "1")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	Stocks and equity mutual funds
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion3", "4")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	Non-guaranteed structured products like equity linked notes
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion3", "5")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            e)	Options, futures, warrants
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion3", "6")%> 
                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <u><b>Question 4</b></u>
                            <br />
                            How would you describe your investment preference?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	I prefer an investment that has little fluctuations in value, i.e., an investment with minimal chance of losing money.
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("riskApetiteQuestion4", "1")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	I have a long-term investment focus and will ride out the good times and the bad times.
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion4", "3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	I actively trade investments in the short-term to take advantage of short-term market movements
                        </td>
                        <td>
                            <%= Html.RadioButton("riskApetiteQuestion4", "5")%> 
                        </td>
                    </tr>
                </table>

            </div><!--/popular-->

            <div id="sectionB" class="tabdiv">
                
                <b>Section B: Measuring Risk Taking Ability</b>
                <br /><br />
                
                <table width=100%>
                    <tr>
                        <td colspan=2>
                        <u><b>Question 5</b></u>
                        <br />
                        Which of the following statements most accurately describe your current situation?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	My income is lower than my on-going expenses.
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion1", "-3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	My income is approximately the same as my on-going expenses.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion1", "0")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	My income is higher (≤30%) than my on-going expenses.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion1", "3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	My income is significantly higher (>30%) than my on-going expenses.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion1", "5")%> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan=2>(On-going expenses exclude large one-time expense such as car purchase or home 
                        <br /> renovation expenses.)

                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>

                    <tr>
                        <td colspan=2>
                            <u><b>Question 6</b></u>
                            <br />
                            How many years are you away from your retirement?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	< 5 years or already retired
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion2", "0")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	5 – 10 years
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion2", "3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	> 10 years
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion2", "5")%> 
                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <u><b>Question 7</b></u>
                            <br />
                            Which of the following statement best describes your investment needs?
                        </td>
                    </tr>
                    <tr>
                        <td width=60%>
                            a)	I need my investments to provide high level of income while maintaining stable value <br />
                            as I rely on my investments to support my current financial needs.
                        </td>
                        <td width=40%>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion3", "0")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	I need my investments to provide high level of income with some capital growth to <br />
                            support my current and future financial needs.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion3", "2")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	I am more concerned to achieve long-term growth as I need my investments to provide for my future financial needs.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion3", "3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	I do not rely on my investments to provide for my financial needs. The performance <br />
                             of my investments will not affect my standard of living negatively
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion3", "5")%> 
                        </td>
                    </tr>
                    <tr height=20px>
                        <td colspan=2/>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <u><b>Question 8</b></u>
                            <br />
                            Is there a future financial need which will require you to liquidate more than 30% of your investments?
                        </td>
                    </tr>
                    <tr>
                        <td width=70%>
                            a)	Yes, the financial commitment will occur within the next 2 years.
                        </td>
                        <td width=30%>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion4", "0")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            b)	Yes, the financial commitment will occur within the next 2 to 5 years.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion4", "2")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            c)	Yes, the financial commitment will occur in more than 5 years’ time.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion4", "3")%> 
                        </td>
                    </tr>
                    <tr>
                        <td>
                            d)	No.
                        </td>
                        <td>
                            <%= Html.RadioButton("measuringRiskTakingAbilityQuestion4", "5")%> 
                        </td>
                    </tr>
                </table>



            </div><!--/recent-->

            <div id="sectionC" class="tabdiv">

            <table width=100%>
                <tr style="background-color:#DDDDDD;" >
                    <td>
                        <%=ViewData["profileName"]%>    
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width=100%>
                            <tr height=30px>
                                <td colspan=2 width/>
                            </tr>
                            
                            <tr id="AgreeWithRiskProfile">
                                <td width=40%>
                                    Do you agree with the above Risk Profile
                                </td>
                                <td>
                                <%= Html.RadioButton("agreeWithRiskProfile", "0")%> Yes
                                <%= Html.RadioButton("agreeWithRiskProfile", "1")%> No
                                </td>
                            </tr>
                            
                            <tr height=30px>
                                <td colspan="2" />
                            </tr>
                            
                            <tr id="NotAgreeWithRiskProfile">
                                <td>
                                    If no, please select your preferred risk profile
                                </td>
                                <td>
                                    <%=Html.DropDownList("riskProfileList", Model.riskProfiles, new { onchange = "changerpcalculated()" })%>
                                    <%= Html.Hidden("riskprofile") %>
                                </td>
                            </tr>
                            <tr height=100px>
                                <td colspan=2 />
                            </tr>
                            
                        </table>
                    </td>
                </tr>
            </table>
            </div>


        </div><!--/widget-->
<table width=100%>
    <tr width=100%>
        <td align=right>
            <input id="Button1" class="zurichbuttonLarge" type="button" value="Print" onclick="printpg()" />
            <input id="Button2" class="zurichbutton" type="button" value="Save" onclick="riskProfileSubmit()" />
            <% 
                if ((ViewData["profileName"]) != null)
                {   
                    %>
                        <input type="button" class="zurichbuttonVeryLarge" value="My Portfolio" onclick="return popitup('/RiskProfile/ShowPortfolioModel/<%=ViewData["profileName"]%>')"/>
                    <%
                }
            %>
        
        </td>
    
    </tr>

</table>
</form>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="/Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="/Scripts/jquery-ui-personalized-1.5.2.packed.js"></script>
    <link rel="stylesheet" type="text/css" href="/Scripts/css/stylesprinkle.css" />

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('#tabvanilla > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle'} });
            $("#NotAgreeWithRiskProfile").hide();
            $("input[name='agreeWithRiskProfile']").click(function () {

                if ($(this).attr('value') == 0) {
                    
                        $("#NotAgreeWithRiskProfile").hide();

                }
                else if ($(this).attr('value') == 1) {
                    var answer = confirm("The selected risk profile would overwrite the existing risk profile");
                    if (answer) {
                        
                        $("#NotAgreeWithRiskProfile").show();
                        $("#NotAgreeWithRiskProfile").slideDown("slow");
                        
                        
                        

                    }

                }
            });


        });
    </script>
    <script language="javascript" type="text/javascript">
        function popitup(url) {
            newwindow = window.open(url, 'name', 'height=900,width=1200');
            if (window.focus) { newwindow.focus() }
            return false;
        }

        function changerpcalculated() {
            document.getElementById('riskprofile').value = document.getElementById('riskProfileList')[document.getElementById('riskProfileList').selectedIndex].text;
        }

        function riskProfileSubmit() {
            document.getElementById('printpage').value = "false";
            document.getElementById('riskprofile').value = document.getElementById('riskProfileList')[document.getElementById('riskProfileList').selectedIndex].text;
            document.forms[0].submit();
        }

        function printpg() {
            
            document.getElementById('printpage').value = "true";
            document.forms[0].submit();
        }

    </script>


</asp:Content>

