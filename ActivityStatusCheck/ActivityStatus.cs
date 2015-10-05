using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Reflection;
using System.Data.Linq;
using System.IO;
using System.Diagnostics;
using DAO;
using ActivityStatusCheck.BusinessService;
using PDFGeneration;
using System.Web.UI.WebControls;

namespace ActivityStatusCheck
{
    public class ActivityStatus
    {
        protected ActivityStatusDAO dao = new ActivityStatusDAO();

        public string getMzaStatus(List<myzurichadviser> mzaOptions)
        {
            string status = "incomplete";

            if (mzaOptions != null && mzaOptions.Count > 0)
            {
                status = "complete";
                foreach (myzurichadviser mz in mzaOptions)
                {
                    if (mz.selectedoptionid == 4 && (mz.selectedoptionothers == null || mz.selectedoptionothers == ""))
                    {
                        status = "incomplete";
                        break;
                    }
                }
            }

            return status;
        }
        
        public string getPersonalDetailStatus(personaldetail personalDetails)
        {
            string status = "";

            if ((personalDetails.title != null && personalDetails.title != "") &&
                (personalDetails.name != null && personalDetails.name != "") &&
                (personalDetails.surname != null && personalDetails.surname != "") &&
                (personalDetails.gender != null && personalDetails.gender != "") &&
                (personalDetails.nric != null && personalDetails.nric != "") &&
                (personalDetails.nationality != null && personalDetails.nationality != "") &&
                (personalDetails.datepicker != null && personalDetails.datepicker != "") &&
                (personalDetails.maritalstatus != null && personalDetails.maritalstatus != "") &&
                (personalDetails.issmoker != null && personalDetails.issmoker != "") &&
                (personalDetails.address != null && personalDetails.address != "") &&
                (personalDetails.employmentstatus != null && personalDetails.employmentstatus != "") &&
                (personalDetails.occupation != null && personalDetails.occupation != "") &&
                (personalDetails.companyname != null && personalDetails.companyname != "") &&
                ((personalDetails.contactnumber != null && personalDetails.contactnumber != "") || (personalDetails.contactnumberfax != null && personalDetails.contactnumberfax != "") || (personalDetails.contactnumberhp != null && personalDetails.contactnumberhp != "") || (personalDetails.contactnumberoffice != null && personalDetails.contactnumberoffice != "")) &&
                (personalDetails.email != null && personalDetails.email != "") &&
                (personalDetails.educationlevel != null && personalDetails.educationlevel != "") &&
                (personalDetails.medicalcondition != null && personalDetails.medicalcondition != "") &&
                (personalDetails.nominee != null && personalDetails.nominee != ""))
            {
                status = "complete";
                if (personalDetails.medicalcondition == "Yes" && (personalDetails.medicalconditiondetails == null || personalDetails.medicalconditiondetails == ""))
                {
                    status = "incomplete";
                }
            }
            else
            {
                status = "incomplete";
            }

            if (personalDetails.familyMemberDetails != null)
            {
                
                foreach(familyMemberDetail fmd in personalDetails.familyMemberDetails)
                {
                    if ((fmd.name == null || fmd.name == "") || (fmd.occupation == null || fmd.occupation == "") || (fmd.relationship == null || fmd.relationship == "") || (fmd.yrstosupport == null) || (fmd.dob == null || fmd.dob == "") || (fmd.monthlyIncome == null || fmd.monthlyIncome == ""))
                    {
                        status = "incomplete";
                        break;
                    }
                }
            }

            if (personalDetails.spokenLanguage == null || personalDetails.spokenLanguage == "")
            {
                status = "incomplete";
            }
            else
            {
                if (personalDetails.spokenLanguage.Contains("4") && (personalDetails.spokenLanguageOtherstxt == null || personalDetails.spokenLanguageOtherstxt == ""))
                {
                    status = "incomplete";
                }
            }

            if (personalDetails.writtenLanguage == null || personalDetails.writtenLanguage == "")
            {
                status = "incomplete";
            }
            else
            {
                if (personalDetails.writtenLanguage.Contains("4") && (personalDetails.writtenLanguageOtherstxt == null || personalDetails.writtenLanguageOtherstxt == ""))
                {
                    status = "incomplete";
                }
            }

            if (personalDetails.accompanyQuestion == "1" &&
                ((personalDetails.trustedIndividualName == null || personalDetails.trustedIndividualName == "")
                || (personalDetails.clientRelationship == null || personalDetails.clientRelationship == "")
                || (personalDetails.NRICAccompany == null || personalDetails.NRICAccompany == ""))
                )
            {
                status = "incomplete";
            }
            else
            {
                //if (personalDetails.noAccompaniedIndividualReason == null || personalDetails.noAccompaniedIndividualReason == "")
                //{
                //    status = "incomplete";
                //}
            }

            return status;
        }

