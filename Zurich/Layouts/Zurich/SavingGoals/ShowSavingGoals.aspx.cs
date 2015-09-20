using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;
using System.Data.Linq;
using DAO;
using DTO;
using ActivityStatusCheck;
using PDFGeneration;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI;
using Zurich.ControlTemplates.Zurich;

namespace Zurich.Layouts.Zurich.SavingGoals
{
    public partial class ShowSavingGoals : LayoutsPageBase
    {
        protected string caseid = "";
        protected List<savinggoal> savingGoal;
        protected assumption assmptn;
        protected SavingGoalsDAO savingGoalsDao = new SavingGoalsDAO();
        protected AssumptionDAO assumptionDao = new AssumptionDAO();
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";
        protected bool sendPdf = false;
        protected byte[] pdfData = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            assmptn = assumptionDao.getAssumptionById(2);

            activity = activityStatusDao.getActivity(6);
            ViewState["activity"] = activity;

            lblSavingGoalFailed.Visible = false;
            lblSavingGoalSuccess.Visible = false;
            lblStatusSubmissionFailed.Visible = false;
            lblStatusSubmitted.Visible = false;
            lblSavingGoalDelFailed.Visible = false;
            lblSavingGoalDelSuccess.Visible = false;

            int sgid = 0;
            if (savinggoalid.Value != null && savinggoalid.Value!="")
            {
                sgid = Int32.Parse(savinggoalid.Value);
            }

            ViewState["sgid"] = sgid;

            if (sgid != 0)
            {
                ViewState["casetype"] = "update";

                if (saveclicked.Value == "0" && addclicked.Value == "0" && delclicked.Value == "0")
                {
                    if (ViewState["caseid"] != null)
                    {
                        savingGoal = savingGoalsDao.getSavingGoal(ViewState["caseid"].ToString());
                    }

                    savinggoal displaysg = null;
                    if (savingGoal != null && savingGoal.Count > 0)
                    {
                        displaysg = savingGoal[0];
                        foreach (savinggoal s in savingGoal)
                        {
                            if (sgid == s.id)
                            {
                                displaysg = s;
                            }
                        }
                    }
                    populateSavingGoal(displaysg, assmptn, ViewState["caseid"].ToString());
                    saveclicked.Value = "1";
                }
                if (delclicked.Value == "1")
                {
                    deleteSavingGoal(sgid);
                }
                saveclicked.Value = "1";
            }
            else
            {
                ViewState["casetype"] = "new";
            }

            string cid = "";
            if (Session["fnacaseid"] != null)
            {
                cid = Session["fnacaseid"].ToString();
            }
            else if (ViewState["caseid"] != null)
            {
                cid = ViewState["caseid"].ToString();
            }

            if (cid != null && cid != "" && (saveclicked.Value == "0" || saveclicked.Value == "") && (addclicked.Value == "0" || addclicked.Value == "") && (delclicked.Value == "0" || delclicked.Value == ""))
            {
                savingGoal = savingGoalsDao.getSavingGoal(cid);

                savinggoal displaysg = null;
                if (savingGoal != null && savingGoal.Count > 0)
                {
                    displaysg = savingGoal[0];
                    if (displaysg.existingassetsgs != null)
                    {
                        ViewState["noofassets"] = displaysg.existingassetsgs.Count;
                        noofmembers.Value = displaysg.existingassetsgs.Count.ToString();
                    }
                }
                saveclicked.Value = "1";
            }

            if (addclicked.Value == "1")
            {
                refreshSavingGoal();
                //addclicked.Value = "0";
                saveclicked.Value = "1";
            }

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
                activityId.Value = caseid;

                string url = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                eaAssetLiability.Attributes.Add("onClick", url);

                url = "popitup('/_layouts/Zurich/IncomeExpensePopUp.aspx',900,1200);return false;";
                mvalueLink.Attributes.Add("onClick", url);

                url = "/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx?caseid=" + caseid;
                addsggoal.Attributes.Add("PostBackUrl", url);
                
