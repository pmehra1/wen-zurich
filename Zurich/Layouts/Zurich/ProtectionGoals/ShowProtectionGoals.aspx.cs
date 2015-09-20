using System;
using System.Data;
using System.Data.Linq;
using System.Collections.Generic;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;
using DAO;
using DTO;
using ActivityStatusCheck;
using System.Configuration;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using PDFGeneration;

namespace Zurich.Layouts.Zurich.ProtectionGoals
{
    public partial class ShowProtectionGoals : LayoutsPageBase
    {
        protected familyNeed fmlyNeed;
        protected myNeed myNeed;
        protected FamilyNeedsDAO familyNeedsDAO = new FamilyNeedsDAO();
        protected MyNeedsDAO myNeedsDAO = new MyNeedsDAO();
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
            saveProtectionGoals(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //lblSaveSuccess.Visible = false;
            activity = activityStatusDao.getActivity(5);
            ViewState["activity"] = activity;

            if (!IsPostBack)
            {
                string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];

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
                activityId.Value = caseId;

                if (caseId != null && caseId != "")
                {
                    ViewState["caseid"] = caseId;
                    fmlyNeed = familyNeedsDAO.getFamilyNeed(caseId);
                    
                    if (fmlyNeed != null)
                    {
                        ViewState["casetypefamily"] = "update";
                        populateFamilyNeed(fmlyNeed);
                    }
                    else
                    {
                        ViewState["casetypefamily"] = "new";
                        populateFamilyNeedIfNoNeed(caseId);
                    }
                }

                string url = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                lnkExistingAssetsFamilyneeds.Attributes.Add("onClick", url);
            }

            txtReplacementIncome.Attributes.Add("onblur", "calculate()");
            txtYrsOfSupport.Attributes.Add("onblur", "calculate()");
            txtInflationAdjustedReturns.Attributes.Add("onblur", "calculate()");
            txtLumpSumRequired.Attributes.Add("onblur", "calculate()");
            txtOtherLiabilities.Attributes.Add("onblur", "calculate()");
            txtEmergencyFundsNeeded.Attributes.Add("onblur", "calculate()");
            txtFinalExpenses.Attributes.Add("onblur", "calculate()");
            txtOtherFundingNeeds.Attributes.Add("onblur", "calculate()");
            txtTotalRequired.Attributes.Add("onblur", "calculate()");
            txtExistingLifeInsurance.Attributes.Add("onblur", "calculate()");
            txtExistingAssetsFamilyneeds.Attributes.Add("onblur", "calculate()");
            txtTotalShortfallSurplus.Attributes.Add("onblur", "calculate()");
            txtMortgageProtectionOutstanding.Attributes.Add("onblur", "calculate()");
            txtMortgageProtectionInsurances.Attributes.Add("onblur", "calculate()");
            txtMortgageProtectionTotal.Attributes.Add("onblur", "calculate()");
            txtTotalRequired.Attributes.Add("readonly", "readonly");
            txtExistingAssetsFamilyneeds.Attributes.Add("readonly", "readonly");
            txtTotalShortfallSurplus.Attributes.Add("readonly", "readonly");
            txtMortgageProtectionTotal.Attributes.Add("readonly", "readonly");
            txtLumpSumRequired.Attributes.Add("readonly", "readonly");

            markStatusOnTab(caseId);
        }


        private string getYearsToSupport(string caseId)
        {
            PersonalDetailsDAO dao = new PersonalDetailsDAO();
            personaldetail detail = dao.getPersonalDetail(caseId);
            int yearsToSupport = 0;
            if (detail != null)
            {
            if (detail.familyMemberDetails != null || detail.familyMemberDetails.Count > 0)
                {
                
                    EntitySet<familyMemberDetail> member = detail.familyMemberDetails;
                    for (int i = 0; i < detail.familyMemberDetails.Count; i++)
                    {
                        if (member[i].yrstosupport != null)
                        {
                            if (i == 0)
                            {
                                yearsToSupport = (int)member[i].yrstosupport;
                            }
                            else
                            {
                                int support = (int)member[i].yrstosupport;
                                if (support >= yearsToSupport)
                                    yearsToSupport = support;
                            }
                        }

                    }
                
                }
            }
           return yearsToSupport + "";
        }


