using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections;
using System.Data;
using DAO;

namespace Zurich.Layouts.Zurich
{
    public partial class ErrorLogViewer : LayoutsPageBase
    {
        //Hashtable filter;
        protected void Page_Load(object sender, EventArgs e)
        {
            //filter = ViewState["FilterArgs"] == null ? new Hashtable() : (Hashtable)ViewState["FilterArgs"];
            if (!IsPostBack)
            {
                try
                {
                    ErrorLogViewerDAO errLog = new ErrorLogViewerDAO();
                    DataTable dtErrorLog = errLog.GetErrorLogs();

                    if (dtErrorLog != null && dtErrorLog.Rows.Count > 0)
                    {
                        grdErrorViewer.DataSource = null;
                        grdErrorViewer.DataBind();
                        grdErrorViewer.DataSource = dtErrorLog;
                        grdErrorViewer.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblErrorMessage.Text = ex.Message + " : " + ex.Source + " : " + ex.StackTrace;
                }
            }
        }


        public void btnExecuteQryClick(object sender, EventArgs e)
        {
            try
            {
                if (txtPassword.Text == string.Empty)
                {
                    lblErrorMessage.Text = "Enter Password";
                    return;
                }
                if (txtPassword.Text != string.Empty && txtPassword.Text != "password$1")
                {
                    lblErrorMessage.Text = "Invalid Password";
                    return;
                }
                if (txtSQLText.Text == string.Empty)
                {
                    lblErrorMessage.Text = "Invalid SQL Query";
                    return;
                }

                ErrorLogViewerDAO errLog = new ErrorLogViewerDAO();
                DataTable dtErrorLog = errLog.GetSQLResult(txtSQLText.Text);

                if (dtErrorLog != null && dtErrorLog.Rows.Count > 0)
                {
                    grdErrorViewer.DataSource = null;
                    grdErrorViewer.DataBind();
                    grdErrorViewer.DataSource = dtErrorLog;
                    grdErrorViewer.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = ex.Message + " : " + ex.Source + " : " + ex.StackTrace;
            }
        }

        public void btnRefreshExceptionLogClick(object sender, EventArgs e)
        {
            try
            {
                ErrorLogViewerDAO errLog = new ErrorLogViewerDAO();
                DataTable dtErrorLog = errLog.GetErrorLogs();

                if (dtErrorLog != null && dtErrorLog.Rows.Count > 0)
                {
                    grdErrorViewer.DataSource = null;
                    grdErrorViewer.DataBind();
                    grdErrorViewer.DataSource = dtErrorLog;
                    grdErrorViewer.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = ex.Message + " : " + ex.Source + " : " + ex.StackTrace;
            }
        }

        protected void GridView1_PageIndexChanged(object sender, EventArgs e)
        {
            //ApplyGridFilter();
        }

        protected void ApplyGridFilter()
        {
            //string args = " ";
            //int i = 0;
            //foreach (object key in filter.Keys)
            //{
            //    if (i == 0)
            //    {
            //        args = key.ToString() + filter[key].ToString();
            //    }
            //    else
            //    {
            //        args += " AND " + key.ToString() + filter[key].ToString();
            //    }
            //    i++;
            //}
            //SqlDataSource1.FilterExpression = args;
            ////Filter needs to be saved between postbacks
            //ViewState.Add("FilterArgs", filter);
        }
    }
}
