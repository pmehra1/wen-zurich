using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Data.Linq;
using System.Collections.Specialized;
using Microsoft.SharePoint.Administration;
using ActivityStatusCheck;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using System.IO;
using PDFGeneration;
using System.Collections.Generic;

namespace Zurich.Layouts.Zurich
{
    public partial class AssetAndLiabilities : LayoutsPageBase
    {

        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";
        protected string csid = "";
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
            
            sendPdf = false;
            saveAssetLiabilitiesDetails(null, null);

            string url = MenuResolution.getUrl(toLink);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            activity = activityStatusDao.getActivity(3);
            ViewState["activity"] = activity;

            lblPdSummarySaveSuccess.Visible = false;
            lblPdSummarySaveFailed.Visible = false;

            netWorth.Attributes.Add("readonly", "readonly");

            assetAndLiability assetLiabilityForCase = null;

            if (!IsPostBack)
            {
                string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];
                string helperUsed = Request.Form["helperUsed"];



                if (nextCaseId != null && nextCaseId != "")
                {
                    csid = nextCaseId;
                }

                if (menuCaseId != null && menuCaseId != "")
                {
                    csid = menuCaseId;
                }

                if (Session["fnacaseid"] != null)
                {
                    csid = Session["fnacaseid"].ToString();
                }

                ViewState["caseId"] = csid;
                AssetAndLiabilityDAO assetAndLiabilityDAO = new AssetAndLiabilityDAO();
                if (csid != null || csid != "")
                {
                    assetLiabilityForCase = assetAndLiabilityDAO.getAssetLiabilityForCase(csid);
                }

                populateAssetAndLiabilityDetails(assetLiabilityForCase, csid);

            }

