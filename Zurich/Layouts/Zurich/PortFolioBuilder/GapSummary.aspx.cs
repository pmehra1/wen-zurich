using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using ActivityStatusCheck;
using PDFGeneration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using System.IO;

namespace Zurich.Layouts.Zurich.PortFolioBuilder
{
    public partial class GapSummary : LayoutsPageBase
    {
        protected string caseID = string.Empty;
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected bool sendPdf = false;

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
                        
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblGapSummarySaveSuccess.Visible = false;
            lblGapSummarySaveFailed.Visible = false;
            lblPrioritiesSequence.Visible = false;
            lblNotNumeric.Visible = false;

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

                    LoadGapSummary();
                }
                else
                {
                    if (ViewState["caseid"] != null)
                    {
                        caseID = ViewState["caseid"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GapSummary Method: Page_Load";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                activityStatusDao.logException(exLog);
            }
        }

        protected void LoadGapSummary()
        {
            GapSummaryDAO gapDAO = new GapSummaryDAO();
            DataTable dtGapSummary = gapDAO.GetGapSummary(caseID);

            if (dtGapSummary != null && dtGapSummary.Rows.Count > 0)
            {
                int cnt = 0;
                foreach (DataRow dr in dtGapSummary.Rows)
                {
                    if (dr["Title"] != null && dr["Title"].ToString() == "SAVINGS")
                    {
                        cnt = cnt + 1;
                    }

                    if (cnt > 1)
                    {
                        dr["Title"] = string.Empty;
                    }

                    if (dr["AmountRequired"] != null && dr["AmountRequired"].ToString() == "0.00")
                    {
                        dr["AmountRequired"] = string.Empty;
                    }
                    if (dr["ExistingArrangements"] != null && dr["ExistingArrangements"].ToString() == "0.00")
                    {
                        dr["ExistingArrangements"] = string.Empty;
                    }
                    if (dr["CurrentShortfall"] != null && dr["CurrentShortfall"].ToString() == "0.00")
                    {
                        dr["CurrentShortfall"] = string.Empty;
                    }
                }

                grdGapSummary.DataSource = dtGapSummary;
                grdGapSummary.DataBind();
                MergeRows(grdGapSummary);
            }
        }

        protected void grdGapSummary_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Label lblMyPriorities = (Label)e.Row.FindControl("lblMyPriorities");
                //if (lblMyPriorities != null)
                //{
                //    lblMyPriorities.Attributes.Add("OnKeyPress", "allowOnlyNumbers()");
                //    lblMyPriorities.Style["TEXT-ALIGN"] = TextAlign.Right.ToString();
                //} 
            }
        }

        protected void grdGapSummary_PreRender(object sender, EventArgs e)
        {
            //MergeRows(grdGapSummary);         
        }

        public static void MergeRows(GridView gridView)
        {
            try
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
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GapSummary Method: MergeRows";
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

        protected void grdGapSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    Label lblHeader = (Label)e.Row.FindControl("lblHeader");
            //    if (lblHeader != null && lblHeader.Text != "")
            //    {
            //        e.Row.BackColor = System.Drawing.Color.FromName(lblHeader.Text);
            //    }
            //}
        }

        protected bool ValidateGapSummary()
        {
            List<int> arPriorities = new List<int>();

            foreach (GridViewRow gvr in grdGapSummary.Rows)
            {
                Label tbAllocationPercent = (Label)gvr.FindControl("lblMyPriorities");

                if (tbAllocationPercent != null && tbAllocationPercent.Text != string.Empty)
                {
                    int result;
                    if (!int.TryParse(tbAllocationPercent.Text, out result))
                    {
                        lblNotNumeric.Visible = true;
                        return false;
                    }                    

                    arPriorities.Add(Convert.ToInt32(tbAllocationPercent.Text.Trim()));
                }                
            }

            int cnt = 1;
            arPriorities.Sort();
            if (arPriorities.Count > 0)
            {
                for (int i = 0; i < arPriorities.Count; i++)
                {
                    if (arPriorities[i].ToString() != cnt.ToString())
                    {
                        lblPrioritiesSequence.Visible = true;
                        return false;
                    }

                    cnt = cnt + 1;
                }
            }

            return true;
        }

        protected void SaveGapSummary()
        {
            bool retVal = false;
            if (!ValidateGapSummary())            
            {   
                return;
            }

            GapSummaryDAO gapSummary = new GapSummaryDAO();
            gapSummary.DeleteGapSummary(caseID);

            foreach (GridViewRow gvr in grdGapSummary.Rows)
            {
                Label lblNeedId = (Label)gvr.FindControl("lblNeedId");
                Label lblGapSummaryTypeID = (Label)gvr.FindControl("lblGapSummaryTypeID");
                Label lblMyPriorities = (Label)gvr.FindControl("lblMyPriorities");
                    

                int iNeedId = Convert.ToInt32(lblNeedId.Text);
                int iNeedTypeId = Convert.ToInt32(lblGapSummaryTypeID.Text);
                string strMyPriorities = lblMyPriorities.Text;
                    
                if (strMyPriorities != null && strMyPriorities != "")                        
                {
                    retVal = gapSummary.SaveGapSummary(caseID, iNeedId, iNeedTypeId, strMyPriorities);                    
                }
            }

            if (!retVal)
            {
                lblGapSummarySaveSuccess.Visible = false;
                lblGapSummarySaveFailed.Visible = true;
            }
            else
            {
                lblGapSummarySaveSuccess.Visible = true;
                lblGapSummarySaveFailed.Visible = false;
            }
        }

        public void printGapSummary_Click(object sender, EventArgs e)
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

        public void saveGapSummaryAndBack(object sender, EventArgs e)
        {
            string url = MenuResolution.getUrl("portfolioBuilder");
            Session["fnacaseid"] = activityId.Value;

            string caseid = activityId.Value;
            sendPdf = false;
            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);
            string urlSalesportal = Server.MapPath("~/_layouts/Zurich/Printpages/");
            byte[] pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, urlSalesportal, sendPdf);

            Response.Redirect(url);
        }

        public void SaveGapSummary_Click(object sender, EventArgs e)
        {
            //SaveGapSummary();
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

            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);
            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            byte[] pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, url, sendPdf);

            salesportalinfo salesPortalInfo = activityStatusDao.getSalesPortalInfoForCaseid(caseid);
            if (salesPortalInfo != null)
            {
                salesPortalRedirectUrl = salesPortalInfo.salesportalurl;
            }

            Response.Redirect(salesPortalRedirectUrl);
        }
    }
}
