// --------------------------------------------------------------------------------------------------------------------
// <copyright file="IBusinessService.cs" company="Zurich">
//   TODO: Update copyright text.
// </copyright>
// <summary>
//   Defines the RuleExecutor type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

/// <summary>
/// Zurich.Echassis.BusinessServices
/// </summary>
namespace Zurich.Echassis.BusinessServices
{
    #region Namespace References
     using System;
     using System.Collections.Generic;
     using System.Linq;
     using System.Runtime.Serialization;
     using System.ServiceModel;
     using System.ServiceModel.Web;
     using System.Text;
    using Zurich.Echassis.BusinessService.Contracts;
using Zurich.Echassis.CustomUtilities;
    using System.Data;
    using System.Xml.Linq;
    #endregion

    //// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.

    /// <summary>
    /// Interface IBusinessService
    /// </summary>
    [ServiceContract]
    public interface IBusinessService
    {
        /// <summary>
        /// ManageCase Interface
        /// </summary>
        /// <param name = "caseDataContract">CaseDataContract Object</param>
        /// <returns>Result - Response</returns>
        [OperationContract]
        CaseResponseDataContract ManageCase(
           CaseDataContract caseDataContract);

        /// <summary>
        /// ManageQuote Interface
        /// </summary> 
        /// <param name = "quoteDataContract">QuoteDataContract Object</param>
        /// <returns>Result - Response</returns>
        [OperationContract]
        QuoteResponseDataContract ManageQuote(
            QuoteDataContract quoteDataContract);

        /// <summary>
        /// ManageRecommendation Interface
        /// </summary> 
        /// <param name = "recomDataContract">RecomDataContract Object</param>
        /// <returns>Result - Response</returns>
        [OperationContract]
         RecommendationResponseDataContract ManageRecommendation(
           RecommendationDataContract recomDataContract);

        /// <summary>
        /// ManageZPlan Interface
        /// </summary>
        /// <param name = "zplanDataContract">ZPlanDataContract Object</param>
        /// <returns>Result - Response</returns>
        [OperationContract]
        ZPlanResponseDataContract ManageZPlan(
            ZPlanDataContract zplanDataContract);

        /// <summary>
        /// SearchCase Interface
        /// </summary> 
        /// <param name = "searchDataContract">SearchDataContract Object</param>
        /// <returns>Result - Response</returns>
        [OperationContract]
        DataSet SearchCase(
            XElement searchDataContract);

        /// <summary>
        /// SearchActivities Interface
        /// </summary> 
        /// <param name = "searchActivitiesDataContract">SearchActivitiesDataContract Object</param>
        /// <returns>Result - Response</returns>
        //[OperationContract]
        //SearchActivitiesResponseDataContract RetrieveActivitiesForCase(
        //    SearchActivitiesDataContract searchActivitiesDataContract);

        //[OperationContract]
        //void AuditLog(
        //    string message, string logType);


        [OperationContract]
        void AuditLog(
            ExceptionContract ex);

        [OperationContract]
        string GetActivityLastRecord();

        [OperationContract]
        string ProceedtoEsign(string caseID, string activityID);
        
    }    
}
