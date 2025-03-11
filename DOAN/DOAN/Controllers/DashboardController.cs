using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;

namespace DOAN.Controllers
{
    public class DashboardController : Controller
    {
        public IActionResult Index()
        {
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("TenDangNhap")))
            {
                return RedirectToAction("Login", "Auth");
            }
            return View();
        }
    }
}
