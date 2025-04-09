using DOAN.DTOs;
using DOAN.Models;
using DOAN.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
        public IActionResult GetByAccountNumber(string accountNumber)
        {
            if (string.IsNullOrEmpty(accountNumber))
            {
                return Json(null);
            }

            // Tìm DepositAccount theo AccountNumber và Include thông tin Customer
            var depositAccount = _context.DepositAccounts
                .Include(a => a.Customer)
                .FirstOrDefault(a => a.AccountNumber == accountNumber);

            if (depositAccount == null)
            {
                return Json(null);
            }

            return Json(new
            {
                accountHolder = depositAccount.Customer.FullName,
                accountType = depositAccount.AccountType,
                branch = depositAccount.Branch,
                balance = depositAccount.Balance
            });
        }


        [HttpGet]
        public IActionResult MoTaiKhoanTienGui()
        {
            return View();
        }
        public IActionResult DanhSachTaiKhoanChuyenDung()
        {
            var data = _context.SpecializedAccounts.ToList();
            return View(data);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult MoTaiKhoanTienGui(TaiKhoanChuyenDungViewModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    string customerIdStr = model.CustomerId;

                    // Nếu chưa có info, thêm mới khách hàng
                    if (!_context.Customers.Any(c => c.CustomerId == customerIdStr))
                    {
                        var customer = new Customer
                        {
                            CustomerId = customerIdStr,
                            FullName = model.CustomerName,
                            Phone = model.PhoneNumber,
                            IdentityNumber = model.IdentityNumber,
                        };
                        _context.Customers.Add(customer);
                        _context.SaveChanges();
                    }

                    // Tạo tài khoản tiền gửi
                    string generatedDepositAccountNumber = GenerateAccountNumber();

                    var depositAccount = new DepositAccount
                    {
                        CustomerId = customerIdStr,
                        AccountNumber = generatedDepositAccountNumber,
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

                    // Nếu có tài khoản chuyên dụng
                    string? specializedAccNum = null;

                    if (!string.IsNullOrEmpty(model.InterestReceiveMethod) &&
                        model.InterestReceiveMethod.Equals("mochuyendung", StringComparison.OrdinalIgnoreCase))
                    {
                        specializedAccNum = model.AccountNumberDeposit.ToString();

                        var specialized = new SpecializedAccount
                        {
                            AccountId = specializedAccNum,
                            AccountHolder = model.AccountHolderDeposit,
                            Balance = 0,
                            AccountType = "Tài khoản chuyên dụng nhận lãi gửi",
                            Branch = model.Branch,
                            CreateAt = DateTime.Now
                           
                        };
                        _context.SpecializedAccounts.Add(specialized);
                        _context.SaveChanges();
                    }

                    return Json(new
                    {
                        success = true,
                        depositAccountNumber = generatedDepositAccountNumber,
                        specializedAccountNumber = specializedAccNum,
                        openDateTime = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")
                    });
                }
                catch (Exception ex)
                {
                    return Json(new { success = false, errors = new[] { "Lỗi hệ thống: " + ex.Message } });
                }
            }

            return Json(new { success = false, errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToArray() });
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
                             AccountNumber = account.AccountNumber,
                             AccountType = account.AccountType,
                             CitizenId = customer.IdentityNumber,
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
