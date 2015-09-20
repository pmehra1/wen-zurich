using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;



namespace DAO
{
    public class PriorityDetailsDAO
    {
        public priorityDetail getPriorityDetails(string caseId)
        {
            
            priorityDetail detail = null;
            try
            {
                dbDataContext ct = new dbDataContext();
                //retrieve existing saving goal 
                var queryPriorityDetails = from al in ct.priorityDetails
                                           where al.caseid == caseId
                                           select al;
                foreach (priorityDetail priorityDetailObject in queryPriorityDetails)
                {
                    detail = priorityDetailObject;
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return detail;

        }
        public void savePriorityDetails(priorityDetail priorityDetails)
        {
            try
            {
                dbDataContext ct = new dbDataContext();
                ct.priorityDetails.InsertOnSubmit(priorityDetails);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            
        }

        public void updatePriorityDetails(priorityDetail priorityDetails)
        {
            try
            {
                dbDataContext ct = new dbDataContext();
                priorityDetail detail = null;
                //retrieve existing saving goal 
                var queryPriorityDetails = from al in ct.priorityDetails
                                           where al.caseid == priorityDetails.caseid
                                           select al;
                foreach (priorityDetail priorityDetailObject in queryPriorityDetails)
                {
                    detail = priorityDetailObject;
                }

                detail.protection1 = priorityDetails.protection1;
                detail.protection2 = priorityDetails.protection2;
                detail.protection3 = priorityDetails.protection3;
                detail.protection4 = priorityDetails.protection4;
                detail.protection5 = priorityDetails.protection5;
                detail.savings1 = priorityDetails.savings1;
                detail.savings2 = priorityDetails.savings2;
                detail.savings3 = priorityDetails.savings3;

                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            

        }

    }
}
