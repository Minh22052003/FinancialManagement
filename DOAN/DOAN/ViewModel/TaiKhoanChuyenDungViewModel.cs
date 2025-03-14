using System.ComponentModel.DataAnnotations;

namespace DOAN.ViewModel
{
    public class TaiKhoanChuyenDungViewModel
    {
        [Required(ErrorMessage = "Vui lòng chọn loại tài khoản")]
        public string PaymentOption { get; set; } = null!;

        public string? LoanAccountNumber { get; set; }

        public decimal? InitialDeposit { get; set; }

        public decimal? LoanAmount { get; set; }

        public int? LoanTerm { get; set; }

        public decimal? MonthlyPayment { get; set; }

        public string? LoanAccountHolder { get; set; }

        public string? LoanAccountPurpose { get; set; } = "Thanh toán lãi vay";

        public string? DepositAccountNumber { get; set; }

        public decimal? DepositAmount { get; set; }

        public decimal? InterestRate { get; set; }

        public string? DepositAccountHolder { get; set; }

        public string? DepositAccountPurpose { get; set; } = "Nhận lãi từ tiền gửi";
    }
}
