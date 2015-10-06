using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;
using System.IO;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text;
using iTextSharp.text.pdf;
using DAO;
using DAO.DTO;
using System.Data;
using System.Drawing;
using System.Diagnostics;
using System.Threading;

namespace PDFGeneration
{
    public class GeneratePdf
    {
        public static string baseUrl = "";
        
        public Boolean doLog = false;
        ActivityStatusDAO activityStatus;

        public static StyleSheet styles;
        public static iTextSharp.text.Font sectionTitleVerdana;
        public static iTextSharp.text.Font headerTitleArial;

        public static Boolean stylesGenerated = false;

        public static PdfBorderDictionary dictionary;

        public static string grayGradientFilePath;
        public static iTextSharp.text.Image grayGradientHeader;

        public static string personalAdvisorFilePath;
        public static iTextSharp.text.Image personalAdvisorHeader;

        public static string personalDetailFilePath;
        public static iTextSharp.text.Image personalDetailHeader;

        public static string prioritiesFilePath;
        public static iTextSharp.text.Image prioritiesHeader;

        public static string currentlyHaveFilePath;
        public static iTextSharp.text.Image currentlyHaveHeader;

        public static string familyNeedFilePath;
        public static iTextSharp.text.Image familyNeedHeader;

        public static string iNeedFilePath;
        public static iTextSharp.text.Image iNeedHeader;

        public static string workHarderFilePath;
        public static iTextSharp.text.Image workHarderHeader;


        public static string riskProfileFilePath;
        public static iTextSharp.text.Image riskProfileHeader;

        public static string investmentFilePath;
        public static iTextSharp.text.Image investmentHeader;

        public static string portfolioBuilderFilePath;
        public static iTextSharp.text.Image portfolioBuilderHeader;

        public static string fundSelectionFilePath;
        public static iTextSharp.text.Image fundSelectionHeader;

        public static string myGapFilePath;
        public static iTextSharp.text.Image myGapHeader;

        public static string imageFilePath;
        public static iTextSharp.text.Image jpg;

        public static string blankImagePath;
        public static iTextSharp.text.Image blankJpg;

        public string caseId = "";

        public static string mza_Path = "";
        public static string personalDetail_Path = "";
        public static string priorityDetail_Path = "";
        public static string IncomeExpenseDetail_Path = "";
        public static string ProtectionGoal_Path = "";
        public static string ProtectionGoalMyNeeds_Path = "";
        public static string SavingGoal_Path = "";
        public static string EducationGoal_Path = "";
        public static string RiskProfile_Path = "";
        public static string CKA_Path = "";
        public static string PortfolioModel_Path = "";
        public static string GAPSummary_Path = "";
        public static string RetirementGoal_Path = "";
        public static string header_Path = "";
        public static string footer_Path = "";

        public string mzaContent = "";
        public string personalDetailsContent = "";
        public string priorityDetailsContent = "";
        public string incomeExpenseContent = "";
        public string assetLiabilityContent = "";
        public string pgFamilyNeedsContent = "";
        public string pgMyNeedsContent = "";
        public string sgContent = "";
        public string rgContent = "";
        public string egContent = "";
        public string riskProfileContent = "";
        public string portfolioModelContent = "";
        public string ckaContent = "";
        public string portfolioBuilderContent = "";
        public string gapSummaryContent = "";

        public List<IElement> mzaList = null;
        public List<IElement> personalDetailsList = null;
        public List<IElement> priorityDetailsList = null;
        public List<IElement> incomeExpenseAssetList = null;
        public List<IElement> pgFamilyNeedsList = null;
        public List<IElement> pgMyNeedsList = null;
        public List<IElement> sgList = null;
        public List<IElement> rgList = null;
        public List<IElement> egList = null;
        public List<IElement> riskProfileList = null;
        public List<IElement> portfolioModelList = null;
        public List<IElement> ckaList = null;
        public List<IElement> portfolioBuilderList = null;
        public List<IElement> gapSummaryList = null;

        public string removeLineBreak(string cont)
        {
            if (cont != null)
            {
                return cont.Replace("\r\n", "<br />");
            }
            else
                return "";     
        }


        public static void GenerateStyles(string url)
        {
            if (!stylesGenerated)
            {
                stylesGenerated = true;

                baseUrl = url;

                FontFactory.Register(baseUrl + "VERDANA.TTF", "verdana");
                FontFactory.Register(baseUrl + "times.ttf", "times_roman");

                styles = new StyleSheet();
                styles.LoadTagStyle("body", "face", "verdana");
                styles.LoadTagStyle("body", "size", "8pt");
                styles.LoadStyle("headerStyle", HtmlTags.BGCOLOR, "#003399");
                styles.LoadStyle("headerStyle", HtmlTags.FONTFAMILY, "verdana");
                styles.LoadStyle("headerStyle", HtmlTags.COLOR, "#FFF");
                styles.LoadStyle("headerStyle", "size", "8pt");
                styles.LoadStyle("headerStyle", HtmlTags.BORDER, ".5");

                styles.LoadStyle("sectionTitleStyle", "font-family", "verdana");
                styles.LoadStyle("sectionTitleStyle", HtmlTags.COLOR, "#003399");
                styles.LoadStyle("sectionTitleStyle", "size", "10pt");
                styles.LoadStyle("sectionTitleStyle", "font-weight", "bold");
                styles.LoadStyle("sectionTitleStyle", HtmlTags.BORDER, "0");


                styles.LoadStyle("borderRow", HtmlTags.BORDER, ".5");
                styles.LoadStyle("noBorderRow", HtmlTags.BORDER, "0");

                styles.LoadStyle("tableStyle", HtmlTags.BGCOLOR, "#DDDDDD");

                styles.LoadStyle("tableHeaderStyle", HtmlTags.FONTFAMILY, "verdana");
                styles.LoadStyle("tableHeaderStyle", HtmlTags.BORDER, ".5");
                styles.LoadStyle("tableHeaderStyle", HtmlTags.BGCOLOR, "#003399");
                styles.LoadStyle("tableHeaderStyle", HtmlTags.COLOR, "#FFF");

                styles.LoadStyle("tableRowStyle", HtmlTags.BGCOLOR, "1");

                styles.LoadStyle("tableTotalRowStyle", HtmlTags.BGCOLOR, "#CCCCCC");

                styles.LoadStyle("tableRow1Style", HtmlTags.BORDER, ".5");
                styles.LoadStyle("tableRow1Style", HtmlTags.BGCOLOR, "#336699");
                styles.LoadStyle("tableRow1Style", HtmlTags.COLOR, "#FFF");

                styles.LoadStyle("simpletableStyle", HtmlTags.FONTFAMILY, "verdana");
                styles.LoadStyle("simpletableStyle", HtmlTags.STYLE, "padding-left:10px");

                styles.LoadStyle("borderTableStyle", HtmlTags.BORDER, ".5");
                styles.LoadStyle("borderTableStyle", HtmlTags.FONTFAMILY, "verdana");
                styles.LoadStyle("borderTableStyle", HtmlTags.STYLE, "padding-left:10px");

                styles.LoadStyle("oddRowStyleNoBorder", HtmlTags.BGCOLOR, "#f0f0f6");
                styles.LoadStyle("oddRowStyleNoBorder", HtmlTags.BORDER, "0");
                styles.LoadStyle("evenRowStyleNoBorder", HtmlTags.BGCOLOR, "#ffffff");
                styles.LoadStyle("evenRowStyleNoBorder", HtmlTags.BORDER, "0");

                styles.LoadStyle("oddRowStyle", HtmlTags.BGCOLOR, "#f0f0f6");
                styles.LoadStyle("oddRowStyle", HtmlTags.BORDER, ".5");
                styles.LoadStyle("evenRowStyle", HtmlTags.BGCOLOR, "#ffffff");
                styles.LoadStyle("evenRowStyle", HtmlTags.BORDER, ".5");
                styles.LoadStyle("totalRowStyle", HtmlTags.BGCOLOR, "#CCCCCC");
                styles.LoadStyle("totalRowStyle", HtmlTags.BORDER, ".5");

                styles.LoadStyle("unusedCellStyle", HtmlTags.BGCOLOR, "#CCCCCC");
                styles.LoadStyle("unusedCellStyle", HtmlTags.BORDER, ".5");

                sectionTitleVerdana = FontFactory.GetFont("verdana", 8, new BaseColor(Color.FromArgb(00, 33, 99)));
                headerTitleArial = FontFactory.GetFont("Arial", 18, iTextSharp.text.Font.BOLD, BaseColor.WHITE);

                float t = 3F;
                int r = 1;
                dictionary = new PdfBorderDictionary(t, r);

                //Gray Gradient
                grayGradientFilePath = baseUrl + "GreyGradientBar.png";
                grayGradientHeader = iTextSharp.text.Image.GetInstance(grayGradientFilePath);
                grayGradientHeader.ScaleAbsolute(500, 40);
                grayGradientHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //MyPersonalAdvisor
                personalAdvisorFilePath = baseUrl + "Header/120911_bar_01.png";
                personalAdvisorHeader = iTextSharp.text.Image.GetInstance(personalAdvisorFilePath);
                personalAdvisorHeader.ScaleAbsolute(545, 84);
                personalAdvisorHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //PersonalDetail
                personalDetailFilePath = baseUrl + "Header/120911_bar_02.png";
                personalDetailHeader = iTextSharp.text.Image.GetInstance(personalDetailFilePath);
                personalDetailHeader.ScaleAbsolute(545, 84);
                personalDetailHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //MyPriorities
                prioritiesFilePath = baseUrl + "Header/120911_bar_03.png";
                prioritiesHeader = iTextSharp.text.Image.GetInstance(prioritiesFilePath);
                prioritiesHeader.ScaleAbsolute(545, 84);
                prioritiesHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //CurrentlyHave
                currentlyHaveFilePath = baseUrl + "Header/120911_bar_04.png";
                currentlyHaveHeader = iTextSharp.text.Image.GetInstance(currentlyHaveFilePath);
                currentlyHaveHeader.ScaleAbsolute(545, 84);
                currentlyHaveHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //FamilyNeed
                familyNeedFilePath = baseUrl + "Header/120911_bar_05.png";
                familyNeedHeader = iTextSharp.text.Image.GetInstance(familyNeedFilePath);
                familyNeedHeader.ScaleAbsolute(545, 84);
                familyNeedHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //INeed
                iNeedFilePath = baseUrl + "Header/120911_bar_06.png";
                iNeedHeader = iTextSharp.text.Image.GetInstance(iNeedFilePath);
                iNeedHeader.ScaleAbsolute(545, 84);
                iNeedHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //WorkHarder
                workHarderFilePath = baseUrl + "Header/120911_bar_07.png";
                workHarderHeader = iTextSharp.text.Image.GetInstance(workHarderFilePath);
                workHarderHeader.ScaleAbsolute(545, 84);
                workHarderHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //RiskProfile
                riskProfileFilePath = baseUrl + "Header/120911_bar_08.png";
                riskProfileHeader = iTextSharp.text.Image.GetInstance(riskProfileFilePath);
                riskProfileHeader.ScaleAbsolute(545, 84);
                riskProfileHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //investment
                investmentFilePath = baseUrl + "Header/120911_bar_09.png";
                investmentHeader = iTextSharp.text.Image.GetInstance(investmentFilePath);
                investmentHeader.ScaleAbsolute(545, 84);
                investmentHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //PortfolioBuilder
                portfolioBuilderFilePath = baseUrl + "Header/120911_bar_10.png";
                portfolioBuilderHeader = iTextSharp.text.Image.GetInstance(portfolioBuilderFilePath);
                portfolioBuilderHeader.ScaleAbsolute(545, 84);
                portfolioBuilderHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //FundSelection
                fundSelectionFilePath = baseUrl + "Header/120911_bar_11.png";
                fundSelectionHeader = iTextSharp.text.Image.GetInstance(fundSelectionFilePath);
                fundSelectionHeader.ScaleAbsolute(545, 84);
                fundSelectionHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                //MyGap
                myGapFilePath = baseUrl + "Header/120911_bar_12.png";
                myGapHeader = iTextSharp.text.Image.GetInstance(myGapFilePath);
                myGapHeader.ScaleAbsolute(545, 84);
                myGapHeader.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                imageFilePath = baseUrl + "ZurichLogo.png";
                jpg = iTextSharp.text.Image.GetInstance(imageFilePath);
                jpg.ScaleAbsolute(100, 72);
                jpg.Alignment = iTextSharp.text.Image.RIGHT_ALIGN;

                blankImagePath = baseUrl + "blank.png";
                blankJpg = iTextSharp.text.Image.GetInstance(blankImagePath);
                blankJpg.ScaleAbsolute(80, 20);
                blankJpg.Alignment = iTextSharp.text.Image.LEFT_ALIGN;

                mza_Path = readHTMLContent(baseUrl + "MzaPrint.html");
                personalDetail_Path = readHTMLContent(baseUrl + "PersonalDetailsPrint.html");
                priorityDetail_Path = readHTMLContent(baseUrl + "PriorityDetailsPrint.html");
                IncomeExpenseDetail_Path = readHTMLContent(baseUrl + "IncomeExpensePrint.html");
                ProtectionGoal_Path = readHTMLContent(baseUrl + "ProtectionGoalPrint.html");
                ProtectionGoalMyNeeds_Path = readHTMLContent(baseUrl + "ProtectionGoalMyNeedsPrint.html");
                SavingGoal_Path = readHTMLContent(baseUrl + "SavingsGoalPrint.html");
                EducationGoal_Path = readHTMLContent(baseUrl + "EducationGoalPrint.html");
                RiskProfile_Path = readHTMLContent(baseUrl + "RiskProfile.html");
                CKA_Path = readHTMLContent(baseUrl + "CkaPrint.html");
                PortfolioModel_Path = readHTMLContent(baseUrl + "PortFolioModelForRiskProfilePrint.html");
                GAPSummary_Path = readHTMLContent(baseUrl + "GAPSummary.html");
                RetirementGoal_Path = readHTMLContent(baseUrl + "RetirementGoalPrint.html");
                header_Path = readHTMLContent(baseUrl + "Header.html");
                footer_Path = readHTMLContent(baseUrl + "Footer.html");
            }
        }

        public void writeLog(ActivityStatusDAO dao, string module,string message,long timeElapsedMillis)
        {

            if (doLog==true)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = " Time Taken for generating -> "+module+" message ->"+message +"---> "+ timeElapsedMillis;
                dao.logException(exLog);
            }
        }

        public MemoryStream createPdf(string caseNumber, string url)
        {

            Stopwatch stpwatchOverall = Stopwatch.StartNew();
            activityStatus = new ActivityStatusDAO();
            caseId = caseNumber;
            baseUrl = url;
            GenerateStyles(url);

            Document document = new Document(PageSize.A4, 0, 50, 25, 45);

            MemoryStream output = new MemoryStream();
            PdfWriter writer = PdfWriter.GetInstance(document, output);
            writer.RgbTransparencyBlending = true;
            PageNumbersEventHelper pgNumber = new PageNumbersEventHelper();
            writer.PageEvent = pgNumber;
            document.Open();

            PdfShading shading = PdfShading.SimpleAxial(writer, 0, 700, 300, 700, BaseColor.BLUE, BaseColor.RED);

            //Create a pattern from our shading object
            PdfShadingPattern pattern = new PdfShadingPattern(shading);

            //Create a color from our patter
            ShadingColor color = new ShadingColor(pattern);

            Thread factFindThread = new Thread(pdfFactFind);
            Thread protectionGoalThread = new Thread(pdfProtectionGoals);
            Thread investmentGoalThread = new Thread(pdfInvestmentGoals);
            Thread riskProfileThread = new Thread(pdfRiskProfile);
            Thread pbGapThread = new Thread(pdfPBGapSummary);

            Stopwatch stpwtchthreads = Stopwatch.StartNew();
            factFindThread.Start();
            protectionGoalThread.Start();
            investmentGoalThread.Start();
            riskProfileThread.Start();
            pbGapThread.Start();

            factFindThread.Join();
            protectionGoalThread.Join();
            investmentGoalThread.Join();
            riskProfileThread.Join();
            pbGapThread.Join();
            stpwtchthreads.Stop();
            writeLog(activityStatus, "", "Time taken for all the threads", stpwtchthreads.ElapsedMilliseconds);

            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(personalAdvisorHeader);

            foreach (var htmlElement in mzaList)
            {
                document.Add(htmlElement as IElement);
            }
            
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(personalDetailHeader);

            foreach (var htmlElement in personalDetailsList)
            {
                document.Add(htmlElement as IElement);
            }
            
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(prioritiesHeader);

            foreach (var htmlElement in priorityDetailsList)
            {
                document.Add(htmlElement as IElement);
            }
            
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(currentlyHaveHeader);

            foreach (var htmlElement in incomeExpenseAssetList)
            {
                document.Add(htmlElement as IElement);
            }
            
			// For Protection Goals Screen
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(familyNeedHeader);

            foreach (var htmlElement in pgFamilyNeedsList)
            {
                document.Add(htmlElement as IElement);
            }
            
            // For Protection Goals My Needs Screen
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(iNeedHeader);

            foreach (var htmlElement in pgMyNeedsList)
            {
                document.Add(htmlElement as IElement);
            }
            
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(workHarderHeader);

            foreach (var htmlElement in sgList)
            {
                document.Add(htmlElement as IElement);
            }
            
            foreach (var htmlElement in egList)
            {
                document.Add(htmlElement as IElement);
            }
            
            foreach (var htmlElement in rgList)
            {
                document.Add(htmlElement as IElement);
            }
            
            // Risk Profile
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(riskProfileHeader);

            foreach (var htmlElement in riskProfileList)
            {
                document.Add(htmlElement as IElement);
            }
            
			// CKA Module
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(investmentHeader);

            foreach (var htmlElement in ckaList)
            {
                document.Add(htmlElement as IElement);
            }
            
            //Start of PortFolioModel
            string strRiskProfileName = string.Empty;
            strRiskProfileName = GetRiskProfileName(caseId);

            if (strRiskProfileName != string.Empty)
            {
                document.NewPage();
                document.Add(jpg);
                document.Add(blankJpg);
                document.Add(portfolioBuilderHeader);

                foreach (var htmlElement in portfolioModelList)
                {
                    document.Add(htmlElement as IElement);
                }
                
            }//End of PortFolioModel

            // For PortFolio Builder Screen
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(fundSelectionHeader);

            foreach (var htmlElement in portfolioBuilderList)
            {
                document.Add(htmlElement as IElement);
            }
            
            // For Gap Summary Screen
            document.NewPage();
            document.Add(jpg);
            document.Add(blankJpg);
            document.Add(myGapHeader);

            foreach (var htmlElement in gapSummaryList)
            {
                document.Add(htmlElement as IElement);
            }
            
            document.Close();

            stpwatchOverall.Stop();
            writeLog(activityStatus, "", "Time taken for complete PDF generation", stpwatchOverall.ElapsedMilliseconds);
            
            return output;
        }

        private void pdfFactFind()
        {
            //mza
            mzaContent += createHeader();
            mzaContent += createMzaPdf(caseId);
            mzaContent += createFooter();
            mzaList = HTMLWorker.ParseToList(new StringReader(mzaContent), styles);

            //personal details
            personalDetailsContent += createHeader();
            personalDetailsContent += createPersonalDetailPdf(caseId);
            personalDetailsContent += createFooter();
            personalDetailsList = HTMLWorker.ParseToList(new StringReader(personalDetailsContent), styles);

            //priority details
            priorityDetailsContent += createHeader();
            priorityDetailsContent += createPrioritiesPdf(caseId);
            priorityDetailsContent += createFooter();
            priorityDetailsList = HTMLWorker.ParseToList(new StringReader(priorityDetailsContent), styles);

            //income expense and asset liability
            incomeExpenseContent += createHeader();
            incomeExpenseContent += createIncomeAndExpensePdf(caseId);
            assetLiabilityContent = createAssetAndLiabilitiesPdf(caseId, incomeExpenseContent);
            assetLiabilityContent += createFooter();
            incomeExpenseAssetList = HTMLWorker.ParseToList(new StringReader(assetLiabilityContent), styles);
        }

        private void pdfProtectionGoals()
        {
            //family needs
            pgFamilyNeedsContent += createHeader();
            pgFamilyNeedsContent += createProtectionGoalsPDF(caseId);
            pgFamilyNeedsContent += createFooter();
            pgFamilyNeedsList = HTMLWorker.ParseToList(new StringReader(pgFamilyNeedsContent), styles);

            //my needs
            pgMyNeedsContent += createHeader();
            pgMyNeedsContent += createProtectionGoalsMyNeedsPDF(caseId);
            pgMyNeedsContent += createFooter();
            pgMyNeedsList = HTMLWorker.ParseToList(new StringReader(pgMyNeedsContent), styles);
        }

        private void pdfInvestmentGoals()
        {
            //saving goals
            sgContent += createHeader();
            sgContent += createSavingGoalsPdf(caseId);
            sgContent += createFooter();
            sgList = HTMLWorker.ParseToList(new StringReader(sgContent), styles);

            //education goals
            egContent += createHeader();
            egContent += createEducationGoalsPdf(caseId);
            egContent += createFooter();
            egList = HTMLWorker.ParseToList(new StringReader(egContent), styles);

            //retirement goals
            rgContent += createHeader();
            rgContent += createRetirementGoalsPdf(caseId);
            rgContent += createFooter();
            rgList = HTMLWorker.ParseToList(new StringReader(rgContent), styles);
        }

        private void pdfRiskProfile()
        {
            //risk profile
            riskProfileContent += createHeader();
            riskProfileContent += createRiskProfilePdf(caseId);
            riskProfileContent += createFooter();
            riskProfileList = HTMLWorker.ParseToList(new StringReader(riskProfileContent), styles);

            //portfolio model
            portfolioModelContent += createHeader();
            portfolioModelContent += createPortFolioModelPDF(caseId);
            portfolioModelContent += createFooter();
            portfolioModelList = HTMLWorker.ParseToList(new StringReader(portfolioModelContent), styles);

            //cka
            ckaContent += createHeader();
            ckaContent += createCkaPdf(caseId);
            ckaContent += createFooter();
            ckaList = HTMLWorker.ParseToList(new StringReader(ckaContent), styles);
        }

        private void pdfPBGapSummary()
        {
            //portfolio builder
            portfolioBuilderContent += createHeader();
            portfolioBuilderContent += createPortfolioBuilderPDF(caseId);
            portfolioBuilderContent += createFooter();
            portfolioBuilderList = HTMLWorker.ParseToList(new StringReader(portfolioBuilderContent), styles);

            //gap summary
            gapSummaryContent += createHeader();
            gapSummaryContent += createGAPSummaryPDF(caseId);
            gapSummaryContent += createFooter();
            gapSummaryList = HTMLWorker.ParseToList(new StringReader(gapSummaryContent), styles);
        }

        public static string readHTMLContent(string path)
        {
            return System.IO.File.ReadAllText(path);
        }

