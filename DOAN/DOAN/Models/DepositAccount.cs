using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class DepositAccount
{
    public int AccountId { get; set; }

    public int CustomerId { get; set; }

    public string AccountNumber { get; set; } = null!;

    public string AccountType { get; set; } = null!;

    public decimal? Balance { get; set; }

    public decimal? InterestRate { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual ICollection<FinancialTransaction> FinancialTransactions { get; set; } = new List<FinancialTransaction>();

    public virtual ICollection<LoanAccount> LoanAccounts { get; set; } = new List<LoanAccount>();
}
