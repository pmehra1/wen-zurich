using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
//using System.Diagnostics;

namespace DAO
{
    public class MyNeedsDAO
    {
        public myNeed saveMyNeeds(myNeed myNeeds)
        {
            int status = 1;

            try
            {
                dbDataContext ct = new dbDataContext();
                ct.myNeeds.InsertOnSubmit(myNeeds);
                ct.SubmitChanges();
            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }  

            if (status == 0)
            {
                myNeeds = null;
            }

            return myNeeds;
        }

        public myNeed updateMyNeeds(myNeed needs)
        {
            myNeed retrievedNeed = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing my need
                var queryMyNeeds = from myneed in ct.myNeeds
                                       where myneed.caseId == needs.caseId
                                       select myneed;
                foreach (myNeed myNeeds in queryMyNeeds)
                {
                    retrievedNeed = myNeeds;
                }


                //update my need attributes
                retrievedNeed.lumpSumRequiredForTreatment = needs.lumpSumRequiredForTreatment;
                retrievedNeed.totalRequired = needs.totalRequired;
                retrievedNeed.criticalIllnessInsurance = needs.criticalIllnessInsurance;
                retrievedNeed.existingAssetsMyneeds = needs.existingAssetsMyneeds;
                retrievedNeed.totalShortfallSurplusMyNeeds = needs.totalShortfallSurplusMyNeeds;
                retrievedNeed.lumpSumMyNeeds = needs.lumpSumMyNeeds;
                retrievedNeed.existingSumMyNeeds = needs.existingSumMyNeeds;
                retrievedNeed.shortfallSumMyNeeds = needs.shortfallSumMyNeeds;
                retrievedNeed.monthlyIncomeDisabilityIncome = needs.monthlyIncomeDisabilityIncome;
                retrievedNeed.percentOfIncomeCoverageRequired = needs.percentOfIncomeCoverageRequired;
                retrievedNeed.monthlyCoverageRequired = needs.monthlyCoverageRequired;
                retrievedNeed.disabilityInsuranceMyNeeds = needs.disabilityInsuranceMyNeeds;
                retrievedNeed.existingAssetsMyneedsDisability = needs.existingAssetsMyneedsDisability;
                retrievedNeed.shortfallSurplusMyNeeds = needs.shortfallSurplusMyNeeds;
                retrievedNeed.monthlyAmountMyNeeds = needs.monthlyAmountMyNeeds;
                retrievedNeed.existingMyNeeds = needs.existingMyNeeds;
                retrievedNeed.shortfallMyNeeds = needs.shortfallMyNeeds;
                retrievedNeed.typeOfHospitalCoverage = needs.typeOfHospitalCoverage;
                retrievedNeed.anyExistingPlans = needs.anyExistingPlans;
                retrievedNeed.typeOfRoomCoverage = needs.typeOfRoomCoverage;
                retrievedNeed.coverageOldageYesNo = needs.coverageOldageYesNo;
                retrievedNeed.epOldageYesNo = needs.epOldageYesNo;
                retrievedNeed.coverageIncomeYesNo = needs.coverageIncomeYesNo;
                retrievedNeed.epIncomeYesNo = needs.epIncomeYesNo;
                retrievedNeed.coverageOutpatientYesNo = needs.coverageOutpatientYesNo;
                retrievedNeed.epOutpatientYesNo = needs.epOutpatientYesNo;
                retrievedNeed.coverageDentalYesNo = needs.coverageDentalYesNo;
                retrievedNeed.epDentalYesNo = needs.epDentalYesNo;
                retrievedNeed.coveragePersonalYesNo = needs.coveragePersonalYesNo;
                retrievedNeed.epPersonalYesNo = needs.epPersonalYesNo;
                retrievedNeed.criticalIllnessPrNeeded = needs.criticalIllnessPrNeeded;
                retrievedNeed.disabilityPrNeeded = needs.disabilityPrNeeded;
                retrievedNeed.hospitalmedCoverNeeded = needs.hospitalmedCoverNeeded;
                retrievedNeed.accidentalhealthCoverNeeded = needs.accidentalhealthCoverNeeded;
                
                if ((needs.anyExistingPlans == true) || (needs.epOldageYesNo == true) || (needs.epPersonalYesNo == true))
                {
                    retrievedNeed.existingPlansDetail = needs.existingPlansDetail;
                }
                else
                    retrievedNeed.existingPlansDetail = "";

               // retrievedNeed.existingPlansDetail = needs.existingPlansDetail;

                retrievedNeed.disabilityProtectionReplacementIncomeRequired = needs.disabilityProtectionReplacementIncomeRequired;
                retrievedNeed.disabilityProtectionReplacementIncomeRequiredPercentage =needs.disabilityProtectionReplacementIncomeRequiredPercentage;
                retrievedNeed.replacementIncomeRequired = needs.replacementIncomeRequired;
                retrievedNeed.yearsOfSupportRequired = needs.yearsOfSupportRequired;
                retrievedNeed.disabilityYearsOfSupport = needs.disabilityYearsOfSupport;
                retrievedNeed.inflatedAdjustedReturns = needs.inflatedAdjustedReturns;
                retrievedNeed.replacementAmountRequired = needs.replacementAmountRequired;
                retrievedNeed.disabilityReplacementAmountRequired = needs.disabilityReplacementAmountRequired;
                retrievedNeed.disabilityInsurance = needs.disabilityInsurance;
                retrievedNeed.inflationAdjustedReturns = needs.inflationAdjustedReturns;




                //delete existing assets for my needs critical illness
                var queryExistingCriticalAssets = from eamyneed in ct.myNeedsCriticalAssets
                                          where eamyneed.myNeedId == retrievedNeed.id
                                          select eamyneed;
                foreach (myNeedsCriticalAsset eamyneeds in queryExistingCriticalAssets)
                {
                    ct.myNeedsCriticalAssets.DeleteOnSubmit(eamyneeds);
                    //ct.SubmitChanges();
                }

                //update existing assets list for my needs critical illness
                if (needs.myNeedsCriticalAssets != null && needs.myNeedsCriticalAssets.Count > 0)
                {
                    EntitySet<myNeedsCriticalAsset> eaMNCriticalList = new EntitySet<myNeedsCriticalAsset>();
                    foreach (myNeedsCriticalAsset mnea in needs.myNeedsCriticalAssets)
                    {
                        eaMNCriticalList.Add(mnea);
                    }
                    retrievedNeed.myNeedsCriticalAssets = eaMNCriticalList;
                }

                
                //delete existing assets for my needs disability income
                var queryExistingDisablityAssets = from eamyneed in ct.myNeedsDisabilityAssets
                                                  where eamyneed.myNeedId == retrievedNeed.id
                                                  select eamyneed;
                foreach (myNeedsDisabilityAsset eamyneeds in queryExistingDisablityAssets)
                {
                    ct.myNeedsDisabilityAssets.DeleteOnSubmit(eamyneeds);
                    //ct.SubmitChanges();
                }

                //update existing assets list for disability income
                if (needs.myNeedsDisabilityAssets != null && needs.myNeedsDisabilityAssets.Count > 0)
                {
                    EntitySet<myNeedsDisabilityAsset> eaMNDisabilityList = new EntitySet<myNeedsDisabilityAsset>();
                    foreach (myNeedsDisabilityAsset mnea in needs.myNeedsDisabilityAssets)
                    {
                        eaMNDisabilityList.Add(mnea);
                    }
                    retrievedNeed.myNeedsDisabilityAssets = eaMNDisabilityList;
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

        public myNeed getMyNeed(string caseid)
        {
            myNeed myNeed = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryMyNeeds = from sg in ct.myNeeds
                                       where sg.caseId == caseid
                                       select sg;
                foreach (myNeed need in queryMyNeeds)
                {
                    myNeed = need;
                }

            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }  

            return myNeed;
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
