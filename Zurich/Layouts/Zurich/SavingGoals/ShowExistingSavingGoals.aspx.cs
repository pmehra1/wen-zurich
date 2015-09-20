using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using DAO;

namespace Zurich.Layouts.Zurich.SavingGoals
{
    public partial class ShowExistingSavingGoals : LayoutsPageBase
    {
        protected List<savinggoal> savingGoal;
        protected string caseid = "";
        protected SavingGoalsDAO savingGoalsDao = new SavingGoalsDAO();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string CaseId = Request.QueryString["caseid"];

            if (CaseId != null && CaseId != "")
            {
                caseid = CaseId;
            }

            if (caseid != null)
            {
                savingGoal = savingGoalsDao.getSavingGoal(caseid);
            }

            existingsggrid.DataSource = savingGoal;
            existingsggrid.DataBind();
        }

        protected void existingsggrid_Edit(Object sender, DataGridCommandEventArgs dgc)
        {

        }

        protected void existingsggrid_Delete(Object sender, DataGridCommandEventArgs dgc)
        {

        }

    }
}
