// -----------------------------------------------------------------------
// <copyright file="ZplanMapper.cs" company="Zurich">
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
    /// ZplanMapper Class
    /// </summary>
    public class ZplanMapper : Zurich.Echassis.CustomUtilities.ObjectMapper<ZPlanDataContract, ZPlanBO>
    {
        /// <summary>
        /// BusinessToService Method
        /// </summary>
        /// <param name="zplanDataContract">zplanDataContract ZPlanDataContract</param>
        /// <returns>Returns ZPlanBO Result</returns>
        public override ZPlanBO BusinessToService(ZPlanDataContract zplanDataContract)
        {
            try
            {
                ZPlanBO zplanBO = new ZPlanBO();
                zplanBO.CaseId = zplanDataContract.CaseId;
                zplanBO.ActivityId = zplanDataContract.ActivityId;
                zplanBO.ActivityType = zplanDataContract.Activity.ToString();
                zplanBO.Title = zplanDataContract.Title;
                zplanBO.Name = zplanDataContract.Name;
                zplanBO.Gender = zplanDataContract.Gender;
                zplanBO.DOB = zplanDataContract.Dob;
                zplanBO.Smoker = zplanDataContract.Smoker;
                zplanBO.Bytearray = zplanDataContract.ByteArray;
                zplanBO.UserId = zplanDataContract.UserId;
                zplanBO.UserType = zplanDataContract.UserType;
                zplanBO.RoleType = zplanDataContract.RoleType;
                zplanBO.UserFirstName = zplanDataContract.UserFirstName;
                zplanBO.UserLastName = zplanDataContract.UserLastName;
                zplanBO.SalesPoartalURL = zplanDataContract.SalesPortalUrl;
                zplanBO.RedirectURL = zplanDataContract.RedirectUrl;
                zplanBO.CaseStatus = zplanDataContract.CaseStatus;
                zplanBO.NRIC = zplanDataContract.NricOrPassport;
                zplanBO.Nationality = zplanDataContract.Nationality;
                zplanBO.Occupation = zplanDataContract.Occupation;
                zplanBO.MartialStatus = zplanDataContract.MaritalStatus;
                zplanBO.Action = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum)zplanDataContract.Action;
                zplanBO.ZPlanStatus = zplanDataContract.ZPlanStatus;
                
                if (zplanDataContract.FamilyDetails != null)
                {
                    int familyCount = zplanDataContract.FamilyDetails.Count;
                    List<FamilyDetailsEntity> familyDetailsCollection = new List<FamilyDetailsEntity>();
                    for (int i = 0; i < familyCount; i++)
                    {
                        FamilyDetailsEntity familyDetails = new FamilyDetailsEntity();
                        familyDetails.FamilyMember = zplanDataContract.FamilyDetails[i].FamilyMember;
                        familyDetails.MemberName = zplanDataContract.FamilyDetails[i].MemberName;
                        familyDetails.MemberRelation = zplanDataContract.FamilyDetails[i].MemberRelation;
                        familyDetails.DOB = zplanDataContract.FamilyDetails[i].Dob;
                        familyDetailsCollection.Add(familyDetails);
                    }

                    zplanBO.FamilyDetails = familyDetailsCollection;
                }

                if (zplanDataContract.FundsCollection != null)
                {
                    int fundCount = zplanDataContract.FundsCollection.Count;
                    List<Zurich.Echassis.BL.BusinessObjects.FundsCollection> fundsCollection = new List<Zurich.Echassis.BL.BusinessObjects.FundsCollection>();
                    for (int i = 0; i < fundCount; i++)
                    {
                        BL.BusinessObjects.FundsCollection fundCollection = new BL.BusinessObjects.FundsCollection();
                        fundCollection.Fund = zplanDataContract.FundsCollection[i].Fund;
                        fundCollection.FundAllocationAmount = zplanDataContract.FundsCollection[i].FundAllocationAmount;
                        fundCollection.FundAllocationPercentage = zplanDataContract.FundsCollection[i].FundAllocationPercentage;
                        fundCollection.PremiumAmount = zplanDataContract.FundsCollection[i].PremiumAmount;
                        fundCollection.PremiumFrequency = zplanDataContract.FundsCollection[i].PremiumFrequency;
                        fundsCollection.Add(fundCollection);
                     }

                    zplanBO.FundCollection = fundsCollection;
                }

                return zplanBO;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// ServiceToBusiness Method
        /// </summary>
        /// <param name="value">value ZPlanBO</param>
        /// <returns>Returns ZPlanDataContract Result</returns>
        public override ZPlanDataContract ServiceToBusiness(ZPlanBO value)
        {
            throw new NotImplementedException();
        }
    }

    /// <summary>
    /// ZplanMapperResponse Class
    /// </summary>
    public class ZplanMapperResponse : Zurich.Echassis.CustomUtilities.ObjectMapper<ZPlanResponseDataContract, ZPlanBO>
    {
        /// <summary>
        /// ServiceToBusiness Method
        /// </summary>
        /// <param name="value">alue ZPlanBO</param>
        /// <returns>Returns ZPlanResponseDataContract Result</returns>
        public override ZPlanResponseDataContract ServiceToBusiness(ZPlanBO value)
        {
            try
            {
                ZPlanResponseDataContract zplanDataContract = new ZPlanResponseDataContract();
                zplanDataContract.ActivityId = value.ActivityId;
                zplanDataContract.CaseId = value.CaseId;
                zplanDataContract.ActivityType = value.ActivityType;
                zplanDataContract.Title = value.Title;
                zplanDataContract.Name = value.Name;
                zplanDataContract.Gender = value.Gender;
                zplanDataContract.Dob = value.DOB;
                zplanDataContract.Smoker = value.Smoker;
                zplanDataContract.UserId = value.UserId;
                zplanDataContract.UserFirstName = value.UserFirstName;
                zplanDataContract.UserLastName = value.UserLastName;
                zplanDataContract.UserType = value.UserType;
                zplanDataContract.RoleType = value.RoleType;
                zplanDataContract.CaseStatus = value.CaseStatus;
                zplanDataContract.NricOrPassport = value.NRIC;
                zplanDataContract.Nationality = value.Nationality;
                zplanDataContract.Occupation = value.Occupation;
                zplanDataContract.MaritalStatus = value.MartialStatus;
                zplanDataContract.Message = value.Message;
                zplanDataContract.Status = value.Status;
                zplanDataContract.Message = value.Message;
                return zplanDataContract;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// BusinessToService Method
        /// </summary>
        /// <param name="zplanResponseDataContract">zplanResponseDataContract ZPlanResponseDataContract</param>
        /// <returns>Returns ZPlanBO Result</returns>
        public override ZPlanBO BusinessToService(ZPlanResponseDataContract zplanResponseDataContract)
        {
            throw new NotImplementedException();
        }
    }
}