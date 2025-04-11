using DOAN.Models;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;

namespace DOAN.Controllers
{
    public class ReportsController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;
        public ReportsController(HeThongTaiChinhDbContext _context)
        {
            this._context = _context;
        }
        public IActionResult BaoCaoTaiKhoanTienGui(DateTime? fromDate, DateTime? toDate, string accountType, string searchTerm, decimal? minBalance)
        {
            var accounts = _context.DepositAccounts.Include(a => a.Customer).AsQueryable();

            if (fromDate.HasValue)
                accounts = accounts.Where(a => a.CreatedAt >= fromDate.Value);
            if (toDate.HasValue)
                accounts = accounts.Where(a => a.CreatedAt <= toDate.Value);
            if (!string.IsNullOrEmpty(accountType))
                accounts = accounts.Where(a => a.AccountType.Contains(accountType));
            if (!string.IsNullOrEmpty(searchTerm))
                accounts = accounts.Where(a =>
                    a.Customer.FullName.Contains(searchTerm) ||
                    a.AccountNumber.Contains(searchTerm));
            if (minBalance.HasValue)
                accounts = accounts.Where(a => a.Balance >= minBalance.Value);
            return View(accounts.ToList());
        }

        public IActionResult BaoCaoDanhSachTaikhoanVay(string? searchTerm, string? loanStatus, bool? isFullyPaid)
        {
            var loanAccounts = _context.LoanAccounts.Include(l => l.Customer).AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                loanAccounts = loanAccounts.Where(l =>
                    l.Customer.FullName.Contains(searchTerm) ||
                    l.CustomerId.Contains(searchTerm));
            }

            if (!string.IsNullOrEmpty(loanStatus))
            {
                loanAccounts = loanAccounts.Where(l => l.LoanStatus == loanStatus);
            }

            if (isFullyPaid.HasValue)
            {
                loanAccounts = loanAccounts.Where(l => l.IsFullyPaid == isFullyPaid.Value);
            }

            ViewBag.SearchTerm = searchTerm;
            ViewBag.LoanStatus = loanStatus;
            ViewBag.IsFullyPaid = isFullyPaid;

