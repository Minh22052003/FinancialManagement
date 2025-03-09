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
        private readonly DatabaseConnection _context;
        public AuthController(DatabaseConnection context)
        {
            _context = context;
        }
        // GET: /Account/Login
        public IActionResult Login()
        {
            return View();
        }

        // POST: /Account/Login
        [HttpPost]
        public IActionResult Login(Account account)
        {
            if (ModelState.IsValid)
            {
                //su dung bam MD5 de bam mat khau
                var hard_Password = GetMD5(account.Password);
                //so sanh voi database
                var user = _context.Users.Where(s => s.Username == account.Username && hard_Password == account.Password).FirstOrDefault();
                if (user != null)
                {
                    HttpContext.Session.SetString("Username", account.Username);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Invalid login attempt.");
                    return View();
                }

            }
            return View();

        }

        // Action Đăng xuất
        public IActionResult DangXuat()
        {
            // Xóa toàn bộ dữ liệu session
            HttpContext.Session.Clear();
            // Chuyển hướng về trang đăng nhập
            return RedirectToAction("Login", "Account");
        }

        //ham bam MD5
        public string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;
            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");
            }
            return byte2String;
        }
    }
}
