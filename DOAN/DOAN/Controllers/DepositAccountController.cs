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
        public IActionResult MoTaiKhoanTienGui(TaiKhoanChuyenDungViewModel model)
        {
            if (ModelState.IsValid)
            {
                // 1. Create a new customer using information from the view model.
                var now = DateTime.Now;
                int prefix = int.Parse(now.ToString("yyMM"));
                int countInMonth = _context.Customers.Count(c => c.CustomerId.ToString().StartsWith(prefix.ToString())) + 1;
                string customerIdStr = prefix + countInMonth.ToString("D2");

                var customer = new Customer
                {
                    CustomerId = customerIdStr,
                    FullName = model.CustomerName,
                    Phone = model.PhoneNumber,
                    IdentityNumber = model.IdentityNumber,
                };
                _context.Customers.Add(customer);
                _context.SaveChanges();

                // 2. Create a deposit account record using info from model.
                var depositAccount = new DepositAccount
                {
                    CustomerId = customer.CustomerId,
                    AccountNumber = GenerateAccountNumber(),  // Your function to generate account number
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

                // 3. If the user selected "mochuyendung" as the interest receive method,
                // create a specialized account with Balance = 0 and AccountType = "NhanLai".
                if (!string.IsNullOrEmpty(model.InterestReceiveMethod) &&
                    model.InterestReceiveMethod.Equals("mochuyendung", StringComparison.OrdinalIgnoreCase))
                {
                    // Create specialized account record.
                    var specialized = new SpecializedAccount
                    {
                        AccountHolder = model.AccountHolderDeposit, // Provided by user in the deposit account form
                        Balance = 0,  // Balance set to 0 initially
                        AccountType = "NhanLai"
                    };

                    _context.SpecializedAccounts.Add(specialized);
                    _context.SaveChanges();

                    // Update the deposit account to link with the specialized account.
                    depositAccount.SpecializedAccountId = specialized.AccountId;
                    _context.SaveChanges();
                }

                return RedirectToAction("DanhSachTaiKhoanTienGui"); // Redirect to the list or confirmation page.
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