        public string getPriorityDetailStatus(priorityDetail priorityDetail)
        {
            string status = "complete";

            /*if ((priorityDetail.protection1 == null || priorityDetail.protection1 == "") && (priorityDetail.protection2 == null || priorityDetail.protection2 == "") && (priorityDetail.protection3 == null || priorityDetail.protection3 == "") && (priorityDetail.protection4 == null || priorityDetail.protection4 == "") && (priorityDetail.savings1 == null || priorityDetail.savings1 == "") && (priorityDetail.savings2 == null || priorityDetail.savings2 == "") && (priorityDetail.savings3 == null || priorityDetail.savings3 == ""))
            {
                status = "incomplete";
            }*/

            return status;
        }

        public string getIncomeExpenseStatus(incomeExpense incomeExpense)
        {
            string status = "complete";

            if (incomeExpense.shortTermGoals != null && incomeExpense.shortTermGoals != "")
            {
                if (incomeExpense.shortTermGoals == "Yes")
                {
                    if (incomeExpense.extraDetails == null || incomeExpense.extraDetails == "")
                    {
                        status = "incomplete";
                    }
                    else
                    {
                        status = "complete";
                    }
                }
            }
            else
            {
                status = "incomplete";
            }

            if (incomeExpense.incomeExpenseNeeded == 1)
            {
                if (incomeExpense.incomeExpenseNotNeededReason == null || incomeExpense.incomeExpenseNotNeededReason == "")
                {
                    status = "incomplete";
                }
            }

            return status;
        }

        public string getAssetLiabilityStatus(assetAndLiability al)
        {
            string status = "incomplete";

            if (al.assetAndLiabilityNeeded == 0)
            {
                if (al.premiumRecomendedNeeded == 0)
                {
                    if ((al.regularSumCash != null && al.regularSumCash != "") ||
                        (al.regularSumCpf != null && al.regularSumCpf != "") ||
                        (al.lumpSumCash != null && al.lumpSumCash != "") ||
                        (al.lumpSumCpf != null && al.lumpSumCpf != ""))
                    {
                        status = "complete";
                    }
                    else
                    {
                        status = "incomplete";
                    }

                    if (al.assetIncomePercent != null && al.assetIncomePercent != "")
                    {
                        status = "complete";
                    }
                    else
                    {
                        status = "incomplete";
                    }
                }
                else
                {
                    if ((al.regularSumCash != null && al.regularSumCash != "") ||
                        (al.regularSumCpf != null && al.regularSumCpf != "") ||
                        (al.lumpSumCash != null && al.lumpSumCash != "") ||
                        (al.lumpSumCpf != null && al.lumpSumCpf != ""))
                    {
                        status = "complete";
                    }
                }               
            }
            else
            {
                if (al.assetAndLiabilityNotNeededReason != null && al.assetAndLiabilityNotNeededReason != "")
                {
                    status = "complete";
                }
            }
            

            return status;
        }

