using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;



namespace DAO
{
    public class AssetAndLiabilityDAO
    {

        public assetAndLiability getAssetLiabilityForCase(string caseNumber)
        {
            
            assetAndLiability result = null;
            try
            {
                dbDataContext dbDataContext = new dbDataContext();
                IQueryable<assetAndLiability> queryable =
                    from a in dbDataContext.GetTable<assetAndLiability>()
                    where a.caseId.Equals(caseNumber)
                    select a;
                using (IEnumerator<assetAndLiability> enumerator = queryable.GetEnumerator())
                {
                    if (enumerator.MoveNext())
                    {
                        assetAndLiability current = enumerator.Current;
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

        public Boolean insertNewAssetLiabilityDetails(assetAndLiability assetAndLiability)
        {
            Boolean status = true;
            try
            {
                dbDataContext ct = new dbDataContext();
                ct.assetAndLiabilities.InsertOnSubmit(assetAndLiability);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                status = false;
                string str = e.Message;
            }

            return status;
        }

        public Boolean updateAssetLiabilityDetails(assetAndLiability assetAndLiability)
        {
            Boolean status = true;
            assetAndLiability assetLiability = null;
            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing saving goal 
                var queryAssetAndLiabilityGoals = from al in ct.assetAndLiabilities
                                       where al.caseId == assetAndLiability.caseId
                                       select al;
                foreach (assetAndLiability assetLiabilityGoals in queryAssetAndLiabilityGoals)
                {
                    assetLiability = assetLiabilityGoals;
                }

                assetLiability.bankAcctCash = assetAndLiability.bankAcctCash;
                assetLiability.cashLoan = assetAndLiability.cashLoan;
                assetLiability.cpfoaBal = assetAndLiability.cpfoaBal;
                assetLiability.creditCard = assetAndLiability.creditCard;
                assetLiability.homeMortgage = assetAndLiability.homeMortgage;
                assetLiability.ilpCash = assetAndLiability.ilpCash;
                assetLiability.ilpCpf = assetAndLiability.ilpCpf;
                assetLiability.invPropCash = assetAndLiability.invPropCash;
                assetLiability.invPropCpf = assetAndLiability.invPropCpf;
                assetLiability.lumpSumCash = assetAndLiability.lumpSumCash;
                assetLiability.lumpSumCpf = assetAndLiability.lumpSumCpf;
                assetLiability.netWorth = assetAndLiability.netWorth;
                assetLiability.regularSumCash = assetAndLiability.regularSumCash;
                assetLiability.regularSumCpf = assetAndLiability.regularSumCpf;
                assetLiability.resPropCash = assetAndLiability.resPropCash;
                assetLiability.resPropCpf = assetAndLiability.resPropCpf;
                assetLiability.srsBal = assetAndLiability.srsBal;
                assetLiability.srsInvCash = assetAndLiability.srsInvCash;
                assetLiability.stocksSharesCash = assetAndLiability.stocksSharesCash;
                assetLiability.stocksSharesCpf = assetAndLiability.stocksSharesCpf;
                assetLiability.submissionDate = assetAndLiability.submissionDate;
                assetLiability.unitTrustsCash = assetAndLiability.unitTrustsCash;
                assetLiability.unitTrustsCpf = assetAndLiability.unitTrustsCpf;
                assetLiability.vehicleLoan = assetAndLiability.vehicleLoan;
                assetLiability.cpfsaBal = assetAndLiability.cpfsaBal;
                assetLiability.cpfMediSaveBalance = assetAndLiability.cpfMediSaveBalance;
                assetLiability.assetAndLiabilityNeeded = assetAndLiability.assetAndLiabilityNeeded;
                assetLiability.assetAndLiabilityNotNeededReason = assetAndLiability.assetAndLiabilityNotNeededReason;
                assetLiability.assetIncomePercent = assetAndLiability.assetIncomePercent;
                assetLiability.premiumRecomendedNeeded = assetAndLiability.premiumRecomendedNeeded;


                var queryliabilityOthers = from liabilityOther in ct.liabilityOthers
                                           where liabilityOther.assetLiabilityId == assetAndLiability.id
                                           select liabilityOther;
                foreach (liabilityOther liabilityOthers in queryliabilityOthers)
                {
                    ct.liabilityOthers.DeleteOnSubmit(liabilityOthers);
                }

                var querypersonalUseAssetsOthers = from personalUseAssetsOther in ct.personalUseAssetsOthers
                                                   where personalUseAssetsOther.assetLiabilityId == assetAndLiability.id
                                                   select personalUseAssetsOther;
                foreach (personalUseAssetsOther personalUseAssetsOther  in querypersonalUseAssetsOthers)
                {
                    ct.personalUseAssetsOthers.DeleteOnSubmit(personalUseAssetsOther);
                }


                var queryinvestedAssetOthers = from investedAssetOthers in ct.investedAssetOthers
                                               where investedAssetOthers.assetLiabilityId == assetAndLiability.id
                                               select investedAssetOthers;
                foreach (investedAssetOther investedAssetOther in queryinvestedAssetOthers)
                {
                    ct.investedAssetOthers.DeleteOnSubmit(investedAssetOther);
                }


                //update liability others list for the AssetLiability goal
                if (assetAndLiability.liabilityOthers != null && assetAndLiability.liabilityOthers.Count > 0)
                {
                    EntitySet<liabilityOther> liabilityOtherSet = new EntitySet<liabilityOther>();
                    foreach (liabilityOther liabilityOther in assetAndLiability.liabilityOthers)
                    {
                        liabilityOtherSet.Add(liabilityOther);
                    }
                    assetLiability.liabilityOthers = liabilityOtherSet;
                }

                //update personal UseAssets others list for the AssetLiability
                if (assetAndLiability.personalUseAssetsOthers != null && assetAndLiability.personalUseAssetsOthers.Count > 0)
                {
                    EntitySet<personalUseAssetsOther> personalUseAssetsOtherSet = new EntitySet<personalUseAssetsOther>();
                    foreach (personalUseAssetsOther liabilityOther in assetAndLiability.personalUseAssetsOthers)
                    {
                        personalUseAssetsOtherSet.Add(liabilityOther);
                    }
                    assetLiability.personalUseAssetsOthers = personalUseAssetsOtherSet;
                }

                
                //update invested others list for the AssetLiability
                if (assetAndLiability.investedAssetOthers != null && assetAndLiability.investedAssetOthers.Count > 0)
                {
                    EntitySet<investedAssetOther> investedAssetOtherSet = new EntitySet<investedAssetOther>();
                    foreach (investedAssetOther investedAssetOther in assetAndLiability.investedAssetOthers)
                    {
                        investedAssetOtherSet.Add(investedAssetOther);
                    }
                    assetLiability.investedAssetOthers = investedAssetOtherSet;
                }

                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                status = false;
                string str = e.Message;
            }

            return status;

        }

        void SetProperties(object source, object target)
        {
            var customerType = target.GetType();
            foreach (var prop in source.GetType().GetProperties())
            {
                var propGetter = prop.GetGetMethod();
                var propSetter = customerType.GetProperty(prop.Name).GetSetMethod();
                var valueToSet = propGetter.Invoke(source, null);
                propSetter.Invoke(target, new[] { valueToSet });
            }
        }
    }
}
