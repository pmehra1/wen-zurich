using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Data.Linq;
using System.Collections.Specialized;
using Microsoft.SharePoint.Administration;
using ActivityStatusCheck;

namespace Zurich.Layouts.Zurich
{
    public partial class AssetAndLiabilityPopUp : LayoutsPageBase
    {
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            activity = activityStatusDao.getActivity(3);
            ViewState["activity"] = activity;

            
            //string text = "2020";
            string caseId = "";
            if (!IsPostBack)
            {
                string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];
                string helperUsed = Request.Form["helperUsed"];



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
                AssetAndLiabilityDAO assetAndLiabilityDAO = new AssetAndLiabilityDAO();
                if (caseId != null || caseId != "")
                {
                    assetAndLiability assetLiabilityForCase = assetAndLiabilityDAO.getAssetLiabilityForCase(caseId);
                    if (assetLiabilityForCase != null)
                    {
                        populateAssetAndLiabilityDetails(assetLiabilityForCase, caseId);
                    }
                }

            }
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

                this.caseId.Value = assetLiabilityForCase.caseId;
                this.assetList.DataSource = assetLiabilityForCase.investedAssetOthers;
                this.assetList.DataBind();
                this.liabilitiesOtherRepeater.DataSource = assetLiabilityForCase.liabilityOthers;
                this.liabilitiesOtherRepeater.DataBind();
                this.otherPersonalAssetsRepeater.DataSource = assetLiabilityForCase.personalUseAssetsOthers;
                this.otherPersonalAssetsRepeater.DataBind();
                this.caseId.Value = caseId;
                if (assetLiabilityForCase.liabilityOthers.Count > 0)
                    this.otherInvestedAssetsNumber.Value = (assetLiabilityForCase.liabilityOthers.Count - 1) + "";
                if (assetLiabilityForCase.personalUseAssetsOthers.Count > 0)
                    this.otherPersonalUsedAssetsNumber.Value = (assetLiabilityForCase.personalUseAssetsOthers.Count - 1) + "";
                if (assetLiabilityForCase.investedAssetOthers.Count > 0)
                    this.otherInvestedAssetsNumber.Value = (assetLiabilityForCase.investedAssetOthers.Count - 1) + "";
            }
            activityId.Value = caseId;
        }


        
    }
}
