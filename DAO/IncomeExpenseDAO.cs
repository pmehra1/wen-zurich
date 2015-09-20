using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;



namespace DAO
{
    public class IncomeExpenseDAO
    {
        public incomeExpense getIncomeExpenseForCase(string caseNumber)
        {
            incomeExpense result = null;
            try
            {
                dbDataContext dbDataContext = new dbDataContext();
                IQueryable<incomeExpense> queryable =
                    from a in dbDataContext.GetTable<incomeExpense>()
                    where a.caseId.Equals(caseNumber)
                    select a;
                using (IEnumerator<incomeExpense> enumerator = queryable.GetEnumerator())
                {
                    if (enumerator.MoveNext())
                    {
                        incomeExpense current = enumerator.Current;
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

        public incomeExpense insertNewIncomeExpenseDetails(incomeExpense incomeExpenseDetail)
        {
            try
            {
                dbDataContext ct = new dbDataContext();
                ct.incomeExpenses.InsertOnSubmit(incomeExpenseDetail);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            return incomeExpenseDetail;
            
        }

        public incomeExpense updateIncomeExpenseDetails(incomeExpense incomeExpenseDetail)
        {
            incomeExpense incomeExpense = null;
            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing saving goal 
                var queryIncomeExpenseDetails = from al in ct.incomeExpenses
                                                  where al.caseId == incomeExpenseDetail.caseId
                                                  select al;
                foreach (incomeExpense incomeExpenseDetails in queryIncomeExpenseDetails)
                {
                    incomeExpense = incomeExpenseDetails;
                }

                incomeExpense.emergencyFundsNeeded = incomeExpenseDetail.emergencyFundsNeeded;
                incomeExpense.shortTermGoals = incomeExpenseDetail.shortTermGoals;
                incomeExpense.extraDetails = incomeExpenseDetail.extraDetails;
                incomeExpense.netMonthlyIncomeAfterCpf = incomeExpenseDetail.netMonthlyIncomeAfterCpf;
                incomeExpense.netMonthlyExpenses = incomeExpenseDetail.netMonthlyExpenses;
                incomeExpense.monthlySavings = incomeExpenseDetail.monthlySavings;
                incomeExpense.lifeInsuranceSA = incomeExpenseDetail.lifeInsuranceSA;
                incomeExpense.lifeInsuranceMV = incomeExpenseDetail.lifeInsuranceMV;
                incomeExpense.expiry1 = incomeExpenseDetail.expiry1;
                incomeExpense.lifeInsurancePremium = incomeExpenseDetail.lifeInsurancePremium;
                incomeExpense.lifeInsuranceRemarks = incomeExpenseDetail.lifeInsuranceRemarks;
                incomeExpense.tpdcSA = incomeExpenseDetail.tpdcSA;
                incomeExpense.tpdcMV = incomeExpenseDetail.tpdcMV;
                incomeExpense.expiry2 = incomeExpenseDetail.expiry2;
                incomeExpense.tpdcPremium = incomeExpenseDetail.tpdcPremium;
                incomeExpense.tpdcRemarks = incomeExpenseDetail.tpdcRemarks;
                incomeExpense.criticalIllnessSA = incomeExpenseDetail.criticalIllnessSA;
                incomeExpense.criticalIllnessMV = incomeExpenseDetail.criticalIllnessMV;
                incomeExpense.expiry3 = incomeExpenseDetail.expiry3;
                incomeExpense.criticalIllnessPremium = incomeExpenseDetail.criticalIllnessPremium;
                incomeExpense.criticalIllnessRemarks = incomeExpenseDetail.criticalIllnessRemarks;
                incomeExpense.disabilityIncomeSA = incomeExpenseDetail.disabilityIncomeSA;
                incomeExpense.disabilityIncomeMV = incomeExpenseDetail.disabilityIncomeMV;
                incomeExpense.expiry4 = incomeExpenseDetail.expiry4;
                incomeExpense.disabilityIncomePremium = incomeExpenseDetail.disabilityIncomePremium;
                incomeExpense.disabilityIncomeRemarks = incomeExpenseDetail.disabilityIncomeRemarks;
                incomeExpense.mortgageSA = incomeExpenseDetail.mortgageSA;
                incomeExpense.mortgageMV = incomeExpenseDetail.mortgageMV;
                incomeExpense.expiry5 = incomeExpenseDetail.expiry5;
                incomeExpense.mortgagePremium = incomeExpenseDetail.mortgagePremium;
                incomeExpense.mortgageRemarks = incomeExpenseDetail.mortgageRemarks;
                incomeExpense.others1A = incomeExpenseDetail.others1A;
                incomeExpense.others1V = incomeExpenseDetail.others1V;
                incomeExpense.expiry6 = incomeExpenseDetail.expiry6;
                incomeExpense.others1Premium = incomeExpenseDetail.others1Premium;
                incomeExpense.others1Remarks = incomeExpenseDetail.others1Remarks;

                incomeExpense.DeathTermInsurancePremium = incomeExpenseDetail.DeathTermInsurancePremium;
                incomeExpense.DeathTermInsuranceSA = incomeExpenseDetail.DeathTermInsuranceSA;
                incomeExpense.DeathTermInsuranceTerm = incomeExpenseDetail.DeathTermInsuranceTerm;
                incomeExpense.DeathWholeLifeInsurancePremium = incomeExpenseDetail.DeathWholeLifeInsurancePremium;
                incomeExpense.DeathWholeLifeInsuranceSA = incomeExpenseDetail.DeathWholeLifeInsuranceSA;
                incomeExpense.DeathWholeLifeInsuranceTerm = incomeExpenseDetail.DeathWholeLifeInsuranceTerm;
                incomeExpense.incomeExpenseNeeded = incomeExpenseDetail.incomeExpenseNeeded;
                incomeExpense.incomeExpenseNotNeededReason = incomeExpenseDetail.incomeExpenseNotNeededReason;
                incomeExpense.assecertainingAffordabilityEnable = incomeExpenseDetail.assecertainingAffordabilityEnable;
                incomeExpense.assecertainingAffordabilityReason = incomeExpenseDetail.assecertainingAffordabilityReason;

                
                incomeExpense.otherSourcesOfIncome = incomeExpenseDetail.otherSourcesOfIncome;

                incomeExpense.caseId=incomeExpenseDetail.caseId;
                
                var queryIncomeExpenseOthers = from incomeExpenseOther in ct.incomeExpenseOthers
                                               where incomeExpenseOther.incomeExpenseId == incomeExpenseDetail.id
                                               select incomeExpenseOther;
                foreach (incomeExpenseOther incomeExpenseOther in queryIncomeExpenseOthers)
                {
                    ct.incomeExpenseOthers.DeleteOnSubmit(incomeExpenseOther);
                }

                //update income expense others list for the IncomeExpense goal
                if (incomeExpenseDetail.incomeExpenseOthers != null && incomeExpenseDetail.incomeExpenseOthers.Count > 0)
                {
                    EntitySet<incomeExpenseOther> incomeExpenseOtherSet = new EntitySet<incomeExpenseOther>();
                    foreach (incomeExpenseOther incomeExpenseOther in incomeExpenseDetail.incomeExpenseOthers)
                    {
                        incomeExpenseOtherSet.Add(incomeExpenseOther);
                    }
                    incomeExpense.incomeExpenseOthers = incomeExpenseOtherSet;
                }



                var queryIncomeExpenseSaving = from insuranceArrangementSaving in ct.insuranceArrangementSavings
                                               where insuranceArrangementSaving.incomeExpenseId == incomeExpenseDetail.id
                                               select insuranceArrangementSaving;
                foreach (insuranceArrangementSaving insuranceArrangementSaving in queryIncomeExpenseSaving)
                {
                    ct.insuranceArrangementSavings.DeleteOnSubmit(insuranceArrangementSaving);
                }

                //update income expense others list for the IncomeExpense goal
                if (incomeExpenseDetail.insuranceArrangementSavings != null && incomeExpenseDetail.insuranceArrangementSavings.Count > 0)
                {
                    EntitySet<insuranceArrangementSaving> insuranceArrangementSavingSet = new EntitySet<insuranceArrangementSaving>();
                    foreach (insuranceArrangementSaving insuranceArrangementSaving in incomeExpenseDetail.insuranceArrangementSavings)
                    {
                        insuranceArrangementSavingSet.Add(insuranceArrangementSaving);
                    }
                    incomeExpense.insuranceArrangementSavings = insuranceArrangementSavingSet;
                }





                var queryIncomeExpenseRetirement = from insuranceArrangementRetirement in ct.insuranceArrangementRetirements
                                                   where insuranceArrangementRetirement.incomeExpenseId == incomeExpenseDetail.id
                                                   select insuranceArrangementRetirement;
                foreach (insuranceArrangementRetirement insuranceArrangementRetirement in queryIncomeExpenseRetirement)
                {
                    ct.insuranceArrangementRetirements.DeleteOnSubmit(insuranceArrangementRetirement);
                }

                //update income expense others list for the IncomeExpense goal
                if (incomeExpenseDetail.insuranceArrangementRetirements != null && incomeExpenseDetail.insuranceArrangementRetirements.Count > 0)
                {
                    EntitySet<insuranceArrangementRetirement> insuranceArrangementRetirementSet = new EntitySet<insuranceArrangementRetirement>();
                    foreach (insuranceArrangementRetirement insuranceArrangementRetirement in incomeExpenseDetail.insuranceArrangementRetirements)
                    {
                        insuranceArrangementRetirementSet.Add(insuranceArrangementRetirement);
                    }
                    incomeExpense.insuranceArrangementRetirements = insuranceArrangementRetirementSet;
                }



                var queryIncomeExpenseEducation = from insuranceArrangementEducation in ct.insuranceArrangementEducations
                                                  where insuranceArrangementEducation.incomeExpenseId == incomeExpenseDetail.id
                                                  select insuranceArrangementEducation;
                foreach (insuranceArrangementEducation insuranceArrangementEducation in queryIncomeExpenseEducation)
                {
                    ct.insuranceArrangementEducations.DeleteOnSubmit(insuranceArrangementEducation);
                }

                //update income expense others list for the IncomeExpense goal
                if (incomeExpenseDetail.insuranceArrangementEducations != null && incomeExpenseDetail.insuranceArrangementEducations.Count > 0)
                {
                    EntitySet<insuranceArrangementEducation> insuranceArrangementEducationSet = new EntitySet<insuranceArrangementEducation>();
                    foreach (insuranceArrangementEducation insuranceArrangementEducation in incomeExpenseDetail.insuranceArrangementEducations)
                    {
                        insuranceArrangementEducationSet.Add(insuranceArrangementEducation);
                    }
                    incomeExpense.insuranceArrangementEducations = insuranceArrangementEducationSet;
                }



                
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            return incomeExpense;
        }

    }
}
