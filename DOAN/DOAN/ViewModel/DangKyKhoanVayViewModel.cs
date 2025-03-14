using System.ComponentModel.DataAnnotations;

namespace DOAN.ViewModel
{
    public class DangKyKhoanVayViewModel
    {
        [Required]
        [Display(Name = "Mã khoản vay")]
        public string MaKhoanVay { get; set; }

        [Required]
        [Display(Name = "Số tiền vay")]
        [Range(1, double.MaxValue, ErrorMessage = "Số tiền vay phải lớn hơn 0")]
        public decimal SoTienVay { get; set; }

        [Required]
        [Display(Name = "Lãi suất vay ban đầu (%)")]
        [Range(0, 100, ErrorMessage = "Lãi suất phải từ 0 đến 100%")]
        public double LaiSuatBanDau { get; set; }

        [Display(Name = "Ưu đãi lãi suất")]
        public string UuDaiLaiSuat { get; set; }

        [Display(Name = "Lãi suất cuối cùng (%)")]
        public double LaiSuatCuoiCung { get; set; }

        [Required]
        [Display(Name = "Thời gian vay (tháng)")]
        [Range(1, 360, ErrorMessage = "Thời gian vay phải từ 1 đến 360 tháng")]
        public int ThoiGianVay { get; set; }

        [Required]
        [Display(Name = "Ngày giải ngân")]
        [DataType(DataType.Date)]
        public DateTime NgayGiaiNgan { get; set; }

        [Required]
        [Display(Name = "Phương thức trả nợ")]
        public string PhuongThucTraNo { get; set; }

        [Display(Name = "Hạn mức vay gợi ý")]
        public string HanMucVayGoiY { get; set; }

        [Required]
        [Display(Name = "Chọn phương thức thanh toán")]
        public string PhuongThucThanhToan { get; set; }
    }
}