        public string getProtectionGoalFamilyStatus(familyNeed familyneed)
        {
            string status = "";
            string familyIncStatus = "";
            string mortgageStatus = "";

            if ((familyneed.familyIncPrNeeded == 1 || familyneed.familyIncPrNeeded == 0) && (familyneed.mortgageNeeded == 1 || familyneed.mortgageNeeded == 0))
            {
                familyIncStatus = "complete";
                mortgageStatus = "complete";
            }
            else
            {
                if (familyneed.familyIncPrNeeded == 2)
                {
                    if ((familyneed.replacementIncomeRequired == null || familyneed.replacementIncomeRequired == "") &&
                    (familyneed.yearsOfSupportRequired == null || familyneed.yearsOfSupportRequired == "") &&
                    (familyneed.inflationAdjustedReturns == null || familyneed.inflationAdjustedReturns == "") &&
                    (familyneed.lumpSumRequired == null || familyneed.lumpSumRequired == "") &&
                    (familyneed.otherLiabilities == null || familyneed.otherLiabilities == "") &&
                    (familyneed.emergencyFundsNeeded == null || familyneed.emergencyFundsNeeded == "") &&
                    (familyneed.finalExpenses == null || familyneed.finalExpenses == "") &&
                    (familyneed.otherFundingNeeds == null || familyneed.otherFundingNeeds == "") &&
                    (familyneed.totalRequired == null || familyneed.totalRequired == "") &&
                    (familyneed.existingLifeInsurance == null || familyneed.existingLifeInsurance == "") &&
                    (familyneed.totalShortfallSurplus == null || familyneed.totalShortfallSurplus == ""))
                    {
                        familyIncStatus = "incomplete";
                    }
                    else
                    {
                        familyIncStatus = "complete";
                    }
                }
                else
                {
                    familyIncStatus = "complete";
                }

                if (familyneed.mortgageNeeded == 2)
                {
                    if ((familyneed.mortgageProtectionOutstanding == null || familyneed.mortgageProtectionOutstanding == "") &&
                    (familyneed.mortgageProtectionInsurances == null || familyneed.mortgageProtectionInsurances == "") &&
                    (familyneed.mortgageProtectionTotal == null || familyneed.mortgageProtectionTotal == ""))
                    {
                        mortgageStatus = "incomplete";
                    }
                    else
                    {
                        mortgageStatus = "complete";
                    }
                }
                else
                {
                    mortgageStatus = "complete";
                }
            }

            
            if (familyIncStatus == "complete" && mortgageStatus == "complete")
            {
                status = "complete";
            }
            else
            {
                status = "incomplete";
            }
            
            return status;
        }