            return View(loanAccounts.ToList());
        }

        public IActionResult BaoCaoTongHopKhachHang(string? searchName, string? searchId, string? accountType, DateTime? fromDate, DateTime? toDate)
        {
            var depositAccounts = _context.DepositAccounts.Include(d => d.Customer).AsQueryable();
            var loanAccounts = _context.LoanAccounts.Include(l => l.Customer).AsQueryable();

            // Lọc theo tên KH
            if (!string.IsNullOrEmpty(searchName))
            {
                depositAccounts = depositAccounts.Where(d => d.Customer.FullName.Contains(searchName));
                loanAccounts = loanAccounts.Where(l => l.Customer.FullName.Contains(searchName));
            }

            // Lọc theo mã KH
            if (!string.IsNullOrEmpty(searchId))
            {
                depositAccounts = depositAccounts.Where(d => d.CustomerId.Contains(searchId));
                loanAccounts = loanAccounts.Where(l => l.CustomerId.Contains(searchId));
            }

            // Lọc theo ngày mở
            if (fromDate.HasValue)
            {
                depositAccounts = depositAccounts.Where(d => d.CreatedAt >= fromDate.Value);
            }

            if (toDate.HasValue)
            {
                depositAccounts = depositAccounts.Where(d => d.CreatedAt <= toDate.Value);
            }

            var depositList = depositAccounts.ToList();
            var loanList = loanAccounts.ToList();

            var groupedData = depositList
                .GroupBy(d => d.CustomerId)
                .Select(g =>
                {
                    var customerLoans = loanList.Where(l => l.CustomerId == g.Key).ToList();

                    return new
                    {
                        CustomerId = g.Key,
                        FullName = g.First().Customer?.FullName ?? "Không có dữ liệu",
                        DepositAccountCount = g.Count(),
                        LoanAccountCount = customerLoans.Count,
                        TotalDepositBalance = g.Sum(d => d.Balance),
                        TotalLoanAmount = customerLoans.Sum(l => l.LoanAmount),
                        OpenDate = g.Min(d => d.CreatedAt)
                    };
                })
                .ToList();


            // Truyền lại filter cho View
            ViewBag.GroupedData = groupedData;
            ViewBag.SearchName = searchName;
            ViewBag.SearchId = searchId;
            ViewBag.AccountType = accountType;
            ViewBag.FromDate = fromDate?.ToString("yyyy-MM-dd");
            ViewBag.ToDate = toDate?.ToString("yyyy-MM-dd");

            return View();
        }


        public IActionResult BaoCaoHoSoVayVon(string? tenKhachHang,
            string? trangThai,
            DateTime? tuNgayTao, DateTime? denNgayTao,
            DateTime? tuNgayPheDuyet, DateTime? denNgayPheDuyet,
            DateTime? tuNgayTuChoi, DateTime? denNgayTuChoi)
        {
            var query = _context.LoanProfiles.AsQueryable();

            if (!string.IsNullOrEmpty(tenKhachHang))
                query = query.Where(p => p.CustomerName.Contains(tenKhachHang));

            if (!string.IsNullOrEmpty(trangThai))
            {
                query = query.Where(p => p.IsApproved == trangThai);
            }

            if (tuNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt >= tuNgayTao.Value);

            if (denNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt <= denNgayTao.Value);

            if (tuNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value >= tuNgayPheDuyet.Value);

            if (denNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value <= denNgayPheDuyet.Value);

            if (tuNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value >= tuNgayTuChoi.Value);

            if (denNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value <= denNgayTuChoi.Value);

            var tempResult = query
                .Select(p => new
                {
                    p.ProfileId,
                    p.CustomerName,
                    p.CitizenId,
                    p.CreatedAt,
                    p.ApprovedAt,
                    p.RejectedAt,
                    p.IsApproved
                })
                .ToList();

            var result = tempResult
                .Select(p => new
                {
                    p.ProfileId,
                    p.CustomerName,
                    p.CitizenId,
                    p.CreatedAt,
                    p.ApprovedAt,
                    p.RejectedAt,
                    TrangThai = p.IsApproved
                }).ToList();


            ViewBag.Data = result;

            // Giữ lại các giá trị filter khi reload view
            ViewBag.TenKhachHang = tenKhachHang;
            ViewBag.TrangThai = trangThai;
            ViewBag.TuNgayTao = tuNgayTao?.ToString("yyyy-MM-dd");
            ViewBag.DenNgayTao = denNgayTao?.ToString("yyyy-MM-dd");
            ViewBag.TuNgayPheDuyet = tuNgayPheDuyet?.ToString("yyyy-MM-dd");
            ViewBag.DenNgayPheDuyet = denNgayPheDuyet?.ToString("yyyy-MM-dd");
            ViewBag.TuNgayTuChoi = tuNgayTuChoi?.ToString("yyyy-MM-dd");
            ViewBag.DenNgayTuChoi = denNgayTuChoi?.ToString("yyyy-MM-dd");

            return View();
        }





        public IActionResult ExportToPdf(DateTime? fromDate, DateTime? toDate, string accountType, string searchTerm, decimal? minBalance)
        {
            var accounts = _context.DepositAccounts.Include(a => a.Customer).AsQueryable();

            if (fromDate.HasValue)
                accounts = accounts.Where(a => a.CreatedAt >= fromDate.Value);
            if (toDate.HasValue)
                accounts = accounts.Where(a => a.CreatedAt <= toDate.Value);
            if (!string.IsNullOrEmpty(accountType))
                accounts = accounts.Where(a => a.AccountType.Contains(accountType));
            if (!string.IsNullOrEmpty(searchTerm))
                accounts = accounts.Where(a =>
                    a.Customer.FullName.Contains(searchTerm) ||
                    a.AccountNumber.Contains(searchTerm));
            if (minBalance.HasValue)
                accounts = accounts.Where(a => a.Balance >= minBalance.Value);

            using (MemoryStream stream = new MemoryStream())
            {
                iTextSharp.text.Document document = new iTextSharp.text.Document(PageSize.A4.Rotate());
                PdfWriter writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                iTextSharp.text.Font titleFont = new iTextSharp.text.Font(baseFont, 16, iTextSharp.text.Font.BOLD);
                iTextSharp.text.Font textFont = new iTextSharp.text.Font(baseFont, 11, iTextSharp.text.Font.NORMAL);

                // Tiêu đề
                Paragraph title = new Paragraph("Báo cáo danh sách tài khoản tiền gửi", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 20
                };
                document.Add(title);

                // Bảng
                PdfPTable table = new PdfPTable(6) { WidthPercentage = 100 };
                table.SetWidths(new float[] { 1.5f, 4f, 5f, 3f, 3.5f, 3f });

                // Header
                string[] headers = { "STT", "Mã tài khoản", "Tên khách hàng", "Ngày mở", "Loại tài khoản", "Số dư hiện tại" };
                foreach (var header in headers)
                {
                    table.AddCell(new PdfPCell(new Phrase(header, textFont)) { BackgroundColor = BaseColor.LIGHT_GRAY });
                }

                int stt = 1;
                foreach (var item in accounts)
                {
                    table.AddCell(new Phrase(stt.ToString(), textFont));
                    table.AddCell(new Phrase(item.AccountNumber ?? "", textFont));
                    table.AddCell(new Phrase(item.Customer?.FullName ?? "Không có dữ liệu", textFont));
                    table.AddCell(new Phrase(((DateTime)item.CreatedAt).ToString("dd/MM/yyyy"), textFont));
                    table.AddCell(new Phrase(string.IsNullOrEmpty(item.AccountType) ? "Không có dữ liệu" : item.AccountType, textFont));
                    table.AddCell(new Phrase(item.Balance.ToString("N2"), textFont));
                    stt++;
                }

                document.Add(table);
                document.Close();

                return File(stream.ToArray(), "application/pdf", "BaoCaoTaiKhoanTienGui.pdf");
            }
        }


        public IActionResult ExportToPdfKhachHang(string? searchName, string? searchId, string? accountType, DateTime? fromDate, DateTime? toDate)
        {
            var depositAccounts = _context.DepositAccounts.Include(d => d.Customer).AsQueryable();
            var loanAccounts = _context.LoanAccounts.Include(l => l.Customer).AsQueryable();

            if (!string.IsNullOrEmpty(searchName))
            {
                depositAccounts = depositAccounts.Where(d => d.Customer.FullName.Contains(searchName));
                loanAccounts = loanAccounts.Where(l => l.Customer.FullName.Contains(searchName));
            }

            if (!string.IsNullOrEmpty(searchId))
            {
                depositAccounts = depositAccounts.Where(d => d.CustomerId.Contains(searchId));
                loanAccounts = loanAccounts.Where(l => l.CustomerId.Contains(searchId));
            }

            if (!string.IsNullOrEmpty(accountType))
            {
                depositAccounts = depositAccounts.Where(d => d.AccountType == accountType);
            }

            if (fromDate.HasValue)
            {
                depositAccounts = depositAccounts.Where(d => d.CreatedAt >= fromDate.Value);
            }

            if (toDate.HasValue)
            {
                depositAccounts = depositAccounts.Where(d => d.CreatedAt <= toDate.Value);
            }

            var depositList = depositAccounts.ToList();
            var loanList = loanAccounts.ToList();

            var groupedData = depositList
                .GroupBy(d => d.CustomerId)
                .Select(g =>
                {
                    var customerLoans = loanList.Where(l => l.CustomerId == g.Key).ToList();

                    return new
                    {
                        CustomerId = g.Key,
                        FullName = g.First().Customer?.FullName ?? "Không có dữ liệu",
                        DepositAccountCount = g.Count(),
                        LoanAccountCount = customerLoans.Count,
                        TotalDepositBalance = g.Sum(d => d.Balance),
                        TotalLoanAmount = customerLoans.Sum(l => l.LoanAmount),
                        OpenDate = g.Min(d => d.CreatedAt)
                    };
                })
                .ToList();

            // Bắt đầu tạo PDF
            using (MemoryStream stream = new MemoryStream())
            {
                var document = new iTextSharp.text.Document(PageSize.A4.Rotate(), 20, 20, 20, 20); // Khổ ngang
                PdfWriter.GetInstance(document, stream);
                document.Open();

                // Font hỗ trợ tiếng Việt
                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                var titleFont = new iTextSharp.text.Font(baseFont, 16, iTextSharp.text.Font.BOLD);
                var textFont = new iTextSharp.text.Font(baseFont, 12, iTextSharp.text.Font.NORMAL);

                // Tiêu đề
                var title = new Paragraph("Báo cáo tổng hợp khách hàng", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 20
                };
                document.Add(title);

                // Bảng dữ liệu
                PdfPTable table = new PdfPTable(7);
                table.WidthPercentage = 100;
                table.SetWidths(new float[] { 2f, 4f, 3f, 3f, 3f, 3f, 3f });

                string[] headers = { "Mã KH", "Tên KH", "Số lượng TK tiền gửi", "Số lượng khoản vay", "Tổng số dư tiền gửi", "Tổng tiền vay", "Ngày mở gần nhất" };
                foreach (var header in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(header, textFont));
                    cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                    table.AddCell(cell);
                }

                foreach (var item in groupedData)
                {
                    table.AddCell(new Phrase(item.CustomerId ?? "Không có dữ liệu", textFont));
                    table.AddCell(new Phrase(item.FullName ?? "Không có dữ liệu", textFont));
                    table.AddCell(new Phrase(item.DepositAccountCount.ToString(), textFont));
                    table.AddCell(new Phrase(item.LoanAccountCount.ToString(), textFont));
                    table.AddCell(new Phrase(item.TotalDepositBalance.ToString("N0"), textFont));
                    table.AddCell(new Phrase(item.TotalLoanAmount.ToString("N0"), textFont));
                    table.AddCell(new Phrase(((DateTime)item.OpenDate).ToString("dd/MM/yyyy"), textFont));
                }

                document.Add(table);
                document.Close();

                return File(stream.ToArray(), "application/pdf", "BaoCaoTongHopKhachHang.pdf");
            }
        }


        public IActionResult ExportToPdfHoSoVayVon(string? tenKhachHang, string? trangThai,
            DateTime? tuNgayTao, DateTime? denNgayTao,
            DateTime? tuNgayPheDuyet, DateTime? denNgayPheDuyet,
            DateTime? tuNgayTuChoi, DateTime? denNgayTuChoi)
        {
            var query = _context.LoanProfiles.AsQueryable();

            if (!string.IsNullOrEmpty(tenKhachHang))
                query = query.Where(p => p.CustomerName.Contains(tenKhachHang));

            if (!string.IsNullOrEmpty(trangThai))
            {
                query = query.Where(p => p.IsApproved == trangThai);
            }

            if (tuNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt.Date >= tuNgayTao.Value.Date);
            if (denNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt.Date <= denNgayTao.Value.Date);

            if (tuNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value.Date >= tuNgayPheDuyet.Value.Date);
            if (denNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value.Date <= denNgayPheDuyet.Value.Date);

            if (tuNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value.Date >= tuNgayTuChoi.Value.Date);
            if (denNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value.Date <= denNgayTuChoi.Value.Date);

            var data = query.ToList();

            using (MemoryStream stream = new MemoryStream())
            {
                iTextSharp.text.Document document = new iTextSharp.text.Document(PageSize.A4.Rotate());
                PdfWriter writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                // Font hỗ trợ tiếng Việt
                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                iTextSharp.text.Font titleFont = new iTextSharp.text.Font(baseFont, 16, iTextSharp.text.Font.BOLD);
                iTextSharp.text.Font textFont = new iTextSharp.text.Font(baseFont, 12, iTextSharp.text.Font.NORMAL);

                // Tiêu đề
                Paragraph title = new Paragraph("BÁO CÁO TỔNG HỢP HỒ SƠ VAY VỐN", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 20
                };
                document.Add(title);

                // Tạo bảng
                PdfPTable table = new PdfPTable(8)
                {
                    WidthPercentage = 100
                };
                table.SetWidths(new float[] { 2f, 4f, 3f, 3f, 3f, 3f, 3f, 3f });

                // Header
                string[] headers = { "Mã hồ sơ", "Tên KH", "Mã KH", "Ghi chú hồ sơ", "Ngày tạo", "Ngày phê duyệt", "Ngày từ chối", "Trạng thái" };
                foreach (var header in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(header, textFont))
                    {
                        BackgroundColor = BaseColor.LIGHT_GRAY,
                        HorizontalAlignment = Element.ALIGN_CENTER
                    };
                    table.AddCell(cell);
                }

                // Dữ liệu
                foreach (var item in data)
                {
                    table.AddCell(new PdfPCell(new Phrase(item.ProfileId, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.CustomerName, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.CitizenId, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.Notes, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.CreatedAt.ToString("dd/MM/yyyy"), textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.ApprovedAt?.ToString("dd/MM/yyyy") ?? "-", textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.RejectedAt?.ToString("dd/MM/yyyy") ?? "-", textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.IsApproved, textFont)));
                }

                document.Add(table);
                document.Close();

                return File(stream.ToArray(), "application/pdf", "BaoCao_HoSoVayVon.pdf");
            }
        }


        public IActionResult XuatExcelBaoCaoHoSoVayVon(string? tenKhachHang, string? trangThai,
            DateTime? tuNgayTao, DateTime? denNgayTao,
            DateTime? tuNgayPheDuyet, DateTime? denNgayPheDuyet,
            DateTime? tuNgayTuChoi, DateTime? denNgayTuChoi)
        {
            var query = _context.LoanProfiles.AsQueryable();

            if (!string.IsNullOrEmpty(tenKhachHang))
                query = query.Where(p => p.CustomerName.Contains(tenKhachHang));

            if (!string.IsNullOrEmpty(trangThai))
                query = query.Where(p => (p.IsApproved == "true" && trangThai == "Đã phê duyệt") ||
                                         (p.IsApproved == "false" && trangThai == "Từ chối") ||
                                         (string.IsNullOrEmpty(p.IsApproved) && trangThai == "Đang chờ"));

            if (tuNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt >= tuNgayTao.Value);

            if (denNgayTao.HasValue)
                query = query.Where(p => p.CreatedAt <= denNgayTao.Value);

            if (tuNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value >= tuNgayPheDuyet.Value);

            if (denNgayPheDuyet.HasValue)
                query = query.Where(p => p.ApprovedAt.HasValue && p.ApprovedAt.Value <= denNgayPheDuyet.Value);

            if (tuNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value >= tuNgayTuChoi.Value);

            if (denNgayTuChoi.HasValue)
                query = query.Where(p => p.RejectedAt.HasValue && p.RejectedAt.Value <= denNgayTuChoi.Value);

            var data = query.ToList();

            using var package = new ExcelPackage();
            var sheet = package.Workbook.Worksheets.Add("HoSoVayVon");

            // Header
            var headers = new[] { "Mã hồ sơ", "Tên KH", "Mã KH", "Số tiền vay", "Ngày tạo", "Ngày phê duyệt", "Ngày từ chối", "Trạng thái" };
            for (int i = 0; i < headers.Length; i++)
            {
                sheet.Cells[1, i + 1].Value = headers[i];
                sheet.Cells[1, i + 1].Style.Font.Bold = true;
                sheet.Column(i + 1).AutoFit();
            }

            // Data
            for (int i = 0; i < data.Count; i++)
            {
                var item = data[i];
                sheet.Cells[i + 2, 1].Value = item.ProfileId;
                sheet.Cells[i + 2, 2].Value = item.CustomerName;
                sheet.Cells[i + 2, 3].Value = item.CitizenId;
                sheet.Cells[i + 2, 4].Value = item.LoanAmount;
                sheet.Cells[i + 2, 5].Value = item.CreatedAt.ToString("dd/MM/yyyy");
                sheet.Cells[i + 2, 6].Value = item.ApprovedAt?.ToString("dd/MM/yyyy") ?? "-";
                sheet.Cells[i + 2, 7].Value = item.RejectedAt?.ToString("dd/MM/yyyy") ?? "-";
                sheet.Cells[i + 2, 8].Value = item.IsApproved switch
                {
                    "true" => "Đã phê duyệt",
                    "false" => "Từ chối",
                    _ => "Đang chờ"
                };
            }

            var stream = new MemoryStream(package.GetAsByteArray());
            string fileName = $"BaoCaoHoSoVayVon_{DateTime.Now:yyyyMMddHHmmss}.xlsx";
            return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
        }
        public IActionResult ExportToPdfDanhSachTaiKhoanVay(string? searchTerm, string? loanStatus, DateOnly? tuNgayTao, DateOnly? denNgayTao, bool? isFullyPaid)
        {
            var loanAccounts = _context.LoanAccounts.Include(l => l.Customer).AsQueryable();
            var currentDate = DateOnly.FromDateTime(DateTime.Now);

            // Lọc theo từ khóa tìm kiếm
            if (!string.IsNullOrEmpty(searchTerm))
            {
                loanAccounts = loanAccounts.Where(l =>
                    l.Customer.FullName.Contains(searchTerm) ||
                    l.CustomerId.Contains(searchTerm));
            }

            // Lọc theo trạng thái khoản vay
            if (!string.IsNullOrEmpty(loanStatus))
            {
                loanAccounts = loanAccounts.Where(l => l.LoanStatus == loanStatus);
            }

            // Lọc theo tình trạng trả nợ
            if (isFullyPaid.HasValue)
            {
                loanAccounts = loanAccounts.Where(l => l.IsFullyPaid == isFullyPaid.Value);
            }

            // Lọc theo khoảng thời gian DueDate
            if (tuNgayTao.HasValue)
            {
                loanAccounts = loanAccounts.Where(l => l.DueDate.HasValue && l.DueDate.Value >= tuNgayTao.Value);
            }

            if (denNgayTao.HasValue)
            {
                loanAccounts = loanAccounts.Where(l => l.DueDate.HasValue && l.DueDate.Value <= denNgayTao.Value);
            }

            // Tạo PDF
            using (MemoryStream stream = new MemoryStream())
            {
                iTextSharp.text.Document document = new iTextSharp.text.Document(PageSize.A4.Rotate(), 20, 20, 20, 20); // Khổ ngang
                PdfWriter writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                // Font hỗ trợ tiếng Việt
                string fontPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), "times.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                iTextSharp.text.Font titleFont = new iTextSharp.text.Font(baseFont, 16, iTextSharp.text.Font.BOLD);
                iTextSharp.text.Font textFont = new iTextSharp.text.Font(baseFont, 12, iTextSharp.text.Font.NORMAL);

                // Tiêu đề
                Paragraph title = new Paragraph("Báo cáo danh sách tài khoản vay", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER,
                    SpacingAfter = 20
                };
                document.Add(title);

                // Tạo bảng
                PdfPTable table = new PdfPTable(6) { WidthPercentage = 100 }; // Thêm cột cho tình trạng trả nợ
                table.SetWidths(new float[] { 2f, 4f, 3f, 3f, 3f, 3f });

                // Header
                string[] headers = { "Mã khoản vay", "Tên khách hàng", "Số tiền vay", "Ngày đến hạn", "Tình trạng giải ngân", "Tình trạng trả nợ" };
                foreach (var header in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(header, textFont))
                    {
                        BackgroundColor = BaseColor.LIGHT_GRAY,
                        HorizontalAlignment = Element.ALIGN_CENTER
                    };
                    table.AddCell(cell);
                }

                // Dữ liệu
                foreach (var item in loanAccounts.ToList())
                {
                    DateTime? dueDate = item.DueDate.HasValue ? item.DueDate.Value.ToDateTime(new TimeOnly(0, 0)) : null;
                    var status = dueDate.HasValue
                        ? (currentDate > item.DueDate.Value ? "Đã đến hạn" : "Chưa đến hạn")
                        : "Chưa xác định";

                    table.AddCell(new PdfPCell(new Phrase(item.LoanId, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.Customer?.FullName ?? "Không có dữ liệu", textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.LoanAmount.ToString("N2"), textFont)) { HorizontalAlignment = Element.ALIGN_RIGHT });
                    table.AddCell(new PdfPCell(new Phrase(dueDate?.ToString("dd/MM/yyyy") ?? "Chưa xác định", textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.LoanStatus, textFont)));
                    table.AddCell(new PdfPCell(new Phrase(item.IsFullyPaid ? "Trả hết" : "Chưa trả hết", textFont))); // Thêm cột tình trạng trả nợ
                }

                document.Add(table);
                document.Close();

                return File(stream.ToArray(), "application/pdf", "BaoCaoDanhSachTaiKhoanVay.pdf");
            }
        }

    }
}
