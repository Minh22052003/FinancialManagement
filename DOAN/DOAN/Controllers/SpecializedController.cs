using DOAN.Models;
using Microsoft.AspNetCore.Mvc;

namespace DOAN.Controllers
{
    public class SpecializedController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context;

        public SpecializedController(HeThongTaiChinhDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetById(int id)
        {
            var account = _context.SpecializedAccounts.FirstOrDefault(a => a.AccountId == id.ToString());
            if (account == null)
            {
                return Json(null);
            }
            return Json(new
            {
                accountHolder = account.AccountHolder,
                accountType = account.AccountType,
                branch = account.Branch,
                balance = account.Balance
            });
        }
    }
}
