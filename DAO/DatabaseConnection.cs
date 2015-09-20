using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace DAO
{
    public class DatabaseConnection
    {
        private static DatabaseConnection connection;
        private DatabaseConnection() { }

        public static DatabaseConnection Connection
        {
            get
            {
                if (connection == null)
                {
                    connection = new DatabaseConnection();
                }
                return connection;
            }
        }

        private SqlConnection conn;
        //private string connectionLink = @"Data Source=.\EC2SQLEXPRESS;Initial Catalog=zurichdata;User ID=zurich;Password=123456;";
        //private string connectionLink = @"Data Source=WIN-NROO1OAGM8T\SQLEXPRESS;Initial Catalog=zurichdata;Trusted_Connection=Yes;Integrated Security=true;";
        private string connectionLink = @"Data Source=WIN-NROO1OAGM8T;Initial Catalog=zurichdata;User ID=zurich;Password=password$1;Trusted_Connection=False;Integrated Security=false;";
        // private string connectionLink = @"Data Source=10.68.38.73;Initial Catalog=zurichdata;Trusted_Connection=Yes;Integrated Security=SSPI;";

        public SqlConnection getConnection()
        {

            try
            {
                conn = new SqlConnection(dbDataContext.getZurichConnectionString());
                conn.Open();
                
            }
            catch (Exception E)
            {
                //System.IO.File.AppendAllText(@"C:\ZurichLogs\logs.txt", E.ToString());
            }
            return conn;
        }

        public void closeConnection()
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
}
