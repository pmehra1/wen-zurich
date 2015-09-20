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
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;

namespace Zurich.Layouts.Zurich.EducationGoals
{
    public partial class ShowEducationGoals : LayoutsPageBase
    {
        protected string caseid = "";
        protected List<educationgoal> educationGoal;
        protected assumption assmptn;
        protected EducationGoalsDAO educationGoalsDao = new EducationGoalsDAO();
        protected AssumptionDAO assumptionDao = new AssumptionDAO();
        protected EntitySet<countrycostofeducation> cced;
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";
        protected bool sendPdf = false;
        protected byte[] pdfData = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            assmptn = assumptionDao.getAssumptionById(3);

            cced = educationGoalsDao.getCountryCostOfEducation();

            activity = activityStatusDao.getActivity(8);
            ViewState["activity"] = activity;

            lblEducationGoalDelFailed.Visible = false;
            lblEducationGoalDelSuccess.Visible = false;
            lblEducationGoalFailed.Visible = false;
            lblEducationGoalSuccess.Visible = false;
            lblStatusSubmissionFailed.Visible = false;
            lblStatusSubmitted.Visible = false;

            int egid = 0;
            if (educationgoalid.Value != null && educationgoalid.Value != "")
            {
                egid = Int32.Parse(educationgoalid.Value);
            }

            ViewState["egid"] = egid;