        public string getProtectionGoalMyneedsStatus(myNeed myneed)
        {
            string status = "";
            string criticalIllnessSectionStatus = "";
            string disabilitySectionStatus = "";
            string hospitalCoverSectionStatus = "";
            string accidentalCoverSectionStatus = "";

            if ((myneed.criticalIllnessPrNeeded == 1 || myneed.criticalIllnessPrNeeded == 0) && (myneed.disabilityPrNeeded == 1 || myneed.disabilityPrNeeded == 0) && (myneed.hospitalmedCoverNeeded == 1 || myneed.hospitalmedCoverNeeded == 0) && (myneed.accidentalhealthCoverNeeded == 1 || myneed.accidentalhealthCoverNeeded == 0))
            {
                status = "complete";
            }
            else
            {
                if (myneed.criticalIllnessPrNeeded == 2)
                {
                    if ((myneed.replacementIncomeRequired == null || myneed.replacementIncomeRequired == "") &&
                        (myneed.yearsOfSupportRequired == null || myneed.yearsOfSupportRequired == "") &&
                        (myneed.inflatedAdjustedReturns == null || myneed.inflatedAdjustedReturns == "") &&
                        (myneed.replacementAmountRequired == null || myneed.replacementAmountRequired == "") &&
                        (myneed.lumpSumRequiredForTreatment == null || myneed.lumpSumRequiredForTreatment == "") &&
                        (myneed.totalRequired == null || myneed.totalRequired == "") &&
                        (myneed.criticalIllnessInsurance == null || myneed.criticalIllnessInsurance == ""))
                    {
                        criticalIllnessSectionStatus = "incomplete";           
                    }
                    else
                    {
                        criticalIllnessSectionStatus = "complete";
                    }
                }
                else if (myneed.criticalIllnessPrNeeded == 1 || myneed.criticalIllnessPrNeeded == 0)
                {
                    criticalIllnessSectionStatus = "complete";
                }
                
                if (myneed.disabilityPrNeeded == 2)
                {
                    if ((myneed.disabilityProtectionReplacementIncomeRequired == null || myneed.disabilityProtectionReplacementIncomeRequired == "") &&
                        (myneed.disabilityYearsOfSupport == null || myneed.disabilityYearsOfSupport == "") &&
                        (myneed.disabilityReplacementAmountRequired == null || myneed.disabilityReplacementAmountRequired == "") &&
                        (myneed.disabilityInsurance == null || myneed.disabilityInsurance == ""))
                    {
                        disabilitySectionStatus = "incomplete";
                    }
                    else
                    {
                        disabilitySectionStatus = "complete";
                    }
                }
                else if (myneed.disabilityPrNeeded == 1 || myneed.disabilityPrNeeded == 0)
                {
                    disabilitySectionStatus = "complete";
                }

                if (myneed.hospitalmedCoverNeeded == 2)
                {
                    if ((myneed.typeOfHospitalCoverage == null || myneed.typeOfHospitalCoverage == "") &&
                        (myneed.anyExistingPlans == null) &&
                        (myneed.typeOfRoomCoverage == null || myneed.typeOfRoomCoverage.Value == 0))
                    {
                        hospitalCoverSectionStatus = "incomplete";
                    }
                    else
                    {
                        hospitalCoverSectionStatus = "complete";
                    }
                }
                else if (myneed.hospitalmedCoverNeeded == 1 || myneed.hospitalmedCoverNeeded == 0)
                {
                    hospitalCoverSectionStatus = "complete";
                }

                if (myneed.accidentalhealthCoverNeeded == 2)
                {
                    if ((myneed.coverageOldageYesNo == null) &&
                        (myneed.epOldageYesNo == null) &&
                        (myneed.coveragePersonalYesNo == null) &&
                        (myneed.epPersonalYesNo == null) && 
                        (myneed.coverageOutpatientMedExp == null) && 
                        (myneed.epOutpatientMedExp == null) && 
                        (myneed.coverageLossOfIncome == null) && 
                        (myneed.epLossOfIncome == null) && 
                        (myneed.coverageOldageDisabilities == null) && 
                        (myneed.epOldageDisabilities == null) && 
                        (myneed.coverageDentalExp == null) && 
                        (myneed.epDentalExp == null))
                    {
                        accidentalCoverSectionStatus = "incomplete";
                    }
                    else
                    {
                        accidentalCoverSectionStatus = "complete";
                    }
                }
                else if (myneed.accidentalhealthCoverNeeded == 1 || myneed.accidentalhealthCoverNeeded == 0)
                {
                    accidentalCoverSectionStatus = "complete";
                }

                if (criticalIllnessSectionStatus == "complete" && disabilitySectionStatus == "complete" && hospitalCoverSectionStatus == "complete" && accidentalCoverSectionStatus == "complete")
                {
                    status = "complete";
                }
                else
                {
                    status = "incomplete";
                }
            }
            
            return status;
        }

        public string getSavingGoalStatus(string caseid)
        {
            string status = "";

            SavingGoalsDAO sgDao = new SavingGoalsDAO();
            List<savinggoal> sgList = sgDao.getSavingGoal(caseid);
            
            if (sgList == null || sgList.Count == 0)
            {
                status = "incomplete";
            }
            else
            {
                savinggoal stmp = sgList[0];

                if (stmp.savingGoalNeeded == 1 || stmp.savingGoalNeeded == 0)
                {
                    status = "complete";
                }
                else
                {
                    foreach (savinggoal sg in sgList)
                    {
                        if ((sg.goal != null && sg.goal != "") || (sg.yrstoaccumulate != null && sg.yrstoaccumulate != "") || (sg.amtneededfv != null && sg.amtneededfv != "") || (sg.maturityvalue != null && sg.maturityvalue != ""))
                        {
                            status = "complete";
                            break;
                        }
                    }
                    if (status == "")
                    {
                        status = "incomplete";
                    }
                }
                
            }

            return status;
        }

        public string getRetirementGoalStatus(retirementgoal retirementGoal)
        {
            string status = "incomplete";

            if (retirementGoal.retirementGoalNeeded == 1 || retirementGoal.retirementGoalNeeded == 0)
            {
                status = "complete";
            }
            else
            {
                if ((retirementGoal.intendedretirementage != null && retirementGoal.intendedretirementage != "")
                || (retirementGoal.incomerequired != null && retirementGoal.incomerequired != "")
                || (retirementGoal.yrstoretirement != null && retirementGoal.yrstoretirement != "")
                || (retirementGoal.sourcesofincome != null && retirementGoal.sourcesofincome != "")
                || (retirementGoal.durationretirement != null && retirementGoal.durationretirement != "")
                || (retirementGoal.maturityvalue != null && retirementGoal.maturityvalue != ""))
                {
                    status = "complete";
                }
            }
            
            return status;
        }

