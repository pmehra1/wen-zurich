using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
//using System.Diagnostics;

namespace DAO
{
    public class PortFolioModellingDAO
    {
        public DataTable getFunds(int riskProfileId, int assetType, string caseid, bool isInitialLoad)
        {
            SqlConnection con = new SqlConnection();
            DataTable dt = new DataTable();
            
            try
            {
                string caseCondition = string.Empty;
                if (caseid != string.Empty)
                {
                    caseCondition = " and pfb.portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster " +
                         " WHERE caseId = " + caseid + ") ";
                }

                string strPercentCondition = string.Empty;
                string strAmountCondition = string.Empty;
                if (isInitialLoad)
                {
                    strPercentCondition = " pfb.allocationPercentage as allocationPercentage, ";
                    strAmountCondition = " pfb.amount as amount ";
                }
                else
                {
                    strPercentCondition = " '' as allocationPercentage, ";
                    strAmountCondition = " '' as amount ";
                }

                con = DatabaseConnection.Connection.getConnection();
                
                String sql = "select e.fullName as RiskProfile, " +
                             " c.description as PrimaryOrSecondary, " +
                             " b.fullName as fundName , " +
                             " a.allocation_type_id, " +
                             " b.id as fund_id, " +
                             " b.asset_id as asset_id, " +
                             " f.name as assetName, " +
                             strPercentCondition +
                             strAmountCondition +
                             " from dbo.fund_risk_profile_mapping a " +
                             " join dbo.fund_lkp b on a.fundid=b.id " +
                             " join dbo.option3FundAssetMapping f on b.id=f.fundId " +
                             " join dbo.allocation_type_lkp c on a.allocation_type_id=c.id " +
                             " join dbo.risk_profile_lkp e on a.riskprofileid=e.id " +
                             " left outer join dbo.portFolioBuilderDetail pfb on pfb.assetClassId = b.asset_id and pfb.fundId = b.id " + 
                             " " + caseCondition +
                             " where 1=1 ";

                if (assetType != 0)
                    sql += "and c.id=" + assetType;

                if (riskProfileId != 0)
                {
                    sql += "and a.riskprofileid=" + riskProfileId;
                }
                else
                {
                    sql += " and 1=2";
                }

                sql += " order by f.sorting_order asc";
                SqlCommand command = new SqlCommand(sql, con);
                SqlDataReader dataReader = command.ExecuteReader();
                                
                dt.Load(dataReader);                                
            }
            catch (Exception ex)
            {
                logException(ex, "getFunds");
                throw;
            }
            finally
            {  
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dt;
        }

        public DataTable getFundSelection(string caseid, bool isInitialLoad)
        {
            SqlConnection con = new SqlConnection();
            DataTable dt = new DataTable();

            try
            {
                string caseCondition = string.Empty;
                if (caseid != string.Empty)
                {
                    caseCondition = " and pfb.portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster " +
                         " WHERE caseId = " + caseid + ") ";
                }

                string strPercentCondition = string.Empty;
                string strAmountCondition = string.Empty;
                if (isInitialLoad)
                {
                    strPercentCondition = " pfb.allocationPercentage as allocationPercentage, ";
                    strAmountCondition = " pfb.amount as amount ";
                }
                else
                {
                    strPercentCondition = " '' as allocationPercentage, ";
                    strAmountCondition = " '' as amount ";
                }

                con = DatabaseConnection.Connection.getConnection();
                String sql = "select b.fullName as fundName,f.name as assetName,b.id as fund_id,b.asset_id as asset_id, " +
                             strPercentCondition +
                             strAmountCondition +  
                             " from dbo.fund_lkp b " +
                             " join dbo.option3FundAssetMapping f on b.id=f.fundId " +
                             " left outer join dbo.portFolioBuilderDetail pfb on pfb.assetClassId = b.asset_id and pfb.fundId = b.id " +
                             " " + caseCondition +
                             " order by f.sorting_order asc";
                SqlCommand command = new SqlCommand(sql, con);
                SqlDataReader dataReader = command.ExecuteReader();
                                
                dt.Load(dataReader);
            }
            catch (Exception ex)
            {
                logException(ex, "getFundSelection");
                throw;
            }
            finally
            {  
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dt;
        }

        
        public DataTable getAllAssets(int riskProfileId, int assetType, string caseID, bool initialLoad)
        {
            SqlConnection con = new SqlConnection();

            DataTable dt = new DataTable();
            try
            {
                string caseCondition = string.Empty;
                string allocationPercentCondition = string.Empty;
                string amountCondition = string.Empty;

                if (caseID != string.Empty)
                {
                    caseCondition = " and pfd.portFolioBuilderId in (SELECT DISTINCT Id FROM portFolioBuilderMaster " +
                         " WHERE caseId = " + caseID + ") ";
                }
                if (initialLoad)
                {
                    allocationPercentCondition = "pfd.allocationPercentage as allocationPercentage,";
                    amountCondition = ", pfd.amount as amount";
                }
                else
                {
                    allocationPercentCondition = "'' as allocationPercentage,";
                    amountCondition = ", '' as amount";
                }

                con = DatabaseConnection.Connection.getConnection();
                String sql = "select a.fullName + ' ' + Str(c.percentage, 5, 2) + '%' as assetName, a.colour, b.fullName as fundName, " +
                             " b.asset_id as asset_id, b.id as fund_id," + allocationPercentCondition + 
                             " Str(c.percentage, 5, 2) as percentage " + amountCondition +
                             " from assets_lkp a " + 
                             " join fund_lkp b on b.asset_id=a.id " + 
                             " join asset_allocation_mapping c on c.asset_id=a.id " +
                             " left outer join portFolioBuilderDetail pfd on pfd.assetClassId = b.asset_id and pfd.fundId = b.id  " +
                             " " + caseCondition +
                             " where 1=1 ";
                sql += " and c.risk_profile_id=" + riskProfileId;

                if (assetType != 2)
                    sql += " and c.allocation_type_id=" + assetType;
                else
                    sql += " and c.allocation_type_id in (6) ";


                if (assetType != 2)
                    sql += " and c.percentage>0 order by c.allocation_type_id asc";
                else
                    sql += " and c.percentage>0 order by b.asset_id asc ";


                SqlCommand command = new SqlCommand(sql, con);
                SqlDataReader dataReader = command.ExecuteReader();
                                
                dt.Load(dataReader);                                
            }
            catch (Exception ex)
            {
                logException(ex, "getAllAssets");
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dt;
        }

        public Dictionary<string, string[]> getFundsLkp()
        {
            SqlConnection con = new SqlConnection();
            Dictionary<string, string[]> funds = new Dictionary<string, string[]>();

            try
            {
                string sql = "select a.id as assetId, b.id as fundId , a.fullName as assetName, "
                             + "b.fullName as fundName "
                             + "from "
                             + "assets_lkp a join fund_lkp b on  b.asset_id=a.id ";
                con = DatabaseConnection.Connection.getConnection();
                SqlCommand command = new SqlCommand(sql, con);
                SqlDataReader dataReader = command.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dataReader);
                
                foreach (DataRow dr in dt.Rows)
                {
                    string fundId = dr["fundId"].ToString();
                    string fundName = dr["fundName"].ToString();
                    string assetId = dr["assetId"].ToString();
                    string assetName = dr["assetName"].ToString();
                    funds.Add((fundId + "-" + assetId), new string[] { fundName, assetName });
                }
            }
            catch (Exception ex)
            {
                logException(ex, "getFundsLkp");
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            
            return funds;
        }

        public Dictionary<string, string[]> getFundsLkpForFundSelector()
        {
            SqlConnection con = new SqlConnection();
            Dictionary<string, string[]> funds = new Dictionary<string, string[]>();

            try
            {
                string sql = "SELECT a.ID as fundId, A.fullName as fundName,F.name as assetName FROM dbo.fund_lkp A " +
                             "JOIN dbo.option3FundAssetMapping f ON A.id=F.fundId";
                con = DatabaseConnection.Connection.getConnection();
                SqlCommand command = new SqlCommand(sql, con);
                SqlDataReader dataReader = command.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dataReader);
                
                foreach (DataRow dr in dt.Rows)
                {
                    string fundId = dr["fundId"].ToString();
                    string fundName = dr["fundName"].ToString();
                    string assetName = dr["assetName"].ToString();
                    funds.Add((fundId), new string[] { fundName, assetName });
                }
            }
            catch (Exception ex)
            {
                logException(ex, "getFundsLkpForFundSelector");
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            
            return funds;
        }

        public List<string> getRiskRatings()
        {
            SqlConnection con = new SqlConnection();
            List<string> lstRiskProfile = new List<string>();

            try
            {                
                con = DatabaseConnection.Connection.getConnection();
                SqlCommand command = new SqlCommand("select * from riskprofile", con);
                SqlDataReader dataReader = command.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(dataReader);

                foreach (DataRow dr in dt.Rows)
                {
                    lstRiskProfile.Add(dr["RiskProfileType"].ToString());

                }
            }
            catch (Exception ex)
            {
                logException(ex, "getRiskRatings");
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            
            return lstRiskProfile;
        }

        public bool SavePortFolioBuilderInfo(string caseId, 
                                            int riskProfileId, 
                                            bool agreeRiskProfile, 
                                            string newRiskProfile, 
                                            bool followAssetAllocationOnRiskProfileYesNo, 
                                            bool assetAllocationOnRiskProfileYesNo, 
                                            bool includeNonCoreFundsYesNo, 
                                            int premiumSelect,
                                            double premiumAmount,
                                            string paymentMode,
                                            double premiumPercent,
                                            double totalPremiumAmount,
                                            DataTable dtPortFolioBuilderDetail)
        {
            int iretVal = 0;
            int iportFolioBuilderId = -1;
            SqlConnection conn = DatabaseConnection.Connection.getConnection();
            
            try
            {                
            
                SqlCommand cmd = new SqlCommand("sp_SavePortFolioMaster", conn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@CaseID", caseId));
                cmd.Parameters.Add(new SqlParameter("@RiskProfileId", riskProfileId));
                cmd.Parameters.Add(new SqlParameter("@AgreeRiskProfile", agreeRiskProfile));
                cmd.Parameters.Add(new SqlParameter("@NewRiskProfile", newRiskProfile));
                cmd.Parameters.Add(new SqlParameter("@FollowAssetAllocationOnRiskProfileYesNo", followAssetAllocationOnRiskProfileYesNo));
                cmd.Parameters.Add(new SqlParameter("@AssetAllocationOnRiskProfileYesNo", assetAllocationOnRiskProfileYesNo));
                cmd.Parameters.Add(new SqlParameter("@IncludeNonCoreFundsYesNo", includeNonCoreFundsYesNo));
                cmd.Parameters.Add(new SqlParameter("@PremiumSelect", premiumSelect));
                cmd.Parameters.Add(new SqlParameter("@PremiumAmount", Convert.ToDecimal(premiumAmount)));                
                cmd.Parameters.Add(new SqlParameter("@PaymentMode", paymentMode));
                cmd.Parameters.Add(new SqlParameter("@PremiumPercent", Convert.ToDecimal(premiumPercent)));
                cmd.Parameters.Add(new SqlParameter("@TotalPremiumAmount", Convert.ToDecimal(totalPremiumAmount)));
                
                SqlParameter portFolioOutputParam =  new SqlParameter("@PortFolioBuilderId", SqlDbType.BigInt);
                portFolioOutputParam.Direction = ParameterDirection.Output;
                
                cmd.Parameters.Add(portFolioOutputParam);
                
                iretVal = cmd.ExecuteNonQuery();

                if (portFolioOutputParam.Value != null)
                {
                    iportFolioBuilderId = Convert.ToInt32(portFolioOutputParam.Value);
                }

                if (iportFolioBuilderId < 0)
                {
                    return false;
                }

                if (dtPortFolioBuilderDetail != null && dtPortFolioBuilderDetail.Rows.Count > 0)
                {
                    foreach (DataRow dRow in dtPortFolioBuilderDetail.Rows)
                    {                        
                        SqlCommand cmdDetail = new SqlCommand("sp_SavePortFolioDetail", conn);

                        cmdDetail.CommandType = CommandType.StoredProcedure;

                        cmdDetail.Parameters.Add(new SqlParameter("@PortFolioBuilderId", iportFolioBuilderId));
                        cmdDetail.Parameters.Add(new SqlParameter("@AssetClassId", dRow["AssetId"]));
                        cmdDetail.Parameters.Add(new SqlParameter("@FundId", dRow["FundId"]));
                        cmdDetail.Parameters.Add(new SqlParameter("@AllocationPercentage", Convert.ToDecimal(dRow["AllocationPercent"])));
                        cmdDetail.Parameters.Add(new SqlParameter("@Amount", Convert.ToDecimal(dRow["Amount"])));

                        iretVal = cmdDetail.ExecuteNonQuery();

                        if (iretVal < 1)
                        {
                            return false;
                        }
                    }
                }

                SqlCommand cmdUpdMaster = new SqlCommand("sp_UpdatePortFolioMaster", conn);

                cmdUpdMaster.CommandType = CommandType.StoredProcedure;
                cmdUpdMaster.Parameters.Add(new SqlParameter("@CaseID", caseId));
                iretVal = cmdUpdMaster.ExecuteNonQuery();

                if (iretVal < 1)
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                logException(ex, "SavePortFolioBuilderInfo");
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }

            if (iretVal > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public DataTable getPortFolioMaster(string caseId)
        {   
            SqlConnection conn = DatabaseConnection.Connection.getConnection();
            DataTable dtPortFolioMaster = new DataTable();
            
            try
            {
                SqlCommand cmd = new SqlCommand("sp_getPortFolioMaster", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseId));

                SqlDataReader dataReader = cmd.ExecuteReader();
                dtPortFolioMaster.Load(dataReader);
            }
            catch (Exception ex)
            {
                logException(ex, "getPortFolioMaster");
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
            
            return dtPortFolioMaster;
        }

        public DataTable getPortFolioDetail(string caseId)
        {
            SqlConnection conn = DatabaseConnection.Connection.getConnection();
            DataTable dtPortFolioDetail = new DataTable();

            try
            {
                SqlCommand cmd = new SqlCommand("sp_getPortFolioDetail", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseId));

                SqlDataReader dataReader = cmd.ExecuteReader();
                dtPortFolioDetail.Load(dataReader);
            }
            catch (Exception ex)
            {
                logException(ex, "getPortFolioDetail");
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }

            return dtPortFolioDetail;
        }

        public DataTable getPortFolioDetailWithMaster(string caseId)
        {
            SqlConnection conn = DatabaseConnection.Connection.getConnection();
            DataTable dtPortFolioDetail = new DataTable();

            try
            {
                SqlCommand cmd = new SqlCommand("sp_getPortFolioDetail_With_Master", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseId));

                SqlDataReader dataReader = cmd.ExecuteReader();
                dtPortFolioDetail.Load(dataReader);
            }
            catch (Exception ex)
            {
                logException(ex, "getPortFolioDetailWithMaster");
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }

            return dtPortFolioDetail;
        }

        public void DeletePoftFolioBuilderForCapitalPreservation(string caseID)
        {
            SqlConnection conn = DatabaseConnection.Connection.getConnection();

            try
            {
                SqlCommand cmd = new SqlCommand("sp_DeletePortfolioBuilderForCP", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseID));

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                logException(ex, "DeletePoftFolioBuilderForCapitalPreservation");
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }

        private void logException(Exception ex, string methodName)
        {
            exceptionlog exLog = new exceptionlog();
            exLog.message = ex.Message + " class: PortFolioModellingDAO Method: " + methodName;
            exLog.source = ex.Source;

            string strtmp = ex.StackTrace;
            strtmp = strtmp.Replace('\r', ' ');
            strtmp = strtmp.Replace('\n', ' ');
            exLog.stacktrace = strtmp;

            exLog.targetsitename = ex.TargetSite.Name;

            ActivityStatusDAO activityStatus = new ActivityStatusDAO();
            activityStatus.logException(exLog); 
        }

    }
          
}
