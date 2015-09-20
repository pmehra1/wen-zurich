using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;

namespace Zurich.Layouts.Zurich.RiskProfile
{
    public partial class ShowPortfolioModel : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string caseId = Request.QueryString["caseId"].ToString();
                
            RiskProfileDAO dao = new RiskProfileDAO();
            RiskProfileAnalysis riskProfileAnalysis = dao.getRiskProfileForCase(caseId);
            String url = "~/_layouts/Zurich/images/Content/";
            
            String core_image = "";
            String non_core_image = "";


            switch (riskProfileAnalysis.riskProfileName)
            {

                case "Adventurous":
                    {
                        core_image = "core_adventurous.png";
                        non_core_image = "noncore_adventurous.png";
                        break;
                    }
                case "Balanced":
                    {
                        core_image = "core_balanced.png";
                        non_core_image = "noncore_balanced.png";
                        break;
                    }
                case "Cautious":
                    {
                        core_image = "core_cautious.png";
                        non_core_image = "noncore_cautious.png";
                        break;
                    }
                case "Moderately Adventurous":
                    {
                        core_image = "core_moderately_adventorous.png";
                        non_core_image = "noncore_moderately_adventurous.png";
                        break;
                    }
                case "Moderately Cautious":
                    {
                        core_image = "core_moderately_cautious.png";
                        non_core_image = "noncore_moderately_cautious.png";
                        break;
                    }
                default:
                    {
                        core_image = "";
                        non_core_image = "";
                        break;
                    }
            }

            String coreurl = url + core_image;
            String noncoreurl = url + non_core_image;

            sectionAImage.ImageUrl = coreurl;
            sectionBImage.ImageUrl = noncoreurl;

        }
    }
}