        public string getEducationGoalStatus(string caseid)
        {
            string status = "";

            EducationGoalsDAO egDao = new EducationGoalsDAO();
            List<educationgoal> egList = egDao.getEducationGoal(caseid);

            if (egList == null || egList.Count == 0)
            {
                status = "incomplete";
            }
            else
            {
                educationgoal etmp = egList[0];

                if (etmp.educationGoalNeeded == 1 || etmp.educationGoalNeeded == 0)
                {
                    status = "complete";
                }
                else
                {
                    foreach (educationgoal eg in egList)
                    {
                        if ((eg.nameofchild != null && eg.nameofchild != "") || (eg.currentage != null && eg.currentage != "") || (eg.agefundsneeded != null && eg.agefundsneeded != "") || (eg.noofyrstosave != null && eg.noofyrstosave != "") || (eg.maturityvalue != null && eg.maturityvalue != ""))
                        {
                            status = "complete";
                            break;
                        }
                    }
                    if (status == "")
                    {
                        status = "incomplete";
                    }
                }
                
            }

            return status;
        }

        public string getRiskProfileStatus(RiskProfileAnalysis riskprofile)
        {
            string status = "incomplete";

            if(((riskprofile.riskApetiteQuestion1option1!=null && riskprofile.riskApetiteQuestion1option1!="") || (riskprofile.riskApetiteQuestion1option2!=null && riskprofile.riskApetiteQuestion1option2!="") || (riskprofile.riskApetiteQuestion1option3!=null && riskprofile.riskApetiteQuestion1option3!="") || (riskprofile.riskApetiteQuestion1option4!=null && riskprofile.riskApetiteQuestion1option4!="") || (riskprofile.riskApetiteQuestion1option5!=null && riskprofile.riskApetiteQuestion1option5!="") || (riskprofile.riskApetiteQuestion1option6!=null && riskprofile.riskApetiteQuestion1option6!="")) && 
                ((riskprofile.riskApetiteQuestion2option1!=null && riskprofile.riskApetiteQuestion2option1!="") || (riskprofile.riskApetiteQuestion2option2!=null && riskprofile.riskApetiteQuestion2option2!="") || (riskprofile.riskApetiteQuestion2option3!=null && riskprofile.riskApetiteQuestion2option3!="") || (riskprofile.riskApetiteQuestion2option4!=null && riskprofile.riskApetiteQuestion2option4!="")) && 
                ((riskprofile.riskApetiteQuestion3option1!=null && riskprofile.riskApetiteQuestion3option1!="") || (riskprofile.riskApetiteQuestion3option2!=null && riskprofile.riskApetiteQuestion3option2!="") || (riskprofile.riskApetiteQuestion3option3!=null && riskprofile.riskApetiteQuestion3option3!="") || (riskprofile.riskApetiteQuestion3option4!=null && riskprofile.riskApetiteQuestion3option4!="") || (riskprofile.riskApetiteQuestion3option5!=null && riskprofile.riskApetiteQuestion3option5!="")) && 
                ((riskprofile.riskApetiteQuestion4option1!=null && riskprofile.riskApetiteQuestion4option1!="") || (riskprofile.riskApetiteQuestion4option2!=null && riskprofile.riskApetiteQuestion4option2!="") || (riskprofile.riskApetiteQuestion4option3!=null && riskprofile.riskApetiteQuestion4option3!="")) && 
                ((riskprofile.measuringRiskTakingAbilityQuestion1option1!=null && riskprofile.measuringRiskTakingAbilityQuestion1option1!="") || (riskprofile.measuringRiskTakingAbilityQuestion1option2!=null && riskprofile.measuringRiskTakingAbilityQuestion1option2!="") || (riskprofile.measuringRiskTakingAbilityQuestion1option3!=null && riskprofile.measuringRiskTakingAbilityQuestion1option3!="") || (riskprofile.measuringRiskTakingAbilityQuestion1option4!=null && riskprofile.measuringRiskTakingAbilityQuestion1option4!="")) && 
                ((riskprofile.measuringRiskTakingAbilityQuestion2option1!=null && riskprofile.measuringRiskTakingAbilityQuestion2option1!="") || (riskprofile.measuringRiskTakingAbilityQuestion2option2!=null && riskprofile.measuringRiskTakingAbilityQuestion2option2!="") || (riskprofile.measuringRiskTakingAbilityQuestion2option3!=null && riskprofile.measuringRiskTakingAbilityQuestion2option3!="")) && 
                ((riskprofile.measuringRiskTakingAbilityQuestion3option1!=null && riskprofile.measuringRiskTakingAbilityQuestion3option1!="") || (riskprofile.measuringRiskTakingAbilityQuestion3option2!=null && riskprofile.measuringRiskTakingAbilityQuestion3option2!="") || (riskprofile.measuringRiskTakingAbilityQuestion3option3!=null && riskprofile.measuringRiskTakingAbilityQuestion3option3!="") || (riskprofile.measuringRiskTakingAbilityQuestion3option4!=null && riskprofile.measuringRiskTakingAbilityQuestion3option4!="")) &&
                ((riskprofile.measuringRiskTakingAbilityQuestion4option1 != null && riskprofile.measuringRiskTakingAbilityQuestion4option1 != "") || (riskprofile.measuringRiskTakingAbilityQuestion4option2 != null && riskprofile.measuringRiskTakingAbilityQuestion4option2 != "") || (riskprofile.measuringRiskTakingAbilityQuestion4option3 != null && riskprofile.measuringRiskTakingAbilityQuestion4option3 != "") || (riskprofile.measuringRiskTakingAbilityQuestion4option4 != null && riskprofile.measuringRiskTakingAbilityQuestion4option4 != "")))
            {
                status = "complete";
            }

            return status;
        }

