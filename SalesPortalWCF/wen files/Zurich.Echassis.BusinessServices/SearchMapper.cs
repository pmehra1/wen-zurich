using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Zurich.Echassis.BusinessService.Contracts;
using Zurich.Echassis.CustomUtilities;
using Zurich.Echassis.BL.BusinessObjects;

namespace Zurich.Echassis.BusinessServices
{
    public class SearchMapper : Zurich.Echassis.CustomUtilities.ObjectMapper<SearchDataContract, SearchBO>
    {
        /// <summary>
        /// BusinessToService Method
        /// </summary>
        /// <param name = "caseDataContract">CaseDataContract Object</param>
        /// <returns>Result - Response</returns>
        public override SearchBO BusinessToService(SearchDataContract searchDataContract)
        {
            SearchBO searchBO = new SearchBO();
            searchBO.Action = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum)searchDataContract.Action;
            searchBO.ActivityType = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum)searchDataContract.Activity;
            searchBO.CaseId = searchDataContract.CaseId;
            searchBO.Firstname = searchDataContract.Firstname;
            searchBO.Lastname = searchDataContract.Lastname;
            searchBO.Dob = searchDataContract.Dob;
            searchBO.Gender = searchDataContract.Gender;
            searchBO.CaseStatusId = searchDataContract.CaseStatusId;
            searchBO.PartyId = searchDataContract.PartyId;
            searchBO.CaseDescription = searchDataContract.CaseDescription;
            searchBO.Country = searchDataContract.Country;
            searchBO.Nationality = searchDataContract.Nationality;
            searchBO.Occupation = searchDataContract.Occupation;
            searchBO.Language = searchDataContract.Language;
            searchBO.Locale = searchDataContract.Locale;
            searchBO.Currency = searchDataContract.Currency;
            searchBO.DistributionChannelId = searchDataContract.DistributionChannelId;
            searchBO.SubDistributionChannelId = searchDataContract.SubDistributionChannelId;
            searchBO.IDorFINorPassport = searchDataContract.IDorFINorPassport;
            searchBO.CountryofResidence = searchDataContract.CountryofResidence;
            searchBO.ClonedFrom = searchDataContract.ClonedFrom;
            searchBO.AssignedTo = searchDataContract.AssignedTo;
            searchBO.AssignedSource = searchDataContract.AssignedSource;
            searchBO.ClonedFlag = searchDataContract.ClonedFlag;
            searchBO.Deleted = searchDataContract.Deleted;
            searchBO.CreationDate = searchDataContract.CreationDate;
            searchBO.LastModifiedDate = searchDataContract.LastModifiedDate;
            searchBO.CreatedBy = searchDataContract.CreatedBy;
            searchBO.LastModifiedBy = searchDataContract.LastModifiedBy;
            searchBO.Title = searchDataContract.Title;
            searchBO.Smoker = searchDataContract.Smoker;
            searchBO.CaseCreationDateTo = searchDataContract.CaseCreationDateTo;
            searchBO.CaseCreationDateFrom = searchDataContract.CaseCreationDateFrom;
            searchBO.CaseModificationDateTo = searchDataContract.CaseModificationDateTo;
            searchBO.CaseModificationDateFrom = searchDataContract.CaseModificationDateFrom;

            UserInfoBO userInfoBO = new UserInfoBO();
            userInfoBO.UserId = searchDataContract.UserInfo.UserId;
            userInfoBO.RoleType = searchDataContract.UserInfo.RoleType;
            userInfoBO.UserType = searchDataContract.UserInfo.UserType;
            userInfoBO.AgentStatus = searchDataContract.UserInfo.AgentStatus;
            userInfoBO.userfirstname = searchDataContract.UserInfo.userfirstname;
            userInfoBO.userlastname = searchDataContract.UserInfo.userlastname;
            userInfoBO.SteroeTypeId = searchDataContract.UserInfo.SteroeTypeId;
            userInfoBO.AgentId = searchDataContract.UserInfo.AgentId;
            userInfoBO.PrimaryEmailId = searchDataContract.UserInfo.PrimaryEmailId;
            userInfoBO.SecondaryEmailId = searchDataContract.UserInfo.SecondaryEmailId;
            userInfoBO.PrimaryContact = searchDataContract.UserInfo.PrimaryContact;
            userInfoBO.SupervisorId = searchDataContract.UserInfo.SupervisorId;

            searchBO.UserInfo = userInfoBO;
            return searchBO;
        }
        /// <summary>
        /// ServiceToBusiness Method
        /// </summary>
        /// <param name = "value">CaseBO Object</param>
        /// <returns>Result - Response</returns>
        public override SearchDataContract ServiceToBusiness(SearchBO value)
        {
            throw new NotImplementedException();
        }
    }
}