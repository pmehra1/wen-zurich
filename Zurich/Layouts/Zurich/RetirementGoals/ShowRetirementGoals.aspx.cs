using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;
using System.Data.Linq;
using DAO;
using DTO;
using PDFGeneration;
using ActivityStatusCheck;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;

namespace Zurich.Layouts.Zurich.RetirementGoals
{
    public partial class ShowRetirementGoals : LayoutsPageBase
    {
        protected string caseid = "";
        protected retirementgoal retirementGoalSelf;
        protected assumption inflationAdjustedReturnAsmptn;
        protected assumption annualInflationReturn;
        protected RetirementGoalsDAO retirementGoalsDao = new RetirementGoalsDAO();
        protected AssumptionDAO assumptionDao = new AssumptionDAO();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected string activity = "";
        protected bool sendPdf = false;
        protected byte[] pdfData = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            inflationAdjustedReturnAsmptn = assumptionDao.getAssumptionById(4);
            annualInflationReturn = assumptionDao.getAssumptionById(1);
            
            activity = activityStatusDao.getActivity(7);
            ViewState["activity"] = activity;

            if (!IsPostBack)
            {
                /*string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];

                if (nextCaseId != null && nextCaseId != "")
                {
                    caseid = nextCaseId;
                }

                if (menuCaseId != null && menuCaseId != "")
                {
                    caseid = menuCaseId;
                }*/
                if (Session["fnacaseid"] != null)
                {
                    caseid = Session["fnacaseid"].ToString();
                }

                ViewState["caseid"] = caseid;

                string url = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                eaAssetLiability.Attributes.Add("onClick", url);

                url = "popitup('/_layouts/Zurich/IncomeExpensePopUp.aspx',900,1200);return false;";
                mvalueLink.Attributes.Add("onClick", url);

                if (caseid != null)
                {
                    ViewState["caseid"] = caseid;
                    caseidrg.Value = caseid;

                    retirementGoalSelf = retirementGoalsDao.getRetirementGoal(caseid, "self");
                    
                    if (retirementGoalSelf == null)
                    {
                        retirementGoalSelf = new retirementgoal();
                    }

                    populateRetirementGoal(retirementGoalSelf, inflationAdjustedReturnAsmptn, annualInflationReturn, caseid);
                }
            }

            intendedRetirementAge.Attributes.Add("onblur", "calculateAmountNeededFutureValue('intendedra')");

            incomeRequiredUponRetirement.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            yearsToRetirement.Attributes.Add("onblur", "tempCalculate1()");

            annualInflationRate.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            futureIncomeNeeded.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            sourcesOfIncome.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            totalFirstYearIncomeNeeded.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            inflationAdjustedReturn.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            durationOfRetirement.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            lumpSumRequiredAtRetirement.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            existingAssets2.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            maturityValue2.Attributes.Add("onblur", "calculateAmountNeededFutureValue('')");

            futureIncomeNeeded.Attributes.Add("readonly", "readonly");

            totalFirstYearIncomeNeeded.Attributes.Add("readonly", "readonly");

            lumpSumRequiredAtRetirement.Attributes.Add("readonly", "readonly");

            totalShortfallSurplus2.Attributes.Add("readonly", "readonly");

            existingAssets2.Attributes.Add("readonly", "readonly");

            yearsToRetirement.Attributes.Add("readonly", "readonly");

            markStatusOnTab(caseid);

        }