        public string getCkaStatus(CkaAssessment ckaassessment)
        {
            string status = "incomplete";

            if(((ckaassessment.investmentExperienceOption1!=null && ckaassessment.investmentExperienceOption1!="") || (ckaassessment.investmentExperienceOption2!=null && ckaassessment.investmentExperienceOption2!="")) && 
                ((ckaassessment.workingExperienceOption1!=null && ckaassessment.workingExperienceOption1!="") || (ckaassessment.workingExperienceOption2!=null && ckaassessment.workingExperienceOption2!="")) && 
                ((ckaassessment.educationalExperienceOption1!=null && ckaassessment.educationalExperienceOption1!="") || (ckaassessment.educationalExperienceOption2!=null && ckaassessment.educationalExperienceOption2!="")) && 
                ((ckaassessment.csaOutcomeOption1!=null && ckaassessment.csaOutcomeOption1!="") || (ckaassessment.csaOutcomeOption2!=null && ckaassessment.csaOutcomeOption2!="")))
            {
                status = "complete";
            }

            return status;
        }

        public string getPortfolioBuilderStatus(double premiumPercent)
        {
            string status = "incomplete";

            if (premiumPercent == 100)
            {
                status = "complete";
            }

            return status;
        }

        public string getZPlanStatus(string caseid)
        {
            string status = "";

            ActivityStatusDAO dao = new ActivityStatusDAO();
            activitystatus activityStatusPerdet = null;
            //activitystatus activityStatusPrDet = null;
            activitystatus activityStatusAssetLiab = null;
            activitystatus activityStatusIncomeExpense = null;
            activitystatus activityStatusMza = null;

            activityStatusPerdet = dao.getActivityForCaseid(caseid, "personaldetail");
            //activityStatusPrDet = dao.getActivityForCaseid(caseid, "prioritydetail");
            activityStatusAssetLiab = dao.getActivityForCaseid(caseid, "assetliability");
            activityStatusIncomeExpense = dao.getActivityForCaseid(caseid, "incomeexpense");
            activityStatusMza = dao.getActivityForCaseid(caseid, "myzurichadviser");

            if (activityStatusPerdet != null && activityStatusAssetLiab != null && activityStatusIncomeExpense != null && activityStatusMza != null)
            {
                if (activityStatusPerdet.status == "incomplete" || activityStatusAssetLiab.status == "incomplete" || activityStatusIncomeExpense.status == "incomplete" || activityStatusMza.status == "incomplete")
                {
                    status = "Incomplete";
                }
                else
                {
                    status = "Complete";
                }
            }
            else
            {
                status = "Incomplete";
            }

            return status;
        }

