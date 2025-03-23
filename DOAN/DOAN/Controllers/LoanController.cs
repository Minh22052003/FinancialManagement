using DOAN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DOAN.Controllers
{
    public class LoanController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;

        public LoanController(HeThongTaiChinhDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult DanhSachKhoanVay()
        {
            var loanAccounts = _context.LoanAccounts
                 .Include(l => l.Customer)
                 .ToList();

            return View(loanAccounts);
        }

        [HttpGet]
        public IActionResult DangKyKhoanVay()
        {
            return View();
        }

        [HttpPost]
        public IActionResult DangKyKhoanVay(LoanAccount model)
        {
            // Thiết lập ngày tạo hồ sơ vay
            model.CreatedAt = DateTime.Now;
            if (string.IsNullOrEmpty(model.LoanStatus))
            {
                model.LoanStatus = "Pending";
            }

            // Nếu chọn phương thức thanh toán "Auto", tạo thêm tài khoản chuyên dụng
            if (model.PaymentMethod == "Auto")
            {
                // Lấy thông tin bổ sung từ form (không nằm trong model LoanAccount)
                string specialAccountHolder = Request.Form["SpecialAccountHolder"];

                // Tạo mới tài khoản chuyên dụng
                var specializedAccount = new SpecializedAccount
                {
                    // Nếu có input cho số tài khoản thì có thể đọc từ Request.Form["SpecialAccountNumber"]
                    // Tuy nhiên, thường AccountId được tạo tự động nên ta chỉ cần gán tên chủ tài khoản.
                    AccountHolder = specialAccountHolder,
                    Balance = 0, // Khởi tạo số dư ban đầu là 0
                    AccountType = "Tài khoản chuyên dụng trả lãi vay",
                    Branch = "Bình Gia Branch",
                    // Chuyển DateTime.Now sang DateOnly (nếu dùng .NET 6+)
                    CreateAt = DateTime.Now
                };

                _context.SpecializedAccounts.Add(specializedAccount);
                _context.SaveChanges();

                // Liên kết tài khoản chuyên dụng vừa tạo với hồ sơ vay
                model.SpecializedAccountId = specializedAccount.AccountId;
            }

            _context.LoanAccounts.Add(model);
            _context.SaveChanges();

            return RedirectToAction("DanhSachKhoanVay");
        }
        public IActionResult LichSuTraNo() => View();


        [HttpGet]
        public IActionResult GenerateLoanId()
        {
            string prefix = "HSVV";
            string year = DateTime.Now.Year.ToString();
            string month = DateTime.Now.Month.ToString("D2"); // Tháng luôn có 2 chữ số

            // Lấy số thứ tự lớn nhất trong tháng hiện tại
            int latestIndex = _context.LoanAccounts
                .Where(l => l.CreatedAt.Year == DateTime.Now.Year && l.CreatedAt.Month == DateTime.Now.Month)
                .Count() + 1; // Số lượng hồ sơ trong tháng + 1

            string loanId = $"{prefix}{year}{month}{latestIndex:D3}"; // Định dạng số thứ tự thành 3 chữ số

            return Json(new { loanId });
        }
    }
}
