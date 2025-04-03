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
                // 1. Tạo khách hàng mới
                var now = DateTime.Now;
                int prefix = int.Parse(now.ToString("yyMM"));
                int countInMonth = _context.Customers.Count(c => c.CustomerId.StartsWith(prefix.ToString())) + 1;
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

                // 2. Tạo bản ghi tài khoản tiền gửi
                var depositAccount = new DepositAccount
                {
                    CustomerId = customer.CustomerId,
                    AccountNumber = GenerateAccountNumber(),  // Hàm tạo số tài khoản
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

                // 3. Nếu chọn phương thức nhận lãi là "mochuyendung", tạo tài khoản chuyên dụng
                if (!string.IsNullOrEmpty(model.InterestReceiveMethod) &&
                    model.InterestReceiveMethod.Equals("mochuyendung", StringComparison.OrdinalIgnoreCase))
                {

                    var specialized = new SpecializedAccount
                    {
                        AccountId = model.AccountNumberDeposit.ToString(), // Lấy giá trị từ view
                        AccountHolder = model.AccountHolderDeposit, // Lấy từ form nhập tên chủ tài khoản chuyên dụng
                        Balance = 0, // Số dư ban đầu là 0
                        AccountType = "Tài khoản chuyên dụng nhận lãi gửi",
                        Branch = model.Branch,
                        CreateAt = DateTime.Now
                    };

                    _context.SpecializedAccounts.Add(specialized);
                    _context.SaveChanges();

                    // Liên kết tài khoản tiền gửi với tài khoản chuyên dụng vừa tạo
                    depositAccount.SpecializedAccountId = specialized.AccountId;
                    _context.SaveChanges();

                    // Nếu bạn muốn trả về id tài khoản chuyên dụng về view (ví dụ hiển thị thông báo), có thể gán:
                    model.AccountNumberDeposit = int.Parse(specialized.AccountId);
                }

                return RedirectToAction("DanhSachTaiKhoanTienGui");
            }
            else
            {
                var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage);
                // Log các lỗi này, ví dụ:
                foreach (var error in errors)
                {
                    Console.WriteLine(error);
                }
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
