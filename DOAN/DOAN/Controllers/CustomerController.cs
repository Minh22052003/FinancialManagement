using DOAN.DTOs;
using DOAN.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace DOAN.Controllers
{
    public class CustomerController : Controller
    {
        private readonly HeThongTaiChinhDbContext _context = new HeThongTaiChinhDbContext();

        public CustomerController() { }

        // Hiển thị danh sách khách hàng
        [HttpGet]
        public IActionResult Index()
        {
            var customers = _context.Customers.ToList();
            var customerDtos = customers.Select(customer => new Customer_DTO
            {
                CustomerId = customer.CustomerId,
                FullName = customer.FullName,
                DateOfBirth = customer.DateOfBirth,
                Address = customer.Address,
                Phone = customer.Phone,
                Email = customer.Email,
                IdentityNumber = customer.IdentityNumber
            }).ToList();
            return View(customerDtos);
        }

        // Thêm khách hàng mới (các action thêm khách hàng giữ nguyên)
        [HttpGet]
        public IActionResult ThemKhachHang()
        {
            return View();
        }

        [HttpPost]
        public IActionResult ThemKhachHang(Customer_DTO customerDto)
        {
            if (ModelState.IsValid)
            {
                var now = DateTime.Now;
                int prefix = int.Parse(now.ToString("yyMM"));
                int countInMonth = _context.Customers.Count(c => c.CustomerId.ToString().StartsWith(prefix.ToString())) + 1;
                string customerId = prefix + countInMonth.ToString("D2");

                var customer = new Customer
                {
                    CustomerId = customerId,
                    FullName = customerDto.FullName,
                    DateOfBirth = customerDto.DateOfBirth,
                    Address = customerDto.Address,
                    Phone = customerDto.Phone,
                    Email = customerDto.Email,
                    IdentityNumber = customerDto.IdentityNumber
                };
                _context.Customers.Add(customer);
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }

        // Tìm kiếm khách hàng (giữ nguyên nếu cần)
        [HttpGet]
        public IActionResult TimKiemVaTraCuu(string? searchKeyword)
        {
            var query = _context.Customers.AsQueryable();
            if (!string.IsNullOrEmpty(searchKeyword))
            {
                
                query = query.Where(c =>
                    c.CustomerId == searchKeyword ||
                    c.FullName.Contains(searchKeyword) ||
                    c.IdentityNumber.Contains(searchKeyword) ||
                    c.Phone.Contains(searchKeyword));

                var customerDtos = query.Select(customer => new Customer_DTO
                {
                    CustomerId = customer.CustomerId,
                    FullName = customer.FullName,
                    DateOfBirth = customer.DateOfBirth,
                    Address = customer.Address,
                    Phone = customer.Phone,
                    Email = customer.Email,
                    IdentityNumber = customer.IdentityNumber
                }).ToList();

                return View(customerDtos);
            }
            return View();

        }

        // Lấy thông tin khách hàng để chỉnh sửa (trả về JSON)
        [HttpGet]
        public IActionResult Edit(string id)
        {
            var customer = _context.Customers.FirstOrDefault(c => c.CustomerId == id);
            if (customer == null)
            {
                return Json(null);
            }
            var customerDto = new Customer_DTO
            {
                CustomerId = customer.CustomerId,
                FullName = customer.FullName,
                DateOfBirth = customer.DateOfBirth,
                Address = customer.Address,
                Phone = customer.Phone,
                Email = customer.Email,
                IdentityNumber = customer.IdentityNumber
            };
            return Json(new
            {
                customerId = customerDto.CustomerId,
                fullName = customerDto.FullName,
                dateOfBirth = customerDto.DateOfBirth?.ToString("yyyy-MM-dd"),
                address = customerDto.Address,
                phone = customerDto.Phone,
                email = customerDto.Email,
                identityNumber = customerDto.IdentityNumber
            });
        }

        // Lưu thay đổi thông tin khách hàng sau chỉnh sửa (trả về JSON)
        [HttpPost]
        public IActionResult Edit(Customer_DTO model)
        {
            if (ModelState.IsValid)
            {
                var customer = _context.Customers.FirstOrDefault(c => c.CustomerId == model.CustomerId);
                if (customer == null)
                {
                    return Json(new { success = false });
                }
                customer.FullName = model.FullName;
                customer.DateOfBirth = model.DateOfBirth;
                customer.Address = model.Address;
                customer.Phone = model.Phone;
                customer.Email = model.Email;
                customer.IdentityNumber = model.IdentityNumber;

                _context.SaveChanges();
                return Json(new { success = true });
            }
            return Json(new { success = false });
        }

        // Xóa khách hàng (trả về JSON)
        [HttpPost]
        public IActionResult Delete(string id)
        {
            var customer = _context.Customers.FirstOrDefault(c => c.CustomerId == id);
            if (customer == null)
            {
                return Json(new { success = false });
            }
            _context.Customers.Remove(customer);
            _context.SaveChanges();
            return Json(new { success = true });
        }

        // API lấy thông tin khách hàng theo mã khách hàng (CustomerId)
        [HttpGet]
        public IActionResult GetThongTinByVay(string maKH)
        {
            var customer = _context.Customers.FirstOrDefault(c => c.CustomerId == maKH);
            if (customer == null)
            {
                return Json(null);
            }

            // Trả về thông tin khách hàng dưới dạng JSON
            return Json(new
            {
                maKH = customer.CustomerId,
                tenKhachHang = customer.FullName,
                soDu = _context.DepositAccounts.Where(a => a.CustomerId == maKH).Sum(a => a.Balance) // Tổng số dư từ các tài khoản
            });
        }

        [HttpGet]
        public IActionResult GetThongTinByGui(string maKH)
        {
            var customer = _context.Customers.FirstOrDefault(c => c.CustomerId == maKH);
            if (customer == null)
            {
                return Json(null);
            }

            // Trả về thông tin khách hàng dưới dạng JSON
            return Json(new
            {
                maKH = customer.CustomerId,
                tenKhachHang = customer.FullName,
                soDienThoai = customer.Phone,
                identityNumber = customer.IdentityNumber
            });
        }

    }
}
