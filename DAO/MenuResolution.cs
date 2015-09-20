using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAO
{
    public static class MenuResolution
    {
        public static string getUrl(string parameter)
        {
            string url = "";
            switch (parameter)
            {
                case "zurichAdvisor":
                    url = "/_layouts/Zurich/MyZurichAdviser/MyZurichAdviser.aspx";
                    break;
                case "personalDetail":
                    url = "/_layouts/Zurich/PersonalDetails.aspx";
                    break;
                case "priorityDetails":
                    url = "/_layouts/Zurich/PriorityDetails.aspx";
                    break;
                case "assetLiabilities":
                    url = "/_layouts/Zurich/AssetAndLiabilities.aspx";
                    break;
                case "incomeExpense":
                    url = "/_layouts/Zurich/IncomeInsuranceExpense.aspx";
                    break;
                case "protectionGoals":
                    url = "/_layouts/Zurich/ProtectionGoals/ShowProtectionGoals.aspx";
                    break;
                case "protectionGoalsMyNeeds":
                    url = "/_layouts/Zurich/ProtectionGoals/ShowMyNeedProtectionGoals.aspx";
                    break;
                case "investmentGoals":
                    url = "/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx";
                    break;
                case "riskProfile":
                    url = "/_layouts/Zurich/RiskProfile/RiskProfile.aspx";
                    break;
                case "riskPortfolioModel":
                    url = "/_layouts/Zurich/PortFolioBuilder/ShowPortFolioModel.aspx";
                    break;
                case "cka":
                    url = "/_layouts/Zurich/RiskProfile/Cka.aspx";
                    break;
                case "portfolioBuilder":
                    url = "/_layouts/Zurich/PortFolioBuilder/PortfolioModelling.aspx";
                    break;
                case "gapSummary":
                    url = "/_layouts/Zurich/PortFolioBuilder/GapSummary.aspx";
                    break;
                case "savingGoals":
                    url = "/_layouts/Zurich/SavingGoals/ShowSavingGoals.aspx";
                    break;
                case "retirementGoals":
                    url = "/_layouts/Zurich/RetirementGoals/ShowRetirementGoals.aspx";
                    break;
                case "educationGoals":
                    url = "/_layouts/Zurich/EducationGoals/ShowEducationGoals.aspx";
                    break;
                default:
                    url = "/_layouts/Zurich/MyZurichAdviser/MyZurichAdviser.aspx";
                    break;
            }
            return url;
        }
    }
}
