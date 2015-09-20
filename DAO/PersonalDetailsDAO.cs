using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.Data.SqlClient;



namespace DAO
{
    public class PersonalDetailsDAO
    {
        public personaldetail getPersonalDetail(string caseId)
        {
             dbDataContext ct = new dbDataContext();
             personaldetail detail = null;
                //retrieve existing saving goal 
                var queryPersonalDetails = from al in ct.personaldetails
                                           where al.caseid == caseId
                                                  select al;
                foreach (personaldetail personalDetailObject in queryPersonalDetails)
                {
                    detail = personalDetailObject;
                }
            return detail;
        }

        public personaldetail updatePersonalDetails(personaldetail personalDetail)
        {
            dbDataContext ct = new dbDataContext();
            personaldetail detail = null;
            //retrieve existing saving goal 
            var queryPersonalDetails = from al in ct.personaldetails
                                       where al.caseid == personalDetail.caseid
                                       select al;
            foreach (personaldetail personalDetailObject in queryPersonalDetails)
            {
                detail = personalDetailObject;
            }

            detail.name = personalDetail.name;
            detail.surname = personalDetail.surname;
            detail.address = personalDetail.address;
            detail.companyname = personalDetail.companyname;
            detail.contactnumber = personalDetail.contactnumber;
            detail.contactnumberfax = personalDetail.contactnumberfax;
            detail.contactnumberhp = personalDetail.contactnumberhp;
            detail.contactnumberoffice = personalDetail.contactnumberoffice;
            detail.datepicker = personalDetail.datepicker;
            detail.educationlevel = personalDetail.educationlevel;
            detail.email = personalDetail.email;
            detail.employmentstatus = personalDetail.employmentstatus;
            detail.gender = personalDetail.gender;

            detail.maritalstatus = personalDetail.maritalstatus;
            detail.medicalcondition = personalDetail.medicalcondition;
            detail.medicalconditiondetails = personalDetail.medicalconditiondetails;
            detail.nationality = personalDetail.nationality;
            detail.nationalityothers = personalDetail.nationalityothers;
            detail.nominee = personalDetail.nominee;
            detail.will = personalDetail.will;
            detail.nric = personalDetail.nric;
            detail.occupation = personalDetail.occupation;
            detail.title = personalDetail.title;
            detail.titleothers = personalDetail.titleothers;
            detail.issmoker = personalDetail.issmoker;

            detail.familyDetailsRequired = personalDetail.familyDetailsRequired;
            detail.spokenLanguage = personalDetail.spokenLanguage;
            detail.spokenLanguageOtherstxt = personalDetail.spokenLanguageOtherstxt;
            detail.writtenLanguage = personalDetail.writtenLanguage;
            detail.writtenLanguageOtherstxt = personalDetail.writtenLanguageOtherstxt;
            detail.accompanyQuestion = personalDetail.accompanyQuestion;
            detail.trustedIndividualName = personalDetail.trustedIndividualName;
            detail.clientRelationship = personalDetail.clientRelationship;
            detail.NRICAccompany = personalDetail.NRICAccompany;
            detail.noAccompaniedIndividualReason = personalDetail.noAccompaniedIndividualReason;


            var queryfamilyMembers = from familyMemberDetails in ct.familyMemberDetails
                                       where familyMemberDetails.personalDetailId == detail.id
                                     select familyMemberDetails;
            foreach (familyMemberDetail familyMembers in queryfamilyMembers)
            {
                ct.familyMemberDetails.DeleteOnSubmit(familyMembers);
            }


            if (detail.familyDetailsRequired == "1")
            {
                //update family member details
                if (personalDetail.familyMemberDetails != null && personalDetail.familyMemberDetails.Count > 0)
                {
                    EntitySet<familyMemberDetail> familyMemberDetailSet = new EntitySet<familyMemberDetail>();
                    foreach (familyMemberDetail familyDetail in personalDetail.familyMemberDetails)
                    {
                        familyMemberDetailSet.Add(familyDetail);

                    }
                    detail.familyMemberDetails = familyMemberDetailSet;
                }
            }

            ct.SubmitChanges();
            return detail;

        }

        public int savePersonalDetails(personaldetail personalDetails)
        {
            int noOfRows = 0;

            try
            {
                
                dbDataContext ct = new dbDataContext();
                ct.personaldetails.InsertOnSubmit(personalDetails);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                string str = e.Message;
            }
            
            return noOfRows;
        }
    }
}
