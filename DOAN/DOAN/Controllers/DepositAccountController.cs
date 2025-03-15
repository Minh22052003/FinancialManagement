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
        public IActionResult MoTaiKhoanTienGui(TaiKhoanTienGuiModel model)
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
            string dayPart = now.ToString("dd");
            string yearPart = now.ToString("yy");

            string basePrefix = prefix + dayPart + yearPart;

            var latestAccount = _context.DepositAccounts
                .Where(a => a.AccountNumber.StartsWith(basePrefix))
                .OrderByDescending(a => a.AccountNumber)
                .FirstOrDefault();

            int nextSequence = 1;
            if (latestAccount != null)
            {
                string seqStr = latestAccount.AccountNumber.Substring(basePrefix.Length);
                if (int.TryParse(seqStr, out int currentSequence))
                {
                    nextSequence = currentSequence + 1;
                }
            }

            string sequencePart = nextSequence.ToString("D4");

            return basePrefix + sequencePart;
        }

        [HttpGet]
        public IActionResult TaiKhoanChuyenDung()
        {
            return View();
        }


        [HttpPost]
        public IActionResult TaiKhoanChuyenDung(TaiKhoanChuyenDungViewModel model)
        {
            if (ModelState.IsValid)
            {
                
            }
            return View(model);
        }


        [HttpGet]
        public IActionResult DanhSachTaiKhoanTienGui()
        {
            var model = (from account in _context.DepositAccounts
                         join customer in _context.Customers
                         on account.CustomerId equals customer.CustomerId
                         select new TaiKhoanTienGuiModel
                         {
                             CustomerName = customer.FullName,
                             PhoneNumber = customer.Phone,
                             IdentityNumber = customer.IdentityNumber,
                             AccountType = account.AccountType,
                             Term = account.Term,
                             OpenDate = account.CreatedAt,
                             InitialDeposit = account.Balance,
                             InterestRate = account.InterestRate,
                             Branch = account.Branch
                         }).ToList();

            return View(model);
        }




    }
}