        private void populateRetirementGoal(retirementgoal retirementGoalSelf, assumption inflationAdjustedReturnAsmptn, assumption annualInflationReturn, string caseid)
        {
            double shortfallSurplusSelf = 0;
            int iIntendedRetirementAge = 0;

            PersonalDetailsDAO dao = new PersonalDetailsDAO();
            personaldetail detail = dao.getPersonalDetail(caseid);

            int yrDob = 0;
            int currentYr = DateTime.Now.Year;
            int agePolicyOwner = 0;
            int iYrstoRetirement = 0;

            try
            {
                DateTime dt2 = DateTime.ParseExact(detail.datepicker, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                yrDob = dt2.Year;

                if (DateTime.Now.Month < dt2.Month)
                {
                    agePolicyOwner = currentYr - yrDob - 1;
                }
                else if (DateTime.Now.Month > dt2.Month)
                {
                    agePolicyOwner = currentYr - yrDob;
                }
                else
                {
                    if (DateTime.Now.Day < dt2.Day)
                    {
                        agePolicyOwner = currentYr - yrDob - 1;
                    }
                    else if ((DateTime.Now.Day > dt2.Day) || (DateTime.Now.Day == dt2.Day))
                    {
                        agePolicyOwner = currentYr - yrDob;
                    }
                }

                iYrstoRetirement = iIntendedRetirementAge - agePolicyOwner;
            }
            catch (Exception e)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = e.Message + " class: ShowRetirementGoals Method: populateRetirementGoal setting yrs to retirement";
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                activityStatusDao.logException(exLog);
            }
            pownerdob.Value = agePolicyOwner.ToString();

            if (detail != null)
            {
                pownergender.Value = detail.gender;
            }

            IncomeExpenseDAO iedao = new IncomeExpenseDAO();
            incomeExpense iedetail = iedao.getIncomeExpenseForCase(caseid);

            retirementGoalNeeded2.Selected = true;
            
            //populate self retirement goals
            if (retirementGoalSelf != null)
            {
                retirementGoalNeeded.SelectedValue = retirementGoalSelf.retirementGoalNeeded.ToString();
                
                if (retirementGoalSelf.intendedretirementage != null && retirementGoalSelf.intendedretirementage != "")
                {
                    intendedRetirementAge.Text = retirementGoalSelf.intendedretirementage;
                }
                else
                {
                    intendedRetirementAge.Text = "62";
                }
                iIntendedRetirementAge = Int32.Parse(intendedRetirementAge.Text);

                //expectedRetirementAgelbl.Text = intendedRetirementAge.Text;

                if (retirementGoalSelf.incomerequired != null && retirementGoalSelf.incomerequired != "")
                {
                    incomeRequiredUponRetirement.Text = retirementGoalSelf.incomerequired;
                }
                else
                {
                    double dincomeReq = 0;
                    if (iedetail!=null && iedetail.netMonthlyIncomeAfterCpf != null && iedetail.netMonthlyIncomeAfterCpf != "")
                    {
                        dincomeReq = 0.7 * 12 * double.Parse(iedetail.netMonthlyIncomeAfterCpf);
                    }

                    incomeRequiredUponRetirement.Text = Math.Round(dincomeReq, 2).ToString();
                }

                //presentIncomeNeededlbl.Text = incomeRequiredUponRetirement.Text;

                if (retirementGoalSelf.yrstoretirement != null && retirementGoalSelf.yrstoretirement != "")
                {
                    yearsToRetirement.Text = retirementGoalSelf.yrstoretirement;
                }
                else
                {
                    yearsToRetirement.Text = iYrstoRetirement.ToString();
                }

                //currentAgelbl.Text = (double.Parse(intendedRetirementAge.Text) - double.Parse(yearsToRetirement.Text)).ToString();

                if (retirementGoalSelf.inflationrate == null || retirementGoalSelf.inflationrate == "")
                {
                    if (annualInflationReturn != null)
                    {
                        annualInflationRate.Text = annualInflationReturn.percentage.Value.ToString();
                    }
                    else
                    {
                        annualInflationRate.Text = "0";
                    }
                }
                else
                {
                    annualInflationRate.Text = retirementGoalSelf.inflationrate;
                }

                //inflationRatelbl.Text = annualInflationRate.Text;

                if (retirementGoalSelf.futureincome != null && retirementGoalSelf.futureincome != "")
                {
                    futureIncomeNeeded.Text = retirementGoalSelf.futureincome;
                }
                else
                {
                    futureIncomeNeeded.Text = "0";
                }

                //futureIncomeNeededChartlbl.Text = futureIncomeNeeded.Text;

                if (retirementGoalSelf.sourcesofincome != null && retirementGoalSelf.sourcesofincome != "")
                {
                    sourcesOfIncome.Text = retirementGoalSelf.sourcesofincome;
                }
                else
                {
                    sourcesOfIncome.Text = "0";
                }

                if (retirementGoalSelf.totalfirstyrincome != null && retirementGoalSelf.totalfirstyrincome != "")
                {
                    totalFirstYearIncomeNeeded.Text = retirementGoalSelf.totalfirstyrincome;
                }
                else
                {
                    totalFirstYearIncomeNeeded.Text = "0";
                }

                //annualAmountlbl.Text = totalFirstYearIncomeNeeded.Text;

                if (retirementGoalSelf.inflationreturnrate == null || retirementGoalSelf.inflationreturnrate == "")
                {
                    if (inflationAdjustedReturnAsmptn != null)
                    {
                        inflationAdjustedReturn.Text = inflationAdjustedReturnAsmptn.percentage.Value.ToString();
                    }
                    else
                    {
                        inflationAdjustedReturn.Text = "0";
                    }
                }
                else
                {
                    inflationAdjustedReturn.Text = retirementGoalSelf.inflationreturnrate;
                }

                //inflationAdjustedReturnslbl.Text = inflationAdjustedReturn.Text;

                if (retirementGoalSelf.durationretirement != null && retirementGoalSelf.durationretirement != "")
                {
                    durationOfRetirement.Text = retirementGoalSelf.durationretirement;
                }
                else
                {
                    int iDurationofRetirement = 0;
                    
                    if (detail.gender == "Male")
                    {
                        iDurationofRetirement = 83 - iIntendedRetirementAge;
                    }
                    else if (detail.gender == "Female")
                    {
                        iDurationofRetirement = 88 - iIntendedRetirementAge;
                    }

                    durationOfRetirement.Text = iDurationofRetirement.ToString();
                }

                //durationOfRetirementValuelbl.Text = durationOfRetirement.Text;
                //ageAtEndOfRetirementlbl.Text = (double.Parse(durationOfRetirement.Text) + double.Parse(intendedRetirementAge.Text)).ToString();

                if (retirementGoalSelf.lumpsumrequired != null && retirementGoalSelf.lumpsumrequired != "")
                {
                    lumpSumRequiredAtRetirement.Text = retirementGoalSelf.lumpsumrequired;
                }
                else
                {
                    lumpSumRequiredAtRetirement.Text = "0";
                }

                if (retirementGoalSelf.maturityvalue != null && retirementGoalSelf.maturityvalue != "")
                {
                    maturityValue2.Text = retirementGoalSelf.maturityvalue;
                }
                else
                {
                    maturityValue2.Text = "0";
                }

                assetListSelf.DataSource = retirementGoalSelf.existingassetrgs;
                assetListSelf.DataBind();
                
                if (retirementGoalSelf.existingassetrgs != null)
                {
                    ViewState["noofassets"] = retirementGoalSelf.existingassetrgs.Count;
                    if (retirementGoalSelf.existingassetstotal != null && retirementGoalSelf.existingassetstotal != "")
                    existingAssets2.Text = retirementGoalSelf.existingassetstotal;
                    else
                        existingAssets2.Text = "0";

                }

                shortfallSurplusSelf = double.Parse(existingAssets2.Text) + double.Parse(maturityValue2.Text) - double.Parse(lumpSumRequiredAtRetirement.Text);
                if (shortfallSurplusSelf < 0)
                {
                    ttlSSSelf.Text = "Shortfall";
                    ttlSSSelf.Style.Add("color", "red");
                }
                else if (shortfallSurplusSelf > 0)
                {
                    ttlSSSelf.Text = "Surplus";
                    ttlSSSelf.Style.Add("color", "black");
                }
                else
                {
                    ttlSSSelf.Text = "Total (Shortfall / Surplus)";
                    ttlSSSelf.Style.Add("color", "black");
                }

                totalShortfallSurplus2.Text = Math.Abs(shortfallSurplusSelf).ToString();
            }

            
            activityId.Value = caseid;

        }

        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);

            FNAMenu menu = (FNAMenu)this.FNAMenu1;

            menu.EventClick += new EventHandler(WebForm_EventClick);
        }

        private void WebForm_EventClick(object sender, EventArgs e)
        {
            SampleEvent even = (SampleEvent)e;
            string toLink = "";
            if (even != null)
                toLink = even.toLink;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            submitRetirementGoals(null, null);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            submitRetirementGoals(null, null);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void submitRetirementGoalsPrevious(object sender, EventArgs e)
        {
            sendPdf = false;
            submitRetirementGoals(null, null);
            string url = MenuResolution.getUrl("savingGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx", data);*/
        }
        
        protected void submitRetirementGoalsNext(object sender, EventArgs e)
        {
            sendPdf = false;
            submitRetirementGoals(null, null);
            string url = MenuResolution.getUrl("educationGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/EducationGoals/ShowEducationGoals.aspx", data);*/
        }

        protected void submitRetirementGoals(object sender, EventArgs e)
        {
            //File.AppendAllText(@"C:\ZurichLogs\logs.txt", "\n inside submitSavingGoals code behind");

            retirementgoal goalsSelf = new retirementgoal();

            string caseid = "";
            if (ViewState["caseid"] != null)
            {
                caseid = ViewState["caseid"].ToString();
                goalsSelf.caseid = caseid;
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string caseType = "";
            retirementGoalSelf = retirementGoalsDao.getRetirementGoal(caseid, "self");

            if (retirementGoalSelf != null)
            {
                caseType = "update";
            }
            else
            {
                caseType = "new";
            }

            goalsSelf.retirementGoalNeeded = Convert.ToInt32(retirementGoalNeeded.SelectedValue);

            if (goalsSelf.retirementGoalNeeded == 2)
            {
                goalsSelf.durationretirement = durationOfRetirement.Text;
                goalsSelf.futureincome = futureIncomeNeeded.Text;
                goalsSelf.incomerequired = incomeRequiredUponRetirement.Text;
                goalsSelf.intendedretirementage = intendedRetirementAge.Text;
                goalsSelf.lumpsumrequired = lumpSumRequiredAtRetirement.Text;
                goalsSelf.maturityvalue = maturityValue2.Text;
                goalsSelf.selforspouse = "self";
                goalsSelf.sourcesofincome = sourcesOfIncome.Text;

                if (totalShortfallSurplus2.Text != null && totalShortfallSurplus2.Text != "")
                {
                    double ttl = double.Parse(totalShortfallSurplus2.Text);
                    if (ttl < 0)
                    {
                        totalShortfallSurplus2.Text = Math.Abs(ttl).ToString();
                    }
                }
                goalsSelf.total = totalShortfallSurplus2.Text;

                goalsSelf.totalfirstyrincome = totalFirstYearIncomeNeeded.Text;
                goalsSelf.yrstoretirement = yearsToRetirement.Text;
                goalsSelf.existingassetstotal = existingAssets2.Text;
                goalsSelf.inflationrate = annualInflationRate.Text;
                goalsSelf.inflationreturnrate = inflationAdjustedReturn.Text;
            }
            else if (goalsSelf.retirementGoalNeeded == 1 || goalsSelf.retirementGoalNeeded == 0)
            {
                goalsSelf.durationretirement = "0";
                goalsSelf.futureincome = "0";
                goalsSelf.incomerequired = "0";
                goalsSelf.intendedretirementage = "0";
                goalsSelf.lumpsumrequired = "0";
                goalsSelf.maturityvalue = "0";
                goalsSelf.selforspouse = "self";
                goalsSelf.sourcesofincome = "0";
                goalsSelf.total = "0";
                goalsSelf.totalfirstyrincome = "0";
                goalsSelf.yrstoretirement = "0";
                goalsSelf.existingassetstotal = "0";
                goalsSelf.inflationrate = "0";
                goalsSelf.inflationreturnrate = "0";
            }
            
            int noofeaself = 0;
            if (goalsSelf.retirementGoalNeeded == 2)
            {
                if (noofmembers.Value != "")
                {
                    noofeaself = Int16.Parse(noofmembers.Value);
                }
            }

            EntitySet<existingassetrg> eargSelfList = new EntitySet<existingassetrg>();
            if (noofeaself > 0)
            {
                for (int i = 1; i <= noofeaself; i++)
                {
                    existingassetrg easg = new existingassetrg();
                    easg.asset = Request.Form["pridesc-" + i];
                    easg.presentvalue = Request.Form["pri_" + i];
                    easg.percentpa = Request.Form["sec_" + i];

                    if ((Request.Form["pridesc-" + i] != null) && (Request.Form["pri_" + i] != null) && (Request.Form["sec_" + i] != null))
                    {
                        eargSelfList.Add(easg);
                    }

                }
                goalsSelf.existingassetrgs = eargSelfList;
            }

            if (caseType == "new")
            {
                goalsSelf = retirementGoalsDao.saveRetirementGoals(goalsSelf);
            }
            else if (caseType == "update")
            {
                goalsSelf = retirementGoalsDao.updateRetirementGoals(goalsSelf);
            }

            string status = activityStatusCheck.getRetirementGoalStatus(goalsSelf);
            activityStatusDao.saveOrUpdateActivityStatus(caseid, actv, status);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, url, sendPdf);

            markStatusOnTab(caseid);

            
            /*if (st == 1)
            {
                lblStatusSubmitted.Visible = false;
            }
            else
            {
                lblStatusSubmissionFailed.Visible = true;
            }*/

            if (goalsSelf != null)
            {
                lblRetirementGoalSuccess.Visible = true;
                populateRetirementGoal(goalsSelf, inflationAdjustedReturnAsmptn, annualInflationReturn, caseid);
            }
            else
            {
                lblRetirementGoalFailed.Visible = true;
            }
        }

        protected void createRetirementGoalsPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseid"] != null)
            {
                caseId = ViewState["caseid"].ToString();
            }

            sendPdf = true;
            submitRetirementGoals(null, null);

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
            
        }

        protected void redirectToCasePortal(object sender, EventArgs e)
        {
            string salesPortalRedirectUrl = "";
            string caseid = "";

            if (ViewState["caseid"] != null)
            {
                caseid = ViewState["caseid"].ToString();
            }

            string toPrintPdf = backToCase.Value;

            if (toPrintPdf == "true")
            {
                sendPdf = true;
            }
            else
            {
                sendPdf = false;
            }
            
            submitRetirementGoals(null, null);
            
            salesportalinfo salesPortalInfo = activityStatusDao.getSalesPortalInfoForCaseid(caseid);
            if (salesPortalInfo != null)
            {
                salesPortalRedirectUrl = salesPortalInfo.salesportalurl;
            }

            Response.Redirect(salesPortalRedirectUrl);
        }

        protected void markStatusOnTab(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatussg = null;
                activitystatus activityStatusrg = null;
                activitystatus activityStatuseg = null;

                activityStatussg = activityStatusDao.getActivityForCaseid(caseid, "savinggoal");
                if (activityStatussg != null)
                {
                    if (activityStatussg.status == "incomplete")
                    {
                        savinggoaltab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        savinggoaltab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusrg = activityStatusDao.getActivityForCaseid(caseid, "retirementgoal");
                if (activityStatusrg != null)
                {
                    if (activityStatusrg.status == "incomplete")
                    {
                        retirementgoaltab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        retirementgoaltab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatuseg = activityStatusDao.getActivityForCaseid(caseid, "educationgoal");
                if (activityStatuseg != null)
                {
                    if (activityStatuseg.status == "incomplete")
                    {
                        educationgoaltab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        educationgoaltab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }


            }

        }

    }
}
