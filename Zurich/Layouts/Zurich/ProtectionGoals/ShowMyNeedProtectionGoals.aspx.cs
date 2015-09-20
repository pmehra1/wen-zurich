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
    public partial class ShowMyNeedProtectionGoals : LayoutsPageBase
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

            activity = activityStatusDao.getActivity(14);
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

                    myNeed = myNeedsDAO.getMyNeed(caseId);

                    if (myNeed != null)
                    {
                        ViewState["casetypemyneeds"] = "update";
                        populateMyNeed(myNeed);
                    }
                    else
                    {
                        ViewState["casetypemyneeds"] = "new";
                        populateMyNeedIfNoNeed(caseId);
                    }
                    
                }

                string url1 = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                lnkExistingAssetsMyNeedsCritical.Attributes.Add("onClick", url1);

                string url2 = "popitup('/_layouts/Zurich/AssetAndLiabilityPopUp.aspx',900,1200);return false;";
                lnkExistingAssetsMyneedsDisability.Attributes.Add("onClick", url2);
            }

            txtlumpSumRequiredForTreatment.Attributes.Add("onblur", "calculate()");
            txtCriticalIllnessInsurance.Attributes.Add("onblur", "calculate()");
            txtExistingAssetsMyNeedsCritical.Attributes.Add("onblur", "calculate()");
            txtTotalShortfallSurplusMyNeeds.Attributes.Add("onblur", "calculate()");
            txtTotalShortfallSurplusMyNeeds.Attributes.Add("readonly", "readonly");

            txtExistingAssetsMyneedsDisability.Attributes.Add("onblur", "calculate()");
            txtShortfallSurplusMyNeeds.Attributes.Add("onblur", "calculate()");
            txtShortfallSurplusMyNeeds.Attributes.Add("readonly", "readonly");

            replacementIncomeRequired.Attributes.Add("onblur", "calculate()");
            disabilityProtectionReplacementIncomeRequired.Attributes.Add("onblur", "calculate()");
            yearsOfSupportRequired.Attributes.Add("onblur", "calculate()");
            disabilityYearsOfSupport.Attributes.Add("onblur", "calculate()");
            inflatedAdjustedReturns.Attributes.Add("onblur", "calculate()");
            inflationAdjustedReturns.Attributes.Add("onblur", "calculate()");
            replacementAmountRequired.Attributes.Add("onblur", "calculate()");

            replacementAmountRequired.Attributes.Add("readonly", "readonly");
            totalRequired.Attributes.Add("readonly", "readonly");

            disabilityReplacementAmountRequired.Attributes.Add("readonly", "readonly");

            txtlumpSumRequiredForTreatment.Attributes.Add("onblur", "calculate()");
            txtCriticalIllnessInsurance.Attributes.Add("onblur", "calculate()");
            disabilityInsurance.Attributes.Add("onblur", "calculate()");
            markStatusOnTab(caseId);
        }

        private string getYearsToSupportCriticalIllness(string caseId)
        {
            AssumptionDAO assumptionDao = new AssumptionDAO();
            string yearsOfSupport = assumptionDao.getAssumptionById(12).percentage + "";
            return yearsOfSupport;
        }


        private string getYearsToSupportDisabilityProtection(string caseId)
        {
            PersonalDetailsDAO dao = new PersonalDetailsDAO();
            personaldetail detail = dao.getPersonalDetail(caseId);
            AssumptionDAO assumptionDao = new AssumptionDAO();
            string yearsOfSupport = "0";
            if (detail != null)
            {
                string dob = detail.datepicker;
                if (dob != null && dob != "")
                {
                    DateTime now = DateTime.Today;
                    DateTime parsedDobDate = Convert.ToDateTime(getDateInProperFormat(dob));  
                    int age = now.Year - parsedDobDate.Year;
                    if (now.Month < parsedDobDate.Month)
                    {
                        age = age - 1;
                    }
                    if (now.Month == parsedDobDate.Month)
                    {
                        if (now.Day < parsedDobDate.Day)
                        {
                            age = age - 1;
                        }
                    }
                    if (age < 62)
                        yearsOfSupport = (62 - age) + "";
                }
            }
            
            return yearsOfSupport;
        }

        public string getDateInProperFormat(string inputDate)
        {
            string outputDate="";

            string day=inputDate.Split('/')[0];
            string month = inputDate.Split('/')[1];
            string year = inputDate.Split('/')[2];

            outputDate = month + "/" + day + "/" + year; 

            return outputDate;
        }

        private void populateMyNeedIfNoNeed(string caseId)
        {
            IncomeExpenseDAO IncomeExpenseDAO = new IncomeExpenseDAO();
            incomeExpense incomeExpense = IncomeExpenseDAO.getIncomeExpenseForCase(caseId);

            AssetAndLiabilityDAO assetLiabilityDao = new AssetAndLiabilityDAO();
            assetAndLiability assetAndLiability = assetLiabilityDao.getAssetLiabilityForCase(caseId);

            float criticalIllnessPercentage = 100;
            float disabilityIncomePercentage = 75;

            criticalIllnessPr2.Selected = true;
            disabilityPr2.Selected = true;
            hospitalmedCoverNeeded2.Selected = true;
            accidentalHealthCoverNeeded2.Selected = true;

            if (incomeExpense != null)
            {
                if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                {
                    replacementIncomeRequired.Text = Math.Round((float.Parse(incomeExpense.netMonthlyIncomeAfterCpf) * 12 * criticalIllnessPercentage * .01)) + "";
                }
            }
            else
                replacementIncomeRequired.Text = "0";

            
            
            if (incomeExpense != null)
            {
                if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                {
                    disabilityProtectionReplacementIncomeRequired.Text = (float.Parse(incomeExpense.netMonthlyIncomeAfterCpf) * 12 * disabilityIncomePercentage * .01) + "";
                }
            }
            else
                disabilityProtectionReplacementIncomeRequired.Text = "0";



            if (incomeExpense != null)
            {
                if (incomeExpense.criticalIllnessSA != null && incomeExpense.criticalIllnessSA != "")
                {
                    txtCriticalIllnessInsurance.Text = incomeExpense.criticalIllnessSA;
                }
                else
                    txtCriticalIllnessInsurance.Text = "0";
            }
            else
                txtCriticalIllnessInsurance.Text = "0";



            if (incomeExpense != null)
            {
                if (incomeExpense.tpdcSA != null && incomeExpense.tpdcSA != "")
                {
                    disabilityInsurance.Text = incomeExpense.tpdcSA;
                }
                else
                    disabilityInsurance.Text = "0";
            }
            else
                disabilityInsurance.Text = "0";


            AssumptionDAO assumptionDao = new AssumptionDAO();
            inflationAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage + "";
            inflatedAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage + "";
            yearsOfSupportRequired.Text = getYearsToSupportCriticalIllness(caseId);
            disabilityYearsOfSupport.Text = getYearsToSupportDisabilityProtection(caseId);

        }

        private void populateMyNeed(myNeed mNeed)
        {

            IncomeExpenseDAO IncomeExpenseDAO = new IncomeExpenseDAO();
            incomeExpense incomeExpense= IncomeExpenseDAO.getIncomeExpenseForCase(mNeed.caseId);

            AssetAndLiabilityDAO assetLiabilityDao = new AssetAndLiabilityDAO();
            assetAndLiability assetAndLiability = assetLiabilityDao.getAssetLiabilityForCase(mNeed.caseId);

            float criticalIllnessPercentage = 100;
            float disabilityIncomePercentage = 75;

            if (mNeed.criticalIllnessPrNeeded != null)
            {
                criticalIllnessPr.SelectedValue = mNeed.criticalIllnessPrNeeded.ToString();
            }
            else
            {
                criticalIllnessPr2.Selected = true;
            }

            if (mNeed.disabilityPrNeeded != null)
            {
                disabilityPr.SelectedValue = mNeed.disabilityPrNeeded.ToString();
            }
            else
            {
                disabilityPr2.Selected = true;
            }

            if (mNeed.hospitalmedCoverNeeded != null)
            {
                hospitalmedCoverNeeded.SelectedValue = mNeed.hospitalmedCoverNeeded.ToString();
            }
            else
            {
                hospitalmedCoverNeeded2.Selected = true;
            }

            if (mNeed.accidentalhealthCoverNeeded != null)
            {
                accidentalHealthCoverNeeded.SelectedValue = mNeed.accidentalhealthCoverNeeded.ToString();
            }
            else
            {
                accidentalHealthCoverNeeded2.Selected = true;
            }
            
            if (mNeed.replacementIncomeRequired == null || mNeed.replacementIncomeRequired == "")
            {
                if (incomeExpense != null)
                {
                    if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                    {
                        replacementIncomeRequired.Text = Math.Round((float.Parse(incomeExpense.netMonthlyIncomeAfterCpf) * 12 * criticalIllnessPercentage * .01)) + "";
                    }
                }
                else
                    replacementIncomeRequired.Text = "0";
            }
            else
                replacementIncomeRequired.Text = mNeed.replacementIncomeRequired;



            if (mNeed.disabilityProtectionReplacementIncomeRequired == null || mNeed.disabilityProtectionReplacementIncomeRequired == "")
            {
                if (incomeExpense != null)
                {
                    if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf != "")
                    {
                        disabilityProtectionReplacementIncomeRequired.Text = (float.Parse(incomeExpense.netMonthlyIncomeAfterCpf) * 12 * disabilityIncomePercentage * .01) + "";
                    }
                }
                else
                    disabilityProtectionReplacementIncomeRequired.Text = "0";
            }
            else
                disabilityProtectionReplacementIncomeRequired.Text = mNeed.disabilityProtectionReplacementIncomeRequired;

            
            if (mNeed.criticalIllnessInsurance == null || mNeed.criticalIllnessInsurance == "")
            {
                if (incomeExpense != null)
                {
                    if (incomeExpense.criticalIllnessSA != null && incomeExpense.criticalIllnessSA != "")
                    {
                        txtCriticalIllnessInsurance.Text = incomeExpense.criticalIllnessSA;
                    }
                    else
                        txtCriticalIllnessInsurance.Text = "0";
                }
                else
                    txtCriticalIllnessInsurance.Text = "0";
             }
            else
                txtCriticalIllnessInsurance.Text = mNeed.criticalIllnessInsurance;



            if (mNeed.disabilityInsurance == null || mNeed.disabilityInsurance == "")
            {
                if (incomeExpense != null)
                {
                    if (incomeExpense.tpdcSA != null && incomeExpense.tpdcSA != "")
                    {
                        disabilityInsurance.Text = incomeExpense.tpdcSA;
                    }
                    else
                        disabilityInsurance.Text = "0";
                }
                else
                    disabilityInsurance.Text = "0";
            }
            else
                disabilityInsurance.Text = mNeed.disabilityInsurance;

            string yearsToSupportCriticalIllness = getYearsToSupportCriticalIllness(mNeed.caseId);
            string yearsToSupportDisabilityProtection = getYearsToSupportDisabilityProtection(mNeed.caseId);
            
            if (mNeed.yearsOfSupportRequired == null || mNeed.yearsOfSupportRequired == "")
            {
                yearsOfSupportRequired.Text = yearsToSupportCriticalIllness;
            }
            else
                yearsOfSupportRequired.Text = mNeed.yearsOfSupportRequired;


            if (mNeed.disabilityYearsOfSupport == null || mNeed.disabilityYearsOfSupport == "")
            {
                disabilityYearsOfSupport.Text = yearsToSupportDisabilityProtection;
            }
            else
                disabilityYearsOfSupport.Text = mNeed.disabilityYearsOfSupport;

            //inflatedAdjustedReturns.Text = (mNeed.inflatedAdjustedReturns == null || mNeed.inflatedAdjustedReturns == "") ? "0" : mNeed.inflatedAdjustedReturns;
            replacementAmountRequired.Text = (mNeed.replacementAmountRequired == null || mNeed.replacementAmountRequired == "") ? "0" : mNeed.replacementAmountRequired;
            disabilityReplacementAmountRequired.Text = (mNeed.disabilityReplacementAmountRequired == null || mNeed.disabilityReplacementAmountRequired == "") ? "0" : mNeed.disabilityReplacementAmountRequired;
            //disabilityInsurance.Text = (mNeed.disabilityInsurance == null || mNeed.disabilityInsurance == "") ? "0" : mNeed.disabilityInsurance;
            //inflationAdjustedReturns.Text = (mNeed.inflationAdjustedReturns == null || mNeed.inflationAdjustedReturns == "") ? "0" : mNeed.inflationAdjustedReturns;

            if (mNeed.inflationAdjustedReturns == null || mNeed.inflationAdjustedReturns == "")
            {
                AssumptionDAO assumptionDao = new AssumptionDAO();
                inflationAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage + "";
            }
            else
                inflationAdjustedReturns.Text = mNeed.inflationAdjustedReturns;

            if (mNeed.inflatedAdjustedReturns == null || mNeed.inflatedAdjustedReturns == "")
            {
                AssumptionDAO assumptionDao = new AssumptionDAO();
                inflatedAdjustedReturns.Text = assumptionDao.getAssumptionById(4).percentage + "";
            }
            else
                inflatedAdjustedReturns.Text = mNeed.inflatedAdjustedReturns;


            txtlumpSumRequiredForTreatment.Text = (mNeed.lumpSumRequiredForTreatment == null || mNeed.lumpSumRequiredForTreatment == "") ? "0" : mNeed.lumpSumRequiredForTreatment;
            //txtCriticalIllnessInsurance.Text = (mNeed.criticalIllnessInsurance == null || mNeed.criticalIllnessInsurance == "") ? "0" : mNeed.criticalIllnessInsurance;
            txtExistingAssetsMyNeedsCritical.Text = (mNeed.existingAssetsMyneeds == null || mNeed.existingAssetsMyneeds == "") ? "0" : mNeed.existingAssetsMyneeds;
            txtExistingAssetsMyneedsDisability.Text = (mNeed.existingAssetsMyneedsDisability == null || mNeed.existingAssetsMyneedsDisability == "") ? "0" : mNeed.existingAssetsMyneedsDisability;
            ddlHospitalTypeList.SelectedValue = (mNeed.typeOfHospitalCoverage == null || mNeed.typeOfHospitalCoverage == "") ? "" : mNeed.typeOfHospitalCoverage;

            if (mNeed.anyExistingPlans != null)
            {
                ddlExistingPlanList.SelectedValue = mNeed.anyExistingPlans == true ? "1" : "0";
            }
            else
            {
                ddlExistingPlanList.SelectedValue = "";
            }
            ViewState["anyExPl"] = ddlExistingPlanList.SelectedValue;

            if (mNeed.typeOfRoomCoverage != null)
            {
                ddlRoomTypeList.SelectedValue = mNeed.typeOfRoomCoverage.ToString();
            }
            else
            {
                ddlRoomTypeList.SelectedValue = "";
            }


            if (mNeed.coverageOldageYesNo != null)
            {
                ddlCoverageOldageYesNo.SelectedValue = mNeed.coverageOldageYesNo == true ? "1" : "0";
            }
            else
                ddlCoverageOldageYesNo.SelectedValue = "";

            
            
            //ddlEpOldageYesNo.SelectedValue = mNeed.epOldageYesNo == true ? "1" : "0";


            if (mNeed.epOldageYesNo != null)
            {
                ddlEpOldageYesNo.SelectedValue = mNeed.epOldageYesNo == true ? "1" : "0";
            }
            else
            {
                ddlEpOldageYesNo.SelectedValue = "";
            }
            ViewState["oldageExPl"] = ddlEpOldageYesNo.SelectedValue;
            
            
            //ddlCoveragePersonalYesNo.SelectedValue = mNeed.coveragePersonalYesNo == true ? "1" : "0";

            if (mNeed.coveragePersonalYesNo != null)
            {
                ddlCoveragePersonalYesNo.SelectedValue = mNeed.coveragePersonalYesNo == true ? "1" : "0";
            }
            else
                ddlCoveragePersonalYesNo.SelectedValue = "";
            
            
            //ddlEpPersonalYesNo.SelectedValue = mNeed.epPersonalYesNo == true ? "1" : "0";


            if (mNeed.epPersonalYesNo != null)
            {
                ddlEpPersonalYesNo.SelectedValue = mNeed.epPersonalYesNo == true ? "1" : "0";
            }
            else
            {
                ddlEpPersonalYesNo.SelectedValue = "";
            }
            ViewState["personalExPl"] = ddlEpPersonalYesNo.SelectedValue;

            if (mNeed.existingPlansDetail != null)
            {
                DetailsOfExistingPlans.Text = mNeed.existingPlansDetail.ToString();
            }
            else
                DetailsOfExistingPlans.Text = "";


            myNeedsCriticalAssetList.DataSource = mNeed.myNeedsCriticalAssets;
            myNeedsCriticalAssetList.DataBind();

            if (mNeed.myNeedsCriticalAssets != null)
            {
                ViewState["noofcriticalassets"] = mNeed.myNeedsCriticalAssets.Count;

                double sum = 0;
                txtTotalShortfallSurplusMyNeeds.Text = sum.ToString();                
            }


            myNeedsDisabilityAssetList.DataSource = mNeed.myNeedsDisabilityAssets;
            myNeedsDisabilityAssetList.DataBind();

            if (mNeed.myNeedsDisabilityAssets != null)
            {
                ViewState["noofdisablityassets"] = mNeed.myNeedsDisabilityAssets.Count;
            }
        }

        private bool saveMyNeeds()
        {
            myNeed myNeeds = new myNeed();

            myNeeds.criticalIllnessPrNeeded = Convert.ToInt16(criticalIllnessPr.SelectedValue);
            
            if (criticalIllnessPr.SelectedValue == "2")
            {
                myNeeds.replacementIncomeRequired = replacementIncomeRequired.Text;
                myNeeds.lumpSumRequiredForTreatment = txtlumpSumRequiredForTreatment.Text;
                myNeeds.yearsOfSupportRequired = yearsOfSupportRequired.Text;
                myNeeds.inflatedAdjustedReturns = inflatedAdjustedReturns.Text;
                myNeeds.replacementAmountRequired = replacementAmountRequired.Text;
                myNeeds.criticalIllnessInsurance = txtCriticalIllnessInsurance.Text;
                myNeeds.existingAssetsMyneeds = txtExistingAssetsMyNeedsCritical.Text;
                myNeeds.totalShortfallSurplusMyNeeds = hiddentxtTotalShortfallSurplusMyNeeds.Value;
                myNeeds.totalRequired = totalRequired.Text;
            }
            else if (criticalIllnessPr.SelectedValue == "1" || criticalIllnessPr.SelectedValue == "0")
            {
                myNeeds.replacementIncomeRequired = "0";
                myNeeds.lumpSumRequiredForTreatment = "0";
                myNeeds.yearsOfSupportRequired = "0";
                myNeeds.inflatedAdjustedReturns = "0";
                myNeeds.replacementAmountRequired = "0";
                myNeeds.criticalIllnessInsurance = "0";
                myNeeds.existingAssetsMyneeds = "0";
                myNeeds.totalShortfallSurplusMyNeeds = "0";
                myNeeds.totalRequired = "0";
            }

            myNeeds.hospitalmedCoverNeeded = Convert.ToInt16(hospitalmedCoverNeeded.SelectedValue);
            myNeeds.accidentalhealthCoverNeeded = Convert.ToInt16(accidentalHealthCoverNeeded.SelectedValue);


            if (hospitalmedCoverNeeded.SelectedValue == "2")
            {
                myNeeds.typeOfHospitalCoverage = ddlHospitalTypeList.SelectedValue;

                if (ddlExistingPlanList.SelectedValue == "")
                {
                    myNeeds.anyExistingPlans = null;
                }
                else
                {
                    myNeeds.anyExistingPlans = ddlExistingPlanList.SelectedValue == "1" ? true : false;
                }

                if (ddlRoomTypeList.SelectedValue == "")
                {
                    myNeeds.typeOfRoomCoverage = null;
                }
                else
                {
                    myNeeds.typeOfRoomCoverage = Convert.ToInt16(ddlRoomTypeList.SelectedValue);
                }
            }
            else if (hospitalmedCoverNeeded.SelectedValue == "1" || hospitalmedCoverNeeded.SelectedValue == "0")
            {
                myNeeds.typeOfHospitalCoverage = "";
                myNeeds.anyExistingPlans = null;
                myNeeds.typeOfRoomCoverage = null;
            }
            
            
           if (ddlCoverageOldageYesNo.SelectedValue == "")
           {
               myNeeds.coverageOldageYesNo = null;
           }
           else
           {
               myNeeds.coverageOldageYesNo = ddlCoverageOldageYesNo.SelectedValue == "1" ? true : false;
           }

           if (ddlEpOldageYesNo.SelectedValue == "")
           {
               myNeeds.epOldageYesNo = null;
           }
           else
           {
               myNeeds.epOldageYesNo = ddlEpOldageYesNo.SelectedValue == "1" ? true : false;
           }

           if (ddlCoveragePersonalYesNo.SelectedValue == "")
           {
               myNeeds.coveragePersonalYesNo = null;
           }
           else
           {
               myNeeds.coveragePersonalYesNo = ddlCoveragePersonalYesNo.SelectedValue == "1" ? true : false;
           }

           if (ddlEpPersonalYesNo.SelectedValue == "")
           {
               myNeeds.epPersonalYesNo = null;
           }
           else
           {
               myNeeds.epPersonalYesNo = ddlEpPersonalYesNo.SelectedValue == "1" ? true : false;            
           }

           if (ddlExistingPlanList.SelectedValue == "" && ddlEpOldageYesNo.SelectedValue == "" && ddlEpPersonalYesNo.SelectedValue == "")
           {
               myNeeds.existingPlansDetail = "";
           }
           else
           {
               if (ddlExistingPlanList.SelectedValue != "" || ddlEpOldageYesNo.SelectedValue != "" || ddlEpPersonalYesNo.SelectedValue != "")
               {
                   myNeeds.existingPlansDetail = DetailsOfExistingPlans.Text;
               }
           }

            myNeeds.disabilityPrNeeded = Convert.ToInt16(disabilityPr.SelectedValue);
            
            if (disabilityPr.SelectedValue == "2")
            {
                myNeeds.disabilityProtectionReplacementIncomeRequired = disabilityProtectionReplacementIncomeRequired.Text;
                myNeeds.disabilityYearsOfSupport = disabilityYearsOfSupport.Text;
                myNeeds.disabilityReplacementAmountRequired = disabilityReplacementAmountRequired.Text;
                myNeeds.disabilityInsurance = disabilityInsurance.Text;
                myNeeds.inflationAdjustedReturns = inflationAdjustedReturns.Text;
                myNeeds.existingAssetsMyneedsDisability = txtExistingAssetsMyneedsDisability.Text;
                myNeeds.shortfallSurplusMyNeeds = hiddentxtShortfallSurplusMyNeeds.Value;
            }
            else if (disabilityPr.SelectedValue == "1" || disabilityPr.SelectedValue == "0")
            {
                myNeeds.disabilityProtectionReplacementIncomeRequired = "0";
                myNeeds.disabilityYearsOfSupport = "0";
                myNeeds.disabilityReplacementAmountRequired = "0";
                myNeeds.disabilityInsurance = "0";
                myNeeds.inflationAdjustedReturns = "0";
                myNeeds.existingAssetsMyneedsDisability = "0";
                myNeeds.shortfallSurplusMyNeeds = "0";
            }

            myNeeds.caseId = ViewState["caseId"].ToString();

            int noofeacritical = 0;
            if (criticalIllnessPr.SelectedValue == "2")
            {
                if (noofcriticalassets.Value != "")
                {
                    noofeacritical = Int16.Parse(noofcriticalassets.Value);
                }
            }

            EntitySet<myNeedsCriticalAsset> eaMyNeedsCriticalList = new EntitySet<myNeedsCriticalAsset>();
            if (noofeacritical > 0)
            {
                for (int i = 1; i <= noofeacritical; i++)
                {
                    myNeedsCriticalAsset eaMNCritical = new myNeedsCriticalAsset();
                    eaMNCritical.asset = Request.Form["primyneedscritical-" + i];
                    eaMNCritical.presentValue = Request.Form["primyneedplus_" + i];

                    if ((Request.Form["primyneedscritical-" + i] != null) && (Request.Form["primyneedplus_" + i] != null))
                    {
                        eaMyNeedsCriticalList.Add(eaMNCritical);
                    }

                }
                myNeeds.myNeedsCriticalAssets = eaMyNeedsCriticalList;
            }

            int noOfDisability = 0;
            if (disabilityPr.SelectedValue == "2")
            {
                if (noofdisabilityassets.Value != "")
                {
                    noOfDisability = Int16.Parse(noofdisabilityassets.Value);
                }
            }
            
            EntitySet<myNeedsDisabilityAsset> eaMyNeedsDisabilityList = new EntitySet<myNeedsDisabilityAsset>();
            if (noOfDisability > 0)
            {
                for (int i = 1; i <= noOfDisability; i++)
                {
                    myNeedsDisabilityAsset eaMNDisability = new myNeedsDisabilityAsset();
                    eaMNDisability.asset = Request.Form["primyneedsdisb-" + i];
                    eaMNDisability.presentValue = Request.Form["primyneedpluspart2_" + i];

                    if ((Request.Form["primyneedsdisb-" + i] != null) && (Request.Form["primyneedpluspart2_" + i] != null))
                    {
                        eaMyNeedsDisabilityList.Add(eaMNDisability);
                    }

                }
                myNeeds.myNeedsDisabilityAssets = eaMyNeedsDisabilityList;
            }

            if (ViewState["casetypemyneeds"] != null && ViewState["casetypemyneeds"].ToString() == "new")
            {
                myNeeds = myNeedsDAO.saveMyNeeds(myNeeds);
            }
            else if (ViewState["casetypemyneeds"] != null && ViewState["casetypemyneeds"].ToString() == "update")
            {
                myNeeds = myNeedsDAO.updateMyNeeds(myNeeds);
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string status = activityStatusCheck.getProtectionGoalMyneedsStatus(myNeeds);
            activityStatusDao.saveOrUpdateActivityStatus(ViewState["caseId"].ToString(), actv, status);

            markStatusOnTab(ViewState["caseId"].ToString());

            string caseStatus = activityStatusCheck.getZPlanStatus(ViewState["caseId"].ToString());

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");

            pdfData = activityStatusCheck.sendDataToSalesPortal(ViewState["caseId"].ToString(), caseStatus, url, sendPdf);
            
            if (myNeeds != null)
            {
                populateMyNeed(myNeeds);
            }
            else
            {
                return false;
            }

            return true;
        }

        protected void saveProtectionGoals(object sender, EventArgs e)
        {
            bool retValSaveMyNeeds;

            retValSaveMyNeeds = saveMyNeeds();
            
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
            string url = MenuResolution.getUrl("savingGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveProtectionGoalsAndBack(object sender, EventArgs e)
        {
            sendPdf = false;
            saveProtectionGoals(null, null);
            string url = MenuResolution.getUrl("protectionGoals");
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

        protected void createMyneedsPdf(object sender, EventArgs e)
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