            if (egid != 0)
            {
                ViewState["casetype"] = "update";

                if ((saveclicked.Value == "0" || saveclicked.Value == "") && (addclicked.Value == "0" || addclicked.Value == "") && (delclicked.Value == "0" || delclicked.Value == "") && (selectedcountrychanged.Value == "0" || selectedcountrychanged.Value == ""))
                {
                    if (ViewState["caseid"] != null)
                    {
                        educationGoal = educationGoalsDao.getEducationGoal(ViewState["caseid"].ToString());
                    }

                    educationgoal displaysg = null;
                    if (educationGoal != null && educationGoal.Count > 0)
                    {
                        displaysg = educationGoal[0];
                        foreach (educationgoal s in educationGoal)
                        {
                            if (egid == s.id)
                            {
                                displaysg = s;
                            }
                        }
                    }
                    populateEducationGoal(displaysg, assmptn, cced, ViewState["caseid"].ToString());
                    saveclicked.Value = "1";
                }
                if (delclicked.Value == "1")
                {
                    deleteEducationGoal(egid);
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

            if (cid != null && cid != "" && (saveclicked.Value == "0" || saveclicked.Value == "") && (addclicked.Value == "0" || addclicked.Value == "") && (delclicked.Value == "0" || delclicked.Value == "") && (selectedcountrychanged.Value == "0" || selectedcountrychanged.Value == ""))
            {
                educationGoal = educationGoalsDao.getEducationGoal(cid);

                educationgoal displaysg = null;
                if (educationGoal != null && educationGoal.Count > 0)
                {
                    displaysg = educationGoal[0];
                    if (displaysg.existingassetegs != null)
                    {
                        ViewState["noofassets"] = displaysg.existingassetegs.Count;
                        noofmembers.Value = displaysg.existingassetegs.Count.ToString();
                    }
                }
                saveclicked.Value = "1";
            }

            if (addclicked.Value == "1")
            {
                refreshEducationGoal(assmptn, cced);
                //addclicked.Value = "0";
                saveclicked.Value = "1";
                ViewState["addclicked"] = addclicked.Value; 
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

                string url = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                eaAssetLiability.Attributes.Add("onClick", url);

                url = "popitup('/_layouts/Zurich/IncomeExpensePopUp.aspx',900,1200);return false;";
                mvalueLink.Attributes.Add("onClick", url);
                
                if (caseid != null)
                {
                    caseidsg.Value = caseid;

                    educationGoal = educationGoalsDao.getEducationGoal(caseid);
                    if (educationGoal != null && educationGoal.Count>0 && egid!=0)
                    {
                        ViewState["casetype"] = "update";
                    }
                    else
                    {
                        ViewState["casetype"] = "new";
                    }
                    
                    educationgoal displaysg = null;
                    if (educationGoal != null && educationGoal.Count > 0)
                    {
                        displaysg = educationGoal[0];
                        educationgoalid.Value = displaysg.id.ToString();
                    }
                    
                    populateEducationGoal(displaysg, assmptn, cced, caseid);

                    List<educationgoal> gridgoal = educationGoal;
                    foreach (educationgoal s in gridgoal)
                    {
                        double damtfv = 0;
                        double dmaturityval = 0;
                        double deattl = 0;

                        if (s.futurecost != null && s.futurecost != "")
                        {
                            damtfv = double.Parse(s.futurecost);
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

                    existingeggrid.DataSource = gridgoal;
                    existingeggrid.DataBind();
                }
            }

            currentAge.Attributes.Add("onblur", "tempCalculate();");
            ageWhenFundsNeeded.Attributes.Add("onblur", "tempCalculate();");
            yrsToSave.Attributes.Add("readonly", "readonly");

            costEducation.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");
            inflationRate.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");
            
            futureValue.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");
            futureValue.Attributes.Add("readonly", "readonly");

            maturityValue.Attributes.Add("onblur", "calculateAmountNeededFutureValue();");

            existingAssetsEducationGoals.Attributes.Add("readonly", "readonly");
            totalShortfallSurplus.Attributes.Add("readonly", "readonly");

            countryList.Attributes.Add("onchange", "selectedCountryChanged();");

            markStatusOnTab(caseid);

        }

        private void populateEducationGoal(educationgoal educationGoal, assumption assmptn, EntitySet<countrycostofeducation> cced, string caseid)
        {
            double shortfallSurplus = 0;

            inflationRate.Text = "0";

            maturityValue.Text = "0";
            futureValue.Text = "0";

            if(assmptn!=null && assmptn.percentage!=null)
            {
                inflationRate.Text = assmptn.percentage.ToString();
            }
            
            int idCountrySel = 0;
            idCountrySel = cced[0].id;

            if (countryList != null && countryList.SelectedValue != null && countryList.SelectedValue!="")
            {
                string countrySel = countryList.SelectedValue;
                idCountrySel = Int16.Parse(countrySel);
            }

            countryList.DataSource = cced;
            countryList.DataValueField = "id";
            countryList.DataTextField = "country";
            countryList.DataBind();
            countryList.SelectedValue = idCountrySel.ToString();

            costEducation.Text = "0";
            
            futureValue.Text = "0";
            

            yrsToSave.Text = "0";
            ageWhenFundsNeeded.Text = "0";
            currentAge.Text = "0";
            nameofChild.Text = "";
            existingAssetsEducationGoals.Text = "0";

            totalShortfallSurplus.Text = "0";

            educationGoalNeeded2.Selected = true;

            if (educationGoal != null)
            {
                educationGoalNeeded.SelectedValue = educationGoal.educationGoalNeeded.ToString();
                
                nameofChild.Text = educationGoal.nameofchild;

                if (educationGoal.currentage != null && educationGoal.currentage != "")
                {
                    currentAge.Text = educationGoal.currentage;
                }

                if (educationGoal.agefundsneeded != null && educationGoal.agefundsneeded != "")
                {
                    ageWhenFundsNeeded.Text = educationGoal.agefundsneeded;
                }

                if (educationGoal.noofyrstosave != null && educationGoal.noofyrstosave != "")
                {
                    yrsToSave.Text = educationGoal.noofyrstosave;
                }

                if (educationGoal.presentcost == null || educationGoal.presentcost == "")
                {
                    foreach (countrycostofeducation cc in cced)
                    {
                        if (cc.id == idCountrySel)
                        {
                            if (cc.costofeducation != null && cc.costofeducation != "")
                            {
                                costEducation.Text = cc.costofeducation;
                            }
                            else
                            {
                                costEducation.Text = "0";
                            }
                            break;
                        }
                    }
                }
                else
                {
                    costEducation.Text = educationGoal.presentcost;
                }

               
                futureValue.Text = costEducation.Text;
                

                if (educationGoal.countryofstudyid != null)
                {
                    countryList.SelectedValue = educationGoal.countryofstudyid.ToString();
                }

                futureValue.Text = educationGoal.futurecost;
                

                if (educationGoal.maturityvalue != null && educationGoal.maturityvalue != "")
                {
                    maturityValue.Text = educationGoal.maturityvalue;
                }

                assetList.DataSource = educationGoal.existingassetegs;
                assetList.DataBind();

                if (educationGoal.inflationrate != null && educationGoal.inflationrate != "")
                {
                    inflationRate.Text = educationGoal.inflationrate;
                }

                if (educationGoal.existingassetegs != null)
                {
                    ViewState["noofassets"] = educationGoal.existingassetegs.Count;

                    if (educationGoal.existingassetegs != null && educationGoal.existingassetegs.Count > 0)
                    {
                        existingAssetsEducationGoals.Text = educationGoal.existingassetstotal;
                    }
                    else
                    {
                        existingAssetsEducationGoals.Text = "0";
                    }

                }

            }

            string ExistingValuesplbl = (double.Parse(existingAssetsEducationGoals.Text) + double.Parse(maturityValue.Text)).ToString();

            if (futureValue.Text == "")
            {
                futureValue.Text = "0";
            }
            
            shortfallSurplus = double.Parse(ExistingValuesplbl) - double.Parse(futureValue.Text);

            totalShortfallSurplus.Text = Math.Abs(shortfallSurplus).ToString();
            
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

        private void refreshEducationGoal(assumption assmptn, EntitySet<countrycostofeducation> cced)
        {
            
            inflationRate.Text = "0";

            maturityValue.Text = "0";
            futureValue.Text = "0";

            if (assmptn != null && assmptn.percentage != null)
            {
                inflationRate.Text = assmptn.percentage.ToString();
            }


            int idCountrySel = 0;
            idCountrySel = cced[0].id;

            countryList.DataSource = cced;
            countryList.DataValueField = "id";
            countryList.DataTextField = "country";
            countryList.DataBind();
            countryList.SelectedValue = idCountrySel.ToString();

            costEducation.Text = "0";

            foreach (countrycostofeducation cc in cced)
            {
                if (cc.id == idCountrySel)
                {
                    if (cc.costofeducation != null && cc.costofeducation != "")
                    {
                        costEducation.Text = cc.costofeducation;
                    }
                    break;
                }
            }

            futureValue.Text = costEducation.Text;
            

            yrsToSave.Text = "0";
            ageWhenFundsNeeded.Text = "0";
            currentAge.Text = "0";
            nameofChild.Text = "";

            assetList.DataSource = null;
            assetList.DataBind();
            
            existingAssetsEducationGoals.Text = "0";

            totalShortfallSurplus.Text = "0";

            ttlSS.Text = "Shortfall / Surplus";
            ttlSS.Style.Add("color", "black");

            educationgoalid.Value = "0";
            saveclicked.Value = "0";
            delclicked.Value = "0";
        }

        private void deleteEducationGoal(int egid)
        {
            int status = 1;
            status = educationGoalsDao.deleteEducationGoal(egid);

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            if (ViewState["caseid"] != null)
            {
                string casestatus = activityStatusCheck.getEducationGoalStatus(ViewState["caseid"].ToString());
                activityStatusDao.saveOrUpdateActivityStatus(ViewState["caseid"].ToString(), actv, casestatus);

                markStatusOnTab(ViewState["caseid"].ToString());

                educationGoal = educationGoalsDao.getEducationGoal(ViewState["caseid"].ToString());
            }

            educationgoal displaysg = null;
            if (educationGoal != null && educationGoal.Count > 0)
            {
                displaysg = educationGoal[0];
                educationgoalid.Value = displaysg.id.ToString();
            }

            populateEducationGoal(displaysg, assmptn, cced, ViewState["caseid"].ToString());

            List<educationgoal> gridgoal = educationGoal;
            foreach (educationgoal s in gridgoal)
            {
                double damtfv = 0;
                double dmaturityval = 0;
                double deattl = 0;

                if (s.futurecost != null && s.futurecost != "")
                {
                    damtfv = double.Parse(s.futurecost);
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

            existingeggrid.DataSource = gridgoal;
            existingeggrid.DataBind();

            if (status == 1)
            {
                lblEducationGoalDelSuccess.Visible = true;
            }
            else
            {
                lblEducationGoalDelFailed.Visible = true;
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
            submitEducationGoals(null, null);
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
            submitEducationGoals(null, null);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void submitEducationGoalsPrevious(object sender, EventArgs e)
        {
            sendPdf = false;
            submitEducationGoals(null, null);
            string url = MenuResolution.getUrl("retirementGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/RetirementGoals/ShowRetirementGoals.aspx", data);*/
        }
        
        protected void submitEducationGoalsNext(object sender, EventArgs e)
        {
            sendPdf = false;
            submitEducationGoals(null, null);
            string url = MenuResolution.getUrl("riskProfile");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/RiskProfile/RiskProfile.aspx", data);*/
        }

        protected void updateCountryCostofEducation(object sender, EventArgs e)
        {
            if (ViewState["addclicked"] != null)
            {
                addclicked.Value = ViewState["addclicked"].ToString();
            }

            int selectedCountry = Int32.Parse(countryList.SelectedValue);
            
            foreach (countrycostofeducation cc in cced)
            {
                if (cc.id == selectedCountry)
                {
                    costEducation.Text = cc.costofeducation;
                    break;
                }
            }

            double dcostOfEducation = 0;
            if (costEducation.Text != null && costEducation.Text != "")
            {
                dcostOfEducation = double.Parse(costEducation.Text);
            }
            double dinflationRate = 0;
            if (inflationRate.Text != null && inflationRate.Text != "")
            {
                dinflationRate = double.Parse(inflationRate.Text);
            }
            int iyrsTosave = 0;
            if (yrsToSave.Text != null && yrsToSave.Text != "")
            {
                iyrsTosave = Int32.Parse(yrsToSave.Text);
            }
            double pow = 1;
            pow = Math.Pow((1 + (dinflationRate/100)), iyrsTosave);
            double dfutureCost = dcostOfEducation * pow;
            if (dfutureCost != 0)
            {
                futureValue.Text = dfutureCost.ToString("#0.00");
            }
            else
            {
                futureValue.Text = "0";
            }
            
            double deattl = 0;
            if (existingAssetsEducationGoals.Text != null && existingAssetsEducationGoals.Text != "")
            {
                deattl = double.Parse(existingAssetsEducationGoals.Text);
            }
            double dmaturityVal = 0;
            if (maturityValue.Text != null && maturityValue.Text != "")
            {
                dmaturityVal = double.Parse(maturityValue.Text);
            }
            double dtotal = (deattl + dmaturityVal) - dfutureCost;
            if (dtotal < 0)
            {
                ttlSS.Text = "Shortfall";
                ttlSS.Style.Add("color", "red");
                totalShortfallSurplus.Text = Math.Abs(dtotal).ToString("#0.00");
            }
            else if (dtotal > 0)
            {
                ttlSS.Text = "Surplus";
                ttlSS.Style.Add("color", "black");
                totalShortfallSurplus.Text = dtotal.ToString("#0.00");
            }
            else
            {
                ttlSS.Text = "Shortfall / Surplus";
                ttlSS.Style.Add("color", "black");
                totalShortfallSurplus.Text = "0";
            }

        }
        
        protected void submitEducationGoals(object sender, EventArgs e)
        {
            educationgoal goals = new educationgoal();

            goals.educationGoalNeeded = Convert.ToInt16(educationGoalNeeded.SelectedValue);

            if (goals.educationGoalNeeded == 2)
            {
                goals.agefundsneeded = ageWhenFundsNeeded.Text;
                goals.currentage = currentAge.Text;
                goals.maturityvalue = maturityValue.Text;
                goals.nameofchild = nameofChild.Text;
                goals.noofyrstosave = yrsToSave.Text;

                if (totalShortfallSurplus.Text != null && totalShortfallSurplus.Text != "")
                {
                    double ttl = double.Parse(totalShortfallSurplus.Text);
                    if (ttl < 0)
                    {
                        totalShortfallSurplus.Text = Math.Abs(ttl).ToString();
                    }
                }
                goals.total = totalShortfallSurplus.Text;

                goals.existingassetstotal = existingAssetsEducationGoals.Text;
                goals.futurecost = futureValue.Text;
                goals.presentcost = costEducation.Text;
                goals.inflationrate = inflationRate.Text;
            }
            else if (goals.educationGoalNeeded == 1 || goals.educationGoalNeeded == 0)
            {
                goals.agefundsneeded = "0";
                goals.currentage = "0";
                goals.maturityvalue = "0";
                goals.nameofchild = "";
                goals.noofyrstosave = "0";
                goals.total = "0";
                goals.existingassetstotal = "0";
                goals.futurecost = "0";
                goals.presentcost = "0";
                goals.inflationrate = "0";
            }
                  
            goals.deleted = false;
            
            string caseid = "";
            if (ViewState["caseid"]!=null)
            {
                caseid = ViewState["caseid"].ToString();
                goals.caseid = caseid;
            }
            

            goals.countryofstudyid = Int16.Parse(countryList.SelectedValue);

            int noofea = 0;
            if (goals.educationGoalNeeded == 2)
            {
                if (noofmembers.Value != "")
                {
                    noofea = Int16.Parse(noofmembers.Value);
                }
            }

            EntitySet<existingasseteg> easgList = new EntitySet<existingasseteg>();
            if (noofea > 0)
            {
                for (int i = 1; i <= noofea; i++)
                {
                    existingasseteg easg = new existingasseteg();
                    easg.asset = Request.Form["pri-" + i];
                    easg.presentvalue = Request.Form["pri_" + i];
                    easg.percentpa = Request.Form["sec_" + i];

                    if ((Request.Form["pri-" + i] != null) && (Request.Form["pri_" + i] != null) && (Request.Form["sec_" + i] != null))
                    {
                        easgList.Add(easg);
                    }

                }
                goals.existingassetegs = easgList;
            }

            int egid = 0;
            if (ViewState["egid"] != null)
            {
                egid = Int32.Parse(ViewState["egid"].ToString());
            }
            
            if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "new")
            {
                goals = educationGoalsDao.saveEducationGoals(goals);
            }
            else if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "update")
            {
                goals = educationGoalsDao.updateEducationGoals(goals, egid);
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string status = activityStatusCheck.getEducationGoalStatus(caseid);
            activityStatusDao.saveOrUpdateActivityStatus(caseid, actv, status);

            markStatusOnTab(caseid);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);

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
                lblEducationGoalSuccess.Visible = true;

                educationGoal = educationGoalsDao.getEducationGoal(caseid);

                educationgoal displaysg = null;
                if (educationGoal != null && educationGoal.Count > 0)
                {
                    if (addandsave.Value == "1")
                    {
                        displaysg = educationGoal[educationGoal.Count-1];
                    }
                    else
                    {
                        bool found = false;
                        int count = 0;
                        foreach (educationgoal sgl in educationGoal)
                        {
                            if (egid == sgl.id)
                            {
                                found = true;
                                break;
                            }
                            count++;
                        }

                        if (found)
                        {
                            displaysg = educationGoal[count];
                        }
                        else
                        {
                            displaysg = educationGoal[0];
                        }
                    }
                    
                    educationgoalid.Value = displaysg.id.ToString();
                    addandsave.Value = "";
                }
                populateEducationGoal(displaysg, assmptn, cced, caseid);

                List<educationgoal> gridgoal = educationGoal;
                foreach (educationgoal s in gridgoal)
                {
                    double damtfv = 0;
                    double dmaturityval = 0;
                    double deattl = 0;

                    if (s.futurecost != null && s.futurecost != "")
                    {
                        damtfv = double.Parse(s.futurecost);
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

                //existingeggrid.DataSource = educationGoal;
                existingeggrid.DataSource = gridgoal;
                existingeggrid.DataBind();

                //refreshEducationGoal(assmptn, cced);
            }
            else
            {
                lblEducationGoalFailed.Visible = true;
            }
            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, url, sendPdf);
        }

        protected void createEducationGoalsPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseid"] != null)
            {
                caseId = ViewState["caseid"].ToString();
            }

            sendPdf = true;
            submitEducationGoals(null, null);

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

            submitEducationGoals(null, null);
            
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
