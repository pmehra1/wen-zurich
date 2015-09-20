using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;
using DAO.DTO;

namespace DAO
{
    public class CkaDao
    {

        public CkaAssessment getCkaProfile(string caseId)
        {
            CkaAssessment result = null;

            try
            {
                dbDataContext dbDataContext = new dbDataContext();
                IQueryable<CkaAssessment> queryable =
                    from a in dbDataContext.GetTable<CkaAssessment>()
                    where a.caseId.Equals(caseId)
                    select a;
                using (IEnumerator<CkaAssessment> enumerator = queryable.GetEnumerator())
                {
                    if (enumerator.MoveNext())
                    {
                        CkaAssessment current = enumerator.Current;
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

        public void updateCkaDetails(CkaAssessment ckaAssessment)
        {
            CkaAssessment assessment = null;
            try
            {
                dbDataContext ct = new dbDataContext();
                var queryCkaDetails = from al in ct.CkaAssessments
                                           where al.caseId == ckaAssessment.caseId
                                           select al;
                foreach (CkaAssessment ckAssessment in queryCkaDetails)
                {
                    assessment = ckAssessment;
                }

                assessment.agreeCKA = ckaAssessment.agreeCKA;
                assessment.csaOutcomeOption1 = ckaAssessment.csaOutcomeOption1;
                assessment.csaOutcomeOption2 = ckaAssessment.csaOutcomeOption2;
                assessment.disagreeCKA = ckaAssessment.disagreeCKA;
                assessment.educationalExperienceOption1 = ckaAssessment.educationalExperienceOption1;
                assessment.educationalExperienceOption2 = ckaAssessment.educationalExperienceOption2;
                assessment.financeRelatedKnowledgeOption1 = ckaAssessment.financeRelatedKnowledgeOption1;
                assessment.financeRelatedKnowledgeOption2 = ckaAssessment.financeRelatedKnowledgeOption2;
                assessment.investmentExperienceOption1 = ckaAssessment.investmentExperienceOption1;
                assessment.investmentExperienceOption2 = ckaAssessment.investmentExperienceOption2;
                assessment.workingExperienceOption1 = ckaAssessment.workingExperienceOption1;
                assessment.workingExperienceOption2 = ckaAssessment.workingExperienceOption2;
                assessment.educationalExperienceList = ckaAssessment.educationalExperienceList;
                assessment.investmentExperienceList = ckaAssessment.investmentExperienceList;
                assessment.workingExperienceList = ckaAssessment.workingExperienceList;
                
                ct.SubmitChanges();

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

        }

        public void saveNewCkaProfile(CkaAssessment ckaAssessment)
        {
            try
            {
                dbDataContext ct = new dbDataContext();
                ct.CkaAssessments.InsertOnSubmit(ckaAssessment);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
        }
    }
}
