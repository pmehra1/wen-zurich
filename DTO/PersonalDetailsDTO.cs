using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTO
{
    public class PersonalDetailsDTO
    {
        public String titleSelected { get; set; }
        public String titleOthers { get; set; }
        public String name { get; set; }
        public String gender { get; set; }
        public String passportnumber { get; set; }
        public String nationality { get; set; }
        public String nationalityOthers { get; set; }
        public String datepicker { get; set; }
        public String maritalstatus { get; set; }
        public String maritalStatusOthers { get; set; }
        public String residentialAddress { get; set; }
        public String employmentStatus { get; set; }
        public String employmentStatusOthers { get; set; }
        public String occupation { get; set; }
        public String companyName { get; set; }
        public String contactNumber { get; set; }
        public String contactNumberOffice { get; set; }
        public String contactNumberHp { get; set; }
        public String contactNumberFax { get; set; }
        public String emailId { get; set; }
        public String educationalLevel { get; set; }
        public String educationalLevelOthers { get; set; }
        public String medicalCondition { get; set; }
        public String medicalConditionDetails { get; set; }
        public String nominee { get; set; }
        public String isWill { get; set; }
        public String isSmoker { get; set; }
        public List<MemberDTO> familyMembers { get; set; }
    }
}