        private void populateFamilyNeedIfNoNeed(string caseId)
        {
            IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();
            incomeExpense incomeExpense = incomeExpenseDao.getIncomeExpenseForCase(caseId);

            AssetAndLiabilityDAO assetLiabilityDao = new AssetAndLiabilityDAO();
            assetAndLiability assetAndLiability = assetLiabilityDao.getAssetLiabilityForCase(caseId);

            string yearsToSupport = getYearsToSupport(caseId);
            
            txtYrsOfSupport.Text = yearsToSupport;

            float percentage = 70;

            familyIncPrNeeded2.Selected = true;
            mortgagePrNeeded2.Selected = true;

            if (incomeExpense != null)
            {
                if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                {
                    txtReplacementIncome.Text = Math.Round((float.Parse(incomeExpense.netMonthlyIncomeAfterCpf) * 12 * percentage * .01)) + "";
                }
                else
                    txtReplacementIncome.Text = "0";
            }
            else
                txtReplacementIncome.Text = "0";

            if (incomeExpense != null)
            {
                if (incomeExpense.emergencyFundsNeeded != null && incomeExpense.emergencyFundsNeeded != "")
                    txtEmergencyFundsNeeded.Text = incomeExpense.emergencyFundsNeeded;
                else
                    txtEmergencyFundsNeeded.Text = "0";
            }
            else
                txtEmergencyFundsNeeded.Text = "0";

                AssumptionDAO assumptionDao = new AssumptionDAO();
                txtInflationAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage + "";
            


            if (assetAndLiability != null)
            {
                float liability = 0;


                if (assetAndLiability.vehicleLoan != null && assetAndLiability.vehicleLoan != "")
                {
                    liability += float.Parse(assetAndLiability.vehicleLoan);
                }

                if (assetAndLiability.cashLoan != null && assetAndLiability.cashLoan != "")
                {
                    liability += float.Parse(assetAndLiability.cashLoan);
                }

                if (assetAndLiability.creditCard != null && assetAndLiability.creditCard != "")
                {
                    liability += float.Parse(assetAndLiability.creditCard);
                }


                if (assetAndLiability.liabilityOthers != null)
                {
                    int count = assetAndLiability.liabilityOthers.Count;

                    EntitySet<liabilityOther> others = assetAndLiability.liabilityOthers;
                    for (int i = 0; i < count; i++)
                    {
                        if (others[i].cash != null && others[i].cash != "")
                            liability += float.Parse(others[i].cash);
                    }
                }

                txtOtherLiabilities.Text = liability + "";
            }
            else
                txtOtherLiabilities.Text = "0";


            float existLifeInsurance = 0;
            if (incomeExpense != null)
            {
                if (incomeExpense.DeathTermInsuranceSA != null && incomeExpense.DeathTermInsuranceSA != "")
                {
                    existLifeInsurance += float.Parse(incomeExpense.DeathTermInsuranceSA);
                }
                if (incomeExpense.DeathWholeLifeInsuranceSA != null && incomeExpense.DeathWholeLifeInsuranceSA != "")
                {
                    existLifeInsurance += float.Parse(incomeExpense.DeathWholeLifeInsuranceSA);
                }
                if (incomeExpense.lifeInsuranceSA != null && incomeExpense.lifeInsuranceSA != "")
                {
                    existLifeInsurance += float.Parse(incomeExpense.lifeInsuranceSA);
                }
            }
            
            txtExistingLifeInsurance.Text = existLifeInsurance + "";

            if (assetAndLiability != null)
            {
                if (assetAndLiability.homeMortgage != null && assetAndLiability.homeMortgage != "")
                {
                    txtMortgageProtectionOutstanding.Text = assetAndLiability.homeMortgage;
                }
                else
                    txtMortgageProtectionOutstanding.Text = "0";
            }
            else
                txtMortgageProtectionOutstanding.Text = "0";


            if (incomeExpense != null)
            {
                if (incomeExpense.mortgageSA != null && incomeExpense.mortgageSA != "")
                {
                    txtMortgageProtectionInsurances.Text = incomeExpense.mortgageSA;
                }
                else
                    txtMortgageProtectionInsurances.Text = "0";
            }
            else
                txtMortgageProtectionInsurances.Text = "0";

        }
        
        
        private void populateFamilyNeed(familyNeed fNeed)
        {

            //txtReplacementIncome.Text = (fNeed.replacementIncomeRequired == null || fNeed.replacementIncomeRequired == "") ? "0" : fNeed.replacementIncomeRequired;

            familyIncPrNeeded.SelectedValue = fNeed.familyIncPrNeeded.ToString();
            mortgagePrNeeded.SelectedValue = fNeed.mortgageNeeded.ToString();

            if(fNeed.yearsOfSupportRequired == null || fNeed.yearsOfSupportRequired == "")
            {
                string yearsToSupport = getYearsToSupport(fNeed.caseId);
                txtYrsOfSupport.Text = yearsToSupport;
            }
            else
                txtYrsOfSupport.Text=fNeed.yearsOfSupportRequired;
            

            txtInflationAdjustedReturns.Text = (fNeed.inflationAdjustedReturns == null || fNeed.inflationAdjustedReturns == "") ? "0" : fNeed.inflationAdjustedReturns;
            txtLumpSumRequired.Text = (fNeed.lumpSumRequired == null || fNeed.lumpSumRequired == "") ? "0" : fNeed.lumpSumRequired;
            txtOtherLiabilities.Text = (fNeed.otherLiabilities == null || fNeed.otherLiabilities == "") ? "0" : fNeed.otherLiabilities;
            txtEmergencyFundsNeeded.Text = (fNeed.emergencyFundsNeeded == null || fNeed.emergencyFundsNeeded == "") ? "0" : fNeed.emergencyFundsNeeded;
            txtFinalExpenses.Text = (fNeed.finalExpenses == null || fNeed.finalExpenses == "") ? "0" : fNeed.finalExpenses;
            txtOtherFundingNeeds.Text = (fNeed.otherFundingNeeds == null || fNeed.otherFundingNeeds == "") ? "0" : fNeed.otherFundingNeeds;
            //txtotherComments.Text = (fNeed.otherComments == null || fNeed.otherComments == "") ? "0" : fNeed.otherComments;
            txtTotalRequired.Text = (fNeed.totalRequired == null || fNeed.totalRequired == "") ? "0" : fNeed.totalRequired;
            txtExistingLifeInsurance.Text = (fNeed.existingLifeInsurance == null || fNeed.existingLifeInsurance == "") ? "0" : fNeed.existingLifeInsurance;
            //txtExistingAssetsFamilyneeds.Text = (fNeed.existingAssetsFamilyneeds == null || fNeed.existingAssetsFamilyneeds == "") ? "0" : fNeed.existingAssetsFamilyneeds;
            txtTotalShortfallSurplus.Text = (fNeed.totalShortfallSurplus == null || fNeed.totalShortfallSurplus == "") ? "0" : fNeed.totalShortfallSurplus;
            hiddenTotalShortfallSurplus.Value = (fNeed.totalShortfallSurplus == null || fNeed.totalShortfallSurplus == "") ? "0" : fNeed.totalShortfallSurplus;
            
            txtMortgageProtectionOutstanding.Text = (fNeed.mortgageProtectionOutstanding == null || fNeed.mortgageProtectionOutstanding == "") ? "0" : fNeed.mortgageProtectionOutstanding;
           // txtMortgageProtectionInsurances.Text = (fNeed.mortgageProtectionInsurances == null || fNeed.mortgageProtectionInsurances == "") ? "0" : fNeed.mortgageProtectionInsurances;
            txtMortgageProtectionTotal.Text = (fNeed.mortgageProtectionTotal == null || fNeed.mortgageProtectionTotal == "") ? "0" : fNeed.mortgageProtectionTotal;
           
            float percentage= 70;

            IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();
            incomeExpense incomeExpense= incomeExpenseDao.getIncomeExpenseForCase(fNeed.caseId);

            AssetAndLiabilityDAO assetLiabilityDao= new AssetAndLiabilityDAO();
            assetAndLiability assetAndLiability=assetLiabilityDao.getAssetLiabilityForCase(fNeed.caseId);

            if (fNeed.replacementIncomeRequired == null || fNeed.replacementIncomeRequired == "")
            {
                if(incomeExpense!=null)
                {
                    if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                    {
                        txtReplacementIncome.Text=Math.Round((float.Parse(incomeExpense.netMonthlyIncomeAfterCpf)*12*percentage*.01))+"";
                    }
                }
                else
                    txtReplacementIncome.Text="0";
            }
            else
                txtReplacementIncome.Text=fNeed.replacementIncomeRequired;
            

            if (fNeed.emergencyFundsNeeded == null || fNeed.emergencyFundsNeeded == "")
            {
                if(incomeExpense!=null)
                {
                    if (incomeExpense.emergencyFundsNeeded != null &&  incomeExpense.emergencyFundsNeeded == "")
                        txtEmergencyFundsNeeded.Text=incomeExpense.emergencyFundsNeeded;
                }
                else
                    txtEmergencyFundsNeeded.Text="0";
            }
            else
                txtEmergencyFundsNeeded.Text=fNeed.emergencyFundsNeeded;

            
            if(fNeed.otherLiabilities==null || fNeed.otherLiabilities=="")
            {
                
                if(assetAndLiability!=null)
                {
                    float liability=0;


                    if (assetAndLiability.vehicleLoan != null && assetAndLiability.vehicleLoan != "")
                    {
                        liability+=float.Parse(assetAndLiability.vehicleLoan);
                    }

                    if (assetAndLiability.cashLoan != null && assetAndLiability.cashLoan != "")
                    {
                        liability+=float.Parse(assetAndLiability.cashLoan);
                    }

                    if (assetAndLiability.creditCard != null && assetAndLiability.creditCard != "")
                    {
                        liability+=float.Parse(assetAndLiability.creditCard);
                    }


                    if(assetAndLiability.liabilityOthers!=null)
                    {
                        int count=assetAndLiability.liabilityOthers.Count;

                        EntitySet<liabilityOther> others = assetAndLiability.liabilityOthers;
                        for (int i = 0; i < count; i++)
                        {
                            if (others[i].cash != null && others[i].cash != "")
                                liability+= float.Parse(others[i].cash);
                        }
                    }

                    txtOtherLiabilities.Text=liability+"";
                }
                else
                    txtOtherLiabilities.Text="0";
            }

            float existLifeInsurance=0;

            if(fNeed.existingLifeInsurance ==null || fNeed.existingLifeInsurance=="")
            {
                if (incomeExpense != null)
                {
                    if (incomeExpense.DeathTermInsuranceSA != null && incomeExpense.DeathTermInsuranceSA != "")
                    {
                        existLifeInsurance += float.Parse(incomeExpense.DeathTermInsuranceSA);
                    }
                    if (incomeExpense.DeathWholeLifeInsuranceSA != null && incomeExpense.DeathWholeLifeInsuranceSA != "")
                    {
                        existLifeInsurance += float.Parse(incomeExpense.DeathWholeLifeInsuranceSA);
                    }
                    if (incomeExpense.lifeInsuranceSA != null && incomeExpense.lifeInsuranceSA != "")
                    {
                        existLifeInsurance += float.Parse(incomeExpense.lifeInsuranceSA);
                    }
                }
                

                 txtExistingLifeInsurance.Text=existLifeInsurance+"";
            }
            else
                txtExistingLifeInsurance.Text=fNeed.existingLifeInsurance;

            if(fNeed.mortgageProtectionOutstanding ==null || fNeed.mortgageProtectionOutstanding=="")
            {
                if(assetAndLiability!=null)
                {
                    if (assetAndLiability.homeMortgage != null && assetAndLiability.homeMortgage != "")
                    {
                        txtMortgageProtectionOutstanding.Text=assetAndLiability.homeMortgage;
                    }
                    else
                        txtMortgageProtectionOutstanding.Text="0";
                }
            }
            else
                txtMortgageProtectionOutstanding.Text=fNeed.mortgageProtectionOutstanding;



            if(fNeed.mortgageProtectionInsurances ==null || fNeed.mortgageProtectionInsurances=="")
            {
                if(incomeExpense!=null)
                {
                    if (incomeExpense.mortgageSA != null && incomeExpense.mortgageSA != "")
                    {
                        txtMortgageProtectionInsurances.Text=incomeExpense.mortgageSA;
                    }
                    else
                        txtMortgageProtectionInsurances.Text="0";
                }
                else
                   txtMortgageProtectionInsurances.Text="0";
            }
                else
                    txtMortgageProtectionInsurances.Text=fNeed.mortgageProtectionInsurances;

            if (fNeed.inflationAdjustedReturns == null || fNeed.inflationAdjustedReturns == "")
            {
                AssumptionDAO assumptionDao = new AssumptionDAO();
                txtInflationAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage+"";
            }
            else
                txtInflationAdjustedReturns.Text = fNeed.inflationAdjustedReturns;


            if (fNeed.familyNeedsAssets!=null)
                noofmembers.Value = fNeed.familyNeedsAssets.Count+"";
            else
                noofmembers.Value = "0";

            familyNeedsAssetList.DataSource = fNeed.familyNeedsAssets;
            familyNeedsAssetList.DataBind();

            if (fNeed.familyNeedsAssets != null)
            {
                ViewState["assetsSize"] = fNeed.familyNeedsAssets.Count;
                
                double sum = 0;
                txtExistingAssetsFamilyneeds.Text = sum.ToString();
            }            
        }

        