                if (caseid != null)
                {
                    
                    caseidsg.Value = caseid;
                    
                    savingGoal = savingGoalsDao.getSavingGoal(caseid);
                    if (savingGoal != null && savingGoal.Count>0 && sgid!=0)
                    {
                        ViewState["casetype"] = "update";
                    }
                    else
                    {
                        ViewState["casetype"] = "new";
                    }

                    savinggoal displaysg = null;
                    if (savingGoal != null && savingGoal.Count > 0)
                    {
                        displaysg = savingGoal[0];
                        savinggoalid.Value = displaysg.id.ToString();
                    }
                    populateSavingGoal(displaysg, assmptn, caseid);

                    List<savinggoal> gridgoal = savingGoal;
                    foreach (savinggoal s in gridgoal)
                    {
                        double damtfv = 0;
                        double dmaturityval = 0;
                        double deattl = 0;

                        if (s.amtneededfv != null && s.amtneededfv != "")
                        {
                            damtfv = double.Parse(s.amtneededfv);
                        }
                        if (s.maturityvalue != null && s.maturityvalue != "")
                        {
                            dmaturityval = double.Parse(s.maturityvalue);
                        }
                        if (s.existingassetstotal != null && s.existingassetstotal != "")
                        {
                            deattl = double.Parse(s.existingassetstotal);
                        }

                        if (((dmaturityval + deattl) - damtfv) < 0)
                        {
                            s.total = "-" + s.total;
                        }
                    }
                    
                    existingsggrid.DataSource = gridgoal;
                    existingsggrid.DataBind();
                    
                }
            }
            existingAssets.Attributes.Add("readonly", "readonly");
            totalShortfallSurplus.Attributes.Add("readonly", "readonly");

            yrstoAccumulate.Attributes.Add("onblur", "tempCalculate();");
            futureValue.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");
            existingAssets.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");
            maturityValue.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");

