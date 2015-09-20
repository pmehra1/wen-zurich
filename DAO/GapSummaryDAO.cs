using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
//using System.Diagnostics;

namespace DAO
{
    public class GapSummaryDAO
    {
        public DataTable GetGapSummary(string caseID)
        {
            SqlConnection conn = DatabaseConnection.Connection.getConnection();
            DataTable dtGapSummary = new DataTable();
            
            try
            {
                SqlCommand cmd = new SqlCommand("sp_getGapSummary", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseId", caseID));

                SqlDataReader dataReader = cmd.ExecuteReader();
                dtGapSummary.Load(dataReader);
            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }

            return dtGapSummary;            
        }

        public void DeleteGapSummary(string caseID)
        {            
            SqlConnection conn = DatabaseConnection.Connection.getConnection();

            try
            {
                SqlCommand cmd = new SqlCommand("sp_DeleteGapSummary", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseID));                

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                logException(ex);
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

        public bool SaveGapSummary(string caseID, int needId, int needTypeId, string myPriorities)
        {
            int iretVal = 0;
            SqlConnection conn = DatabaseConnection.Connection.getConnection();

            try
            {

                SqlCommand cmd = new SqlCommand("sp_SaveGapSummary", conn);  

                cmd = new SqlCommand("sp_SaveGapSummary", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CaseID", caseID));
                cmd.Parameters.Add(new SqlParameter("@NeedId", needId));
                cmd.Parameters.Add(new SqlParameter("@NeedTypeId", needTypeId));
                cmd.Parameters.Add(new SqlParameter("@myPriorities", myPriorities));                
            
                iretVal = cmd.ExecuteNonQuery();                
           
            }
            catch (Exception ex)
            {
                logException(ex);
                throw ex;
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }

            if (iretVal <= 0)
            {
                return false;
            }
            return true;
        }

        private void logException(Exception ex)
        {
            string strException = " Source     : " + ex.Source + "\n" +
                                  " Message    : " + ex.Message + "\n" +
                                  " StackTrace : " + ex.StackTrace;

            //EventLog.WriteEntry("Zurich PortFolio Builder", strException, EventLogEntryType.Error);

        }
    }
}
