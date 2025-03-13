using DOAN.DTOs;
using DOAN.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using XSystem.Security.Cryptography;

namespace DOAN.Controllers
{
    public class AuthController : Controller
    {
        //lay thong tin tu database
        private readonly HeThongTaiChinhDbContext _context = new HeThongTaiChinhDbContext();
        public AuthController()
        {
        }
        // GET: /Account/Login
        public IActionResult Login()
        {
            return View();
        }

        // POST: /Account/Login
        [HttpPost]
        public IActionResult Login(Account_DTO account)
        {
            if (ModelState.IsValid)
            {
                //so sanh voi database
                var user = _context.Users.Where(s => s.Username == account.TenDangNhap && s.PasswordHash == account.MatKhau).FirstOrDefault();
                if (user != null)
                {
                    HttpContext.Session.SetString("TenDangNhap", account.TenDangNhap);
                    return RedirectToAction("Index", "Dashboard");
                }
                ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng");

            }
            return View(account);

        }

        // Action Đăng xuất
        public IActionResult DangXuat()
        {
            // Xóa toàn bộ dữ liệu session
            HttpContext.Session.Clear();
            // Chuyển hướng về trang đăng nhập
            return RedirectToAction("Login", "Auth");
        }
    }
}