        public string createMzaPdf(string caseId)
        {
            try
            {
                string contents = "";

                bool lifeinsChecked = false;
                bool criticalChecked = false;
                bool hospspsurgChecked = false;
                bool othersChecked = false;

                MyZurichAdviserDAO mzaDao = new MyZurichAdviserDAO();
                
                Stopwatch stpwatchMza = Stopwatch.StartNew();
                List<myzurichadviser> savedMzaoptions = mzaDao.getMza(caseId);
                stpwatchMza.Stop();
                writeLog(activityStatus, "", "Time taken for mza db call", stpwatchMza.ElapsedMilliseconds);
                string tick_mark = baseUrl + "tick_01a.jpg";
                string tick = "<img src='" + tick_mark + "' alt='' width='10' height='10'";
                string tick_noMark = baseUrl + "tick_01b.jpg";
                string tickNo = "<img src='" + tick_noMark + "' alt='' width='10' height='10'";

                contents = mza_Path; 

                if (savedMzaoptions != null && savedMzaoptions.Count>0)
                {
                    foreach (myzurichadviser m in savedMzaoptions)
                    {
                        if (m.selectedoptionid.Value == 1)
                        {
                            contents = contents.Replace("[ticklifeins]", tick);
                            lifeinsChecked = true;
                        }
                        
                        if (m.selectedoptionid.Value == 2)
                        {
                            contents = contents.Replace("[tickcritical]", tick);
                            criticalChecked = true;
                        }
                        
                        if (m.selectedoptionid.Value == 3)
                        {
                            contents = contents.Replace("[tickhospsurg]", tick);
                            hospspsurgChecked = true;
                        }
                        
                        if (m.selectedoptionid.Value == 4)
                        {
                            string otherstxt = "";
                            
                            contents = contents.Replace("[tickothers]", tick);

                            othersChecked = true;
                            
                            if (m.selectedoptionothers != null)
                            {
                                otherstxt = m.selectedoptionothers;
                            }
                            contents = contents.Replace("[otherstxt]", removeLineBreak(otherstxt));
                        }
                        
                    }
                    
                }

                if (lifeinsChecked == false)
                {
                    contents = contents.Replace("[ticklifeins]", tickNo);
                }
                if (criticalChecked == false)
                {
                    contents = contents.Replace("[tickcritical]", tickNo);
                }
                if (hospspsurgChecked == false)
                {
                    contents = contents.Replace("[tickhospsurg]", tickNo);
                }
                if (othersChecked == false)
                {
                    contents = contents.Replace("[tickothers]", tickNo);
                    contents = contents.Replace("[otherstxt]", string.Empty);
                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createMzaPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }

        public int calculateIndividualScores(string riskPart, RiskProfile profile)
        {
            int score = 0;
            if (riskPart == "measuringRiskTakingAbility")
            {
                if (profile != null)
                {
                    score += int.Parse((profile.measuringRiskTakingAbilityQuestion1 != null && profile.measuringRiskTakingAbilityQuestion1 != "") ? profile.measuringRiskTakingAbilityQuestion1 : "0");
                    score += int.Parse((profile.measuringRiskTakingAbilityQuestion2 != null && profile.measuringRiskTakingAbilityQuestion2 != "") ? profile.measuringRiskTakingAbilityQuestion2 : "0");
                    score += int.Parse((profile.measuringRiskTakingAbilityQuestion3 != null && profile.measuringRiskTakingAbilityQuestion3 != "") ? profile.measuringRiskTakingAbilityQuestion3 : "0");
                    score += int.Parse((profile.measuringRiskTakingAbilityQuestion4 != null && profile.measuringRiskTakingAbilityQuestion4 != "") ? profile.measuringRiskTakingAbilityQuestion4 : "0");

                }
            }

            else
            {
                if (profile != null)
                {
                    score += int.Parse((profile.riskApetiteQuestion1 != null && profile.riskApetiteQuestion1 != "") ? profile.riskApetiteQuestion1 : "0");
                    score += int.Parse((profile.riskApetiteQuestion2 != null && profile.riskApetiteQuestion2 != "") ? profile.riskApetiteQuestion2 : "0");
                    score += int.Parse((profile.riskApetiteQuestion3 != null && profile.riskApetiteQuestion3 != "") ? profile.riskApetiteQuestion3 : "0");
                    score += int.Parse((profile.riskApetiteQuestion4 != null && profile.riskApetiteQuestion4 != "") ? profile.riskApetiteQuestion4 : "0");

                }

            }

            return score;

        }


        public string createRiskProfilePdf(string caseId)
        {
            try
            {
                //string path = baseUrl + "RiskProfile.html";
                string contents = RiskProfile_Path;
                String answer1 = "-";
                String answer2 = "-";
                String answer3 = "-";
                String answer4 = "-";
                String answer5 = "-";
                String answer6 = "-";
                String answer7 = "-";
                String answer8 = "-";
                RiskProfileDAO dao = new RiskProfileDAO();

                string imagePath = baseUrl + "RiskProfileChart.jpg";
                imagePath = imagePath.Replace("\\\\", "\\");
                contents = contents.Replace("[imagePath]", imagePath);
                string backgroundimagePath = baseUrl + "headertitleimage.png";
                string risk_image = baseUrl + "Risk_Profile_Calc.png";

                contents = contents.Replace("[background-image]", backgroundimagePath);

                string tick_mark = baseUrl + "tick_01a.jpg";
                string tick_noMark = baseUrl + "tick_01b.jpg";

                Stopwatch stpwatchRiskProfile = Stopwatch.StartNew();

                RiskProfileAnalysis riskProfile = dao.getRiskProfileForCase(caseId);
                stpwatchRiskProfile.Stop();
                writeLog(activityStatus, "", "Time taken for risk profile db call", stpwatchRiskProfile.ElapsedMilliseconds);
                RiskProfile profile = new RiskProfile();

                int riskApetiteQuestionsScore = 0;
                int riskTakingAbilityquestionsScore = 0;

                if (riskProfile != null)
                {
                    contents = contents.Replace("[riskProfile]", riskProfile.riskProfileName);
                }
                if (riskProfile != null)
                {
                    profile = dao.populateRiskProfile(riskProfile);
                    riskTakingAbilityquestionsScore = calculateIndividualScores("measuringRiskTakingAbility", profile);
                    riskApetiteQuestionsScore = calculateIndividualScores("riskAppetite", profile);

                    contents = contents.Replace("[totalRiskProfileScoreRiskAppetite]", riskApetiteQuestionsScore + "");
                    contents = contents.Replace("[totalRiskProfileScoreRiskTakingAbility]", riskTakingAbilityquestionsScore + "");
                }
                else
                {
                    contents = contents.Replace("[totalRiskProfileScoreRiskAppetite]", string.Empty);
                    contents = contents.Replace("[totalRiskProfileScoreRiskTakingAbility]", string.Empty);
                    contents = contents.Replace("[riskProfile]", string.Empty);
                }


                string q1A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q1A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q1A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q1A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q1A5 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q1A6 = "<img src='" + tick_noMark + "' width='10' height='10'/>";


                if (profile.riskApetiteQuestion1 != null)
                {
                    switch (profile.riskApetiteQuestion1)
                    {
                        case "-16":
                            q1A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "-3":
                            q1A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "2":
                            q1A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "8":
                            q1A4 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "12":
                            q1A5 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "16":
                            q1A6 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer1]", answer1);

                contents = contents.Replace("[q1A1]", q1A1);
                contents = contents.Replace("[q1A2]", q1A2);
                contents = contents.Replace("[q1A3]", q1A3);
                contents = contents.Replace("[q1A4]", q1A4);
                contents = contents.Replace("[q1A5]", q1A5);
                contents = contents.Replace("[q1A6]", q1A6);


                string q2A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q2A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q2A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q2A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";

                if (profile.riskApetiteQuestion2 != null)
                {
                    switch (profile.riskApetiteQuestion2)
                    {
                        case "1":
                            q2A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "2":
                            q2A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "4":
                            q2A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "5":
                            q2A4 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;

                    }

                }
                else
                    contents = contents.Replace("[answer2]", answer2);

                contents = contents.Replace("[q2A1]", q2A1);
                contents = contents.Replace("[q2A2]", q2A2);
                contents = contents.Replace("[q2A3]", q2A3);
                contents = contents.Replace("[q2A4]", q2A4);

                string q3A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q3A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q3A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q3A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q3A5 = "<img src='" + tick_noMark + "' width='10' height='10'/>";


                if (profile.riskApetiteQuestion3 != null)
                {
                    switch (profile.riskApetiteQuestion3)
                    {
                        case "-4":
                            q3A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "1":
                            q3A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "4":
                            q3A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "5":
                            q3A4 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "6":
                            q3A5 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                    }
                }
                else
                    contents = contents.Replace("[answer3]", answer3);

                contents = contents.Replace("[q3A1]", q3A1);
                contents = contents.Replace("[q3A2]", q3A2);
                contents = contents.Replace("[q3A3]", q3A3);
                contents = contents.Replace("[q3A4]", q3A4);
                contents = contents.Replace("[q3A5]", q3A5);



                string q4A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q4A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q4A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";


                if (profile.riskApetiteQuestion4 != null)
                {
                    switch (profile.riskApetiteQuestion4)
                    {
                        case "1":
                            q4A1 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                        case "3":
                            q4A2 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                        case "5":
                            q4A3 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer4]", answer4);

                contents = contents.Replace("[q4A1]", q4A1);
                contents = contents.Replace("[q4A2]", q4A2);
                contents = contents.Replace("[q4A3]", q4A3);


                string q5A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q5A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q5A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q5A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";

                if (profile.measuringRiskTakingAbilityQuestion1 != null)
                {
                    switch (profile.measuringRiskTakingAbilityQuestion1)
                    {
                        case "-3":
                            q5A1 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                        case "0":
                            q5A2 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                        case "3":
                            q5A3 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                        case "5":
                            q5A4 = "<img src='" + tick_mark + "' width='10' height='10'";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer5]", answer5);


                contents = contents.Replace("[q5A1]", q5A1);
                contents = contents.Replace("[q5A2]", q5A2);
                contents = contents.Replace("[q5A3]", q5A3);
                contents = contents.Replace("[q5A4]", q5A4);


                string q6A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q6A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q6A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";


                if (profile.measuringRiskTakingAbilityQuestion2 != null)
                {
                    switch (profile.measuringRiskTakingAbilityQuestion2)
                    {
                        case "0":
                            q6A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "3":
                            q6A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "5":
                            q6A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer6]", answer6);

                contents = contents.Replace("[q6A1]", q6A1);
                contents = contents.Replace("[q6A2]", q6A2);
                contents = contents.Replace("[q6A3]", q6A3);


                string q7A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q7A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q7A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q7A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";


                if (profile.measuringRiskTakingAbilityQuestion3 != null)
                {
                    switch (profile.measuringRiskTakingAbilityQuestion3)
                    {
                        case "0":
                            q7A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "2":
                            q7A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "3":
                            q7A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "5":
                            q7A4 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer7]", answer7);


                contents = contents.Replace("[q7A1]", q7A1);
                contents = contents.Replace("[q7A2]", q7A2);
                contents = contents.Replace("[q7A3]", q7A3);
                contents = contents.Replace("[q7A4]", q7A4);

                string q8A1 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q8A2 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q8A3 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string q8A4 = "<img src='" + tick_noMark + "' width='10' height='10'/>";
                string riskImage = "<img src='" + risk_image + "' width='500' height='250'";

                if (profile.measuringRiskTakingAbilityQuestion4 != null)
                {
                    switch (profile.measuringRiskTakingAbilityQuestion4)
                    {
                        case "0":
                            q8A1 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "2":
                            q8A2 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "3":
                            q8A3 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                        case "5":
                            q8A4 = "<img src='" + tick_mark + "' width='10' height='10'/>";
                            break;
                    }

                }
                else
                    contents = contents.Replace("[answer8]", answer8);

                contents = contents.Replace("[q8A1]", q8A1);
                contents = contents.Replace("[q8A2]", q8A2);
                contents = contents.Replace("[q8A3]", q8A3);
                contents = contents.Replace("[q8A4]", q8A4);
                contents = contents.Replace("[riskImage]", riskImage);

                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createRiskProfilePdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }

        public string createIncomeAndExpensePdf(string caseId)
        {
            try
            {
                string contents = IncomeExpenseDetail_Path;
                string members = "";
                IncomeExpenseDAO incomeExpenseDao = new IncomeExpenseDAO();
                
                Stopwatch stpwatchIncomeExpense = Stopwatch.StartNew();
                incomeExpense incomeExpense = incomeExpenseDao.getIncomeExpenseForCase(caseId);
                stpwatchIncomeExpense.Stop();
                writeLog(activityStatus, "", "Time taken for income expense db call", stpwatchIncomeExpense.ElapsedMilliseconds);

                if (incomeExpense != null)
                {

                    if (incomeExpense.assecertainingAffordabilityEnable != null)
                    {
                        if (incomeExpense.assecertainingAffordabilityEnable == 0)
                        {
                            contents = contents.Replace("[assecertainingAffordabilityEnable]", "Yes");
                            contents = contents.Replace("[assecertainingAffordabilityReason]", "");
                        }
                        else
                        {
                            contents = contents.Replace("[assecertainingAffordabilityEnable]", "No");
                            
                            if (incomeExpense.assecertainingAffordabilityReason != null && incomeExpense.assecertainingAffordabilityReason != "")
                            {
                                contents = contents.Replace("[assecertainingAffordabilityReason]", "Reason: "+incomeExpense.assecertainingAffordabilityReason);
                            }
                            else
                            {
                                contents = contents.Replace("[assecertainingAffordabilityReason]", "");
                            }
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[assecertainingAffordabilityEnable]", "");
                        contents = contents.Replace("[assecertainingAffordabilityReason]", "");
                    }

                    if (incomeExpense.incomeExpenseNeeded != null)
                    {
                        if (incomeExpense.incomeExpenseNeeded == 0)
                        {
                            contents = contents.Replace("[incomeInsuranceEnable]", "Yes");
                            contents = contents.Replace("[incomeExpenseNotNeededReason]", "");
                        }
                        else
                        {
                            contents = contents.Replace("[incomeInsuranceEnable]", "No");
                            
                            if (incomeExpense.incomeExpenseNotNeededReason != null && incomeExpense.incomeExpenseNotNeededReason != "")
                            {
                                contents = contents.Replace("[incomeExpenseNotNeededReason]", "Reason: "+incomeExpense.incomeExpenseNotNeededReason);

                            }
                            else
                            {
                                contents = contents.Replace("[incomeExpenseNotNeededReason]", "");

                            }
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[incomeInsuranceEnable]", "");
                        contents = contents.Replace("[incomeExpenseNotNeededReason]", "");
                    }

                    if (incomeExpense.emergencyFundsNeeded != null && incomeExpense.emergencyFundsNeeded!="")
                        contents = contents.Replace("[emergencyFundNeeded]", double.Parse(incomeExpense.emergencyFundsNeeded).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[emergencyFundNeeded]", "");


                    if (incomeExpense.shortTermGoals != null)
                        contents = contents.Replace("[shortTermGoalsIn12Months]", incomeExpense.shortTermGoals);
                    else
                        contents = contents.Replace("[shortTermGoalsIn12Months]", "");

                    if (incomeExpense.extraDetails != null)
                        contents = contents.Replace("[detailShortTermGoalsIn12Months]", removeLineBreak(incomeExpense.extraDetails.ToString()));
                    else
                        contents = contents.Replace("[detailShortTermGoalsIn12Months]", "");

                    double dnetMonthlyIncomeAfterCpf = 0;
                    if (incomeExpense.netMonthlyIncomeAfterCpf != null && incomeExpense.netMonthlyIncomeAfterCpf!="")
                    {
                        contents = contents.Replace("[netMonthlyIncomeAfterCPF]", double.Parse(incomeExpense.netMonthlyIncomeAfterCpf).ToString("#,##0.00"));
                        if (incomeExpense.netMonthlyIncomeAfterCpf != "")
                        {
                            dnetMonthlyIncomeAfterCpf = double.Parse(incomeExpense.netMonthlyIncomeAfterCpf);
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[netMonthlyIncomeAfterCPF]", "0");
                    }

                    double dnetMonthlyExpenses = 0;
                    if (incomeExpense.netMonthlyExpenses != null && incomeExpense.netMonthlyExpenses!="")
                    {
                        contents = contents.Replace("[netMonthlyExpenses]", double.Parse(incomeExpense.netMonthlyExpenses).ToString("#,##0.00"));
                        if (incomeExpense.netMonthlyExpenses != "")
                        {
                            dnetMonthlyExpenses = double.Parse(incomeExpense.netMonthlyExpenses);
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[netMonthlyExpenses]", "0");
                    }

                    double dotherSourcesOfIncome = 0;
                    if (incomeExpense.otherSourcesOfIncome != null && incomeExpense.otherSourcesOfIncome!="")
                    {
                        contents = contents.Replace("[otherSourcesIncome]", double.Parse(incomeExpense.otherSourcesOfIncome).ToString("#,##0.00"));
                        if (incomeExpense.otherSourcesOfIncome != "")
                        {
                            dotherSourcesOfIncome = double.Parse(incomeExpense.otherSourcesOfIncome);
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[otherSourcesIncome]", "0");
                    }

                    double total = (dnetMonthlyIncomeAfterCpf + dotherSourcesOfIncome) - dnetMonthlyExpenses;
                    if (total != 0)
                    {
                        if (total > 0)
                        {
                            contents = contents.Replace("[surplusShortfall]", "TOTAL(SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusColour]", "black");
                        }
                        else
                        {
                            contents = contents.Replace("[surplusShortfall]", "TOTAL(SHORTFALL)");
                            contents = contents.Replace("[shortfallSurplusColour]", "red");
                        }

                        contents = contents.Replace("[ttlspdef]", Math.Abs(total).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[shortfallSurplusColour]", "black");
                        contents = contents.Replace("[surplusShortfall]", "TOTAL(SHORTFALL/SURPLUS)");
                        contents = contents.Replace("[ttlspdef]", "0");
                    }

                    if (incomeExpense.DeathTermInsuranceSA != null && incomeExpense.DeathTermInsuranceSA!="")
                        contents = contents.Replace("[deathTermInsuranceSA]", double.Parse(incomeExpense.DeathTermInsuranceSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[deathTermInsuranceSA]", "");

                    if (incomeExpense.DeathWholeLifeInsuranceSA != null && (incomeExpense.DeathWholeLifeInsuranceSA != ""))
                        contents = contents.Replace("[deathWholelifeInsuranceSA]", double.Parse(incomeExpense.DeathWholeLifeInsuranceSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[deathWholelifeInsuranceSA]", "");

                    if (incomeExpense.lifeInsuranceSA != null && incomeExpense.lifeInsuranceSA != "")
                        contents = contents.Replace("[lifeInsuranceSA]", double.Parse(incomeExpense.lifeInsuranceSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[lifeInsuranceSA]", "");

                    if (incomeExpense.tpdcSA != null && incomeExpense.tpdcSA != "")
                        contents = contents.Replace("[tpdcSA]", double.Parse(incomeExpense.tpdcSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[tpdcSA]", "");

                    if (incomeExpense.criticalIllnessSA != null && incomeExpense.criticalIllnessSA != "")
                        contents = contents.Replace("[criticalIllnessSA]", double.Parse(incomeExpense.criticalIllnessSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[criticalIllnessSA]", "");

                    if (incomeExpense.mortgageSA != null && incomeExpense.mortgageSA != "")
                        contents = contents.Replace("[mortgageSA]", double.Parse(incomeExpense.mortgageSA).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[mortgageSA]", "");

                    if (incomeExpense.DeathTermInsuranceTerm != null && incomeExpense.DeathTermInsuranceTerm != "")
                        contents = contents.Replace("[deathTermInsuranceTerm]", double.Parse(incomeExpense.DeathTermInsuranceTerm).ToString());
                    else
                        contents = contents.Replace("[deathTermInsuranceTerm]", "");

                    if (incomeExpense.DeathWholeLifeInsuranceTerm != null && incomeExpense.DeathWholeLifeInsuranceTerm != "")
                        contents = contents.Replace("[deathWholelifeInsuranceTerm]", double.Parse(incomeExpense.DeathWholeLifeInsuranceTerm).ToString());
                    else
                        contents = contents.Replace("[deathWholelifeInsuranceTerm]", "");

                    if (incomeExpense.lifeInsuranceMV != null && incomeExpense.lifeInsuranceMV != "")
                        contents = contents.Replace("[lifeInsuranceMV]", double.Parse(incomeExpense.lifeInsuranceMV).ToString());
                    else
                        contents = contents.Replace("[lifeInsuranceMV]", "");

                    if (incomeExpense.tpdcMV != null && incomeExpense.tpdcMV != "")
                        contents = contents.Replace("[tpdcMV]", double.Parse(incomeExpense.tpdcMV).ToString());
                    else
                        contents = contents.Replace("[tpdcMV]", "");

                    if (incomeExpense.criticalIllnessMV != null && incomeExpense.criticalIllnessMV != "")
                        contents = contents.Replace("[criticalIllnessMV]", double.Parse(incomeExpense.criticalIllnessMV).ToString());
                    else
                        contents = contents.Replace("[criticalIllnessMV]", "");

                    if (incomeExpense.mortgageMV != null && incomeExpense.mortgageMV != "")
                        contents = contents.Replace("[mortgageMV]", double.Parse(incomeExpense.mortgageMV).ToString());
                    else
                        contents = contents.Replace("[mortgageMV]", "");

                    if (incomeExpense.DeathTermInsurancePremium != null && incomeExpense.DeathTermInsurancePremium != "")
                        contents = contents.Replace("[deathTermInsurancePremium]", double.Parse(incomeExpense.DeathTermInsurancePremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[deathTermInsurancePremium]", "");

                    if (incomeExpense.DeathWholeLifeInsurancePremium != null && incomeExpense.DeathWholeLifeInsurancePremium != "")
                        contents = contents.Replace("[deathWholelifeInsurancePremium]", double.Parse(incomeExpense.DeathWholeLifeInsurancePremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[deathWholelifeInsurancePremium]", "");

                    if (incomeExpense.lifeInsurancePremium != null && incomeExpense.lifeInsurancePremium != "")
                        contents = contents.Replace("[lifeInsurancePremium]", double.Parse(incomeExpense.lifeInsurancePremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[lifeInsurancePremium]", "");

                    if (incomeExpense.tpdcPremium != null && incomeExpense.tpdcPremium != "")
                        contents = contents.Replace("[tpdcPremium]", double.Parse(incomeExpense.tpdcPremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[tpdcPremium]", "");

                    if (incomeExpense.criticalIllnessPremium != null && incomeExpense.criticalIllnessPremium != "")
                        contents = contents.Replace("[criticalIllnessPremium]", double.Parse(incomeExpense.criticalIllnessPremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[criticalIllnessPremium]", "");

                    if (incomeExpense.mortgagePremium != null && incomeExpense.mortgagePremium != "")
                        contents = contents.Replace("[mortgagePremium]", double.Parse(incomeExpense.mortgagePremium).ToString("#,##0.00"));
                    else
                        contents = contents.Replace("[mortgagePremium]", "");

                    if (incomeExpense.insuranceArrangementSavings != null)
                    {
                        for (int i = 0; i < incomeExpense.insuranceArrangementSavings.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";

                            insuranceArrangementSaving sg = incomeExpense.insuranceArrangementSavings[i];

                            string contrib = sg.contribution;
                            if(sg.contribution!=null && sg.contribution!="")
                            {
                                contrib = double.Parse(sg.contribution).ToString("#,##0.00");
                            }

                            string strfv = sg.fundValue;
                            if(sg.fundValue!=null && sg.fundValue!="")
                            {
                                strfv = double.Parse(sg.fundValue).ToString("#,##0.00");
                            }
                            
                            members += "<tr class='" + classRow + "'><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.natureOfPlan + "</td><td align='center'>"
                                 + sg.company + "</td><td align='center'>" + "$ " + contrib + "</td><td align='center'>"+sg.frequency+"</td><td align='center'>" + sg.term + "</td><td align='center'>"
                                 + "$ " + strfv + "</td></tr>";
                        }

                        /*foreach (insuranceArrangementSaving sg in incomeExpense.insuranceArrangementSavings)
                        {
                            members += "<tr><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.natureOfPlan + "</td><td align='center'>"
                                 + sg.company + "</td><td align='center'>" + sg.contribution + "</td><td align='center'>" + sg.term + "</td><td align='center'>"
                                 + sg.fundValue + "</td></tr>";
                        }*/
                        contents = contents.Replace("[easavings]", members);
                    }
                    members = "";

                    if (incomeExpense.insuranceArrangementRetirements != null)
                    {
                        for (int i = 0; i < incomeExpense.insuranceArrangementRetirements.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";

                            insuranceArrangementRetirement sg = incomeExpense.insuranceArrangementRetirements[i];

                            string contrib = sg.contribution;
                            if(sg.contribution!=null && sg.contribution!="")
                            {
                                contrib = double.Parse(sg.contribution).ToString("#,##0.00");
                            }

                            string strprjlumpsum = sg.projectedLumpSumMaturity;
                            if(sg.projectedLumpSumMaturity!=null && sg.projectedLumpSumMaturity!="")
                            {
                                strprjlumpsum = double.Parse(sg.projectedLumpSumMaturity).ToString("#,##0.00");
                            }

                            string strprjincome = sg.projectedIncomeMaturity;
                            if(sg.projectedIncomeMaturity!=null && sg.projectedIncomeMaturity!="")
                            {
                                strprjincome = double.Parse(sg.projectedIncomeMaturity).ToString("#,##0.00");
                            }
                            
                            members += "<tr class='" + classRow + "'><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.company + "</td><td align='center'>"
                                 + "$ " + contrib + "</td><td align='center'>"+sg.frequency+"</td><td align='center'>" + sg.maturityDate + "</td><td align='center'>" + "$ " + strprjlumpsum + "</td><td align='center'>"
                                 + "$ " + strprjincome + "</td></tr>";
                        }
                        //foreach (insuranceArrangementRetirement sg in incomeExpense.insuranceArrangementRetirements)
                        //{
                        //    members += "<tr><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.company + "</td><td align='center'>"
                        //         + sg.contribution + "</td><td align='center'>" + sg.maturityDate + "</td><td align='center'>" + sg.projectedLumpSumMaturity + "</td><td align='center'>"
                        //         + sg.projectedIncomeMaturity + "</td></tr>";
                        //}
                        contents = contents.Replace("[earetirement]", members);
                    }
                    members = "";

                    if (incomeExpense.insuranceArrangementEducations != null)
                    {
                        for (int i = 0; i < incomeExpense.insuranceArrangementEducations.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";

                            insuranceArrangementEducation sg = incomeExpense.insuranceArrangementEducations[i];

                            string contrib = sg.contribution;
                            if(sg.contribution!=null && sg.contribution!="")
                            {
                                contrib = double.Parse(sg.contribution).ToString("#,##0.00");
                            }

                            string strprjlumpsum = sg.projectedLumpSumMaturity;
                            if(sg.projectedLumpSumMaturity!=null && sg.projectedLumpSumMaturity!="")
                            {
                                strprjlumpsum = double.Parse(sg.projectedLumpSumMaturity).ToString("#,##0.00");
                            }

                            string strprjincome = sg.projectedIncomeMaturity;
                            if(sg.projectedIncomeMaturity!=null && sg.projectedIncomeMaturity!="")
                            {
                                strprjincome = double.Parse(sg.projectedIncomeMaturity).ToString("#,##0.00");
                            }
                            
                            members += "<tr class='" + classRow + "'><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.company + "</td><td align='center'>"
                                 + "$ " + contrib + "</td><td align='center'>" + sg.frequency + "</td><td align='center'>" + sg.maturityDate + "</td><td align='center'>" + "$ " + strprjlumpsum + "</td><td align='center'>"
                                 + "$ " + strprjincome + "</td></tr>";
                        }
                        //foreach (insuranceArrangementEducation sg in incomeExpense.insuranceArrangementEducations)
                        //{
                        //    members += "<tr><td align='center'>" + sg.policyOwnerName + "</td><td align='center'>" + sg.company + "</td><td align='center'>"
                        //         + sg.contribution + "</td><td align='center'>" + sg.maturityDate + "</td><td align='center'>" + sg.projectedLumpSumMaturity + "</td><td align='center'>"
                        //         + sg.projectedIncomeMaturity + "</td></tr>";
                        //}
                        contents = contents.Replace("[eaeducation]", members);
                    }
                    members = "";
                }
                else
                {
                    contents = contents.Replace("[emergencyFundNeeded]", "");

                    contents = contents.Replace("[shortTermGoalsIn12Months]", "");

                    contents = contents.Replace("[detailShortTermGoalsIn12Months]", "");

                    contents = contents.Replace("[netMonthlyIncomeAfterCPF]", "");

                    contents = contents.Replace("[netMonthlyExpenses]", "");

                    contents = contents.Replace("[otherSourcesIncome]", "");

                    contents = contents.Replace("[ttlspdef]", "0");

                    contents = contents.Replace("[deathTermInsuranceSA]", "");

                    contents = contents.Replace("[deathWholelifeInsuranceSA]", "");

                    contents = contents.Replace("[lifeInsuranceSA]", "");

                    contents = contents.Replace("[tpdcSA]", "");

                    contents = contents.Replace("[criticalIllnessSA]", "");

                    contents = contents.Replace("[mortgageSA]", "");

                    contents = contents.Replace("[deathTermInsuranceTerm]", "");

                    contents = contents.Replace("[deathWholelifeInsuranceTerm]", "");

                    contents = contents.Replace("[lifeInsuranceMV]", "");

                    contents = contents.Replace("[tpdcMV]", "");

                    contents = contents.Replace("[criticalIllnessMV]", "");

                    contents = contents.Replace("[mortgageMV]", "");

                    contents = contents.Replace("[deathTermInsurancePremium]", "");

                    contents = contents.Replace("[deathWholelifeInsurancePremium]", "");

                    contents = contents.Replace("[lifeInsurancePremium]", "");

                    contents = contents.Replace("[tpdcPremium]", "");

                    contents = contents.Replace("[criticalIllnessPremium]", "");

                    contents = contents.Replace("[mortgagePremium]", "");

                    members = "";

                    contents = contents.Replace("[easavings]", members);

                    contents = contents.Replace("[earetirement]", members);

                    contents = contents.Replace("[eaeducation]", members);

                    contents = contents.Replace("[surplusShortfall]", "TOTAL(SHORTFALL/SURPLUS)");

                    contents = contents.Replace("[shortfallSurplusColour]", "black");
                }

                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createIncomeAndExpensePdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
            
        }

        public string createAssetAndLiabilitiesPdf(string caseId,string contents)
        {
            try
            {
                AssetAndLiabilityDAO assetLiabilityDAO = new AssetAndLiabilityDAO();

                Stopwatch stpwtch = Stopwatch.StartNew();
                assetAndLiability assetAndLiability = assetLiabilityDAO.getAssetLiabilityForCase(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for asset liability db call", stpwtch.ElapsedMilliseconds);

                double totalCash = 0;
                double totalCpf = 0;

                if (assetAndLiability != null)
                {
                    if (assetAndLiability.assetAndLiabilityNeeded != null)
                    {
                        if (assetAndLiability.assetAndLiabilityNeeded == 0)
                        {
                            contents = contents.Replace("[assetAndLiabilityNeeded]", "Yes");
                            contents = contents.Replace("[assetLiabilitiesNotNeededReason]", "");
                        }
                        else
                        {
                            contents = contents.Replace("[assetAndLiabilityNeeded]", "No");
                            if (assetAndLiability.assetAndLiabilityNotNeededReason != null && assetAndLiability.assetAndLiabilityNotNeededReason != "")
                            {
                                contents = contents.Replace("[assetLiabilitiesNotNeededReason]", "Reason: " + assetAndLiability.assetAndLiabilityNotNeededReason);
                            }
                            else
                            {
                                contents = contents.Replace("[assetLiabilitiesNotNeededReason]", "");
                            }
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[assetAndLiabilityNeeded]", "");
                        contents = contents.Replace("[assetLiabilitiesNotNeededReason]", "");
                    }


                    if (assetAndLiability.premiumRecomendedNeeded != null)
                    {
                        if (assetAndLiability.premiumRecomendedNeeded == 1)
                        {
                            contents = contents.Replace("[premiumRecomended]", "No");
                            contents = contents.Replace("[assetIncomePercent]", "");
                        }
                        else
                        {
                            if (assetAndLiability.premiumRecomendedNeeded == 0)
                            {
                                contents = contents.Replace("[premiumRecomended]", "Yes");
                                if (assetAndLiability.assetIncomePercent != null && assetAndLiability.assetIncomePercent != "")
                                {
                                    contents = contents.Replace("[assetIncomePercent]", "$ " + double.Parse(assetAndLiability.assetIncomePercent).ToString("#,##0.00"));

                                }
                                else
                                {
                                    contents = contents.Replace("[assetIncomePercent]", "");
                                }

                            }
                            else
                            {
                                contents = contents.Replace("[premiumRecomended]", "No");
                                contents = contents.Replace("[assetIncomePercent]", "");
                            }
                        }     
                    }
                    else
                    {
                        contents = contents.Replace("[premiumRecomended]", "");
                        contents = contents.Replace("[assetIncomePercent]", "");
                    }

                    contents = contents.Replace("[bankAcctCash]", (assetAndLiability.bankAcctCash != null && assetAndLiability.bankAcctCash != "") ? double.Parse(assetAndLiability.bankAcctCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.bankAcctCash != null && assetAndLiability.bankAcctCash != "") ? assetAndLiability.bankAcctCash : "0");

                    contents = contents.Replace("[cpfoaBal]", (assetAndLiability.cpfoaBal != null && assetAndLiability.cpfoaBal != "") ? double.Parse(assetAndLiability.cpfoaBal).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.cpfoaBal != null && assetAndLiability.cpfoaBal != "") ? assetAndLiability.cpfoaBal : "0");

                    contents = contents.Replace("[cpfsaBal]", (assetAndLiability.cpfsaBal != null && assetAndLiability.cpfsaBal != "") ? double.Parse(assetAndLiability.cpfsaBal).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.cpfsaBal != null && assetAndLiability.cpfsaBal != "") ? assetAndLiability.cpfsaBal : "0");

                    contents = contents.Replace("[cpfMedisaveBalance]", (assetAndLiability.cpfMediSaveBalance != null && assetAndLiability.cpfMediSaveBalance != "") ? double.Parse(assetAndLiability.cpfMediSaveBalance).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.cpfMediSaveBalance != null && assetAndLiability.cpfMediSaveBalance != "") ? assetAndLiability.cpfMediSaveBalance : "0");

                    contents = contents.Replace("[srsBal]", (assetAndLiability.srsBal != null && assetAndLiability.srsBal != "") ? double.Parse(assetAndLiability.srsBal).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.srsBal != null && assetAndLiability.srsBal != "") ? assetAndLiability.srsBal : "0");


                    contents = contents.Replace("[stocksSharesCash]", (assetAndLiability.stocksSharesCash != null && assetAndLiability.stocksSharesCash != "") ? double.Parse(assetAndLiability.stocksSharesCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.stocksSharesCash != null && assetAndLiability.stocksSharesCash != "") ? assetAndLiability.stocksSharesCash : "0");

                    contents = contents.Replace("[stocksSharesCpf]", (assetAndLiability.stocksSharesCpf != null && assetAndLiability.stocksSharesCpf != "") ? double.Parse(assetAndLiability.stocksSharesCpf).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.stocksSharesCpf != null && assetAndLiability.stocksSharesCpf != "") ? assetAndLiability.stocksSharesCpf : "0");

                    contents = contents.Replace("[unitTrustsCash]", (assetAndLiability.unitTrustsCash != null && assetAndLiability.unitTrustsCash != "") ? double.Parse(assetAndLiability.unitTrustsCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.unitTrustsCash != null && assetAndLiability.unitTrustsCash != "") ? assetAndLiability.unitTrustsCash : "0");

                    contents = contents.Replace("[unitTrustsCpf]", (assetAndLiability.unitTrustsCpf != null && assetAndLiability.unitTrustsCpf != "") ? double.Parse(assetAndLiability.unitTrustsCpf).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.unitTrustsCpf != null && assetAndLiability.unitTrustsCpf != "") ? assetAndLiability.unitTrustsCpf : "0");

                    contents = contents.Replace("[ilpCash]", (assetAndLiability.ilpCash != null && assetAndLiability.ilpCash != "") ? double.Parse(assetAndLiability.ilpCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.ilpCash != null && assetAndLiability.ilpCash != "") ? assetAndLiability.ilpCash : "0");

                    contents = contents.Replace("[ilpCpf]", (assetAndLiability.ilpCpf != null && assetAndLiability.ilpCpf != "") ? double.Parse(assetAndLiability.ilpCpf).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.ilpCpf != null && assetAndLiability.ilpCpf != "") ? assetAndLiability.ilpCpf : "0");

                    contents = contents.Replace("[srsInvCash]", (assetAndLiability.srsInvCash != null && assetAndLiability.srsInvCash != "") ? double.Parse(assetAndLiability.srsInvCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.srsInvCash != null && assetAndLiability.srsInvCash != "") ? assetAndLiability.srsInvCash : "0");

                    contents = contents.Replace("[invPropCash]", (assetAndLiability.invPropCash != null && assetAndLiability.invPropCash != "") ? double.Parse(assetAndLiability.invPropCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.invPropCash != null && assetAndLiability.invPropCash != "") ? assetAndLiability.invPropCash : "0");

                    contents = contents.Replace("[invPropCpf]", (assetAndLiability.invPropCpf != null && assetAndLiability.invPropCpf != "") ? double.Parse(assetAndLiability.invPropCpf).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.invPropCpf != null && assetAndLiability.invPropCpf != "") ? assetAndLiability.invPropCpf : "0");

                    contents = contents.Replace("[resPropCash]", (assetAndLiability.resPropCash != null && assetAndLiability.resPropCash != "") ? double.Parse(assetAndLiability.resPropCash).ToString("#,##0.00") : string.Empty);
                    totalCash += double.Parse((assetAndLiability.resPropCash != null && assetAndLiability.resPropCash != "") ? assetAndLiability.resPropCash : "0");

                    contents = contents.Replace("[resPropCpf]", (assetAndLiability.resPropCpf != null && assetAndLiability.resPropCpf != "") ? double.Parse(assetAndLiability.resPropCpf).ToString("#,##0.00") : string.Empty);
                    totalCpf += double.Parse((assetAndLiability.resPropCpf != null && assetAndLiability.resPropCpf != "") ? assetAndLiability.resPropCpf : "0");


                    contents = contents.Replace("[homeMortgage]", (assetAndLiability.homeMortgage != null && assetAndLiability.homeMortgage != "") ? double.Parse(assetAndLiability.homeMortgage).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[vehicleLoan]", (assetAndLiability.vehicleLoan != null && assetAndLiability.vehicleLoan != "") ? double.Parse(assetAndLiability.vehicleLoan).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[cashLoan]", (assetAndLiability.cashLoan != null && assetAndLiability.cashLoan != "") ? double.Parse(assetAndLiability.cashLoan).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[creditCard]", (assetAndLiability.creditCard != null && assetAndLiability.creditCard != "") ? double.Parse(assetAndLiability.creditCard).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[netWorth]", (assetAndLiability.netWorth != null && assetAndLiability.netWorth != "") ? double.Parse(assetAndLiability.netWorth).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[regularSumCash]", (assetAndLiability.regularSumCash != null && assetAndLiability.regularSumCash != "") ? double.Parse(assetAndLiability.regularSumCash).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[lumpSumCash]", (assetAndLiability.lumpSumCash != null && assetAndLiability.lumpSumCash != "") ? double.Parse(assetAndLiability.lumpSumCash).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[regularSumCpf]", (assetAndLiability.regularSumCpf != null && assetAndLiability.regularSumCpf != "") ? double.Parse(assetAndLiability.regularSumCpf).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[lumpSumCpf]", (assetAndLiability.lumpSumCpf != null && assetAndLiability.lumpSumCpf != "") ? double.Parse(assetAndLiability.lumpSumCpf).ToString("#,##0.00") : string.Empty);


                    double homeMortgage = double.Parse((assetAndLiability.homeMortgage != null && assetAndLiability.homeMortgage != "") ? assetAndLiability.homeMortgage : "0");
                    double vehicleLoan = double.Parse((assetAndLiability.vehicleLoan != null && assetAndLiability.vehicleLoan != "") ? assetAndLiability.vehicleLoan : "0");
                    double cashLoan = double.Parse((assetAndLiability.cashLoan != null && assetAndLiability.cashLoan != "") ? assetAndLiability.cashLoan : "0");
                    double creditCard = double.Parse((assetAndLiability.creditCard != null && assetAndLiability.creditCard != "") ? assetAndLiability.creditCard : "0");

                    double totalLiabilitiesForPdf = homeMortgage + vehicleLoan + cashLoan + creditCard;

                    string members = "";
                    double assetLiabilityInvestedCash = 0;
                    double assetLiabilityInvestedCpf = 0;
                    
                    if (assetAndLiability.investedAssetOthers != null)
                    {
                        for (int i = 0; i < assetAndLiability.investedAssetOthers.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";
                            investedAssetOther investedAssetOther = assetAndLiability.investedAssetOthers[i];

                            assetLiabilityInvestedCash += double.Parse((investedAssetOther.cash != null && investedAssetOther.cash != "") ? investedAssetOther.cash : "0");
                            assetLiabilityInvestedCpf += double.Parse((investedAssetOther.cpf != null && investedAssetOther.cpf != "") ? investedAssetOther.cpf : "0");

                            string iaothercash = investedAssetOther.cash;
                            if (investedAssetOther.cash != null && investedAssetOther.cash != "")
                            {
                                iaothercash = double.Parse(investedAssetOther.cash).ToString("#,##0.00");
                            }

                            string iaothercpf = investedAssetOther.cpf;
                            if (investedAssetOther.cpf != null && investedAssetOther.cpf != "")
                            {
                                iaothercpf = double.Parse(investedAssetOther.cpf).ToString("#,##0.00");
                            }
                            
                            members += "<tr class='" + classRow + "'><td align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + investedAssetOther.assetDesc + "</td><td align='right'>" + "$ "+ iaothercash + "</td><td align='right'>"
                                 + "$ " + iaothercpf + "</td></tr>";
                        }

                        /*foreach (investedAssetOther investedAssetOther in assetAndLiability.investedAssetOthers)
                        {
                            assetLiabilityInvestedCash += double.Parse((investedAssetOther.cash != null && investedAssetOther.cash != "") ? investedAssetOther.cash : "0");
                            assetLiabilityInvestedCpf += double.Parse((investedAssetOther.cpf != null && investedAssetOther.cpf != "") ? investedAssetOther.cpf : "0");

                            members += "<tr><td align='center'>" + investedAssetOther.assetDesc + "</td><td align='center'>" + investedAssetOther.cash + "</td><td align='center'>"
                                 + investedAssetOther.cpf + "</td></tr>";

                        }*/

                        //members += "<tr><td align='center'>Total Assets</td><td align='center'><b>" + assetLiabilityInvestedCash + "</b></td><td align='center'><b>"
                          //       + assetLiabilityInvestedCpf + "</b></td></tr>";

                        contents = contents.Replace("[othersInvestedAssets]", members);


                    }

                     totalCash += assetLiabilityInvestedCash;
                     totalCpf += assetLiabilityInvestedCpf;

                    members = "";

                    double personnalUseAssetsOthersCash =0;
                    double personnalUseAssetsOthersCpf =0;

                    if (assetAndLiability.personalUseAssetsOthers != null)
                    {
                        for (int i = 0; i < assetAndLiability.personalUseAssetsOthers.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";
                            personalUseAssetsOther personalUseAssetsOther = assetAndLiability.personalUseAssetsOthers[i];

                            personnalUseAssetsOthersCash += double.Parse((personalUseAssetsOther.cash != null && personalUseAssetsOther.cash != "") ? personalUseAssetsOther.cash : "0");
                            personnalUseAssetsOthersCpf += double.Parse((personalUseAssetsOther.cpf != null && personalUseAssetsOther.cpf != "") ? personalUseAssetsOther.cpf : "0");

                            string iaothercash = personalUseAssetsOther.cash;
                            if (personalUseAssetsOther.cash != null && personalUseAssetsOther.cash != "")
                            {
                                iaothercash = double.Parse(personalUseAssetsOther.cash).ToString("#,##0.00");
                            }

                            string iaothercpf = personalUseAssetsOther.cpf;
                            if (personalUseAssetsOther.cpf != null && personalUseAssetsOther.cpf != "")
                            {
                                iaothercpf = double.Parse(personalUseAssetsOther.cpf).ToString("#,##0.00");
                            }

                            members += "<tr class='" + classRow + "'><td align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + personalUseAssetsOther.assetDesc + "</td><td align='right'>" + "$ " + iaothercash + "</td><td align='right'>"
                                 +"$ "+ iaothercpf + "</td></tr>";
                        }


                        //members = "<table width='100%'>";
                        /*foreach (personalUseAssetsOther personalUseAssetsOther in assetAndLiability.personalUseAssetsOthers)
                        {
                            members += "<tr><td align='center'>" + personalUseAssetsOther.assetDesc + "</td><td align='center'>" + personalUseAssetsOther.cash + "</td><td align='center'>"
                                 + personalUseAssetsOther.cpf + "</td></tr>";
                            personnalUseAssetsOthersCash += double.Parse((personalUseAssetsOther.cash != null && personalUseAssetsOther.cash != "") ? personalUseAssetsOther.cash : "0");
                            personnalUseAssetsOthersCpf += double.Parse((personalUseAssetsOther.cpf != null && personalUseAssetsOther.cpf != "") ? personalUseAssetsOther.cpf : "0");

                        }*/
                        //members += "</table>";
                        contents = contents.Replace("[othersPersonalUse]", members);
                    }

                    contents = contents.Replace("[totalCash]", personnalUseAssetsOthersCash+"");
                    contents = contents.Replace("[totalCpf]", personnalUseAssetsOthersCpf+"");

                    totalCash += personnalUseAssetsOthersCash;
                    totalCpf += personnalUseAssetsOthersCpf;

                    contents = contents.Replace("[totalAssetsCash]", totalCash.ToString("#,##0.00") + "");
                    contents = contents.Replace("[totalAssetsCpf]", totalCpf.ToString("#,##0.00") + "");

                    members = "";

                    double otherLiabilitiesValue = 0;

                    if (assetAndLiability.liabilityOthers != null)
                    {
                        for (int i = 0; i < assetAndLiability.liabilityOthers.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "evenRowStyle";
                            else
                                classRow = "oddRowStyle";
                            liabilityOther liabilityOther = assetAndLiability.liabilityOthers[i];

                            otherLiabilitiesValue += double.Parse(liabilityOther.cash != null ? liabilityOther.cash : "0");

                            string iaothercash = liabilityOther.cash;
                            if (liabilityOther.cash != null && liabilityOther.cash != "")
                            {
                                iaothercash = double.Parse(liabilityOther.cash).ToString("#,##0.00");
                            }

                            members += "<tr class='" + classRow + "'><td width='60%' align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + liabilityOther.liabilityDesc + "</td><td width='40%' align='right'>" +"$ "+ iaothercash + "</td></tr>";
                        }
                        
                        //members = "<table width='100%'>";
                        /*foreach (liabilityOther liabilityOther in assetAndLiability.liabilityOthers)
                        {
                            otherLiabilitiesValue += double.Parse(liabilityOther.cash != null ? liabilityOther.cash : "0");

                            members += "<tr><td align='left'>" + liabilityOther.liabilityDesc + "</td><td align='center'>" + liabilityOther.cash + "</td></tr>";

                        }*/
                        //members += "</table>";
                        contents = contents.Replace("[othersLiabilities]", members);
                    }

                    totalLiabilitiesForPdf += otherLiabilitiesValue;

                    contents = contents.Replace("[totalLiabilitiesOthers]", totalLiabilitiesForPdf.ToString("#,##0.00") + "");

                    
                }
                else
                {
                    contents = contents.Replace("[bankAcctCash]", string.Empty);
                    contents = contents.Replace("[cpfoaBal]", string.Empty);
                    contents = contents.Replace("[cpfsaBal]", string.Empty);
                    contents = contents.Replace("[srsBal]", string.Empty);
                    contents = contents.Replace("[cpfMedisaveBalance]", string.Empty);
                    contents = contents.Replace("[stocksSharesCash]", string.Empty);
                    contents = contents.Replace("[stocksSharesCpf]", string.Empty);
                    contents = contents.Replace("[unitTrustsCash]", string.Empty);
                    contents = contents.Replace("[unitTrustsCpf]", string.Empty);
                    contents = contents.Replace("[ilpCash]", string.Empty);
                    contents = contents.Replace("[ilpCpf]", string.Empty);
                    contents = contents.Replace("[srsInvCash]", string.Empty);
                    contents = contents.Replace("[invPropCash]", string.Empty);
                    contents = contents.Replace("[invPropCpf]", string.Empty);
                    contents = contents.Replace("[resPropCash]", string.Empty);
                    contents = contents.Replace("[resPropCpf]", string.Empty);
                    contents = contents.Replace("[homeMortgage]", string.Empty);
                    contents = contents.Replace("[vehicleLoan]", string.Empty);
                    contents = contents.Replace("[cashLoan]", string.Empty);
                    contents = contents.Replace("[creditCard]", string.Empty);
                    contents = contents.Replace("[netWorth]", string.Empty);
                    contents = contents.Replace("[regularSumCash]", string.Empty);
                    contents = contents.Replace("[lumpSumCash]", string.Empty);
                    contents = contents.Replace("[regularSumCpf]", string.Empty);
                    contents = contents.Replace("[lumpSumCpf]", string.Empty);
                    contents = contents.Replace("[totalLiabilitiesOthers]", string.Empty);

                    contents = contents.Replace("[totalCash]", string.Empty);
                    contents = contents.Replace("[totalCpf]", string.Empty);


                    contents = contents.Replace("[totalAssetsCash]", string.Empty);
                    contents = contents.Replace("[totalAssetsCpf]", string.Empty);
                    
                    string members = "";

                    contents = contents.Replace("[othersInvestedAssets]", members);

                    contents = contents.Replace("[othersPersonalUse]", members);

                    contents = contents.Replace("[othersLiabilities]", members);
                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createAssetAndLiabilitiesPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
         
        }

        public string createCkaPdf(string caseId)
        {
            try
            {
               // string path = baseUrl + "CkaPrint.html";
                string tick_mark = baseUrl + "tick_01a.jpg";
                string tick = "<img src='" + tick_mark + "' width='10 height='10' />";
                string tick_noMark = baseUrl + "tick_01b.jpg";
                string tickNo = "<img src='" + tick_noMark + "' width='10 height='10' />";

                string SelectedRadio = baseUrl + "RadioButtonSelected.png";
                string selectedRadioBtn = "<img src='" + SelectedRadio + "' height = '8.4px' />";

                string NotSelectedRadio = baseUrl + "RadioButtonNotSelected.png";
                string NotSelectedRadioBtn = "<img src='" + NotSelectedRadio + "' height = '8.4px'/>";

                string contents = CKA_Path;
                
                CkaDao dao = new CkaDao();

                Stopwatch stpwatchCKA = Stopwatch.StartNew();

                CkaAssessment ckaAnalysis = dao.getCkaProfile(caseId);
                stpwatchCKA.Stop();
                writeLog(activityStatus, "", "Time taken for cka db call", stpwatchCKA.ElapsedMilliseconds);


                if (ckaAnalysis != null)
                {

                    if (ckaAnalysis.agreeCKA == "true")
                    {
                        contents = contents.Replace("[A1]", selectedRadioBtn);
                        contents = contents.Replace("[A2]", NotSelectedRadioBtn);
                    }
                    else if (ckaAnalysis.disagreeCKA == "true")
                    {
                        contents = contents.Replace("[A1]", NotSelectedRadioBtn);
                        contents = contents.Replace("[A2]", selectedRadioBtn);
                    }
                    else
                    {
                        contents = contents.Replace("[A1]", NotSelectedRadioBtn);
                        contents = contents.Replace("[A2]", NotSelectedRadioBtn);
                    }

                    if (ckaAnalysis.investmentExperienceOption1 != null)
                    {
                        if (ckaAnalysis.investmentExperienceOption1 == "true")
                            contents = contents.Replace("[A4]", "Yes");
                        contents = contents.Replace("[A4Reason]", "<br />" + "Details: "+ckaAnalysis.investmentExperienceList);
                    }
                    else if (ckaAnalysis.investmentExperienceOption2 != null)
                    {
                        if (ckaAnalysis.investmentExperienceOption2 == "true")
                            contents = contents.Replace("[A4]", "No");
                    }
                    else
                    {
                        contents = contents.Replace("[A4]", "");
                    }

                    if (ckaAnalysis.workingExperienceOption1 != null)
                    {
                        if (ckaAnalysis.workingExperienceOption1 == "true")
                            contents = contents.Replace("[A5]", "Yes");
                        contents = contents.Replace("[A5Reason]", "<br />" + "Details: " + ckaAnalysis.workingExperienceList);
                    }
                    else if (ckaAnalysis.workingExperienceOption2 != null)
                    {
                        if (ckaAnalysis.workingExperienceOption2 == "true")
                            contents = contents.Replace("[A5]", "No");
                    }
                    else
                    {
                        contents = contents.Replace("[A5]", "");
                    }


                    if (ckaAnalysis.educationalExperienceOption1 != null)
                    {
                        if (ckaAnalysis.educationalExperienceOption1 == "true")
                            contents = contents.Replace("[A6]", "Yes");
                        contents = contents.Replace("[A6Reason]", "<br />" + "Details: " + ckaAnalysis.educationalExperienceList);
                    }
                    else if (ckaAnalysis.educationalExperienceOption2 != null)
                    {
                        if (ckaAnalysis.educationalExperienceOption2 == "true")
                            contents = contents.Replace("[A6]", "No");
                    }
                    else
                    {
                        contents = contents.Replace("[A6]", "");
                    }

                    string cont = "";

                    if (ckaAnalysis.csaOutcomeOption1 == "true")
                    {
                        cont = tick + " If you have answered 'Yes' to any one of the four questions above, we are pleased to inform you that you may purchase any ILPs without the need of any advice from your Zurich Adviser, as you possess the relevant knowledge or experience to understand the risks and features of ILPs.";
                        cont += " <br/>";
                        cont += "If you have answered 'No' to All the four questions above, you are deemed to not possess the relevant knowledge or experience in ILPs. If you wish to purchase an ILP, your Zurich Adviser must provide advice to you before you can proceed with the purchase.";

                        contents = contents.Replace("[A7]", tick);
                        contents = contents.Replace("[A8]", tickNo);
                        //contents = contents.Replace("[A8]", cont);
                    }
                    else if (ckaAnalysis.csaOutcomeOption2 == "true")
                    {
                        cont = " If you have answered 'Yes' to any one of the four questions above, we are pleased to inform you that you may purchase any ILPs without the need of any advice from your Zurich Adviser, as you possess the relevant knowledge or experience to understand the risks and features of ILPs.";
                        cont += " <br/>";
                        cont += tick + "If you have answered 'No' to All the four questions above, you are deemed to not possess the relevant knowledge or experience in ILPs. If you wish to purchase an ILP, your Zurich Adviser must provide advice to you before you can proceed with the purchase.";
                        //contents = contents.Replace("[A7]", tick);
                        //contents = contents.Replace("[A8]", cont);
                        contents = contents.Replace("[A7]", tickNo);
                        contents = contents.Replace("[A8]", tick);
                    }
                    else
                    {
                        contents = contents.Replace("[A7]", tickNo);
                        contents = contents.Replace("[A8]", tickNo);
                    }

                }
                else
                {
                    contents = contents.Replace("[A1]", NotSelectedRadioBtn);
                    contents = contents.Replace("[A2]", NotSelectedRadioBtn);
                    contents = contents.Replace("[A3]", "");
                    contents = contents.Replace("[A4]", "");
                    contents = contents.Replace("[A4Reason]", "");
                    contents = contents.Replace("[A5]", "");
                    contents = contents.Replace("[A5Reason]", "");
                    contents = contents.Replace("[A6]", "");
                    contents = contents.Replace("[A6Reason]", "");
                    contents = contents.Replace("[A7]", tickNo);
                    contents = contents.Replace("[A8]", tickNo);
                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createCkaPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;

        }


        public string createPrioritiesPdf(string caseId)
        {
            try
            {
                string contents = priorityDetail_Path;
                PriorityDetailsDAO priorityDetailDAO = new PriorityDetailsDAO();
                Stopwatch stpwatch = Stopwatch.StartNew(); 
                priorityDetail detail = priorityDetailDAO.getPriorityDetails(caseId);
                stpwatch.Stop();
                writeLog(activityStatus, "", "Time taken for priority details db call", stpwatch.ElapsedMilliseconds);

                if (detail != null)
                {
                    contents = contents.Replace("[priorityNeed1]", (detail.protection1 != null ? detail.protection1 : string.Empty));
                    contents = contents.Replace("[priorityNeed2]", (detail.protection2 != null ? detail.protection2 : string.Empty));
                    contents = contents.Replace("[priorityNeed3]", (detail.protection3 != null ? detail.protection3 : string.Empty));
                    contents = contents.Replace("[priorityNeed7]", (detail.protection4 != null ? detail.protection4 : string.Empty));
                    contents = contents.Replace("[priorityNeed8]", (detail.protection5 != null ? detail.protection5 : string.Empty));
                    contents = contents.Replace("[priorityNeed4]", (detail.savings1 != null ? detail.savings1 : string.Empty));
                    contents = contents.Replace("[priorityNeed5]", (detail.savings2 != null ? detail.savings2 : string.Empty));
                    contents = contents.Replace("[priorityNeed6]", (detail.savings3 != null ? detail.savings3 : string.Empty));                    
                }
                else
                {
                    contents = contents.Replace("[priorityNeed1]", string.Empty);
                    contents = contents.Replace("[priorityNeed2]", string.Empty);
                    contents = contents.Replace("[priorityNeed3]", string.Empty);
                    contents = contents.Replace("[priorityNeed7]", string.Empty);
                    contents = contents.Replace("[priorityNeed4]", string.Empty);
                    contents = contents.Replace("[priorityNeed5]", string.Empty);
                    contents = contents.Replace("[priorityNeed6]", string.Empty);
                    contents = contents.Replace("[priorityNeed8]", string.Empty);
                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createPrioritiesPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }

        public string createHeader()
        {
           // string path = baseUrl + "Header.html";
            string content = header_Path;
            return content;
        }

        public string createFooter()
        {
           // string path = baseUrl + "Footer.html";
            string content = footer_Path;
            return content;
        }

        public string createPersonalDetailPdf(string caseId)
        {

            try
            {
                string contents = personalDetail_Path;
                PersonalDetailsDAO personalDetailsDAO = new PersonalDetailsDAO();
                Stopwatch stpwtch = Stopwatch.StartNew();
                personaldetail detail = personalDetailsDAO.getPersonalDetail(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for personal details db call", stpwtch.ElapsedMilliseconds);

                if (detail != null)
                {
                    contents = contents.Replace("[title]", (detail.title != null ? detail.title : string.Empty));
                    contents = contents.Replace("[name]", (detail.name != null ? detail.name : string.Empty));
                    contents = contents.Replace("[surname]", (detail.surname != null ? detail.surname : string.Empty));
                    contents = contents.Replace("[gender]", (detail.gender != null ? detail.gender : string.Empty));
                    contents = contents.Replace("[passportnumber]", (detail.nric != null ? detail.nric : string.Empty));
                    contents = contents.Replace("[nationality]", (detail.nationality != null ? detail.nationality : string.Empty));
                    contents = contents.Replace("[maritalstatus]", (detail.maritalstatus != null ? detail.maritalstatus : string.Empty));
                    contents = contents.Replace("[isSmoker]", (detail.issmoker != null ? detail.issmoker : string.Empty));
                    contents = contents.Replace("[residentialAddress]", (detail.address != null ? detail.address.Replace("\r\n", "<br />") : string.Empty));
                    contents = contents.Replace("[employmentStatus]", (detail.employmentstatus != null ? detail.employmentstatus : string.Empty));
                    contents = contents.Replace("[occupation]", (detail.occupation != null ? detail.occupation : string.Empty));
                    contents = contents.Replace("[companyName]", (detail.companyname != null ? detail.companyname.Replace("\r\n", "<br />") : string.Empty));
                    contents = contents.Replace("[contactNumber]", ((detail.contactnumber != null && detail.contactnumber != "") ? (detail.contactnumber + " (Home)<br/>") : string.Empty));
                    contents = contents.Replace("[contactNumberFax]", ((detail.contactnumberfax != null && detail.contactnumberfax != "") ? (detail.contactnumberfax+" (Fax)<br/>") : string.Empty));
                    contents = contents.Replace("[contactNumberHp]", ((detail.contactnumberhp != null && detail.contactnumberhp != "") ? (detail.contactnumberhp + " (HP)<br/>") : string.Empty));
                    contents = contents.Replace("[contactNumberOffice]", ((detail.contactnumberoffice != null && detail.contactnumberoffice != "") ? (detail.contactnumberoffice + " (Office)<br/>") : string.Empty));
                    contents = contents.Replace("[emailId]", (detail.email != null ? detail.email : string.Empty));
                    contents = contents.Replace("[educationalLevel]", (detail.educationlevel != null ? detail.educationlevel : string.Empty));
                    contents = contents.Replace("[datepicker]", (detail.datepicker != null ? detail.datepicker : string.Empty));
                    contents = contents.Replace("[medicalCondition]", (detail.medicalcondition != null ? detail.medicalcondition : string.Empty));
                    if (detail.medicalcondition != null)
                    {
                        if(detail.medicalcondition =="No")
                            contents = contents.Replace("[medicalConditionDetails]", string.Empty);
                        else
                            contents = contents.Replace("[medicalConditionDetails]", (detail.medicalconditiondetails != null ? detail.medicalconditiondetails.Replace("\r\n", "<br />") : string.Empty));
                    }
                    else
                        contents = contents.Replace("[medicalConditionDetails]", string.Empty);
                    
                    
                    contents = contents.Replace("[nominee]", (detail.nominee != null ? detail.nominee : string.Empty));
                    contents = contents.Replace("[isWill]", (detail.will != null ? detail.will : string.Empty));

                    if (detail.familyDetailsRequired != null)
                    {
                        if (detail.familyDetailsRequired == "1")
                            contents = contents.Replace("[FamilyDetailsRequired]", ("Yes"));
                        else                        
                            contents = contents.Replace("[FamilyDetailsRequired]", ("No"));
                    }
                    else
                        contents = contents.Replace("[FamilyDetailsRequired]", string.Empty);

                    contents = createSpokenLanguagePDF(detail, contents);
                    contents = createWrittenLanguagePDF(detail, contents);

                    if (detail.accompanyQuestion != null)
                    {
                        if (detail.accompanyQuestion == "1")
                            contents = contents.Replace("[AccompanyQuestion]", ("Yes"));
                        else
                            contents = contents.Replace("[AccompanyQuestion]", ("No"));
                    }
                    else
                        contents = contents.Replace("[AccompanyQuestion]", string.Empty);

                    contents = contents.Replace("[TrustedIndividualName]", (detail.trustedIndividualName != null ? detail.trustedIndividualName : string.Empty));
                    contents = contents.Replace("[ClientRelationship]", (detail.clientRelationship != null ? detail.clientRelationship : string.Empty));
                    contents = contents.Replace("[NRICAccompany]", (detail.NRICAccompany != null ? detail.NRICAccompany : string.Empty));
                    //contents = contents.Replace("[NoAccompaniedIndividualReason]", (detail.noAccompaniedIndividualReason != null ? detail.noAccompaniedIndividualReason : string.Empty));

                    string members = "";
                    if (detail.familyMemberDetails != null && detail.familyMemberDetails.Count>0)
                    {
                        for (int i = 0; i < detail.familyMemberDetails.Count; i++)
                        {
                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";

                            familyMemberDetail m = detail.familyMemberDetails[i];

                            string mincome = m.monthlyIncome;
                            if (m.monthlyIncome != null && m.monthlyIncome != "")
                            {
                                mincome = double.Parse(m.monthlyIncome).ToString("#,##0.00");
                            }

                            members += "<tr class='" + classRow + "'><td align='center'>" + m.name + "</td><td align='center'>" + m.relationship + "</td><td align='center'>" +
                            m.dob + "</td><td align='center'>" + m.occupation + "</td><td align='center'>"
                            + "$ " + mincome + "</td><td align='center'>" + m.yrstosupport + " </td></tr>";
                        }

                        /*foreach(familyMemberDetail m in detail.familyMemberDetails)
                        {
                            members += "<tr class='tableRowStyle'><td align='center'>" + m.name + "</td><td align='center'>" + m.relationship + "</td><td align='center'>" +
                            m.dob + "</td><td align='center'>" + m.occupation + "</td><td align='center'>"
                            + m.monthlyIncome + "</td><td align='center'>"+ m.yrstosupport +" </td></tr>";
                        }*/
                    }
                    else
                    {
                        members += "<tr class='evenRowStyle'><td align='left'>" + string.Empty + "</td><td align='left'>" + string.Empty + "</td><td align='left'>" +
                            string.Empty + "</td><td align='left'>" + string.Empty + "</td><td align='center'>"
                            + "$ " + string.Empty + "</td><td align='center'>" + string.Empty + " </td></tr>";
                    }
                    contents = contents.Replace("[members]", members);
                }
                else
                {
                    contents = contents.Replace("[title]", string.Empty);
                    contents = contents.Replace("[name]", string.Empty);
                    contents = contents.Replace("[surname]", string.Empty);
                    contents = contents.Replace("[gender]", string.Empty);
                    contents = contents.Replace("[passportnumber]", string.Empty);
                    contents = contents.Replace("[nationality]", string.Empty);
                    contents = contents.Replace("[maritalstatus]", string.Empty);
                    contents = contents.Replace("[isSmoker]", string.Empty);
                    contents = contents.Replace("[residentialAddress]", string.Empty);
                    contents = contents.Replace("[employmentStatus]", string.Empty);
                    contents = contents.Replace("[occupation]", string.Empty);
                    contents = contents.Replace("[companyName]", string.Empty);
                    contents = contents.Replace("[contactNumber]", string.Empty);
                    contents = contents.Replace("[contactNumberFax]", string.Empty);
                    contents = contents.Replace("[contactNumberHp]", string.Empty);
                    contents = contents.Replace("[contactNumberOffice]", string.Empty);
                    contents = contents.Replace("[emailId]", string.Empty);
                    contents = contents.Replace("[educationalLevel]", string.Empty);
                    contents = contents.Replace("[datepicker]", string.Empty);
                    contents = contents.Replace("[medicalCondition]", string.Empty);
                    contents = contents.Replace("[medicalConditionDetails]", string.Empty);
                    contents = contents.Replace("[nominee]", string.Empty);
                    contents = contents.Replace("[isWill]", string.Empty);
                    string members = "";
                    contents = contents.Replace("[members]", members);
                    contents = contents.Replace("[FamilyDetailsRequired]", string.Empty);
                    contents = contents.Replace("[AccompanyQuestion]", string.Empty);
                    contents = contents.Replace("[TrustedIndividualName]", string.Empty);
                    contents = contents.Replace("[ClientRelationship]", string.Empty);
                    contents = contents.Replace("[NRICAccompany]", string.Empty);
                    //contents = contents.Replace("[NoAccompaniedIndividualReason]", string.Empty);
                    contents = contents.Replace("[othersSpokenTxt]", string.Empty);
                    contents = contents.Replace("[othersWrittenTxt]", string.Empty);

                    string tick_noMark = baseUrl + "tick_01b.jpg";
                    string tickNo = "<img src='" + tick_noMark + "' alt='' width='10' height='10'";

                    contents = contents.Replace("[tickSpokenEnglish]", tickNo);
                    contents = contents.Replace("[tickSpokenMandarin]", tickNo);
                    contents = contents.Replace("[tickhSpokenMalay]", tickNo);
                    contents = contents.Replace("[tickhSpokenTamil]", tickNo);
                    contents = contents.Replace("[tickSpokenOthers]", tickNo);

                    contents = contents.Replace("[tickWrittenEnglish]", tickNo);
                    contents = contents.Replace("[tickWrittenMandarin]", tickNo);
                    contents = contents.Replace("[tickWrittenMalay]", tickNo);
                    contents = contents.Replace("[tickWrittenTamil]", tickNo);
                    contents = contents.Replace("[tickWrittenOthers]", tickNo);

                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createPersonalDetailPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
            
        }

        private string createSpokenLanguagePDF(personaldetail detail, string contents)
        {
            bool tickSpokenEnglish = false;
            bool tickSpokenMandarin = false;
            bool tickhSpokenMalay = false;
            bool tickhSpokenTamil = false;
            bool othersChecked = false;

            string tick_mark = baseUrl + "tick_01a.jpg";
            string tick = "<img src='" + tick_mark + "' alt='' width='10' height='10'";
            string tick_noMark = baseUrl + "tick_01b.jpg";
            string tickNo = "<img src='" + tick_noMark + "' alt='' width='10' height='10'";
            
            string spokenLanguage = detail.spokenLanguage;

            char[] delimiterChars = { ',' };
            string[] words = spokenLanguage.Split(delimiterChars);

            if (detail.spokenLanguage != null && detail.spokenLanguage.Length > 0)
            {
                foreach (string s in words)
                {
                    if (s == "0")
                    {
                        contents = contents.Replace("[tickSpokenEnglish]", tick);
                        tickSpokenEnglish = true;
                    }

                    if (s == "1")
                    {
                        contents = contents.Replace("[tickSpokenMandarin]", tick);
                        tickSpokenMandarin = true;
                    }

                    if (s == "2")
                    {
                        contents = contents.Replace("[tickhSpokenMalay]", tick);
                        tickhSpokenMalay = true;
                    }

                    if (s == "3")
                    {
                        contents = contents.Replace("[tickhSpokenTamil]", tick);
                        tickhSpokenTamil = true;
                    }

                    if (s == "4")
                    {
                        string otherstxt = "";

                        contents = contents.Replace("[tickSpokenOthers]", tick);

                        othersChecked = true;

                        if (detail.spokenLanguageOtherstxt != null)
                        {
                            otherstxt = detail.spokenLanguageOtherstxt;
                        }
                        contents = contents.Replace("[othersSpokenTxt]", removeLineBreak(otherstxt));
                    }

                }

            }

            if (tickSpokenEnglish == false)
            {
                contents = contents.Replace("[tickSpokenEnglish]", tickNo);
            }
            if (tickSpokenMandarin == false)
            {
                contents = contents.Replace("[tickSpokenMandarin]", tickNo);
            }
            if (tickhSpokenMalay == false)
            {
                contents = contents.Replace("[tickhSpokenMalay]", tickNo);
            }
            if (tickhSpokenTamil == false)
            {
                contents = contents.Replace("[tickhSpokenTamil]", tickNo);
            }
            if (othersChecked == false)
            {
                contents = contents.Replace("[tickSpokenOthers]", tickNo);
                contents = contents.Replace("[othersSpokenTxt]", string.Empty);
            }

            return contents;
        }

        private string createWrittenLanguagePDF(personaldetail detail, string contents)
        {
            bool tickWrittenEnglish = false;
            bool tickWrittenMandarin = false;
            bool tickWrittenMalay = false;
            bool tickWrittenTamil = false;
            bool othersChecked = false;

            string tick_mark = baseUrl + "tick_01a.jpg";
            string tick = "<img src='" + tick_mark + "' alt='' width='10' height='10'";
            string tick_noMark = baseUrl + "tick_01b.jpg";
            string tickNo = "<img src='" + tick_noMark + "' alt='' width='10' height='10'";

            string writtenLanguage = detail.writtenLanguage;

            char[] delimiterChars = { ',' };
            string[] words = writtenLanguage.Split(delimiterChars);

            if (detail.writtenLanguage != null && detail.writtenLanguage.Length > 0)
            {
                foreach (string s in words)
                {
                    if (s == "0")
                    {
                        contents = contents.Replace("[tickWrittenEnglish]", tick);
                        tickWrittenEnglish = true;
                    }

                    if (s == "1")
                    {
                        contents = contents.Replace("[tickWrittenMandarin]", tick);
                        tickWrittenMandarin = true;
                    }

                    if (s == "2")
                    {
                        contents = contents.Replace("[tickWrittenMalay]", tick);
                        tickWrittenMalay = true;
                    }

                    if (s == "3")
                    {
                        contents = contents.Replace("[tickWrittenTamil]", tick);
                        tickWrittenTamil = true;
                    }

                    if (s == "4")
                    {
                        string otherstxt = "";

                        contents = contents.Replace("[tickWrittenOthers]", tick);

                        othersChecked = true;

                        if (detail.writtenLanguageOtherstxt != null)
                        {
                            otherstxt = detail.writtenLanguageOtherstxt;
                        }
                        contents = contents.Replace("[othersWrittenTxt]", removeLineBreak(otherstxt));
                    }

                }

            }

            if (tickWrittenEnglish == false)
            {
                contents = contents.Replace("[tickWrittenEnglish]", tickNo);
            }
            if (tickWrittenMandarin == false)
            {
                contents = contents.Replace("[tickWrittenMandarin]", tickNo);
            }
            if (tickWrittenMalay == false)
            {
                contents = contents.Replace("[tickWrittenMalay]", tickNo);
            }
            if (tickWrittenTamil == false)
            {
                contents = contents.Replace("[tickWrittenTamil]", tickNo);
            }
            if (othersChecked == false)
            {
                contents = contents.Replace("[tickWrittenOthers]", tickNo);
                contents = contents.Replace("[othersWrittenTxt]", string.Empty);
            }

            return contents;
        }


        public string createProtectionGoalsMyNeedsPDF(string caseId)
        {
            try
            {
                string contents = ProtectionGoalMyNeeds_Path;

                MyNeedsDAO myNeedsDAO = new MyNeedsDAO();
                Stopwatch stpwtch = Stopwatch.StartNew();
                myNeed myNeedObj = myNeedsDAO.getMyNeed(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for my needs db call", stpwtch.ElapsedMilliseconds);

                if (myNeedObj != null)
                {
                    string strCriticalIllNeeded = "";
                    if (myNeedObj.criticalIllnessPrNeeded == 2)
                    {
                        strCriticalIllNeeded = "Yes";
                    }
                    else if (myNeedObj.criticalIllnessPrNeeded == 1)
                    {
                        strCriticalIllNeeded = "No";
                    }
                    else if (myNeedObj.criticalIllnessPrNeeded == 0)
                    {
                        strCriticalIllNeeded = "Not Applicable";
                    }
                    contents = contents.Replace("[planningNeededCriticalIll]", strCriticalIllNeeded);

                    string strDisabilityPrNeeded = "";
                    if (myNeedObj.disabilityPrNeeded == 2)
                    {
                        strDisabilityPrNeeded = "Yes";
                    }
                    else if (myNeedObj.disabilityPrNeeded == 1)
                    {
                        strDisabilityPrNeeded = "No";
                    }
                    else if (myNeedObj.disabilityPrNeeded == 0)
                    {
                        strDisabilityPrNeeded = "Not Applicable";
                    }
                    contents = contents.Replace("[planningNeededDisability]", strDisabilityPrNeeded);

                    string strhospitalCoverNeeded = "";
                    if (myNeedObj.hospitalmedCoverNeeded == 2)
                    {
                        strhospitalCoverNeeded = "Yes";
                    }
                    else if (myNeedObj.hospitalmedCoverNeeded == 1)
                    {
                        strhospitalCoverNeeded = "No";
                    }
                    else if (myNeedObj.hospitalmedCoverNeeded == 0)
                    {
                        strhospitalCoverNeeded = "Not Applicable";
                    }
                    contents = contents.Replace("[hospitalCoverNeeded]", strhospitalCoverNeeded);

                    string straccidentalCoverNeeded = "";
                    if (myNeedObj.accidentalhealthCoverNeeded == 2)
                    {
                        straccidentalCoverNeeded = "Yes";
                    }
                    else if (myNeedObj.accidentalhealthCoverNeeded == 1)
                    {
                        straccidentalCoverNeeded = "No";
                    }
                    else if (myNeedObj.accidentalhealthCoverNeeded == 0)
                    {
                        straccidentalCoverNeeded = "Not Applicable";
                    }
                    contents = contents.Replace("[accidentalCoverNeeded]", straccidentalCoverNeeded);
                    
                    contents = contents.Replace("[lumpsumRequiredForTreatment]", (myNeedObj.lumpSumRequiredForTreatment != null && myNeedObj.lumpSumRequiredForTreatment != "") ? double.Parse(myNeedObj.lumpSumRequiredForTreatment).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[criticalIllnessInsurance]", (myNeedObj.criticalIllnessInsurance != null && myNeedObj.criticalIllnessInsurance != "") ? double.Parse(myNeedObj.criticalIllnessInsurance).ToString("#,##0.00") : string.Empty);

                    contents = contents.Replace("[totalShortfallSurplusMyNeeds]", (myNeedObj.totalShortfallSurplusMyNeeds != null && myNeedObj.totalShortfallSurplusMyNeeds != "") ? Math.Abs(double.Parse(myNeedObj.totalShortfallSurplusMyNeeds)).ToString("#,##0.00") : string.Empty);

                    if (myNeedObj.totalShortfallSurplusMyNeeds != null && myNeedObj.totalShortfallSurplusMyNeeds != "")
                    {
                        double shortfallCriticalIllness = double.Parse(myNeedObj.totalShortfallSurplusMyNeeds);
                        if (shortfallCriticalIllness < 0)
                        {
                            contents = contents.Replace("[totalShortfallSurplusCriticalIllness]", "TOTAL(SHORTFALL)");
                            contents = contents.Replace("[shortfallSurplusciColour]", "red");
                        }
                        else if (shortfallCriticalIllness > 0)
                        {
                            contents = contents.Replace("[totalShortfallSurplusCriticalIllness]", "TOTAL(SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusciColour]", "black");
                        }
                        else
                        {
                            contents = contents.Replace("[totalShortfallSurplusCriticalIllness]", "TOTAL(SHORTFALL/SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusciColour]", "black");
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[totalShortfallSurplusCriticalIllness]", "TOTAL(SHORTFALL/SURPLUS)");
                        contents = contents.Replace("[shortfallSurplusciColour]", "black");
                    }



                    contents = contents.Replace("[monthlyIncomeDisabilityIncome]", (myNeedObj.disabilityProtectionReplacementIncomeRequired != null && myNeedObj.disabilityProtectionReplacementIncomeRequired != "") ? double.Parse(myNeedObj.disabilityProtectionReplacementIncomeRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[perOfIncomeCoverageRequired]", myNeedObj.disabilityYearsOfSupport != null ? myNeedObj.disabilityYearsOfSupport : string.Empty);
                    contents = contents.Replace("[monthlyCoverageRequired]", myNeedObj.inflationAdjustedReturns != null ? myNeedObj.inflationAdjustedReturns : string.Empty);
                    contents = contents.Replace("[disrepamtreq]", (myNeedObj.disabilityReplacementAmountRequired != null && myNeedObj.disabilityReplacementAmountRequired != "") ? double.Parse(myNeedObj.disabilityReplacementAmountRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[disabilityInsuranceMyNeeds]", (myNeedObj.disabilityInsurance != null && myNeedObj.disabilityInsurance != "") ? double.Parse(myNeedObj.disabilityInsurance).ToString("#,##0.00") : string.Empty);

                    if (myNeedObj.shortfallSurplusMyNeeds != null && myNeedObj.shortfallSurplusMyNeeds != "")
                    {
                        double shortfalldisab = double.Parse(myNeedObj.shortfallSurplusMyNeeds);
                        if (shortfalldisab < 0)
                        {
                            contents = contents.Replace("[disabilityTotallbl]", "TOTAL(SHORTFALL)");
                            contents = contents.Replace("[shortfallSurplusdisbColour]", "red");
                        }
                        else if (shortfalldisab > 0)
                        {
                            contents = contents.Replace("[disabilityTotallbl]", "TOTAL(SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusdisbColour]", "black");
                        }
                        else
                        {
                            contents = contents.Replace("[disabilityTotallbl]", "TOTAL(SHORTFALL/SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusdisbColour]", "black");
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[disabilityTotallbl]", "TOTAL(SHORTFALL/SURPLUS)");
                        contents = contents.Replace("[shortfallSurplusdisbColour]", "black");
                    }
                    contents = contents.Replace("[shortfallSurplusMyNeeds]", (myNeedObj.shortfallSurplusMyNeeds != null && myNeedObj.shortfallSurplusMyNeeds != "") ? Math.Abs(double.Parse(myNeedObj.shortfallSurplusMyNeeds)).ToString("#,##0.00") : string.Empty);
                    
                    contents = contents.Replace("[typeOfHospitalCoverage]", myNeedObj.typeOfHospitalCoverage != null ? myNeedObj.typeOfHospitalCoverage : string.Empty);

                    contents = contents.Replace("[replacementIncomeReq]", (myNeedObj.replacementIncomeRequired != null && myNeedObj.replacementIncomeRequired != "") ? double.Parse(myNeedObj.replacementIncomeRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[yrsofsupportReq]", myNeedObj.yearsOfSupportRequired != null ? myNeedObj.yearsOfSupportRequired : string.Empty);
                    contents = contents.Replace("[infladjReturns]", myNeedObj.inflatedAdjustedReturns != null ? myNeedObj.inflatedAdjustedReturns : string.Empty);
                    contents = contents.Replace("[repamtReq]", (myNeedObj.replacementAmountRequired != null && myNeedObj.replacementAmountRequired != "") ? double.Parse(myNeedObj.replacementAmountRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[ttlreq]", (myNeedObj.totalRequired != null && myNeedObj.totalRequired != "") ? double.Parse(myNeedObj.totalRequired).ToString("#,##0.00") : string.Empty);

                    if (myNeedObj.anyExistingPlans == null)
                    {
                        contents = contents.Replace("[anyExistingPlans]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[anyExistingPlans]", myNeedObj.anyExistingPlans == true ? "Yes" : "No");
                    }

                    contents = contents.Replace("[typeOfRoomCoverage]", myNeedObj.typeOfRoomCoverage != null ? myNeedObj.typeOfRoomCoverage.ToString() + " Bed" : string.Empty);

                    if (myNeedObj.coverageOldageYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow1]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow1]", myNeedObj.coverageOldageYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.epOldageYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow1]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow1]", myNeedObj.epOldageYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.coverageIncomeYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow2]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow2]", myNeedObj.coverageIncomeYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.epIncomeYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow2]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow2]", myNeedObj.epIncomeYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.coverageOutpatientYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow3]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow3]", myNeedObj.coverageOutpatientYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.epOutpatientYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow3]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow3]", myNeedObj.epOutpatientYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.coverageDentalYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow4]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow4]", myNeedObj.coverageDentalYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.epDentalYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow4]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow4]", myNeedObj.epDentalYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.coveragePersonalYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow5]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthCoverageRow5]", myNeedObj.coveragePersonalYesNo == true ? "Yes" : "No");
                    }

                    if (myNeedObj.epPersonalYesNo == null)
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow5]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[accidentHealthAnyExistingPlansRow5]", myNeedObj.epPersonalYesNo == true ? "Yes" : "No");
                    }


                    if (myNeedObj.coverageOutpatientMedExp == null)
                    {
                        contents = contents.Replace("[coverageOutpatientMedExp]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[coverageOutpatientMedExp]", myNeedObj.coverageOutpatientMedExp == true ? "Yes" : "No");
                    }
                    if (myNeedObj.epOutpatientMedExp == null)
                    {
                        contents = contents.Replace("[epOutpatientMedExp]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[epOutpatientMedExp]", myNeedObj.epOutpatientMedExp == true ? "Yes" : "No");
                    }
                    if (myNeedObj.coverageLossOfIncome == null)
                    {
                        contents = contents.Replace("[coverageLossOfIncome]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[coverageLossOfIncome]", myNeedObj.coverageLossOfIncome == true ? "Yes" : "No");
                    }
                    if (myNeedObj.epLossOfIncome == null)
                    {
                        contents = contents.Replace("[epLossOfIncome]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[epLossOfIncome]", myNeedObj.epLossOfIncome == true ? "Yes" : "No");
                    }
                    if (myNeedObj.coverageOldageDisabilities == null)
                    {
                        contents = contents.Replace("[coverageOldageDisabilities]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[coverageOldageDisabilities]", myNeedObj.coverageOldageDisabilities == true ? "Yes" : "No");
                    }
                    if (myNeedObj.epOldageDisabilities == null)
                    {
                        contents = contents.Replace("[epOldageDisabilities]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[epOldageDisabilities]", myNeedObj.epOldageDisabilities == true ? "Yes" : "No");
                    }
                    if (myNeedObj.coverageDentalExp == null)
                    {
                        contents = contents.Replace("[coverageDentalExp]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[coverageDentalExp]", myNeedObj.coverageDentalExp == true ? "Yes" : "No");
                    }
                    if (myNeedObj.epDentalExp == null)
                    {
                        contents = contents.Replace("[epDentalExp]", "");
                    }
                    else
                    {
                        contents = contents.Replace("[epDentalExp]", myNeedObj.epDentalExp == true ? "Yes" : "No");
                    }


                    contents = contents.Replace("[detailsOfExistingPlans]", myNeedObj.existingPlansDetail != null ? removeLineBreak(myNeedObj.existingPlansDetail) : string.Empty);
                }
                else
                {
                    contents = contents.Replace("[lumpsumRequiredForTreatment]", string.Empty);
                    contents = contents.Replace("[criticalIllnessInsurance]", string.Empty);
                    contents = contents.Replace("[existingAssetsMyneeds]", string.Empty);
                    contents = contents.Replace("[totalShortfallSurplusMyNeeds]", string.Empty);
                    contents = contents.Replace("[monthlyIncomeDisabilityIncome]", string.Empty);
                    contents = contents.Replace("[perOfIncomeCoverageRequired]", string.Empty);
                    contents = contents.Replace("[monthlyCoverageRequired]", string.Empty);
                    contents = contents.Replace("[disrepamtreq]", string.Empty);
                    contents = contents.Replace("[disabilityInsuranceMyNeeds]", string.Empty);
                    contents = contents.Replace("[existingAssetsMyneedspart2]", string.Empty);
                    contents = contents.Replace("[shortfallSurplusMyNeeds]", string.Empty);
                    contents = contents.Replace("[typeOfHospitalCoverage]", string.Empty);

                    contents = contents.Replace("[replacementIncomeReq]", string.Empty);
                    contents = contents.Replace("[yrsofsupportReq]", string.Empty);
                    contents = contents.Replace("[infladjReturns]", string.Empty);
                    contents = contents.Replace("[repamtReq]", string.Empty);
                    contents = contents.Replace("[ttlreq]", string.Empty);

                    contents = contents.Replace("[anyExistingPlans]", "");

                    contents = contents.Replace("[typeOfRoomCoverage]", string.Empty);

                    contents = contents.Replace("[accidentHealthCoverageRow1]", "");

                    contents = contents.Replace("[accidentHealthAnyExistingPlansRow1]", "");

                    contents = contents.Replace("[accidentHealthCoverageRow2]", "");

                    contents = contents.Replace("[accidentHealthAnyExistingPlansRow2]", "");

                    contents = contents.Replace("[accidentHealthCoverageRow3]", "");

                    contents = contents.Replace("[accidentHealthAnyExistingPlansRow3]", "");

                    contents = contents.Replace("[accidentHealthCoverageRow4]", "");

                    contents = contents.Replace("[accidentHealthAnyExistingPlansRow4]", "");

                    contents = contents.Replace("[accidentHealthCoverageRow5]", "");

                    contents = contents.Replace("[accidentHealthAnyExistingPlansRow5]", "");

                    contents = contents.Replace("[coverageOutpatientMedExp]", "");
                    contents = contents.Replace("[epOutpatientMedExp]", "");
                    contents = contents.Replace("[coverageLossOfIncome]", "");
                    contents = contents.Replace("[epLossOfIncome]", "");
                    contents = contents.Replace("[coverageOldageDisabilities]", "");
                    contents = contents.Replace("[epOldageDisabilities]", "");
                    contents = contents.Replace("[coverageDentalExp]", "");
                    contents = contents.Replace("[epDentalExp]", "");

                    contents = contents.Replace("[detailsOfExistingPlans]", string.Empty);

                    contents = contents.Replace("[totalShortfallSurplusCriticalIllness]", "TOTAL(SHORTFALL/SURPLUS)");

                    contents = contents.Replace("[disabilityTotallbl]", "TOTAL(SHORTFALL/SURPLUS)");

                    contents = contents.Replace("[shortfallSurplusciColour]", "black");
                    contents = contents.Replace("[shortfallSurplusdisbColour]", "black");
                }

                string eamyneedscritical = "";
                int counter = 0;

                double existingAssetsCriticalIllnessMyNeeds = 0;

                if (myNeedObj != null && myNeedObj.myNeedsCriticalAssets != null)
                {
                    for (int i = 0; i < myNeedObj.myNeedsCriticalAssets.Count; i++)
                    {
                        string classRow = "";
                        if ((i % 2) == 0)
                            classRow = "oddRowStyle";
                        else
                            classRow = "evenRowStyle";

                        string classCell = "";
                        if ((i % 2) == 0)
                            classCell = "oddRowStyleNoBorder";
                        else
                            classCell = "evenRowStyleNoBorder";


                        myNeedsCriticalAsset m = myNeedObj.myNeedsCriticalAssets[i];
                        existingAssetsCriticalIllnessMyNeeds += double.Parse((m.presentValue != null && m.presentValue != "") ? m.presentValue : "0");

                        string strpv = m.presentValue;
                        if (m.presentValue != null && m.presentValue != "")
                        {
                            strpv = double.Parse(m.presentValue).ToString("#,##0.00");
                        }

                        eamyneedscritical += "<tr class='" + classRow + "'><td align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + m.asset + "</td><td align='right'><table class='tableStyle'><tr><td align='left' class='" + classCell + "'>Less:</td><td align='right' class='" + classCell + "'>" + "$ " + strpv + "</td></tr></table></td></tr>";
                    }
                }

                contents = contents.Replace("[existingAssetsMyneeds]", existingAssetsCriticalIllnessMyNeeds + "");

                contents = contents.Replace("[eamyneedscritical]", eamyneedscritical);



                string eamyneedsdisable = "";
                counter = 0;
                double existingAssetsDisabilityProtectionMyNeeds = 0;
                if (myNeedObj != null && myNeedObj.myNeedsDisabilityAssets != null)
                {
                    for (int i = 0; i < myNeedObj.myNeedsDisabilityAssets.Count; i++)
                    {
                        string classRow = "";
                        if ((i % 2) == 0)
                            classRow = "oddRowStyle";
                        else
                            classRow = "evenRowStyle";
                        myNeedsDisabilityAsset m = myNeedObj.myNeedsDisabilityAssets[i];
                        existingAssetsDisabilityProtectionMyNeeds += double.Parse((m.presentValue != null && m.presentValue != "") ? m.presentValue : "0");

                        string strpv = m.presentValue;
                        if (m.presentValue != null && m.presentValue != "")
                        {
                            strpv = double.Parse(m.presentValue).ToString("#,##0.00");
                        }

                        eamyneedsdisable += "<tr class='" + classRow + "'><td align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + m.asset + "</td><td align='right'><table class='tableStyle'><tr><td align='left' class='oddRowStyleNoBorder'>Less:</td><td align='right' class='oddRowStyleNoBorder'> $" + strpv + "</td></tr></table></td></tr>";
                    }

                    contents = contents.Replace("[existingAssetsMyneedspart2]", existingAssetsDisabilityProtectionMyNeeds + "");
                }
                contents = contents.Replace("[eamyneedsdisable]", eamyneedsdisable);

                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createProtectionGoalsPDF()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }


        public string createProtectionGoalsPDF(string caseId)
        {
            try
            {

                string contents = ProtectionGoal_Path;

                FamilyNeedsDAO familyNeedsDAO = new FamilyNeedsDAO();
                Stopwatch stpwtch = Stopwatch.StartNew();
                familyNeed familyNeedObj = familyNeedsDAO.getFamilyNeed(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for family needs db call", stpwtch.ElapsedMilliseconds);

                if (familyNeedObj != null)
                {
                    string strFamilySelected = "";
                    string strMortgageNeeded = "";

                    if (familyNeedObj.familyIncPrNeeded == 2)
                    {
                        strFamilySelected = "Yes";
                    }
                    else if (familyNeedObj.familyIncPrNeeded == 1)
                    {
                        strFamilySelected = "No";
                    }
                    else if (familyNeedObj.familyIncPrNeeded == 0)
                    {
                        strFamilySelected = "Not Applicable";
                    }

                    if (familyNeedObj.mortgageNeeded == 2)
                    {
                        strMortgageNeeded = "Yes";
                    }
                    else if (familyNeedObj.mortgageNeeded == 1)
                    {
                        strMortgageNeeded = "No";
                    }
                    else if (familyNeedObj.mortgageNeeded == 0)
                    {
                        strMortgageNeeded = "Not Applicable";
                    }

                    contents = contents.Replace("[familyIncNeeded]", strFamilySelected);
                    contents = contents.Replace("[mortgageNeeded]", strMortgageNeeded);
                    
                    contents = contents.Replace("[replacementIncomeRequired]", (familyNeedObj.replacementIncomeRequired != null && familyNeedObj.replacementIncomeRequired != "") ? double.Parse(familyNeedObj.replacementIncomeRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[yearsOfSupportRequired]", familyNeedObj.yearsOfSupportRequired != null ? familyNeedObj.yearsOfSupportRequired : string.Empty);
                    contents = contents.Replace("[inflationAdjustedReturns]", familyNeedObj.inflationAdjustedReturns != null ? familyNeedObj.inflationAdjustedReturns : string.Empty);
                    contents = contents.Replace("[lumpSumRequired]", (familyNeedObj.lumpSumRequired != null && familyNeedObj.lumpSumRequired != "") ? double.Parse(familyNeedObj.lumpSumRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[otherLiabilities]", (familyNeedObj.otherLiabilities != null && familyNeedObj.otherLiabilities != "") ? double.Parse(familyNeedObj.otherLiabilities).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[emergencyFundsNeeded]", (familyNeedObj.emergencyFundsNeeded != null && familyNeedObj.emergencyFundsNeeded != "") ? double.Parse(familyNeedObj.emergencyFundsNeeded).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[finalExpenses]", (familyNeedObj.finalExpenses != null && familyNeedObj.finalExpenses != "") ? double.Parse(familyNeedObj.finalExpenses).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[otherFundingNeeds]", (familyNeedObj.otherFundingNeeds != null && familyNeedObj.otherFundingNeeds != "") ? double.Parse(familyNeedObj.otherFundingNeeds).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[otherComments]", familyNeedObj.otherComments != null ? familyNeedObj.otherComments : string.Empty);
                    contents = contents.Replace("[totalRequired]", (familyNeedObj.totalRequired != null && familyNeedObj.totalRequired != "") ? double.Parse(familyNeedObj.totalRequired).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[existingLifeInsurance]", (familyNeedObj.existingLifeInsurance != null && familyNeedObj.existingLifeInsurance != "") ? double.Parse(familyNeedObj.existingLifeInsurance).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[existingAssetsFamilyneeds]", (familyNeedObj.existingAssetsFamilyneeds != null && familyNeedObj.existingAssetsFamilyneeds != "") ? double.Parse(familyNeedObj.existingAssetsFamilyneeds).ToString("#,##0.00") : string.Empty);

                    if (familyNeedObj.totalShortfallSurplus != null && familyNeedObj.totalShortfallSurplus != "")
                    {
                        double shortfall = double.Parse(familyNeedObj.totalShortfallSurplus);
                        if (shortfall < 0)
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "red");
                            contents = contents.Replace("[shortfallSurplusValueColour]", "red");
                            contents = contents.Replace("[shortfallSurplus]", "TOTAL(SHORTFALL)");
                        }
                        else if(shortfall>0)
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "black");
                            contents = contents.Replace("[shortfallSurplusValueColour]", "black");
                            contents = contents.Replace("[shortfallSurplus]", "TOTAL(SURPLUS)");
                        }
                        else
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "black");
                            contents = contents.Replace("[shortfallSurplusValueColour]", "black");
                            contents = contents.Replace("[shortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                        }

                    }
                    else
                    {
                        contents = contents.Replace("[shortfallSurplusColour]", "black");
                        contents = contents.Replace("[shortfallSurplusValueColour]", "black");
                        contents = contents.Replace("[shortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                    }
                        

                    contents = contents.Replace("[totalShortfallSurplus]", (familyNeedObj.totalShortfallSurplus != null && familyNeedObj.totalShortfallSurplus != "") ? Math.Abs(double.Parse(familyNeedObj.totalShortfallSurplus)).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[mortgageOutstanding]", (familyNeedObj.mortgageProtectionOutstanding != null && familyNeedObj.mortgageProtectionOutstanding != "") ? double.Parse(familyNeedObj.mortgageProtectionOutstanding).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[mortgageInsurances]", (familyNeedObj.mortgageProtectionInsurances != null && familyNeedObj.mortgageProtectionInsurances != "") ? double.Parse(familyNeedObj.mortgageProtectionInsurances).ToString("#,##0.00") : string.Empty);
                    contents = contents.Replace("[mortgageInsurancesTotal]", (familyNeedObj.mortgageProtectionTotal != null && familyNeedObj.mortgageProtectionTotal != "") ? Math.Abs(double.Parse(familyNeedObj.mortgageProtectionTotal)).ToString("#,##0.00") : string.Empty);


                    if (familyNeedObj.mortgageProtectionTotal != null && familyNeedObj.mortgageProtectionTotal != "")
                    {
                        double mortgageProtectionShortfall = double.Parse(familyNeedObj.mortgageProtectionTotal);
                        if (mortgageProtectionShortfall < 0)
                        {
                            contents = contents.Replace("[mortgageProtectionShortfallSurplus]", "TOTAL(SHORTFALL)");
                            contents = contents.Replace("[shortfallSurplusmgColour]", "red");
                        }
                        else if (mortgageProtectionShortfall > 0)
                        {
                            contents = contents.Replace("[mortgageProtectionShortfallSurplus]", "TOTAL(SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusmgColour]", "black");
                        }
                        else
                        {
                            contents = contents.Replace("[mortgageProtectionShortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                            contents = contents.Replace("[shortfallSurplusmgColour]", "black");
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[mortgageProtectionShortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                        contents = contents.Replace("[shortfallSurplusmgColour]", "black");
                    }
                }
                    
                else
                {
                    contents = contents.Replace("[familyIncNeeded]", string.Empty);
                    contents = contents.Replace("[mortgageNeeded]", string.Empty);
                    contents = contents.Replace("[replacementIncomeRequired]", string.Empty);
                    contents = contents.Replace("[yearsOfSupportRequired]", string.Empty);
                    contents = contents.Replace("[inflationAdjustedReturns]", string.Empty);
                    contents = contents.Replace("[lumpSumRequired]", string.Empty);
                    contents = contents.Replace("[otherLiabilities]", string.Empty);
                    contents = contents.Replace("[emergencyFundsNeeded]", string.Empty);
                    contents = contents.Replace("[finalExpenses]", string.Empty);
                    contents = contents.Replace("[otherFundingNeeds]", string.Empty);
                    contents = contents.Replace("[otherComments]", string.Empty);
                    contents = contents.Replace("[totalRequired]", string.Empty);
                    contents = contents.Replace("[existingLifeInsurance]", string.Empty);
                    contents = contents.Replace("[existingAssetsFamilyneeds]", string.Empty);
                    contents = contents.Replace("[shortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                    contents = contents.Replace("[totalShortfallSurplus]", string.Empty);
                    contents = contents.Replace("[mortgageOutstanding]", string.Empty);
                    contents = contents.Replace("[mortgageInsurances]", string.Empty);
                    contents = contents.Replace("[mortgageInsurancesTotal]", string.Empty);
                    contents = contents.Replace("[mortgageProtectionShortfallSurplus]", "TOTAL(SHORTFALL/SURPLUS)");
                    contents = contents.Replace("[shortfallSurplusmgColour]", "black");
                    contents = contents.Replace("[shortfallSurplusColour]", "black");
                    contents = contents.Replace("[shortfallSurplusValueColour]", "black");
                }

                string eafamilyneeds = "";
                int counter = 0;

                if (familyNeedObj != null && familyNeedObj.familyNeedsAssets != null)
                {
                    for (int i = 0; i < familyNeedObj.familyNeedsAssets.Count; i++)
                    {
                        string classRow = "";
                        if ((i % 2) == 0)
                            classRow = "evenRowStyle";
                        else
                            classRow = "oddRowStyle";

                        string cellClass = "";
                        if ((i % 2) == 0)
                            cellClass = "evenRowStyleNoBorder";
                        else
                            cellClass = "oddRowStyleNoBorder";

                        familyNeedsAsset m = familyNeedObj.familyNeedsAssets[i];

                        string strpv = m.presentValue;
                        if (m.presentValue != null && m.presentValue != "")
                        {
                            strpv = double.Parse(m.presentValue).ToString("#,##0.00");
                        }
                        
                        eafamilyneeds += "<tr class='" + classRow +
                        "'><td align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
                        m.asset
                        + "</td><td><table class='tableStyle'><tr><td align='left' class='" + cellClass + "'>Less:</td><td align='right' class='" + cellClass + "'>" + "$ " + strpv + "</td></tr></table></td></tr>";
                    }
                }
                contents = contents.Replace("[eafamilyneeds]", eafamilyneeds);
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createProtectionGoalsPDF()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;

        }

        public string createPortFolioModelPDF(string caseId)
        {
            try
            {
                string strRiskProfileName = string.Empty;

                Stopwatch stpwtch = Stopwatch.StartNew();
                strRiskProfileName = GetRiskProfileName(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for getting risk profile name db call", stpwtch.ElapsedMilliseconds);

                if (strRiskProfileName != string.Empty)
                {
                    //string path = baseUrl + "PortFolioModelForRiskProfilePrint.html";
                    string contents = PortfolioModel_Path;

                    string CoreUrl = ChangeImageBasedOnSelection(strRiskProfileName, true);                    
                    string RateOfReturnsCoreImageHTMLTag = "<img src='" + CoreUrl + "' alt='' />";

                    string risk_image_core_assets = baseUrl + "Core_Assets.png";
                    string risk_image_non_core_assets = baseUrl + "Non_core_Assets.png";

                    string coreAssetsImage = "<img src='" + risk_image_core_assets + "' alt='' />";
                    string nonCoreAssetsImage = "<img src='" + risk_image_non_core_assets + "' alt='' />";

                    string CoreHeader = "<table width='100%' cellpadding = '0' cellspacing = '0' class = 'simpletableStyle'><tr width='100%' class='headerStyle'><td align='center' width='68%'>Range of Returns with Core Assets</td><td align='center' width='32%'>Strategic Assets Allocation</td></tr></table>";

                    contents = contents.Replace("[RangeOfReturnsCoreLabelText]", CoreHeader);
                    contents = contents.Replace("[PortFolioModelCoreImage]", RateOfReturnsCoreImageHTMLTag);

                    contents = contents.Replace("[coreAssetsImage]", coreAssetsImage);
                    contents = contents.Replace("[nonCoreAssetsImage]", nonCoreAssetsImage);

                    string NonCoreUrl = ChangeImageBasedOnSelection(strRiskProfileName, false);                    
                    string RateOfReturnsNonCoreImageHTMLTag = "<img src='" + NonCoreUrl + "' alt='' />";
                    string NonCoreHeader = "<table width='100%' cellpadding = '0' cellspacing = '0' class = 'simpletableStyle'><tr width='100%' class='headerStyle'><td align='center' width='68%'>Range of Returns with Non Core Assets</td><td align='center' width='32%'>Strategic Assets Allocation</td></tr></table>";

                    contents = contents.Replace("[RangeOfReturnsNonCoreLabelText]", NonCoreHeader);
                    contents = contents.Replace("[PortFolioModelNonCoreImage]", RateOfReturnsNonCoreImageHTMLTag);                    

                    return contents;
                }
                else
                {
                    return string.Empty;
                }
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createPortFolioModelPDF()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }
            return string.Empty;
        }

        private string GetRiskProfileName(string caseId)
        {
            string strRiskProfileName = string.Empty;
            RiskProfileDAO riskProfile = new RiskProfileDAO();
            RiskProfileAnalysis riskProfileDetails = riskProfile.getRiskProfileForCase(caseId);

            if (riskProfileDetails != null)
            {
                if (riskProfileDetails.riskProfileName != null)
                {
                    strRiskProfileName = riskProfileDetails.riskProfileName;
                }
            }

            return strRiskProfileName;
        }

        public string ChangeImageBasedOnSelection(string strRiskProfileName, bool IsCore)
        {
            //String url = "~/_layouts/Zurich/images/Content/PortFolioModelImages/";
            //String url = "C:/Zurich/PDFProject/WebApplication1/WebApplication1/Layouts/Zurich/images/Content/PortFolioModelImages/";
            String url = baseUrl;
            url = url.Replace("Printpages", "images/Content/PortFolioModelImages");
            try
            {

                String core_image = "";
                String non_core_image = "";

                switch (strRiskProfileName)
                {
                    case "Adventurous":
                        {                        
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_05Adventurous.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_05Adventurous.png";
                            break;
                        }
                    case "Balanced":
                        {                        
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_03Balanced.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_03Balanced.png";
                            break;
                        }
                    case "Cautious":
                        {                        
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_01Cautious.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_01Cautious.png";
                            break;
                        }
                    case "Moderately Adventurous":
                        {                       
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_04MAdventurous.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_04MAdventurous.png";
                            break;
                        }
                    case "Moderately Cautious":
                        {                        
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_02MCautious.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_02MCautious.png";
                            break;
                        }
                    default:
                        {                       
                            core_image = "CoreAssets/PortFolioModel_CoreAssets_01Cautious.png";
                            non_core_image = "NonCoreAssets/PortFolioModel_NonCoreAssets_01Cautious.png";
                            break;
                        }
                }

                String coreurl = url + core_image;
                String noncoreurl = url + non_core_image;

                if (IsCore == true)
                {
                    //lblLineGraph.Text = "Range of Returns with Core Assets";
                    //imgPortFolioModel.ImageUrl = coreurl;
                    return coreurl;
                }
                if (IsCore == false)
                {
                    //lblLineGraph.Text = "Range of Returns with Non Core Assets";
                    //imgPortFolioModel.ImageUrl = noncoreurl;
                    return noncoreurl;
                }

                return coreurl; 
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: ChangeImageBasedOnSelection()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }
        
        
        public string createPortfolioBuilderPDF(string caseId)
        {
            try
            {
                PortFolioModellingDAO portFolioBuilder = new PortFolioModellingDAO();

                Stopwatch stpwtch = Stopwatch.StartNew();
                DataTable dtPortFolioMaster = portFolioBuilder.getPortFolioMaster(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for getting portfolio master db call", stpwtch.ElapsedMilliseconds);

                if (dtPortFolioMaster != null && dtPortFolioMaster.Rows.Count > 0)
                {
                    string premium = dtPortFolioMaster.Rows[0]["premiumSelect"].ToString().Trim();
                    
                    string premiumAmount = "0";
                    if (dtPortFolioMaster.Rows[0]["premiumAmount"] != null && dtPortFolioMaster.Rows[0]["premiumAmount"].ToString() != string.Empty)
                        premiumAmount = double.Parse(dtPortFolioMaster.Rows[0]["premiumAmount"].ToString()).ToString("#,##0.00");
                    
                    string riskProfile = dtPortFolioMaster.Rows[0]["riskProfileName"].ToString();
                    string dbRiskProfileId = dtPortFolioMaster.Rows[0]["riskProfileId"].ToString();
                    string followAssetAllocationOnRiskProfile = dtPortFolioMaster.Rows[0]["followAssetAllocationOnRiskProfileYesNo"].ToString();
                    string nonCoreFunds = dtPortFolioMaster.Rows[0]["includeNonCoreFundsYesNo"].ToString();

                    string agreeWithRiskProfile = string.Empty;
                    if (dtPortFolioMaster.Rows[0]["agreeWithRiskProfile"] != null)
                    {
                        agreeWithRiskProfile = dtPortFolioMaster.Rows[0]["agreeWithRiskProfile"].ToString();
                    }
                    
                    string preferredRiskPRofile = dtPortFolioMaster.Rows[0]["preferredRiskPRofile"].ToString();
                    
                    string preferredRiskProfileName = string.Empty;
                    if (dtPortFolioMaster.Rows[0]["preferredRiskProfileName"] != null)
                    {
                        preferredRiskProfileName = dtPortFolioMaster.Rows[0]["preferredRiskProfileName"].ToString();
                    }
                    
                    string assetAllocationOnRiskProfileYesNo = dtPortFolioMaster.Rows[0]["assetAllocationOnRiskProfileYesNo"].ToString();
                    string strPreferredRiskProfileName = string.Empty;
                    string premiumPercent = dtPortFolioMaster.Rows[0]["premiumPercent"].ToString() + " %";

                    string totalPremiumAmount = "0";
                    if (dtPortFolioMaster.Rows[0]["premiumTotalAmount"] != null && dtPortFolioMaster.Rows[0]["premiumTotalAmount"].ToString() != string.Empty)
                        totalPremiumAmount = double.Parse(dtPortFolioMaster.Rows[0]["premiumTotalAmount"].ToString()).ToString("#,##0.00");
                    
                    if (agreeWithRiskProfile == "False")
                    {
                        strPreferredRiskProfileName = "<tr class='evenRowStyle'><td width='60%'>Your preferred Risk Profile if differs from profile</td><td width='40%' align='right'>" + preferredRiskProfileName + "</td></tr>";
                    }
    
                    int module;
                    if (followAssetAllocationOnRiskProfile == "True" || followAssetAllocationOnRiskProfile == "1")
                    {
                        string SelectedRadio = baseUrl + "RadioButtonSelected.png";
                        string selectedRadioBtn = "<img src='" + SelectedRadio + "' height = '9px' />";

                        string NotSelectedRadio = baseUrl + "RadioButtonNotSelected.png";
                        string NotSelectedRadioBtn = "<img src='" + NotSelectedRadio + "' height = '9px'/>";

                        followAssetAllocationOnRiskProfile = "Yes";

                        if (nonCoreFunds == "True")
                        {
                            followAssetAllocationOnRiskProfile = followAssetAllocationOnRiskProfile + "&nbsp;&nbsp;" + NotSelectedRadioBtn + "&nbsp;Core Funds&nbsp;&nbsp;" + selectedRadioBtn + "&nbsp;Non Core Funds";
                        }
                        else
                        {
                            followAssetAllocationOnRiskProfile = followAssetAllocationOnRiskProfile + "&nbsp;&nbsp;" + selectedRadioBtn + "&nbsp;Core Funds&nbsp;&nbsp;" + NotSelectedRadioBtn + "&nbsp;Non Core Funds";
                        }

                        module = 1;
                        //printAssetBasedPortfolioModel                 
                    }
                    else
                    {
                        string SelectedRadio = baseUrl + "RadioButtonSelected.png";
                        string selectedRadioBtn = "<img src='" + SelectedRadio + "' height = '8px'/>";

                        string NotSelectedRadio = baseUrl + "RadioButtonNotSelected.png";
                        string NotSelectedRadioBtn = "<img src='" + NotSelectedRadio + "' height = '8px'/>";

                        followAssetAllocationOnRiskProfile = "No";
                        if (assetAllocationOnRiskProfileYesNo == "True")
                        {
                            followAssetAllocationOnRiskProfile = followAssetAllocationOnRiskProfile + "&nbsp;&nbsp;" + selectedRadioBtn + "&nbsp;Funds Risk Plotter&nbsp;&nbsp;" + NotSelectedRadioBtn + "&nbsp;Fund Selection";                            
                        }
                        else
                        {
                            followAssetAllocationOnRiskProfile = followAssetAllocationOnRiskProfile + "&nbsp;&nbsp;" + NotSelectedRadioBtn + "&nbsp;Funds Risk Plotter&nbsp;&nbsp;" + selectedRadioBtn + "&nbsp;Fund Selection";
                        }
                        module = 2;
                        //printRiskPlotter 
                    }
                    
                    string strPaymentMode = string.Empty;
                    if (premium == "1")
                    {
                        string paymentModeText = string.Empty;
                        string paymentMode = dtPortFolioMaster.Rows[0]["paymentMode"].ToString();
                        
                        if (paymentMode == "1")
                        {
                            paymentModeText = "Monthly";
                        }
                        else if (paymentMode == "2")
                        {
                            paymentModeText = "Quarterly";
                        }
                        else if (paymentMode == "3")
                        {
                            paymentModeText = "SemiAnnual";
                        }
                        else if (paymentMode == "4")
                        {
                            paymentModeText = "Annual";
                        }

                        strPaymentMode = "<tr class='oddRowStyle'><td width='60%'>Premium Mode</td><td width='40%' align='right'>" + paymentModeText + "</td></tr>";
                    }

                    if (premium == "0")
                        premium = "Single Premium";
                    else
                        premium = "Regular Premium";

                    //dtPortFolioMaster.Rows[0]["premiumPercent"].ToString();
                   
                    DataTable dtPortFolioDetail = new DataTable ();
                    
                    if (module == 1)
                    {                                                    
                        string path = baseUrl + "PortfolioModelPrint.html";
                        string contents = System.IO.File.ReadAllText(path);
                                        
                        string portfolioModel = "";
                        string asset = "";

                        string strFinalRiskProfile = string.Empty;
                        if (agreeWithRiskProfile == "True")
                        {
                            strFinalRiskProfile = dbRiskProfileId;
                        }
                        if (agreeWithRiskProfile == "False")
                        {
                            strFinalRiskProfile = preferredRiskPRofile;
                        }

                        int riskProfileId = Convert.ToInt32(strFinalRiskProfile);

                        if (nonCoreFunds == "True")
                        {
                            dtPortFolioDetail = portFolioBuilder.getAllAssets(riskProfileId, 2, caseId, true);
                        }
                        else
                        {
                            dtPortFolioDetail = portFolioBuilder.getAllAssets(riskProfileId, 1, caseId, true);
                        }

                        int i = 0;
                        string usedAssetName = "";
                        foreach(DataRow dr in dtPortFolioDetail.Rows)
                        {
                            string fundId = dr["fund_id"].ToString();
                            string assetId = dr["asset_id"].ToString();
                            string fundName = dr["fundName"].ToString();
                            string assetName = dr["assetName"].ToString();                            
                            string percentageAllocation = dr["allocationPercentage"].ToString();
                                                       
                            string amountEntered = string.Empty;
                            if (dr["amount"].ToString() != null && dr["amount"].ToString() != "")
                            {
                                amountEntered = double.Parse(dr["amount"].ToString()).ToString("#,##0.00");
                            }                            
                             
                            /*if (assetId != asset)
                            {
                                portfolioModel += "<tr><td colspan=3 align='left' class='headerStyle'>" + assetName + "</td></tr>";
                                asset = assetId;
                            }
                            if (!percentageAllocation.Equals("0") && !percentageAllocation.Equals(""))
                            {
                                portfolioModel += "<tr class='tableRowStyle'><td width='60%'>" + fundName + "</td><td width='20%' align='right'>" + percentageAllocation + "</td><td width='20%' align='right'>" + amountEntered + "</td></tr>";
                            }*/

                            string classRow = "";
                            if ((i % 2) == 0)
                                classRow = "oddRowStyle";
                            else
                                classRow = "evenRowStyle";

                            if (!percentageAllocation.Equals("0") && !percentageAllocation.Equals(""))
                            {
                                
                                if (assetName != usedAssetName)
                                    portfolioModel += "<tr class='" + classRow + "'><td width='30%' align='left'>" + assetName + "</td><td width='30%'>" + fundName + "</td><td width='20%' align='right'>" + percentageAllocation + " %</td><td width='20%' align='right'>" +"$ "+ amountEntered + "</td></tr>";
                                else
                                    portfolioModel += "<tr class='" + classRow + "'><td width='30%' align='left'>" + " " + "</td><td width='30%'>" + fundName + "</td><td width='20%' align='right'>" + percentageAllocation + " %</td><td width='20%' align='right'>" + "$ " + amountEntered + "</td></tr>";

                                usedAssetName = assetName;
                                i++;
                            }

                        }

                        contents = contents.Replace("[portfolioModel]", portfolioModel);
                        contents = contents.Replace("[premium]", premium);
                        contents = contents.Replace("[PremiumMode]", strPaymentMode);                        
                        contents = contents.Replace("[premiumAmount]", premiumAmount);
                        contents = contents.Replace("[riskProfile]", riskProfile);
                        contents = contents.Replace("[PrefferedRiskProfile]", strPreferredRiskProfileName);                        
                        contents = contents.Replace("[followAssetAllocationOnRiskProfile]", followAssetAllocationOnRiskProfile);
                        contents = contents.Replace("[AllocationTotalPercentage]", premiumPercent);
                        contents = contents.Replace("[AllocationTotal]", totalPremiumAmount);

                        string rangeOfReturnsLabelText = string.Empty;
                        string RateOfReturnsImageHTMLTag = ShowRateOfReturnsImage(riskProfile, agreeWithRiskProfile, nonCoreFunds, preferredRiskProfileName, ref rangeOfReturnsLabelText);
                        contents = contents.Replace("[RangeOfReturnsLabelText]", rangeOfReturnsLabelText);

                        if (riskProfile == "Capital Preservation")
                        {
                            contents = contents.Replace("[PortFolioBuilderImage]", string.Empty);
                        }
                        else
                        {
                            contents = contents.Replace("[PortFolioBuilderImage]", RateOfReturnsImageHTMLTag);
                        }                         

                        return contents;
                    }
                    else 
                    {                       
                        string path = baseUrl + "RiskPlotterPrint.html";
                        string contents = System.IO.File.ReadAllText(path);
                                        
                        string portfolioModel = "";                                                               
                        bool allocationBasedOnRiskProfile = (bool)dtPortFolioMaster.Rows[0]["assetAllocationOnRiskProfileYesNo"];

                        //if allocationBasedOnRiskProfile = true then primary and secondary
                        if (allocationBasedOnRiskProfile == true)
                        {
                            string strFinalRiskProfile = string.Empty;
                            if (agreeWithRiskProfile == "True")
                            {
                                strFinalRiskProfile = dbRiskProfileId;
                            }
                            if (agreeWithRiskProfile == "False")
                            {
                                strFinalRiskProfile = preferredRiskPRofile;
                            }

                            int riskProfileId = Convert.ToInt32(strFinalRiskProfile);
                            
                            //Primary Funds
                            int i = 0;
                            dtPortFolioDetail = portFolioBuilder.getFunds(riskProfileId, 4, caseId, true);
                            foreach (DataRow dr in dtPortFolioDetail.Rows)
                            {                                
                                string fundName = dr["fundName"].ToString();
                                string assetName = dr["assetName"].ToString();
                                                             
                                string allocationPercentage = "";
                                string amount = "";

                                if (dr["allocationPercentage"] != null && dr["allocationPercentage"].ToString() != string.Empty)
                                    allocationPercentage = dr["allocationPercentage"].ToString() +" %";
                                                                                                
                                if (dr["amount"].ToString() != null && dr["amount"].ToString() != "")
                                {
                                    amount = double.Parse(dr["amount"].ToString()).ToString("#,##0.00");
                                }

                                string classRow = "";
                                if ((i % 2) == 0)
                                    classRow = "oddRowStyle";
                                else
                                    classRow = "evenRowStyle";
                                
                                if (allocationPercentage != null && allocationPercentage.Trim() != "" && allocationPercentage != "0")
                                    portfolioModel += "<tr class='" + classRow + "'><td width='30%'>" + assetName + "</td><td width='30%'>" + fundName + "</td><td width='20%' align='right'>" + allocationPercentage + "</td><td width='20%' align='right'>" + "$ " + amount + "</td></tr>";

                                i++;
                            }

                            //Secondary Funds
                            int cnt = 0;
                            int isec = 0;
                            dtPortFolioDetail = portFolioBuilder.getFunds(riskProfileId, 5, caseId, true);
                            foreach (DataRow dr in dtPortFolioDetail.Rows)
                            {
                                string fundName = dr["fundName"].ToString();
                                string assetName = dr["assetName"].ToString();

                                string allocationPercentage = "";
                                string amount = "";

                                if (dr["allocationPercentage"] != null && dr["allocationPercentage"].ToString() != string.Empty)
                                    allocationPercentage = dr["allocationPercentage"].ToString() +" %";
                                
                                
                                if (dr["amount"].ToString() != null && dr["amount"].ToString() != "")
                                {
                                    amount = double.Parse(dr["amount"].ToString()).ToString("#,##0.00");
                                }

                                string profilePercentage = string.Empty;
                                switch (strFinalRiskProfile)
                                {
                                    case "0":
                                        profilePercentage = "";
                                        break;
                                    case "1":
                                        profilePercentage = "15";
                                        break;
                                    case "2":
                                        profilePercentage = "25";
                                        break;
                                    case "3":
                                        profilePercentage = "35";
                                        break;
                                    case "4":
                                        profilePercentage = "45";
                                        break;
                                    case "5":
                                        profilePercentage = "55";
                                        break;
                                    default:
                                        profilePercentage = "";
                                        break;
                                }

                                if (allocationPercentage != null && allocationPercentage.Trim() != "" && allocationPercentage != "0")
                                {
                                    if (cnt == 0)
                                    {
                                        portfolioModel += "<tr width='100%' class='tableRow1Style'><td colspan='4' align='left'>Secondary Funds (Up to " + profilePercentage + "% limit)</td></tr>";
                                    }
                                    cnt = cnt + 1;

                                    string classRow = "";
                                    if ((isec % 2) == 0)
                                    {
                                        classRow = "oddRowStyle";
                                    }
                                    else
                                    {
                                        classRow = "evenRowStyle";
                                    }
                                    isec++;

                                    portfolioModel += "<tr class='"+classRow+"'><td width='25'>" + assetName + "</td><td width='45'>" + fundName + "</td><td width='15' align='right'>" + allocationPercentage + "</td><td width='15' align='right'>$ " + amount + "</td></tr>";
                                }
                            }
                        }
                        else //if allocationBasedOnRiskProfile = false then funds selection
                        {
                            dtPortFolioDetail = portFolioBuilder.getFundSelection(caseId, true);

                            int i = 0;
                            foreach (DataRow dr in dtPortFolioDetail.Rows)
                            {                                
                                string fundName = dr["fundName"].ToString();
                                string assetName = dr["assetName"].ToString();

                                string allocationPercentage = "";
                                string amount = "";

                                if (dr["allocationPercentage"] != null && dr["allocationPercentage"].ToString() != string.Empty)
                                    allocationPercentage = dr["allocationPercentage"].ToString() + " %";
                                
                                if (dr["amount"].ToString() != null && dr["amount"].ToString() != "")
                                {
                                    amount = double.Parse(dr["amount"].ToString()).ToString("#,##0.00");
                                }

                                string classRow = "";
                                if ((i % 2) == 0)
                                {
                                    classRow = "oddRowStyle";
                                }
                                else
                                {
                                    classRow = "evenRowStyle";
                                }
                                i++;
                                
                                if (allocationPercentage != null && allocationPercentage.Trim() != "" && allocationPercentage != "0")
                                    portfolioModel += "<tr class='"+classRow+"'><td width='25'>" + assetName + "</td><td width='45'>" + fundName + "</td><td width='15' align='right'>" + allocationPercentage + "</td><td width='15' align='right'>$ " + amount + "</td></tr>";
                                                            
                            }
                        }                       
                                                
                        contents = contents.Replace("[portfolioModel]", portfolioModel);
                        contents = contents.Replace("[premium]", premium);
                        contents = contents.Replace("[PremiumMode]", strPaymentMode);
                        contents = contents.Replace("[premiumAmount]", premiumAmount);
                        contents = contents.Replace("[riskProfile]", riskProfile);
                        contents = contents.Replace("[PrefferedRiskProfile]", strPreferredRiskProfileName);
                        contents = contents.Replace("[followAssetAllocationOnRiskProfile]", followAssetAllocationOnRiskProfile);
                        contents = contents.Replace("[AllocationTotalPercentage]", premiumPercent);
                        contents = contents.Replace("[AllocationTotal]", totalPremiumAmount); 

                        string rangeOfReturnsLabelText = string.Empty;
                        string RateOfReturnsImageHTMLTag = ShowRateOfReturnsImage(riskProfile, agreeWithRiskProfile, nonCoreFunds, preferredRiskProfileName, ref rangeOfReturnsLabelText);
                        contents = contents.Replace("[RangeOfReturnsLabelText]", rangeOfReturnsLabelText);
                        if (riskProfile == "Capital Preservation")
                        {
                            contents = contents.Replace("[PortFolioBuilderImage]", string.Empty);
                        }
                        else
                        {
                            contents = contents.Replace("[PortFolioBuilderImage]", RateOfReturnsImageHTMLTag);
                        }
                                                

                        return contents;
                    }
                }
                
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createGAPSummaryPDF()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }

        private string ShowRateOfReturnsImage(string riskProfile, string agreeWithRiskProfile, string nonCoreFunds, string PreferredRiskProfileName, ref string rangeOfReturnsText)
        {   
            string imgRangeOfReturnsURL = string.Empty;
            try
            {
                //string baseUrl = Server.MapPath("~/_layouts/Zurich/Printpages/");
                
                //String coreUrl = "C:/Zurich/PDFProject/WebApplication1/WebApplication1/Layouts/Zurich/images/Content/RangeOfReturnsImages/CoreAssets/";
                //String nonCoreUrl = "C:/Zurich/PDFProject/WebApplication1/WebApplication1/Layouts/Zurich/images/Content/RangeOfReturnsImages/NonCoreAssets/";
                
                //String coreUrl = "~/_layouts/Zurich/images/Content/RangeOfReturnsImages/CoreAssets/";
                //String nonCoreUrl = "~/_layouts/Zurich/images/Content/RangeOfReturnsImages/NonCoreAssets/";

                String coreUrl = baseUrl;
                coreUrl = coreUrl.Replace("Printpages", "images/Content/RangeOfReturnsImages/CoreAssets");
                String nonCoreUrl = baseUrl;
                nonCoreUrl = nonCoreUrl.Replace("Printpages", "images/Content/RangeOfReturnsImages/NonCoreAssets");

                String core_image = "";
                String non_core_image = "";

                if (riskProfile == string.Empty)
                {
                    imgRangeOfReturnsURL = string.Empty;
                    return string.Empty;
                }
                if (agreeWithRiskProfile == "True" || agreeWithRiskProfile == "")
                {
                    switch (riskProfile.Trim())
                    {
                        case "Cautious":
                            core_image = "CoreAssets_Cautious.png";
                            non_core_image = "NonCoreAssets_Cautious.png";
                            break;
                        case "Moderately Cautious":
                            core_image = "CoreAssets_ModCautious.png";
                            non_core_image = "NonCoreAssets_ModCautious.png";
                            break;
                        case "Balanced":
                            core_image = "CoreAssets_Balanced.png";
                            non_core_image = "NonCoreAssets_Balanced.png";
                            break;
                        case "Moderately Adventurous":
                            core_image = "CoreAssets_ModAdventurous.png";
                            non_core_image = "NonCoreAssets_ModAdventurous.png";
                            break;
                        case "Adventurous":
                            core_image = "CoreAssets_Adventurous.png";
                            non_core_image = "NonCoreAssets_Adventurous.png";
                            break;
                        case "Capital Preservation":
                            core_image = "";
                            non_core_image = "";
                            break;
                        default:
                            break;
                    }

                    if (nonCoreFunds == "True")
                    {
                        rangeOfReturnsText = "Range of Returns with Non Core Assets";
                        nonCoreUrl = nonCoreUrl + non_core_image;
                        if (non_core_image == string.Empty)
                        {
                            imgRangeOfReturnsURL = string.Empty;
                        }
                        else
                        {
                            imgRangeOfReturnsURL = nonCoreUrl;
                        }
                    }
                    if (nonCoreFunds == "False" || nonCoreFunds == "")
                    {
                        rangeOfReturnsText = "Range of Returns with Core Assets";
                        coreUrl = coreUrl + core_image;
                        if (core_image == string.Empty)
                        {
                            imgRangeOfReturnsURL = string.Empty;
                        }
                        else
                        {
                            imgRangeOfReturnsURL = coreUrl;
                        }
                    }
                }
                else
                {
                    if (riskProfile.Trim() == "Cautious")
                    {
                        if (PreferredRiskProfileName == "Moderately Cautious")
                        {
                            core_image = "CoreAssets_CautiousModCautious.png";
                            non_core_image = "NonCoreAssets_CautiousModCautious.png";
                        }
                        else if (PreferredRiskProfileName == "Balanced")
                        {
                            core_image = "CoreAssets_CautiousBalanced.png";
                            non_core_image = "NonCoreAssets_CautiousBalanced.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Adventurous")
                        {
                            core_image = "CoreAssets_CautiousModAdventurous.png";
                            non_core_image = "NonCoreAssets_CautiousModAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Adventurous")
                        {
                            core_image = "CoreAssets_CautiousAdventurous.png";
                            non_core_image = "NonCoreAssets_CautiousAdventurous.png";
                        }
                        else
                        {
                            core_image = "CoreAssets_Cautious.png";
                            non_core_image = "NonCoreAssets_Cautious.png";
                        }
                    }
                    if (riskProfile.Trim() == "Moderately Cautious")
                    {
                        if (PreferredRiskProfileName == "Cautious")
                        {
                            core_image = "CoreAssets_CautiousModCautious.png";
                            non_core_image = "NonCoreAssets_CautiousModCautious.png";
                        }
                        else if (PreferredRiskProfileName == "Balanced")
                        {
                            core_image = "CoreAssets_ModCautiousBalanced.png";
                            non_core_image = "NonCoreAssets_ModCautiousBalanced.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Adventurous")
                        {
                            core_image = "CoreAssets_ModCautiousModAdventurous.png";
                            non_core_image = "NonCoreAssets_ModCautiousModAdenturous.png";
                        }
                        else if (PreferredRiskProfileName == "Adventurous")
                        {
                            core_image = "CoreAssets_ModCautiousAdventurous.png";
                            non_core_image = "NonCoreAssets_ModCautiousAdventurous.png";
                        }
                        else
                        {
                            core_image = "CoreAssets_ModCautious.png";
                            non_core_image = "NonCoreAssets_ModCautious.png";
                        }
                    }
                    if (riskProfile.Trim() == "Balanced")
                    {
                        if (PreferredRiskProfileName == "Cautious")
                        {
                            core_image = "CoreAssets_CautiousBalanced.png";
                            non_core_image = "NonCoreAssets_CautiousBalanced.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Cautious")
                        {
                            core_image = "CoreAssets_ModCautiousBalanced.png";
                            non_core_image = "NonCoreAssets_ModCautiousBalanced.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Adventurous")
                        {
                            core_image = "CoreAssets_BalancedModAdventurous.png";
                            non_core_image = "NonCoreAssets_BalancedModAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Adventurous")
                        {
                            core_image = "CoreAssets_BalancedAdventurous.png";
                            non_core_image = "NonCoreAssets_BalancedAdventurous.png";
                        }
                        else
                        {
                            core_image = "CoreAssets_Balanced.png";
                            non_core_image = "NonCoreAssets_Balanced.png";
                        }
                    }
                    if (riskProfile.Trim() == "Moderately Adventurous")
                    {
                        if (PreferredRiskProfileName == "Cautious")
                        {
                            core_image = "CoreAssets_CautiousModAdventurous.png";
                            non_core_image = "NonCoreAssets_CautiousModAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Cautious")
                        {
                            core_image = "CoreAssets_ModCautiousModAdventurous.png";
                            non_core_image = "NonCoreAssets_ModCautiousModAdenturous.png";
                        }
                        else if (PreferredRiskProfileName == "Balanced")
                        {
                            core_image = "CoreAssets_BalancedModAdventurous.png";
                            non_core_image = "NonCoreAssets_BalancedModAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Adventurous")
                        {
                            core_image = "CoreAssets_ModAdventurousAdventurous.png";
                            non_core_image = "NonCoreAssets_ModAdventurousAdventurous.png";
                        }
                        else
                        {
                            core_image = "CoreAssets_ModAdventurous.png";
                            non_core_image = "NonCoreAssets_ModAdventurous.png";
                        }
                    }
                    if (riskProfile.Trim() == "Adventurous")
                    {
                        if (PreferredRiskProfileName == "Cautious")
                        {
                            core_image = "CoreAssets_CautiousAdventurous.png";
                            non_core_image = "NonCoreAssets_CautiousAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Cautious")
                        {
                            core_image = "CoreAssets_ModCautiousAdventurous.png";
                            non_core_image = "NonCoreAssets_ModCautiousAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Balanced")
                        {
                            core_image = "CoreAssets_BalancedAdventurous.png";
                            non_core_image = "NonCoreAssets_BalancedAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Adventurous")
                        {
                            core_image = "CoreAssets_ModAdventurousAdventurous.png";
                            non_core_image = "NonCoreAssets_ModAdventurousAdventurous.png";
                        }
                        else
                        {
                            core_image = "CoreAssets_Adventurous.png";
                            non_core_image = "NonCoreAssets_Adventurous.png";
                        }
                    }

                    if (riskProfile.Trim() == "Capital Preservation")
                    {
                        if (PreferredRiskProfileName == "Cautious")
                        {
                            core_image = "CoreAssets_Cautious.png";
                            non_core_image = "NonCoreAssets_Cautious.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Cautious")
                        {
                            core_image = "CoreAssets_ModCautious.png";
                            non_core_image = "NonCoreAssets_ModCautious.png";
                        }
                        else if (PreferredRiskProfileName == "Balanced")
                        {
                            core_image = "CoreAssets_Balanced.png";
                            non_core_image = "NonCoreAssets_Balanced.png";
                        }
                        else if (PreferredRiskProfileName == "Moderately Adventurous")
                        {
                            core_image = "CoreAssets_ModAdventurous.png";
                            non_core_image = "NonCoreAssets_ModAdventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Adventurous")
                        {
                            core_image = "CoreAssets_Adventurous.png";
                            non_core_image = "NonCoreAssets_Adventurous.png";
                        }
                        else if (PreferredRiskProfileName == "Capital Preservation")
                        {
                            core_image = "";
                            non_core_image = "";
                        }
                    }


                    if (nonCoreFunds == "True")
                    {
                        rangeOfReturnsText = "Range of Returns with Non Core Assets";
                        nonCoreUrl = nonCoreUrl + non_core_image;

                        if (non_core_image == string.Empty)
                        {
                            imgRangeOfReturnsURL = string.Empty;
                        }
                        else
                        {
                            imgRangeOfReturnsURL = nonCoreUrl;
                        }
                    }
                    if (nonCoreFunds == "False" || nonCoreFunds == "")
                    {
                        rangeOfReturnsText = "Range of Returns with Core Assets";
                        coreUrl = coreUrl + core_image;

                        if (core_image == string.Empty)
                        {
                            imgRangeOfReturnsURL = string.Empty;
                        }
                        else
                        {
                            imgRangeOfReturnsURL = coreUrl;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: ShowRateOfReturnsImage()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            string RateOfReturnsImageHTMLTag = "<img src='" + imgRangeOfReturnsURL + "' alt='' />";
            return RateOfReturnsImageHTMLTag;
        }

        public string createGAPSummaryPDF(string caseId)
        {
            try
            {
                GapSummaryDAO gapSummaryDAO = new GapSummaryDAO();

                Stopwatch stpwtch = Stopwatch.StartNew();
                DataTable dtGapSummary = gapSummaryDAO.GetGapSummary(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for gap summary db call", stpwtch.ElapsedMilliseconds);

                if (dtGapSummary != null && dtGapSummary.Rows.Count > 0)
                {
                    //string path = baseUrl + "GAPSummary.html";
                    string contents = GAPSummary_Path;

                    string gapSummaryTable = "";
                    int cnt = 0;
                    foreach (DataRow dr in dtGapSummary.Rows)
                    {
                        if (dr["Title"] != null && dr["Title"].ToString() == "SAVINGS")
                        {
                            cnt = cnt + 1;
                        }

                        if (cnt > 1)
                        {
                            dr["Title"] = string.Empty;
                        }
                    }

                    int row = 0;
                    foreach (DataRow dr in dtGapSummary.Rows)
                    {
                        string Id = dr["Id"].ToString();
                        string gapSummaryId = dr["gapSummaryTypeId"].ToString();
                        string title = dr["Title"].ToString();
                        string needs = dr["Needs"].ToString();

                        string amountRequired;
                        if (dr["AmountRequired"] != null && dr["AmountRequired"].ToString() == "0.00")
                            amountRequired = string.Empty;
                        else
                        {
                            amountRequired = dr["AmountRequired"].ToString();

                            if (dr["AmountRequired"].ToString() != string.Empty)
                            {
                                if (needs.IndexOf("Hospitalization") < 0)
                                    amountRequired = "$" + double.Parse(amountRequired).ToString("#,##0.00");                                
                            }
                        }

                        string existingArrangements;
                        if (dr["ExistingArrangements"] != null && dr["ExistingArrangements"].ToString() == "0.00")
                            existingArrangements = string.Empty;
                        else
                        {
                            existingArrangements = dr["ExistingArrangements"].ToString();

                            if (dr["ExistingArrangements"].ToString() != string.Empty)
                            {
                                if (needs.IndexOf("Hospitalization") < 0)
                                    existingArrangements = "$" + double.Parse(existingArrangements).ToString("#,##0.00");
                            }
                        }

                        string currentShortfall;
                        if (dr["CurrentShortfall"] != null && dr["CurrentShortfall"].ToString() == "0.00")
                            currentShortfall = string.Empty;
                        else
                        {
                            currentShortfall = dr["CurrentShortfall"].ToString();

                            if (dr["CurrentShortfall"].ToString() != string.Empty)
                            {
                                if (needs.IndexOf("Hospitalization") < 0)
                                    currentShortfall = "$" + double.Parse(currentShortfall).ToString("#,##0.00");
                            }
                        }

                        string myPriorities = dr["MyPriorities"].ToString();

                        string classRow = "";
                        if ((row % 2) == 0)
                            classRow = "oddRowStyle";
                        else
                            classRow = "evenRowStyle";

                        //gapSummaryTable += "<tr class='tableRowStyle'><td width='13%'>" + title + "</td><td width='30%'>" + needs + "</td><td align='right' width='15%'>" + amountRequired + "</td><td align='right' width='15%'>" + existingArrangements + "</td><td align='right' width='15%'>" + currentShortfall + "</td><td align='center' width='12%'>" + myPriorities + "</td></tr>";
                        gapSummaryTable += "<tr class='" + classRow + "'><td width='13%'>" + title + "</td><td width='28%'>" + needs + "</td><td align='right' width='15%'>" + amountRequired + "</td><td align='right' width='15%'>" + existingArrangements + "</td><td align='right' width='18%'>" + currentShortfall + "</td><td align='center' width='10%'>" + myPriorities + "</td></tr>";
                        row++;
                    }

                    contents = contents.Replace("[gapSummaryTable]", gapSummaryTable);
                    
                    return contents;
                }
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createGAPSummaryPDF()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }
            return string.Empty;
        }

        public string createSavingGoalsPdf(string caseId)
        {
            try
            {
                string path = baseUrl + "SavingsGoalPrint.html";
                string contents = "";
                string sgcontents = "";

                SavingGoalsDAO savingGoalsDao = new SavingGoalsDAO();
                Stopwatch stpwtch = Stopwatch.StartNew();
                List<savinggoal> listpd = savingGoalsDao.getSavingGoal(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for saving goals db call", stpwtch.ElapsedMilliseconds);

                if (listpd != null && listpd.Count > 0)
                {
                    savinggoal stmp = listpd[0];
                    string strSgNeeded = "";
                    if(stmp.savingGoalNeeded == 2)
                    {
                        strSgNeeded = "Yes";
                    }
                    else if(stmp.savingGoalNeeded == 1)
                    {
                        strSgNeeded = "No";
                    }
                    else if(stmp.savingGoalNeeded == 0)
                    {
                        strSgNeeded = "Not Applicable";
                    }
                    sgcontents = "<tr><td colspan='3' width='100%'>Do you require planning for this need?&nbsp;&nbsp;&nbsp;&nbsp;" + strSgNeeded + "</td></tr>"
                        + "<tr><td colspan='3'>&nbsp;</td><tr>";
                    
                    foreach (savinggoal pd in listpd)
                    {
                        string members = "";
                        string classRow = "";
                        if (pd.existingassetsgs != null && pd.existingassetsgs.Count > 0)
                        {
                            /*members = "<tr class='totalRowStyle'><td colspan='3'><table width='100%'><tr class='noBorderRow'><td align='center'>Assets</td><td align='center'>Present value</td><td align='center'>% p.a</td></tr></table></td></tr>";
                            for (int i = 0; i < pd.existingassetsgs.Count; i++)
                            {
                                string classRowNoBorder = "";
                                if ((i % 2) == 0)
                                {
                                    classRow = "oddRowStyle";
                                    classRowNoBorder = "oddRowStyleNoBorder";
                                }
                                else
                                {
                                    classRow = "evenRowStyle";
                                    classRowNoBorder = "evenRowStyleNoBorder";
                                }
                                existingassetsg sg = pd.existingassetsgs[i];
                                members += "<tr class=" + classRow + "'><td><table width='100%'><tr class='noBorderRow'><td align='center'>" + sg.asset + "</td><td align='center'>" + sg.presentvalue + "</td><td align='center'>"
                                     + sg.percentpa + "</td></tr></table></td></tr>";
                            }
                            members += "</table></td></tr>";*/
                            int i = 0;
                            members += "<tr class='evenRowStyle'><td colspan='3'><table width='100%' cellspacing='0' cellpadding='0'><tr><td colspan='2'><table><td align='center'>Asset</td><td align='center'>Present Value</td><td align='center'>% p.a</td></tr>";
                            foreach (existingassetsg sg in pd.existingassetsgs)
                            {
                                string classRowNoBorder = "";
                                if ((i % 2) == 0)
                                {
                                    classRow = "oddRowStyle";
                                    classRowNoBorder = "oddRowStyleNoBorder";
                                }
                                else
                                {
                                    classRow = "evenRowStyle";
                                    classRowNoBorder = "evenRowStyleNoBorder";
                                }

                                string strpv = sg.presentvalue;
                                if (sg.presentvalue != null && sg.presentvalue != "")
                                {
                                    strpv = double.Parse(sg.presentvalue).ToString("#,##0.00");
                                }

                                members += "<tr class='evenRowStyle'><td align='center'>" + sg.asset + "</td><td align='center'>" + "$ " + strpv + "</td><td align='center'>"
                                     + sg.percentpa + "</td></tr>";
                                i++;
                            }
                            members += "</table></td><td></td></tr></table></td></tr>";
                        }

                        string totallabel = "";
                        string strtotal = "";

                        double damtneededfv = 0;
                        if (pd.amtneededfv != null && pd.amtneededfv != "")
                        {
                            damtneededfv = double.Parse(pd.amtneededfv);
                        }

                        double deattl = 0;
                        if (pd.existingassetstotal != null && pd.existingassetstotal != "")
                        {
                            deattl = double.Parse(pd.existingassetstotal);
                        }

                        double dmaturityval = 0;
                        if (pd.maturityvalue != null && pd.maturityvalue != "")
                        {
                            dmaturityval = double.Parse(pd.maturityvalue);
                        }

                        string spanColor = "black";
                        if (((deattl + dmaturityval) - damtneededfv) < 0)
                        {
                            totallabel = "TOTAL(SHORTFALL)";
                            //strtotal = "-" + pd.total;
                            strtotal = pd.total;
                            spanColor = "red";
                        }
                        else if (((deattl + dmaturityval) - damtneededfv) > 0)
                        {
                            totallabel = "TOTAL(SURPLUS)";
                            strtotal = pd.total;
                        }
                        else
                        {
                            totallabel = "TOTAL(SHORTFALL/SURPLUS)";
                            strtotal = "0";
                        }

                        if (classRow == "oddRowStyle")
                            classRow = "evenRowStyle";
                        else
                            classRow = "oddRowStyle";

                        /*sgcontents += "<tr class='oddRowStyle'><td>Goal</td><td>" + (pd.goal != null ? pd.goal : string.Empty) + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Years To Accumulate</td><td>" + (pd.yrstoaccumulate != null ? pd.yrstoaccumulate : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td>Amount Needed (Future Value)</td><td>" + (pd.amtneededfv != null ? pd.amtneededfv : "0") + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Existing Assets (Future Value)</td><td><table width='100%' class='tableStyle'><tr class='evenRowStyleNoBorder'><td align='left'>Less:</td><td align='right'>" + (pd.existingassetstotal != null ? pd.existingassetstotal : "0") + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='" + classRow + "'><td>Projected Maturity Value of Existing Insurance Policies</td><td>" + (pd.maturityvalue != null ? pd.maturityvalue : "0") + "</td><tr>"
                            + "<tr class='totalRowStyle'><td>" + totallabel + "</td><td>" + strtotal + "</td></tr>";*/

                        sgcontents += "<tr class='oddRowStyle'><td colspan='2' width='65%'>Goal</td><td width='35%' align='right'>" + (pd.goal != null ? pd.goal : string.Empty) + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Years To Accumulate</td><td width='35%' align='right'>" + (pd.yrstoaccumulate != null ? pd.yrstoaccumulate : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'><b>Amount Needed (Future Value)</b></td><td width='35%' align='right'><b> $ " + ((pd.amtneededfv != null && pd.amtneededfv != "") ? double.Parse(pd.amtneededfv).ToString("#,##0.00") : "0") + "</b></td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Existing Assets (Future Value)</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + ((pd.existingassetstotal != null && pd.existingassetstotal != "") ? double.Parse(pd.existingassetstotal).ToString("#,##0.00") : "0") + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Projected Maturity Value of Existing Insurance Policies</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + ((pd.maturityvalue != null && pd.maturityvalue != "") ? double.Parse(pd.maturityvalue).ToString("#,##0.00") : "0") + "</td></tr></table></td><tr>"
                            + "<tr class='totalRowStyle'><td colspan='2' width='65%'><span style='color: " + spanColor + "'><b>" + totallabel + "</b></span></td><td width='35%' align='right'><span style='color: " + spanColor + "'><b> $ " + double.Parse(strtotal).ToString("#,##0.00") + "</b></span></td><tr>"
                            + "<tr><td colspan='3'>&nbsp;</td><tr>";
                    }
                }
                else
                {
                    string members = "";
                    members += "<tr class='evenRowStyle'><td colspan='3'><table width='100%' cellspacing='0' cellpadding='0'><tr><td colspan='2'><table><td align='center'>Asset</td><td align='center'>Present Value</td><td align='center'>% p.a</td></tr>";
                    members += "</table></td><td></td></tr></table></td></tr>";

                    sgcontents = "<tr><td colspan='3' width='100%'>Do you require planning for this need?</td></tr>"
                        + "<tr><td colspan='3'>&nbsp;</td><tr>";
                    
                    sgcontents += "<tr class='oddRowStyle'><td colspan='2' width='65%'>Goal</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Years To Accumulate</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'><b>Amount Needed (Future Value)</b></td><td width='35%' align='right'><b> $ " + string.Empty + "</b></td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Existing Assets (Future Value)</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + string.Empty + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Projected Maturity Value of Existing Insurance Policies</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + string.Empty + "</td></tr></table></td><tr>"
                            + "<tr class='totalRowStyle'><td colspan='2' width='65%'><b>TOTAL(SHORTFALL/SURPLUS)</b></td><td width='35%' align='right'><b> $ " + string.Empty + "</b></td><tr>"
                            + "<tr><td colspan='3'>&nbsp;</td><tr>";
                }


                AssumptionDAO assumptionDao = new AssumptionDAO();
                assumption assmptn = assumptionDao.getAssumptionById(2);

                string strPercentage = "";
                if (assmptn != null && assmptn.percentage != null)
                {
                    strPercentage = assmptn.percentage.ToString();
                }

                contents = SavingGoal_Path; 

                contents = contents.Replace("[investmentReturnRate]", strPercentage);

                contents = contents.Replace("[savinggoals]", sgcontents);

                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createSavingGoalsPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
            
        }

        public string createRetirementGoalsPdf(string caseId)
        {

            try
            {
                //string path = baseUrl + "RetirementGoalPrint.html";
                string contents = "";

                RetirementGoalsDAO retirementGoalDao = new RetirementGoalsDAO();
                Stopwatch stpwtch = Stopwatch.StartNew();
                retirementgoal goalSelf = retirementGoalDao.getRetirementGoal(caseId, "self");
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for retirement goals db call", stpwtch.ElapsedMilliseconds);

                contents = RetirementGoal_Path;

                if (goalSelf == null)
                {
                    contents = contents.Replace("[retirementGoalNeeded]", "Not Applicable");
                    contents = contents.Replace("[annualInflationRate]", "0");
                    contents = contents.Replace("[inflationAdjustedReturn]", "0");
                    contents = contents.Replace("[intendedRetirementAge]", "0");
                    contents = contents.Replace("[incomeRequiredUponRetirement]", "0");
                    contents = contents.Replace("[yearsToRetirement]", "0");
                    contents = contents.Replace("[futureIncomeNeeded]", "0");
                    contents = contents.Replace("[sourcesOfIncome]", "0");
                    contents = contents.Replace("[totalFirstYearIncomeNeeded]", "0");
                    contents = contents.Replace("[durationOfRetirement]", "0");
                    contents = contents.Replace("[lumpSumRequiredAtRetirement]", "0");
                    contents = contents.Replace("[maturityValue2]", "0");
                    contents = contents.Replace("[totalShortfallSurplus2]", "0");
                    contents = contents.Replace("[existingAssets2]", "0");
                    contents = contents.Replace("[totallabel]", "TOTAL(SHORTFALL/SURPLUS)");
                    contents = contents.Replace("[shortfallSurplusColour]", "black");
                }
                else
                {
                    string retGoalNeeded = "";
                    if (goalSelf.retirementGoalNeeded == 2)
                    {
                        retGoalNeeded = "Yes";
                    }
                    else if (goalSelf.retirementGoalNeeded == 1)
                    {
                        retGoalNeeded = "No";
                    }
                    else if (goalSelf.retirementGoalNeeded == 0)
                    {
                        retGoalNeeded = "Not Applicable";
                    }
                    contents = contents.Replace("[retirementGoalNeeded]", retGoalNeeded);
                    
                    if (goalSelf.inflationrate != null)
                    {
                        contents = contents.Replace("[annualInflationRate]", goalSelf.inflationrate);
                    }
                    else
                    {
                        contents = contents.Replace("[annualInflationRate]", "0");
                    }

                    if (goalSelf.inflationreturnrate != null)
                    {
                        contents = contents.Replace("[inflationAdjustedReturn]", goalSelf.inflationreturnrate);
                    }
                    else
                    {
                        contents = contents.Replace("[inflationAdjustedReturn]", "0");
                    }
                    
                    if (goalSelf.intendedretirementage != null)
                    {
                        contents = contents.Replace("[intendedRetirementAge]", goalSelf.intendedretirementage);
                    }
                    else
                    {
                        contents = contents.Replace("[intendedRetirementAge]", "0");
                    }

                    if (goalSelf.incomerequired != null && goalSelf.incomerequired != "")
                    {
                        contents = contents.Replace("[incomeRequiredUponRetirement]", double.Parse(goalSelf.incomerequired).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[incomeRequiredUponRetirement]", "0");
                    }

                    if (goalSelf.yrstoretirement != null)
                    {
                        contents = contents.Replace("[yearsToRetirement]", goalSelf.yrstoretirement);
                    }
                    else
                    {
                        contents = contents.Replace("[yearsToRetirement]", "0");
                    }


                    if (goalSelf.futureincome != null && goalSelf.futureincome != "")
                    {
                        contents = contents.Replace("[futureIncomeNeeded]", double.Parse(goalSelf.futureincome).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[futureIncomeNeeded]", "0");
                    }

                    if (goalSelf.sourcesofincome != null && goalSelf.sourcesofincome != "")
                    {
                        contents = contents.Replace("[sourcesOfIncome]", double.Parse(goalSelf.sourcesofincome).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[sourcesOfIncome]", "0");
                    }

                    if (goalSelf.totalfirstyrincome != null && goalSelf.totalfirstyrincome != "")
                    {
                        contents = contents.Replace("[totalFirstYearIncomeNeeded]", double.Parse(goalSelf.totalfirstyrincome).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[totalFirstYearIncomeNeeded]", "0");
                    }

                    if (goalSelf.durationretirement != null)
                    {
                        contents = contents.Replace("[durationOfRetirement]", goalSelf.durationretirement);
                    }
                    else
                    {
                        contents = contents.Replace("[durationOfRetirement]", "0");
                    }

                    double dlumpsum = 0;
                    if (goalSelf.lumpsumrequired != null && goalSelf.lumpsumrequired != "")
                    {
                        dlumpsum = double.Parse(goalSelf.lumpsumrequired);
                        contents = contents.Replace("[lumpSumRequiredAtRetirement]", double.Parse(goalSelf.lumpsumrequired).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[lumpSumRequiredAtRetirement]", "0");
                    }

                    double dmaturityval = 0;
                    if (goalSelf.maturityvalue != null && goalSelf.maturityvalue != "")
                    {
                        dmaturityval = double.Parse(goalSelf.maturityvalue);
                        contents = contents.Replace("[maturityValue2]", double.Parse(goalSelf.maturityvalue).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[maturityValue2]", "0");
                    }

                    double deargttl = 0;
                    if (goalSelf.existingassetstotal != null && goalSelf.existingassetstotal != "")
                    {
                        deargttl = double.Parse(goalSelf.existingassetstotal);
                        contents = contents.Replace("[existingAssets2]", double.Parse(goalSelf.existingassetstotal).ToString("#,##0.00"));
                    }
                    else
                    {
                        contents = contents.Replace("[existingAssets2]", "0");
                    }

                    string members = "";
                    if (goalSelf.existingassetrgs != null)
                    {
                        members = "<tr class='evenRowStyle'><td colspan='3'><table width='100%' cellspacing='0' cellpadding='0'><tr><td colspan='2'><table><td align='center'>Asset</td><td align='center'>Present Value</td><td align='center'>% p.a</td></tr>";
                        foreach (existingassetrg sg in goalSelf.existingassetrgs)
                        {
                            string strpv = sg.presentvalue;
                            if (sg.presentvalue != null && sg.presentvalue != "")
                            {
                                strpv = double.Parse(sg.presentvalue).ToString("#,##0.00");
                            }
                            
                            members += "<tr class='evenRowStyle'><td align='center'>" + sg.asset + "</td><td align='center'> $ " + strpv + "</td><td align='center'>"
                                 + sg.percentpa + "</td></tr>";

                        }
                        members += "</table></td><td></td></tr></table></td></tr>";
                        contents = contents.Replace("[earg]", members);
                    }

                    if (goalSelf.total != null && goalSelf.total != "")
                    {
                        if (((dmaturityval + deargttl) - dlumpsum) > 0)
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "black");
                            contents = contents.Replace("[totallabel]", "TOTAL(SURPLUS)");
                            contents = contents.Replace("[totalShortfallSurplus2]", double.Parse(goalSelf.total).ToString("#,##0.00"));
                        }
                        else if (((dmaturityval + deargttl) - dlumpsum) < 0)
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "red");
                            contents = contents.Replace("[totallabel]", "TOTAL(SHORTFALL)");
                            contents = contents.Replace("[totalShortfallSurplus2]", (double.Parse(goalSelf.total).ToString("#,##0.00")));
                        }
                        else
                        {
                            contents = contents.Replace("[shortfallSurplusColour]", "black");
                            contents = contents.Replace("[totallabel]", "TOTAL(SHORTFALL/SURPLUS)");
                            contents = contents.Replace("[totalShortfallSurplus2]", double.Parse(goalSelf.total).ToString("#,##0.00"));
                        }
                    }
                    else
                    {
                        contents = contents.Replace("[shortfallSurplusColour]", "black");
                        contents = contents.Replace("[totallabel]", "TOTAL(SHORTFALL/SURPLUS)");
                        contents = contents.Replace("[totalShortfallSurplus2]", "0");
                    }


                    string eassts = "";
                    int counter = 0;

                    if (goalSelf.existingassetrgs != null)
                    {
                        counter++;
                        if (counter == 1)
                        {
                            eassts = "<table width='100%'>";
                        }
                        foreach (existingassetrg m in goalSelf.existingassetrgs)
                        {
                            string strpv = m.presentvalue;
                            if (m.presentvalue != null && m.presentvalue != "")
                            {
                                strpv = double.Parse(m.presentvalue).ToString("#,##0.00");
                            }
                            
                            eassts += "<tr><td align='center'>" + m.asset + "</td><td align='center'> $ " + strpv + "</td><td align='center'>" +
                                m.percentpa + "</td></tr>";
                        }
                        if (counter > 0)
                        {
                            eassts += "</table>";
                        }
                    }
                    contents = contents.Replace("[eassts]", eassts);

                }
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createRetirementGoalsPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
            
        }

        public string createEducationGoalsPdf(string caseId)
        {
            try
            {
                //string path = baseUrl + "EducationGoalPrint.html";
                string contents = "";
                string edcontents = "";

                EducationGoalsDAO educationGoalsDao = new EducationGoalsDAO();

                Stopwatch stpwtch = Stopwatch.StartNew();
                List<educationgoal> listpd = educationGoalsDao.getEducationGoal(caseId);
                stpwtch.Stop();
                writeLog(activityStatus, "", "Time taken for education goals db call", stpwtch.ElapsedMilliseconds);

                EntitySet<countrycostofeducation> cced = educationGoalsDao.getCountryCostOfEducation();

                contents = EducationGoal_Path; 

                if (listpd != null && listpd.Count > 0)
                {
                    educationgoal stmp = listpd[0];
                    string strSgNeeded = "";
                    if (stmp.educationGoalNeeded == 2)
                    {
                        strSgNeeded = "Yes";
                    }
                    else if (stmp.educationGoalNeeded == 1)
                    {
                        strSgNeeded = "No";
                    }
                    else if (stmp.educationGoalNeeded == 0)
                    {
                        strSgNeeded = "Not Applicable";
                    }
                    edcontents = "<tr><td colspan='3' width='100%'>Do you require planning for this need?&nbsp;&nbsp;&nbsp;&nbsp;" + strSgNeeded + "</td></tr>"
                        + "<tr><td colspan='3'>&nbsp;</td><tr>";
                    
                    string countryOfStudy = "";

                    foreach (educationgoal pd in listpd)
                    {
                        foreach (countrycostofeducation cc in cced)
                        {
                            if (cc.id == pd.countryofstudyid)
                            {
                                countryOfStudy = cc.country;
                                break;
                            }
                        }

                        string members = "";
                        string classRow = "";
                        string classRowNoBorder = "";

                        /*if (pd.existingassetegs != null && pd.existingassetegs.Count > 0)
                        {
                            members = "<tr class='totalRowStyle'><td colspan='3'><table width='100%'><tr class='noBorderRow'><td align='center'>Assets</td><td align='center'>Present value</td><td align='center'>% p.a</td></tr></table></td></tr>";

                            for (int i = 0; i < pd.existingassetegs.Count; i++)
                            {
                                if ((i % 2) == 0)
                                {
                                    classRow = "oddRowStyle";
                                    classRowNoBorder = "oddRowStyleNoBorder";
                                }
                                else
                                {
                                    classRow = "evenRowStyle";
                                    classRowNoBorder = "evenRowStyleNoBorder";
                                }
                                existingasseteg sg = pd.existingassetegs[i];
                                members += "<tr class=" + classRow + "'><td><table width='100%'><tr class='noBorderRow'><td align='center'>" + sg.asset + "</td><td align='center'>" + sg.presentvalue + "</td><td align='center'>" + sg.percentpa + "</td></tr></table></td></tr>";
                            }
                            members += "</table></td></tr>";
                        }*/

                        if (pd.existingassetegs != null && pd.existingassetegs.Count > 0)
                        {
                            int i = 0;
                            members += "<tr class='evenRowStyle'><td colspan='3'><table width='100%' cellspacing='0' cellpadding='0'><tr><td colspan='2'><table><td align='center'>Asset</td><td align='center'>Present Value</td><td align='center'>% p.a</td></tr>";
                            foreach (existingasseteg sg in pd.existingassetegs)
                            {
                                if ((i % 2) == 0)
                                {
                                    classRow = "oddRowStyle";
                                    classRowNoBorder = "oddRowStyleNoBorder";
                                }
                                else
                                {
                                    classRow = "evenRowStyle";
                                    classRowNoBorder = "evenRowStyleNoBorder";
                                }

                                string strpv = sg.presentvalue;
                                if (sg.presentvalue != null && sg.presentvalue != "")
                                {
                                    strpv = double.Parse(sg.presentvalue).ToString("#,##0.00");
                                }

                                members += "<tr class='evenRowStyle'><td align='center'>" + sg.asset + "</td><td align='center'> $ " + strpv + "</td><td align='center'>"
                                     + sg.percentpa + "</td></tr>";
                                i++;
                            }
                            members += "</table></td><td></td></tr></table></td></tr>";
                        }

                        string totallabel = "";
                        string strtotal = "";

                        double damtneededfv = 0;
                        if (pd.futurecost != null && pd.futurecost != "")
                        {
                            damtneededfv = double.Parse(pd.futurecost);
                        }

                        double deattl = 0;
                        if (pd.existingassetstotal != null && pd.existingassetstotal != "")
                        {
                            deattl = double.Parse(pd.existingassetstotal);
                        }

                        double dmaturityval = 0;
                        if (pd.maturityvalue != null && pd.maturityvalue != "")
                        {
                            dmaturityval = double.Parse(pd.maturityvalue);
                        }

                        string spanColor = "black";
                        if (((deattl + dmaturityval) - damtneededfv) < 0)
                        {
                            totallabel = "TOTAL(SHORTFALL)";
                            //strtotal = "-" + pd.total;
                            strtotal = pd.total;
                            spanColor = "red";
                        }
                        else if (((deattl + dmaturityval) - damtneededfv) > 0)
                        {
                            totallabel = "TOTAL(SURPLUS)";
                            strtotal = pd.total;
                        }
                        else
                        {
                            totallabel = "TOTAL(SHORTFALL/SURPLUS)";
                            strtotal = "0";
                        }

                        if (classRow == "oddRowStyle")
                        {
                            classRow = "evenRowStyle";
                            classRowNoBorder = "evenRowStyleNoBorder";
                        }
                        else
                        {
                            classRow = "oddRowStyle";
                            classRowNoBorder = "oddRowStyleNoBorder";
                        }


                        /*edcontents += "<tr class='oddRowStyle'><td>Name of Child</td><td>" + (pd.nameofchild != null ? pd.nameofchild : string.Empty) + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Current Age</td><td>" + (pd.currentage != null ? pd.currentage : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td>Age when Funds Needed</td><td>" + (pd.agefundsneeded != null ? pd.agefundsneeded : "0") + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Number of Years to Save</td><td>" + (pd.noofyrstosave != null ? pd.noofyrstosave : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td>Country of Study</td><td>" + countryOfStudy + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Present Cost of Education</td><td>" + (pd.presentcost != null ? pd.presentcost : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td>Inflation Rate of Education</td><td>" + (pd.inflationrate != null ? pd.inflationrate : "0") + "</td><tr>"
                            + "<tr class='evenRowStyle'><td>Future Cost of Education</td><td>" + (pd.futurecost != null ? pd.futurecost : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td>Existing Assets (Future Value)</td><td><table width='100%' class='tableStyle'><tr class='oddRowStyleNoBorder'><td align='left'>Less:</td><td align='right'>" + (pd.existingassetstotal != null ? pd.existingassetstotal : "0") + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='" + classRow + "'><td>Projected Maturity Value of Existing Insurance Policies</td><td><table width='100%' class='tableStyle'><tr><td align='left' class='" + classRowNoBorder + "'>Less:</td><td align='right'  class='" + classRowNoBorder + "'>" + (pd.maturityvalue != null ? pd.maturityvalue : "0") + "</td></tr></table></td><tr>"
                            + "<tr class='totalRowStyle'><td>" + totallabel + "</td><td>" + strtotal + "</td></tr>";*/

                        edcontents += "<tr class='oddRowStyle'><td colspan='2' width='65%'>Name of Child</td><td width='35%' align='right'>" + (pd.nameofchild != null ? pd.nameofchild : string.Empty) + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Current Age</td><td width='35%' align='right'>" + (pd.currentage != null ? pd.currentage : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Age when Funds Are Needed</td><td width='35%' align='right'>" + (pd.agefundsneeded != null ? pd.agefundsneeded : "0") + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Number of Years to Save</td><td width='35%' align='right'>" + (pd.noofyrstosave != null ? pd.noofyrstosave : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Country of Study(eg. Singapore, USA, Australia) </td><td width='35%' align='right'>" + countryOfStudy + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Present Cost of Education</td><td width='35%' align='right'> $ " + ((pd.presentcost != null && pd.presentcost != "") ? double.Parse(pd.presentcost).ToString("#,##0.00") : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Inflation Rate of Education</td><td width='35%' align='right'>" + (pd.inflationrate != null ? pd.inflationrate : "0") + " %</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Future Cost of Education</td><td width='35%' align='right'> $ " + ((pd.futurecost != null && pd.futurecost != "") ? double.Parse(pd.futurecost).ToString("#,##0.00") : "0") + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Existing Assets (Future Value)</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + ((pd.existingassetstotal != null && pd.existingassetstotal != "") ? double.Parse(pd.existingassetstotal).ToString("#,##0.00") : "0") + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Projected Maturity Value of Existing Insurance Policies</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + ((pd.maturityvalue != null && pd.maturityvalue != "") ? double.Parse(pd.maturityvalue).ToString("#,##0.00") : "0") + "</td></tr></table></td><tr>"
                            + "<tr class='totalRowStyle'><td colspan='2' width='65%'><span style='color: " + spanColor + "'><b>" + totallabel + "</b></span></td><td width='35%' align='right'><span style='color: " + spanColor + "'><b> $ " + double.Parse(strtotal).ToString("#,##0.00") + "</b></span></td><tr>"
                            + "<tr><td colspan='3'>&nbsp;</td><tr>";
                    }
                }
                else
                {
                    string members = "";
                    members += "<tr class='evenRowStyle'><td colspan='3'><table width='100%' cellspacing='0' cellpadding='0'><tr><td colspan='2'><table><td align='center'>Asset</td><td align='center'>Present Value</td><td align='center'>% p.a</td></tr>";
                    members += "</table></td><td></td></tr></table></td></tr>";

                    edcontents = "<tr><td colspan='3' width='100%'>Do you require planning for this need?</td></tr>"
                        + "<tr><td colspan='3'>&nbsp;</td><tr>";

                    edcontents += "<tr class='oddRowStyle'><td colspan='2' width='65%'>Name of Child</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Current Age</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Age when Funds Are Needed</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Number of Years to Save</td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Country of Study(eg. Singapore, USA, Australia) </td><td width='35%' align='right'>" + string.Empty + "</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Present Cost of Education</td><td width='35%' align='right'> $ " + string.Empty + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Inflation Rate of Education</td><td width='35%' align='right'>" + string.Empty + " %</td><tr>"
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Future Cost of Education</td><td width='35%' align='right'> $ " + string.Empty + "</td><tr>"
                            + "<tr class='oddRowStyle'><td colspan='2' width='65%'>Existing Assets (Future Value)</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + string.Empty + "</td></tr></table></td><tr>"
                            + members
                            + "<tr class='evenRowStyle'><td colspan='2' width='65%'>Projected Maturity Value of Existing Insurance Policies</td><td width='35%'><table width='100%' border='0'><tr><td>Less:</td><td align='right'> $ " + string.Empty + "</td></tr></table></td><tr>"
                            + "<tr class='totalRowStyle'><td colspan='2' width='65%'><b>TOTAL(SHORTFALL/SURPLUS)</b></td><td width='35%' align='right'><b> $ " + string.Empty + "</b></td><tr>"
                            + "<tr><td colspan='3'>&nbsp;</td><tr>";

                }

                contents = contents.Replace("[educationgoals]", edcontents);
                
                return contents;
            }
            catch (Exception ex)
            {
                exceptionlog exLog = new exceptionlog();
                exLog.message = ex.Message + " class: GeneratePdf Method: createEducationGoalsPdf()";
                exLog.source = ex.Source;

                string strtmp = ex.StackTrace;
                strtmp = strtmp.Replace('\r', ' ');
                strtmp = strtmp.Replace('\n', ' ');
                exLog.stacktrace = strtmp;

                exLog.targetsitename = ex.TargetSite.Name;

                ActivityStatusDAO activityStatus = new ActivityStatusDAO();
                activityStatus.logException(exLog);
            }

            return string.Empty;
        }
    }
}
