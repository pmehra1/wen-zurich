// -----------------------------------------------------------------------
// <copyright file="CaseMapper.cs" company="Zurich">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace Zurich.Echassis.BusinessServices
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Zurich.Echassis.BL.BusinessObjects;
    using Zurich.Echassis.BusinessService.Contracts;
    using Zurich.Echassis.CustomUtilities;

    /// <summary>
    /// CaseMapper Class
    /// </summary>
    public class CaseMapper : Zurich.Echassis.CustomUtilities.ObjectMapper<CaseDataContract, CaseBO>
    {
        /// <summary>
        /// BusinessToService Method
        /// </summary>
        /// <param name = "caseDataContract">CaseDataContract Object</param>
        /// <returns>Result - Response</returns>
        public override CaseBO BusinessToService(CaseDataContract caseDataContract)
        {
            CaseBO caseBO = new CaseBO();

            caseBO.CaseId = caseDataContract.CaseId;
            caseBO.Firstname = caseDataContract.Firstname;
            caseBO.Lastname = caseDataContract.Lastname;

            caseBO.Dob = caseDataContract.Dob;
            caseBO.Gender = caseDataContract.Gender;
            caseBO.CaseStatusId = caseDataContract.CaseStatusId;
            caseBO.PartyId = caseDataContract.PartyId;
            caseBO.CaseDescription = caseDataContract.CaseDescription;
            caseBO.Country = caseDataContract.Country;
            caseBO.Language = caseDataContract.Language;
            caseBO.Locale = caseDataContract.Locale;
            caseBO.Currency = caseDataContract.Currency;
            caseBO.DistributionChannelId = caseDataContract.DistributionChannelId;
            caseBO.SubDistributionChannelId = caseDataContract.SubDistributionChannelId;
            caseBO.IDorFINorPassport = caseDataContract.IDorFINorPassport;
            caseBO.Occupation = caseDataContract.Occupation;
            caseBO.Nationality = caseDataContract.Nationality;
            caseBO.CountryOfResidence = caseDataContract.CountryofResidence;
            caseBO.ClonedFrom = caseDataContract.ClonedFrom;
            caseBO.Deleted = caseDataContract.Deleted;
            caseBO.CreationDate = caseDataContract.CreationDate;
            caseBO.CreatedBy = caseDataContract.CreatedBy;
            caseBO.LastModifiedDate = caseDataContract.LastModifiedDate;
            caseBO.LastModifiedBy = caseDataContract.LastModifiedBy;
            caseBO.Smoker = caseDataContract.Smoker;

            caseBO.Action = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum)caseDataContract.Action;
            caseBO.ActivityType = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum)caseDataContract.Activity;

            UserInfoBO userInfoBO = new UserInfoBO();
            userInfoBO.UserId = caseDataContract.UserInfo.UserId;
            userInfoBO.RoleType = caseDataContract.UserInfo.RoleType;
            userInfoBO.UserType = caseDataContract.UserInfo.UserType;
            userInfoBO.AgentStatus = caseDataContract.UserInfo.AgentStatus;
            userInfoBO.userfirstname = caseDataContract.UserInfo.userfirstname;
            userInfoBO.userlastname = caseDataContract.UserInfo.userlastname;
            userInfoBO.SteroeTypeId = caseDataContract.UserInfo.SteroeTypeId;
            userInfoBO.AgentId = caseDataContract.UserInfo.AgentId;
            userInfoBO.PrimaryEmailId = caseDataContract.UserInfo.PrimaryEmailId;
            userInfoBO.SecondaryEmailId = caseDataContract.UserInfo.SecondaryEmailId;
            userInfoBO.PrimaryContact = caseDataContract.UserInfo.PrimaryContact;
            userInfoBO.SupervisorId = caseDataContract.UserInfo.SupervisorId;

            caseBO.UserInfo = userInfoBO;

            return caseBO;
        }

        /// <summary>
        /// ServiceToBusiness Method
        /// </summary>
        /// <param name = "value">CaseBO Object</param>
        /// <returns>Result - Response</returns>
        public override CaseDataContract ServiceToBusiness(CaseBO value)
        {
            throw new NotImplementedException();
        }
    }
}
