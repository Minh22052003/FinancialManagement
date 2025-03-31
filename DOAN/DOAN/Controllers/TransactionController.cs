using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DOAN.Models;
using DOAN.DTOs;

namespace DOAN.Controllers
{
    public class TransactionController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;

        public TransactionController(HeThongTaiChinhDbContext context)
        {
            _context = context;
        }
        public IActionResult GuiTienThanhToan()
        {
            return View();
        }

        [HttpPost]
        public IActionResult GuiTienThanhToan([FromBody] DepositRequestModel_DTOs request)
        {
            if (request == null || request.Amount <= 0)
            {
                return BadRequest(new { success = false, message = "Số tiền gửi không hợp lệ." });
            }

            // Tìm tài khoản tiền gửi theo AccountNumber (giả sử AccountNumber là duy nhất)
            var depositAccount = _context.DepositAccounts.FirstOrDefault(a => a.AccountNumber == request.AccountNumber);
            if (depositAccount == null)
            {
                return NotFound(new { success = false, message = "Số tài khoản không tồn tại." });
            }

            // Cập nhật số dư
            depositAccount.Balance += request.Amount;

            // Tạo giao dịch (TransactionHistory)
            var transaction = new TransactionHistory
            {
                // Giả sử giao dịch liên quan đến DepositAccount, không liên kết SpecializedAccount
                DepositAccountId = depositAccount.AccountId,
                TransactionAmount = request.Amount,
                TransactionDate = DateTime.Now,
                Transactor = request.SenderName,
                TransactionStatus = "Completed",
                Description = "Gửi tiền vào tài khoản thanh toán"
            };

            _context.TransactionHistories.Add(transaction);
            _context.SaveChanges();

            return Json(new { success = true, transactionId = transaction.TransactionId });
        }

        public IActionResult RutTien()
        {
            return View();
        }

        // POST: /Transaction/RutTien
        [HttpPost]
        public async Task<IActionResult> RutTien([FromBody] WithdrawRequestModel model)
        {
            if (model == null)
            {
                return BadRequest("Yêu cầu không hợp lệ.");
            }

            // Kiểm tra kiểu tài khoản: "Deposit" hoặc "Specialized"
            if (model.AccountType == "Deposit")
            {
                // Tìm tài khoản thanh toán theo số tài khoản
                var depositAccount = await _context.DepositAccounts
                    .FirstOrDefaultAsync(a => a.AccountNumber == model.AccountNumber);

                if (depositAccount == null)
                {
                    return NotFound("Không tìm thấy tài khoản thanh toán.");
                }

                if (depositAccount.Balance < model.Amount)
                {
                    return BadRequest("Số dư không đủ để rút tiền.");
                }

                // Trừ số tiền rút
                depositAccount.Balance -= model.Amount;

                // Tạo bản ghi giao dịch
                var transaction = new TransactionHistory
                {
                    DepositAccountId = depositAccount.AccountId,
                    TransactionAmount = model.Amount,
                    TransactionDate = DateTime.Now,
                    Transactor = model.Transactor,
                    TransactionStatus = "Success",
                    Description = "Rút tiền từ tài khoản tiền gửi"
                };

                _context.TransactionHistories.Add(transaction);
                await _context.SaveChangesAsync();

                return Ok(new { success = true, transactionId = transaction.TransactionId });
            }
            else if (model.AccountType == "Specialized")
            {
                // Với tài khoản chuyên dụng, giả sử bạn tìm theo số tài khoản hoặc tên chủ tài khoản.
                // Ở đây ví dụ tìm theo tên chủ tài khoản (AccountHolder) đã được gửi từ view.
                var specializedAccount = await _context.SpecializedAccounts
                    .FirstOrDefaultAsync(a => a.AccountHolder == model.AccountHolder);

                if (specializedAccount == null)
                {
                    return NotFound("Không tìm thấy tài khoản chuyên dụng.");
                }

                if (specializedAccount.Balance < model.Amount)
                {
                    return BadRequest("Số dư không đủ để rút tiền.");
                }

                // Trừ số tiền rút
                specializedAccount.Balance -= model.Amount;

                // Tạo bản ghi giao dịch
                var transaction = new TransactionHistory
                {
                    SpecialAccountId = specializedAccount.AccountId,
                    TransactionAmount = model.Amount,
                    TransactionDate = DateTime.Now,
                    Transactor = model.Transactor,
                    TransactionStatus = "Success",
                    Description = "Rút tiền từ tài khoản chuyên dụng "
                };

                _context.TransactionHistories.Add(transaction);
                await _context.SaveChangesAsync();

                return Ok(new { success = true, transactionId = transaction.TransactionId });
            }
            else
            {
                return BadRequest("Kiểu tài khoản không hợp lệ.");
            }
        }

        // Model nhận dữ liệu từ AJAX
        public class WithdrawRequestModel
        {
            // Dành cho tài khoản thanh toán
            public string AccountNumber { get; set; }

            // Dành cho tài khoản chuyên dụng (giả sử ta dùng tên chủ tài khoản để tìm)
            public string AccountHolder { get; set; }

            public decimal Amount { get; set; }
            public string Transactor { get; set; }
            /// <summary>
            /// Giá trị "Deposit" hoặc "Specialized"
            /// </summary>
            public string AccountType { get; set; }
        }


        public IActionResult GuiTienChuyenDung()
        {
            return View();
        }

        [HttpPost]
        public IActionResult GuiTienChuyenDung(TransactionHistory model)
        {
            // Kiểm tra số tài khoản chuyên dụng có tồn tại không
            var specialized = _context.SpecializedAccounts.Find(model.SpecialAccountId);
            if (specialized == null)
            {
                return Json(new { success = false, message = "Không tìm thấy tài khoản chuyên dụng." });
            }

            // Gán thông tin giao dịch
            model.TransactionDate = DateTime.Now;
            if (string.IsNullOrEmpty(model.Transactor))
            {
                model.Transactor = specialized.AccountHolder;
            }
            model.TransactionStatus = "Completed";
            model.Description = "Gửi tiền vào tài khoản chuyên dụng";

            // Lưu giao dịch
            _context.TransactionHistories.Add(model);
            // Cập nhật số dư của tài khoản chuyên dụng: cộng thêm số tiền giao dịch
            specialized.Balance += model.TransactionAmount;
            _context.SaveChanges();

            return Json(new { success = true, transactionId = model.TransactionId });
        }

        public IActionResult LichSuGiaoDich()
        {
            var transactions = _context.TransactionHistories
                .Include(th => th.SpecialAccount)
                .Include(th => th.DepositAccount)
                    .ThenInclude(da => da.Customer) // nếu cần lấy thông tin khách hàng từ DepositAccount
                .ToList();
            return View(transactions);
        }
    }
}
