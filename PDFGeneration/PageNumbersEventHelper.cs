using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace PDFGeneration
{
    public class PageNumbersEventHelper : PdfPageEventHelper
    {
        PdfTemplate m_Template;
        BaseFont m_BaseFont;
        PdfContentByte m_Cb;

        public override void OnOpenDocument(PdfWriter writer, Document document)
        {
            m_BaseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            m_Cb = writer.DirectContent;
            m_Template = m_Cb.CreateTemplate(80, 80);
        }

        public override void OnEndPage(PdfWriter writer, Document document)
        {
            int page = writer.PageNumber;
            string text = "Page " + page;

            m_Cb.BeginText();
            m_Cb.SetFontAndSize(m_BaseFont, 10);
            m_Cb.ShowTextAligned(PdfContentByte.ALIGN_RIGHT, text, 312, 20, 0);
            m_Cb.EndText();
            m_Cb.AddTemplate(m_Template, 302.3f, 20);

            text = "Nexus Financial Services Pte Ltd.";
            m_Cb.BeginText();
            m_Cb.SetFontAndSize(m_BaseFont, 7);
            m_Cb.ShowTextAligned(PdfContentByte.ALIGN_RIGHT, text, 490, 20, 0);
            m_Cb.EndText();
            m_Cb.AddTemplate(m_Template, 482.3f, 20);
        }

        public override void OnCloseDocument(PdfWriter writer, Document document)
        {
            m_Template.BeginText();
            m_Template.SetFontAndSize(m_BaseFont, 10);
            //string text = "of " + (writer.PageNumber - 1).ToString();
            string text = "";
            m_Template.ShowTextAligned(PdfContentByte.ALIGN_LEFT, text, 0, 0, 0);
            m_Template.EndText();
        }
    }
}
