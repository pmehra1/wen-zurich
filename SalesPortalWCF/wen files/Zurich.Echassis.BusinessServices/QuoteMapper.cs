// -----------------------------------------------------------------------
// <copyright file="QuoteMapper.cs" company="Zurich">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------
namespace Zurich.Echassis.BusinessServices
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Zurich.Echassis.BusinessService.Contracts;
    using Zurich.Echassis.BL.BusinessObjects;

    public class QuoteMapper : Zurich.Echassis.CustomUtilities.ObjectMapper<QuoteDataContract, QuoteBO>
    {
        public override QuoteBO BusinessToService(QuoteDataContract value)
        {
            QuoteBO quoteBO = new QuoteBO();
            try
            {
                #region Quote Basic Data Mapping

               
                quoteBO.QuoteId = value.QuoteId;
                quoteBO.UserID = value.UserID;
                quoteBO.LastModifiedBy = value.UserID;
                quoteBO.LastModifiedDate = DateTime.Now;
                quoteBO.Date = DateTime.Now;
                quoteBO.QuoteDate = DateTime.Now;
                quoteBO.ModuleName = value.ModuleName;

                quoteBO.CaseId = value.CaseId;
                quoteBO.ClonedFlag = value.ClonedFlag;
                quoteBO.CloneQuoteId = value.CloneQuoteId;
                quoteBO.Deleted = value.Deleted;
                quoteBO.DocumentName = value.DocumentName;
                quoteBO.DocumentType = value.DocumentType;
                quoteBO.IllustrationDoc = value.IllustrationDoc;
                quoteBO.QuoteDescription = value.QuoteDescription;
                quoteBO.QuoteStatus = value.QuoteStatus;
                quoteBO.CreatedBy = value.UserID;
                quoteBO.ActivityAssociationId = value.QuoteId;
                quoteBO.ActivityId = value.QuoteId;
                quoteBO.DocumentId = "QT" + value.QuoteId;

                #endregion Quote Basic Data Mapping

                #region UserInfo
                if (value.UserInfo != null)
                {
                    Zurich.Echassis.BL.BusinessObjects.UserInfoBO userInfoBO = new UserInfoBO();
                    userInfoBO.AgentId = value.UserInfo.AgentId;
                    userInfoBO.AgentStatus = value.UserInfo.AgentStatus;
                    userInfoBO.PrimaryContact = value.UserInfo.PrimaryContact;
                    userInfoBO.PrimaryEmailId = value.UserInfo.PrimaryEmailId;
                    userInfoBO.RoleType = value.UserInfo.RoleType;
                    userInfoBO.SecondaryEmailId = value.UserInfo.SecondaryEmailId;
                    userInfoBO.SteroeTypeId = value.UserInfo.SteroeTypeId;
                    userInfoBO.SupervisorId = value.UserInfo.SupervisorId;
                    userInfoBO.userfirstname = value.UserInfo.userfirstname;
                    userInfoBO.UserId = value.UserInfo.UserId;
                    userInfoBO.userlastname = value.UserInfo.userlastname; ;
                    userInfoBO.UserType = value.UserInfo.UserType;
                    quoteBO.UserInfo = userInfoBO;
                }
                #endregion UserInfo

                #region Activity Type
                Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum actEnum = Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum.Assign;
                if (Enum.IsDefined(typeof(Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum), value.Action.ToString()))
                {
                    actEnum = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum)Enum.Parse(typeof(Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActionEnum), value.Action.ToString(), true);
                }

                Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum actType = Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum.Quote;
                if (Enum.IsDefined(typeof(Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum), value.Activity.ToString()))
                {
                    actType = (Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum)Enum.Parse(typeof(Zurich.Echassis.BL.BusinessObjects.EnumsBO.ActivityTypeEnum), value.Activity.ToString(), true);
                }

                quoteBO.Action = actEnum;
                quoteBO.ActivityType = actType;

                #endregion Activity Type

                #region metadata

                if (value.QuoteMetaData != null)
                {
                    Zurich.Echassis.BL.Quote.VPMS.NewBusiness metadataBO = new Zurich.Echassis.BL.Quote.VPMS.NewBusiness();

                    if (value.QuoteMetaData.applicant != null)
                    {
                        Zurich.Echassis.BL.Quote.VPMS.Person personBO = new BL.Quote.VPMS.Person();

                        if (value.QuoteMetaData.applicant.countryOfResidence != null)
                        {
                            Zurich.Echassis.BL.Quote.VPMS.Person.Country countryInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Country.SG;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.QuoteMetaData.applicant.countryOfResidence.ToString()))
                            {
                                countryInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Country)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.QuoteMetaData.applicant.countryOfResidence.ToString(), true);
                            }
                            personBO.countryOfResidence = countryInfo;
                        }
                        //personBO.countryOfResidence = (Zurich.Echassis.BL.Quote.VPMS.Person.Country)value.QuoteMetaData.applicant.countryOfResidence;
                        personBO.dateOfBirth = value.QuoteMetaData.applicant.dateOfBirth;
                        personBO.firstName = value.QuoteMetaData.applicant.firstName;

                        if (value.QuoteMetaData.applicant.gender != null)
                        {
                            Zurich.Echassis.BL.Quote.VPMS.Person.Gender genderInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Gender.Male;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.QuoteMetaData.applicant.gender.ToString()))
                            {
                                genderInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Gender)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.QuoteMetaData.applicant.gender.ToString(), true);
                            }
                            personBO.gender = genderInfo;
                        }

                        if (value.QuoteMetaData.applicant.nationality != null)
                        {
                            //personBO.gender = (Zurich.Echassis.BL.Quote.VPMS.Person.Gender)value.QuoteMetaData.applicant.gender;
                            Zurich.Echassis.BL.Quote.VPMS.Person.Nationality nationalityInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Nationality.SG;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.QuoteMetaData.applicant.nationality.ToString()))
                            {
                                nationalityInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Nationality)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.QuoteMetaData.applicant.nationality.ToString(), true);
                            }
                            personBO.nationality = nationalityInfo;
                        }
                        //personBO.nationality = (Zurich.Echassis.BL.Quote.VPMS.Person.Nationality)value.QuoteMetaData.applicant.nationality;

                        if (value.QuoteMetaData.applicant.occupation != null)
                        {
                            Zurich.Echassis.BL.Quote.VPMS.Person.Occupation occupationInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Occupation.Accountant;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.QuoteMetaData.applicant.occupation.ToString()))
                            {
                                occupationInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Occupation)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.QuoteMetaData.applicant.occupation.ToString(), true);
                            }
                            personBO.occupation = occupationInfo;
                        }

                        //personBO.occupation = (Zurich.Echassis.BL.Quote.VPMS.Person.Occupation)value.QuoteMetaData.applicant.occupation;
                        personBO.secondName = value.QuoteMetaData.applicant.secondName;
                        personBO.smoker = value.QuoteMetaData.applicant.smoker;
                        personBO.title = value.QuoteMetaData.applicant.title;
                        metadataBO.applicant = personBO;
                    }

                    metadataBO.caseId = value.QuoteMetaData.caseId;
                    metadataBO.id = value.QuoteMetaData.id;
                    metadataBO.premium = value.QuoteMetaData.premium;
                    metadataBO.startDate = value.QuoteMetaData.startDate;

                    Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus newBusinessInfo = Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus.IncompleteQuote;
                    if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus), value.QuoteMetaData.status.ToString()))
                    {
                        newBusinessInfo = (Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus), value.QuoteMetaData.status.ToString(), true);
                    }
                    metadataBO.status = newBusinessInfo;
                    //metadataBO.status = (Zurich.Echassis.BL.Quote.VPMS.NewBusinessStatus)value.QuoteMetaData.status;
                    metadataBO.sumAssured = value.QuoteMetaData.sumAssured;

                    if (value.QuoteMetaData.funds != null)
                    {
                        Zurich.Echassis.BL.Quote.VPMS.Fund[] fundBOCol = null;
                        List<Zurich.Echassis.BL.Quote.VPMS.Fund> lstFund = new List<Zurich.Echassis.BL.Quote.VPMS.Fund>();
                        //int fundCount = 0;
                        Zurich.Echassis.BL.Quote.VPMS.Fund fundBO = new BL.Quote.VPMS.Fund();
                        foreach (Fund f in value.QuoteMetaData.funds)
                        {
                            //fundCount++;
                            fundBO.allocation = f.allocation;
                            fundBO.id = f.id;
                            fundBO.name = f.name;
                            fundBO.specificationIds = f.specificationIds;
                            lstFund.Add(fundBO);
                            //fundBOCol[fundCount] = fundBO;
                        }
                        fundBOCol =lstFund.Count > 0 ?  lstFund.ToArray() : null;
                        metadataBO.funds = fundBOCol;
                    }


                    if (value.QuoteMetaData.livesAssured != null)
                    {
                        Zurich.Echassis.BL.Quote.VPMS.Person[] livesAssured = null;
                        List<Zurich.Echassis.BL.Quote.VPMS.Person> lstPerson = new List<BL.Quote.VPMS.Person>();
                        //int perColCount = 0;
                        foreach (Person p in value.QuoteMetaData.livesAssured)
                        {
                            Zurich.Echassis.BL.Quote.VPMS.Person persBo = new BL.Quote.VPMS.Person();
                            //perColCount++;
                            Zurich.Echassis.BL.Quote.VPMS.Benefit[] benifitCol = null;
                            List<Zurich.Echassis.BL.Quote.VPMS.Benefit> lstbenefit = new List<BL.Quote.VPMS.Benefit>();
                            //int bnftCount = 0;
                            foreach (Benefit b in p.benefits)
                            {
                                Zurich.Echassis.BL.Quote.VPMS.Benefit benBO = new BL.Quote.VPMS.Benefit();
                                //bnftCount++;
                                benBO.id = b.id;
                                benBO.name = b.name;
                                benBO.specificationIds = b.specificationIds;
                                lstbenefit.Add(benBO);
                                //benifitCol[bnftCount] = benBO;
                            }
                            benifitCol = lstbenefit.Count > 0 ? lstbenefit.ToArray() : null;
                            persBo.benefits = benifitCol;

                            Zurich.Echassis.BL.Quote.VPMS.Person.Country countryInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Country.SG;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.QuoteMetaData.applicant.countryOfResidence.ToString()))
                            {
                                countryInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Country)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.QuoteMetaData.applicant.countryOfResidence.ToString(), true);
                            }
                            persBo.countryOfResidence = countryInfo;//(Zurich.Echassis.BL.Quote.VPMS.Person.Country)p.countryOfResidence;
                            persBo.dateOfBirth = p.dateOfBirth;
                            persBo.firstName = p.firstName;

                            Zurich.Echassis.BL.Quote.VPMS.Person.Gender genderInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Gender.Male;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.QuoteMetaData.applicant.gender.ToString()))
                            {
                                genderInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Gender)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.QuoteMetaData.applicant.gender.ToString(), true);
                            }
                            persBo.gender = genderInfo;

                            Zurich.Echassis.BL.Quote.VPMS.Person.Nationality nationalityInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Nationality.SG;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.QuoteMetaData.applicant.nationality.ToString()))
                            {
                                nationalityInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Nationality)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.QuoteMetaData.applicant.nationality.ToString(), true);
                            }
                            persBo.nationality = nationalityInfo;

                            Zurich.Echassis.BL.Quote.VPMS.Person.Occupation occupationInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Occupation.Accountant;
                            if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.QuoteMetaData.applicant.occupation.ToString()))
                            {
                                occupationInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Occupation)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.QuoteMetaData.applicant.occupation.ToString(), true);
                            }
                            persBo.occupation = occupationInfo;
                            persBo.secondName = p.secondName;
                            persBo.smoker = p.smoker;
                            persBo.title = p.title;

                            lstPerson.Add(persBo);
                            //livesAssured[perColCount] = persBo;
                        }
                        livesAssured = lstPerson.Count > 0 ? lstPerson.ToArray() : null;
                        metadataBO.livesAssured = livesAssured;
                    }

                    if (value.QuoteMetaData.productType != null)
                    {
                        Zurich.Echassis.BL.Quote.VPMS.ProductType prodTypeBO = new Zurich.Echassis.BL.Quote.VPMS.ProductType();
                        prodTypeBO.id = value.QuoteMetaData.productType.id;
                        prodTypeBO.name = value.QuoteMetaData.productType.name;
                        prodTypeBO.specificationIds = value.QuoteMetaData.productType.specificationIds;
                        metadataBO.productType = prodTypeBO;
                    }

                    if (value.QuoteMetaData.signatories != null)
                    {
                        Zurich.Echassis.BL.Quote.VPMS.Signatory[] signatoryCol = null;
                        List<Zurich.Echassis.BL.Quote.VPMS.Signatory> lstSignatories = new List<BL.Quote.VPMS.Signatory>();
                        //int signCount = 0;
                        foreach (Signatory signat in value.QuoteMetaData.signatories)
                        {
                            //signCount++;
                            Zurich.Echassis.BL.Quote.VPMS.Signatory sign = new BL.Quote.VPMS.Signatory();
                            sign.name = signat.name;
                            sign.role = signat.role;
                            lstSignatories.Add(sign);
                            //signatoryCol[signCount] = sign;
                        }
                        signatoryCol = lstSignatories.Count > 0 ? lstSignatories.ToArray() : null;
                        metadataBO.signatories = signatoryCol;
                    }

                    quoteBO.QuoteMetaData = metadataBO;
                }
                #endregion

                #region Integration Data

                //if (value.IntegrationRequestData != null)
                //{
                //    Zurich.Echassis.BL.Quote.VPMS.UserPrivilege[] userPrivCol = null;
                //    int userPrivCount = 0;

                //    foreach (Zurich.Echassis.BusinessService.Contracts.UserPrivilege userPrivilege in value.IntegrationRequestData.user.privileges)
                //    {
                //        if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.UserPrivilege), userPrivilege.ToString()))
                //        {
                //            userPrivCount++;
                //            userPrivCol[userPrivCount] = (Zurich.Echassis.BL.Quote.VPMS.UserPrivilege)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.UserPrivilege), userPrivilege.ToString(), true);
                //        }

                //    }
                //    Zurich.Echassis.BL.Quote.VPMS.User quoteUser = new Zurich.Echassis.BL.Quote.VPMS.User();
                //    quoteUser.id = value.IntegrationRequestData.user.id;
                //    quoteUser.locale = value.IntegrationRequestData.user.locale;
                //    quoteUser.name = value.IntegrationRequestData.user.name;
                //    quoteUser.privileges = userPrivCol;
                //    quoteUser.roles = value.IntegrationRequestData.user.roles;

                //    //Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType invocationType = Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType.ExistingQuote;

                //    //if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType), value.IntegrationRequestData.quoteType.ToString()))
                //    //{
                //    //    invocationType = (Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType), value.IntegrationRequestData.quoteType.ToString(), true);
                //    //}

                //    Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType invocationType = (Zurich.Echassis.BL.Quote.VPMS.NewBusinessInvocationType)value.IntegrationRequestData.quoteType;

                //    //Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype distSteroType = Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype.ExpatFA;

                //    //if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype), value.IntegrationRequestData.distributor.stereotypeId.ToString()))
                //    //{
                //    //    distSteroType = (Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype), value.IntegrationRequestData.distributor.stereotypeId.ToString(), true);
                //    //}

                //    Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype distSteroType = (Zurich.Echassis.BL.Quote.VPMS.DistributorStereotype)value.IntegrationRequestData.distributor.stereotypeId;

                //    Zurich.Echassis.BL.Quote.VPMS.Distributor quoteDistributor = new BL.Quote.VPMS.Distributor();
                //    quoteDistributor.id = value.IntegrationRequestData.distributor.id;
                //    quoteDistributor.name = value.IntegrationRequestData.distributor.name;
                //    quoteDistributor.repNumber = value.IntegrationRequestData.distributor.repNumber;
                //    quoteDistributor.stereotypeId = distSteroType;


                //    //Zurich.Echassis.BL.Quote.VPMS.Person.Country countyInfo=Zurich.Echassis.BL.Quote.VPMS.Person.Country.SG;
                //    //if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.IntegrationRequestData.applicant.countryOfResidence.ToString()))
                //    //{
                //    //    countyInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Country)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Country), value.IntegrationRequestData.applicant.countryOfResidence.ToString(), true);
                //    //}

                //    Zurich.Echassis.BL.Quote.VPMS.Person.Country countyInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Country)value.IntegrationRequestData.applicant.countryOfResidence;


                //    Zurich.Echassis.BL.Quote.VPMS.Person.Gender genderInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Gender.Male;
                //    if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.IntegrationRequestData.applicant.gender.ToString()))
                //    {
                //        genderInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Gender)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Gender), value.IntegrationRequestData.applicant.gender.ToString(), true);
                //    }


                //    Zurich.Echassis.BL.Quote.VPMS.Person.Nationality nationalityInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Nationality.SG;
                //    if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.IntegrationRequestData.applicant.nationality.ToString()))
                //    {
                //        nationalityInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Nationality)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Nationality), value.IntegrationRequestData.applicant.nationality.ToString(), true);
                //    }

                //    Zurich.Echassis.BL.Quote.VPMS.Person.Occupation occupationInfo = Zurich.Echassis.BL.Quote.VPMS.Person.Occupation.Accountant;
                //    if (Enum.IsDefined(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.IntegrationRequestData.applicant.occupation.ToString()))
                //    {
                //        occupationInfo = (Zurich.Echassis.BL.Quote.VPMS.Person.Occupation)Enum.Parse(typeof(Zurich.Echassis.BL.Quote.VPMS.Person.Occupation), value.IntegrationRequestData.applicant.occupation.ToString(), true);
                //    }

                //    Zurich.Echassis.BL.Quote.VPMS.Person person = new BL.Quote.VPMS.Person();
                //    person.countryOfResidence = countyInfo;
                //    person.dateOfBirth = value.IntegrationRequestData.applicant.dateOfBirth;
                //    person.firstName = value.IntegrationRequestData.applicant.firstName;
                //    person.gender = genderInfo;
                //    person.nationality = nationalityInfo;
                //    person.occupation = occupationInfo;
                //    person.secondName = value.IntegrationRequestData.applicant.secondName;
                //    person.smoker = value.IntegrationRequestData.applicant.smoker;
                //    person.title = value.IntegrationRequestData.applicant.title;

                //    quoteBO.IntegrationRequestData = new BL.Quote.VPMS.NewBusinessInvocationRequest(
                //        value.IntegrationRequestData.quoteId, value.CaseId, value.CloneQuoteId, invocationType,
                //        quoteUser, quoteDistributor, person);

                //}
                #endregion Integration Data
            }
            catch (Exception e)
            { 
            }
            return quoteBO;
        }

        public override QuoteDataContract ServiceToBusiness(QuoteBO value)
        {
            throw new NotImplementedException();
        }
    }
}