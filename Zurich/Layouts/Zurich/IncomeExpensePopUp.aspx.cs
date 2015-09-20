using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using DAO;
using System.Data.Linq;
using System.Collections.Specialized;
using ActivityStatusCheck;

namespace Zurich.Layouts.Zurich
{
    public partial class IncomeExpensePopUp : LayoutsPageBase
    {
        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            activity = activityStatusDao.getActivity(4);
            ViewState["activity"] = activity;

            lblPdSummarySaveSuccess.Visible = false;
            lblPdSummarySaveFailed.Visible = false;

            incomeExpense incomeExpense = null;

            if (!IsPostBack)
            {
                string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];
                string helperUsed = Request.Form["helperUsed"];
                string caseId = "";
                IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();

                if (nextCaseId != null && nextCaseId != "")
                {
                    caseId = nextCaseId;
                }

                if (menuCaseId != null && menuCaseId != "")
                {
                    caseId = menuCaseId;
                }

                if (Session["fnacaseid"] != null)
                {
                    caseId = Session["fnacaseid"].ToString();
                }

                ViewState["caseId"] = caseId;

                if (caseId != null || caseId != "")
                {
                    incomeExpense = incomeExpenseDao.getIncomeExpenseForCase(caseId);

                }

                populateIncomeAndExpenseDetails(incomeExpense, caseId);
            }
        }


        protected void populateIncomeAndExpenseDetails(incomeExpense incomeExpense, string caseId)
        {
            if (incomeExpense != null)
            {
                DeathTermInsuranceSA.Text = incomeExpense.DeathTermInsuranceSA;
                DeathWholeLifeInsuranceSA.Text = incomeExpense.DeathWholeLifeInsuranceSA;
                DeathTermInsuranceTerm.Text = incomeExpense.DeathTermInsuranceTerm;
                DeathWholeLifeInsuranceTerm.Text = incomeExpense.DeathWholeLifeInsuranceTerm;
                DeathTermInsurancePremium.Text = incomeExpense.DeathTermInsurancePremium;
                DeathWholeLifeInsurancePremium.Text = incomeExpense.DeathWholeLifeInsurancePremium;
                emergencyFundsNeeded.Text = incomeExpense.emergencyFundsNeeded;
                shortTermGoals.Text = incomeExpense.shortTermGoals;
                extraDetails.Text = incomeExpense.extraDetails;
                netMonthlyIncomeAfterCpf.Text = incomeExpense.netMonthlyIncomeAfterCpf;
                netMonthlyExpenses.Text = incomeExpense.netMonthlyExpenses;
                monthlySavings.Text = incomeExpense.monthlySavings;
                lifeInsuranceSA.Text = incomeExpense.lifeInsuranceSA;
                lifeInsuranceMV.Text = incomeExpense.lifeInsuranceMV;
                lifeInsurancePremium.Text = incomeExpense.lifeInsurancePremium;
                tpdcSA.Text = incomeExpense.tpdcSA;
                tpdcMV.Text = incomeExpense.tpdcMV;
                tpdcPremium.Text = incomeExpense.tpdcPremium;
                criticalIllnessSA.Text = incomeExpense.criticalIllnessSA;
                criticalIllnessMV.Text = incomeExpense.criticalIllnessMV;
                criticalIllnessPremium.Text = incomeExpense.criticalIllnessPremium;
                mortgageSA.Text = incomeExpense.mortgageSA;
                mortgageMV.Text = incomeExpense.mortgageMV;
                mortgagePremium.Text = incomeExpense.mortgagePremium;
                otherSourcesOfIncome.Text = incomeExpense.otherSourcesOfIncome;

                if (incomeExpense.insuranceArrangementSavings.Count > 0)
                    this.savingsPlusNumber.Value = (incomeExpense.insuranceArrangementSavings.Count) + "";
                this.incomeInsuranceExpenseSavingRepeater.DataSource = incomeExpense.insuranceArrangementSavings;
                this.incomeInsuranceExpenseSavingRepeater.DataBind();


                if (incomeExpense.insuranceArrangementRetirements.Count > 0)
                    this.retirementPlusNumber.Value = (incomeExpense.insuranceArrangementRetirements.Count) + "";
                this.incomeInsuranceExpenseRetirementRepeater.DataSource = incomeExpense.insuranceArrangementRetirements;
                this.incomeInsuranceExpenseRetirementRepeater.DataBind();

                if (incomeExpense.insuranceArrangementEducations.Count > 0)
                    this.educationPlusNumber.Value = (incomeExpense.insuranceArrangementEducations.Count) + "";
                this.incomeInsuranceExpenseEducationRepeater.DataSource = incomeExpense.insuranceArrangementEducations;
                this.incomeInsuranceExpenseEducationRepeater.DataBind();
            }
            activityId.Value = caseId;
            PersonalDetailsDAO personalDao = new PersonalDetailsDAO();
            personaldetail detail = personalDao.getPersonalDetail(caseId);
            if (detail != null)
            {
                if ((detail.name != null) || (detail.name != ""))
                    PersonName.Value = detail.name;
                else
                    PersonName.Value = "";
            }
            else
                PersonName.Value = "";
        }

    }
}
