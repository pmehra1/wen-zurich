using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using ActivityStatusCheck;

namespace Zurich.Layouts.Zurich.Introduction
{
    public partial class Introduction : LayoutsPageBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string salesPortalRedirectUrl = string.Empty;
                if (Request.Form["SalesPortalRedirectUrl"] != null)
                {
                    salesPortalRedirectUrl = Request.Form["SalesPortalRedirectUrl"].ToString();
                }

                ViewState["SalesPortalRedirectUrl"] = salesPortalRedirectUrl;
            }
        }

        protected void redirectToCasePortal(object sender, EventArgs e)
        {
            string salesPortalRedirectUrl = string.Empty;
            if (ViewState["SalesPortalRedirectUrl"] != null)
            {
                salesPortalRedirectUrl = ViewState["SalesPortalRedirectUrl"].ToString();
            }            

            Response.Redirect(salesPortalRedirectUrl);
        }
    }
}
