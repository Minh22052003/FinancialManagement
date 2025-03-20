using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DOAN.Models;

namespace DOAN.Controllers
{
    public class TransactionController : Controller
    {
        public IActionResult GuiTienThanhToan()
        {
            return View();
        }

        public IActionResult RutTien()
        {
            return View();
        }
    }
}
