using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAO
{
    public class AssumptionDAO
    {
        public assumption getAssumptionById(int assumptionId)
        {
            assumption asmpt = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                var queryAssumption = from assmptn in ct.assumptions
                                      where assmptn.id == assumptionId
                                      select assmptn;

                foreach (assumption a in queryAssumption)
                {
                    asmpt = a;
                }
            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return asmpt;
        }
    }
}
