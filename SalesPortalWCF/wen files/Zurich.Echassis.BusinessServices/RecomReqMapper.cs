// -----------------------------------------------------------------------
// <copyright file="RecomReqMapper.cs" company="Zurich">
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
    public class RecomReqMapper : Zurich.Echassis.CustomUtilities.ObjectMapper<RecommendationDataContract, RecommendationBO>
    {
        /// <summary>
        /// BusinessToService Method
        /// </summary>
        /// <param name = "recommDataContract">recommDataContract RecommendationDataContract</param>
        /// <returns>Returns RecommendationBO Result</returns>
        public override RecommendationBO BusinessToService(RecommendationDataContract recommDataContract)
        {
            RecommendationBO recomBO = new RecommendationBO();
            try
            {
                recomBO.Action = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum)recommDataContract.Action;
                recomBO.ActivityType = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum)recommDataContract.Activity;
                recomBO.CaseId = recommDataContract.CaseId;
                recomBO.Reasons = recommDataContract.Reasons;
                recomBO.CaseStatus = recommDataContract.CaseStatus;
                recomBO.ClonedFlag = recommDataContract.ClonedFlag;
                recomBO.ClonedFrom = recommDataContract.ClonedFrom;
                recomBO.DistributionChannelId = recommDataContract.DistributionChannelId;
                recomBO.MyNextReviewDate = recommDataContract.MyNextReviewDate;
                recomBO.MyRemarks = recommDataContract.MyRemarks;
                recomBO.OutstandingNeeds = recommDataContract.OutstandingNeeds;
                recomBO.ReasonForRecommendation = recommDataContract.ReasonForRecommendation;
                recomBO.RecomdStatus = recommDataContract.RecomdStatus;
                recomBO.RecomId = recommDataContract.RecomId;
                recomBO.SubDistributionChannelId = recommDataContract.SubDistributionChannelId;
                recomBO.Flag = recommDataContract.Flag;

                ////List<Zurich.Echassis.BL.BusinessObjects.RecommQuestion> questionList = new List<RecommQuestion>();
                ////if (recommDataContract.RecommendationQuestions != null)
                ////{
                ////    foreach (RecommQuestionContract recom in recommDataContract.RecommendationQuestions)
                ////    {
                ////        questionList.Add(new RecommQuestion()
                ////        {
                ////            RecLocationId = recom.RecLocationId,
                ////            RecQuestContent = recom.RecQuestContent,
                ////            RecQuestDispName = recom.RecQuestDispName,
                ////            RecQuestionId = recom.RecQuestionId
                ////        });
                ////    }
                ////}

                ////recomBO.RecommendationQuestions = questionList;

                ////List<Zurich.Echassis.BL.BusinessObjects.RecommAnswers> answerList = new List<RecommAnswers>();
                ////if (recommDataContract.RecommendationAnswers != null)
                ////{
                ////    foreach (RecommAnswersContract recom in recommDataContract.RecommendationAnswers)
                ////    {
                ////        answerList.Add(new RecommAnswers()
                ////        {
                ////            RecAnswerControl = recom.RecAnswerControl,
                ////            RecAnswerId = recom.RecAnswerId,
                ////            RecAnswerOrder = recom.RecAnswerOrder,
                ////            RecAnswerValue = recom.RecAnswerValue,
                ////            RecQuestionId = recom.RecQuestionId
                ////        });
                ////    }
                ////}
                ////recomBO.RecommendationAnswers = answerList;

                List<Zurich.Echassis.BL.BusinessObjects.RecommDataSheet> dataSheetList = new List<RecommDataSheet>();
                if (recommDataContract.RecommDataSheet != null)
                {
                    foreach (RecommDataSheetContract recom in recommDataContract.RecommDataSheet)
                    {
                        dataSheetList.Add(new RecommDataSheet()
                        {
                            RecAnswer = recom.RecAnswer,
                            Recomdid = recom.Recomdid,
                            RecQuestionId = recom.RecQuestionId
                        });
                    }
                }

                recomBO.RecommDataSheets = dataSheetList;
                List<Zurich.Echassis.BL.BusinessObjects.MyRecommendationData> myRecommendationList = new List<MyRecommendationData>();
                if (recommDataContract.MyRecommDataContract != null)
                {
                    foreach (MyRecommendationDataContract recom in recommDataContract.MyRecommDataContract)
                    {
                        myRecommendationList.Add(new MyRecommendationData()
                        {
                            RecRider = recom.RecRider,
                            RecProductType = recom.RecProductType,
                            RecPremium = recom.RecPremium,
                            RecPremiumFreq = recom.RecPremiumFreq,
                            RecSumAssured = recom.RecSumAssured,
                            RecOwnerId = recom.RecOwnerId,
                            RecNeeds = recom.RecNeeds,
                            RecLifeAssured = recom.RecLifeAssured,
                            RecManuallyEntered = recom.RecManuallyEntered,
                            Deleted = recom.Deleted,
                            RecomId = recom.RecomId
                        });
                    }
                }

                recomBO.MyRecommData  = myRecommendationList;

                recomBO.UserInfo = new UserInfoBO()
                {
                    AgentId = recommDataContract.UserInfo.AgentId,
                    AgentStatus = recommDataContract.UserInfo.AgentStatus,
                    PrimaryContact = recommDataContract.UserInfo.PrimaryContact,
                    PrimaryEmailId = recommDataContract.UserInfo.PrimaryEmailId,
                    RoleType = recommDataContract.UserInfo.RoleType,
                    SecondaryEmailId = recommDataContract.UserInfo.SecondaryEmailId,
                    SteroeTypeId = recommDataContract.UserInfo.SteroeTypeId,
                    SupervisorId = recommDataContract.UserInfo.SupervisorId,
                    UserId = recommDataContract.UserInfo.UserId,
                    UserType = recommDataContract.UserInfo.UserType
                };
            }
            catch (Exception ex)
            {
                string s = ex.InnerException.ToString();
            }

            return recomBO;
        }

        /// <summary>
        /// ServiceToBusiness Method
        /// </summary>
        /// <param name = "bisObject">bisObject RecommendationBO</param>
        /// <returns>Returns RecommendationDataContract Result</returns>
        public override RecommendationDataContract ServiceToBusiness(RecommendationBO bisObject)
        {
            throw new NotImplementedException();
        }
    }
}
