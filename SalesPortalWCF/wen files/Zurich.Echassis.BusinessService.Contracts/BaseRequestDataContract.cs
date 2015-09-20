#region File Header
// --------------------------------------------------------------------------------------------------------------------
// <copyright file="BaseRequestDataContract.cs" company="Zurich">
//   TODO: Update copyright text.
// </copyright>
// <summary>
//   Defines the RuleExecutor type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------
////===============================================================================================
// File Name        : 
// Description      : 
// Version          : 
// Author           : 
// Created On       : 
////===============================================================================================
// Modification History
////===============================================================================================
// Modified By      : 
// Date             : 
// CCF/Incident No  : 
// Reason           : 
////===============================================================================================
#endregion

/// <summary>
/// TODO: Update summary.
/// </summary>
namespace Zurich.Echassis.BusinessService.Contracts
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Runtime;
    using System.Runtime.Serialization;
    using System.ServiceModel;
    using System.Text;

    /// <summary>
    /// BaseRequestDataContract Class
    /// </summary>
    [DataContract]
    public class BaseRequestDataContract
    {
        /// <summary>
        /// Gets or sets Activity Property
        /// </summary>
        [DataMember]
        public ActivityTypeEnum Activity { get; set; }

        /// <summary>
        /// Gets or sets Action Property
        /// </summary>
        [DataMember]
        public ActionEnumContracts Action { get; set; }


        /// <summary>
        /// Gets or sets Action Property
        /// </summary>
        [DataMember]
        public ErrorType ErrorType { get; set; }

        /// <summary>
        /// Gets or sets UserInfo Property
        /// </summary>
        [DataMember]
        public UserInfoEntity UserInfo { get; set; }
    }

    /// <summary>
    /// BaseResponseDataContract Class
    /// </summary>
    [DataContract]
    public class BaseResponseDataContract
    {
        /// <summary>
        /// Gets or sets Status Property
        /// </summary>
        [DataMember]
        public bool Status { get; set; }

        /// <summary>
        /// Gets or sets Message Property
        /// </summary>
        [DataMember]
        public string Message { get; set; }
    }

    /// <summary>
    /// UserInfoEntity Class
    /// </summary>
    [DataContract]
    public class UserInfoEntity
    {
        /// <summary>
        /// Gets or sets UserId Property
        /// </summary>
        [DataMember]
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets RoleType Property
        /// </summary>
        [DataMember]
        public string RoleType { get; set; }

        /// <summary>
        /// Gets or sets UserType Property
        /// </summary>
        [DataMember]
        public string UserType { get; set; }

        /// <summary>
        /// Gets or sets AgentStatus Property
        /// </summary>
        [DataMember]
        public string AgentStatus { get; set; }

        /// <summary>
        /// Gets or sets userfirstname Property
        /// </summary>
        [DataMember]
        public string userfirstname { get; set; }

        /// <summary>
        /// Gets or sets userlastname Property
        /// </summary>
        [DataMember]
        public string userlastname { get; set; }

        /// <summary>
        /// Gets or sets SteroeTypeId Property
        /// </summary>
        [DataMember]
        public string SteroeTypeId { get; set; }

        /// <summary>
        /// Gets or sets AgentId Property
        /// </summary>
        [DataMember]
        public string AgentId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryEmailId Property
        /// </summary>
        [DataMember]
        public string PrimaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets SecondaryEmailId Property
        /// </summary>
        [DataMember]
        public string SecondaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryContact Property
        /// </summary>
        [DataMember]
        public string PrimaryContact { get; set; }

        /// <summary>
        /// Gets or sets SupervisorId Property
        /// </summary>
        [DataMember]
        public string SupervisorId { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }
    }

    /// <summary>
    /// FamilyDetailsList Class
    /// </summary>
    [CollectionDataContract]
    public class FamilyDetailsList : List<FamilyDetails>
    {
    }

    /// <summary>
    /// FundCollectionList Class
    /// </summary>
    [CollectionDataContract]
    public class FundCollectionList : List<FundsCollection>
    {
    }

    /// <summary>
    /// ZPlanDataContract Class
    /// </summary>
    [DataContract]
    public class ZPlanDataContract : BaseRequestDataContract
    {

        /// <summary>
        /// Gets or sets ZPlan Satus
        /// </summary>
        [DataMember]
        public string ZPlanStatus { get; set; }

        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets UserId Property
        /// </summary>
        [DataMember]
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets ActivityId Property
        /// </summary>
        [DataMember]
        public string ActivityId { get; set; }

        /// <summary>
        /// Gets or sets ActivityType Property
        /// </summary>
        [DataMember]
        public string ActivityType { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Name Property
        /// </summary>
        [DataMember]
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        public string Dob { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public bool Smoker { get; set; }

        /// <summary>
        /// Gets or sets FamilyDetails Property
        /// </summary>
        [DataMember]
        public FamilyDetailsList FamilyDetails { get; set; }

        /// <summary>
        /// Gets or sets ByteArray Property
        /// </summary>
        [DataMember]
        public byte[] ByteArray { get; set; }

        /// <summary>
        /// Gets or sets RedirectUrl Property
        /// </summary>
        [DataMember]
        public string RedirectUrl { get; set; }

        /// <summary>
        /// Gets or sets SalesPortalUrl Property
        /// </summary>
        [DataMember]
        public string SalesPortalUrl { get; set; }

        /// <summary>
        /// Gets or sets UserFirstName Property
        /// </summary>
        [DataMember]
        public string UserFirstName { get; set; }

        /// <summary>
        /// Gets or sets UserLastName Property
        /// </summary>
        [DataMember]
        public string UserLastName { get; set; }

        /// <summary>
        /// Gets or sets RoleType Property
        /// </summary>
        [DataMember]
        public string RoleType { get; set; }

        /// <summary>
        /// Gets or sets UserType Property
        /// </summary>
        [DataMember]
        public string UserType { get; set; }

        /// <summary>
        /// Gets or sets CaseStatus Property
        /// </summary>
        [DataMember]
        public string CaseStatus { get; set; }

        /// <summary>
        /// Gets or sets NricOrPassport Property
        /// </summary>
        [DataMember]
        public string NricOrPassport { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets MaritalStatus Property
        /// </summary>
        [DataMember]
        public string MaritalStatus { get; set; }

        /// <summary>
        /// Gets or sets FundsCollection Property
        /// </summary>
        [DataMember]
        public FundCollectionList FundsCollection { get; set; }
    }

    /// <summary>
    /// ZPlanResponseDataContract Class
    /// </summary>
    [DataContract]
    public class ZPlanResponseDataContract : BaseResponseDataContract
    {

        /// <summary>
        /// Gets or sets ZPlan Satus
        /// </summary>
        [DataMember]
        public string ZPlanStatus { get; set; }

        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets UserId Property
        /// </summary>
        [DataMember]
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets ActivityId Property
        /// </summary>
        [DataMember]
        public string ActivityId { get; set; }

        /// <summary>
        /// Gets or sets ActivityType Property
        /// </summary>
        [DataMember]
        public string ActivityType { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Name Property
        /// </summary>
        [DataMember]
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        public string Dob { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public bool Smoker { get; set; }

        ////[DataMember]
        ////public  FamilyDetails FamilyDetails { get; set; }

        ////[DataMember]
        ////public List<FamilyDetails> FamilyDetails { get; set; }

        /// <summary>
        /// Gets or sets ByteArray Property
        /// </summary>
        [DataMember]
        public byte[] ByteArray { get; set; }

        /// <summary>
        /// Gets or sets RedirectUrl Property
        /// </summary>
        [DataMember]
        public string RedirectUrl { get; set; }

        /// <summary>
        /// Gets or sets SalesPortalUrl Property
        /// </summary>
        [DataMember]
        public string SalesPortalUrl { get; set; }

        /// <summary>
        /// Gets or sets UserFirstName Property
        /// </summary>
        [DataMember]
        public string UserFirstName { get; set; }

        /// <summary>
        /// Gets or sets UserLastName Property
        /// </summary>
        [DataMember]
        public string UserLastName { get; set; }

        /// <summary>
        /// Gets or sets RoleType Property
        /// </summary>
        [DataMember]
        public string RoleType { get; set; }

        /// <summary>
        /// Gets or sets UserType Property
        /// </summary>
        [DataMember]
        public string UserType { get; set; }

        /// <summary>
        /// Gets or sets CaseStatus Property
        /// </summary>
        [DataMember]
        public string CaseStatus { get; set; }

        /// <summary>
        /// Gets or sets NricOrPassport Property
        /// </summary>
        [DataMember]
        public string NricOrPassport { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets MaritalStatus Property
        /// </summary>
        [DataMember]
        public string MaritalStatus { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }

        ////[DataMember]
        ////public FundsCollection FundsCollection { get; set; }
        ////public List<FundsCollection> FundsCollection { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

    }

    /// <summary>
    /// FamilyDetails Class
    /// </summary>
    [DataContract]
    public class FamilyDetails
    {
        ////public FamilyDetails(string familyMember, string memberName, string memberRelation, string dob)
        ////{
        ////    this.FamilyMember = familyMember;
        ////    this.MemberName = memberName;
        ////    this.MemberRelation = memberRelation;
        ////    this.Dob = dob;
        ////}

        /// <summary>
        /// Gets or sets FamilyMember Property
        /// </summary>
        [DataMember]
        public int FamilyMember { get; set; }

        /// <summary>
        /// Gets or sets MemberName Property
        /// </summary>
        [DataMember]
        public string MemberName { get; set; }

        /// <summary>
        /// Gets or sets MemberRelation Property
        /// </summary>
        [DataMember]
        public string MemberRelation { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        public string Dob { get; set; }
    }

    /// <summary>
    /// FundsCollection Class
    /// </summary>
    [DataContract]
    public class FundsCollection
    {
        ////public FundsCollection(string premiumFrequency, string premiumAmount, string fund, string fundAllocationPercentage, string fundAllocationAmount)
        ////{
        ////    this.PremiumFrequency = premiumFrequency;
        ////    this.PremiumAmount = premiumAmount;
        ////    this.Fund = fund;
        ////    this.FundAllocationPercentage = fundAllocationPercentage;
        ////    this.FundAllocationAmount = fundAllocationAmount;
        ////}

        /// <summary>
        /// Gets or sets PremiumFrequency Property
        /// </summary>
        [DataMember]
        public string PremiumFrequency { get; set; }

        /// <summary>
        /// Gets or sets PremiumAmount Property
        /// </summary>
        [DataMember]
        public string PremiumAmount { get; set; }

        /// <summary>
        /// Gets or sets Fund Property
        /// </summary>
        [DataMember]
        public string Fund { get; set; }

        /// <summary>
        /// Gets or sets FundAllocationPercentage Property
        /// </summary>
        [DataMember]
        public string FundAllocationPercentage { get; set; }

        /// <summary>
        /// Gets or sets FundAllocationAmount Property
        /// </summary>
        [DataMember]
        public string FundAllocationAmount { get; set; }
    }

  
    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class CaseDataContract : BaseRequestDataContract
    {
        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets Firstname Property
        /// </summary>
        [DataMember]
        public string Firstname { get; set; }

        /// <summary>
        /// Gets or sets Lastname Property
        /// </summary>
        [DataMember]
        public string Lastname { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> Dob { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets CaseStatusId Property
        /// </summary>
        [DataMember]
        public string CaseStatusId { get; set; }

        /// <summary>
        /// Gets or sets PartyId Property
        /// </summary>
        [DataMember]
        public string PartyId { get; set; }

        /// <summary>
        /// Gets or sets CaseDescription Property
        /// </summary>
        [DataMember]
        public string CaseDescription { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }

        /// <summary>
        /// Gets or sets CountryOfResidence Property
        /// </summary>
        [DataMember]
        public string CountryOfResidence { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets Language Property
        /// </summary>
        [DataMember]
        public string Language { get; set; }

        /// <summary>
        /// Gets or sets Locale Property
        /// </summary>
        [DataMember]
        public string Locale { get; set; }

        /// <summary>
        /// Gets or sets Currency Property
        /// </summary>
        [DataMember]
        public string Currency { get; set; }

        /// <summary>
        /// Gets or sets DistributionChannelId Property
        /// </summary>
        [DataMember]
        public string DistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets SubDistributionChannelId Property
        /// </summary>
        [DataMember]
        public string SubDistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets IDorFINorPassport Property
        /// </summary>
        [DataMember]
        public string IDorFINorPassport { get; set; }

        /// <summary>
        /// Gets or sets CountryofResidence Property
        /// </summary>
        [DataMember]
        public string CountryofResidence { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets AssignedTo Property
        /// </summary>
        [DataMember]
        public string AssignedTo { get; set; }

        /// <summary>
        /// Gets or sets AssignedSource Property
        /// </summary>
        [DataMember]
        public string AssignedSource { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public string Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public string Smoker { get; set; }
    }

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class CaseResponseDataContract : BaseResponseDataContract
    {
        /// <summary>
        /// Gets or sets EnableZplan Property
        /// </summary>
        [DataMember]
        public string EnableZplan { get; set; }

        /// <summary>
        /// Gets or sets EnableRecommendation Property
        /// </summary>
        [DataMember]
        public string EnableRecommendation { get; set; }

        /// <summary>
        /// Gets or sets EnableQuote Property
        /// </summary>
        [DataMember]
        public string EnableQuote { get; set; }

        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets Firstname Property
        /// </summary>
        [DataMember]
        public string Firstname { get; set; }

        /// <summary>
        /// Gets or sets Lastname Property
        /// </summary>
        [DataMember]
        public string Lastname { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> Dob { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets CaseStatusId Property
        /// </summary>
        [DataMember]
        public string CaseStatusId { get; set; }

        /// <summary>
        /// Gets or sets PartyId Property
        /// </summary>
        [DataMember]
        public string PartyId { get; set; }

        /// <summary>
        /// Gets or sets CaseDescription Property
        /// </summary>
        [DataMember]
        public string CaseDescription { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }

        /// <summary>
        /// Gets or sets CountryOfResidence Property
        /// </summary>
        [DataMember]
        public string CountryOfResidence { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets Language Property
        /// </summary>
        [DataMember]
        public string Language { get; set; }

        /// <summary>
        /// Gets or sets Locale Property
        /// </summary>
        [DataMember]
        public string Locale { get; set; }

        /// <summary>
        /// Gets or sets Currency Property
        /// </summary>
        [DataMember]
        public string Currency { get; set; }

        /// <summary>
        /// Gets or sets DistributionChannelId Property
        /// </summary>
        [DataMember]
        public string DistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets SubDistributionChannelId Property
        /// </summary>
        [DataMember]
        public string SubDistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets IDorFINorPassport Property
        /// </summary>
        [DataMember]
        public string IDorFINorPassport { get; set; }

        /// <summary>
        /// Gets or sets CountryofResidence Property
        /// </summary>
        [DataMember]
        public string CountryofResidence { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets AssignedTo Property
        /// </summary>
        [DataMember]
        public string AssignedTo { get; set; }

        /// <summary>
        /// Gets or sets AssignedSource Property
        /// </summary>
        [DataMember]
        public string AssignedSource { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public string Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public string Smoker { get; set; }

        /// <summary>
        /// Gets or sets Data Property
        /// </summary>
        [DataMember]
        public DataSet Data { get; set; }

        /// <summary>
        /// Gets or sets Count Property
        /// </summary>
        [DataMember]
        public int Count { get; set; }
    }

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class RecomDataContract : BaseRequestDataContract
    {
        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public int CaseId { get; set; }

        /// <summary>
        /// Gets or sets Action Property
        /// </summary>
        [DataMember]
        public string Action { get; set; }

        /// <summary>
        /// Gets or sets UserId Property
        /// </summary>
        [DataMember]
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets RoleType Property
        /// </summary>
        [DataMember]
        public string RoleType { get; set; }

        /// <summary>
        /// Gets or sets UserType Property
        /// </summary>
        [DataMember]
        public string UserType { get; set; }

        /// <summary>
        /// Gets or sets AgentStatus Property
        /// </summary>
        [DataMember]
        public string AgentStatus { get; set; }

        /// <summary>
        /// Gets or sets FirstName Property
        /// </summary>
        [DataMember]
        public string FirstName { get; set; }

        /// <summary>
        /// Gets or sets LastName Property
        /// </summary>
        [DataMember]
        public string LastName { get; set; }

        /// <summary>
        /// Gets or sets StereoTypeId Property
        /// </summary>
        [DataMember]
        public string StereoTypeId { get; set; }

        /// <summary>
        /// Gets or sets AgentId Property
        /// </summary>
        [DataMember]
        public string AgentId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryEmailId Property
        /// </summary>
        [DataMember]
        public int PrimaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets SecondaryEmailId Property
        /// </summary>
        [DataMember]
        public string SecondaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryContact Property
        /// </summary>
        [DataMember]
        public string PrimaryContact { get; set; }

        /// <summary>
        /// Gets or sets SupervisorId Property
        /// </summary>
        [DataMember]
        public string SupervisorId { get; set; }

        /// <summary>
        /// Gets or sets RecommendationStatus Property
        /// </summary>
        [DataMember]
        public string RecommendationStatus { get; set; }

        /// <summary>
        /// Gets or sets ProductOrRiderName Property
        /// </summary>
        [DataMember]
        public string ProductOrRiderName { get; set; }

        /// <summary>
        /// Gets or sets ProductType Property
        /// </summary>
        [DataMember]
        public string ProductType { get; set; }

        /// <summary>
        /// Gets or sets Premium Property
        /// </summary>
        [DataMember]
        public string Premium { get; set; }

        /// <summary>
        /// Gets or sets PremiumFrequency Property
        /// </summary>
        [DataMember]
        public string PremiumFrequency { get; set; }

        /// <summary>
        /// Gets or sets SumAssured Property
        /// </summary>
        [DataMember]
        public string SumAssured { get; set; }

        /// <summary>
        /// Gets or sets LifeAssured Property
        /// </summary>
        [DataMember]
        public string LifeAssured { get; set; }

        /// <summary>
        /// Gets or sets AdvisorName Property
        /// </summary>
        [DataMember]
        public string AdvisorName { get; set; }

        /// <summary>
        /// Gets or sets AdvisorMASNumber Property
        /// </summary>
        [DataMember]
        public string AdvisorMASNumber { get; set; }

        /// <summary>
        /// Gets or sets SupervisorName Property
        /// </summary>
        [DataMember]
        public string SupervisorName { get; set; }

        /// <summary>
        /// Gets or sets SupervisorMASNumber Property
        /// </summary>
        [DataMember]
        public string SupervisorMASNumber { get; set; }

        /// <summary>
        /// Gets or sets ProductDisclosureCollection Property
        /// </summary>
        [DataMember]
        public string ProductDisclosureCollection { get; set; }

        /// <summary>
        /// Gets or sets DisclosureOptionCollection Property
        /// </summary>
        [DataMember]
        public string DisclosureOptionCollection { get; set; }

        /// <summary>
        /// Gets or sets QuoteStatus Property
        /// </summary>
        [DataMember]
        public string QuoteStatus { get; set; }

        /// <summary>
        /// Gets or sets CaseStatus Property
        /// </summary>
        [DataMember]
        public string CaseStatus { get; set; }

        /// <summary>
        /// Gets or sets ZPlanStatus Property
        /// </summary>
        [DataMember]
        public string ZPlanStatus { get; set; }

        /// <summary>
        /// Gets or sets Owner Property
        /// </summary>
        [DataMember]
        public string Owner { get; set; }

        /// <summary>
        /// Gets or sets Reasons Property
        /// </summary>
        [DataMember]
        public string Reasons { get; set; }

        /// <summary>
        /// Gets or sets Needs Property
        /// </summary>
        [DataMember]
        public string Needs { get; set; }

        /// <summary>
        /// Gets or sets RecManuallyEntered Property
        /// </summary>
        [DataMember]
        public bool RecManuallyEntered { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public bool Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }
    }

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class RecomResponseDataContract : BaseResponseDataContract
    {
        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public int CaseId { get; set; }

        /// <summary>
        /// Gets or sets Action Property
        /// </summary>
        [DataMember]
        public string Action { get; set; }

        /// <summary>
        /// Gets or sets UserId Property
        /// </summary>
        [DataMember]
        public string UserId { get; set; }

        /// <summary>
        /// Gets or sets RoleType Property
        /// </summary>
        [DataMember]
        public string RoleType { get; set; }

        /// <summary>
        /// Gets or sets UserType Property
        /// </summary>
        [DataMember]
        public string UserType { get; set; }

        /// <summary>
        /// Gets or sets AgentStatus Property
        /// </summary>
        [DataMember]
        public string AgentStatus { get; set; }

        /// <summary>
        /// Gets or sets FirstName Property
        /// </summary>
        [DataMember]
        public string FirstName { get; set; }

        /// <summary>
        /// Gets or sets LastName Property
        /// </summary>
        [DataMember]
        public string LastName { get; set; }

        /// <summary>
        /// Gets or sets StereoTypeId Property
        /// </summary>
        [DataMember]
        public string StereoTypeId { get; set; }

        /// <summary>
        /// Gets or sets AgentId Property
        /// </summary>
        [DataMember]
        public string AgentId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryEmailId Property
        /// </summary>
        [DataMember]
        public int PrimaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets SecondaryEmailId Property
        /// </summary>
        [DataMember]
        public string SecondaryEmailId { get; set; }

        /// <summary>
        /// Gets or sets PrimaryContact Property
        /// </summary>
        [DataMember]
        public string PrimaryContact { get; set; }

        /// <summary>
        /// Gets or sets SupervisorId Property
        /// </summary>
        [DataMember]
        public string SupervisorId { get; set; }

        /// <summary>
        /// Gets or sets RecommendationStatus Property
        /// </summary>
        [DataMember]
        public string RecommendationStatus { get; set; }

        /// <summary>
        /// Gets or sets ProductOrRiderName Property
        /// </summary>
        [DataMember]
        public string ProductOrRiderName { get; set; }

        /// <summary>
        /// Gets or sets ProductType Property
        /// </summary>
        [DataMember]
        public string ProductType { get; set; }

        /// <summary>
        /// Gets or sets Premium Property
        /// </summary>
        [DataMember]
        public string Premium { get; set; }

        /// <summary>
        /// Gets or sets PremiumFrequency Property
        /// </summary>
        [DataMember]
        public string PremiumFrequency { get; set; }

        /// <summary>
        /// Gets or sets SumAssured Property
        /// </summary>
        [DataMember]
        public string SumAssured { get; set; }

        /// <summary>
        /// Gets or sets LifeAssured Property
        /// </summary>
        [DataMember]
        public string LifeAssured { get; set; }

        /// <summary>
        /// Gets or sets AdvisorName Property
        /// </summary>
        [DataMember]
        public string AdvisorName { get; set; }

        /// <summary>
        /// Gets or sets AdvisorMASNumber Property
        /// </summary>
        [DataMember]
        public string AdvisorMASNumber { get; set; }

        /// <summary>
        /// Gets or sets SupervisorName Property
        /// </summary>
        [DataMember]
        public string SupervisorName { get; set; }

        /// <summary>
        /// Gets or sets SupervisorMASNumber Property
        /// </summary>
        [DataMember]
        public string SupervisorMASNumber { get; set; }

        /// <summary>
        /// Gets or sets ProductDisclosureCollection Property
        /// </summary>
        [DataMember]
        public string ProductDisclosureCollection { get; set; }

        /// <summary>
        /// Gets or sets DisclosureOptionCollection Property
        /// </summary>
        [DataMember]
        public string DisclosureOptionCollection { get; set; }

        /// <summary>
        /// Gets or sets QuoteStatus Property
        /// </summary>
        [DataMember]
        public string QuoteStatus { get; set; }

        /// <summary>
        /// Gets or sets CaseStatus Property
        /// </summary>
        [DataMember]
        public string CaseStatus { get; set; }

        /// <summary>
        /// Gets or sets ZPlanStatus Property
        /// </summary>
        [DataMember]
        public string ZPlanStatus { get; set; }

        /// <summary>
        /// Gets or sets Owner Property
        /// </summary>
        [DataMember]
        public string Owner { get; set; }

        /// <summary>
        /// Gets or sets Reasons Property
        /// </summary>
        [DataMember]
        public string Reasons { get; set; }

        /// <summary>
        /// Gets or sets Needs Property
        /// </summary>
        [DataMember]
        public string Needs { get; set; }

        /// <summary>
        /// Gets or sets RecManuallyEntered Property
        /// </summary>
        [DataMember]
        public bool RecManuallyEntered { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public bool Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }
    }

    /// <summary>
    /// SearchDataContract Class
    /// </summary>
    [DataContract]
    public class SearchDataContract : BaseRequestDataContract
    {
        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets Firstname Property
        /// </summary>
        [DataMember]
        public string Firstname { get; set; }

        /// <summary>
        /// Gets or sets Lastname Property
        /// </summary>
        [DataMember]
        public string Lastname { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> Dob { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets CaseStatusId Property
        /// </summary>
        [DataMember]
        public string CaseStatusId { get; set; }

        /// <summary>
        /// Gets or sets PartyId Property
        /// </summary>
        [DataMember]
        public string PartyId { get; set; }

        /// <summary>
        /// Gets or sets CaseDescription Property
        /// </summary>
        [DataMember]
        public string CaseDescription { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets Language Property
        /// </summary>
        [DataMember]
        public string Language { get; set; }

        /// <summary>
        /// Gets or sets Locale Property
        /// </summary>
        [DataMember]
        public string Locale { get; set; }

        /// <summary>
        /// Gets or sets Currency Property
        /// </summary>
        [DataMember]
        public string Currency { get; set; }

        /// <summary>
        /// Gets or sets DistributionChannelId Property
        /// </summary>
        [DataMember]
        public string DistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets SubDistributionChannelId Property
        /// </summary>
        [DataMember]
        public string SubDistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets IDorFINorPassport Property
        /// </summary>
        [DataMember]
        public string IDorFINorPassport { get; set; }

        /// <summary>
        /// Gets or sets CountryofResidence Property
        /// </summary>
        [DataMember]
        public string CountryofResidence { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets AssignedTo Property
        /// </summary>
        [DataMember]
        public string AssignedTo { get; set; }

        /// <summary>
        /// Gets or sets AssignedSource Property
        /// </summary>
        [DataMember]
        public string AssignedSource { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public string Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public string Smoker { get; set; }

        /// <summary>
        /// Gets or sets CaseCreationDateFrom Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CaseCreationDateFrom { get; set; }

        /// <summary>
        /// Gets or sets CaseCreationDateTo Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CaseCreationDateTo { get; set; }

        /// <summary>
        /// Gets or sets CaseModificationDateFrom Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CaseModificationDateFrom { get; set; }

        /// <summary>
        /// Gets or sets CaseModificationDateTo Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CaseModificationDateTo { get; set; }
    }

    /// <summary>
    /// SearchResponseDataContract Class
    /// </summary>
    [DataContract]
    public class SearchResponseDataContract : BaseResponseDataContract
    {
        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets Firstname Property
        /// </summary>
        [DataMember]
        public string Firstname { get; set; }

        /// <summary>
        /// Gets or sets Lastname Property
        /// </summary>
        [DataMember]
        public string Lastname { get; set; }

        /// <summary>
        /// Gets or sets Dob Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> Dob { get; set; }

        /// <summary>
        /// Gets or sets Gender Property
        /// </summary>
        [DataMember]
        public string Gender { get; set; }

        /// <summary>
        /// Gets or sets CaseStatusId Property
        /// </summary>
        [DataMember]
        public string CaseStatusId { get; set; }

        /// <summary>
        /// Gets or sets PartyId Property
        /// </summary>
        [DataMember]
        public string PartyId { get; set; }

        /// <summary>
        /// Gets or sets CaseDescription Property
        /// </summary>
        [DataMember]
        public string CaseDescription { get; set; }

        /// <summary>
        /// Gets or sets Country Property
        /// </summary>
        [DataMember]
        public string Country { get; set; }

        /// <summary>
        /// Gets or sets CountryOfResidence Property
        /// </summary>
        [DataMember]
        public string CountryOfResidence { get; set; }

        /// <summary>
        /// Gets or sets Nationality Property
        /// </summary>
        [DataMember]
        public string Nationality { get; set; }

        /// <summary>
        /// Gets or sets Occupation Property
        /// </summary>
        [DataMember]
        public string Occupation { get; set; }

        /// <summary>
        /// Gets or sets Language Property
        /// </summary>
        [DataMember]
        public string Language { get; set; }

        /// <summary>
        /// Gets or sets Locale Property
        /// </summary>
        [DataMember]
        public string Locale { get; set; }

        /// <summary>
        /// Gets or sets Currency Property
        /// </summary>
        [DataMember]
        public string Currency { get; set; }

        /// <summary>
        /// Gets or sets DistributionChannelId Property
        /// </summary>
        [DataMember]
        public string DistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets SubDistributionChannelId Property
        /// </summary>
        [DataMember]
        public string SubDistributionChannelId { get; set; }

        /// <summary>
        /// Gets or sets IDorFINorPassport Property
        /// </summary>
        [DataMember]
        public string IDorFINorPassport { get; set; }

        /// <summary>
        /// Gets or sets CountryofResidence Property
        /// </summary>
        [DataMember]
        public string CountryofResidence { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets AssignedTo Property
        /// </summary>
        [DataMember]
        public string AssignedTo { get; set; }

        /// <summary>
        /// Gets or sets AssignedSource Property
        /// </summary>
        [DataMember]
        public string AssignedSource { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

        /// <summary>
        /// Gets or sets Deleted Property
        /// </summary>
        [DataMember]
        public string Deleted { get; set; }

        /// <summary>
        /// Gets or sets CreationDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> CreationDate { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedDate Property
        /// </summary>
        [DataMember]
        [System.ComponentModel.DefaultValue(null)]
        public Nullable<DateTime> LastModifiedDate { get; set; }

        /// <summary>
        /// Gets or sets CreatedBy Property
        /// </summary>
        [DataMember]
        public string CreatedBy { get; set; }

        /// <summary>
        /// Gets or sets LastModifiedBy Property
        /// </summary>
        [DataMember]
        public string LastModifiedBy { get; set; }

        /// <summary>
        /// Gets or sets Title Property
        /// </summary>
        [DataMember]
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets Smoker Property
        /// </summary>
        [DataMember]
        public string Smoker { get; set; }

        /// <summary>
        /// Gets or sets Data Property
        /// </summary>
        [DataMember]
        public DataSet Data { get; set; }

        /// <summary>
        /// Gets or sets Count Property
        /// </summary>
        [DataMember]
        public int Count { get; set; }
    }

    /// <summary>
    /// SearchActivitiesDataContract Class
    /// </summary>
    [DataContract]
    public class SearchActivitiesDataContract : BaseRequestDataContract
    {
    }

    /// <summary>
    /// ActionEnumContracts Enum
    /// </summary>
    [DataContract]
    public class SearchActivitiesResponseDataContract : BaseResponseDataContract
    {
    }

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public enum ActionEnumContracts
    {
        /// <summary>
        /// Assign Enum
        /// </summary>
        [EnumMember]
        Unknown = 0,

        /// <summary>
        /// Assign Enum
        /// </summary>
        [EnumMember]
        Assign = 1,

        /// <summary>
        /// Clone Enum
        /// </summary>
        [EnumMember]
        Clone = 2,

        /// <summary>
        /// Complete Enum
        /// </summary>
        [EnumMember]
        Complete = 3,

        /// <summary>
        /// Case Enum
        /// </summary>
        [EnumMember]
        Create = 4,

        /// <summary>
        /// Delete Enum
        /// </summary>
        [EnumMember]
        Delete = 5,

        /// <summary>
        /// GeneratePDF Enum
        /// </summary>
        [EnumMember]
        GeneratePDF = 6,

        /// <summary>
        /// Modify Enum
        /// </summary>
        [EnumMember]
        Modify = 7,

        /// <summary>
        /// Save Enum
        /// </summary>
        [EnumMember]
        Save = 8,

        /// <summary>
        /// PrintDoc Enum
        /// </summary>
        [EnumMember]
        PrintDoc = 9,

        /// <summary>
        /// PrintDoc1 Enum
        /// </summary>
        [EnumMember]
        PrintDoc1 = 10,

        /// <summary>
        /// Restore Enum
        /// </summary>
        [EnumMember]
        Restore = 11,

        /// <summary>
        /// SaveDoc Enum
        /// </summary>
        [EnumMember]
        SaveDoc = 12,

        /// <summary>
        /// List Enum
        /// </summary>
        [EnumMember]
        List = 13,

        /// <summary>
        /// View Enum
        /// </summary>
        [EnumMember]
        View = 14,

        /// <summary>
        /// SelectCase Enum
        /// </summary>
        [EnumMember]
        SelectCase = 15,

        /// <summary>
        /// UpdateCase Enum
        /// </summary>
        [EnumMember]
        UpdateCase = 16,

        /// <summary>
        /// GetQuoteLastRecord Enum
        /// </summary>
        [EnumMember]
        GetQuoteLastRecord = 17,

        /// <summary>
        /// ViewContent Enum
        /// </summary>
        [EnumMember]
        ViewContent = 18,

        /// <summary>
        /// ApprovalListCase Enum
        /// </summary>
        [EnumMember]
        ApprovalListCase = 19,

        /// <summary>
        /// SaveRemarks Enum
        /// </summary>
        [EnumMember]
        SaveRemarks = 20,

        /// <summary>
        /// Sign Enum
        /// </summary>
        [EnumMember]
        Sign = 21,

        /// <summary>
        /// Search
        /// </summary>
        [EnumMember]
        Search = 22,

        /// <summary>
        /// MyApprovalListCase
        /// </summary>
        [EnumMember]
        MyApprovalListCase = 23,

        /// <summary>
        /// SupervisorApproval
        /// </summary>
        [EnumMember]
        SupervisorApproval = 24


    }

    /// <summary>
    /// ActivityTypeEnum Enum
    /// </summary>
    [DataContract]
    public enum ActivityTypeEnum
    {
        /// <summary>
        /// Case Enum
        /// </summary>
        [EnumMember]
        Case,

        /// <summary>
        /// Quote Enum
        /// </summary>
        [EnumMember]
        Quote,

        /// <summary>
        /// Recommendation Enum
        /// </summary>
        [EnumMember]
        Recommendation,

        /// <summary>
        /// Zplan Enum
        /// </summary>
        [EnumMember]
        ZPlan,

        /// <summary>
        /// Party Enum
        /// </summary>
        [EnumMember]
        Party
    }


    /// <summary>
    /// BaseRequestDataContract Class
    /// </summary>
    [DataContract]
    public class CommonDataContract
    {
        /// <summary>
        /// Gets or sets ModuleName Property
        /// </summary>
        [DataMember]
        public string ModuleName { get; set; }
    }




    /// <summary>

    /// ExceptionDataContract Class

    /// </summary>

    [DataContract]
    [Serializable]
    public class ExceptionContract 
    {

        /// <summary>
        /// Gets or sets Exception Message Property
        /// </summary>
        [DataMember]
        public string Message { get; set; }

        /// <summary>
        /// Gets or sets Stack Trace Property
        /// </summary>
        [DataMember]
        public string[] strStackTrace { get; set; }

        /// <summary>
        /// Gets or sets Data Property
        /// </summary>
        [DataMember]
        public string strData { get; set; }

        /// <summary>
        /// Gets or sets Source Property
        /// </summary>
        [DataMember]
        public string[] strSource { get; set; }

        /// <summary>
        /// Gets or sets UserID Property
        /// </summary>
        [DataMember]
        public string strUserId { get; set; }

        /// <summary>
        /// Gets or sets Role Property
        /// </summary>
        [DataMember]
        public string strRole { get; set; }

        /// <summary>
        /// Gets or sets AgentId Property
        /// </summary>
        [DataMember]
        public string strAgentId { get; set; }

        /// <summary>
        /// Gets or sets Activity Property
        /// </summary>
        [DataMember]
        public string strActivity { get; set; }

        /// <summary>
        /// Gets or sets AgentId Property
        /// </summary>
        [DataMember]
        public string strAction { get; set; }

        /// <summary>
        /// Gets or sets ErrorType Property
        /// </summary>
        [DataMember]
        public ErrorType strErrorType { get; set; }

        /// <summary>
        /// Gets or sets ErrorCode Property
        /// </summary>
        [DataMember]
        public string strErrorCode { get; set; }

        /// <summary>
        /// Gets orsets ResultCode Property
        /// </summary>
        [DataMember]
        public string strResultCode { get; set; }


    }
    [DataContract]
    public enum ErrorType
    {
        /// <summary>
        /// DEBUG
        /// </summary>
        [EnumMember]
        DEBUG,
        /// <summary>
        /// INFO
        /// </summary>
        [EnumMember]
        INFO,
        /// <summary>
        /// WARN
        /// </summary>
        [EnumMember]
        WARN,
        /// <summary>
        /// ERROR
        /// </summary>
        [EnumMember]
        ERROR,
        /// <summary>
        /// FATAL
        /// </summary>
        [EnumMember]
        FATAL
    }

}
