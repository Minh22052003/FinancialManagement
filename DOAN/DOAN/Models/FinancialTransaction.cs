using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class FinancialTransaction
{
    public int TransactionId { get; set; }

    public string TransactionType { get; set; } = null!;

    public int? DepositAccountId { get; set; }

    public int? LoanId { get; set; }

    public decimal Amount { get; set; }

    public DateTime? TransactionDate { get; set; }

    public string? Description { get; set; }

    public virtual DepositAccount? DepositAccount { get; set; }

    public virtual LoanAccount? Loan { get; set; }
}
