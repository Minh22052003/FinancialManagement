using Microsoft.AspNetCore.Mvc;

namespace DOAN.Controllers
{
    public class LoanController : Controller
    {
        public IActionResult DangKyKhoanVay()
        {
            return View();
        }
    }
}