            markStatusOnTab(csid);
        }


        protected void populateAssetAndLiabilityDetails(assetAndLiability assetLiabilityForCase, string caseId)
        {
            if (assetLiabilityForCase != null)
            {
                this.bankAcctCash.Text = assetLiabilityForCase.bankAcctCash;
                this.cashLoan.Text = assetLiabilityForCase.cashLoan;
                this.cpfoaBal.Text = assetLiabilityForCase.cpfoaBal;
                this.cpfsaBal.Text = assetLiabilityForCase.cpfsaBal;
                this.creditCard.Text = assetLiabilityForCase.creditCard;
                this.homeMortgage.Text = assetLiabilityForCase.homeMortgage;
                this.ilpCash.Text = assetLiabilityForCase.ilpCash;
                this.ilpCpf.Text = assetLiabilityForCase.ilpCpf;
                this.invPropCash.Text = assetLiabilityForCase.invPropCash;
                this.invPropCpf.Text = assetLiabilityForCase.invPropCpf;
                this.lumpSumCash.Text = assetLiabilityForCase.lumpSumCash;
                this.lumpSumCpf.Text = assetLiabilityForCase.lumpSumCpf;
                this.netWorth.Text = assetLiabilityForCase.netWorth;
                this.regularSumCash.Text = assetLiabilityForCase.regularSumCash;
                this.regularSumCpf.Text = assetLiabilityForCase.regularSumCpf;
                this.resPropCash.Text = assetLiabilityForCase.resPropCash;
                this.resPropCpf.Text = assetLiabilityForCase.resPropCpf;
                this.srsBal.Text = assetLiabilityForCase.srsBal;
                this.srsInvCash.Text = assetLiabilityForCase.srsInvCash;
                this.stocksSharesCash.Text = assetLiabilityForCase.stocksSharesCash;
                this.stocksSharesCpf.Text = assetLiabilityForCase.stocksSharesCpf;
                this.unitTrustsCash.Text = assetLiabilityForCase.unitTrustsCash;
                this.unitTrustsCpf.Text = assetLiabilityForCase.unitTrustsCpf;
                this.vehicleLoan.Text = assetLiabilityForCase.vehicleLoan;
                this.cpfMediSaveBalance.Text = assetLiabilityForCase.cpfMediSaveBalance;

                this.assetLiabilitiesEnable.SelectedValue = assetLiabilityForCase.assetAndLiabilityNeeded.ToString();

                if (assetLiabilityForCase.assetAndLiabilityNotNeededReason != null)
                    assetLiabilitiesNotNeededReason.Text = assetLiabilityForCase.assetAndLiabilityNotNeededReason.ToString();
                else
                    assetLiabilitiesNotNeededReason.Text = "";


                this.premiumRecomended.SelectedValue = assetLiabilityForCase.premiumRecomendedNeeded.ToString();

                if (assetLiabilityForCase.assetIncomePercent != null)
                    assetIncomePercent.Text = assetLiabilityForCase.assetIncomePercent.ToString();
                else
                    assetIncomePercent.Text = "";


                this.caseId.Value = assetLiabilityForCase.caseId;
                this.assetList.DataSource = assetLiabilityForCase.investedAssetOthers;
                this.assetList.DataBind();
                this.liabilitiesOtherRepeater.DataSource = assetLiabilityForCase.liabilityOthers;
                this.liabilitiesOtherRepeater.DataBind();
                this.otherPersonalAssetsRepeater.DataSource = assetLiabilityForCase.personalUseAssetsOthers;
                this.otherPersonalAssetsRepeater.DataBind();
                this.caseId.Value = caseId;
                if (assetLiabilityForCase.liabilityOthers.Count > 0)
                    this.otherLiabilitiesNumber.Value = (assetLiabilityForCase.liabilityOthers.Count - 1) + "";
                if (assetLiabilityForCase.personalUseAssetsOthers.Count > 0)
                    this.otherPersonalUsedAssetsNumber.Value = (assetLiabilityForCase.personalUseAssetsOthers.Count - 1) + "";
                if (assetLiabilityForCase.investedAssetOthers.Count > 0)
                    this.otherInvestedAssetsNumber.Value = (assetLiabilityForCase.investedAssetOthers.Count - 1) + "";

                List<string> errors = printErrorMessages(assetLiabilityForCase);
                this.ErrorRepeater.DataSource = errors;
                this.ErrorRepeater.DataBind();

            }
            else
            {
                assetLiabilitiesEnable.SelectedValue = "0";
                premiumRecomended.SelectedValue = "0";
            }
            activityId.Value = caseId;
        }


        public List<string> printErrorMessages(assetAndLiability assetAndLiability)
        {
            List<string> list = new List<string>();

            if (assetAndLiability.assetAndLiabilityNeeded == 0)
            {
                if (assetAndLiability != null)
                {
                    if (
                        (assetAndLiability.regularSumCash == null || assetAndLiability.regularSumCash == "") &&
                        (assetAndLiability.regularSumCpf == null || assetAndLiability.regularSumCpf == "") &&
                        (assetAndLiability.lumpSumCpf == null || assetAndLiability.lumpSumCpf == "") &&
                        (assetAndLiability.lumpSumCash == null || assetAndLiability.lumpSumCash == "")
                        )
                    {
                        list.Add("Please fill one of the following values : Regular sum or Lump Sum (CPF or Cash)");
                    }
                }

                if (assetAndLiability.premiumRecomendedNeeded == 0)
                {
                    if (assetAndLiability.assetIncomePercent == null || assetAndLiability.assetIncomePercent == "")
                    {
                        list.Add("Please enter the Asset/Income %");
                    }
                }

            }
            else
            {
                if (assetAndLiability.assetAndLiabilityNotNeededReason == null || assetAndLiability.assetAndLiabilityNotNeededReason == "")
                {
                    list.Add("Please enter the reason for not considering Assets and Liabilities");
                }
            }

            return list;
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            sendPdf = false;
            saveAssetLiabilitiesDetails(null, null);

            string url = MenuResolution.getUrl(toLink);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveAssetLiabilitiesDetailsNext(object sender, EventArgs e)
        {
            sendPdf = false;
            saveAssetLiabilitiesDetails(null, null);
            string url = MenuResolution.getUrl("protectionGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveAssetLiabilitiesDetailsBack(object sender, EventArgs e)
        {
            sendPdf = false;
            saveAssetLiabilitiesDetails(null, null);
            string url = MenuResolution.getUrl("incomeExpense");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void saveAssetLiabilitiesDetails(object sender, EventArgs e)
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

            AssetAndLiabilityDAO assetAndLiabilityDAO = new AssetAndLiabilityDAO();
            assetAndLiability assetAndLiability = assetAndLiabilityDAO.getAssetLiabilityForCase(caseId);

            string status = "new";

            if (assetAndLiability != null)
            {
                copyAssetBaseClass(assetAndLiability);
                status = "update";
            }
            else
            {
                assetAndLiability = new assetAndLiability();
                copyAssetBaseClass(assetAndLiability);
            }

            int noofmemberOfInvestedAssets = 0;
            int noOfLiabilitiesNumber = 0;
            int noPersonalUsedAssetsNumber = 0;

            if (otherInvestedAssetsNumber.Value != "")
            {
                noofmemberOfInvestedAssets = Int16.Parse(otherInvestedAssetsNumber.Value) + 1;
            }

            if (otherPersonalUsedAssetsNumber.Value != "")
            {
                noPersonalUsedAssetsNumber = Int16.Parse(otherPersonalUsedAssetsNumber.Value) + 1;
            }

            if (otherLiabilitiesNumber.Value != "")
            {
                noOfLiabilitiesNumber = Int16.Parse(otherLiabilitiesNumber.Value) + 1;
            }

            EntitySet<personalUseAssetsOther> personalUseAssets = new EntitySet<personalUseAssetsOther>();
            EntitySet<liabilityOther> liabilityOthers = new EntitySet<liabilityOther>();
            EntitySet<investedAssetOther> investedAssetOther = new EntitySet<investedAssetOther>();


            if (noofmemberOfInvestedAssets > 0)
            {
                for (int i = 0; i < noofmemberOfInvestedAssets; i++)
                {

                    if (Request.Form["priothers-" + i] != null)
                    {
                        investedAssetOther asset = new investedAssetOther();
                        asset.cash = Request.Form["priotherscash-" + i];
                        asset.cpf = Request.Form["priotherscpf-" + i];
                        asset.date = DateTime.Today;
                        asset.assetDesc = Request.Form["priothers-" + i];
                        investedAssetOther.Add(asset);
                    }
                }
            }
            assetAndLiability.investedAssetOthers = investedAssetOther;
            if (noPersonalUsedAssetsNumber > 0)
            {
                for (int i = 0; i < noPersonalUsedAssetsNumber; i++)
                {

                    if (Request.Form["priotherspu-" + i] != null)
                    {
                        personalUseAssetsOther asset = new personalUseAssetsOther();
                        asset.cash = Request.Form["priotherspucash-" + i];
                        asset.cpf = Request.Form["priotherspucpf-" + i];
                        asset.date = DateTime.Today;
                        asset.assetDesc = Request.Form["priotherspu-" + i];
                        personalUseAssets.Add(asset);

                    }
                }
            }
            assetAndLiability.personalUseAssetsOthers = personalUseAssets;
            if (noOfLiabilitiesNumber > 0)
            {
                for (int i = 0; i < noOfLiabilitiesNumber; i++)
                {

                    if (Request.Form["priotherslb-" + i] != null)
                    {
                        liabilityOther liability = new liabilityOther();
                        liability.liabilityDesc = Request.Form["priotherslb-" + i];
                        liability.cash = Request.Form["priotherslbamount-" + i];
                        liability.date = DateTime.Today;
                        liabilityOthers.Add(liability);

                    }
                }
            }

            assetAndLiability.liabilityOthers = liabilityOthers;
            AssetAndLiabilityDAO dao = new AssetAndLiabilityDAO();
            if (status.Equals("new"))
            {
                assetAndLiability.caseId = caseId;
                dao.insertNewAssetLiabilityDetails(assetAndLiability);
            }
            else
                dao.updateAssetLiabilityDetails(assetAndLiability);

            this.assetList.DataSource = investedAssetOther;
            this.assetList.DataBind();
            this.liabilitiesOtherRepeater.DataSource = liabilityOthers;
            this.liabilitiesOtherRepeater.DataBind();
            this.otherPersonalAssetsRepeater.DataSource = personalUseAssets;
            this.otherPersonalAssetsRepeater.DataBind();

            string sts = activityStatusCheck.getAssetLiabilityStatus(assetAndLiability);
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

            if (liabilityOthers.Count > 0)
                this.otherInvestedAssetsNumber.Value = (liabilityOthers.Count - 1) + "";
            if (personalUseAssets.Count > 0)
                this.otherPersonalUsedAssetsNumber.Value = (personalUseAssets.Count - 1) + "";
            if (investedAssetOther.Count > 0)
                this.otherInvestedAssetsNumber.Value = (investedAssetOther.Count - 1) + "";
            activityId.Value = caseId;

            lblPdSummarySaveSuccess.Visible = true;

            List<string> errors = printErrorMessages(assetAndLiability);
            this.ErrorRepeater.DataSource = errors;
            this.ErrorRepeater.DataBind();

        }

        protected assetAndLiability copyAssetBaseClass(assetAndLiability assetAndLiability)
        {

            assetAndLiability.bankAcctCash = bankAcctCash.Text;
            assetAndLiability.cashLoan = cashLoan.Text;
            assetAndLiability.cpfoaBal = cpfoaBal.Text;
            assetAndLiability.cpfsaBal = cpfsaBal.Text;
            assetAndLiability.creditCard = creditCard.Text;
            assetAndLiability.homeMortgage = homeMortgage.Text;
            assetAndLiability.ilpCash = ilpCash.Text;
            assetAndLiability.ilpCpf = ilpCpf.Text;
            assetAndLiability.invPropCash = invPropCash.Text;
            assetAndLiability.invPropCpf = invPropCpf.Text;
            assetAndLiability.lumpSumCash = lumpSumCash.Text;
            assetAndLiability.lumpSumCpf = lumpSumCpf.Text;
            assetAndLiability.regularSumCash = regularSumCash.Text;
            assetAndLiability.regularSumCpf = regularSumCpf.Text;
            assetAndLiability.resPropCash = resPropCash.Text;
            assetAndLiability.resPropCpf = resPropCpf.Text;
            assetAndLiability.srsBal = srsBal.Text;
            assetAndLiability.srsInvCash = srsInvCash.Text;
            assetAndLiability.stocksSharesCash = stocksSharesCash.Text;
            assetAndLiability.stocksSharesCpf = stocksSharesCpf.Text;
            assetAndLiability.submissionDate = DateTime.Today;
            assetAndLiability.unitTrustsCash = unitTrustsCash.Text;
            assetAndLiability.unitTrustsCpf = unitTrustsCpf.Text;
            assetAndLiability.vehicleLoan = vehicleLoan.Text;
            assetAndLiability.cpfMediSaveBalance = cpfMediSaveBalance.Text;
            assetAndLiability.netWorth = netWorth.Text;
            assetAndLiability.assetAndLiabilityNotNeededReason = assetLiabilitiesNotNeededReason.Text;
            assetAndLiability.assetAndLiabilityNeeded = Convert.ToInt32(assetLiabilitiesEnable.SelectedValue);

            assetAndLiability.assetIncomePercent = assetIncomePercent.Text;
            
            if ((premiumRecomended.SelectedValue != null) && (!premiumRecomended.SelectedValue.Equals("")))
                assetAndLiability.premiumRecomendedNeeded = Convert.ToInt32(premiumRecomended.SelectedValue);
            else
            {
                assetAndLiability.premiumRecomendedNeeded = 0;
            }
            return assetAndLiability;
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
                
            saveAssetLiabilitiesDetails(null, null);
            
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

        protected void createAssetliabilityPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }

            sendPdf = true;
            saveAssetLiabilitiesDetails(null, null);
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }

    }
}
