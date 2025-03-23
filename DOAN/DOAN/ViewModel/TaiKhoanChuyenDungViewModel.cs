using System;
using System.ComponentModel.DataAnnotations;

namespace DOAN.ViewModel
{
    public class TaiKhoanChuyenDungViewModel
    {
        // Thông tin khách hàng
        [Required(ErrorMessage = "Tên khách hàng không được để trống")]
        [Display(Name = "Tên khách hàng")]
        public string CustomerName { get; set; }

        [Required(ErrorMessage = "Số điện thoại không được để trống")]
        [Display(Name = "Số điện thoại")]
        public string PhoneNumber { get; set; }

        [Required(ErrorMessage = "CMND/CCCD/Hộ chiếu không được để trống")]
        [Display(Name = "CMND/CCCD/Hộ chiếu")]
        public string IdentityNumber { get; set; }

        // Thông tin tài khoản tiền gửi
        [Display(Name = "Chi nhánh")]
        public string Branch { get; set; } = "Bình Gia Branch";

        [Required(ErrorMessage = "Loại tiền gửi không được để trống")]
        [Display(Name = "Loại tiền gửi")]
        public string AccountType { get; set; }

        [Display(Name = "Thời gian gửi (tháng)")]
        public int? Term { get; set; }  // tính bằng tháng

        [Required(ErrorMessage = "Ngày mở tài khoản không được để trống")]
        [Display(Name = "Ngày mở tài khoản")]
        [DataType(DataType.Date)]
        public DateTime OpenDate { get; set; }

        [Required(ErrorMessage = "Số tiền gửi ban đầu không được để trống")]
        [Display(Name = "Số tiền gửi ban đầu")]
        [Range(0.01, double.MaxValue, ErrorMessage = "Số tiền phải lớn hơn 0")]
        public decimal InitialDeposit { get; set; }

        [Required(ErrorMessage = "Lãi suất tiền gửi không được để trống")]
        [Display(Name = "Lãi suất tiền gửi (%)")]
        [Range(0, 100, ErrorMessage = "Lãi suất phải nằm trong khoảng 0 đến 100")]
        public decimal InterestRate { get; set; }

        // Thông tin bổ sung cho tài khoản chuyên dụng (nếu cần)
        [Display(Name = "Phương thức nhận lãi")]
        public string InterestReceiveMethod { get; set; }  // ví dụ: "taquay" hoặc "mochuyendung"


        [Display(Name = "Chủ tài khoản nhận lãi")]
        public string AccountHolderDeposit { get; set; }     // Tên của chủ tài khoản chuyên dụng

        [Display(Name = "Số tài khoản nhận lãi")]
        public int AccountNumberDeposit { get; set; }       // (Tùy chọn: được tạo bởi JS)
    }
}
