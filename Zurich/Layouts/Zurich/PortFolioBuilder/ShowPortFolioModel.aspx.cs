using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using DAO;
using ActivityStatusCheck;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using PDFGeneration;

namespace Zurich.Layouts.Zurich.PortFolioBuilder
{
    public partial class ShowPortFolioModel : LayoutsPageBase
    {
        protected string caseID = string.Empty;
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        bool sendPdf = false;

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
            SampleEvent even=(SampleEvent)e;
            string toLink="";
            if (even != null)
                toLink = even.toLink;
            string url = MenuResolution.getUrl(toLink);
                        
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);

            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string menuCaseId = Request.QueryString["caseid"];
                //string strRiskProfileName = Request.QueryString["RiskProfileName"];

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

                string strRiskProfileName = GetRiskProfileName();
                riskProfileNameHidden.Value = strRiskProfileName;
                imgPortFolioModel.AlternateText = strRiskProfileName;
                ChangeImageBasedOnSelection(strRiskProfileName);
            }
            else
            {
                if (ViewState["caseid"] != null)
                {
                    caseID = ViewState["caseid"].ToString();
                }
            }            

            markStatusOnTab(caseID);
        }
        
        public void optnCoreNonCoreOptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = imgPortFolioModel.AlternateText;
            ChangeImageBasedOnSelection(imgPortFolioModel.AlternateText);
        }
        
        public void lnkCautiousClicked(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = "Cautious";
            imgPortFolioModel.AlternateText = "Cautious";
            ChangeImageBasedOnSelection("Cautious");
        }

        public void lnkModeratelyCautiousClicked(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = "Moderately Cautious";
            imgPortFolioModel.AlternateText = "Moderately Cautious";
            ChangeImageBasedOnSelection("Moderately Cautious");
        }

        public void lnkBalancedClicked(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = "Balanced";
            imgPortFolioModel.AlternateText = "Balanced";
            ChangeImageBasedOnSelection("Balanced");
        }

        public void lnkModeratelyAdventurousClicked(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = "Moderately Adventurous";
            imgPortFolioModel.AlternateText = "Moderately Adventurous";
            ChangeImageBasedOnSelection("Moderately Adventurous");
        }

        public void lnkAdventurousClicked(object sender, EventArgs e)
        {
            riskProfileNameHidden.Value = "Adventurous";
            imgPortFolioModel.AlternateText = "Adventurous";
            ChangeImageBasedOnSelection("Adventurous");
        }

        protected string GetRiskProfileName()
        {
            string strRiskProfileName = string.Empty;
            RiskProfileDAO riskProfile = new RiskProfileDAO();
            RiskProfileAnalysis riskProfileDetails = riskProfile.getRiskProfileForCase(caseID);

            if (riskProfileDetails != null)
            {
                if (riskProfileDetails.riskProfileName != null)
                {
                    strRiskProfileName = riskProfileDetails.riskProfileName;
                }
            }

            return strRiskProfileName;
        }

        public void ChangeImageBasedOnSelection(string strRiskProfileName)
        {          

            String url = "~/_layouts/Zurich/images/Content/PortFolioModelImages/";

            String core_image = "";
            String non_core_image = "";

            switch (strRiskProfileName)
            {
                case "Adventurous":
                    {                            
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_05Adventurous.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_05Adventurous.png";
                        break;
                    }
                case "Balanced":
                    {                        
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_03Balanced.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_03Balanced.png";
                        break;
                    }
                case "Cautious":
                    {                        
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_01Cautious.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_01Cautious.png";                        
                        break;
                    }
                case "Moderately Adventurous":
                    {                        
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_04MAdventurous.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_04MAdventurous.png";                        
                        break;
                    }
                case "Moderately Cautious":
                    {                        
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_02MCautious.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_02MCautious.png";                        
                        break;
                    }
                default:
                    {                        
                        core_image = "CoreAssets/PortFolioModel_CoreAssets_01Cautious.png";
                        non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_01Cautious.png";                        
                        break;
                    }
            }

            String coreurl = url + core_image;
            String noncoreurl = url + non_core_image;

            if (optnCore.Selected == true)
            {
                lblLineGraph.Text = "Range of Returns with Core Assets";
                imgPortFolioModel.ImageUrl = coreurl;
            }
            if (optnNonCore.Selected == true)
            {
                lblLineGraph.Text = "Range of Returns with Non Core Assets";
                imgPortFolioModel.ImageUrl = noncoreurl;                
            }
        }
                

        protected void PortFolioModelPrevious(object sender, EventArgs e)
        {
            string url = MenuResolution.getUrl("riskProfile");
            Session["fnacaseid"] = activityId.Value;

            sendPdf = false;
            string caseStatus = activityStatusCheck.getZPlanStatus(activityId.Value);

            string url1 = Server.MapPath("~/_layouts/Zurich/Printpages/");
            byte[] pdfData = activityStatusCheck.sendDataToSalesPortal(activityId.Value, caseStatus, url1, sendPdf);

            Response.Redirect(url);
        }

        protected void PortFolioModelNext(object sender, EventArgs e)
        {
            string url = MenuResolution.getUrl("cka");
            Session["fnacaseid"] = activityId.Value;

            sendPdf = false;
            string caseStatus = activityStatusCheck.getZPlanStatus(activityId.Value);

            string url1 = Server.MapPath("~/_layouts/Zurich/Printpages/");
            byte[] pdfData = activityStatusCheck.sendDataToSalesPortal(activityId.Value, caseStatus, url1, sendPdf);

            Response.Redirect(url);
        }

        protected void markStatusOnTab(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusRisk = null;
                activitystatus activityStatusCka = null;

                activityStatusRisk = activityStatusDao.getActivityForCaseid(caseid, "riskprofile");
                if (activityStatusRisk != null)
                {
                    if (activityStatusRisk.status == "incomplete")
                    {
                        riskprofiletab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        riskprofiletab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusCka = activityStatusDao.getActivityForCaseid(caseid, "cka");
                if (activityStatusCka != null)
                {
                    if (activityStatusCka.status == "incomplete")
                    {
                        ckatab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        ckatab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

            }

        }

        protected void createPortfoliomodelPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseid"] != null)
            {
                caseId = ViewState["caseid"].ToString();
            }

            sendPdf = true;

            string caseStatus = activityStatusCheck.getZPlanStatus(caseId);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            byte[] pdfData = activityStatusCheck.sendDataToSalesPortal(caseId, caseStatus, url, sendPdf);

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }

    }
}
