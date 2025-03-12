namespace DOAN.DTOs
{
    public class DepositAccount_DTO
    {
        public int AccountId { get; set; }

        public int CustomerId { get; set; }

        public string AccountNumber { get; set; } = null!;

        public string AccountType { get; set; } = null!;

        public decimal Balance { get; set; }

        public int? Term { get; set; }

        public decimal? InterestRate { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateOnly? MaturityDate { get; set; }

        public string Status { get; set; } = null!;

        public string? Branch { get; set; }
    }
}
