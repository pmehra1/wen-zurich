using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;
using DAO.DTO;


namespace DAO
{
    public class RiskProfileDAO
    {
        public void  saveNewRiskProfile(RiskProfileAnalysis RiskProfileDetails)
        {
            try
            {
                dbDataContext ct = new dbDataContext();

                if (RiskProfileDetails.agreeWithRiskProfileoption2 == "true")
                {
                    RiskProfileDetails.riskProfileName = getRiskProfileName(Int32.Parse(RiskProfileDetails.riskProfileValue));
                }
                else
                {
                    int score = calculateRiskProfile(RiskProfileDetails);
                    RiskProfileDetails.riskProfileValue = score + "";
                    String profile_name = getRiskProfileName(score);
                    RiskProfileDetails.riskProfileName = profile_name;

                }
                
                ct.RiskProfileAnalysis.InsertOnSubmit(RiskProfileDetails);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            
            
        }

        public RiskProfile populateRiskProfile(RiskProfileAnalysis RiskProfileDetails)
        {
            RiskProfile profile = new RiskProfile();
            if (RiskProfileDetails.riskApetiteQuestion1option1 == "true")
                profile.riskApetiteQuestion1 = "-16";
            if (RiskProfileDetails.riskApetiteQuestion1option2 == "true")
                profile.riskApetiteQuestion1 = "-3";
            if (RiskProfileDetails.riskApetiteQuestion1option3 == "true")
                profile.riskApetiteQuestion1 = "2";
            if (RiskProfileDetails.riskApetiteQuestion1option4 == "true")
                profile.riskApetiteQuestion1 = "8";
            if (RiskProfileDetails.riskApetiteQuestion1option5 == "true")
                profile.riskApetiteQuestion1 = "12";
            if (RiskProfileDetails.riskApetiteQuestion1option6 == "true")
                profile.riskApetiteQuestion1 = "16";


            if (RiskProfileDetails.riskApetiteQuestion2option1 == "true")
                profile.riskApetiteQuestion2 = "1";
            if (RiskProfileDetails.riskApetiteQuestion2option2 == "true")
                profile.riskApetiteQuestion2 = "2";
            if (RiskProfileDetails.riskApetiteQuestion2option3 == "true")
                profile.riskApetiteQuestion2 = "4";
            if (RiskProfileDetails.riskApetiteQuestion2option4 == "true")
                profile.riskApetiteQuestion2 = "5";


            if (RiskProfileDetails.riskApetiteQuestion3option1 == "true")
                profile.riskApetiteQuestion3 = "-4";
            if (RiskProfileDetails.riskApetiteQuestion3option2 == "true")
                profile.riskApetiteQuestion3 = "1";
            if (RiskProfileDetails.riskApetiteQuestion3option3 == "true")
                profile.riskApetiteQuestion3 = "4";
            if (RiskProfileDetails.riskApetiteQuestion3option4 == "true")
                profile.riskApetiteQuestion3 = "5";
            if (RiskProfileDetails.riskApetiteQuestion3option5 == "true")
                profile.riskApetiteQuestion3 = "6";

            if (RiskProfileDetails.riskApetiteQuestion4option1 == "true")
                profile.riskApetiteQuestion4 = "1";
            if (RiskProfileDetails.riskApetiteQuestion4option2 == "true")
                profile.riskApetiteQuestion4 = "3";
            if (RiskProfileDetails.riskApetiteQuestion4option3 == "true")
                profile.riskApetiteQuestion4 = "5";



            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion1option1 == "true")
                profile.measuringRiskTakingAbilityQuestion1 = "-3";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion1option2 == "true")
                profile.measuringRiskTakingAbilityQuestion1 = "0";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion1option3 == "true")
                profile.measuringRiskTakingAbilityQuestion1 = "3";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion1option4 == "true")
                profile.measuringRiskTakingAbilityQuestion1 = "5";


            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion2option1 == "true")
                profile.measuringRiskTakingAbilityQuestion2 = "0";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion2option2 == "true")
                profile.measuringRiskTakingAbilityQuestion2 = "3";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion2option3 == "true")
                profile.measuringRiskTakingAbilityQuestion2 = "5";

            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion3option1 == "true")
                profile.measuringRiskTakingAbilityQuestion3 = "0";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion3option2 == "true")
                profile.measuringRiskTakingAbilityQuestion3 = "2";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion3option3 == "true")
                profile.measuringRiskTakingAbilityQuestion3 = "3";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion3option4 == "true")
                profile.measuringRiskTakingAbilityQuestion3 = "5";


            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion4option1 == "true")
                profile.measuringRiskTakingAbilityQuestion4 = "0";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion4option2 == "true")
                profile.measuringRiskTakingAbilityQuestion4 = "2";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion4option3 == "true")
                profile.measuringRiskTakingAbilityQuestion4 = "3";
            if (RiskProfileDetails.measuringRiskTakingAbilityQuestion4option4 == "true")
                profile.measuringRiskTakingAbilityQuestion4 = "5";
            
            return profile;
        }



        public int calculateRiskProfileAppetiteForPopulate(RiskProfileAnalysis RiskProfileDetails)
        {

            RiskProfile profile = populateRiskProfile(RiskProfileDetails);
            int riskProfileApetite = calculateRiskProfileApetite(profile);
            return riskProfileApetite;
        }

        public int calculateRiskProfileAbilityForPopulate(RiskProfileAnalysis RiskProfileDetails)
        {

            RiskProfile profile = populateRiskProfile(RiskProfileDetails);
            int riskProfileAbility = calculateRiskProfileAbility(profile);
            return riskProfileAbility;
        }

        public int calculateRiskProfile(RiskProfileAnalysis RiskProfileDetails)
        {
            RiskProfile profile=populateRiskProfile(RiskProfileDetails);
            int riskProfileApetite = calculateRiskProfileApetite(profile);
            int profileRating = calculateRiskProfileApetite(profile);


            int[,] scores = { { 0, 1, 1, 1, 1, 1 }, { 0, 1, 2, 2, 2, 2 }, { 0, 1, 2, 3, 3, 3 }, { 0, 1, 2, 3, 4, 4 }, { 0, 1, 2, 3, 4, 5 } };

            int riskApetite = calculateRiskProfileApetite(profile);
            int riskAbility = calculateRiskProfileAbility(profile);

            int score = scores[riskAbility, riskApetite];
            return score;
        }


        public int calculateRiskProfileApetite(RiskProfile profile)
        {
            int riskProfileApetite = 0;
            if (profile.riskApetiteQuestion1 != null)
                riskProfileApetite += Convert.ToInt32(profile.riskApetiteQuestion1);

            if (profile.riskApetiteQuestion2 != null)
                riskProfileApetite += Convert.ToInt32(profile.riskApetiteQuestion2);

            if (profile.riskApetiteQuestion3 != null)
                riskProfileApetite += Convert.ToInt32(profile.riskApetiteQuestion3);

            if (profile.riskApetiteQuestion4 != null)
                riskProfileApetite += Convert.ToInt32(profile.riskApetiteQuestion4);

            if (riskProfileApetite < 0)
                return 0;
            else if (riskProfileApetite >= 0 && riskProfileApetite <= 8)
                return 1;
            else if (riskProfileApetite > 8 && riskProfileApetite <= 17)
                return 2;
            else if (riskProfileApetite > 17 && riskProfileApetite <= 22)
                return 3;
            else if (riskProfileApetite > 22 && riskProfileApetite <= 26)
                return 4;
            else if (riskProfileApetite > 26 && riskProfileApetite <= 32)
                return 5;
            else
                return 0;

        }

        public int calculateRiskProfileAbility(RiskProfile profile)
        {
            int measuringRiskTakingAbilityQuestion = 0;
            if (profile.measuringRiskTakingAbilityQuestion1 != null)
                measuringRiskTakingAbilityQuestion += Convert.ToInt32(profile.measuringRiskTakingAbilityQuestion1);

            if (profile.measuringRiskTakingAbilityQuestion2 != null)
                measuringRiskTakingAbilityQuestion += Convert.ToInt32(profile.measuringRiskTakingAbilityQuestion2);

            if (profile.measuringRiskTakingAbilityQuestion3 != null)
                measuringRiskTakingAbilityQuestion += Convert.ToInt32(profile.measuringRiskTakingAbilityQuestion3);

            if (profile.measuringRiskTakingAbilityQuestion4 != null)
                measuringRiskTakingAbilityQuestion += Convert.ToInt32(profile.measuringRiskTakingAbilityQuestion4);

            if (measuringRiskTakingAbilityQuestion < 7)
                return 0;
            else if (measuringRiskTakingAbilityQuestion >= 7 && measuringRiskTakingAbilityQuestion <= 10)
                return 1;
            else if (measuringRiskTakingAbilityQuestion > 10 && measuringRiskTakingAbilityQuestion <= 14)
                return 2;
            else if (measuringRiskTakingAbilityQuestion > 14 && measuringRiskTakingAbilityQuestion <= 17)
                return 3;
            else if (measuringRiskTakingAbilityQuestion > 17 && measuringRiskTakingAbilityQuestion <= 20)
                return 4;
            else
                return 0;
        }

        public String getRiskProfileName(int score)
        {
            String risk_score_desc = "";
            switch (score)
            {
                case 0:
                    risk_score_desc = "Capital Preservation";
                    break;
                case 1:
                    risk_score_desc = "Cautious";
                    break;
                case 2:
                    risk_score_desc = "Moderately Cautious";
                    break;
                case 3:
                    risk_score_desc = "Balanced";
                    break;
                case 4:
                    risk_score_desc = "Moderately Adventurous";
                    break;
                case 5:
                    risk_score_desc = "Adventurous";
                    break;
                default:
                    risk_score_desc = "Capital Preservation";
                    break;
            }
            return risk_score_desc;

        }


        public void updateRiskProfileDetails(RiskProfileAnalysis riskProfile,string type)
        {
            RiskProfileAnalysis riskProfileAnalysis = null;
            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing saving goal 
                var queryRiskProfileDetails = from al in ct.RiskProfileAnalysis
                                                  where al.caseId == riskProfile.caseId
                                                  select al;
                foreach (RiskProfileAnalysis riskProfileVariable in queryRiskProfileDetails)
                {
                    riskProfileAnalysis = riskProfileVariable;
                }


                riskProfileAnalysis.caseId=riskProfile.caseId;

                
                    riskProfileAnalysis.agreeWithRiskProfileoption1 = riskProfile.agreeWithRiskProfileoption1;
                    riskProfileAnalysis.agreeWithRiskProfileoption2 = riskProfile.agreeWithRiskProfileoption2;

                    riskProfileAnalysis.riskApetiteQuestion1option1 = riskProfile.riskApetiteQuestion1option1;
                    riskProfileAnalysis.riskApetiteQuestion1option2 = riskProfile.riskApetiteQuestion1option2;
                    riskProfileAnalysis.riskApetiteQuestion1option3 = riskProfile.riskApetiteQuestion1option3;
                    riskProfileAnalysis.riskApetiteQuestion1option4 = riskProfile.riskApetiteQuestion1option4;
                    riskProfileAnalysis.riskApetiteQuestion1option5 = riskProfile.riskApetiteQuestion1option5;
                    riskProfileAnalysis.riskApetiteQuestion1option6 = riskProfile.riskApetiteQuestion1option6;

                    riskProfileAnalysis.riskApetiteQuestion2option1 = riskProfile.riskApetiteQuestion2option1;
                    riskProfileAnalysis.riskApetiteQuestion2option2 = riskProfile.riskApetiteQuestion2option2;
                    riskProfileAnalysis.riskApetiteQuestion2option3 = riskProfile.riskApetiteQuestion2option3;
                    riskProfileAnalysis.riskApetiteQuestion2option4 = riskProfile.riskApetiteQuestion2option4;


                    riskProfileAnalysis.riskApetiteQuestion3option1 = riskProfile.riskApetiteQuestion3option1;
                    riskProfileAnalysis.riskApetiteQuestion3option2 = riskProfile.riskApetiteQuestion3option2;
                    riskProfileAnalysis.riskApetiteQuestion3option3 = riskProfile.riskApetiteQuestion3option3;
                    riskProfileAnalysis.riskApetiteQuestion3option4 = riskProfile.riskApetiteQuestion3option4;
                    riskProfileAnalysis.riskApetiteQuestion3option5 = riskProfile.riskApetiteQuestion3option5;


                    riskProfileAnalysis.riskApetiteQuestion4option1 = riskProfile.riskApetiteQuestion4option1;
                    riskProfileAnalysis.riskApetiteQuestion4option2 = riskProfile.riskApetiteQuestion4option2;
                    riskProfileAnalysis.riskApetiteQuestion4option3 = riskProfile.riskApetiteQuestion4option3;


                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option1 = riskProfile.measuringRiskTakingAbilityQuestion1option1;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option2 = riskProfile.measuringRiskTakingAbilityQuestion1option2;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option3 = riskProfile.measuringRiskTakingAbilityQuestion1option3;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion1option4 = riskProfile.measuringRiskTakingAbilityQuestion1option4;

                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option1 = riskProfile.measuringRiskTakingAbilityQuestion2option1;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option2 = riskProfile.measuringRiskTakingAbilityQuestion2option2;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion2option3 = riskProfile.measuringRiskTakingAbilityQuestion2option3;


                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option1 = riskProfile.measuringRiskTakingAbilityQuestion3option1;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option2 = riskProfile.measuringRiskTakingAbilityQuestion3option2;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option3 = riskProfile.measuringRiskTakingAbilityQuestion3option3;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion3option4 = riskProfile.measuringRiskTakingAbilityQuestion3option4;

                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option1 = riskProfile.measuringRiskTakingAbilityQuestion4option1;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option2 = riskProfile.measuringRiskTakingAbilityQuestion4option2;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option3 = riskProfile.measuringRiskTakingAbilityQuestion4option3;
                    riskProfileAnalysis.measuringRiskTakingAbilityQuestion4option4 = riskProfile.measuringRiskTakingAbilityQuestion4option4;
                
                
            if (riskProfileAnalysis.agreeWithRiskProfileoption2 == "true")
                {
                    riskProfileAnalysis.riskProfileValue = riskProfile.riskProfileValue;
                    riskProfileAnalysis.riskProfileName = getRiskProfileName(Int32.Parse(riskProfile.riskProfileValue));
                }
                else
                {
                    int score = calculateRiskProfile(riskProfile);
                    riskProfileAnalysis.riskProfileValue = score + "";
                    String profile_name = getRiskProfileName(score);
                    riskProfileAnalysis.riskProfileName = profile_name;

                }
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
        }
        

        public RiskProfileAnalysis getRiskProfileForCase(string caseNumber)
        {
            RiskProfileAnalysis result = null;
            
            try
            {
                dbDataContext dbDataContext = new dbDataContext();
                IQueryable<RiskProfileAnalysis> queryable =
                    from a in dbDataContext.GetTable<RiskProfileAnalysis>()
                    where a.caseId.Equals(caseNumber)
                    select a;
                using (IEnumerator<RiskProfileAnalysis> enumerator = queryable.GetEnumerator())
                {
                    if (enumerator.MoveNext())
                    {
                        RiskProfileAnalysis current = enumerator.Current;
                        result = current;
                    }
                }
            }
            catch (Exception ex)
            {
                string message = ex.Message;
            }
            return result;
        }
    }
}