        public byte[] sendDataToSalesPortal(string caseid, string caseStatus, string url, bool sendPdf)
        {
            int status = 1;
            string csid = "";
            byte[] pdfData = null;

            /*ActivityStatusDAO dao = new ActivityStatusDAO();

            salesportalinfo salesPortalInfo = dao.getSalesPortalInfoForCaseid(caseid);
            
            ZPlanResponseDataContract zPlanResponse = null;
            ZPlanDataContract zPlanContract = new ZPlanDataContract();
            zPlanContract.ActivityId = caseid;
            zPlanContract.ZPlanStatus = caseStatus;
            zPlanContract.Action = ActionEnumContracts.Save;
            zPlanContract.Activity = ActivityTypeEnum.ZPlan;

            if (salesPortalInfo != null)
            {
                zPlanContract.ActivityType = salesPortalInfo.activitytype;
                zPlanContract.CaseId = salesPortalInfo.caseid;
                zPlanContract.RedirectUrl = salesPortalInfo.redirecturl;
                zPlanContract.RoleType = salesPortalInfo.roletype;
                zPlanContract.SalesPortalUrl = salesPortalInfo.salesportalurl;
                zPlanContract.UserFirstName = salesPortalInfo.userfirstname;
                zPlanContract.UserId = salesPortalInfo.userid;
                zPlanContract.UserLastName = salesPortalInfo.userlastname;
                zPlanContract.UserType = salesPortalInfo.usertype;
                zPlanContract.CaseStatus = salesPortalInfo.casestatus;

                UserInfoEntity ufo = new UserInfoEntity();
                ufo.UserId = salesPortalInfo.userid;
                ufo.Country = salesPortalInfo.country;
                ufo.RoleType = salesPortalInfo.saleschannel;
                zPlanContract.UserInfo = ufo;
             
                csid = salesPortalInfo.caseid; 
            }

            //get the personal details
            PersonalDetailsDAO personalDetDao = new PersonalDetailsDAO();
            personaldetail personalDetails = personalDetDao.getPersonalDetail(caseid);
            
            //populate datacontract values
            if (personalDetails != null)
            {
                zPlanContract.Title = personalDetails.title;
                zPlanContract.Name = personalDetails.name;
                zPlanContract.UserFirstName = personalDetails.name;
                zPlanContract.UserLastName = personalDetails.surname;
                zPlanContract.Gender = personalDetails.gender;

                if(personalDetails.datepicker!=null && personalDetails.datepicker!="")
                {
                    zPlanContract.Dob = personalDetails.datepicker;
                }
                
                if(personalDetails.issmoker == "Yes")
                {
                    zPlanContract.Smoker = true;
                }
                if (personalDetails.issmoker == "No")
                {
                    zPlanContract.Smoker = false;
                }

                if (personalDetails.familyMemberDetails != null && personalDetails.familyMemberDetails.Count > 0)
                {
                    FamilyDetailsList familyDetailsList = new FamilyDetailsList();
                    foreach (familyMemberDetail fmd in personalDetails.familyMemberDetails)
                    {
                        FamilyDetails f = new FamilyDetails();
                        f.Dob = fmd.dob;
                        f.FamilyMember = fmd.memberId;
                        f.MemberName = fmd.name;
                        f.MemberRelation = fmd.relationship;
                        familyDetailsList.Add(f);
                    }
                    zPlanContract.FamilyDetails = familyDetailsList;
                }

                zPlanContract.NricOrPassport = personalDetails.nric;
                zPlanContract.Nationality = personalDetails.nationality;
                zPlanContract.Occupation = personalDetails.occupation;
                zPlanContract.MaritalStatus = personalDetails.maritalstatus;
                
            }

            //get Portfolio builder/fund collection details
            DataTable dt = null;
            try
            {
                PortFolioModellingDAO portfolioDao = new PortFolioModellingDAO();
                dt = portfolioDao.getPortFolioDetailWithMaster(caseid);
                if (dt != null && dt.Rows.Count > 0)
                {
                    FundCollectionList fundList = new FundCollectionList();
                    foreach (DataRow dr in dt.Rows)
                    {
                        FundsCollection fundDetails = new FundsCollection();
                        fundDetails.Fund = dr["Fund"].ToString();
                        fundDetails.FundAllocationAmount = dr["FundAllocationAmount"].ToString();
                        fundDetails.FundAllocationPercentage = dr["FundAllocationPercentage"].ToString();
                        fundDetails.PremiumAmount = dr["PremiumAmount"].ToString();
                        fundDetails.PremiumFrequency = dr["PremiumFrequency"].ToString();

                        fundList.Add(fundDetails);
                    }
                    zPlanContract.FundsCollection = fundList;
                }
            }
            catch (Exception excp)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = excp.Message + " class: ActivityStatus Method: sendDataToSalesPortal Getting fund collection. caseid="+csid+" activity id="+caseid;
                exLog.source = excp.Source;

                string strtmp = excp.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = excp.TargetSite.Name;

                dao.logException(exLog);
            }

            if (sendPdf)
            {
                pdfData = generatePdf(caseid, url);
                zPlanContract.ByteArray = pdfData;   
            }

            try
            {
                //log start time calling webservice to db
                exceptionlog exLg1 = new exceptionlog();
                exLg1.message = "starting time calling webservice = 0";
                exLg1.source = caseid;
                exLg1.stacktrace = DateTime.Now.ToString();
                exLg1.targetsitename = "";
                dao.logException(exLg1);
                Stopwatch stpwatch1 = Stopwatch.StartNew();
                
                BusinessServiceClient client = new BusinessServiceClient();
                client.ClientCredentials.Windows.AllowedImpersonationLevel = System.Security.Principal.TokenImpersonationLevel.Impersonation;
                zPlanResponse = client.ManageZPlan(zPlanContract);

                //log end time calling webservice to db
                exLg1 = new exceptionlog();
                exLg1.message = "ending time calling webservice = " + stpwatch1.ElapsedMilliseconds;
                exLg1.source = caseid;
                exLg1.stacktrace = DateTime.Now.ToString();
                exLg1.targetsitename = "";
                dao.logException(exLg1);
            }
            catch (Exception e)
            {
                status = 0;

                //log exception to db
                exceptionlog exLog = new exceptionlog();
                string strData = "caseid=" + csid + ", activity id="+caseid+", casestatus=" + caseStatus + ", url=" + url + ", salesportalinfo obj=" + salesPortalInfo + ", zPlanContract obj=" + zPlanContract + ", zPlanContract userid=" + zPlanContract.UserId + ", personalDetails obj=" + personalDetails+", zplancontact name="+zPlanContract.Name+", portfoliomodel datatable="+dt+", zplancontract fundcollection="+zPlanContract.FundsCollection+", byte array="+pdfData;
                exLog.message = e.Message + " class: ActivityStatus Method: sendDataToSalesPortal Calling web service. data details: "+strData;
                exLog.source = e.Source;

                string strtmp = e.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = e.TargetSite.Name;

                dao.logException(exLog);
            }*/

            return pdfData;
        }

