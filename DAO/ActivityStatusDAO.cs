using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace DAO
{
    public class ActivityStatusDAO
    {
        public string getActivity(int activityId)
        {
            string activity = "";

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryActivity = from act in ct.activities
                                           where act.id == activityId
                                           select act;
                foreach (activity a in queryActivity)
                {
                    activity = a.activity1;
                }

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return activity;
        }

        public activitystatus getActivityForCaseid(string caseid, string activity)
        {
            activitystatus activityStatus = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryActivity = from act in ct.activitystatus
                                    where act.caseid == caseid && act.activity == activity
                                    select act;
                foreach (activitystatus a in queryActivity)
                {
                    activityStatus = a;
                }

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return activityStatus;
        }

        public salesportalinfo getSalesPortalInfoForCaseid(string caseid)
        {
            salesportalinfo salesPortalInfo = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var querySalesInfo = from spi in ct.salesportalinfos
                                    where spi.activityid == caseid
                                    select spi;
                foreach (salesportalinfo a in querySalesInfo)
                {
                    salesPortalInfo = a;
                }

            }
            catch (Exception e)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = e.Message + " class: ActivityStatusDAO Method: getSalesPortalInfoForCaseid";
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                logException(exLog);
            }

            return salesPortalInfo;
        }
        
        public void saveOrUpdateActivityStatus(string caseid, string activity, string status)
        {
            activitystatus actstatus = null;
            
            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing activity status 
                var queryActivityStatus = from actst in ct.activitystatus
                                          where actst.caseid == caseid && actst.activity == activity
                                          select actst;

                foreach (activitystatus a in queryActivityStatus)
                {
                    actstatus = a;
                }
                if (actstatus == null)
                {
                    //adding new status
                    activitystatus actStatus = new activitystatus();
                    actStatus.caseid = caseid;
                    actStatus.activity = activity;
                    actStatus.status = status;
                    ct.activitystatus.InsertOnSubmit(actStatus);
                }
                else
                {
                    //update activity status
                    actstatus.status = status;
                }
                
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
        }

        public void saveSalesPortalInfo(string caseid, salesportalinfo salesPortalInfo)
        {
            salesportalinfo spistatus = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing sales portal info 
                var querySalesPortalInfo = from spi in ct.salesportalinfos
                                          where spi.activityid == caseid
                                          select spi;

                foreach (salesportalinfo a in querySalesPortalInfo)
                {
                    spistatus = a;
                }
                if (spistatus == null)
                {
                    //adding new sales portal info
                    ct.salesportalinfos.InsertOnSubmit(salesPortalInfo);
                }
                else
                {
                    //update sales portal info
                    spistatus.activitytype = salesPortalInfo.activitytype;
                    spistatus.caseid = salesPortalInfo.caseid;
                    spistatus.redirecturl = salesPortalInfo.redirecturl;
                    spistatus.roletype = salesPortalInfo.roletype;
                    spistatus.salesportalurl = salesPortalInfo.salesportalurl;
                    spistatus.userfirstname = salesPortalInfo.userfirstname;
                    spistatus.userid = salesPortalInfo.userid;
                    spistatus.userlastname = salesPortalInfo.userlastname;
                    spistatus.usertype = salesPortalInfo.usertype;
                    spistatus.casestatus = salesPortalInfo.casestatus;
                    spistatus.country = salesPortalInfo.country;
                    spistatus.saleschannel = salesPortalInfo.saleschannel;
                }

                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = e.Message + " class: ActivityStatusDAO Method: saveSalesPortalInfo";
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                logException(exLog);
            }
        }

        public void logException(exceptionlog exLog)
        {
            try
            {
                dbDataContext db = new dbDataContext();
                db.exceptionlogs.InsertOnSubmit(exLog);
                db.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
        }

        public clonemappingid getCloneMappingForCaseid(string caseid, string newId)
        {
            clonemappingid cloneMapping = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryClone = from act in ct.clonemappingids
                                    where act.clonedfrom == caseid && act.newid == newId
                                    select act;
                foreach (clonemappingid a in queryClone)
                {
                    cloneMapping = a;
                }

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return cloneMapping;
        }

        public void saveClonemapping(clonemappingid clonemapping)
        {
            try
            {
                dbDataContext db = new dbDataContext();
                db.clonemappingids.InsertOnSubmit(clonemapping);
                db.SubmitChanges();
            }
            catch (Exception e)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = e.Message + " class: ActivityStatusDAO Method: saveClonemapping";
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                logException(exLog);
            }
        }

        public void cloneCase(string clonedFrom, string newId)
        {
            SqlConnection conn = DatabaseConnection.Connection.getConnection();

            try
            {
                SqlCommand cmdUpdMaster = new SqlCommand("CloneCase", conn);

                cmdUpdMaster.CommandType = CommandType.StoredProcedure;
                cmdUpdMaster.Parameters.Add(new SqlParameter("@CloneFromID", clonedFrom));
                cmdUpdMaster.Parameters.Add(new SqlParameter("@NewCaseID", newId));
                cmdUpdMaster.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = e.Message + " class: ActivityStatusDAO Method: cloneCase";
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                logException(exLog);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }

    }
}