            markStatusOnTab(caseid);
        }

        private void populateSavingGoal(savinggoal savingGoal, assumption assmptn, string caseid)
        {
            double shortfallSurplus = 0;

            savingGoalNeeded2.Selected = true;
            
            if (savingGoal != null)
            {
                savingGoalNeeded.SelectedValue = savingGoal.savingGoalNeeded.ToString();
                
                goal.Text = savingGoal.goal;
                yrstoAccumulate.Text = savingGoal.yrstoaccumulate;

                if(savingGoal.amtneededfv!=null && savingGoal.amtneededfv!="")
                {
                    futureValue.Text = savingGoal.amtneededfv;
                }
                else
                {
                    futureValue.Text = "0";
                }
                
                if(savingGoal.maturityvalue!=null && savingGoal.maturityvalue!="")
                {
                    maturityValue.Text = savingGoal.maturityvalue;
                }
                else
                {
                    maturityValue.Text = "0";
                }
                
                assetList.DataSource = savingGoal.existingassetsgs;
                assetList.DataBind();

                if (savingGoal.existingassetsgs != null)
                {
                    ViewState["noofassets"] = savingGoal.existingassetsgs.Count;

                    if (savingGoal.existingassetstotal != null && savingGoal.existingassetstotal != "")
                    {
                        existingAssets.Text = savingGoal.existingassetstotal;
                    }
                    else
                    {
                        existingAssets.Text = "0";
                    }

                }

                shortfallSurplus = (double.Parse(existingAssets.Text) + double.Parse(maturityValue.Text)) - double.Parse(futureValue.Text);
                totalShortfallSurplus.Text = Math.Abs(shortfallSurplus).ToString();

            }

            if (shortfallSurplus < 0)
            {
                ttlSS.Text = "Shortfall";
                ttlSS.Style.Add("color", "red");
            }
            else if (shortfallSurplus > 0)
            {
                ttlSS.Text = "Surplus";
                ttlSS.Style.Add("color", "black");
            }
            else
            {
                ttlSS.Text = "Shortfall / Surplus";
                ttlSS.Style.Add("color", "black");
            }

            activityId.Value = caseid;
            
        }

        private void refreshSavingGoal()
        {
            goal.Text = "";
            yrstoAccumulate.Text = "";

            futureValue.Text = "";
            maturityValue.Text = "";
            totalShortfallSurplus.Text = "";

            assetList.DataSource = null;
            assetList.DataBind();

            existingAssets.Text = "";

            ttlSS.Text = "Shortfall / Surplus";
            ttlSS.Style.Add("color", "black");

            savinggoalid.Value = "0";
            saveclicked.Value = "0";
            delclicked.Value = "0";

        }

        private void deleteSavingGoal(int sgid)
        {
            int status = 1;
            status = savingGoalsDao.deleteSavingGoals(sgid);

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            if (ViewState["caseid"] != null)
            {

                string casestatus = activityStatusCheck.getSavingGoalStatus(ViewState["caseid"].ToString());
                activityStatusDao.saveOrUpdateActivityStatus(ViewState["caseid"].ToString(), actv, casestatus);

                markStatusOnTab(ViewState["caseid"].ToString());

                savingGoal = savingGoalsDao.getSavingGoal(ViewState["caseid"].ToString());
            }

            savinggoal displaysg = null;
            if (savingGoal != null && savingGoal.Count > 0)
            {
                displaysg = savingGoal[0];
                savinggoalid.Value = displaysg.id.ToString();
            }
            populateSavingGoal(displaysg, assmptn, ViewState["caseid"].ToString());

            List<savinggoal> gridgoal = savingGoal;
            foreach (savinggoal s in gridgoal)
            {
                double damtfv = 0;
                double dmaturityval = 0;
                double deattl = 0;

                if (s.amtneededfv != null && s.amtneededfv != "")
                {
                    damtfv = double.Parse(s.amtneededfv);
                }
                if (s.maturityvalue != null && s.maturityvalue != "")
                {
                    dmaturityval = double.Parse(s.maturityvalue);
                }
                if (s.existingassetstotal != null && s.existingassetstotal != "")
                {
                    deattl = double.Parse(s.existingassetstotal);
                }

                if (((dmaturityval + deattl) - damtfv) < 0)
                {
                    s.total = "-" + s.total;
                }
            }

            existingsggrid.DataSource = gridgoal;
            existingsggrid.DataBind();

            if (status == 1)
            {
                lblSavingGoalDelSuccess.Visible = true;
            }
            else
            {
                lblSavingGoalDelFailed.Visible = true;
            }
            delclicked.Value = "0";
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
            submitSavingGoals(null, null);
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
            submitSavingGoals(null, null);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void submitToPreviousGoal(object sender, EventArgs e)
        {
            sendPdf = false;
            submitSavingGoals(null, null);
            string url = MenuResolution.getUrl("protectionGoalsMyNeeds");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx", data);*/
        }
        
        protected void submitSavingGoalsNext(object sender, EventArgs e)
        {
            sendPdf = false;
            submitSavingGoals(null, null);
            string url = MenuResolution.getUrl("retirementGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/RetirementGoals/ShowRetirementGoals.aspx", data);            */
        }

        protected void submitSavingGoals(object sender, EventArgs e)
        {
            savinggoal goals = new savinggoal();

            goals.savingGoalNeeded = Convert.ToInt16(savingGoalNeeded.SelectedValue);

            if (goals.savingGoalNeeded == 2)
            {
                goals.goal = goal.Text;
                goals.yrstoaccumulate = yrstoAccumulate.Text;
                goals.amtneededfv = futureValue.Text;
                goals.maturityvalue = maturityValue.Text;

                if (totalShortfallSurplus.Text != null && totalShortfallSurplus.Text != "")
                {
                    double ttl = double.Parse(totalShortfallSurplus.Text);
                    if (ttl < 0)
                    {
                        totalShortfallSurplus.Text = Math.Abs(ttl).ToString();
                    }
                }
                goals.total = totalShortfallSurplus.Text;

                goals.existingassetstotal = existingAssets.Text;
            }
            else if (goals.savingGoalNeeded == 1 || goals.savingGoalNeeded == 0)
            {
                goals.goal = "";
                goals.yrstoaccumulate = "0";
                goals.amtneededfv = "0";
                goals.maturityvalue = "0";
                goals.total = "0";
                goals.existingassetstotal = "0";
            }

            goals.deleted = false;
            
            string caseid = "";
            if (ViewState["caseid"] != null)
            {
                caseid = ViewState["caseid"].ToString();
                goals.caseid = caseid;
            }

            int noofea = 0;
            if (goals.savingGoalNeeded == 2)
            {
                if (noofmembers.Value != "")
                {
                    noofea = Int16.Parse(noofmembers.Value);
                }
            }

            EntitySet<existingassetsg> easgList = new EntitySet<existingassetsg>();
            if (noofea > 0)
            {
                for (int i = 1; i <= noofea; i++)
                {
                    existingassetsg easg = new existingassetsg();
                    easg.asset = Request.Form["pridesc-" + i];
                    easg.presentvalue = Request.Form["pri_" + i];
                    easg.percentpa = Request.Form["sec_" + i];

                    if ((Request.Form["pridesc-" + i] != null) && (Request.Form["pri_" + i] != null) && (Request.Form["sec_" + i]!=null))
                    {
                        easgList.Add(easg);
                    }

                }
                goals.existingassetsgs = easgList;
            }

            int sgid = 0;
            if (ViewState["sgid"] != null)
            {
                sgid = Int32.Parse(ViewState["sgid"].ToString());
            }

            
            if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "new")
            {
                goals = savingGoalsDao.saveSavingGoals(goals);
            }
            else if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "update")
            {
                goals = savingGoalsDao.updateSavingGoals(goals, sgid);
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string status = activityStatusCheck.getSavingGoalStatus(caseid);
            activityStatusDao.saveOrUpdateActivityStatus(caseid, actv, status);

            markStatusOnTab(caseid);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, url, sendPdf);
            
            /*if (st == 1)
            {
                lblStatusSubmitted.Visible = false;
            }
            else
            {
                lblStatusSubmissionFailed.Visible = true;
            }*/

            if (goals != null)
            {
                lblSavingGoalSuccess.Visible = true;

                savingGoal = savingGoalsDao.getSavingGoal(caseid);

                savinggoal displaysg = null;
                if (savingGoal != null && savingGoal.Count > 0)
                {
                    if (addandsave.Value == "1")
                    {
                        displaysg = savingGoal[savingGoal.Count-1];
                    }
                    else
                    {
                        bool found = false;
                        int count = 0;
                        foreach (savinggoal sgl in savingGoal)
                        {
                            if (sgid == sgl.id)
                            {
                                found = true;
                                break;
                            }
                            count++;
                        }

                        if (found)
                        {
                            displaysg = savingGoal[count];
                        }
                        else
                        {
                            displaysg = savingGoal[0];
                        }
                    }
                    
                    savinggoalid.Value = displaysg.id.ToString();
                    addandsave.Value = "";
                }
                populateSavingGoal(displaysg, assmptn, caseid);

                List<savinggoal> gridgoal = savingGoal;
                foreach (savinggoal s in gridgoal)
                {
                    double damtfv = 0;
                    double dmaturityval = 0;
                    double deattl = 0;

                    if (s.amtneededfv != null && s.amtneededfv != "")
                    {
                        damtfv = double.Parse(s.amtneededfv);
                    }
                    if (s.maturityvalue != null && s.maturityvalue != "")
                    {
                        dmaturityval = double.Parse(s.maturityvalue);
                    }
                    if (s.existingassetstotal != null && s.existingassetstotal != "")
                    {
                        deattl = double.Parse(s.existingassetstotal);
                    }

                    if (((dmaturityval + deattl) - damtfv) < 0)
                    {
                        s.total = "-" + s.total;
                    }
                }
                
                //existingsggrid.DataSource = savingGoal;
                existingsggrid.DataSource = gridgoal;
                existingsggrid.DataBind();

                //refreshSavingGoal();
            }
            else
            {
                lblSavingGoalFailed.Visible = true;
            }

        }

        protected void createSavingGoalsPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseid"] != null)
            {
                caseId = ViewState["caseid"].ToString();
            }

            sendPdf = true;
            submitSavingGoals(null, null);

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
            
            submitSavingGoals(null, null);

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
