using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;
using System.Collections.Generic;
using System.Collections.Specialized;
using DAO;
using ActivityStatusCheck;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zurich.ControlTemplates.Zurich;
using System.IO;
using PDFGeneration;
using ActivityStatusCheck.BusinessService;

namespace Zurich.Layouts.Zurich.MyZurichAdvisor
{
    public partial class MyZurichAdvisor : LayoutsPageBase
    {
        protected string caseid = "";
        protected MyZurichAdviserDAO mzaDao = new MyZurichAdviserDAO();
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

            FNAMenu menu = (FNAMenu)this.FNAMenu1;

            menu.EventClick += new EventHandler(WebForm_EventClick);
        }

        private void WebForm_EventClick(object sender, EventArgs e)
        {
            SampleEvent even = (SampleEvent)e;
            string toLink = "";
            if (even != null)
                toLink = even.toLink;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            submitMza(null, null);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblStatusSubmissionFailed.Visible = false;
            lblStatusSubmitted.Visible = false;
            lblZurichAdvFailed.Visible = false;
            lblZurichAdvSuccess.Visible = false;

            activity = activityStatusDao.getActivity(13);
            ViewState["activity"] = activity;

            ZPlanResponseDataContract zPlanResponse = null;
            string clonedFrom = "";

            if (!IsPostBack)
            {

                /*string nextCaseId = Request.Form["caseid"];
                string menuCaseId = Request.QueryString["caseid"];

                if (nextCaseId != null && nextCaseId != "")
                {
                    caseid = nextCaseId;
                }

                if (menuCaseId != null && menuCaseId != "")
                {
                    caseid = menuCaseId;
                }*/

                string activityID = string.Empty;

                string country = string.Empty;
                if (Request.Form["Country"] != null)
                {
                    country = Request.Form["Country"].ToString();
                }

                string salesChannel = string.Empty;
                if (Request.Form["SalesChannel"] != null)
                {
                    salesChannel = Request.Form["SalesChannel"].ToString();
                }

                if (Request.Form["ActivityID"] != null)
                {
                    activityID = Request.Form["ActivityID"].ToString();
                    //activityID = "1500";

                    ZPlanDataContract zPlanContract = new ZPlanDataContract();
                    zPlanContract.ActivityId = activityID;
                    zPlanContract.Activity = ActivityTypeEnum.ZPlan;
                    zPlanContract.Action = ActionEnumContracts.View;
                    UserInfoEntity ufo = new UserInfoEntity();
                    ufo.Country = country;
                    ufo.RoleType = salesChannel;
                    zPlanContract.UserInfo = ufo;
                    zPlanResponse = new ZPlanResponseDataContract();

                    try
                    {
                        BusinessServiceClient client = new BusinessServiceClient();
                        client.ClientCredentials.Windows.AllowedImpersonationLevel =
                            System.Security.Principal.TokenImpersonationLevel.Impersonation;
                        zPlanResponse = client.ManageZPlan(zPlanContract);

                        if (zPlanResponse != null)
                        {
                            salesportalinfo salesPortalDto = new salesportalinfo();
                            salesPortalDto.activityid = activityID;
                            salesPortalDto.activitytype = zPlanResponse.ActivityType;
                            salesPortalDto.caseid = zPlanResponse.CaseId;
                            salesPortalDto.redirecturl = zPlanResponse.RedirectUrl;
                            salesPortalDto.roletype = zPlanResponse.RoleType;
                            salesPortalDto.salesportalurl = zPlanResponse.SalesPortalUrl;
                            salesPortalDto.userfirstname = zPlanResponse.UserFirstName;
                            salesPortalDto.userid = zPlanResponse.UserId;
                            salesPortalDto.userlastname = zPlanResponse.UserLastName;
                            salesPortalDto.usertype = zPlanResponse.UserType;
                            salesPortalDto.casestatus = zPlanResponse.CaseStatus;
                            salesPortalDto.country = country;
                            salesPortalDto.saleschannel = salesChannel;
                            activityStatusDao.saveSalesPortalInfo(activityID, salesPortalDto);

                            caseid = zPlanResponse.ActivityId;

                            //check if ClonedFrom is sent from portal
                            if (zPlanResponse.ClonedFrom != null && zPlanResponse.ClonedFrom != "")
                            {
                                clonedFrom = zPlanResponse.ClonedFrom;

                                //check if case has been cloned earlier
                                clonemappingid clonemapping = activityStatusDao.getCloneMappingForCaseid(clonedFrom, zPlanResponse.ActivityId);

                                if (clonemapping == null)
                                {
                                    //if the case is not cloned, add entry in the clone mapping table and clone the case
                                    clonemapping = new clonemappingid();
                                    clonemapping.clonedfrom = clonedFrom;
                                    clonemapping.newid = zPlanResponse.ActivityId;
                                    activityStatusDao.saveClonemapping(clonemapping);

                                    activityStatusDao.cloneCase(clonedFrom, zPlanResponse.ActivityId);
                                }
                                
                            }
                            
                        }
                    }
                    catch (Exception ex)
                    {
                        //log exception to db
                        exceptionlog exLog = new exceptionlog();
                        exLog.message = ex.Message + " class: MyZurichAdviser Method: Page_Load";
                        exLog.source = ex.Source;
                        
                        string strtmp = ex.StackTrace;
                        strtmp = strtmp.Replace('\r', ' ');
                        strtmp = strtmp.Replace('\n', ' ');
                        exLog.stacktrace = strtmp;
                        
                        exLog.targetsitename = ex.TargetSite.Name;

                        activityStatusDao.logException(exLog);
                    }
                    
                }
                else
                {
                    string backCaseId = Request.Form["caseid"];
                    string menuCaseId = Request.QueryString["caseid"];

                    if (backCaseId != null && backCaseId != "")
                    {
                        caseid = backCaseId;
                    }
                    else if (menuCaseId != null && menuCaseId != "")
                    {
                        caseid = menuCaseId;
                    }
                    else if (Session["fnacaseid"] != null)
                    {
                        caseid = Session["fnacaseid"].ToString();
                    } 
                    else
                    {
                        caseid = "2040";
                    }
                    
                }
                         
                activityId.Value = caseid;
                PersonalDetailsDAO dao = new PersonalDetailsDAO();
                personaldetail detail = dao.getPersonalDetail(caseid);

                if (detail != null)
                {
                    if (zPlanResponse != null)
                    {
                        detail.datepicker = zPlanResponse.Dob;
                        detail.gender = zPlanResponse.Gender;
                        //detail.maritalstatus = zPlanResponse.MaritalStatus;
                        detail.name = zPlanResponse.UserFirstName;
                        detail.surname = zPlanResponse.UserLastName; 
                        detail.nationality = zPlanResponse.Nationality;
                        detail.nric = zPlanResponse.NricOrPassport;
                        detail.occupation = zPlanResponse.Occupation;
                        if (zPlanResponse.Smoker)
                        {
                            detail.issmoker = "Yes";
                        }
                        else
                        {
                            detail.issmoker = "No";
                        }
                        detail.title = zPlanResponse.Title;
                    }

                    dao.updatePersonalDetails(detail);
                }
                else
                {
                    detail = new personaldetail();
                    detail.caseid = caseid;
                    
                    if (zPlanResponse != null)
                    {
                        detail.datepicker = zPlanResponse.Dob;
                        detail.gender = zPlanResponse.Gender;
                        //detail.maritalstatus = zPlanResponse.MaritalStatus;
                        detail.name = zPlanResponse.UserFirstName;
                        detail.surname = zPlanResponse.UserLastName;
                        detail.nationality = zPlanResponse.Nationality;
                        detail.nric = zPlanResponse.NricOrPassport;
                        detail.occupation = zPlanResponse.Occupation;
                        if (zPlanResponse.Smoker)
                        {
                            detail.issmoker = "Yes";
                        }
                        else
                        {
                            detail.issmoker = "No";
                        }
                        detail.title = zPlanResponse.Title;
                    }
                    dao.savePersonalDetails(detail);
                }

                if (caseid != "")
                {
                    ViewState["caseid"] = caseid;

                    List<myzurichadviser> savedMzaoptions = mzaDao.getMza(caseid);

                    if (savedMzaoptions != null && savedMzaoptions.Count>0)
                    {
                        ViewState["casetype"] = "update";
                    }
                    else
                    {
                        ViewState["casetype"] = "new";
                        savedMzaoptions = new List<myzurichadviser>();
                        myzurichadviser mzadv = new myzurichadviser();
                        mzadv.caseid = caseid;
                        mzadv.selectedoptionid = 1;
                        savedMzaoptions.Add(mzadv);

                        mzadv = new myzurichadviser();
                        mzadv.caseid = caseid;
                        mzadv.selectedoptionid = 2;
                        savedMzaoptions.Add(mzadv);
                    }

                    populateMzaoptions(savedMzaoptions, caseid);

                }

            }
            markStatusOnTab(caseid);
        }

