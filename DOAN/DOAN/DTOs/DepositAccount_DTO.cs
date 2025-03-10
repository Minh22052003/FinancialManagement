﻿namespace DOAN.DTOs
{
    public class DepositAccount_DTO
    {
        public int AccountId { get; set; }
        public int CustomerId { get; set; }
        public string AccountNumber { get; set; }
        public string AccountType { get; set; }
        public decimal Balance { get; set; }
        public decimal? InterestRate { get; set; }
        public DateTime? CreatedAt { get; set; }
    }
}
