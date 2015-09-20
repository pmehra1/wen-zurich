using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Data.Linq;
using System.Collections.Specialized;
using ActivityStatusCheck;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using PDFGeneration;
using System.IO;
using System.Collections.Generic;

namespace Zurich.Layouts.Zurich
{
    public partial class IncomeInsuranceExpense : LayoutsPageBase
    {
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";
        string caseId = "";
        protected bool sendPdf = false;
        protected byte[] pdfData = null;

        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);

            FNAMenu menu = (FNAMenu)this.menu1;

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
            saveIncomeInsuranceExpenseDetails(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            activity = activityStatusDao.getActivity(4);
            ViewState["activity"] = activity;

            lblPdSummarySaveSuccess.Visible = false;
            lblPdSummarySaveFailed.Visible = false;

            incomeExpense incomeExpense = null;
           
            if (!IsPostBack)
            {
                string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];
                string helperUsed = Request.Form["helperUsed"];
                
                IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();
                
                if (nextCaseId != null && nextCaseId != "")
                {
                    caseId = nextCaseId;
                }

                if (menuCaseId != null && menuCaseId != "")
                {
                    caseId = menuCaseId;
                }

                if (Session["fnacaseid"] != null)
                {
                    caseId = Session["fnacaseid"].ToString();
                } 

                ViewState["caseId"] = caseId;
                
                if (caseId != null || caseId != "")
                {
                    incomeExpense = incomeExpenseDao.getIncomeExpenseForCase(caseId);

                }

                populateIncomeAndExpenseDetails(incomeExpense, caseId);
            }

