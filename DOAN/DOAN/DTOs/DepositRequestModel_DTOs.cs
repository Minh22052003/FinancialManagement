namespace DOAN.DTOs
{
    public class DepositRequestModel_DTOs
    {
        public string AccountNumber { get; set; } = null!;
        public string SenderName { get; set; } = null!;
        public string? ReceiverName { get; set; }
        public decimal Amount { get; set; }
    }
}
