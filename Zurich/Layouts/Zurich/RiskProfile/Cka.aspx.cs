using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
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
    public partial class Cka : LayoutsPageBase
    {
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string caseId = "";
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
            ckaSubmit(null, null);

            //NameValueCollection data = new NameValueCollection();
            //data.Add("caseid", activityId.Value);
            //HttpHelper.RedirectAndPOST(this.Page, url, data);

            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            ckaSubmit(null, null);
            
            //NameValueCollection data = new NameValueCollection();
            //data.Add("caseid", activityId.Value);
            //HttpHelper.RedirectAndPOST(this.Page, url, data);

            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void ckaSubmitNext(object sender, EventArgs e)
        {
            sendPdf = false;
            ckaSubmit(null, null);
            NameValueCollection data = new NameValueCollection();
            
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect("/_layouts/Zurich/PortFolioBuilder/PortfolioModelling.aspx");
        }

        protected void ckaSubmitBack(object sender, EventArgs e)
        {
            sendPdf = false;
            ckaSubmit(null, null);
            
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect("/_layouts/Zurich/PortFolioBuilder/ShowPortFolioModel.aspx");
        }

        protected void ckaSubmit(object sender, EventArgs e)
        {   

            activity = activityStatusDao.getActivity(10);
            ViewState["activity"] = activity;
            
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }


            CkaAssessment cka = new CkaAssessment();

            CkaDao dao = new CkaDao();

            CkaAssessment ckaAnalysis = dao.getCkaProfile(caseId);

            string status = "new";

            if (ckaAnalysis != null)
            {
                status = "update";
                copyRiskProfileBaseClass(cka);

            }
            else
            {
                cka.caseId = caseId;
                copyRiskProfileBaseClass(cka);
            }

            if (status == "new")
            {
                dao.saveNewCkaProfile(cka);
            }
            else
            {
                cka.caseId = caseId;
                dao.updateCkaDetails(cka);
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            string cstatus = activityStatusCheck.getCkaStatus(cka);
            activityStatusDao.saveOrUpdateActivityStatus(caseId, actv, cstatus);

            markStatusOnTab(caseId);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseId);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");

            pdfData = activityStatusCheck.sendDataToSalesPortal(caseId, caseStatus, url, sendPdf);

            populateCka(cka, caseId);
        }


        public void copyRiskProfileBaseClass(CkaAssessment assessment)
        {
            /*if (agreeCKA.Checked)
            {
                assessment.agreeCKA = "true";
            }

            if (disagreeCKA.Checked)
            {
                assessment.disagreeCKA = "true";
            }*/

            if (educationalExperienceOption1.Checked)
            {
                assessment.educationalExperienceOption1 = "true";
            }
            
            if (educationalExperienceOption2.Checked)
            {
                assessment.educationalExperienceOption2 = "true";
            }
            assessment.educationalExperienceList = qualificationslist.Text;

           

            if (investmentExperienceOption1.Checked)
            {
                assessment.investmentExperienceOption1 = "true";
            }

            if (investmentExperienceOption2.Checked)
            {
                assessment.investmentExperienceOption2 = "true";
            }
            assessment.investmentExperienceList = investmentExperienceList.Text;

            if (workingExperienceOption1.Checked)
            {
                assessment.workingExperienceOption1 = "true";
            }

            if (workingExperienceOption2.Checked)
            {
                assessment.workingExperienceOption2 = "true";
            }
            assessment.workingExperienceList = workingExperienceList.Text;

            calculateCKAOption(assessment);

        }

        public List<string> printErrorMessages(CkaAssessment assessment)
        {
            List<string> list = new List<string>();

            if (assessment != null)
            {
                /*if ((assessment.agreeCKA == null || assessment.agreeCKA == "") && (assessment.disagreeCKA == null || assessment.disagreeCKA == ""))
                {
                    list.Add("Please fill Customer Knowledge Assessment details");
                }*/

                if ((assessment.educationalExperienceOption1 == null || assessment.educationalExperienceOption1 == "") && (assessment.educationalExperienceOption2 == null || assessment.educationalExperienceOption2 == ""))
                {
                    list.Add("Please fill Educational Qualifications details");
                }

                if ((assessment.educationalExperienceOption1 == "true") && (assessment.educationalExperienceList == "" || assessment.educationalExperienceList == null))
                { 
                    list.Add("Please fill Educational Qualifications details");
                }

                if ((assessment.investmentExperienceOption1 == null || assessment.investmentExperienceOption1 == "") && (assessment.investmentExperienceOption2 == null || assessment.investmentExperienceOption2 == ""))
                {
                    list.Add("Please fill Investment Experience details");
                }

                if ((assessment.investmentExperienceOption1 == "true") && (assessment.investmentExperienceList == "" || assessment.investmentExperienceList == null))
                { 
                    list.Add("Please fill Investment Experience details");
                }

                if ((assessment.workingExperienceOption1 == null || assessment.workingExperienceOption1 == "") && (assessment.workingExperienceOption2 == null || assessment.workingExperienceOption2 == ""))
                {
                    list.Add("Please fill Work Experience details");
                }

                if ((assessment.workingExperienceOption1 == "true") && (assessment.workingExperienceList == "" || assessment.workingExperienceList == null))
                {
                    list.Add("Please fill Work Experience details");
                }
            }
            return list;
        }

        public Boolean areBothNull(string field1,string field2 )
        {
            if ((field1 == null) && (field2 == null))
                return true;
            else
                return false;
        }

        public CkaAssessment calculateCKAOption(CkaAssessment assessment)
        {
            Boolean educational = areBothNull(assessment.educationalExperienceOption1, assessment.educationalExperienceOption2);
            Boolean investment = areBothNull(assessment.investmentExperienceOption1, assessment.investmentExperienceOption2);
            Boolean working = areBothNull(assessment.workingExperienceOption1, assessment.workingExperienceOption2);

            if ((educational == true) || (investment == true) || (working == true))
            {
                assessment.csaOutcomeOption1 = null;
                assessment.csaOutcomeOption2 = null;
            }
            else
            {
                if ((assessment.educationalExperienceOption1 == "true") || (assessment.financeRelatedKnowledgeOption1 == "true") || (assessment.investmentExperienceOption1 == "true") || (assessment.workingExperienceOption1 == "true"))
                {
                    assessment.csaOutcomeOption1 = "true";
                    assessment.csaOutcomeOption2 = "false";
                }
                else
                {
                    assessment.csaOutcomeOption1 = "false";
                    assessment.csaOutcomeOption2 = "true";
                }
            }
            return assessment;
        }


        public void populateCka(CkaAssessment assessment, string caseId)
        {
            /*if (assessment.agreeCKA == "true")
            {
                agreeCKA.Checked = true;
            }

            if (assessment.disagreeCKA == "true")
            {
                disagreeCKA.Checked = true;
            }*/

            if (assessment.csaOutcomeOption1 == "true")
            {
                csaOutcomeOption1.Checked = true;
            }

            if (assessment.csaOutcomeOption2== "true")
            {
                csaOutcomeOption2.Checked = true;
            }

            if (assessment.educationalExperienceOption1 == "true")
            {
                educationalExperienceOption1.Checked = true;
            }

            if (assessment.educationalExperienceOption2 == "true")
            {
                educationalExperienceOption2.Checked = true;
            }

            if (assessment.investmentExperienceOption1 == "true")
            {
                investmentExperienceOption1.Checked = true;
            }

            if (assessment.investmentExperienceOption2 == "true")
            {
                investmentExperienceOption2.Checked = true;
            }

            if (assessment.workingExperienceOption1 == "true")
            {
                workingExperienceOption1.Checked = true;
            }

            if (assessment.workingExperienceOption2 == "true")
            {
                workingExperienceOption2.Checked = true;
            }

            qualificationslist.Text = assessment.educationalExperienceList;
            investmentExperienceList.Text = assessment.investmentExperienceList;
            workingExperienceList.Text = assessment.workingExperienceList;
            

            if (assessment != null)
            {
                List<string> errors = printErrorMessages(assessment);
                this.ErrorRepeater.DataSource = errors;
                this.ErrorRepeater.DataBind();
            }
            


        }
        protected void Page_Load(object sender, EventArgs e)
        {

            string caseId = "";
            

            if (!IsPostBack)
            {
                //string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];
                string helperUsed = Request.Form["helperUsed"];

                if (Session["fnacaseid"] != null)
                {
                    caseId = Session["fnacaseid"].ToString();
                }                

                //if (nextCaseId != null && nextCaseId != "")
                //{
                //    caseId = nextCaseId;
                //}

                if (menuCaseId != null && menuCaseId != "")
                {
                    caseId = menuCaseId;
                }

             

                ViewState["caseId"] = caseId;
                activityId.Value = caseId;
                CkaDao dao = new CkaDao();
                CkaAssessment assessment = null;
                if (caseId != null || caseId != "")
                {
                    assessment = dao.getCkaProfile(caseId);

                }

                if (assessment != null)
                {
                    populateCka(assessment,caseId);
                }
                

            }

            markStatusOnTab(caseId);

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

            ckaSubmit(null, null);
            
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

        protected void createCkaPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }

            sendPdf = true;
            ckaSubmit(null, null);
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
            
        }

    }
}
