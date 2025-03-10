using DOAN.DTOs;
using DOAN.Models;
using Microsoft.AspNetCore.Mvc;

namespace DOAN.Controllers
{
    public class CustomerController : Controller
    {

        private readonly HeThongTaiChinhDbContext _context;

        public CustomerController(HeThongTaiChinhDbContext context)
        {
            _context = context;
        }

        //get danh sach khach hang va chuyen thanh customerdto
        [HttpGet]
        public IActionResult Index(string? search)
        {
            var query = _context.Customers.AsQueryable();

            if (!string.IsNullOrEmpty(search))
            {
                if (int.TryParse(search, out int id))
                {
                    query = query.Where(c => c.CustomerId == id);
                }
                else
                {
                    query = query.Where(c => c.FullName.Contains(search));
                }
            }

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

            return Ok(customerDtos);
        }



        //httppost de them khach hang dua tren customerdto va tra ve view danh sach khach hang
        [HttpPost]
        public IActionResult Create(Customer_DTO customerDto)
        {
            if (ModelState.IsValid)
            {
                var customer = new Customer
                {
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

        //get view de hien thi thong tin khach hang can sua dua tren id
        [HttpGet]
        public IActionResult Detail(int id)
        {
            //lay thong tin khach hang dua tren id
            var customer = _context.Customers.Find(id);
            if (customer == null)
            {
                return NotFound();
            }
            //chuyen tu customer sang customerdto
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
            return View(customerDto);
        }



        //httppost de sua khach hang dua tren customerdto va tra ve view danh sach khach hang
        [HttpPost]
        public IActionResult Edit(Customer_DTO customerDto)
        {
            if (ModelState.IsValid)
            {
                var customer = _context.Customers.Find(customerDto.CustomerId);
                if (customer == null)
                {
                    return NotFound();
                }
                customer.FullName = customerDto.FullName;
                customer.DateOfBirth = customerDto.DateOfBirth;
                customer.Address = customerDto.Address;
                customer.Phone = customerDto.Phone;
                customer.Email = customerDto.Email;
                customer.IdentityNumber = customerDto.IdentityNumber;
                _context.SaveChanges();
                return RedirectToAction("Index");
            }
            return View();
        }

        //httppost de xoa khach hang dua tren id va tra ve view danh sach khach hang
        [HttpPost]
        public IActionResult Delete(int id)
        {
            var customer = _context.Customers.Find(id);
            if (customer == null)
            {
                return NotFound();
            }
            _context.Customers.Remove(customer);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
