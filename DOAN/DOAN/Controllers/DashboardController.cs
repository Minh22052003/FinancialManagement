using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using DOAN.Models;

namespace DOAN.Controllers
{
    public class DashboardController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;

        public DashboardController(HeThongTaiChinhDbContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("TenDangNhap")))
            {
                return RedirectToAction("Login", "Auth");
            }
            TuDongTinhTien();
            return View();
        }

        public void TuDongTinhTien()
        {
            DateOnly today = DateOnly.FromDateTime(DateTime.Now);
            var loansDue = _context.LoanAccounts
                .Where(l => l.DueDate.HasValue && l.DueDate.Value <= today && !l.IsFullyPaid)
                .ToList();

            foreach (var loan in loansDue)
            {
                // Tính số tiền cần thanh toán: loanAmount * (1 + InterestRate)
                decimal interestRate = loan.InterestRate ?? 0m;
                decimal requiredAmount = loan.LoanAmount * (1 + interestRate);

                // Tìm tài khoản chuyên dụng tương ứng
                var specAccount = _context.SpecializedAccounts.FirstOrDefault(sa => sa.AccountId == loan.SpecializedAccountId);

                if (specAccount != null)
                {
                    if (specAccount.Balance >= requiredAmount)
                    {
                        // Trừ số tiền thanh toán khỏi số dư tài khoản chuyên dụng
                        specAccount.Balance -= requiredAmount;

                        // Cập nhật trạng thái khoản vay: đánh dấu đã trả, cập nhật ngày trả và trạng thái
                        loan.IsFullyPaid = true;
                        loan.FullyPaidAt = DateTime.Now;
                        loan.LoanStatus = "Fully Paid"; // Hoặc trạng thái phù hợp theo yêu cầu

                        // Tạo giao dịch cho bảng TransactionHistory
                        TransactionHistory transaction = new TransactionHistory
                        {
                            DepositAccountId = null,
                            SpecialAccountId = specAccount.AccountId,
                            TransactionAmount = requiredAmount,
                            TransactionDate = DateTime.Now,
                            Transactor = "Tự động", // hoặc "System"
                            TransactionStatus = "Success",
                            Description = "Tự động trừ nợ giao dịch"
                        };

                        _context.TransactionHistories.Add(transaction);
                    }
                    else
                    {
                        // Xử lý trường hợp tài khoản không đủ số dư nếu cần
                        Console.WriteLine($"Tài khoản {specAccount.AccountId} không đủ số dư cho khoản vay {loan.LoanId}.");
                    }
                }
                else
                {
                    Console.WriteLine($"Không tìm thấy tài khoản chuyên dụng cho khoản vay {loan.LoanId}.");
                }
            }

            // Lưu các thay đổi vào cơ sở dữ liệu
            _context.SaveChanges();

        }
    

    }
}
