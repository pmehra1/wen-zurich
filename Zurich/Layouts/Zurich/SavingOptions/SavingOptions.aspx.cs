using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



namespace Zurich.Layouts.Zurich.SavingOptions
{
    public partial class SavingOptions : LayoutsPageBase
    {


        

        protected void Page_Load(object sender, EventArgs e)
        {
            AssumptionDAO dao = new AssumptionDAO();
            
            string shortfallString1 = Request.QueryString["shortfall"];
            string yrstoAccumulateString1= Request.QueryString["yrstoAccumulate"];
            string moduleNameString = Request.QueryString["moduleName"];

            float shortfall = 0;

            if (shortfallString1 != null && shortfallString1 != "" && shortfallString1 != "NaN")
            {
                shortfall = float.Parse(shortfallString1);
            }


            int yearsOfRetirement = 0;

            if (yrstoAccumulateString1 != null && yrstoAccumulateString1 != "" && yrstoAccumulateString1 != "NaN")
            {
                yearsOfRetirement = int.Parse(yrstoAccumulateString1);
            }

            shortfallString.Text = shortfall + "";
            yrstoAccumulateString.Text = yearsOfRetirement + "";

            int module = int.Parse(moduleNameString);



            double regularSumValue1 = 0;
            double regularSumValue2 = 0;
            double regularSumValue3 = 0;
            double regularSumValue4 = 0;

            double lumpSumValue1 = 0;
            double lumpSumValue2 = 0;
            double lumpSumValue3 = 0;
            double lumpSumValue4 = 0;


            float lowest = 0;
            float low = 0;
            float high = 0;
            float highest = 0;

            low = float.Parse(dao.getAssumptionById(6).percentage+"");
            lowest = float.Parse(dao.getAssumptionById(5).percentage+"");
            high = float.Parse(dao.getAssumptionById(7).percentage+"");
            highest = float.Parse(dao.getAssumptionById(8).percentage+"");


            switch (module)
            {
                case 1:
                    {
                        regularSumValue1 = calculateRegularSum(shortfall, lowest, yearsOfRetirement);
                        regularSumValue2 = calculateRegularSum(shortfall, low, yearsOfRetirement);
                        regularSumValue3 = calculateRegularSum(shortfall, high, yearsOfRetirement);
                        regularSumValue4 = calculateRegularSum(shortfall, highest, yearsOfRetirement);


                        lumpSumValue1 = calculateLumpSum(shortfall, lowest, yearsOfRetirement);
                        lumpSumValue2 = calculateLumpSum(shortfall, low, yearsOfRetirement);
                        lumpSumValue3 = calculateLumpSum(shortfall, high, yearsOfRetirement);
                        lumpSumValue4 = calculateLumpSum(shortfall, highest, yearsOfRetirement);
                    };
                    break;
                case 2:
                    {
                        regularSumValue1 = calculateRegularSumRetirement(shortfall, lowest, yearsOfRetirement);
                        regularSumValue2 = calculateRegularSumRetirement(shortfall, low, yearsOfRetirement);
                        regularSumValue3 = calculateRegularSumRetirement(shortfall, high, yearsOfRetirement);
                        regularSumValue4 = calculateRegularSumRetirement(shortfall, highest, yearsOfRetirement);


                        lumpSumValue1 = calculateLumpSumRetirement(shortfall, lowest, yearsOfRetirement);
                        lumpSumValue2 = calculateLumpSumRetirement(shortfall, low, yearsOfRetirement);
                        lumpSumValue3 = calculateLumpSumRetirement(shortfall, high, yearsOfRetirement);
                        lumpSumValue4 = calculateLumpSumRetirement(shortfall, highest, yearsOfRetirement);

                    };
                    break;
                case 3:
                    {
                        regularSumValue1 = calculateRegularSumEducationGoal(shortfall, lowest, yearsOfRetirement);
                        regularSumValue2 = calculateRegularSumEducationGoal(shortfall, low, yearsOfRetirement);
                        regularSumValue3 = calculateRegularSumEducationGoal(shortfall, high, yearsOfRetirement);
                        regularSumValue4 = calculateRegularSumEducationGoal(shortfall, highest, yearsOfRetirement);


                        lumpSumValue1 = calculateLumpSumEducationGoal(shortfall, lowest, yearsOfRetirement);
                        lumpSumValue2 = calculateLumpSumEducationGoal(shortfall, low, yearsOfRetirement);
                        lumpSumValue3 = calculateLumpSumEducationGoal(shortfall, high, yearsOfRetirement);
                        lumpSumValue4 = calculateLumpSumEducationGoal(shortfall, highest, yearsOfRetirement);
                    };
                    break;
                default:
                    break;
            }

            lowest1.Text = regularSumValue1 + "";
            low1.Text = regularSumValue2 + "";
            high1.Text = regularSumValue3 + "";
            highest1.Text = regularSumValue4 + "";


            lumpsumLowest1.Text = lumpSumValue1 + "";
            lumpsumLow1.Text = lumpSumValue2 + "";
            lumpsumHigh1.Text = lumpSumValue3 + "";
            lumpsumHighest1.Text = lumpSumValue4 + "";

            
            
        }

        public static double roundOff(double param)
        {
            if (param == 0)
            {
                return param;
            }
            else
            {
                double calc = Math.Round(param * 100) / 100;
                return param;
            }
            
        }

       
        public static double calculateRegularSum(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = shortfall * (investmentRate / 100);
            float step2 = 1 + (investmentRate / 100);
            double step3 = Math.Pow(step2, (yearsToGo + 1));
            float step4 = 1 + (investmentRate / 100);
            double step5 = step3 - step4;
            double step6 = 0;
            if (step5 != 0)
                step6 = step1 / step5;
            return roundOff(step6);
        }


        public double calculateLumpSum(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = shortfall;
            float step2 = 1 + (investmentRate / 100);
            double step3 = Math.Pow(step2, yearsToGo);

            double step4 = 0;
            if (step3 != 0)
                step4 = step1 / step3;
            return roundOff(step4);
        }


        public double calculateLumpSumRetirement(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = (1 + investmentRate / 100);
            double step2 = Math.Pow(step1, yearsToGo);
            double step3 = 0;

            if (step2 != 0)
                step3 = shortfall / step2;
            return roundOff(step3);

        }

        public double calculateRegularSumRetirement(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = shortfall * (investmentRate / 100);
            float step2 = (1 + (investmentRate / 100));
            double step3 = Math.Pow(step2, (yearsToGo + 1));
            double step4 = step3 - step2;
            double step6 = 0;
            if (step4 != 0)
                step6 = step1 / step4;
            return roundOff(step6);
        }

        public double calculateLumpSumEducationGoal(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = (1 + investmentRate / 100);
            double step2 = Math.Pow(step1, yearsToGo);
            double step3 = 0;

            if (step2 != 0)
                step3 = shortfall / step2;
            return roundOff(step3);

        }

        public double calculateRegularSumEducationGoal(float shortfall, float investmentRate, int yearsToGo)
        {
            float step1 = shortfall * (investmentRate / 100);
            float step2 = (1 + (investmentRate / 100));
            double step3 = Math.Pow(step2, (yearsToGo + 1));
            double step4 = step3 - step2;
            double step6 = 0;
            if (step4 != 0)
                step6 = step1 / step4;
            return roundOff(step6);
        }


         


    }
}
