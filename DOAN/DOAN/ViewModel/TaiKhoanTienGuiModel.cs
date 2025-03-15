namespace DOAN.ViewModel
{
    public class TaiKhoanTienGuiModel
    {
        // Thông tin khách hàng
        public string CustomerName { get; set; }
        public string PhoneNumber { get; set; }
        public string IdentityNumber { get; set; }

        // Thông tin tài khoản tiền gửi
        public string AccountType { get; set; }
        public int? Term { get; set; } // Thời gian gửi (tháng)
        public DateTime OpenDate { get; set; }
        public decimal InitialDeposit { get; set; }
        public decimal? InterestRate { get; set; }

        // Chi nhánh (giá trị cố định)
        public string Branch { get; set; } = "Bình Gia Branch";
    }
}
