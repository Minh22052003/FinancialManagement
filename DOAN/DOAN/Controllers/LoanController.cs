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
        public IActionResult DangKyHoSoVay()
        {
            return View();
        }

        [HttpPost]
        public IActionResult DangKyHoSoVay(LoanProfile model)
        {
            if (ModelState.IsValid)
            {
                model.IsApproved = "Chưa phê duyệt";
                _context.LoanProfiles.Add(model);
                _context.SaveChanges();
                return RedirectToAction("DanhSachHoSoChuaPheDuyet");
            }
            return View(model);
        }

        [HttpGet]
        public IActionResult DanhSachHoSoChuaPheDuyet()
        {
            var loanProfiles = _context.LoanProfiles
                .Where(l => l.IsApproved == "Chưa phê duyệt")
                .ToList();
            return View(loanProfiles);
        }

        // POST: Phê duyệt hồ sơ
        [HttpPost]
        public IActionResult Approve(string profileId)
        {
            var profile = _context.LoanProfiles.FirstOrDefault(lp => lp.ProfileId == profileId);
            if (profile != null)
            {
                profile.IsApproved = "Đã phê duyệt";
                _context.SaveChanges();
                return Json(new { success = true, message = "Phê duyệt thành công!" });
            }
            return Json(new { success = false, message = "Hồ sơ không tồn tại." });
        }

        // POST: Từ chối hồ sơ
        [HttpPost]
        public IActionResult Reject(string profileId)
        {
            var profile = _context.LoanProfiles.FirstOrDefault(lp => lp.ProfileId == profileId);
            if (profile != null)
            {
                profile.IsApproved = "Đã từ chối";
                _context.SaveChanges();
                return Json(new { success = true, message = "Đã từ chối hồ sơ!" });
            }
            return Json(new { success = false, message = "Hồ sơ không tồn tại." });
        }

        [HttpGet]
        public IActionResult DanhSachHoSoDaPheDuyet()
        {
            var loanProfiles = _context.LoanProfiles.Where(x => x.IsApproved != "Chưa phê duyệt").ToList();
            return View(loanProfiles);
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
            string loanTerm = Request.Form["LoanTerm"];
            // Lấy ngày tạo khoản vay
            DateTime createdAt = model.CreatedAt;

            // Lấy số tháng từ LoanTerm
            if (int.TryParse(Request.Form["LoanTerm"], out int loanTermMonths))
            {
                // Tính ngày đáo hạn bằng cách cộng thêm số tháng vào ngày tạo khoản vay
                DateTime dueDateTime = createdAt.AddMonths(loanTermMonths);

                // Chuyển đổi sang DateOnly và gán vào model
                model.DueDate = DateOnly.FromDateTime(dueDateTime);
            }
            else
            {
                // Xử lý trường hợp giá trị LoanTerm không hợp lệ
                ModelState.AddModelError("LoanTerm", "Thời hạn vay không hợp lệ.");
            }

            if (string.IsNullOrEmpty(model.LoanStatus))
            {
                model.LoanStatus = "Chờ giải ngân";
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
                    AccountId = Request.Form["SpecialAccountNumber"],
                    AccountHolder = specialAccountHolder,
                    Balance = 0, // Khởi tạo số dư ban đầu là 0
                    AccountType = "Tài khoản chuyên dụng trả lãi vay",
                    Branch = "Bình Gia Branch",
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
        public IActionResult LichSuTraNo()
        {
            var lichsutrano = _context.LoanAccounts
                .Include(l => l.Customer)
                .Where(l => l.IsFullyPaid == true)
                .ToList();
            return View(lichsutrano);
        }


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

        [HttpGet]
        public IActionResult GenerateSpecializedAccountId()
        {
            string year = DateTime.Now.Year.ToString();
            string month = DateTime.Now.Month.ToString("D2"); // Tháng luôn có 2 chữ số

            // Lấy số thứ tự lớn nhất trong tháng hiện tại
            int latestIndex = _context.LoanAccounts
                .Where(l => l.CreatedAt.Year == DateTime.Now.Year && l.CreatedAt.Month == DateTime.Now.Month)
                .Count() + 1; // Số lượng hồ sơ trong tháng + 1

            string loanId = $"{year}{month}{latestIndex:D3}"; // Định dạng số thứ tự thành 3 chữ số
            int specializedaccountid = int.Parse(loanId);

            return Json(new { specializedaccountid });
        }


        [HttpGet]
        public IActionResult GetLoanProfileByID(string loanProfileId)
        {
            if (string.IsNullOrWhiteSpace(loanProfileId))
            {
                return Json(new { success = false, message = "LoanProfileId is required" });
            }

            var profile = _context.LoanProfiles.FirstOrDefault(lp => lp.ProfileId == loanProfileId);
            if (profile == null)
            {
                return Json(new { success = false, message = "Loan profile not found" });
            }

            // Trả về toàn bộ thông tin hồ sơ dưới dạng JSON
            return Json(new { success = true, data = profile });
        }

        [HttpPost]
        public IActionResult UpdateLoan([FromBody] LoanUpdateViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Tìm khoản vay theo LoanId
                var loan = _context.LoanAccounts.FirstOrDefault(l => l.LoanId == model.LoanId);
                if (loan != null)
                {
                    // Cập nhật các trường
                    loan.LoanAmount = model.LoanAmount;
                    // Tính DueDate dựa trên LoanTerm (số tháng) và ngày tạo
                    loan.DueDate = DateOnly.FromDateTime(loan.CreatedAt.AddMonths(model.LoanTerm));
                    // Cập nhật lãi suất
                    loan.InterestRate = model.InterestRate;
                    // Cập nhật trạng thái giải ngân (DisbursementStatus) theo select (giá trị đã chọn)
                    loan.LoanStatus = model.LoanStatus;
                    // Cập nhật phương thức thanh toán
                    loan.PaymentMethod = model.PaymentMethod;

                    loan.IsFullyPaid = model.IsFullyPaid;
                    if (loan.IsFullyPaid)
                    {
                        loan.FullyPaidAt = DateTime.Now;
                    }

                    _context.SaveChanges();
                    return Ok();
                }
                return NotFound("Không tìm thấy khoản vay cần cập nhật");
            }
            return BadRequest(ModelState);
        }

        //[HttpGet]
        //public IActionResult DanhSachKhoanVayChuaGiaiNgan()
        //{
        //    var loanAccounts = _context.LoanAccounts
        //         .Include(l => l.Customer)
        //         .Where(l=>l.LoanStatus == "Chờ giải ngân")
        //         .ToList();

        //    return View(loanAccounts);
        //}


        //[HttpGet]
        //public IActionResult DanhSachKhoanVayDaGiaiNgan()
        //{
        //    var loanAccounts = _context.LoanAccounts
        //          .Include(l => l.Customer)
        //          .Where(l => l.LoanStatus == "Đã giải ngân")
        //          .ToList();

        //    return View(loanAccounts);
        //}

        [HttpGet]
        public IActionResult GenerateLoanProfileIdNext()
        {
            try
            {
                var lastProfile = _context.LoanProfiles
                    .OrderByDescending(l => l.ProfileId)
                    .Select(l => l.ProfileId)
                    .FirstOrDefault();

                string nextProfileId = "LP0001";
                if (!string.IsNullOrEmpty(lastProfile))
                {
                    int lastNumber = int.Parse(lastProfile.Substring(2));
                    nextProfileId = $"LP{(lastNumber + 1):D4}";
                }

                return Json(new { profileid = nextProfileId });
            }
            catch (Exception ex)
            {
                return Json(new { error = "Lỗi khi tạo mã hồ sơ", details = ex.Message });
            }
        }


    }




    // ViewModel dùng cho cập nhật
    public class LoanUpdateViewModel
    {
        public string? LoanId { get; set; }
        public decimal LoanAmount { get; set; }
        public int LoanTerm { get; set; } // số tháng vay
        public decimal? InterestRate { get; set; }
        public string? LoanStatus { get; set; }
        public string? PaymentMethod { get; set; }
        public bool IsFullyPaid { get; set; }
    }
}