        public byte[] generatePdf(string caseid, string url)
        {
            byte[] pdfData = null;

            try
            {
                //log start time generating pdf to db
                /*exceptionlog exLg = new exceptionlog();
                exLg.message = "starting time generating pdf before web service call = 0";
                exLg.source = caseid;
                exLg.stacktrace = DateTime.Now.ToString();
                exLg.targetsitename = "";
                dao.logException(exLg);
                Stopwatch stpwatch = Stopwatch.StartNew();*/

                //populate pdf byte array
                GeneratePdf genPdf = new GeneratePdf();
                MemoryStream output = genPdf.createPdf(caseid, url);
                pdfData = output.ToArray();

                //log end time generating pdf to db
                /*exLg = new exceptionlog();
                exLg.message = "ending time generating pdf before web service call = "+stpwatch.ElapsedMilliseconds;
                exLg.source = caseid;
                exLg.stacktrace = DateTime.Now.ToString();
                exLg.targetsitename = "";
                dao.logException(exLg);*/
            }
            catch (Exception excp)
            {
                //log exception to db
                exceptionlog exLog = new exceptionlog();
                exLog.message = excp.Message + " class: ActivityStatus Method: generatePdf Getting pdf byte array. activity id=" + caseid;
                exLog.source = excp.Source;

                string strtmp = excp.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = excp.TargetSite.Name;

                dao.logException(exLog);
            }

            return pdfData;
        }

    }
}
