using System;
using DAO;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;
using System.Collections.Specialized;
using Microsoft.SharePoint.Administration;
using ActivityStatusCheck;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using PDFGeneration;
using System.Collections.Generic;

namespace Zurich.Layouts.Zurich
{
    public partial class PriorityDetails : LayoutsPageBase
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
            savePriorityDetails(null, null);

            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            savePriorityDetails(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void savePrioritydetailsAndNext(object sender, EventArgs e)
        {
            sendPdf = false;
            savePriorityDetails(null, null);
            string url = MenuResolution.getUrl("incomeExpense");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void savePriorityDetailsAndBack(object sender, EventArgs e)
        {
            sendPdf = false;
            savePriorityDetails(null, null);
            string url = MenuResolution.getUrl("personalDetail");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }
        

        protected void Page_Load(object sender, EventArgs e)
        {
            activity = activityStatusDao.getActivity(2);
            ViewState["activity"] = activity;
            
            lblPdSummarySaveSuccess.Visible = false;
            lblPdSummarySaveFailed.Visible = false;

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
                if (caseId != null || caseId != "")
                {
                    PriorityDetailsDAO dao = new PriorityDetailsDAO();
                    priorityDetail detail=new priorityDetail();
                    
                        detail = dao.getPriorityDetails(caseId);
                        populatePriorityDetails(detail, caseId);
                }
            }
            markStatusOnTab(caseId);
        }

        protected void savePriorityDetails(object sender, EventArgs e)
        {
                string caseId = "";
                priorityDetail detail = new priorityDetail();
                priorityDetail existingDetail;
                if (ViewState["caseId"] != null)
                {
                    caseId = ViewState["caseId"].ToString();
                    //detail.caseId =caseId ;
                }

                string actv = "";
                if (ViewState["activity"] != null)
                {
                    actv = ViewState["activity"].ToString();
                }

                if (priorityNeed1.Text != null || priorityNeed1.Text != "")
                    detail.protection1 = priorityNeed1.Text.Trim();

                if (priorityNeed2.Text != null || priorityNeed2.Text != "")
                    detail.protection2 = priorityNeed2.Text.Trim();

                if (priorityNeed3.Text != null || priorityNeed3.Text != "")
                    detail.protection3 = priorityNeed3.Text.Trim();

                if (priorityNeed4.Text != null || priorityNeed4.Text != "")
                    detail.savings1 = priorityNeed4.Text.Trim();

                if (priorityNeed5.Text != null || priorityNeed5.Text != "")
                    detail.savings2 = priorityNeed5.Text.Trim();

                if (priorityNeed6.Text != null || priorityNeed6.Text != "")
                    detail.savings3 = priorityNeed6.Text.Trim();

                if (priorityNeed7.Text != null || priorityNeed7.Text != "")
                    detail.protection4 = priorityNeed7.Text.Trim();

                if (priorityNeed8.Text != null || priorityNeed8.Text != "")
                    detail.protection5 = priorityNeed8.Text.Trim();

                detail.caseid = caseId;

                PriorityDetailsDAO dao = new PriorityDetailsDAO();

                existingDetail = dao.getPriorityDetails(caseId);

                if (existingDetail == null)
                {
                    dao.savePriorityDetails(detail);
                }
                else
                {
                    dao.updatePriorityDetails(detail);
                }

                string status = activityStatusCheck.getPriorityDetailStatus(detail);
                activityStatusDao.saveOrUpdateActivityStatus(caseId, actv, status);

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
                
                populatePriorityDetails(detail, caseId);
                lblPdSummarySaveSuccess.Visible = true;
        }


        protected void populatePriorityDetails(priorityDetail detail,string caseId)
        {
            if(detail!=null)
            {
                if (detail.protection1!=null)
                priorityNeed1.Text = detail.protection1.Trim();
                
                if (detail.protection2 != null)
                priorityNeed2.Text = detail.protection2.Trim();

                if (detail.protection3 != null)
                priorityNeed3.Text = detail.protection3.Trim();

                if (detail.protection4 != null)
                priorityNeed7.Text = detail.protection4.Trim();

                if (detail.savings1 != null)
                priorityNeed4.Text = detail.savings1.Trim();

                if (detail.savings2 != null)
                priorityNeed5.Text = detail.savings2.Trim();

                if (detail.savings3 != null)
                priorityNeed6.Text = detail.savings3.Trim();

                if (detail.protection5 != null)
                    priorityNeed8.Text = detail.protection5.Trim();

               /* List<string> errors = printErrorMessages(detail);
                this.ErrorRepeater.DataSource = errors;
                this.ErrorRepeater.DataBind();
                */

            }
            activityId.Value = caseId;
        }

        public List<string> printErrorMessages(priorityDetail detail)
        {
            List<string> list = new List<string>();

            if (detail != null)
            {
                if ((detail.protection1 == null || detail.protection1 == "") &&
                    (detail.protection2 == null || detail.protection2 == "") &&
                    (detail.protection3 == null || detail.protection3 == "") &&
                    (detail.protection4 == null || detail.protection4 == "") &&
                    (detail.savings1 == null || detail.savings1 == "") &&
                    (detail.savings2 == null || detail.savings2 == "") &&
                    (detail.savings3 == null || detail.savings3 == ""))
                    {
                        //list.Add("Please enter at least one priority value");
                        list.Add("");
                    }
            }
            return list;
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
                sendPdf = false;

            savePriorityDetails(null, null);
            
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

        protected void createPrioritydetailsPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
            sendPdf = true;
            savePriorityDetails(null, null);
            
            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        }

    }
}
