using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAO;
using ActivityStatusCheck;
using PDFGeneration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;

namespace Zurich.Layouts.Zurich.PortFolioBuilder
{
    public partial class PortFolioModelling : LayoutsPageBase
    {
        protected string caseID = string.Empty;
        protected string strRiskProfileID = string.Empty;
        protected string strProfileName = string.Empty;
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected string activity = "";
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

            if (!savePortFolioModel())
            {
                //if (Convert.ToInt32(txtTotalPremium.Text) > 100)
                //{
                    //lblErrorMsgGreaterthan100.Visible = true;
                    return;
                //}
            }
            
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {           
            activity = activityStatusDao.getActivity(11);
            ViewState["activity"] = activity;
            
            premium.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();
            txtTotalPremium.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();
            txtAllocationAmtTotal.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();
            lblTotal.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();
            //followAssetAllocationOnRiskProfile.Attributes.Add("onclick", "return confirm('Data will be lost when?');");
            //nonCoreFunds.Attributes.Add("onclick", "return confirm('Are you sure?');");
            //allocationBasedOnRiskProfile.Attributes.Add("onclick", "return confirm('Are you sure?');");
            //optnAgreeRiskProfile.Attributes.Add("onclick", "showChangeRiskProfileMessage();");
            
            premium.Attributes.Add("onblur", "roundOffValues();");
            txtTotalPremium.Attributes.Add("onblur", "roundOffValues();");
            txtAllocationAmtTotal.Attributes.Add("onblur", "roundOffValues();");
           // txtTotalPremium.Attributes.Add("OnKeyPress", "DisableTyping();");            
            txtTotalPremium.BackColor = Color.LightGray;
            txtAllocationAmtTotal.BackColor = Color.LightGray;

            try
            {
                if (!IsPostBack)
                {
                    string menuCaseId = Request.QueryString["caseid"];

                    if (Session["fnacaseid"] != null)
                    {
                        caseID = Session["fnacaseid"].ToString();
                    }

                    if (menuCaseId != null && menuCaseId != "")
                    {
                        caseID = menuCaseId;
                    }

                    ViewState["caseid"] = caseID;
                    activityId.Value = caseID;                    

                    HideFieldsOnFormLoad();

                    string strLclRiskProfileName = LoadRiskProfileDetails(caseID);
                    if (strLclRiskProfileName == null || strLclRiskProfileName == string.Empty)
                    {                        
                        EnableDisableControls(false);
                        btnBackFundPlotter.Enabled = true;
                        btnNextFundPlotter.Enabled = true;
                        btnBackPortFolioModel.Enabled = true;
                        btnNextPortFolioModel.Enabled = true;
                        return;
                    }
                    else
                    {                        
                        EnableDisableControls(true);
                    }

                    if (ViewState["strProfileName"] != null)
                    {
                        strProfileName = ViewState["strProfileName"].ToString();
                    }

                    if (ViewState["strRiskProfileID"] != null)
                    {
                        strRiskProfileID = ViewState["strRiskProfileID"].ToString();
                    }                    

                    LoadPortFolioDetails();

                    if ((txtTotalPremium.Text != string.Empty && (Convert.ToInt32(txtTotalPremium.Text) < 100)) 
                         && !(optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex == 1))
                    {
                        //if (lblSubmitMessageLessThan100.Visible == false)
                        //{
                        if (optnAgreeRiskProfileYes.Selected == true && lblRiskProfile.Text == "Capital Preservation")
                        {
                            lblAllocationLessThan100.Visible = false;
                        }
                        else
                        {
                            lblAllocationLessThan100.Visible = true;
                        }                            
                        //}
                    }
                }
                else
                {
                    if (ViewState["caseid"] != null)
                    {
                        caseID = ViewState["caseid"].ToString();
                    }

                    if (ViewState["strProfileName"] != null)
                    {
                        strProfileName = ViewState["strProfileName"].ToString();
                    }

                    if (ViewState["strRiskProfileID"] != null)
                    {
                        strRiskProfileID = ViewState["strRiskProfileID"].ToString();
                    }
                }

                cst.Value = markStatusOnTab(caseID);
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: PortFolioModelling Method: Page_Load";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }
        }

        protected string LoadRiskProfileDetails(string caseID)
        {
            RiskProfileDAO riskProfile = new RiskProfileDAO();
            RiskProfileAnalysis riskProfileDetails = riskProfile.getRiskProfileForCase(caseID);

            if (riskProfileDetails != null)
            {
                if (riskProfileDetails.riskProfileValue != null)
                {
                    ViewState["strRiskProfileID"] = riskProfileDetails.riskProfileValue;
                }
                if (riskProfileDetails.riskProfileName != null)
                {
                    ViewState["strProfileName"] = riskProfileDetails.riskProfileName;
                }

                return riskProfileDetails.riskProfileName;
            }
            else
            {
                return string.Empty;
            }            
        }
        
        protected void LoadPortFolioDetails()
        {
            lblRiskProfile.Text = strProfileName;

            PortFolioModellingDAO portFolioDAO = new PortFolioModellingDAO();
            DataTable dtPortFolioMaster = portFolioDAO.getPortFolioMaster(caseID);

            if ((dtPortFolioMaster == null || dtPortFolioMaster.Rows.Count == 0) && strProfileName == "Capital Preservation")
            {
                EnableDisableControls(false);
                btnBackFundPlotter.Enabled = true;
                btnNextFundPlotter.Enabled = true;
                btnBackPortFolioModel.Enabled = true;
                btnNextPortFolioModel.Enabled = true;
                btnPrintRiskPlotter.Enabled = true;
                btnPrint.Enabled = true;

                optnAgreeRiskProfile.Enabled = true;
                imgRangeOfReturns.ImageUrl = string.Empty;

                return;
            }

            if (dtPortFolioMaster != null && dtPortFolioMaster.Rows.Count > 0)
            {                
                lblRiskProfile.Text = dtPortFolioMaster.Rows[0]["riskProfileName"].ToString();

                bool agreeWithRiskProfile = (bool)dtPortFolioMaster.Rows[0]["agreeWithRiskProfile"];
                if (agreeWithRiskProfile)
                {
                    optnAgreeRiskProfileYes.Selected = true;
                }
                else
                {
                    optnAgreeRiskProfileNo.Selected = true;
                }
                optnAgreeRiskProfile_SelectedIndexChanged(null, null);
                if (optnAgreeRiskProfileYes.Selected == true && lblRiskProfile.Text == "Capital Preservation")
                {
                    return;
                }

                ddlRiskProfileList.SelectedValue = dtPortFolioMaster.Rows[0]["preferredRiskPRofile"].ToString();
                if (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex == 1)
                {
                    ddlRiskProfileList_SelectedIndexChanged(null, null);
                }

                if (optnAgreeRiskProfileYes.Selected == true || (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex != 1))
                {
                    bool farp = (bool)dtPortFolioMaster.Rows[0]["followAssetAllocationOnRiskProfileYesNo"];
                    if (farp)
                    {
                        optnAssetAllocRiskProfile1.Selected = true;
                    }
                    else
                    {
                        optnAssetAllocRiskProfile2.Selected = true;
                    }
                    followAllocationBasedOnRiskProfile_SelectedIndexChanged(null, null);

                    if (!farp)
                    {
                        //True = Fund Risk Plottor, False = Fund Selection
                        bool arp = (bool)dtPortFolioMaster.Rows[0]["assetAllocationOnRiskProfileYesNo"];
                        if (arp)
                        {
                            optnAllocRiskProfile1.Selected = true;
                        }
                        else
                        {
                            optnAllocRiskProfile2.Selected = true;
                        }

                        onAllocationBasedOnRiskProfile_SelectedIndexChanged(null, null);
                    }

                    if (farp)
                    {
                        bool ncf = (bool)dtPortFolioMaster.Rows[0]["includeNonCoreFundsYesNo"];
                        if (ncf)
                        {
                            optnNonCoreFunds1.Selected = true;
                        }
                        else
                        {
                            optnNonCoreFunds2.Selected = true;
                        }

                        nonCoreFunds_SelectedIndexChanged(null, null);
                    }

                    string pselect = dtPortFolioMaster.Rows[0]["premiumSelect"].ToString().Trim();
                    if (pselect == "0")
                    {
                        optnPremiumSelect1.Selected = true;
                    }
                    else
                    {
                        optnPremiumSelect2.Selected = true;
                    }
                }

                premium.Text = dtPortFolioMaster.Rows[0]["premiumAmount"].ToString();

                ddlPaymentMode.SelectedValue = dtPortFolioMaster.Rows[0]["paymentMode"].ToString();
                premiumSelect_SelectedIndexChanged(null, null);

                txtTotalPremium.Text = dtPortFolioMaster.Rows[0]["premiumPercent"].ToString();
                txtAllocationAmtTotal.Text = dtPortFolioMaster.Rows[0]["premiumTotalAmount"].ToString();
                                                                
            }

            ShowRateOfReturnsImage();
        }

        private void ShowRateOfReturnsImage()
        {
            String coreUrl = "~/_layouts/Zurich/images/Content/RangeOfReturnsImages/CoreAssets/";
            String nonCoreUrl = "~/_layouts/Zurich/images/Content/RangeOfReturnsImages/NonCoreAssets/";
            String core_image = "";
            String non_core_image = "";
            
            if (lblRiskProfile.Text == string.Empty)
            {
                imgRangeOfReturns.ImageUrl = null;
                return;
            }
            if (optnAgreeRiskProfileYes.Selected == true || (optnAgreeRiskProfileYes.Selected == false && optnAgreeRiskProfileNo.Selected == false))
            {
                switch (lblRiskProfile.Text.Trim())
                {
                    case "Cautious":
                        core_image = "CoreAssets_Cautious.png";
                        non_core_image = "NonCoreAssets_Cautious.png";
                        break;
                    case "Moderately Cautious":
                        core_image = "CoreAssets_ModCautious.png";
                        non_core_image = "NonCoreAssets_ModCautious.png";
                        break;
                    case "Balanced":
                        core_image = "CoreAssets_Balanced.png";
                        non_core_image = "NonCoreAssets_Balanced.png"; 
                        break;
                    case "Moderately Adventurous":
                        core_image = "CoreAssets_ModAdventurous.png";
                        non_core_image = "NonCoreAssets_ModAdventurous.png"; 
                        break;
                    case "Adventurous":
                        core_image = "CoreAssets_Adventurous.png";
                        non_core_image = "NonCoreAssets_Adventurous.png";
                        break;
                    case "Capital Preservation":
                        core_image = "";
                        non_core_image = "";
                        break;
                    default:
                        break;
                }

                if (optnNonCoreFunds1.Selected == true)
                {
                    lblLineGraph.Text = "Range of Returns with Non Core Assets";
                    nonCoreUrl = nonCoreUrl + non_core_image;
                    if (non_core_image == string.Empty)
                    {
                        imgRangeOfReturns.ImageUrl = string.Empty;
                    }
                    else
                    {
                        imgRangeOfReturns.ImageUrl = nonCoreUrl;
                    }
                }
                if (optnNonCoreFunds2.Selected == true || (optnNonCoreFunds1.Selected == false && optnNonCoreFunds2.Selected == false))
                {
                    lblLineGraph.Text = "Range of Returns with Core Assets";
                    coreUrl = coreUrl + core_image;
                    if (core_image == string.Empty)
                    {
                        imgRangeOfReturns.ImageUrl = string.Empty;
                    }
                    else
                    {
                        imgRangeOfReturns.ImageUrl = coreUrl;
                    }
                }
            }
            else
            {
                if (lblRiskProfile.Text.Trim() == "Cautious")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Cautious")
                    {
                        core_image = "CoreAssets_CautiousModCautious.png";
                        non_core_image = "NonCoreAssets_CautiousModCautious.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Balanced")
                    {
                        core_image = "CoreAssets_CautiousBalanced.png";
                        non_core_image = "NonCoreAssets_CautiousBalanced.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Adventurous")
                    {
                        core_image = "CoreAssets_CautiousModAdventurous.png";
                        non_core_image = "NonCoreAssets_CautiousModAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Adventurous")
                    {
                        core_image = "CoreAssets_CautiousAdventurous.png";
                        non_core_image = "NonCoreAssets_CautiousAdventurous.png";
                    }
                    else
                    {
                        core_image = "CoreAssets_Cautious.png";
                        non_core_image = "NonCoreAssets_Cautious.png";
                    }
                }
                if (lblRiskProfile.Text.Trim() == "Moderately Cautious")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Cautious")
                    {
                        core_image = "CoreAssets_CautiousModCautious.png";
                        non_core_image = "NonCoreAssets_CautiousModCautious.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Balanced")
                    {
                        core_image = "CoreAssets_ModCautiousBalanced.png";
                        non_core_image = "NonCoreAssets_ModCautiousBalanced.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Adventurous")
                    {
                        core_image = "CoreAssets_ModCautiousModAdventurous.png";
                        non_core_image = "NonCoreAssets_ModCautiousModAdenturous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Adventurous")
                    {
                        core_image = "CoreAssets_ModCautiousAdventurous.png";
                        non_core_image = "NonCoreAssets_ModCautiousAdventurous.png";
                    }
                    else
                    {
                        core_image = "CoreAssets_ModCautious.png";
                        non_core_image = "NonCoreAssets_ModCautious.png";
                    }
                }
                if (lblRiskProfile.Text.Trim() == "Balanced")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Cautious")
                    {
                        core_image = "CoreAssets_CautiousBalanced.png";
                        non_core_image = "NonCoreAssets_CautiousBalanced.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Cautious")
                    {
                        core_image = "CoreAssets_ModCautiousBalanced.png";
                        non_core_image = "NonCoreAssets_ModCautiousBalanced.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Adventurous")
                    {
                        core_image = "CoreAssets_BalancedModAdventurous.png";
                        non_core_image = "NonCoreAssets_BalancedModAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Adventurous")
                    {
                        core_image = "CoreAssets_BalancedAdventurous.png";
                        non_core_image = "NonCoreAssets_BalancedAdventurous.png";
                    }
                    else
                    {
                        core_image = "CoreAssets_Balanced.png";
                        non_core_image = "NonCoreAssets_Balanced.png"; 
                    }
                }
                if (lblRiskProfile.Text.Trim() == "Moderately Adventurous")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Cautious")
                    {
                        core_image = "CoreAssets_CautiousModAdventurous.png";
                        non_core_image = "NonCoreAssets_CautiousModAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Cautious")
                    {
                        core_image = "CoreAssets_ModCautiousModAdventurous.png";
                        non_core_image = "NonCoreAssets_ModCautiousModAdenturous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Balanced")
                    {
                        core_image = "CoreAssets_BalancedModAdventurous.png";
                        non_core_image = "NonCoreAssets_BalancedModAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Adventurous")
                    {
                        core_image = "CoreAssets_ModAdventurousAdventurous.png";
                        non_core_image = "NonCoreAssets_ModAdventurousAdventurous.png";
                    }
                    else 
                    {
                        core_image = "CoreAssets_ModAdventurous.png";
                        non_core_image = "NonCoreAssets_ModAdventurous.png"; 
                    }
                }
                if (lblRiskProfile.Text.Trim() == "Adventurous")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Cautious")
                    {
                        core_image = "CoreAssets_CautiousAdventurous.png";
                        non_core_image = "NonCoreAssets_CautiousAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Cautious")
                    {
                        core_image = "CoreAssets_ModCautiousAdventurous.png";
                        non_core_image = "NonCoreAssets_ModCautiousAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Balanced")
                    {
                        core_image = "CoreAssets_BalancedAdventurous.png";
                        non_core_image = "NonCoreAssets_BalancedAdventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Adventurous")
                    {
                        core_image = "CoreAssets_ModAdventurousAdventurous.png";
                        non_core_image = "NonCoreAssets_ModAdventurousAdventurous.png";
                    }
                    else
                    {
                        core_image = "CoreAssets_Adventurous.png";
                        non_core_image = "NonCoreAssets_Adventurous.png";
                    }
                }

                if (lblRiskProfile.Text.Trim() == "Capital Preservation")
                {
                    if (ddlRiskProfileList.SelectedItem.ToString() == "Cautious")
                    {
                        core_image = "CoreAssets_Cautious.png";
                        non_core_image = "NonCoreAssets_Cautious.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Cautious")
                    {
                        core_image = "CoreAssets_ModCautious.png";
                        non_core_image = "NonCoreAssets_ModCautious.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Balanced")
                    {
                        core_image = "CoreAssets_Balanced.png";
                        non_core_image = "NonCoreAssets_Balanced.png"; 
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Moderately Adventurous")
                    {
                        core_image = "CoreAssets_ModAdventurous.png";
                        non_core_image = "NonCoreAssets_ModAdventurous.png"; 
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Adventurous")
                    {
                        core_image = "CoreAssets_Adventurous.png";
                        non_core_image = "NonCoreAssets_Adventurous.png";
                    }
                    else if (ddlRiskProfileList.SelectedItem.ToString() == "Capital Preservation")
                    {
                        core_image = "";
                        non_core_image = "";
                    }
                }

                
                if (optnNonCoreFunds1.Selected == true)
                {
                    lblLineGraph.Text = "Range of Returns with Non Core Assets";
                    nonCoreUrl = nonCoreUrl + non_core_image;

                    if (non_core_image == string.Empty)
                    {
                        imgRangeOfReturns.ImageUrl = string.Empty;
                    }
                    else
                    {
                        imgRangeOfReturns.ImageUrl = nonCoreUrl;
                    }
                }
                if (optnNonCoreFunds2.Selected == true || (optnNonCoreFunds1.Selected == false && optnNonCoreFunds2.Selected == false))
                {
                    lblLineGraph.Text = "Range of Returns with Core Assets";
                    coreUrl = coreUrl + core_image;
                    
                    if (core_image == string.Empty)
                    {
                        imgRangeOfReturns.ImageUrl = string.Empty;
                    }
                    else
                    {
                        imgRangeOfReturns.ImageUrl = coreUrl;
                    }
                }
            }   
            
        }

        private void HideErrorMessages()
        {
            lblFundSplitterErrorMessage1.Visible = false;
            lblFundSplitterErrorMessage2.Visible = false;

            lblSubmitMessage.Visible = false;
            lblSubmitMessageLessThan100.Visible = false;
            lblAllocationLessThan100.Visible = false;
            lblErrorMessage.Visible = false;
            lblErrorMsgGreaterthan100.Visible = false;
            lblErrorMsgNotRecommendedPercent.Visible = false;

            lblErrorMsgAgreeWithRiskProfile.Visible = false;
            lblErrorMsgPreferredRiskProfile.Visible = false;
            lblErrorMsgFollowAsset.Visible = false;
            lblErrorMsgAllocationOnRiskProfile.Visible = false;
            lblErrorMsgCoreNonCore.Visible = false;
            lblErrorMsgSingleRegularPremium.Visible = false;
            lblErrorMsgPremiumAmt.Visible = false;
            lblErrorMsgPaymentMode.Visible = false;
        }

        private void HideFieldsOnFormLoad()
        {
            HideErrorMessages();
            disclaimer.Visible = false;
            
            lblIncludeNonCoreFunds.Visible = false;
            lblPreferredRiskProfile.Visible = false;
            ddlRiskProfileList.Visible = false;
            nonCoreFunds.Visible = false;            
            allocationBasedOnRiskProfile.Visible = false;
            trProfilePercent.Visible = false;
            //fundplotterButton.Visible = false;
            portfoliomodelSaveButton.Visible = false;
            //funds.Visible = false;
        }

        private void ClearFieldsForAgreeWithRiskProfile()
        {
            ddlRiskProfileList.SelectedIndex = 0;
            optnAssetAllocRiskProfile1.Selected = false;
            optnAssetAllocRiskProfile2.Selected = false;
            optnNonCoreFunds1.Selected = false;
            optnNonCoreFunds2.Selected = false;
            optnAllocRiskProfile1.Selected = false;
            optnAllocRiskProfile2.Selected = false;
            //optnPremiumSelect1.Selected = false;
            //optnPremiumSelect2.Selected = false;
            //premium.Text = "0";
            //ddlPaymentMode.SelectedIndex = 0;
            txtTotalPremium.Text = "0";
            txtAllocationAmtTotal.Text = "0";
        }

        private void ClearFieldsForRiskProfileList()
        {            
            optnAssetAllocRiskProfile1.Selected = false;
            optnAssetAllocRiskProfile2.Selected = false;
            optnNonCoreFunds1.Selected = false;
            optnNonCoreFunds2.Selected = false;
            optnAllocRiskProfile1.Selected = false;
            optnAllocRiskProfile2.Selected = false;
            optnPremiumSelect1.Selected = false;
            optnPremiumSelect2.Selected = false;
            premium.Text = "0";
            ddlPaymentMode.SelectedIndex = 0;
            txtTotalPremium.Text = "0";
            txtAllocationAmtTotal.Text = "0";
        }

        private void ClearFieldsForFollowAssetAllocation()
        {
            //ddlRiskProfileList.SelectedIndex = 0;
            //optnAssetAllocRiskProfile1.Selected = false;
            //optnAssetAllocRiskProfile2.Selected = false;
            optnNonCoreFunds1.Selected = false;
            optnNonCoreFunds2.Selected = false;
            optnAllocRiskProfile1.Selected = false;
            optnAllocRiskProfile2.Selected = false;
            //optnPremiumSelect1.Selected = false;
            //optnPremiumSelect2.Selected = false;
            //premium.Text = "0";
            //ddlPaymentMode.SelectedIndex = 0;
            txtTotalPremium.Text = "0";
            txtAllocationAmtTotal.Text = "0";
        }

        private void ClearFieldsForAllocationBasedOnRiskProfile()
        {
            //ddlRiskProfileList.SelectedIndex = 0;
            //optnAssetAllocRiskProfile1.Selected = false;
            //optnAssetAllocRiskProfile2.Selected = false;
            optnNonCoreFunds1.Selected = false;
            optnNonCoreFunds2.Selected = false;
            //optnAllocRiskProfile1.Selected = false;
            //optnAllocRiskProfile2.Selected = false;
            //optnPremiumSelect1.Selected = false;
            //optnPremiumSelect2.Selected = false;
            //premium.Text = "0";
            //ddlPaymentMode.SelectedIndex = 0;
            txtTotalPremium.Text = "0";
            txtAllocationAmtTotal.Text = "0";
        }

        private void ClearFieldsForCoreNonCore()
        {
            //ddlRiskProfileList.SelectedIndex = 0;
            //optnAssetAllocRiskProfile1.Selected = false;
            //optnAssetAllocRiskProfile2.Selected = false;
            //optnNonCoreFunds1.Selected = false;
            //optnNonCoreFunds2.Selected = false;
            optnAllocRiskProfile1.Selected = false;
            optnAllocRiskProfile2.Selected = false;
            //optnPremiumSelect1.Selected = false;
            //optnPremiumSelect2.Selected = false;
            //premium.Text = "0";
            //ddlPaymentMode.SelectedIndex = 0;
            txtTotalPremium.Text = "0";
            txtAllocationAmtTotal.Text = "0";
        }

        private void ClearAllGrids()
        {          
            grdFundRiskPlotter.DataSource = null;
            grdFundRiskPlotter.DataBind();
            
            grdFundsSelection.DataSource = null;
            grdFundsSelection.DataBind();
            
            grdNonCoreFunds.DataSource = null;
            grdNonCoreFunds.DataBind();
            
            grdSecondaryFunds.DataSource = null;
            grdSecondaryFunds.DataBind();

            trProfilePercent.Visible = false;
        }

        private void hideEverything()
        {   
            HideErrorMessages();
            fundsCoreNoncore.Visible = false;
            disclaimer.Visible = false;
            fundRiskPlotter.Visible = false;
            trProfilePercent.Visible = false;
            lblProfilePercent.Visible = false;         
        }

        private void EnableDisableControls(bool bVal)
        {            
            followAssetAllocationOnRiskProfile.Enabled = bVal;            
            optnAgreeRiskProfile.Enabled = bVal;            
            ddlRiskProfileList.Enabled = bVal;
            nonCoreFunds.Enabled = bVal;
            allocationBasedOnRiskProfile.Enabled = bVal;
            premiumSelect.Enabled = bVal;
            ddlPaymentMode.Enabled = bVal;
            premium.Enabled = bVal;                  

            btnPrintRiskPlotter.Enabled = bVal;
            btnBackFundPlotter.Enabled = bVal;
            btnSaveFundPloter.Enabled = bVal;
            btnNextFundPlotter.Enabled = bVal;
            btnPrint.Enabled = bVal;
            btnBackPortFolioModel.Enabled = bVal;
            btnSavePortFolioModel.Enabled = bVal;
            btnNextPortFolioModel.Enabled = bVal;
        }

        public DataTable getAllAssets(String id, bool isInitialLoad)
        {
            string[] words = id.Split('-');
            int assetId = int.Parse(words[0]);
            int riskProfileId = 0;
            String profileName = words[1];
            switch (profileName)
            {
                case "Capital Preservation":
                    riskProfileId = 0;
                    break;
                case "Cautious":
                    riskProfileId = 1;
                    break;
                case "Moderately Cautious":
                    riskProfileId = 2;
                    break;
                case "Balanced":
                    riskProfileId = 3;
                    break;
                case "Moderately Adventurous":
                    riskProfileId = 4;
                    break;
                case "Adventurous":
                    riskProfileId = 5;
                    break;
                default:

                    break;
            }

            PortFolioModellingDAO portFolioModellingDAO = new PortFolioModellingDAO();
            DataTable dtAssets = portFolioModellingDAO.getAllAssets(riskProfileId, assetId, caseID, isInitialLoad);

            return dtAssets;
        }

        public DataTable getFundRiskPlotter(String id, bool isInitialLoad)
        {
            string[] words = id.Split('-');
            int assetId = int.Parse(words[0]);
            int riskProfileId = 0;
            String profileName = words[1];
            switch (profileName)
            { 
                case "Capital Preservation":
                    riskProfileId = 0;
                    break;
                case "Cautious":
                    riskProfileId = 1;
                    break;
                case "Moderately Cautious":
                    riskProfileId = 2;
                    break;
                case "Balanced":
                    riskProfileId = 3;
                    break;
                case "Moderately Adventurous":
                    riskProfileId = 4;
                    break;
                case "Adventurous":
                    riskProfileId = 5;
                    break;
                default:

                    break;
            }

            PortFolioModellingDAO portFolioModellingDAO = new PortFolioModellingDAO();
            DataTable dtAssets = portFolioModellingDAO.getFunds(riskProfileId, assetId, caseID, isInitialLoad);

            return dtAssets;
        }

        public DataTable getFundSelection(bool isInitialLoad)
        {
            PortFolioModellingDAO portFolioModellingDAO = new PortFolioModellingDAO();
            DataTable assets = portFolioModellingDAO.getFundSelection(caseID, isInitialLoad);

            return assets;

        }
        
        private bool ValidateFundSelection()
        {
            double sumFundSelection = 0;
            bool hasError = false;

            HideErrorMessages();
            
            if (optnAssetAllocRiskProfile2.Selected == true && optnAllocRiskProfile2.Selected == true)
            {
                foreach (GridViewRow gvRow in grdFundsSelection.Rows)
                {
                    TextBox tbAllocationPercent = (TextBox)gvRow.FindControl("txtAllocation");
                    string strAllocationPercent = tbAllocationPercent.Text;

                    if (strAllocationPercent != null && strAllocationPercent != "" && Convert.ToDouble(strAllocationPercent) > 0)
                    {
                        sumFundSelection += Convert.ToDouble(strAllocationPercent);
                    }
                }
            }

            if (sumFundSelection > 100)
            {
                hasError = true;
                lblFundSplitterErrorMessage2.Visible = true;
            }            

            if (!hasError)
                return true;
            else
                return false;
        }

        private bool validateFundPlotter()
        {
            double summationPrimary = 0;
            double summationSecondary = 0;

            List<GridViewRow> gvRowsPrimary = new List<GridViewRow>();
            List<GridViewRow> gvRowsSecondary = new List<GridViewRow>();

            int profilePercentage = 0;            
            bool hasError = false;

            HideErrorMessages();

            string strFinalRiskProfile = string.Empty;
            if (optnAgreeRiskProfileYes.Selected == true)
            {
                strFinalRiskProfile = strProfileName;
            }
            if (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex > 0)
            {
                strFinalRiskProfile = ddlRiskProfileList.SelectedItem.Text;
            }

            switch (strFinalRiskProfile)
            {
                case "Capital Preservation":
                    profilePercentage = 0;
                    break;
                case "Cautious":
                    profilePercentage = 15;
                    break;
                case "Moderately Cautious":
                    profilePercentage = 25;
                    break;
                case "Balanced":
                    profilePercentage = 35;
                    break;
                case "Moderately Adventurous":
                    profilePercentage = 45;
                    break;
                case "Adventurous":
                    profilePercentage = 55;
                    break;
                default:
                    profilePercentage = 0;
                    break;
            }
                        
            
            if (optnAssetAllocRiskProfile2.Selected == true && optnAllocRiskProfile1.Selected == true)
            {
                foreach (GridViewRow gvRow in grdFundRiskPlotter.Rows)
                {
                    gvRowsPrimary.Add(gvRow);
                }
                foreach (GridViewRow gvRow in grdSecondaryFunds.Rows)
                {
                    gvRowsSecondary.Add(gvRow);
                }

                if (gvRowsPrimary != null)
                {
                    foreach (GridViewRow gvr in gvRowsPrimary)
                    {                        
                        TextBox tbAllocationPercent = (TextBox)gvr.FindControl("txtAllocation");                                                                       
                        string strAllocationPercent = tbAllocationPercent.Text;
                        
                        if (strAllocationPercent != null && strAllocationPercent != "" && Convert.ToDouble(strAllocationPercent) > 0)
                        {
                            summationPrimary += Convert.ToDouble(strAllocationPercent);
                        }                        
                    } 

                    foreach (GridViewRow gvr in gvRowsSecondary)
                    {
                        TextBox tbAllocationPercent = (TextBox)gvr.FindControl("txtAllocation");                                                                        
                        string strAllocationPercent = tbAllocationPercent.Text;                        

                        if (strAllocationPercent != null && strAllocationPercent != "" && Convert.ToDouble(strAllocationPercent) > 0)
                        {
                            summationSecondary += Convert.ToDouble(strAllocationPercent); 
                        }
                    }
                }
            } 
            
		    if (summationSecondary > profilePercentage) {
		        hasError = true;
                lblFundSplitterErrorMessage1.Visible = true;
		    }

		    if ((summationSecondary + summationPrimary) > 100) {
		        hasError = true;
                lblFundSplitterErrorMessage2.Visible = true;
		    }

            //if ((summationSecondary + summationPrimary) < 100) {
            //    hasError = true;
            //    lblFundSplitterErrorMessage2.Visible = true;
            //}
		        
		    if (!hasError)
		        return true;
            else
                return false;
        }

        private bool validateFundAllocation()
        {
            HideErrorMessages();

		   
		    double totalSumPercentage = 0;           
		    bool hasError = false;

            List<GridViewRow> gvRowsAlloc = new List<GridViewRow>();

            if (optnAssetAllocRiskProfile1.Selected == true && (optnNonCoreFunds1.Selected == true || optnNonCoreFunds2.Selected == true))
            {
                foreach (GridViewRow gvRow in grdNonCoreFunds.Rows)
                {
                    gvRowsAlloc.Add(gvRow);
                }
            }
                       
            if (totalSumPercentage > 100)
            {
                lblErrorMsgGreaterthan100.Visible = true;
                hasError = true;
            }

            if (hasError)
                return false;

            Dictionary<string, string> dcAssetPercent = new Dictionary<string, string>();            
            foreach (GridViewRow gvr in gvRowsAlloc)
            {
                Label lblAssedId = (Label)gvr.FindControl("lblAssetId");                
                Label lblPercent = (Label)gvr.FindControl("lblPercentage");

                string iAssetId = lblAssedId.Text;                
                string strPercent = string.Empty;

                if (iAssetId != string.Empty)
                {
                    if (lblPercent != null && lblPercent.Text != null && lblPercent.Text != string.Empty)
                    {
                        strPercent = lblPercent.Text;
                    }
                    if (!dcAssetPercent.ContainsKey(iAssetId))
                    {
                        dcAssetPercent.Add(iAssetId, strPercent);                    
                    }                    
                }                
            }
            
            foreach (KeyValuePair<string, string> pair in dcAssetPercent)
            {
                string prevAssetID = string.Empty;
                double cntPercent = 0;
                int cnt = 0;
                foreach (GridViewRow gvr in gvRowsAlloc)
                {
                    Label lblAssedId = (Label)gvr.FindControl("lblAssetId");
                    TextBox tbAllocationPercent = (TextBox)gvr.FindControl("txtAllocation");
                    Label lblPercent = (Label)gvr.FindControl("lblPercentage");

                    string iAssetId = lblAssedId.Text;                    
                    string strAllocationPercent = tbAllocationPercent.Text;                    
                    string strPercent = string.Empty;

                    if (iAssetId != string.Empty)
                    {
                        if (lblPercent != null && lblPercent.Text != null && lblPercent.Text != string.Empty)
                        {
                            strPercent = lblPercent.Text;
                        }
                    }

                    if (cnt == 0)
                    {
                        prevAssetID = iAssetId;
                    }

                    if (strAllocationPercent != string.Empty && prevAssetID == iAssetId)
                    {
                        cntPercent = cntPercent + Convert.ToDouble(strAllocationPercent);
                    }
                    else if (prevAssetID != iAssetId)
                    {
                        if (strAllocationPercent != string.Empty)
                        {
                            cntPercent = Convert.ToDouble(strAllocationPercent);
                        }
                        else
                        {
                            cntPercent = 0;
                        }
                    }                    

                    if (cntPercent > Convert.ToDouble(dcAssetPercent[iAssetId]))
                    {
                        lblErrorMsgNotRecommendedPercent.Visible = true;
                        hasError = true;
                        break;
                    }

                    cnt = cnt + 1;                    
                    prevAssetID = iAssetId;
                }
                if (hasError)                    
                    return false; 
            }
                        
            if (!hasError)
                return true;
            else
                return false;            

            //for (var i = 0; i < elementsArray.length; i++) {
            //    if (elementsArray[i].type == 'text') {
            //        if (elementsArray[i] != null) {
            //            var obj = elementsArray[i].id.split("-");
            //            var assetId = obj[1];
            //            // alert('assetId-->' + assetId + '--previousAssetId' + previousAssetId + '--' + elementsArray[i].id);

            //            if (assetId == previousAssetId) {
            //                //   alert('here');
            //                // alert(elementsArray[i].id);
            //                var temp = document.getElementById(elementsArray[i].id).value;

            //                // alert("temp-> " + temp);
            //                if (!isNaN(temp)) {
            //                    sumPercentages = parseFloat(sumPercentages) + parseFloat(temp);
            //                    totalSumPercentage = parseFloat(totalSumPercentage) + parseFloat(temp);
            //                    //   alert("sumPercentages" + sumPercentages);
            //                }


            //            }
            //            else {
            //                // alert("inthegridpercentage-->" + parseFloat(obj[2]) + "---->" + sumPercentages + "--->assetId-" + obj[1] + " previous percent-->" + previousExpectedPercent)
            //                if (sumPercentages != previousExpectedPercent) {
            //                    $('#lblErrorMessage').show();
            //                    $('#lblErrorMessage').slideDown('slow');
            //                    hasError = 1;
            //                    // alert("Sorry error compared to --> " + previousExpectedPercent + "the sum Percentage calculated was-->" + sumPercentages);
            //                }
            //                var temp = document.getElementById(elementsArray[i].id).value;
            //                totalSumPercentage = parseFloat(totalSumPercentage) + parseFloat(temp);
            //                sumPercentages = temp;
            //                previousAssetId = assetId;
            //                previousExpectedPercent = parseFloat(obj[2]);
            //            }
            //        }
            //    }
            //}		       
        }

        private bool validateAllRequiredFields()
        {            
            HideErrorMessages();

            if (optnAgreeRiskProfileYes.Selected == false && optnAgreeRiskProfileNo.Selected == false)
            {
                lblErrorMsgAgreeWithRiskProfile.Visible = true;
                return false;
            }
            if (optnAgreeRiskProfileNo.Selected == true)
            {
                if (ddlRiskProfileList.SelectedIndex == 0)
                {
                    lblErrorMsgPreferredRiskProfile.Visible = true;
                    return false;
                }
            }
            if (optnAssetAllocRiskProfile1.Selected == false && optnAssetAllocRiskProfile2.Selected == false)
            {
                lblErrorMsgFollowAsset.Visible = true;
                return false;
            }            
            if (optnAssetAllocRiskProfile1.Selected == true && (optnNonCoreFunds1.Selected == false && optnNonCoreFunds2.Selected == false))
            {
                lblErrorMsgCoreNonCore.Visible = true;                
                return false;
            }
            if (optnAssetAllocRiskProfile2.Selected == true && optnAllocRiskProfile1.Selected == false && optnAllocRiskProfile2.Selected == false)
            {
                lblErrorMsgAllocationOnRiskProfile.Visible = true;
                return false;
            }            
            if (optnPremiumSelect1.Selected == false && optnPremiumSelect2.Selected == false)
            {
                lblErrorMsgSingleRegularPremium.Visible = true;
                return false;
            }            
            if (premium.Text == "")
            {
                lblErrorMsgPremiumAmt.Visible = true;
                return false;
            }
            if (ddlPaymentMode.SelectedIndex == 0 && optnPremiumSelect2.Selected == true)
            {
                lblErrorMsgPaymentMode.Visible = true;
                return false;
            }
            
            return true;
        }


        private bool savePortFolioModel()
        {
            try
            {
                if ((optnAgreeRiskProfileYes.Selected == true && lblRiskProfile.Text != "Capital Preservation") || (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex > 1))
                {
                    if (!validateAllRequiredFields())
                    {
                        return false;
                    }
                }

                int riskProfileId = -1;
                switch (strProfileName)
                {
                    case "Capital Preservation":
                        riskProfileId = 0;
                        break;
                    case "Cautious":
                        riskProfileId = 1;
                        break;
                    case "Moderately Cautious":
                        riskProfileId = 2;
                        break;
                    case "Balanced":
                        riskProfileId = 3;
                        break;
                    case "Moderately Adventurous":
                        riskProfileId = 4;
                        break;
                    case "Adventurous":
                        riskProfileId = 5;
                        break;                    
                    default:
                        break;
                }

                bool agreeRiskProfile = true;
                if (optnAgreeRiskProfileYes.Selected == true)
                {
                    agreeRiskProfile = true;
                }
                if (optnAgreeRiskProfileNo.Selected == true)
                {
                    agreeRiskProfile = false;
                }

                string newRiskProfile = "-1";
                newRiskProfile = ddlRiskProfileList.SelectedValue.ToString();
                                
                bool followAssetAllocationOnRiskProfileYesNo = false;
                if (optnAssetAllocRiskProfile1.Selected == true)
                {
                    followAssetAllocationOnRiskProfileYesNo = true;
                }
                if (optnAssetAllocRiskProfile2.Selected == true)
                {
                    followAssetAllocationOnRiskProfileYesNo = false;
                }

                //True = Fund Risk Plottor, False = Fund Selection
                bool assetAllocationOnRiskProfileYesNo = false;
                if (optnAllocRiskProfile1.Selected == true)
                {
                    assetAllocationOnRiskProfileYesNo = true;
                }
                if (optnAllocRiskProfile2.Selected == true)
                {
                    assetAllocationOnRiskProfileYesNo = false;
                }

                bool includeNonCoreFundsYesNo = false;
                if (optnNonCoreFunds1.Selected == true)
                {
                    includeNonCoreFundsYesNo = true;
                }
                if (optnNonCoreFunds2.Selected == true)
                {
                    includeNonCoreFundsYesNo = false;
                }

                int premiumSelect = -1;
                if (optnPremiumSelect1.Selected == true)
                {
                    premiumSelect = 0;
                }
                if (optnPremiumSelect2.Selected == true)
                {
                    premiumSelect = 1;
                }

                double premiumAmount = 0;
                double premiumPercent = 0;
                double totalPremiumAmount = 0;
                if (premium.Text != null && premium.Text != "")
                {
                    premiumAmount = Convert.ToDouble(premium.Text);
                }

                string paymentMode = "-1";
                paymentMode = ddlPaymentMode.SelectedValue.ToString();

                List<int> lstAssetId = new List<int>();
                List<int> lstFundId = new List<int>();
                List<int> lstAllocationPercent = new List<int>();
                List<int> lstAmount = new List<int>();

                DataTable dtPortFolioBuilderDetail = new DataTable();
                dtPortFolioBuilderDetail.Columns.Add("AssetId", typeof(string));
                dtPortFolioBuilderDetail.Columns.Add("FundId", typeof(string));
                dtPortFolioBuilderDetail.Columns.Add("AllocationPercent", typeof(string));
                dtPortFolioBuilderDetail.Columns.Add("Amount", typeof(string));

                List<GridViewRow> gvRows = new List<GridViewRow>();
                if (optnAssetAllocRiskProfile1.Selected == true && (optnNonCoreFunds1.Selected == true || optnNonCoreFunds2.Selected == true))
                {
                    if (!validateFundAllocation())
                    {
                        return false;
                    }
                    foreach (GridViewRow gvRow in grdNonCoreFunds.Rows)
                    {
                        gvRows.Add(gvRow);
                    }
                }
                if (optnAssetAllocRiskProfile2.Selected == true && optnAllocRiskProfile1.Selected == true)
                {
                    if (!validateFundPlotter())
                    {
                        return false;
                    }
                    foreach (GridViewRow gvRow in grdFundRiskPlotter.Rows)
                    {
                        gvRows.Add(gvRow);
                    }
                    foreach (GridViewRow gvRow in grdSecondaryFunds.Rows)
                    {
                        gvRows.Add(gvRow);
                    }
                }
                if (optnAssetAllocRiskProfile2.Selected == true && optnAllocRiskProfile2.Selected == true)
                {
                    if (!ValidateFundSelection())
                    {
                        return false;
                    }
                    foreach (GridViewRow gvRow in grdFundsSelection.Rows)
                    {
                        gvRows.Add(gvRow);
                    }
                }

                if (gvRows != null)
                {
                    foreach (GridViewRow gvr in gvRows)
                    {
                        Label lblAssedId = (Label)gvr.FindControl("lblAssetId");
                        Label lblFundId = (Label)gvr.FindControl("lblFundId");
                        TextBox tbAllocationPercent = (TextBox)gvr.FindControl("txtAllocation");
                        TextBox tbAmount = (TextBox)gvr.FindControl("txtAmount");

                        string iAssetId = lblAssedId.Text;
                        string iFundId = lblFundId.Text;
                        string strAllocationPercent = tbAllocationPercent.Text;
                        string strAmount = tbAmount.Text;
                        double totalPercent = 0;
                        double totalpremiumAmt = 0;

                        if ((strAllocationPercent != null && strAllocationPercent != "" && Convert.ToDouble(strAllocationPercent) > 0) ||
                            (strAmount != null && strAmount != "" && Convert.ToDouble(strAmount) > 0))
                        {
                            if (strAllocationPercent == null || strAllocationPercent == "")
                            {
                                strAllocationPercent = "0";
                            }
                            if ( Convert.ToDouble(strAllocationPercent) == 0)
                            {
                                continue;
                            }
                            //{
                            totalPercent = Convert.ToDouble(strAllocationPercent);
                            //}
                            if (strAmount == null || strAmount == "")
                            {
                                strAmount = "0";
                            }
                            //else
                            //{
                            totalpremiumAmt = Convert.ToDouble(strAmount);
                            //}
                            dtPortFolioBuilderDetail.Rows.Add(iAssetId, iFundId, strAllocationPercent, strAmount);
                        }

                        premiumPercent = premiumPercent + totalPercent;
                        totalPremiumAmount = totalPremiumAmount + totalpremiumAmt;
                        //if (txtTotalPremium.Text != null && txtTotalPremium.Text != "")
                        //{
                        //premiumPercent = Convert.ToDouble(txtTotalPremium.Text);
                        //}
                    }

                    PortFolioModellingDAO portFolioDAO = new PortFolioModellingDAO();
                    bool bResult = portFolioDAO.SavePortFolioBuilderInfo(caseID,
                                                                        riskProfileId,
                                                                        agreeRiskProfile,
                                                                        newRiskProfile,
                                                                        followAssetAllocationOnRiskProfileYesNo,
                                                                        assetAllocationOnRiskProfileYesNo,
                                                                        includeNonCoreFundsYesNo,
                                                                        premiumSelect,
                                                                        premiumAmount,
                                                                        paymentMode,
                                                                        premiumPercent,
                                                                        totalPremiumAmount,
                                                                        dtPortFolioBuilderDetail);

                    if (bResult)
                    {
                        string actv = "";
                        if (ViewState["activity"] != null)
                        {
                            actv = ViewState["activity"].ToString();
                        }

                        string status = activityStatusCheck.getPortfolioBuilderStatus(premiumPercent);
                        activityStatusDao.saveOrUpdateActivityStatus(caseID, actv, status);

                        cst.Value = markStatusOnTab(caseID);
                        ScriptManager.RegisterStartupScript(this, typeof(string), "TabStatus", "tabstatus('"+cst.Value+"');", true);

                        string caseStatus = activityStatusCheck.getZPlanStatus(caseID);

                        string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
                        pdfData = activityStatusCheck.sendDataToSalesPortal(caseID, caseStatus, url, sendPdf);

                        LoadPortFolioDetails();
                        
                        if ((txtTotalPremium.Text != string.Empty && (Convert.ToInt32(txtTotalPremium.Text) < 100)) 
                            && !(optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex == 1))
                        {
                            lblSubmitMessageLessThan100.Visible = true;
                            lblSubmitMessage.Visible = false;
                        }
                        else
                        {
                            lblSubmitMessageLessThan100.Visible = false;
                            lblSubmitMessage.Visible = true;
                        }

                        return true;
                    }
                }                
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: PortFolioModelling Method: SavePortFolioModel";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return false;
        }

        public void followAllocationBasedOnRiskProfile_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearFieldsForFollowAssetAllocation();
            ClearAllGrids();
            disclaimer.Visible = false;

            if (optnAssetAllocRiskProfile1.Selected == true)
            {
                lblIncludeNonCoreFunds.Visible = true;
                nonCoreFunds.Visible = true;
                allocationBasedOnRiskProfile.Visible = false;
                
                fundplotterButton.Visible = false;
                portfoliomodelSaveButton.Visible = true;
            }
            if (optnAssetAllocRiskProfile2.Selected == true)
            {                
                lblIncludeNonCoreFunds.Visible = false;
                nonCoreFunds.Visible = false;
                allocationBasedOnRiskProfile.Visible = true;

                fundplotterButton.Visible = true;
                portfoliomodelSaveButton.Visible = false;
            }
        }

        public void onAllocationBasedOnRiskProfile_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearFieldsForAllocationBasedOnRiskProfile(); 
            ClearAllGrids();

            bool isInitialLoad = false;
            if (sender == null && e == null)
            {
                isInitialLoad = true;
            }

            if (optnAllocRiskProfile1.Selected == true)
            {
                bool confirmMsg = false;//valuesenteredForRiskPlotter();
                bool answer = false;
                if (confirmMsg == true)
                {
                    //answer = confirm("All the entered information would be lost. Do you wish to proceed ?");
                }
                else
                {
                    answer = true;
                }
                if (answer)
                {
                    hideEverything();
                    fundRiskPlotter.Visible = true;
                    trProfilePercent.Visible = true;
                    lblProfilePercent.Visible = true;

                    int profilePercentage = 0;
                    string strFinalRiskProfile = string.Empty;
                    if (optnAgreeRiskProfileYes.Selected == true)
                    {
                        strFinalRiskProfile = strProfileName;
                    }
                    if (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex > 0)
                    {
                        strFinalRiskProfile = ddlRiskProfileList.SelectedItem.Text;
                    }

                    switch (strFinalRiskProfile)
                    {
                        case "Capital Preservation":
                            profilePercentage = 0;
                            break;
                        case "Cautious":
                            profilePercentage = 15;
                            break;
                        case "Moderately Cautious":
                            profilePercentage = 25;
                            break;
                        case "Balanced":
                            profilePercentage = 35;
                            break;
                        case "Moderately Adventurous":
                            profilePercentage = 45;
                            break;
                        case "Adventurous":
                            profilePercentage = 55;
                            break;
                        default:
                            profilePercentage = 0;
                            break;
                    }
                    lblProfilePercent.Text = "Secondary Funds (Up to " + profilePercentage + "% limit)"; 
                    
                    DataTable dtAssets = getFundRiskPlotter("4-" + strFinalRiskProfile, isInitialLoad);
                    grdFundRiskPlotter.DataSource = dtAssets;
                    grdFundRiskPlotter.DataBind();
                    MergeRows(grdFundRiskPlotter);

                    DataTable dtSecondaryFunds = getFundRiskPlotter("5-" + strFinalRiskProfile, isInitialLoad);
                    grdSecondaryFunds.DataSource = dtSecondaryFunds;
                    grdSecondaryFunds.DataBind();
                    MergeRows(grdSecondaryFunds);
                }
            }
            if (optnAllocRiskProfile2.Selected == true)
            {
                bool confirmMsg = false; //valuesenteredForRiskPlotter();
                bool answer = false;
                if (confirmMsg == true)
                {
                    //answer = confirm("All the entered information would be lost. Do you wish to proceed ?");
                }
                else
                {
                    answer = true;
                }
                if (answer)
                {
                    hideEverything();
                    fundRiskPlotter.Visible = true;
                    disclaimer.Visible = true;
                    
                    DataTable dtFundSelection = getFundSelection(isInitialLoad);
                    grdFundsSelection.DataSource = dtFundSelection;
                    grdFundsSelection.DataBind();
                    MergeRows(grdFundsSelection);
                }
            }
        }

        public void nonCoreFunds_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearFieldsForCoreNonCore(); 
            ClearAllGrids();
            disclaimer.Visible = false;

            ShowRateOfReturnsImage();

            bool isInitialLoad = false;
            if (sender == null && e == null)
            {
                isInitialLoad = true;
            }

            if (optnNonCoreFunds1.Selected == true)
            { 
                 bool confirmMsg = false;//valuesenteredForCorenoncore();
                 bool answer = false;
                 if( confirmMsg == true)
                 {
                    //answer = confirm("All the entered information would be lost. Do you wish to proceed ?");
                 }else
                 {
		            answer = true;
                 }
		         if (answer) 
                 {
		            hideEverything();
                    fundsCoreNoncore.Visible = true;
		            
                    string strFinalRiskProfile = string.Empty;
                    if (optnAgreeRiskProfileYes.Selected == true)
                    {
                        strFinalRiskProfile = strProfileName;
                    }
                    if (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex > 0)
                    {
                        strFinalRiskProfile = ddlRiskProfileList.SelectedItem.Text;
                    }

                    DataTable dtAssets = getAllAssets("2-" + strFinalRiskProfile, isInitialLoad);
                     grdNonCoreFunds.DataSource = dtAssets;
                     grdNonCoreFunds.DataBind();
                     MergeRows(grdNonCoreFunds);
                 }
            }
            if (optnNonCoreFunds2.Selected == true)
            { 
                bool confirmMsg = false; //valuesenteredForCorenoncore();
                bool answer = false;
                if( confirmMsg == true)
                {
                    //answer = confirm("All the entered information would be lost. Do you wish to proceed ?");
                }else
                {
		            answer = true;
                }
                if (answer)
                {
                    hideEverything();
                    fundsCoreNoncore.Visible = true;
                                        
                    string strFinalRiskProfile = string.Empty;
                    if (optnAgreeRiskProfileYes.Selected == true)
                    {
                        strFinalRiskProfile = strProfileName;
                    }
                    if (optnAgreeRiskProfileNo.Selected == true && ddlRiskProfileList.SelectedIndex > 0)
                    {
                        strFinalRiskProfile = ddlRiskProfileList.SelectedItem.Text;
                    }

                    DataTable dtAssets = getAllAssets("1-" + strFinalRiskProfile, isInitialLoad);
                    grdNonCoreFunds.DataSource = dtAssets;
                    grdNonCoreFunds.DataBind();
                    MergeRows(grdNonCoreFunds);
                }            
            }
        }
                
        public void optnAgreeRiskProfile_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (optnAgreeRiskProfileYes.Selected == true)
            {
                lblPreferredRiskProfile.Visible = false;
                ddlRiskProfileList.Visible = false;
            }

            if (optnAgreeRiskProfileNo.Selected == true)
            {
                lblPreferredRiskProfile.Visible = true;
                ddlRiskProfileList.Visible = true;
            }
                        
            ClearFieldsForAgreeWithRiskProfile();
            ClearAllGrids();
            disclaimer.Visible = false;

            if (optnAgreeRiskProfileYes.Selected == true && lblRiskProfile.Text == "Capital Preservation")
            {
                EnableDisableControls(false);
                btnBackFundPlotter.Enabled = true;
                btnSaveFundPloter.Enabled = true;
                btnNextFundPlotter.Enabled = true;
                btnBackPortFolioModel.Enabled = true;
                btnSavePortFolioModel.Enabled = true;
                btnNextPortFolioModel.Enabled = true;
                btnPrintRiskPlotter.Enabled = true;
                btnPrint.Enabled = true;
                
                optnAgreeRiskProfile.Enabled = true;
                imgRangeOfReturns.ImageUrl = string.Empty;
                return; 
            }

            //if (optnAgreeRiskProfileNo.Selected == true && lblRiskProfile.Text == "Capital Preservation")
            //{
                EnableDisableControls(true);
            //}
                disclaimer.Visible = false;
        }

        public void premiumSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (optnPremiumSelect2.Selected == true)
            {
                ddlPaymentMode.Enabled = true;                
            }
            else
            {
                ddlPaymentMode.Enabled = false;
                ddlPaymentMode.SelectedIndex = 0;
            }
        }

        public void ddlRiskProfileList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRiskProfileList.SelectedIndex == 1)
            {
                EnableDisableControls(false);
                //followAssetAllocationOnRiskProfile.Enabled = bVal;
                optnAgreeRiskProfile.Enabled = true;
                ddlRiskProfileList.Enabled = true;
                //nonCoreFunds.Enabled = bVal;
                //allocationBasedOnRiskProfile.Enabled = bVal;
                //premiumSelect.Enabled = bVal;
                //ddlPaymentMode.Enabled = bVal;
                //premium.Enabled = bVal;

                //btnPrintRiskPlotter.Enabled = bVal;
                //btnBackFundPlotter.Enabled = bVal;
                btnSaveFundPloter.Enabled = true;
                //btnNextFundPlotter.Enabled = bVal;
                //btnPrint.Enabled = bVal;
                //btnBackPortFolioModel.Enabled = bVal;
                btnSavePortFolioModel.Enabled = true;
                //btnNextPortFolioModel.Enabled = bVal;

                ClearFieldsForRiskProfileList();
                ClearAllGrids();
                disclaimer.Visible = false;
                imgRangeOfReturns.ImageUrl = string.Empty;
            }
            else
            {
                EnableDisableControls(true);
                
                if (optnAllocRiskProfile1.Selected == true || optnAllocRiskProfile2.Selected == true)
                {
                    onAllocationBasedOnRiskProfile_SelectedIndexChanged(sender, e);
                }                
                if (optnNonCoreFunds1.Selected == true || optnNonCoreFunds2.Selected == true)
                {
                    nonCoreFunds_SelectedIndexChanged(sender, e);
                }
                
                //EnableDisableControls(true);
                ShowRateOfReturnsImage();
            }
        }
        
        public void SaveFundPlotter_Click(object sender, EventArgs e)
        {
            if (!savePortFolioModel())
            {
                //if (Convert.ToInt32(txtTotalPremium.Text) > 100)
                //{
                    //lblErrorMsgGreaterthan100.Visible = true;
                    return;
                //}
            }
        }

        public void SavePortFolioModel_Click(object sender, EventArgs e)
        {
            if (!savePortFolioModel())
            {
                //if (Convert.ToInt32(txtTotalPremium.Text) > 100)
                //{
                    //lblErrorMsgGreaterthan100.Visible = true;
                    return;
                //}
            }
        }

        public void printRiskPlotter_Click(object sender, EventArgs e)
        {
            sendPdf = true;
            if (!savePortFolioModel())
            {
                return;
            }
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
            
        }

        public void printAssetBasedPortfolioModel_Click(object sender, EventArgs e)
        {
            sendPdf = true;
            if (!savePortFolioModel())
            {
                return;
            }
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }

        protected void grdNonCoreFunds_PreRender(object sender, EventArgs e)
        {
            if (grdNonCoreFunds.Rows.Count > 0)
            {
                foreach (GridViewRow row in grdNonCoreFunds.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        Label lblColor = (Label)row.FindControl("lblColor");
                        if (lblColor != null && lblColor.Text != "")
                        {
                           row.BackColor = System.Drawing.Color.FromName(lblColor.Text);
                        }
                    }
                }
            }           
        }
        
        protected void grdNonCoreFunds_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            { 
                TextBox txtAmt = (TextBox)e.Row.FindControl("txtAmount");                
                if (txtAmt != null)
                {
                    txtAmt.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();                    
                }

                TextBox txtAllocation = (TextBox)e.Row.FindControl("txtAllocation");
                if (txtAllocation != null)
                {
                    string strPercent = string.Empty;
                    string strAsset = string.Empty;
                    Label lblPercent = (Label)e.Row.FindControl("lblPercentage");
                    Label lblAsset = (Label)e.Row.FindControl("lblAssetName");

                    if (lblPercent != null)
                    {
                        strPercent = lblPercent.Text;
                    }

                    if (lblAsset != null)
                    {
                        strAsset = lblAsset.Text;
                    }

                    txtAllocation.Attributes.Add("onblur", "calculateAmountGrdNonCoreFunds(" + strPercent + ", '" + strAsset + "')");
                    txtAllocation.Attributes.Add("OnKeyPress", "javascript:allowOnlyNumbers(this.value)");
                    txtAllocation.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();    
                }                                
            }            
        }

        protected void grdFundRiskPlotter_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           if (e.Row.RowType == DataControlRowType.DataRow)
            {                
                TextBox txtAmt = (TextBox)e.Row.FindControl("txtAmount");                
                if (txtAmt != null)
                {
                    txtAmt.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();                    
                }

                TextBox txtAllocation = (TextBox)e.Row.FindControl("txtAllocation");
                if (txtAllocation != null)
                {
                    txtAllocation.Attributes.Add("onblur", "calculateAmountGrdFundRiskPlotter();");
                    txtAllocation.Attributes.Add("OnKeyPress", "javascript:allowOnlyNumbers(this.value)");
                    txtAllocation.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();                    
                }                
            }   
        }

        protected void grdSecondaryFunds_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtAmt = (TextBox)e.Row.FindControl("txtAmount");                
                if (txtAmt != null)
                {
                    txtAmt.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();                    
                }

                TextBox txtAllocation = (TextBox)e.Row.FindControl("txtAllocation");
                if (txtAllocation != null)
                {
                    txtAllocation.Attributes.Add("onblur", "calculateAmountGrdFundRiskPlotter();");
                    txtAllocation.Attributes.Add("OnKeyPress", "javascript:allowOnlyNumbers(this.value)");
                    txtAllocation.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();         
                }                
            }   
        }

        protected void grdFundsSelection_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtAmt = (TextBox)e.Row.FindControl("txtAmount");
                if (txtAmt != null)
                {
                    txtAmt.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();                    
                }

                TextBox txtAllocation = (TextBox)e.Row.FindControl("txtAllocation");
                if (txtAllocation != null)
                {
                    txtAllocation.Attributes.Add("onblur", "calculateAmountGrdFundsSelection();");
                    txtAllocation.Attributes.Add("OnKeyPress", "javascript:allowOnlyNumbers(this.value)");
                    txtAllocation.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();         
                }                
            }  
        }

        protected void grdNonCoreFunds_OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void grdFundRiskPlotter_OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void grdSecondaryFunds_OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void grdFundsSelection_OnRowCreated(object sender, GridViewRowEventArgs e)
        {
           
        }

        protected void savePortFolioBuilderAndBack(object sender, EventArgs e)
        {
            string strLclRiskProfileName = LoadRiskProfileDetails(caseID);
            if (strLclRiskProfileName != null && strLclRiskProfileName != string.Empty && lblRiskProfile.Text != "Capital Preservation")
            {
                sendPdf = false;
                if (!savePortFolioModel())
                {
                    //if (Convert.ToInt32(txtTotalPremium.Text) > 100)
                    //{
                        //lblErrorMsgGreaterthan100.Visible = true;
                        return;
                    //}
                }
            }
            string url = MenuResolution.getUrl("cka");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);            
        }

        protected void savePortFolioBuilderAndNext(object sender, EventArgs e)
        {
            string strLclRiskProfileName = LoadRiskProfileDetails(caseID);
            if (strLclRiskProfileName != null && strLclRiskProfileName != string.Empty && lblRiskProfile.Text != "Capital Preservation")
            {
                sendPdf = false;
                if (!savePortFolioModel())
                {
                    //if (Convert.ToInt32(txtTotalPremium.Text) > 100)
                    //{
                        //lblErrorMsgGreaterthan100.Visible = true;
                        return;
                    //}
                }
            }
            string url = MenuResolution.getUrl("gapSummary");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }
               
        public static void MergeRows(GridView gridView)
        {
            string strPrevAsset = string.Empty;
            foreach (GridViewRow gvr in gridView.Rows)
            {
                string strAsset = string.Empty;
                Label tbAllocationPercent = (Label)gvr.FindControl("lblAssetClasses");
                  
                if (tbAllocationPercent != null && tbAllocationPercent.Text != string.Empty)
                {
                    strAsset = tbAllocationPercent.Text;
                    if (strPrevAsset == strAsset)
                    {
                        tbAllocationPercent.Text = string.Empty;
                    }
                }
                strPrevAsset = strAsset;                
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

            if (!savePortFolioModel())
            {
                return;
            }
            
            salesportalinfo salesPortalInfo = activityStatusDao.getSalesPortalInfoForCaseid(caseid);
            if (salesPortalInfo != null)
            {
                salesPortalRedirectUrl = salesPortalInfo.salesportalurl;
            }

            Response.Redirect(salesPortalRedirectUrl);
        }

        protected string markStatusOnTab(string caseid)
        {
            string status = string.Empty;
            
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusPortfolio = null;

                activityStatusPortfolio = activityStatusDao.getActivityForCaseid(caseid, "portfoliobuilder");
                if (activityStatusPortfolio != null)
                {
                    status = activityStatusPortfolio.status;
                }

            }

            return status;

        }

    }
}
