using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class DepositAccount
{
    public int AccountId { get; set; }

    public string CustomerId { get; set; } = null!;

    public string AccountNumber { get; set; } = null!;

    public string AccountType { get; set; } = null!;

    public decimal Balance { get; set; }

    public int? Term { get; set; }

    public decimal? InterestRate { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateOnly? MaturityDate { get; set; }

    public string Status { get; set; } = null!;

    public string? Branch { get; set; }

    public int? SpecializedAccountId { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual ICollection<FinancialTransaction> FinancialTransactions { get; set; } = new List<FinancialTransaction>();

    public virtual ICollection<LoanAccount> LoanAccounts { get; set; } = new List<LoanAccount>();

    public virtual SpecializedAccount? SpecializedAccount { get; set; }

    public virtual ICollection<TransactionHistory> TransactionHistories { get; set; } = new List<TransactionHistory>();
}
