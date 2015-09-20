// -----------------------------------------------------------------------
// <copyright file="RecommendationDataContract.cs" company="Zurich">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------
namespace Zurich.Echassis.BusinessService.Contracts
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.ServiceModel;
    using System.Text;

    /// <summary>
    /// RecommendationDataContract Class
    /// </summary>
    [DataContract]
    public class RecommendationDataContract : BaseRequestDataContract
    {
        /// <summary>
        /// Gets or sets RecomId Property
        /// </summary>
        [DataMember]
        public string RecomId { get; set; }

        /// <summary>
        /// Gets or sets RecomdStatus Property
        /// </summary>
        [DataMember]
        public string RecomdStatus { get; set; }

        /// <summary>
        /// Gets or sets Flag Property
        /// </summary>
        [DataMember]
        public string Flag { get; set; }

        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets CaseStatus Property
        /// </summary>
        [DataMember]
        public string CaseStatus { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

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
        /// Gets or sets ReasonForRecommendation Property
        /// </summary>
        [DataMember]
        public string ReasonForRecommendation { get; set; }

        /// <summary>
        /// Gets or sets MyRemarks Property
        /// </summary>
        [DataMember]
        public string MyRemarks { get; set; }

        /// <summary>
        /// Gets or sets MyNextReviewDate Property
        /// </summary>
        [DataMember]
        public DateTime MyNextReviewDate { get; set; }

        /// <summary>
        /// Gets or sets OutstandingNeeds Property
        /// </summary>
        [DataMember]
        public string OutstandingNeeds { get; set; }

        /// <summary>
        /// Gets or sets Reasons Property
        /// </summary>
        [DataMember]
        public string Reasons { get; set; }

        /// <summary>
        /// Gets or sets MyRecommDataContract Property
        /// </summary>
        [DataMember]
        public MyRecommendtionContractList MyRecommDataContract { get; set; }       
        ////[DataMember]
        ////public RecommQuesContractList RecommendationQuestions { get; set; }
        ////[DataMember]
        ////public RecommAnsContractList RecommendationAnswers { get; set; }

        /// <summary>
        /// Gets or sets RecommDataSheet Property
        /// </summary>
        [DataMember]
        public RecommDataSheetContractList RecommDataSheet { get; set; }
        ////[DataMember]
        ////public RecProductNameContractList RecProductName { get; set; }
        ////[DataMember]
        ////public RecProductTypeContractList RecProductType { get; set; }
        ////[DataMember]
        ////public RecNeedsContractList RecNeedsContract { get; set; }
        ////[DataMember]
        ////public RecPremiumFrequencyList RecPremiumFrequency { get; set; }
        ////[DataMember]
        ////public RecOwnerContractList RecOwnerContract { get; set; }
        ////[DataMember]
        ////public RecLifeAssuredContractList RecLifeAssuredContract { get; set; }       
    }

    /// <summary>
    /// MyRecommendationDataContract Class
    /// </summary>
    [DataContract]
    public class MyRecommendationDataContract
    {
        /// <summary>
        /// Gets or sets RecRiderId Property
        /// </summary>
        [DataMember]
        public string RecRiderId { get; set; }

        /// <summary>
        /// Gets or sets RecRider Property
        /// </summary>
        [DataMember]
        public string RecRider { get; set; }

        /// <summary>
        /// Gets or sets RecProductTypeId Property
        /// </summary>
        [DataMember]
        public string RecProductTypeId { get; set; }

        /// <summary>
        /// Gets or sets RecProductType Property
        /// </summary>
        [DataMember]
        public string RecProductType { get; set; }

        /// <summary>
        /// Gets or sets RecPremium Property
        /// </summary>
        [DataMember]
        public string RecPremium { get; set; }

        /// <summary>
        /// Gets or sets RecPremiumFreqId Property
        /// </summary>
        [DataMember]
        public string RecPremiumFreqId { get; set; }

        /// <summary>
        /// Gets or sets RecPremiumFreq Property
        /// </summary>
        [DataMember]
        public string RecPremiumFreq { get; set; }

        /// <summary>
        /// Gets or sets RecSumAssured Property
        /// </summary>
        [DataMember]
        public string RecSumAssured { get; set; }

        /// <summary>
        /// Gets or sets RecOwnerId Property
        /// </summary>
        [DataMember]
        public string RecOwnerId { get; set; }

        /// <summary>
        /// Gets or sets RecNeedsId Property
        /// </summary>
        [DataMember]
        public string RecNeedsId { get; set; }

        /// <summary>
        /// Gets or sets RecNeeds Property
        /// </summary>
        [DataMember]
        public string RecNeeds { get; set; }

        /// <summary>
        /// Gets or sets RecLifeAssuredId Property
        /// </summary>
        [DataMember]
        public string RecLifeAssuredId { get; set; }

        /// <summary>
        /// Gets or sets RecLifeAssured Property
        /// </summary>
        [DataMember]
        public string RecLifeAssured { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether RecManuallyEntered Property
        /// </summary>
        [DataMember]
        public bool RecManuallyEntered { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether Deleted Property
        /// </summary>
        [DataMember]
        public bool Deleted { get; set; }

        /// <summary>
        /// Gets or sets RecomId Property
        /// </summary>
        [DataMember]
        public int RecomId { get; set; }
    }

    /// <summary>
    /// RecommQuestionContract Class
    /// </summary>
    [DataContract]
    public class RecommQuestionContract
    {
        /// <summary>
        /// Gets or sets RecQuestionId Property
        /// </summary>
        [DataMember]
        public string RecQuestionId { get; set; }

        /// <summary>
        /// Gets or sets RecQuestDispName Property
        /// </summary>
        [DataMember]
        public string RecQuestDispName { get; set; }

        /// <summary>
        /// Gets or sets RecQuestContent Property
        /// </summary>
        [DataMember]
        public string RecQuestContent { get; set; }

        /// <summary>
        /// Gets or sets RecLocationId Property
        /// </summary>
        [DataMember]
        public string RecLocationId { get; set; }
    }

    /// <summary>
    /// RecommAnswersContract Class
    /// </summary>
    [DataContract]
    public class RecommAnswersContract
    {
        /// <summary>
        /// Gets or sets RecQuestionId Property
        /// </summary>
        [DataMember]
        public string RecQuestionId { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerId Property
        /// </summary>
        [DataMember]
        public string RecAnswerId { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerControl Property
        /// </summary>
        [DataMember]
        public string RecAnswerControl { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerValue Property
        /// </summary>
        [DataMember]
        public string RecAnswerValue { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerOrder Property
        /// </summary>
        [DataMember]
        public string RecAnswerOrder { get; set; }
    }

    /// <summary>
    /// RecommProductContract Class
    /// </summary>
    [DataContract]
    public class RecommProductContract
    {
        /// <summary>
        /// Gets or sets RecQuestionId Property
        /// </summary>
        [DataMember]
        public string RecQuestionId { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerId Property
        /// </summary>
        [DataMember]
        public string RecAnswerId { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerControl Property
        /// </summary>
        [DataMember]
        public string RecAnswerControl { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerValue Property
        /// </summary>
        [DataMember]
        public string RecAnswerValue { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerOrder Property
        /// </summary>
        [DataMember]
        public string RecAnswerOrder { get; set; }
    }

    /// <summary>
    /// RecommDataSheetContract Class
    /// </summary>
    [DataContract]
    public class RecommDataSheetContract
    {
        /// <summary>
        /// Gets or sets RecQuestionId Property
        /// </summary>
        [DataMember]
        public string RecQuestionId { get; set; }

        /// <summary>
        /// Gets or sets RecAnswer Property
        /// </summary>
        [DataMember]
        public string RecAnswer { get; set; }

        /// <summary>
        /// Gets or sets Recomdid Property
        /// </summary>
        [DataMember]
        public string Recomdid { get; set; }

        /// <summary>
        /// Gets or sets RecAnswerId Property
        /// </summary>
        [DataMember]
        public string RecAnswerId { get; set; }

        /// <summary>
        /// Gets or sets Version Property
        /// </summary>
        [DataMember]
        public string Version { get; set; }

    }

    /// <summary>
    /// RecommendationResponseDataContract Class
    /// </summary>
    [DataContract]
    public class RecommendationResponseDataContract : BaseResponseDataContract
    {
        /// <summary>
        /// Gets or sets RecomId Property
        /// </summary>
        [DataMember]
        public string RecomId { get; set; }

        /// <summary>
        /// Gets or sets RecomdStatus Property
        /// </summary>
        [DataMember]
        public string RecomdStatus { get; set; }

        /// <summary>
        /// Gets or sets Flag Property
        /// </summary>
        [DataMember]
        public string Flag { get; set; }

        /// <summary>
        /// Gets or sets CaseId Property
        /// </summary>
        [DataMember]
        public string CaseId { get; set; }

        /// <summary>
        /// Gets or sets ClonedFrom Property
        /// </summary>
        [DataMember]
        public string ClonedFrom { get; set; }

        /// <summary>
        /// Gets or sets ClonedFlag Property
        /// </summary>
        [DataMember]
        public string ClonedFlag { get; set; }

        /// <summary>
        /// Gets or sets ReasonForRecommendation Property
        /// </summary>
        [DataMember]
        public string ReasonForRecommendation { get; set; }

        /// <summary>
        /// Gets or sets MyRemarks Property
        /// </summary>
        [DataMember]
        public string MyRemarks { get; set; }

        /// <summary>
        /// Gets or sets MyNextReviewDate Property
        /// </summary>
        [DataMember]
        public DateTime MyNextReviewDate { get; set; }

        /// <summary>
        /// Gets or sets OutstandingNeeds Property
        /// </summary>
        [DataMember]
        public string OutstandingNeeds { get; set; }

        /// <summary>
        /// Gets or sets Reasons Property
        /// </summary>
        [DataMember]
        public string Reasons { get; set; }

        /// <summary>
        /// Gets or sets MyRecommDataContract Property
        /// </summary>
        [DataMember]
        public MyRecommendtionContractList MyRecommDataContract { get; set; }

        /// <summary>
        /// Gets or sets RecommendationQuestions Property
        /// </summary>
        [DataMember]
        public RecommQuesContractList RecommendationQuestions { get; set; }

        /// <summary>
        /// Gets or sets RecommendationAnswers Property
        /// </summary>
        [DataMember]
        public RecommAnsContractList RecommendationAnswers { get; set; }

        /// <summary>
        /// Gets or sets RecommDataSheet Property
        /// </summary>
        [DataMember]
        public RecommDataSheetContractList RecommDataSheet { get; set; }

        /// <summary>
        /// Gets or sets RecProductName Property
        /// </summary>
        [DataMember]
        public RecProductNameContractList RecProductName { get; set; }

        /// <summary>
        /// Gets or sets RecProductType Property
        /// </summary>
        [DataMember]
        public RecProductTypeContractList RecProductType { get; set; }

        /// <summary>
        /// Gets or sets RecNeedsContract Property
        /// </summary>
        [DataMember]
        public RecNeedsContractList RecNeedsContract { get; set; }

        /// <summary>
        /// Gets or sets RecPremiumFrequency Property
        /// </summary>
        [DataMember]
        public RecPremiumFrequencyList RecPremiumFrequency { get; set; }

        /// <summary>
        /// Gets or sets RecOwnerContract Property
        /// </summary>
        [DataMember]
        public RecOwnerContractList RecOwnerContract { get; set; }

        /// <summary>
        /// Gets or sets RecLifeAssuredContract Property
        /// </summary>
        [DataMember]
        public RecLifeAssuredContractList RecLifeAssuredContract { get; set; }

        /// <summary>
        /// Gets or sets RecDocument Property
        /// </summary>
        [DataMember]
        public byte[] RecDocument { get; set; }       
    }

    /// <summary>
    /// RecProductNameContract Class
    /// </summary>
    [DataContract]
    public class RecProductNameContract
    {
        /// <summary>
        /// Gets or sets RecRiderId Property
        /// </summary>
        [DataMember]
        public string RecRiderId { get; set; }

        /// <summary>
        /// Gets or sets RecProductRider Property
        /// </summary>
        [DataMember]
        public string RecProductRider { get; set; }
    }

    /// <summary>
    /// RecProductTypeContract Class
    /// </summary>
    [DataContract]
    public class RecProductTypeContract
    {
        /// <summary>
        /// Gets or sets RecProductTypeId Property
        /// </summary>
        [DataMember]
        public string RecProductTypeId { get; set; }

        /// <summary>
        /// Gets or sets RecProductType Property
        /// </summary>
        [DataMember]
        public string RecProductType { get; set; }
    }

    /// <summary>
    /// RecPremiumFrequencyContract Class
    /// </summary>
    [DataContract]
    public class RecPremiumFrequencyContract
    {
        /// <summary>
        /// Gets or sets RecPremiumFreqId Property
        /// </summary>
        [DataMember]
        public string RecPremiumFreqId { get; set; }

        /// <summary>
        /// Gets or sets RecPremiumFrequency Property
        /// </summary>
        [DataMember]
        public string RecPremiumFrequency { get; set; }
    }

    /// <summary>
    /// RecOwnerContract Class
    /// </summary>
    [DataContract]
    public class RecOwnerContract
    {
        /// <summary>
        /// Gets or sets RecOwnerId Property
        /// </summary>
        [DataMember]
        public string RecOwnerId { get; set; }

        /// <summary>
        /// Gets or sets RecOwner Property
        /// </summary>
        [DataMember]
        public string RecOwner { get; set; }
    }

    /// <summary>
    /// RecLifeAssuredContract Class
    /// </summary>
    [DataContract]
    public class RecLifeAssuredContract
    {
        /// <summary>
        /// Gets or sets RecLifeAssuredId Property
        /// </summary>
        [DataMember]
        public string RecLifeAssuredId { get; set; }

        /// <summary>
        /// Gets or sets RecLifeAssured Property
        /// </summary>
        [DataMember]
        public string RecLifeAssured { get; set; }
    }

    /// <summary>
    /// RecNeedsContract Class
    /// </summary>
    [DataContract]
    public class RecNeedsContract
    {
        /// <summary>
        /// Gets or sets RecNeedsId Property
        /// </summary>
        [DataMember]
        public string RecNeedsId { get; set; }

        /// <summary>
        /// Gets or sets RecNeeds Property
        /// </summary>
        [DataMember]
        public string RecNeeds { get; set; }
    }

    /// <summary>
    /// RecommQuesContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecommQuesContractList : List<RecommQuestionContract>
    {
    }

    /// <summary>
    /// RecommAnsContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecommAnsContractList : List<RecommAnswersContract>
    {
    }

    /// <summary>
    /// RecommDataSheetContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecommDataSheetContractList : List<RecommDataSheetContract>
    {
    }

    /// <summary>
    /// RecProductNameContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecProductNameContractList : List<RecProductNameContract>
    {
    }

    /// <summary>
    /// RecProductTypeContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecProductTypeContractList : List<RecProductTypeContract>
    {
    }

    /// <summary>
    /// RecNeedsContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecNeedsContractList : List<RecNeedsContract>
    {
    }

    /// <summary>
    /// RecPremiumFrequencyList Class
    /// </summary>
    [CollectionDataContract]
    public class RecPremiumFrequencyList : List<RecPremiumFrequencyContract>
    {
    }

    /// <summary>
    /// RecOwnerContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecOwnerContractList : List<RecOwnerContract>
    {
    }

    /// <summary>
    /// RecLifeAssuredContractList Class
    /// </summary>
    [CollectionDataContract]
    public class RecLifeAssuredContractList : List<RecLifeAssuredContract>
    {
    }

    /// <summary>
    /// MyRecommendtionContractList Class
    /// </summary>
    [CollectionDataContract]
    public class MyRecommendtionContractList : List<MyRecommendationDataContract>
    {
    }
}