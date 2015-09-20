using System;
using System.Data;
using System.Data.Linq;
using System.Collections.Generic;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.IO;
using DAO;
using DTO;
using System.Configuration;
using PDFGeneration;
using Zurich.ControlTemplates.Zurich;
using System.Collections.Specialized;
using ActivityStatusCheck;
//using ActivityStatusCheck.BusinessService;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Zurich.Layouts.Zurich
{
    public partial class PersonalDetails : LayoutsPageBase
    {
        public string cas;

        protected ActivityStatus activityStatusCheck = new ActivityStatus();
        protected ActivityStatusDAO activityStatusDao = new ActivityStatusDAO();
        protected string activity = "";
        protected bool sendPdf = false;
        protected byte[] pdfData = null;

        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);

            FNAMenu menu = (FNAMenu)this.menu1;

            menu.EventClick += new EventHandler(WebForm_EventClick);
        }

        private void WebForm_EventClick(object sender, EventArgs e)
        {
            SampleEvent even=(SampleEvent)e;
            string toLink="";
            if (even != null)
                toLink = even.toLink;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            savePersonaldetails(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string caseId = "";
           
            activity = activityStatusDao.getActivity(1);
            ViewState["activity"] = activity;

            casestatuslbl.Visible = false;

            if (!IsPostBack)
            {

                string backCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];

                if (backCaseId != null && backCaseId != "")
                {
                    caseId = backCaseId;
                }
                else if (menuCaseId != null && menuCaseId != "")
                {
                    caseId = menuCaseId;
                }
                else if (Session["fnacaseid"] != null)
                {
                    caseId = Session["fnacaseid"].ToString();
                }
                else
                {
                    caseId = "2040";
                }
                         
                ViewState["caseId"] = caseId;
                activityId.Value = caseId;
                PersonalDetailsDAO dao = new PersonalDetailsDAO();
                personaldetail detail = dao.getPersonalDetail(caseId);

                if (detail == null)
                {
                    detail = new personaldetail();
                }

                populatePersonalDetails(detail);
            }

            titleList.Attributes.Add("readonly", "readonly");
            name.Attributes.Add("readonly", "readonly");
            surname.Attributes.Add("readonly", "readonly");
            datepicker.Attributes.Add("readonly", "readonly");
            genderList.Attributes.Add("readonly", "readonly");
            nationalityList.Attributes.Add("readonly", "readonly");
            //maritalList.Attributes.Add("readonly", "readonly");
            smokerList.Attributes.Add("readonly", "readonly");
            nric.Attributes.Add("readonly", "readonly");
            occupation.Attributes.Add("readonly", "readonly");

            markStatusOnTab(caseId);

        }


        private void populatePersonalDetails(personaldetail detail)
        {

            name.Text = (detail.name == null || detail.name == "") ? "" : detail.name;
            surname.Text = (detail.surname == null || detail.surname == "") ? "" : detail.surname; 
            titleList.Text = (detail.title == null || detail.title == "") ? "" : detail.title;
            genderList.Text = (detail.gender == null || detail.gender == "") ? "" : detail.gender;
            nric.Text = (detail.nric == null || detail.nric == "") ? "" : detail.nric;
            nationalityList.Text = (detail.nationality == null || detail.nationality == "") ? "" : detail.nationality;
            nationalityOthers.Text = (detail.nationalityothers == null || detail.nationalityothers == "") ? "" : detail.nationalityothers;
            
            if (detail.datepicker != null && detail.datepicker != "")
            {
                datepicker.Text = detail.datepicker;
            }
            else
            {
                datepicker.Text = "";
            }

            maritalList.SelectedValue = (detail.maritalstatus == null || detail.maritalstatus == "") ? "" : detail.maritalstatus;
            smokerList.Text = (detail.issmoker == null || detail.issmoker == "") ? "" : detail.issmoker;
            address.Text = (detail.address == null || detail.address == "") ? "" : detail.address;
            employmentList.Text = (detail.employmentstatus == null || detail.employmentstatus == "") ? "" : detail.employmentstatus;
            occupation.Text = (detail.occupation == null || detail.occupation == "") ? "" : detail.occupation;
            companyName.Text = (detail.companyname == null || detail.companyname == "") ? "" : detail.companyname;
            contactNumber.Text = (detail.contactnumber == null || detail.contactnumber == "") ? "" : detail.contactnumber;
            contactNumberOffice.Text = (detail.contactnumberoffice == null || detail.contactnumberoffice == "") ? "" : detail.contactnumberoffice;
            contactNumberHp.Text = (detail.contactnumberhp == null || detail.contactnumberhp == "") ? "" : detail.contactnumberhp;
            contactNumberFax.Text = (detail.contactnumberfax == null || detail.contactnumberfax == "") ? "" : detail.contactnumberfax;
            emailId.Text = (detail.email == null || detail.email == "") ? "" : detail.email;
            educationList.SelectedValue = (detail.educationlevel == null || detail.educationlevel == "") ? "" : detail.educationlevel;
            medicalList.SelectedValue = (detail.medicalcondition == null || detail.medicalcondition == "") ? "" : detail.medicalcondition;
            medicalConditions.Text = (detail.medicalconditiondetails == null || detail.medicalconditiondetails == "") ? "" : detail.medicalconditiondetails;
            nomineeList.SelectedValue = (detail.nominee == null || detail.nominee == "") ? "" : detail.nominee;
            willList.SelectedValue = (detail.will == null || detail.will == "") ? "" : detail.will;

            FamilyDetailsRequired.SelectedValue = (detail.familyDetailsRequired == null || detail.familyDetailsRequired == "") ? "1" : detail.familyDetailsRequired;
                  
            if (detail.spokenLanguage != null)
            {
                string spokenLanguage = detail.spokenLanguage;

                char[] delimiterChars = { ',' };
                string[] words = spokenLanguage.Split(delimiterChars);

                foreach (string s in words)
                {
                    if (s == "0")
                    {
                        spokenLanguageOptions.Items[0].Selected = true;
                    }
                    else if (s == "1")
                    {
                        spokenLanguageOptions.Items[1].Selected = true;
                    }
                    else if (s == "2")
                    {
                        spokenLanguageOptions.Items[2].Selected = true;
                    }
                    else if (s == "3")
                    {
                        spokenLanguageOptions.Items[3].Selected = true;
                    }
                    else if (s == "4")
                    {
                        spokenLanguageOptions.Items[4].Selected = true;
                        spokenLanguageOtherstxt.Text = detail.spokenLanguageOtherstxt;
                    }
                }                
            }

            if (detail.writtenLanguage != null)
            {
                string writtenLanguage = detail.writtenLanguage;

                char[] delimiterChars = { ',' };
                string[] words = writtenLanguage.Split(delimiterChars);

                foreach (string s in words)
                {
                    if (s == "0")
                    {
                        writtenLanguageOptions.Items[0].Selected = true;
                    }
                    else if (s == "1")
                    {
                        writtenLanguageOptions.Items[1].Selected = true;
                    }
                    else if (s == "2")
                    {
                        writtenLanguageOptions.Items[2].Selected = true;
                    }
                    else if (s == "3")
                    {
                        writtenLanguageOptions.Items[3].Selected = true;
                    }
                    else if (s == "4")
                    {
                        writtenLanguageOptions.Items[4].Selected = true;
                        writtenLanguageOtherstxt.Text = detail.writtenLanguageOtherstxt;
                    }
                }
            }            

            accompanyQuestion.SelectedValue = (detail.accompanyQuestion == null || detail.accompanyQuestion == "") ? "1" : detail.accompanyQuestion;
            TrustedIndividualName.Text = (detail.trustedIndividualName == null || detail.trustedIndividualName == "") ? "" : detail.trustedIndividualName;
            ClientRelationship.Text = (detail.clientRelationship == null || detail.clientRelationship == "") ? "" : detail.clientRelationship;
            NRICAccompany.Text = (detail.NRICAccompany == null || detail.NRICAccompany == "") ? "" : detail.NRICAccompany;
            //NoAccompaniedIndividualReason.Text = (detail.noAccompaniedIndividualReason == null || detail.noAccompaniedIndividualReason == "") ? "" : detail.noAccompaniedIndividualReason; 

            string strCaseid = "";
            if (ViewState["caseId"] != null)
            {
                activityId.Value = ViewState["caseId"].ToString();
                strCaseid = ViewState["caseId"].ToString();
            }

            if (detail.familyMemberDetails != null || detail.familyMemberDetails.Count > 0)
            {
                membernumber.Value = detail.familyMemberDetails.Count.ToString();
                this.personalDetailsOtherRepeater.DataSource = detail.familyMemberDetails;
                this.personalDetailsOtherRepeater.DataBind();
            }

            string strActivity = "";
            if (ViewState["activity"] != null)
            {
                strActivity = ViewState["activity"].ToString();
            }
            activitystatus act = activityStatusDao.getActivityForCaseid(strCaseid, strActivity);

            if (act != null)
            {
                List<string> errors = printErrorMessages(detail);
                this.ErrorRepeater.DataSource = errors;
                this.ErrorRepeater.DataBind();
            }

        }

        protected void printpg(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseId"] != null)
            {
                caseId = ViewState["caseId"].ToString();
            }
            sendPdf = true;
            savePersonaldetails(null, null);

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
        
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            savePersonaldetails(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void savePersonaldetailsAndBack(object sender, EventArgs e)
        {
            sendPdf = false;
            savePersonaldetails(null, null);
            string url = MenuResolution.getUrl("zurichAdvisor");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);

        }


        protected void savePersonaldetailsAndNext(object sender, EventArgs e)
        {
            sendPdf = false;
            savePersonaldetails(null, null);
            string url = MenuResolution.getUrl("priorityDetails");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        public personaldetail copyPersonalDetail(personaldetail detail)
            {

                detail.name = name.Text;
                detail.surname = surname.Text;
                detail.title= titleList.Text;
                detail.gender = genderList.Text;
                detail.nric = nric.Text;
                detail.nationality = nationalityList.Text;
                detail.nationalityothers = nationalityOthers.Text;
                
                if ((datepicker.Text != null) && (datepicker.Text != ""))
                {
                    detail.datepicker = datepicker.Text;
                }
                else
                    detail.datepicker = "";

                detail.maritalstatus= maritalList.SelectedValue;
                detail.address = address.Text;
                detail.employmentstatus = employmentList.SelectedValue;
                detail.occupation = occupation.Text;
                detail.companyname = companyName.Text;
                detail.contactnumber = contactNumber.Text;
                detail.contactnumberoffice = contactNumberOffice.Text;
                detail.contactnumberhp = contactNumberHp.Text;
                detail.contactnumberoffice = contactNumberOffice.Text;
                detail.contactnumberhp = contactNumberHp.Text;
                detail.contactnumberfax = contactNumberFax.Text;
                detail.email = emailId.Text;
                detail.issmoker = smokerList.Text;
                detail.educationlevel = educationList.SelectedValue;
                detail.medicalcondition = medicalList.SelectedValue;
                detail.medicalconditiondetails = medicalConditions.Text;
                detail.nominee = nomineeList.SelectedValue;
                detail.will = willList.SelectedValue;
                detail.familyDetailsRequired = FamilyDetailsRequired.SelectedValue;                
                
                string spokenLang = "";
                if (spokenLanguageOptions.Items[0].Selected == true)
                {
                    spokenLang += "0";
                    spokenLang += ",";
                }
                if (spokenLanguageOptions.Items[1].Selected == true)
                {
                    spokenLang += "1";
                    spokenLang += ",";
                }
                if (spokenLanguageOptions.Items[2].Selected == true)
                {
                    spokenLang += "2";
                    spokenLang += ",";
                }
                if (spokenLanguageOptions.Items[3].Selected == true)
                {
                    spokenLang += "3";
                    spokenLang += ",";
                }
                if (spokenLanguageOptions.Items[4].Selected == true)
                {
                    spokenLang += "4";                    
                }
                detail.spokenLanguage = spokenLang;
                detail.spokenLanguageOtherstxt = spokenLanguageOtherstxt.Text;

                string writtenLang = "";
                if (writtenLanguageOptions.Items[0].Selected == true)
                {
                    writtenLang += "0";
                    writtenLang += ",";
                }
                if (writtenLanguageOptions.Items[1].Selected == true)
                {
                    writtenLang += "1";
                    writtenLang += ",";
                }
                if (writtenLanguageOptions.Items[2].Selected == true)
                {
                    writtenLang += "2";
                    writtenLang += ",";
                }
                if (writtenLanguageOptions.Items[3].Selected == true)
                {
                    writtenLang += "3";
                    writtenLang += ",";
                }
                if (writtenLanguageOptions.Items[4].Selected == true)
                {
                    writtenLang += "4";
                }
                
                detail.writtenLanguage = writtenLang;
                detail.writtenLanguageOtherstxt = writtenLanguageOtherstxt.Text;

                detail.accompanyQuestion = accompanyQuestion.Text;
                detail.trustedIndividualName = TrustedIndividualName.Text;
                detail.clientRelationship = ClientRelationship.Text;
                detail.NRICAccompany = NRICAccompany.Text;
                //detail.noAccompaniedIndividualReason = NoAccompaniedIndividualReason.Text;
                         
                int noofmember = 0;
                if (membernumber.Value != "")
                {
                    noofmember = Int16.Parse(membernumber.Value);
                }

                EntitySet<familyMemberDetail> membersList = new EntitySet<familyMemberDetail>();
                if ((noofmember > 0) && (FamilyDetailsRequired.SelectedValue == "1"))
                {
                    for (int i = 1; i <= noofmember; i++)
                    {
                        if (Request.Form["membername-" + i] != null)
                        {
                            familyMemberDetail member = new familyMemberDetail();
                            member.name = Request.Form["membername-" + i];
                            member.occupation = Request.Form["memberoccupation-" + i];
                            member.relationship = Request.Form["memberrel-" + i];
                            if ((Request.Form["memberyrssupport-" + i] != null) && (Request.Form["memberyrssupport-" + i] != ""))
                                member.yrstosupport = Int16.Parse(Request.Form["memberyrssupport-" + i]);
                            member.dob = Request.Form["datepicker-" + i];

                            if (Request.Form["monthlyIncome-" + i] != null && Request.Form["monthlyIncome-" + i] != "")
                            {
                                member.monthlyIncome = Request.Form["monthlyIncome-" + i];
                            }
                            else
                            {
                                member.monthlyIncome = "0";
                            }
                            
                            membersList.Add(member);
                        }
                    }
                    detail.familyMemberDetails = membersList;
                }

                if (detail.accompanyQuestion == "0")
                {
                    detail.trustedIndividualName = "";
                    detail.clientRelationship = "";
                    detail.NRICAccompany = "";
                }
                return detail;
            }


        protected void savePersonaldetails(object sender, EventArgs e)
        {
            string caseId= (string)ViewState["caseId"];
            PersonalDetailsDAO dao = new PersonalDetailsDAO();
            personaldetail detail = dao.getPersonalDetail(caseId);

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }

            personaldetail returnDetail = new personaldetail();
            if (detail != null)
            {
                copyPersonalDetail(detail);
               detail= dao.updatePersonalDetails(detail);

            }
            else
            {
                detail = new personaldetail();
                detail.caseid = caseId;
                copyPersonalDetail(detail);
                try
                {
                    dao.savePersonalDetails(detail);
                    lblPersonalDetailSuccess.Visible = true;
                }
                catch (Exception ex)
                {
                    lblPersonalDetailFailed.Visible = true;
                    throw ex;
                }
            }

            string status = activityStatusCheck.getPersonalDetailStatus(detail);
            activityStatusDao.saveOrUpdateActivityStatus(caseId, actv, status);

            markStatusOnTab(caseId);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseId);
            casestatuslbl.Visible = false;
            casestatuslbl.Text = "zplan status: " + caseStatus;
            
            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            //try
            //{
                
            //    GeneratePdf genPdf = new GeneratePdf();
            //    MemoryStream output = genPdf.createPdf(caseId, url);
            //    pdfData = output.ToArray();
            //}
            //catch (Exception ex)
            //{
            //    throw;
            //}
            
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseId, caseStatus, url, sendPdf);
            /*if (st == 1)
            {
                lblStatusSubmitted.Visible = false;
            }
            else
            {
                lblStatusSubmissionFailed.Visible = true;
            }*/

            populatePersonalDetails(detail);

        }


        public List<string> printErrorMessages(personaldetail personalDetails)
        {
            List<string> list = new List<string>();

            Utility.checkEmptyField(personalDetails.title, list, "Title is Required");
            Utility.checkEmptyField(personalDetails.name, list, "Name is Required");
            Utility.checkEmptyField(personalDetails.gender, list, "Gender is Required");
            Utility.checkEmptyField(personalDetails.nric, list, "NRIC is Required");
            Utility.checkEmptyField(personalDetails.surname, list, "Surname is Required");
            Utility.checkEmptyField(personalDetails.nationality, list, "Nationality is Required");
            Utility.checkEmptyField(personalDetails.datepicker, list, "Date Of Birth is Required");
            Utility.checkEmptyField(personalDetails.maritalstatus, list, "Marital Status is Required");
            Utility.checkEmptyField(personalDetails.issmoker, list, "Is Smoker is Required");
            Utility.checkEmptyField(personalDetails.address, list, "Address is Required");
            Utility.checkEmptyField(personalDetails.employmentstatus, list, "Employment Status is Required");
            Utility.checkEmptyField(personalDetails.occupation, list, "Occupation is Required");
            Utility.checkEmptyField(personalDetails.companyname, list, "Company Name is Required");

            if (
                (personalDetails.contactnumber == null || personalDetails.contactnumber == "")&&
                (personalDetails.contactnumberfax == null || personalDetails.contactnumberfax == "")&&
                (personalDetails.contactnumberhp == null || personalDetails.contactnumberhp == "")&&
                (personalDetails.contactnumberoffice == null || personalDetails.contactnumberoffice == "")
                )
                list.Add("Contact Number is Required");

            Utility.checkEmptyField(personalDetails.email, list, "Email is Required");
            Utility.checkEmptyField(personalDetails.educationlevel, list, "Education Level is Required");
            Utility.checkEmptyField(personalDetails.medicalcondition, list, "Medical Level is Required");
            Utility.checkEmptyField(personalDetails.nominee, list, "CPF Nominee is Required");
            Utility.checkEmptyField(personalDetails.will, list, "Will Details is Required");
            
            if (personalDetails.medicalcondition == "Yes")
            {
                Utility.checkEmptyField(personalDetails.medicalconditiondetails, list, "Medical Condition Details is Required");
            }

            if (personalDetails.familyMemberDetails != null && FamilyDetailsRequired.SelectedValue == "1")
            {
                foreach (familyMemberDetail fmd in personalDetails.familyMemberDetails)
                {
                    Utility.checkEmptyField(fmd.name, list, "Family Name is Required");

                    Utility.checkEmptyField(fmd.occupation, list, "Family Member Occupation is Required");

                    Utility.checkEmptyField(fmd.yrstosupport + "", list, "Family Member Years to Support is Required");

                    Utility.checkEmptyField(fmd.dob, list, "Family Member Date of Birth is Required");

                    Utility.checkEmptyField(fmd.monthlyIncome, list, "Family Member Monthly Income is Required");

                    Utility.checkEmptyField(fmd.relationship, list, "Family Member Relationship is Required");

                }
            }

            //Validate Spoken Language Entries
            int selectedCnt = 0;
            if (spokenLanguageOptions.Items[0].Selected == true || spokenLanguageOptions.Items[1].Selected == true ||
                spokenLanguageOptions.Items[2].Selected == true || spokenLanguageOptions.Items[3].Selected == true ||
                spokenLanguageOptions.Items[4].Selected == true)
            {
                selectedCnt += 1;
            }

            if (selectedCnt == 0)
            {
                list.Add("Please choose atleast One Spoken Language");
            }

            if (spokenLanguageOptions.Items[4].Selected == true)
            {
                Utility.checkEmptyField(personalDetails.spokenLanguageOtherstxt, list, "Please enter Other type of Spoken Language");
            }

            //Validate Written Language Entries
            selectedCnt = 0;
            if (writtenLanguageOptions.Items[0].Selected == true || writtenLanguageOptions.Items[1].Selected == true ||
                writtenLanguageOptions.Items[2].Selected == true || writtenLanguageOptions.Items[3].Selected == true ||
                writtenLanguageOptions.Items[4].Selected == true)
            {
                selectedCnt += 1;
            }

            if (selectedCnt == 0)
            {
                list.Add("Please choose atleast One Written Language");
            }

            if (writtenLanguageOptions.Items[4].Selected == true)
            {
                Utility.checkEmptyField(personalDetails.writtenLanguageOtherstxt, list, "Please enter Other type of Written Language");
            }

            if (personalDetails.accompanyQuestion != null && accompanyQuestion.SelectedValue == "1")
            {
                 Utility.checkEmptyField(personalDetails.trustedIndividualName, list, "Name of Trusted Individual is Required");
                 Utility.checkEmptyField(personalDetails.clientRelationship, list, "Relationship to Client is Required");
                 Utility.checkEmptyField(personalDetails.NRICAccompany, list, "NRIC No. is Required for Trusted Individual");
            }

            //if (accompanyQuestion.SelectedValue == "0")
            //{
            //    Utility.checkEmptyField(personalDetails.noAccompaniedIndividualReason, list, "Please enter Why you don't like to be accompanied by a Trusted Individual?");
            //}

            return list;
        }

        protected void redirectToCasePortal(object sender, EventArgs e)
        {
            string salesPortalRedirectUrl = "";
            string caseid = "";
            if (ViewState["caseId"] != null)
            {
                caseid = ViewState["caseId"].ToString();
            }


            string toPrintPdf = backToCase.Value;

            if (toPrintPdf == "true")
            {
                sendPdf = true;
            }
            else
            {
                sendPdf = false;
            }

            savePersonaldetails(null, null);
            
            salesportalinfo salesPortalInfo = activityStatusDao.getSalesPortalInfoForCaseid(caseid);
            if (salesPortalInfo != null)
            {
                salesPortalRedirectUrl = salesPortalInfo.salesportalurl;
            }

            Response.Redirect(salesPortalRedirectUrl);   
        }

        protected void markStatusOnTab(string caseid)
        {
            if (caseid != null && caseid != "")
            {
                activitystatus activityStatusPerdet = null;
                activitystatus activityStatusPrDet = null;
                activitystatus activityStatusAssetLiab = null;
                activitystatus activityStatusIncomeExpense = null;
                activitystatus activityStatusMza = null;

                activityStatusPerdet = activityStatusDao.getActivityForCaseid(caseid, "personaldetail");
                if (activityStatusPerdet != null)
                {
                    if (activityStatusPerdet.status == "incomplete")
                    {
                        personaldetailstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        personaldetailstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusPrDet = activityStatusDao.getActivityForCaseid(caseid, "prioritydetail");
                if (activityStatusPrDet != null)
                {
                    if (activityStatusPrDet.status == "incomplete")
                    {
                        prioritydetailstab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        prioritydetailstab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusAssetLiab = activityStatusDao.getActivityForCaseid(caseid, "assetliability");
                if (activityStatusAssetLiab != null)
                {
                    if (activityStatusAssetLiab.status == "incomplete")
                    {
                        assetliabilitytab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        assetliabilitytab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusIncomeExpense = activityStatusDao.getActivityForCaseid(caseid, "incomeexpense");
                if (activityStatusIncomeExpense != null)
                {
                    if (activityStatusIncomeExpense.status == "incomplete")
                    {
                        incomeexpensetab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        incomeexpensetab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }

                activityStatusMza = activityStatusDao.getActivityForCaseid(caseid, "myzurichadviser");
                if (activityStatusMza != null)
                {
                    if (activityStatusMza.status == "incomplete")
                    {
                        mzatab.Attributes["class"] = "chassis_application_page_warnings";
                    }
                    else
                    {
                        mzatab.Attributes["class"] = "chassis_application_page_complete";
                    }
                }
            }
            
        }

    }
}
