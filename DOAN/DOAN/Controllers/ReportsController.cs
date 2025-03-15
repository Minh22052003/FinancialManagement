using DOAN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using static System.Net.Mime.MediaTypeNames;
using System.Reflection.Metadata;
using System.Xml.Linq;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace DOAN.Controllers
{
    public class ReportsController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;
        public ReportsController(HeThongTaiChinhDbContext _context)
        {
            this._context = _context;
        }
        public IActionResult BaoCaoTaiKhoanTienGui()
        {
            var accounts = _context.DepositAccounts
                .Include(a => a.Customer)
                .ToList();
            return View(accounts);
        }

        public IActionResult ExportToPdf()
        {
            var accounts = _context.DepositAccounts
                .Include(a => a.Customer)
                .ToList();

            using (MemoryStream stream = new MemoryStream())
            {
                iTextSharp.text.Document document = new iTextSharp.text.Document(PageSize.A4);
                PdfWriter writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                // 🛠 Load font hỗ trợ tiếng Việt (Times New Roman)
                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                iTextSharp.text.Font titleFont = new iTextSharp.text.Font(baseFont, 16, iTextSharp.text.Font.BOLD);
                iTextSharp.text.Font textFont = new iTextSharp.text.Font(baseFont, 12, iTextSharp.text.Font.NORMAL);

                // 📌 Thêm tiêu đề
                Paragraph title = new Paragraph("Báo cáo danh sách tài khoản tiền gửi", titleFont);
                title.Alignment = Element.ALIGN_CENTER;
                title.SpacingAfter = 20;
                document.Add(title);

                // 📌 Tạo bảng PDF
                PdfPTable table = new PdfPTable(3);
                table.WidthPercentage = 100;
                table.SetWidths(new float[] { 2f, 5f, 3f });

                // 📌 Tiêu đề cột (chỉnh font Unicode)
                PdfPCell cell1 = new PdfPCell(new Phrase("Mã tài khoản", textFont));
                PdfPCell cell2 = new PdfPCell(new Phrase("Tên khách hàng", textFont));
                PdfPCell cell3 = new PdfPCell(new Phrase("Số dư", textFont));

                cell1.BackgroundColor = BaseColor.LIGHT_GRAY;
                cell2.BackgroundColor = BaseColor.LIGHT_GRAY;
                cell3.BackgroundColor = BaseColor.LIGHT_GRAY;

                table.AddCell(cell1);
                table.AddCell(cell2);
                table.AddCell(cell3);

                // 📌 Thêm dữ liệu
                foreach (var item in accounts)
                {
                    table.AddCell(new PdfPCell(new Phrase(item.AccountId.ToString(), textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.Customer?.FullName ?? "Không có dữ liệu", textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.Balance.ToString("N2"), textFont)));
                }

                document.Add(table);
                document.Close();

                return File(stream.ToArray(), "application/pdf", "BaoCaoTaiKhoanTienGui.pdf");
            }
        }
    }
}