        protected void populateMzaoptions(List<myzurichadviser> savedMzaoptions, string caseid)
        {
            if (savedMzaoptions!=null && savedMzaoptions.Count>0)
            {
                foreach (myzurichadviser m in savedMzaoptions)
                {
                    for (int i = 0; i < mzaoptions.Items.Count; i++)
                    {
                        if (mzaoptions.Items[i].Value == m.selectedoptionid.Value.ToString())
                        {
                            mzaoptions.Items[i].Selected = true;
                            if (m.selectedoptionid.Value == mzaoptions.Items.Count)
                            {
                                otherstxt.Visible = true;
                                otherstxt.Text = m.selectedoptionothers;
                            }
                        }
                    }
                }
            }

            List<string> errors = printErrorMessages(savedMzaoptions);
            this.ErrorRepeater.DataSource = errors;
            this.ErrorRepeater.DataBind();

            activityId.Value = caseid;
            
        }

        protected void createMzaPdf(object sender, EventArgs e)
        {
            string caseId = "";
            if (ViewState["caseid"] != null)
            {
                caseId = ViewState["caseid"].ToString();
            }

            sendPdf = true;
            submitMza(null, null);

            //test pdf
            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            GeneratePdf genPdf = new GeneratePdf();
            MemoryStream output = genPdf.createPdf(caseId, url);
            pdfData = output.ToArray();

            if (pdfData != null && pdfData.Length > 0)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("attachment;filename=ZPlan.pdf"));
                Response.BinaryWrite(pdfData);
            }
            
        }

        protected void submitMza(object sender, EventArgs e)
        {
            List<myzurichadviser> mzaOptions = new List<myzurichadviser>();

            string caseid = "";
            if(ViewState["caseid"]!=null)
            {
                caseid = ViewState["caseid"].ToString();
            }

            string actv = "";
            if (ViewState["activity"] != null)
            {
                actv = ViewState["activity"].ToString();
            }
            
            for (int i = 0; i < mzaoptions.Items.Count; i++)
            {
                if (mzaoptions.Items[i].Selected)
                {
                    myzurichadviser mz = new myzurichadviser();
                    mz.caseid = caseid;
                    mz.selectedoptionid = Int32.Parse(mzaoptions.Items[i].Value);

                    if ((i == mzaoptions.Items.Count-1) && mzaoptions.Items[i].Selected)
                    {
                        mz.selectedoptionothers = otherstxt.Text;
                    }

                    mzaOptions.Add(mz);
                }
            }

            if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "new")
            {
                mzaOptions = mzaDao.saveMza(mzaOptions);
            }
            else if (ViewState["casetype"] != null && ViewState["casetype"].ToString() == "update")
            {
                mzaOptions = mzaDao.updateMza(mzaOptions, caseid);
            }

            string status = activityStatusCheck.getMzaStatus(mzaOptions);
            activityStatusDao.saveOrUpdateActivityStatus(caseid, actv, status);

            markStatusOnTab(caseid);

            string caseStatus = activityStatusCheck.getZPlanStatus(caseid);

            string url = Server.MapPath("~/_layouts/Zurich/Printpages/");
            pdfData = activityStatusCheck.sendDataToSalesPortal(caseid, caseStatus, url, sendPdf);
            
            /*if (st == 1)
            {
                lblStatusSubmitted.Visible = false;
            }
            else
            {
                lblStatusSubmissionFailed.Visible = true;
            }*/

            if (mzaOptions != null)
            {
                lblZurichAdvSuccess.Visible = true;
                populateMzaoptions(mzaOptions, caseid);
            }
            else
            {
                lblZurichAdvFailed.Visible = true;
            }
        }

        protected void menuClick(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string toLink = btn.CommandArgument;
            string url = MenuResolution.getUrl(toLink);
            sendPdf = false;
            submitMza(null, null);
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, url, data);*/
        }

        
        protected void submitMzaNext(object sender, EventArgs e)
        {
            sendPdf = false;
            submitMza(null, null);
            string url = MenuResolution.getUrl("personalDetail");
            Session["fnacaseid"] = activityId.Value;
            Response.Redirect(url);
            /*NameValueCollection data = new NameValueCollection();
            data.Add("caseid", activityId.Value);
            HttpHelper.RedirectAndPOST(this.Page, "/_layouts/Zurich/PersonalDetails.aspx", data);*/
        }

        protected void mzaoption_selected(object sender, EventArgs e)
        {
            int othersValue = mzaoptions.Items.Count;
            if (mzaoptions.Items[othersValue-1].Selected)
            {
                otherstxt.Visible = true;
            }
            else
            {
                otherstxt.Visible = false;
            }
        }

        protected void redirectToCasePortal(object sender, EventArgs e)
        {
            string salesPortalRedirectUrl = "";
            string caseid = "";

            if (ViewState["caseid"] != null)
            {
                caseid = ViewState["caseid"].ToString();
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

            submitMza(null, null);
            
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

        public List<string> printErrorMessages(List<myzurichadviser> savedMzaoptions)
        {
            List<string> list = new List<string>();

            if (savedMzaoptions == null || savedMzaoptions.Count == 0)
            {
                list.Add("At least one option needs to be selected");
            }
            else
            {
                foreach (myzurichadviser m in savedMzaoptions)
                {
                    for (int i = 0; i < mzaoptions.Items.Count; i++)
                    {
                        if (mzaoptions.Items[i].Value == m.selectedoptionid.Value.ToString())
                        {
                            if (m.selectedoptionid.Value == mzaoptions.Items.Count && (m.selectedoptionothers == null || m.selectedoptionothers == ""))
                            {
                                list.Add("Others is Required");
                                break;
                            }
                        }
                    }
                }
            }

            return list;
        }

    }
}
