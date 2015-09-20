using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Collections.Specialized;


namespace Zurich.Layouts.Zurich.RiskProfile
{
    public partial class RiskProfileSectionB : LayoutsPageBase
    {

        protected void saveRiskProfileNext(object sender, EventArgs e)
        {
            riskProfileSubmit(null, null);
            NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/PortFolioBuilder/PortFolioModelling.aspx", data);
        }

        protected void saveRiskProfileBack(object sender, EventArgs e)
        {
            riskProfileSubmit(null, null);
            NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/RiskProfile/RiskProfile.aspx", data);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            string caseId = "";

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

                string url = "popitup('/_layouts/Zurich/RiskProfile/ShowPortfolioModel.aspx?caseId=" + caseId + "');";
                ShowPortfolioModelButton.Attributes.Add("onClick", url);

                ViewState["caseId"] = caseId;
                activityId.Value = caseId;
                RiskProfileDAO dao = new RiskProfileDAO();
                RiskProfileAnalysis riskProfileAnalysis = null;
                if (caseId != null || caseId != "")
                {
                    riskProfileAnalysis = dao.getRiskProfileForCase(caseId);

                }

                if (riskProfileAnalysis != null)
                {
                    populateRiskProfile(riskProfileAnalysis, caseId);
                }

            }

        }


        public void populateRiskProfile(RiskProfileAnalysis riskProfileAnalysis, string caseId)
        {
           if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option1 == "true")
            {
                measuringRiskTakingAbilityQuestion1option1.Checked = true;
            }

           if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option2 == "true")
           {
               measuringRiskTakingAbilityQuestion1option2.Checked = true;
           }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option3 == "true")
            {
                measuringRiskTakingAbilityQuestion1option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option4 == "true")
            {
                measuringRiskTakingAbilityQuestion1option4.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option1 == "true")
            {
                measuringRiskTakingAbilityQuestion2option1.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option2 == "true")
            {
                measuringRiskTakingAbilityQuestion2option2.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option3 == "true")
            {
                measuringRiskTakingAbilityQuestion2option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option1 == "true")
            {
                measuringRiskTakingAbilityQuestion3option1.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option2 == "true")
            {
                measuringRiskTakingAbilityQuestion3option2.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option3 == "true")
            {
                measuringRiskTakingAbilityQuestion3option3.Checked = true;
            }
            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option4 == "true")
            {
                measuringRiskTakingAbilityQuestion3option4.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option1 == "true")
            {
                measuringRiskTakingAbilityQuestion4option1.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option2 == "true")
            {
                measuringRiskTakingAbilityQuestion4option2.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option3 == "true")
            {
                measuringRiskTakingAbilityQuestion4option3.Checked = true;
            }

            if (riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option4 == "true")
            {
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
                RiskProfileDAO dao = new RiskProfileDAO();
                int score = dao.calculateRiskProfileAbilityForPopulate(riskProfileAnalysis);
                //RiskProfileValue.InnerText = score + "";
            }

            activityId.Value = caseId;
        }

        public void copyRiskProfileBaseClass(RiskProfileAnalysis riskProfile)
        {
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

            //string selectedValue = NotSelected.SelectedValue;
        }


        protected void riskProfileSubmit(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
            //string caseId="2020";
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
                dao.updateRiskProfileDetails(riskProfile,"measuringRiskTakingAbility");
            }

            populateRiskProfile(riskProfile, caseId);
        }



    }
}
