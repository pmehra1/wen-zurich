using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Zurich.Layouts.Zurich;
using ActivityStatusCheck;
using DAO;
using System.Collections.Generic;
namespace Zurich.ControlTemplates.Zurich
{

    public class SampleEvent : EventArgs
    {
        public string toLink { get; set; }
    }


    public partial class FNAMenu : UserControl
    {
        public string activityId { get; set; }

        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenField activity = (HiddenField)this.Parent.FindControl("activityId");

            if (activity != null)
            {
                activityId = activity.Value;
            }
            else
            {
                activityId = "";
            }

            HiddenField portfolioBuilderMenuSvr = (HiddenField)this.Parent.FindControl("portfolioBuilderMenu");
            if (portfolioBuilderMenuSvr != null)
            {
                portfolioBuilderMenuFNAMenu.Value = portfolioBuilderMenuSvr.Value;
            }
            else
            {
                portfolioBuilderMenuFNAMenu.Value = "";
            }

            HiddenField portfolioBuilderCstLcl = (HiddenField)this.Parent.FindControl("cst");
            if (portfolioBuilderCstLcl != null)
            {
                portfolioBuilderCst.Value = portfolioBuilderCstLcl.Value;
            }
            else
            {
                portfolioBuilderCst.Value = "";
            }


            getFactFindStatus(activityId);
            getProtectionGoalStatus(activityId);
            getInvestmentGoalStatus(activityId);
            getRiskProfileStatus(activityId);
            getPBStatus(activityId);
        }

        public event EventHandler EventClick;

        protected void OnButtonClick(EventArgs e)
        {
            if (EventClick != null)
            {
                EventClick(this, e);
            }
        }

        public void Menu_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            ViewState["toLink"] = toLink;
            SampleEvent even = new SampleEvent();
            even.toLink = toLink;
            OnButtonClick(even);
         
        }

        public string isComplete(List<activitystatus> activityStatusList)
        {
            string status = "complete";
            if (activityStatusList != null)
            {
                foreach(activitystatus activityStatus in activityStatusList)
                {
                    if (!nullCheck(activityStatus))
                    {
                        if (activityStatus.status == "incomplete")
                        {
                            status = "incomplete";
                            break;
                        }
                    }
                    else
                    {
                        status = "incomplete";
                        break;
                    }
                        
                }
            }

            return status;
        }

        public Boolean nullCheck(activitystatus activitystatus)
        {
            Boolean status = false;
                if(activitystatus == null)
                    status = true;
                else
                {
                    if (activitystatus.status == null || activitystatus.status == "")
                    {
                        status = true;
                    }
                    else
                        status = false;
                }
            return status;
        }

        public Boolean nullCheck(List<activitystatus> activityStatusList)
        {
            Boolean status = false;
            foreach (activitystatus activityStatus in activityStatusList)
            {
                if(!nullCheck(activityStatus))
                {
                    status=true;
                }
            }
            return status;
        }


        public string calculateStatus(List<activitystatus> activityStatusList)
        {
            if (!nullCheck(activityStatusList))
                return "";
            else
                return isComplete(activityStatusList);
        }

        protected void getFactFindStatus(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusPerdet = null;
                activitystatus activityStatusPrDet = null;
                activitystatus activityStatusAssetLiab = null;
                activitystatus activityStatusIncomeExpense = null;
                activitystatus activityStatusMza = null;

                activityStatusPerdet = activityStatusDao.getActivityForCaseid(caseid, "personaldetail");
                activityStatusPrDet = activityStatusDao.getActivityForCaseid(caseid, "prioritydetail");
                activityStatusAssetLiab = activityStatusDao.getActivityForCaseid(caseid, "assetliability");
                activityStatusIncomeExpense = activityStatusDao.getActivityForCaseid(caseid, "incomeexpense");
                activityStatusMza = activityStatusDao.getActivityForCaseid(caseid, "myzurichadviser");

                List<activitystatus> activityStatusList = new List<activitystatus>();
                activityStatusList.Add(activityStatusPerdet);
                activityStatusList.Add(activityStatusPrDet);
                activityStatusList.Add(activityStatusAssetLiab);
                activityStatusList.Add(activityStatusIncomeExpense);
                activityStatusList.Add(activityStatusMza);

                factfindstatus.Value = calculateStatus(activityStatusList);
            }
        }

        protected void getProtectionGoalStatus(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusFamily = null;
                activitystatus activityStatusMyneeds = null;

                activityStatusFamily = activityStatusDao.getActivityForCaseid(caseid, "protectiongoalfamily");
                activityStatusMyneeds = activityStatusDao.getActivityForCaseid(caseid, "protectiongoalmyneeds");

                List<activitystatus> activityStatusList = new List<activitystatus>();
                activityStatusList.Add(activityStatusFamily);
                activityStatusList.Add(activityStatusMyneeds);


                protectiongoalstatus.Value = calculateStatus(activityStatusList);
            }
        }

        protected void getInvestmentGoalStatus(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusSg = null;
                activitystatus activityStatusRg = null;
                activitystatus activityStatusEg = null;

                activityStatusSg = activityStatusDao.getActivityForCaseid(caseid, "savinggoal");
                activityStatusRg = activityStatusDao.getActivityForCaseid(caseid, "retirementgoal");
                activityStatusEg = activityStatusDao.getActivityForCaseid(caseid, "educationgoal");

                List<activitystatus> activityStatusList = new List<activitystatus>();
                activityStatusList.Add(activityStatusSg);
                activityStatusList.Add(activityStatusRg);
                activityStatusList.Add(activityStatusEg);

                investmentgoalsstatus.Value = calculateStatus(activityStatusList);
            }
        }

        protected void getRiskProfileStatus(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusRiskprofile = null;
                activitystatus activityStatusCka = null;

                activityStatusRiskprofile = activityStatusDao.getActivityForCaseid(caseid, "riskprofile");
                activityStatusCka = activityStatusDao.getActivityForCaseid(caseid, "cka");

                List<activitystatus> activityStatusList = new List<activitystatus>();
                activityStatusList.Add(activityStatusRiskprofile);
                activityStatusList.Add(activityStatusCka);
                
                riskprofilestatus.Value = calculateStatus(activityStatusList);
            }
        }

        protected void getPBStatus(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusPb = null;

                activityStatusPb = activityStatusDao.getActivityForCaseid(caseid, "portfoliobuilder");

                List<activitystatus> activityStatusList = new List<activitystatus>();
                activityStatusList.Add(activityStatusPb);
               
                portfoliobuilderstatus.Value = calculateStatus(activityStatusList);
            }
        }
       
    }
}

