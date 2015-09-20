using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
//using System.Diagnostics;

namespace DAO
{
    public class FamilyNeedsDAO
    {
        public familyNeed saveFamilyNeeds(familyNeed familyNeeds)
        {
            int status = 1;

            try
            {
                dbDataContext ct = new dbDataContext();
                ct.familyNeeds.InsertOnSubmit(familyNeeds);
                ct.SubmitChanges();
            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }   

            if (status == 0)
            {
                familyNeeds = null;
            }

            return familyNeeds;
        }

        public familyNeed updateFamilyNeeds(familyNeed needs)
        {
            familyNeed retrievedNeed = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing family need
                var queryfamilyNeeds = from fneed in ct.familyNeeds
                                       where fneed.caseId == needs.caseId
                                       select fneed;
                foreach (familyNeed fNeeds in queryfamilyNeeds)
                {
                    retrievedNeed = fNeeds;
                }

                
                //update family need attributes
                retrievedNeed.familyIncPrNeeded = needs.familyIncPrNeeded;
                retrievedNeed.mortgageNeeded = needs.mortgageNeeded;
                retrievedNeed.replacementIncomeRequired = needs.replacementIncomeRequired;
                retrievedNeed.yearsOfSupportRequired = needs.yearsOfSupportRequired;
                retrievedNeed.inflationAdjustedReturns = needs.inflationAdjustedReturns;
                retrievedNeed.lumpSumRequired = needs.lumpSumRequired;
                retrievedNeed.otherLiabilities = needs.otherLiabilities;
                retrievedNeed.emergencyFundsNeeded = needs.emergencyFundsNeeded;
                retrievedNeed.finalExpenses = needs.finalExpenses;
                retrievedNeed.otherFundingNeeds = needs.otherFundingNeeds;
                retrievedNeed.otherComments = needs.otherComments;
                retrievedNeed.totalRequired = needs.totalRequired;
                retrievedNeed.existingLifeInsurance = needs.existingLifeInsurance;
                retrievedNeed.existingAssetsFamilyneeds = needs.existingAssetsFamilyneeds;
                retrievedNeed.totalShortfallSurplus = needs.totalShortfallSurplus;
                retrievedNeed.lumpSumRequiredChart = needs.lumpSumRequiredChart;
                retrievedNeed.existingSumRequiredChart = needs.existingSumRequiredChart;
                retrievedNeed.shortfallSumRequiredChart = needs.shortfallSumRequiredChart;
                retrievedNeed.inflationAdjustedReturnsGraph = needs.inflationAdjustedReturnsGraph;
                retrievedNeed.yearsOfSupportRequiredGraph = needs.yearsOfSupportRequiredGraph;
                retrievedNeed.replacementIncomeChart = needs.replacementIncomeChart;
                retrievedNeed.mortgageProtectionOutstanding = needs.mortgageProtectionOutstanding;
                retrievedNeed.mortgageProtectionInsurances = needs.mortgageProtectionInsurances;
                retrievedNeed.mortgageProtectionTotal = needs.mortgageProtectionTotal;
                retrievedNeed.mortgageLoan = needs.mortgageLoan;
                retrievedNeed.mortgageInsurance = needs.mortgageInsurance;
                retrievedNeed.mortgageShortfall = needs.mortgageShortfall;
                retrievedNeed.lumpSumRequiredChart = needs.lumpSumRequiredChart;

                //delete existing assets for the family need
                var queryExistingAssets = from eafneed in ct.familyNeedsAssets
                                          where eafneed.familyNeedId == retrievedNeed.id
                                          select eafneed;
                foreach (familyNeedsAsset eafneeds in queryExistingAssets)
                {
                    ct.familyNeedsAssets.DeleteOnSubmit(eafneeds);
                    //ct.SubmitChanges();
                }

                //update existing assets list for the family need
                if (needs.familyNeedsAssets != null && needs.familyNeedsAssets.Count > 0)
                {
                    EntitySet<familyNeedsAsset> eafnList = new EntitySet<familyNeedsAsset>();
                    foreach (familyNeedsAsset fnea in needs.familyNeedsAssets)
                    {
                        eafnList.Add(fnea);
                    }
                    retrievedNeed.familyNeedsAssets = eafnList;
                }

                ct.SubmitChanges();

            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }   

            return retrievedNeed;
        }

        public familyNeed getFamilyNeed(string caseid)
        {
            familyNeed fNeed = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryFamilyNeeds = from sg in ct.familyNeeds 
                                       where sg.caseId == caseid
                                       select sg;
                foreach (familyNeed need in queryFamilyNeeds)
                {
                    fNeed = need;
                }

            } 
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }            

            return fNeed;
        }

        private void logException(Exception ex)
        {
            string strException = " Source     : " + ex.Source + "\n" +
                                  " Message    : " + ex.Message + "\n" +
                                  " StackTrace : " + ex.StackTrace;

            //EventLogPermission eventLogPermission = new EventLogPermission(EventLogPermissionAccess.Write, ".");

            //eventLogPermission.PermitOnly();
            //EventLog.WriteEntry("Zurich PortFolio Builder", strException, EventLogEntryType.Error);

        }
    }

}