        protected void saveProtectionGoals(object sender, EventArgs e)
        {
            bool retValSaveFamilyNeeds;
            retValSaveFamilyNeeds = saveFamilyNeeds();
            
        }

        private bool saveFamilyNeeds()
        {
            familyNeed familyNeeds = new familyNeed();

            familyNeeds.familyIncPrNeeded = Convert.ToInt32(familyIncPrNeeded.SelectedValue);
            familyNeeds.mortgageNeeded = Convert.ToInt32(mortgagePrNeeded.SelectedValue);

            if (familyNeeds.familyIncPrNeeded == 2)
            {
                familyNeeds.replacementIncomeRequired = txtReplacementIncome.Text;
                familyNeeds.yearsOfSupportRequired = txtYrsOfSupport.Text;
                familyNeeds.inflationAdjustedReturns = txtInflationAdjustedReturns.Text;
                familyNeeds.lumpSumRequired = txtLumpSumRequired.Text;
                familyNeeds.otherLiabilities = txtOtherLiabilities.Text;
                familyNeeds.emergencyFundsNeeded = txtEmergencyFundsNeeded.Text;
                familyNeeds.finalExpenses = txtFinalExpenses.Text;
                familyNeeds.otherFundingNeeds = txtOtherFundingNeeds.Text;
                //familyNeeds.otherComments = txtotherComments.Text;
                familyNeeds.totalRequired = txtTotalRequired.Text;
                familyNeeds.existingLifeInsurance = txtExistingLifeInsurance.Text;
                familyNeeds.existingAssetsFamilyneeds = txtExistingAssetsFamilyneeds.Text;
                //familyNeeds.totalShortfallSurplus = txtTotalShortfallSurplus.Text;
                familyNeeds.totalShortfallSurplus = hiddenTotalShortfallSurplus.Value;
            }
            else if (familyNeeds.familyIncPrNeeded == 1 || familyNeeds.familyIncPrNeeded == 0)
            {
                familyNeeds.replacementIncomeRequired = "0";
                familyNeeds.yearsOfSupportRequired = "0";
                familyNeeds.inflationAdjustedReturns = "0";
                familyNeeds.lumpSumRequired = "0";
                familyNeeds.otherLiabilities = "0";
                familyNeeds.emergencyFundsNeeded = "0";
                familyNeeds.finalExpenses = "0";
                familyNeeds.otherFundingNeeds = "0";
                //familyNeeds.otherComments = txtotherComments.Text;
                familyNeeds.totalRequired = "0";
                familyNeeds.existingLifeInsurance = "0";
                familyNeeds.existingAssetsFamilyneeds = "0";
                //familyNeeds.totalShortfallSurplus = txtTotalShortfallSurplus.Text;
                familyNeeds.totalShortfallSurplus = "0";
            }


            if (familyNeeds.mortgageNeeded == 2)
            {
                familyNeeds.mortgageProtectionOutstanding = txtMortgageProtectionOutstanding.Text;
                familyNeeds.mortgageProtectionInsurances = txtMortgageProtectionInsurances.Text;
                familyNeeds.mortgageProtectionTotal = hiddentxtMortgageProtectionTotal.Value;
            }
            else if (familyNeeds.mortgageNeeded == 1 || familyNeeds.mortgageNeeded == 0)
            {
                familyNeeds.mortgageProtectionOutstanding = "0";
                familyNeeds.mortgageProtectionInsurances = "0";
                familyNeeds.mortgageProtectionTotal = "0";
            }
            
            
            familyNeeds.caseId = ViewState["caseId"].ToString();

            int noofea = 0;
            if (familyNeeds.familyIncPrNeeded == 2)
            {
                if (noofmembers.Value != "")
                {
                    noofea = Int16.Parse(noofmembers.Value);
                }
            }
            

            EntitySet<familyNeedsAsset> eaFNeedsList = new EntitySet<familyNeedsAsset>();
            if (noofea > 0)
            {
                for (int i = 1; i <= noofea; i++)
                {
                    familyNeedsAsset eafn = new familyNeedsAsset();
                    eafn.asset = Request.Form["prifamily-" + i];
                    eafn.presentValue = Request.Form["prifamilyneeds_" + i];

                    if ((Request.Form["prifamily-" + i] != null) && (Request.Form["prifamilyneeds_" + i] != null))
                    {
                        eaFNeedsList.Add(eafn);
                    }

                }
                familyNeeds.familyNeedsAssets = eaFNeedsList;
            }

            if (ViewState["casetypefamily"] != null && ViewState["casetypefamily"].ToString() == "new")
            {
                familyNeeds = familyNeedsDAO.saveFamilyNeeds(familyNeeds);
            }
            else if (ViewState["casetypefamily"] != null && ViewState["casetypefamily"].ToString() == "update")
            {
                familyNeeds = familyNeedsDAO.updateFamilyNeeds(familyNeeds);
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string status = activityStatusCheck.getProtectionGoalFamilyStatus(familyNeeds);
            activityStatusDao.saveOrUpdateActivityStatus(ViewState["caseId"].ToString(), actv, status);

            markStatusOnTab(ViewState["caseId"].ToString());

            string caseStatus = activityStatusCheck.getZPlanStatus(ViewState["caseId"].ToString());

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");

            pdfData = activityStatusCheck.sendDataToSalesPortal(ViewState["caseId"].ToString(), caseStatus, url, sendPdf);

            if (familyNeeds != null)
            {
                populateFamilyNeed(familyNeeds);
            }
            else
            {
                return false;
            }

            return true;
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            saveProtectionGoals(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);

        }


        protected void saveProtectionGoalsAndNext(object sender, EventArgs e)
        {
            sendPdf = false;
            saveProtectionGoals(null, null);
            string url = MenuResolution.getUrl("protectionGoalsMyNeeds");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveProtectionGoalsAndBack(object sender, EventArgs e)
        {
            sendPdf = false;
            saveProtectionGoals(null, null);
            string url = MenuResolution.getUrl("assetLiabilities");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
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

            saveProtectionGoals(null, null);
            
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
                activitystatus activityStatusFamily = null;
                activitystatus activityStatusMyneeds = null;

                activityStatusFamily = activityStatusDao.getActivityForCaseid(caseid, "protectiongoalfamily");
                if (activityStatusFamily != null)
                {
                    if (activityStatusFamily.status == "incomplete")
                    {
                        familyneedstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        familyneedstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusMyneeds = activityStatusDao.getActivityForCaseid(caseid, "protectiongoalmyneeds");
                if (activityStatusMyneeds != null)
                {
                    if (activityStatusMyneeds.status == "incomplete")
                    {
                        myneedstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        myneedstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

            }

        }

        protected void createFamilyneedsPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
            sendPdf = true;
            saveProtectionGoals(null, null);
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }
    }   
}
