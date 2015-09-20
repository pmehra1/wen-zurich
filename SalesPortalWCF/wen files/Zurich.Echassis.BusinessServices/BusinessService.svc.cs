// --------------------------------------------------------------------------------------------------------------------
// <copyright file="BusinessService.svc.cs" company="Zurich">
//   TODO: Update copyright text.
// </copyright>
// <summary>
//   Defines the Business Service
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
    using System.Data;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.ServiceModel;
    using System.ServiceModel.Activation;
    using System.ServiceModel.Web;
    using System.Text;
    using System.Xml.Linq;
    using Zurich.Echassis.BL;
    using Zurich.Echassis.BL.BusinessObjects;
    using Zurich.Echassis.BusinessService.Contracts;
    using Zurich.Echassis.CustomUtilities;
    #endregion

    /// <summary>
    /// BusinessService which handles the Calls from PL
    /// </summary>   
    //// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.

    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class BusinessService : IBusinessService
    {
        /// <summary>
        /// ManageCase Method
        /// </summary>
        /// <param name = "caseDataContract">CaseDataContract Object</param>
        /// <returns>Result - Response</returns>
        public CaseResponseDataContract ManageCase(
            CaseDataContract caseDataContract)
        {
            try
            {
                //// DataContract Object should be mapped to Business Object
                CaseMapper caseMapper = new CaseMapper();
                CaseBO objcaseBO = new CaseBO();

                objcaseBO = caseMapper.BusinessToService(caseDataContract);

                //// Business Logic Layer is Called
                CommonBL objCommonBL = new CommonBL();
                CaseResponseDataContract objResponse = new CaseResponseDataContract();
                objResponse = objCommonBL.ManageCase(objcaseBO);
                if (objResponse != null)
                {
                    objResponse.Dob = DateTime.MinValue;
                    objResponse.CreationDate = DateTime.MinValue;
                    objResponse.LastModifiedDate = DateTime.MinValue;                  
                    //Logging.WriteLog("BusinessService:ManageCase. WCF Success Response:" + objResponse.Data.Tables[0].Rows.Count.ToString(), LogType.INFO);
                }
                return objResponse;
            }
            //catch (FaultException<FaultContractExceptionTest> fx)
            //{
            //    fx.Detail.ErrorMessage = "Internal Server Error " + fx.Reason.ToString();
            //    Logging.WriteLog("BusinessService:ManageCase. Exception:" + fx.Reason.ToString(), LogType.ERROR);
                
            //}
            catch (Exception ex)
            {
                Logging.WriteLog("BusinessService:ManageCase. Exception:" + ex.InnerException.ToString(), LogType.ERROR);
                throw new FaultException<FaultContractExceptionTest>
                     (new FaultContractExceptionTest(ex.InnerException.ToString()));
            }
        }

        /// <summary>
        /// ManageQuote Method
        /// </summary>
        /// <param name = "quoteDataContract">QuoteDataContract Object</param>
        /// <returns> Result </returns>
        public QuoteResponseDataContract ManageQuote(
            QuoteDataContract quoteDataContract)
        {
            /// DataContract Object should be mapped to Business Object
            QuoteMapper quoteMapper = new QuoteMapper();
            QuoteBO objquoteBO = new QuoteBO();

            objquoteBO = quoteMapper.BusinessToService(quoteDataContract);
            CommonBL objCommonBL = new CommonBL();
            QuoteResponseDataContract objResponse = objCommonBL.ManageQuote(objquoteBO);
            return objResponse;
        }

        /// <summary>
        /// ManageRecommendation Method
        /// </summary>
        /// <param name = "recomDataContract">RecomDataContract Object</param>
        /// <returns>Result - Response</returns>
        public RecommendationResponseDataContract ManageRecommendation(
         RecommendationDataContract recomDataContract)
        {
            RecomReqMapper recommMapper = new RecomReqMapper();
            RecommendationBO businessObj = new RecommendationBO();

            businessObj = recommMapper.BusinessToService(recomDataContract);

            CommonBL objCommonBL = new CommonBL();
            RecommendationResponseDataContract objResponse = objCommonBL.ManageRecommendation(businessObj);
            return objResponse;
        }

        /// <summary>
        /// ManageZPlan Method
        /// </summary>
        /// <param name = "zplanDataContract">ZPlanDataContract Object</param>
        /// <returns>Result - Response</returns>
        public ZPlanResponseDataContract ManageZPlan(
            ZPlanDataContract zplanDataContract)
        {
            try
            {
                ZplanMapper zplanMapper = new ZplanMapper();
                ZPlanBO zplanBO = new ZPlanBO();
                zplanBO = zplanMapper.BusinessToService(zplanDataContract);
                //// Business Logic Layer is Called
                /*CommonBL objCommonBL = new CommonBL();
                zplanBO = (ZPlanBO)objCommonBL.ManageZPlan(zplanBO);
                ZplanMapperResponse zplanMapperResponse = new ZplanMapperResponse();
                ZPlanResponseDataContract zplanDataResponse = zplanMapperResponse.ServiceToBusiness(zplanBO);*/
                ZPlanResponseDataContract zplanDataResponse = new ZPlanResponseDataContract();
                zplanDataResponse.ActivityId = "1500";
                zplanDataResponse.NricOrPassport = "S1234567A";
                zplanDataResponse.Occupation = "Professional";
                zplanDataResponse.CaseId = "C1";
                zplanDataResponse.RedirectUrl = "redirecturl";
                zplanDataResponse.RoleType = "roletype";
                zplanDataResponse.SalesPortalUrl = "salesportalurl";
                zplanDataResponse.UserFirstName = "username";
                zplanDataResponse.UserId = "userid";
                zplanDataResponse.UserLastName = "userlastname";
                zplanDataResponse.UserType = "usertype";
                zplanDataResponse.ZPlanStatus = "zplan";
                return zplanDataResponse;
            }
            catch (Exception ex)
            {
                Logging.WriteLog("BusinessService:ManageCase. Exception:" + ex.ToString(), LogType.ERROR);
                throw new FaultException<FaultContractExceptionTest>
                    (new FaultContractExceptionTest(ex.InnerException.ToString()));
            }
        }

        /// <summary>
        /// SearchCase Method
        /// </summary>
        /// <param name = "searchDataContract">SearchDataContract Object</param>
        /// <returns>Result - Response</returns>
        public DataSet SearchCase(
            XElement searchElement)
        {
            try
            {
                //// DataContract Object should be mapped to Business Object
                //SearchMapper searchMapper = new SearchMapper();
                //SearchBO objsearchBO = new SearchBO();

                //objsearchBO = searchMapper.BusinessToService(searchDataContract);

                ////// Business Logic Layer is Called
                CommonBL objCommonBL = new CommonBL();
                DataSet objResponse = objCommonBL.SearchCase(searchElement);

                return objResponse;
            }
            catch (Exception ex)
            {
                Logging.WriteLog("BusinessService:SearchCase. Exception:" + ex.ToString(), LogType.ERROR);
                throw new FaultException<FaultContractExceptionTest>
                    (new FaultContractExceptionTest(ex.InnerException.ToString()));
            }
        }

        /// <summary>
        /// SearchActivities Interface
        /// </summary> 
        /// <param name = "searchActivitiesDataContract">SearchActivitiesDataContract Object</param>
        /// <returns>Result - Response</returns>
        public SearchActivitiesResponseDataContract RetrieveActivitiesForCase(
            SearchActivitiesDataContract searchActivitiesDataContract)
        {
            try
            {
                //// DataContract Object should be mapped to Business Object
                //CaseMapper caseMapper = new CaseMapper();
                //CaseBO objcaseBO = new CaseBO();

                //objcaseBO = caseMapper.BusinessToService(searchActivitiesDataContract);

                //// Business Logic Layer is Called
                CommonBL objCommonBL = new CommonBL();
                SearchActivitiesResponseDataContract objResponse = null;// objCommonBL.ManageCase(searchActivitiesDataContract);
                return objResponse;
            }
            catch (Exception ex)
            {
                Logging.WriteLog("BusinessService:RetrieveActivitiesForCase. Exception:" + ex.ToString(), LogType.ERROR);
                throw;
            }
        }

        /// <summary>
        /// SearchActivities Interface
        /// </summary> 
        public string GetActivityLastRecord()
        {
            string lastRecord = string.Empty;
            CommonBL commonBL = new CommonBL();
            lastRecord = commonBL.GetActivityLastRecord();
            return lastRecord;
        }

        //public void AuditLog(string message, string logType)
        //{

        //    LogType type;
        //    switch (logType)
        //    {
        //        case "Error":
        //            type = LogType.ERROR;
        //            break;
        //        default:
        //            type = LogType.INFO;
        //            break;
        //    }
        //    Logging.WriteLog(message, type);
        //}
        public void AuditLog(ExceptionContract cnt)
        {
           // Zurich.Echassis.CustomUtilities.Logging custUtil = new Zurich.Echassis.CustomUtilities.Logging();

            //CustomUtilities custUtil = new CustomUtilities();
            //custUtil.AuditLog(cnt);

            //Logging.WriteLog("BusinessService:RetrieveActivitiesForCase. Exception:", LogType.ERROR);
            Logging.WriteLog(cnt);
            
            //Logging.WriteLog("BusinessService:RetrieveActivitiesForCase. Exception:" , LogType.ERROR);


        }

        public string ProceedtoEsign(string caseID, string activityID)
        {
            CommonBL commonBL = new CommonBL();
            string status = commonBL.Create(caseID);
            return status;
        }

        [DataContractAttribute]
        public class FaultContractExceptionTest
        {
            private string Msg;
            public FaultContractExceptionTest(string msg)
            {
                this.Msg = msg;
            }

            [DataMember]
            public string ErrorMessage
            {
                get { return this.Msg; }
                set { this.Msg = value; }
            }
        }
    }
}
