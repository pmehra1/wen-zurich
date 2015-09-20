using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace DAO
{
    public class ErrorLogViewerDAO
    {
        public DataTable GetSQLResult(string sqlqry)
        {
            SqlConnection con = new SqlConnection();
            DataTable dtSQLResult = new DataTable();

            try
            {
                con = DatabaseConnection.Connection.getConnection();
                SqlCommand command = new SqlCommand(sqlqry, con);
                SqlDataReader dataReader = command.ExecuteReader();

                dtSQLResult.Load(dataReader);
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dtSQLResult;
        }

        public DataTable GetErrorLogs()
        {
            SqlConnection con = new SqlConnection();
            DataTable dtErrorLog = new DataTable();

            try
            {
                con = DatabaseConnection.Connection.getConnection();
                SqlCommand command = new SqlCommand("select id, message, source, stacktrace, targetsitename from exceptionlog order by id desc", con);
                SqlDataReader dataReader = command.ExecuteReader();

                dtErrorLog.Load(dataReader);                
            }
            catch (Exception ex)
            {               
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            return dtErrorLog;   
        }
    }
}
