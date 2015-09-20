using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using DTO;
using ActivityStatusCheck;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using System.IO;
using PDFGeneration;
using System.Collections.Generic;

namespace Zurich.Layouts.Zurich.RiskProfile
{
    public partial class RiskProfile : LayoutsPageBase
    {
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        string caseId = "";
        string activity = "";
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
            riskProfileSubmit(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            riskProfileSubmit(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveRiskProfileNext(object sender, EventArgs e)
        {
            sendPdf = false;
            riskProfileSubmit(null, null);
            string url = MenuResolution.getUrl("riskPortfolioModel");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void saveRiskProfileBack(object sender, EventArgs e)
        {
            sendPdf = false;
            riskProfileSubmit(null, null);
            string url = MenuResolution.getUrl("educationGoals");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            activity = activityStatusDao.getActivity(9);
            ViewState["activity"] = activity;
            riskProfileSaveSuccess.Visible = false;
            
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

                //string url = "popitup('/_layouts/Zurich/RiskProfile/ShowPortfolioModel.aspx?caseId=" + caseId + "');";
                //ShowPortfolioModelButton.Attributes.Add("onClick", url);

                ViewState["caseId"] = caseId;
                activityId.Value = caseId;
                RiskProfileDAO dao = new RiskProfileDAO();
                RiskProfileAnalysis riskProfileAnalysis=null;
                if (caseId != null || caseId != "")
                {
                    riskProfileAnalysis = dao.getRiskProfileForCase(caseId);

                }

                if (riskProfileAnalysis != null)
                {
                    populateRiskProfile(riskProfileAnalysis, caseId);
                }
                
            }

            markStatusOnTab(caseId);
        }

        public List<string> printErrorMessages(RiskProfileAnalysis riskProfileAnalysis)
        {
            List<string> list = new List<string>();

            if (riskProfileAnalysis != null)
            {
                RiskProfileDAO dao = new RiskProfileDAO();
                DAO.DTO.RiskProfile profile= dao.populateRiskProfile(riskProfileAnalysis);
                Utility.checkEmptyField(profile.riskApetiteQuestion1, list, "Please enter the Risk Appetite Question 1");
                Utility.checkEmptyField(profile.riskApetiteQuestion2, list, "Please enter the Risk Appetite Question 2");
                Utility.checkEmptyField(profile.riskApetiteQuestion3, list, "Please enter the Risk Appetite Question 3");
                Utility.checkEmptyField(profile.riskApetiteQuestion4, list, "Please enter the Risk Appetite Question 4");
                Utility.checkEmptyField(profile.measuringRiskTakingAbilityQuestion1, list, "Please enter the risk Taking Ability Question 5");
                Utility.checkEmptyField(profile.measuringRiskTakingAbilityQuestion2, list, "Please enter the risk Taking Ability Question 6");
                Utility.checkEmptyField(profile.measuringRiskTakingAbilityQuestion3, list, "Please enter the risk Taking Ability Question 7");
                Utility.checkEmptyField(profile.measuringRiskTakingAbilityQuestion4, list, "Please enter the risk Taking Ability Question 8");

            }
            return list;
        }


        public void populateRiskProfile(RiskProfileAnalysis riskProfile,string caseId)
        {
            int riskApetiteQuestions = 0;
            int riskTakingAbilityQuestions = 0;

            int riskApetiteQuestionsScore = 0;
            int riskTakingAbilityquestionsScore = 0;

            RiskProfileDAO dao = new RiskProfileDAO();

            RiskProfileAnalysis riskProfileAnalysis = dao.getRiskProfileForCase(riskProfile.caseId);

            if (riskProfileAnalysis.riskApetiteQuestion1option1 == "true")
            {
                riskApetiteQuestions += 1;
                riskApetiteQuestionsScore += -16;
                riskApetiteQuestion1option1.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion1option2 == "true")
            {
                riskApetiteQuestionsScore += -3;
                riskApetiteQuestions += 1;
                riskApetiteQuestion1option2.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion1option3 == "true")
            {
                riskApetiteQuestionsScore += 2;
                riskApetiteQuestions += 1;
                riskApetiteQuestion1option3.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion1option4 == "true")
            {
                riskApetiteQuestionsScore += 8;
                riskApetiteQuestions += 1;
                riskApetiteQuestion1option4.Checked = true;
            }
            if (riskProfileAnalysis.riskApetiteQuestion1option5 == "true")
            {
                riskApetiteQuestionsScore += 12;
                riskApetiteQuestions += 1;
                riskApetiteQuestion1option5.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion1option6 == "true")
            {
                riskApetiteQuestionsScore += 16;
                riskApetiteQuestions += 1;
                riskApetiteQuestion1option6.Checked = true;
            }


            if (riskProfileAnalysis.riskApetiteQuestion2option1 == "true")
            {
                riskApetiteQuestionsScore += 1;
                riskApetiteQuestions += 1;
                riskApetiteQuestion2option1.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion2option2 == "true")
            {
                riskApetiteQuestionsScore += 2;
                riskApetiteQuestions += 1;
                riskApetiteQuestion2option2.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion2option3 == "true")
            {
                riskApetiteQuestionsScore += 4;
                riskApetiteQuestions += 1;
                riskApetiteQuestion2option3.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion2option4 == "true")
            {
                riskApetiteQuestionsScore += 5;
                riskApetiteQuestions += 1;
                riskApetiteQuestion2option4.Checked = true;
            }


            if (riskProfileAnalysis.riskApetiteQuestion3option1 == "true")
            {
                riskApetiteQuestionsScore += -4;
                riskApetiteQuestions += 1;
                riskApetiteQuestion3option1.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion3option2 == "true")
            {
                riskApetiteQuestionsScore += 1;
                riskApetiteQuestions += 1;
                riskApetiteQuestion3option2.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion3option3 == "true")
            {
                riskApetiteQuestionsScore += 4;
                riskApetiteQuestions += 1;
                riskApetiteQuestion3option3.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion3option4 == "true")
            {
                riskApetiteQuestionsScore += 5;
                riskApetiteQuestions += 1;
                riskApetiteQuestion3option4.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion3option5 == "true")
            {
                riskApetiteQuestionsScore += 6;
                riskApetiteQuestions += 1;
                riskApetiteQuestion3option5.Checked = true;
            }


            if (riskProfileAnalysis.riskApetiteQuestion4option1 == "true")
            {
                riskApetiteQuestionsScore += 1;
                riskApetiteQuestions += 1;
                riskApetiteQuestion4option1.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion4option2 == "true")
            {
                riskApetiteQuestionsScore += 3;
                riskApetiteQuestions += 1;
                riskApetiteQuestion4option2.Checked = true;
            }

            if (riskProfileAnalysis.riskApetiteQuestion4option3 == "true")
            {
                riskApetiteQuestionsScore += 5;
                riskApetiteQuestions += 1;
                riskApetiteQuestion4option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option1 == "true")
            {
                riskTakingAbilityquestionsScore += -3;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion1option1.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option2 == "true")
            {
                riskTakingAbilityquestionsScore += 0;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion1option2.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option3 == "true")
            {
                riskTakingAbilityquestionsScore += 3;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion1option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option4 == "true")
            {
                riskTakingAbilityquestionsScore += 5;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion1option4.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option1 == "true")
            {
                riskTakingAbilityquestionsScore += 0;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion2option1.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option2 == "true")
            {
                riskTakingAbilityquestionsScore += 3;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion2option2.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option3 == "true")
            {
                riskTakingAbilityquestionsScore += 5;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion2option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option1 == "true")
            {
                riskTakingAbilityquestionsScore += 0;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion3option1.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option2 == "true")
            {
                riskTakingAbilityquestionsScore += 2;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion3option2.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option3 == "true")
            {
                riskTakingAbilityquestionsScore += 3;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion3option3.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option4 == "true")
            {
                riskTakingAbilityquestionsScore += 5;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion3option4.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option1 == "true")
            {
                riskTakingAbilityquestionsScore += 0;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion4option1.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option2 == "true")
            {
                riskTakingAbilityquestionsScore += 2;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion4option2.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option3 == "true")
            {
                riskTakingAbilityquestionsScore += 3;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion4option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option4 == "true")
            {
                riskTakingAbilityquestionsScore += 5;
                riskTakingAbilityQuestions += 1;
                measuringRiskTakingAbilityQuestion4option4.Checked = true;
            }

            if (riskProfileAnalysis.agreeWithRiskProfileoption2 == "true")
            {
                isPreferredRiskProfile.Value = "true";
            }
            else
                isPreferredRiskProfile.Value = "false";

            if (riskProfileAnalysis != null)
            {
                if (riskApetiteQuestions == 4)
                riskTakingAppetiteLabel.InnerText = riskApetiteQuestionsScore + "";

                if (riskTakingAbilityQuestions == 4)
                riskTakingAbilityLabel.InnerText = riskTakingAbilityquestionsScore + "";
                if (riskProfileAnalysis.riskProfileName != null)
                {
                    if ((riskApetiteQuestions == 4) && (riskTakingAbilityQuestions == 4))
                    {
                        finalRiskProfile.InnerText = riskProfileAnalysis.riskProfileName;
                    }
                }
            }
            
            activityId.Value = caseId;
            if (riskProfileAnalysis != null)
            {
                List<string> errors = printErrorMessages(riskProfileAnalysis);
                this.ErrorRepeater.DataSource = errors;
                this.ErrorRepeater.DataBind();
            }
        }

        public void copyRiskProfileBaseClass(RiskProfileAnalysis riskProfile)
        {
            if (riskApetiteQuestion1option1.Checked)
            {
                riskProfile.riskApetiteQuestion1option1 = "true";
            }

            if (riskApetiteQuestion1option2.Checked)
            {
                riskProfile.riskApetiteQuestion1option2 = "true";
            }

            if (riskApetiteQuestion1option3.Checked)
            {
                riskProfile.riskApetiteQuestion1option3 = "true";
            }

            if (riskApetiteQuestion1option4.Checked)
            {
                riskProfile.riskApetiteQuestion1option4 = "true";
            }

            if (riskApetiteQuestion1option5.Checked)
            {
                riskProfile.riskApetiteQuestion1option5 = "true";
            }

            if (riskApetiteQuestion1option6.Checked)
            {
                riskProfile.riskApetiteQuestion1option6 = "true";
            }

            if (riskApetiteQuestion2option1.Checked)
            {
                riskProfile.riskApetiteQuestion2option1 = "true";
            }

            if (riskApetiteQuestion2option2.Checked)
            {
                riskProfile.riskApetiteQuestion2option2 = "true";
            }

            if (riskApetiteQuestion2option3.Checked)
            {
                riskProfile.riskApetiteQuestion2option3 = "true";
            }

            if (riskApetiteQuestion2option4.Checked)
            {
                riskProfile.riskApetiteQuestion2option4 = "true";
            }

            if (riskApetiteQuestion3option1.Checked)
            {
                riskProfile.riskApetiteQuestion3option1 = "true";
            }

            if (riskApetiteQuestion3option2.Checked)
            {
                riskProfile.riskApetiteQuestion3option2 = "true";
            }

            if (riskApetiteQuestion3option3.Checked)
            {
                riskProfile.riskApetiteQuestion3option3 = "true";
            }

            if (riskApetiteQuestion3option4.Checked)
            {
                riskProfile.riskApetiteQuestion3option4 = "true";
            }

            if (riskApetiteQuestion3option5.Checked)
            {
                riskProfile.riskApetiteQuestion3option5 = "true";
            }

            if (riskApetiteQuestion4option1.Checked)
            {
                riskProfile.riskApetiteQuestion4option1 = "true";
            }

            if (riskApetiteQuestion4option2.Checked)
            {
                riskProfile.riskApetiteQuestion4option2 = "true";
            }

            if (riskApetiteQuestion4option3.Checked)
            {
                riskProfile.riskApetiteQuestion4option3 = "true";
            }

            if (measuringRiskTakingAbilityQuestion1option1.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion1option1 = "true";
            }

            if (measuringRiskTakingAbilityQuestion1option2.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion1option2 = "true";
            }

            if (measuringRiskTakingAbilityQuestion1option3.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion1option3 = "true";
            }
            if (measuringRiskTakingAbilityQuestion1option4.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion1option4 = "true";
            }

            if (measuringRiskTakingAbilityQuestion2option1.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion2option1 = "true";
            }

            if (measuringRiskTakingAbilityQuestion2option2.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion2option2 = "true";
            }

            if (measuringRiskTakingAbilityQuestion2option3.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion2option3 = "true";
            }


            if (measuringRiskTakingAbilityQuestion3option1.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion3option1 = "true";
            }


            if (measuringRiskTakingAbilityQuestion3option2.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion3option2 = "true";
            }

            if (measuringRiskTakingAbilityQuestion3option3.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion3option3 = "true";
            }


            if (measuringRiskTakingAbilityQuestion3option4.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion3option4 = "true";
            }


            if (measuringRiskTakingAbilityQuestion4option1.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion4option1 = "true";
            }

            if (measuringRiskTakingAbilityQuestion4option2.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion4option2 = "true";
            }

            if (measuringRiskTakingAbilityQuestion4option3.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion4option3 = "true";
            }

            if (measuringRiskTakingAbilityQuestion4option4.Checked)
            {
                riskProfile.measuringRiskTakingAbilityQuestion4option4 = "true";
            }

        }


        protected void riskProfileSubmit(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
           
            caseNumber.Value = caseId;
           
            RiskProfileAnalysis riskProfile = new RiskProfileAnalysis();

            RiskProfileDAO dao = new RiskProfileDAO();

            RiskProfileAnalysis riskProfileAnalysis = dao.getRiskProfileForCase(caseId);

            string status = "new";

            if (riskProfileAnalysis != null)
            {
                status = "update";
                copyRiskProfileBaseClass(riskProfile);

            }
            else
            {
                riskProfile.caseId = caseId;
                copyRiskProfileBaseClass(riskProfile);
            }

            if (status == "new")
            {
                dao.saveNewRiskProfile(riskProfile);
            }
            else
            {
                riskProfile.caseId = caseId;
                dao.updateRiskProfileDetails(riskProfile, "riskApetite");
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string cstatus = activityStatusCheck.getRiskProfileStatus(riskProfile);
            activityStatusDao.saveOrUpdateActivityStatus(caseId, actv, cstatus);

            PortFolioModellingDAO poftFolioDAO = new PortFolioModellingDAO();
            poftFolioDAO.DeletePoftFolioBuilderForCapitalPreservation(caseId);

            markStatusOnTab(caseId);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseId);
            
            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseId, caseStatus, url, sendPdf);

            populateRiskProfile(riskProfile,caseId);
            riskProfileSaveSuccess.Visible = true;
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

            riskProfileSubmit(null, null);

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

        protected void createRiskprofilePdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }

            sendPdf = true;
            riskProfileSubmit(null, null);

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
            
        }

    }

}