            markStatusOnTab(caseId);
            emergencyFundsNeeded.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathTermInsuranceSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathWholeLifeInsuranceSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            lifeInsuranceSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            tpdcSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            criticalIllnessSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            mortgageSA.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathTermInsuranceTerm.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathWholeLifeInsuranceTerm.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            lifeInsuranceMV.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            tpdcMV.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            criticalIllnessMV.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            mortgageMV.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathTermInsurancePremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            DeathWholeLifeInsurancePremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            lifeInsurancePremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            tpdcPremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            criticalIllnessPremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
            mortgagePremium.Attributes.Add("onblur", "removeZeroesIncomeExpense();");
        }


        protected void populateIncomeAndExpenseDetails(incomeExpense incomeExpense, string caseId)
        {
            if (incomeExpense != null)
            {
                DeathTermInsuranceSA.Text = incomeExpense.DeathTermInsuranceSA;
                DeathWholeLifeInsuranceSA.Text = incomeExpense.DeathWholeLifeInsuranceSA;
                DeathTermInsuranceTerm.Text = incomeExpense.DeathTermInsuranceTerm;
                DeathWholeLifeInsuranceTerm.Text = incomeExpense.DeathWholeLifeInsuranceTerm;
                DeathTermInsurancePremium.Text = incomeExpense.DeathTermInsurancePremium;
                DeathWholeLifeInsurancePremium.Text = incomeExpense.DeathWholeLifeInsurancePremium;
                emergencyFundsNeeded.Text = incomeExpense.emergencyFundsNeeded;
                shortTermGoals.Text = incomeExpense.shortTermGoals;
                extraDetails.Text = incomeExpense.extraDetails;
                netMonthlyIncomeAfterCpf.Text = incomeExpense.netMonthlyIncomeAfterCpf;
                netMonthlyExpenses.Text = incomeExpense.netMonthlyExpenses;
                monthlySavings.Text = incomeExpense.monthlySavings;
                lifeInsuranceSA.Text = incomeExpense.lifeInsuranceSA;
                lifeInsuranceMV.Text = incomeExpense.lifeInsuranceMV;
                lifeInsurancePremium.Text = incomeExpense.lifeInsurancePremium;
                tpdcSA.Text = incomeExpense.tpdcSA;
                tpdcMV.Text = incomeExpense.tpdcMV;
                tpdcPremium.Text = incomeExpense.tpdcPremium;
                criticalIllnessSA.Text = incomeExpense.criticalIllnessSA;
                criticalIllnessMV.Text = incomeExpense.criticalIllnessMV;
                criticalIllnessPremium.Text = incomeExpense.criticalIllnessPremium;
                mortgageSA.Text = incomeExpense.mortgageSA;
                mortgageMV.Text = incomeExpense.mortgageMV;
                mortgagePremium.Text = incomeExpense.mortgagePremium;
                otherSourcesOfIncome.Text = incomeExpense.otherSourcesOfIncome;
                incomeInsuranceEnable.SelectedValue = incomeExpense.incomeExpenseNeeded.ToString();
                assecertainingAffordabilityEnable.SelectedValue = incomeExpense.assecertainingAffordabilityEnable.ToString();

                if (incomeExpense.incomeExpenseNotNeededReason != null)
                    incomeExpenseNotNeededReason.Text = incomeExpense.incomeExpenseNotNeededReason.ToString();
                else
                    incomeExpenseNotNeededReason.Text = "";

                if (incomeExpense.assecertainingAffordabilityEnable == null)
                {
                    assecertainingAffordabilityEnable.SelectedValue = "0";
                }
                if (incomeExpense.incomeExpenseNeeded == null)
                {
                    incomeInsuranceEnable.SelectedValue = "0";
                }
                
                if (incomeExpense.assecertainingAffordabilityReason != null)
                    assecertainingAffordabilityReason.Text = incomeExpense.assecertainingAffordabilityReason.ToString();
                else
                    assecertainingAffordabilityReason.Text = "";

                if (incomeExpense.insuranceArrangementSavings.Count > 0)
                    this.savingsPlusNumber.Value = (incomeExpense.insuranceArrangementSavings.Count) + "";
                this.incomeInsuranceExpenseSavingRepeater.DataSource = incomeExpense.insuranceArrangementSavings;
                this.incomeInsuranceExpenseSavingRepeater.DataBind();


                if (incomeExpense.insuranceArrangementRetirements.Count > 0)
                    this.retirementPlusNumber.Value = (incomeExpense.insuranceArrangementRetirements.Count) + "";
                this.incomeInsuranceExpenseRetirementRepeater.DataSource = incomeExpense.insuranceArrangementRetirements;
                this.incomeInsuranceExpenseRetirementRepeater.DataBind();

                if (incomeExpense.insuranceArrangementEducations.Count > 0)
                    this.educationPlusNumber.Value = (incomeExpense.insuranceArrangementEducations.Count) + "";
                this.incomeInsuranceExpenseEducationRepeater.DataSource = incomeExpense.insuranceArrangementEducations;
                this.incomeInsuranceExpenseEducationRepeater.DataBind();
            }
            else
            {
                incomeInsuranceEnable.SelectedValue = "0";
                assecertainingAffordabilityEnable.SelectedValue = "0";
            }
            activityId.Value = caseId;
            PersonalDetailsDAO personalDao = new PersonalDetailsDAO();
            personaldetail detail = personalDao.getPersonalDetail(caseId);
            if (detail != null)
            {
                if ((detail.name != null) || (detail.name != ""))
                    PersonName.Value = detail.name;
                else
                    PersonName.Value = "";
            }
            else
                PersonName.Value = "";

            List<string> errors = printErrorMessages(incomeExpense);
            this.ErrorRepeater.DataSource = errors;
            this.ErrorRepeater.DataBind();
        }


        public List<string> printErrorMessages(incomeExpense incomeExpense)
        {
            List<string> list = new List<string>();

            if (incomeExpense != null)
            {
                if (incomeExpense.shortTermGoals != null)
                {
                    if (incomeExpense.shortTermGoals == "Yes")
                    {
                        Utility.checkEmptyField(incomeExpense.extraDetails, list, "Please enter the extra details");
                    }
                }

                if (incomeExpense.incomeExpenseNeeded == 1)
                {
                    Utility.checkEmptyField(incomeExpense.incomeExpenseNotNeededReason, list, "Please enter the reason for not considering Income and Expense");
                }
            }
            return list;
        }


        protected incomeExpense copyIncomeExpenseBaseClass(incomeExpense incomeExpense)
        {
            incomeExpense.emergencyFundsNeeded = emergencyFundsNeeded.Text;
            incomeExpense.shortTermGoals = shortTermGoals.Text;
            incomeExpense.extraDetails = extraDetails.Text;
            incomeExpense.netMonthlyIncomeAfterCpf = netMonthlyIncomeAfterCpf.Text;
            incomeExpense.netMonthlyExpenses = netMonthlyExpenses.Text;
            incomeExpense.monthlySavings = monthlySavings.Text;
            incomeExpense.lifeInsuranceSA = lifeInsuranceSA.Text;
            incomeExpense.lifeInsuranceMV = lifeInsuranceMV.Text;
            incomeExpense.lifeInsurancePremium = lifeInsurancePremium.Text;
            incomeExpense.tpdcSA = tpdcSA.Text;
            incomeExpense.tpdcMV = tpdcMV.Text;
            incomeExpense.tpdcPremium = tpdcPremium.Text;
            incomeExpense.criticalIllnessSA = criticalIllnessSA.Text;
            incomeExpense.criticalIllnessMV = criticalIllnessMV.Text;
            incomeExpense.criticalIllnessPremium = criticalIllnessPremium.Text;
            incomeExpense.mortgageSA = mortgageSA.Text;
            incomeExpense.mortgageMV = mortgageMV.Text;
            incomeExpense.mortgagePremium = mortgagePremium.Text;
            incomeExpense.DeathTermInsuranceTerm = DeathTermInsuranceTerm.Text;
            incomeExpense.DeathTermInsuranceSA = DeathTermInsuranceSA.Text;
            incomeExpense.DeathTermInsurancePremium = DeathTermInsurancePremium.Text;
            incomeExpense.DeathWholeLifeInsurancePremium = DeathWholeLifeInsurancePremium.Text;
            incomeExpense.DeathWholeLifeInsuranceSA = DeathWholeLifeInsuranceSA.Text;
            incomeExpense.DeathWholeLifeInsuranceTerm = DeathWholeLifeInsuranceTerm.Text;
            incomeExpense.otherSourcesOfIncome = otherSourcesOfIncome.Text;
            incomeExpense.incomeExpenseNotNeededReason = incomeExpenseNotNeededReason.Text;
            incomeExpense.incomeExpenseNeeded = Convert.ToInt32(incomeInsuranceEnable.SelectedValue);
            incomeExpense.assecertainingAffordabilityEnable = Convert.ToInt32(assecertainingAffordabilityEnable.SelectedValue);
            incomeExpense.assecertainingAffordabilityReason = assecertainingAffordabilityReason.Text;
            return incomeExpense;
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            saveIncomeInsuranceExpenseDetails(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveIncomeInsuranceExpenseNext(object sender, EventArgs e)
        {
            sendPdf = false;
            saveIncomeInsuranceExpenseDetails(null, null);
            string url = MenuResolution.getUrl("assetLiabilities");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveIncomeAndInsuranceDetailsBack(object sender, EventArgs e)
        {
            sendPdf = false;
            saveIncomeInsuranceExpenseDetails(null, null);
            string url = MenuResolution.getUrl("priorityDetails");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void saveIncomeInsuranceExpenseDetails(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }

            if (Session["fnacaseid"] != null)
            {
                caseId = Session["fnacaseid"].ToString();
            } 


            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }


            IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();
            incomeExpense incomeExpense = incomeExpenseDao.getIncomeExpenseForCase(caseId);

            string status = "new";

            if (incomeExpense != null)
            {
                copyIncomeExpenseBaseClass(incomeExpense);
                status = "update";
            }
            else
            {
                incomeExpense = new incomeExpense();
                incomeExpense.caseId = caseId;
                copyIncomeExpenseBaseClass(incomeExpense);
            }

            EntitySet<insuranceArrangementSaving> insuranceArrangementSavingsOthers = new EntitySet<insuranceArrangementSaving>();
            EntitySet<insuranceArrangementRetirement> insuranceArrangementRetirementOthers = new EntitySet<insuranceArrangementRetirement>();
            EntitySet<insuranceArrangementEducation> insuranceArrangementEducationOthers = new EntitySet<insuranceArrangementEducation>();
            
            
            

            int savingsArrangementsNumber = 0;
            int retirementArrangementsNumber = 0;
            int educationArrangementsNumber = 0;

            if (savingsPlusNumber.Value != "")
            {
                savingsArrangementsNumber = Int16.Parse(savingsPlusNumber.Value) ;
            }


            if (savingsArrangementsNumber > 0)
            {
                for (int i = 1; i < savingsArrangementsNumber+1; i++)
                {
                    if (Request.Form["savingsOwnerName" + i] != null)
                    {
                        insuranceArrangementSaving insuranceArrangementSaving = new insuranceArrangementSaving();
                        insuranceArrangementSaving.policyOwnerName = Request.Form["savingsOwnerName" + i];
                        insuranceArrangementSaving.natureOfPlan = Request.Form["savingsNatureOfPlan" + i];
                        insuranceArrangementSaving.company = Request.Form["savingsCompany" + i];
                        insuranceArrangementSaving.contribution = Request.Form["savingsContribution" + i];
                        insuranceArrangementSaving.term = Request.Form["savingsTerm" + i];
                        insuranceArrangementSaving.fundValue = Request.Form["savingsCurrentFundValue" + i];
                        insuranceArrangementSaving.frequency = Request.Form["savingsFrequency" + i];
                        insuranceArrangementSaving.caseId = caseId;
                        insuranceArrangementSavingsOthers.Add(insuranceArrangementSaving);
                        
                    }
                }
            }



            if (retirementPlusNumber.Value != "")
            {
                retirementArrangementsNumber = Int16.Parse(retirementPlusNumber.Value) ;
            }


            
            if (retirementArrangementsNumber > 0)
            {
                for (int i = 1; i < retirementArrangementsNumber+1; i++)
                {
                    if (Request.Form["retirementOwnerName" + i] != null)
                    {
                        insuranceArrangementRetirement insuranceArrangementRetirement = new insuranceArrangementRetirement();
                        insuranceArrangementRetirement.policyOwnerName = Request.Form["retirementOwnerName" + i];
                        insuranceArrangementRetirement.company = Request.Form["retirementCompany" + i];
                        insuranceArrangementRetirement.contribution = Request.Form["retirementContribution" + i];
                        insuranceArrangementRetirement.maturityDate = Request.Form["retirementMaturityDate" + i];
                        insuranceArrangementRetirement.projectedLumpSumMaturity = Request.Form["retirementLumpSumMaturity" + i];
                        insuranceArrangementRetirement.projectedIncomeMaturity = Request.Form["retirementProjectedIncomeMaturity" + i];
                        insuranceArrangementRetirement.frequency = Request.Form["retirementFrequency" + i];
                        insuranceArrangementRetirement.caseId = caseId;
                        insuranceArrangementRetirementOthers.Add(insuranceArrangementRetirement);
                    }
                }
            }



            if (educationPlusNumber.Value != "")
            {
                educationArrangementsNumber = Int16.Parse(educationPlusNumber.Value) ;
            }


            if (educationArrangementsNumber > 0)
            {
                for (int i = 1; i < educationArrangementsNumber+1; i++)
                {
                    if (Request.Form["educationOwnerName" + i] != null)
                    {
                        insuranceArrangementEducation insuranceArrangementEducation = new insuranceArrangementEducation();
                        insuranceArrangementEducation.policyOwnerName = Request.Form["educationOwnerName" + i];
                        insuranceArrangementEducation.company = Request.Form["educationCompany" + i];
                        insuranceArrangementEducation.contribution = Request.Form["educationContribution" + i];
                        insuranceArrangementEducation.maturityDate = Request.Form["educationMaturityDate" + i];
                        insuranceArrangementEducation.projectedLumpSumMaturity = Request.Form["educationLumpSumMaturity" + i];
                        insuranceArrangementEducation.frequency = Request.Form["educationFrequency" + i];
                        insuranceArrangementEducation.projectedIncomeMaturity = Request.Form["educationProjectedIncomeMaturity" + i];
                        insuranceArrangementEducation.caseId = caseId;
                        insuranceArrangementEducationOthers.Add(insuranceArrangementEducation);
                    }
                }
            }

            incomeExpense.insuranceArrangementSavings = insuranceArrangementSavingsOthers;
            incomeExpense.insuranceArrangementRetirements = insuranceArrangementRetirementOthers;
            incomeExpense.insuranceArrangementEducations = insuranceArrangementEducationOthers;

            if (status.Equals("new"))
              incomeExpense=  incomeExpenseDao.insertNewIncomeExpenseDetails(incomeExpense);
            else
              incomeExpense=  incomeExpenseDao.updateIncomeExpenseDetails(incomeExpense);
            

            this.savingsPlusNumber.Value = (insuranceArrangementSavingsOthers.Count) + "";
            this.retirementPlusNumber.Value = (insuranceArrangementRetirementOthers.Count) + "";
            this.educationPlusNumber.Value = (insuranceArrangementEducationOthers.Count) + "";
            activityId.Value = caseId;

            string sts = activityStatusCheck.getIncomeExpenseStatus(incomeExpense);
            activityStatusDao.saveOrUpdateActivityStatus(caseId, actv, sts);

            markStatusOnTab(caseId);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseId);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");

            pdfData = activityStatusCheck.sendDataToSalesPortal(caseId, caseStatus, url, sendPdf);
            
            /*if (st == 1)
            {
                lblStatusSubmitted.Visible = false;
            }
            else
            {
                lblStatusSubmissionFailed.Visible = true;
            }*/
            
            populateIncomeAndExpenseDetails(incomeExpense, caseId);
            lblPdSummarySaveSuccess.Visible = true;
        }

        protected void redirectToCasePortal(object sender, EventArgs e)
        {
            string salesPortalRedirectUrl = "";
            string caseid = "";

            if (ViewState["caseId"] != null)
            {
                caseid = ViewState["caseId"].ToString();
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


            saveIncomeInsuranceExpenseDetails(null, null);
            
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
                activitystatus activityStatusPerdet = null;
                activitystatus activityStatusPrDet = null;
                activitystatus activityStatusAssetLiab = null;
                activitystatus activityStatusIncomeExpense = null;
                activitystatus activityStatusMza = null;

                activityStatusPerdet = activityStatusDao.getActivityForCaseid(caseid, "personaldetail");
                if (activityStatusPerdet != null)
                {
                    if (activityStatusPerdet.status == "incomplete")
                    {
                        personaldetailstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        personaldetailstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusPrDet = activityStatusDao.getActivityForCaseid(caseid, "prioritydetail");
                if (activityStatusPrDet != null)
                {
                    if (activityStatusPrDet.status == "incomplete")
                    {
                        prioritydetailstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        prioritydetailstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusAssetLiab = activityStatusDao.getActivityForCaseid(caseid, "assetliability");
                if (activityStatusAssetLiab != null)
                {
                    if (activityStatusAssetLiab.status == "incomplete")
                    {
                        assetliabilitytab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        assetliabilitytab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusIncomeExpense = activityStatusDao.getActivityForCaseid(caseid, "incomeexpense");
                if (activityStatusIncomeExpense != null)
                {
                    if (activityStatusIncomeExpense.status == "incomplete")
                    {
                        incomeexpensetab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        incomeexpensetab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusMza = activityStatusDao.getActivityForCaseid(caseid, "myzurichadviser");
                if (activityStatusMza != null)
                {
                    if (activityStatusMza.status == "incomplete")
                    {
                        mzatab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        mzatab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }
            }

        }

        protected void createIncomeexpensePdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
            sendPdf = true;
            saveIncomeInsuranceExpenseDetails(null, null);

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }

    }
}
