using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAO
{
    public class MyZurichAdviserDAO
    {
        public List<myzurichadviser> saveMza(List<myzurichadviser> mzaoptions)
        {
            int status = 1;

            try
            {
                dbDataContext ct = new dbDataContext();
                if (mzaoptions != null && mzaoptions.Count > 0)
                {
                    ct.myzurichadvisers.InsertAllOnSubmit(mzaoptions);
                    ct.SubmitChanges();
                }
            }
            catch (Exception e)
            {
                status = 0;
                string str = e.Message;
            }

            if (status == 0)
            {
                mzaoptions = null;
            }

            return mzaoptions;
        }

        public List<myzurichadviser> updateMza(List<myzurichadviser> mzaoptions, string caseid)
        {

            int status = 1;

            try
            {
                dbDataContext ct = new dbDataContext();

                //delete existing my zurich adviser
                var queryExistingMza = from emza in ct.myzurichadvisers
                                          where emza.caseid == caseid
                                          select emza;
                foreach (myzurichadviser mza in queryExistingMza)
                {
                    ct.myzurichadvisers.DeleteOnSubmit(mza);
                }
                
                if (mzaoptions != null && mzaoptions.Count > 0)
                {
                    ct.myzurichadvisers.InsertAllOnSubmit(mzaoptions);
                }
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                status = 0;
                string str = e.Message;
            }

            if (status == 0)
            {
                mzaoptions = null;
            }
            
            return mzaoptions;
        }

        public List<myzurichadviser> getMza(string caseid)
        {
            List<myzurichadviser> mzaOptions = new List<myzurichadviser>();

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryMza = from mza in ct.myzurichadvisers
                                       where mza.caseid == caseid
                                       select mza;
                foreach (myzurichadviser m in queryMza)
                {
                    mzaOptions.Add(m);
                }

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return mzaOptions;
        }
    }
}
