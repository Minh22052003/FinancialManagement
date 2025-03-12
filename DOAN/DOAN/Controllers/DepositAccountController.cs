using DOAN.DTOs;
using DOAN.Models;
using DOAN.ViewModel;
using Microsoft.AspNetCore.Mvc;

namespace DOAN.Controllers
{
    public class DepositAccountController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;

        public DepositAccountController(HeThongTaiChinhDbContext _context)
        {
            this._context = _context;
        }
        [HttpGet]
        public IActionResult MoTaiKhoanTienGui()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult MoTaiKhoanTienGui(MoTaiKhoanTienGuiModel model)
        {
            if (ModelState.IsValid)
            {
                var now = DateTime.Now;
                int prefix = int.Parse(now.ToString("yyMM"));
                int countInMonth = _context.Customers.Count(c => c.CustomerId.ToString().StartsWith(prefix.ToString())) + 1;
                string customerIdStr = prefix + countInMonth.ToString("D2");

                var customer = new Customer
                {
                    CustomerId = int.Parse(customerIdStr),
                    FullName = model.CustomerName,
                    Phone = model.PhoneNumber,
                    IdentityNumber = model.IdentityNumber,
                };
                _context.Customers.Add(customer);
                _context.SaveChanges();

                var depositAccount = new DepositAccount
                {
                    CustomerId = customer.CustomerId,
                    AccountNumber = GenerateAccountNumber(),
                    AccountType = model.AccountType,
                    Balance = model.InitialDeposit,
                    Term = model.Term,
                    InterestRate = model.InterestRate,
                    CreatedAt = model.OpenDate,
                    Status = "Active",
                    Branch = model.Branch
                };

                if (depositAccount.Term.HasValue)
                {
                    DateTime maturity = depositAccount.CreatedAt.AddMonths(depositAccount.Term.Value);
                    depositAccount.MaturityDate = DateOnly.FromDateTime(maturity);
                }

                _context.DepositAccounts.Add(depositAccount);
                _context.SaveChanges();

                return RedirectToAction("Index");
            }
            return View(model);
        }


        private string GenerateAccountNumber()
        {
            var now = DateTime.Now;
            string prefix = "9704";
            string dayPart = now.ToString("dd"); // 2 số ngày
            string yearPart = now.ToString("yy"); // 2 số năm (ví dụ: "25" cho năm 2025)

            // Ghép phần cố định: ví dụ "97041525"
            string basePrefix = prefix + dayPart + yearPart;

            // Lấy account number cao nhất hiện có có cùng basePrefix
            var latestAccount = _context.DepositAccounts
                .Where(a => a.AccountNumber.StartsWith(basePrefix))
                .OrderByDescending(a => a.AccountNumber)
                .FirstOrDefault();

            int nextSequence = 1;
            if (latestAccount != null)
            {
                // Lấy 4 số cuối của số tài khoản hiện có
                string seqStr = latestAccount.AccountNumber.Substring(basePrefix.Length);
                if (int.TryParse(seqStr, out int currentSequence))
                {
                    nextSequence = currentSequence + 1;
                }
            }

            // Định dạng số thứ tự thành chuỗi 4 chữ số
            string sequencePart = nextSequence.ToString("D4");

            return basePrefix + sequencePart;
        }

    }
}
