using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class FinancialTransaction
{
    public int TransactionId { get; set; }

    public int DepositAccountId { get; set; }

    public string TransactionType { get; set; } = null!;

    public decimal Amount { get; set; }

    public DateTime TransactionDate { get; set; }

    public int EmployeeId { get; set; }

    public string TransactionMethod { get; set; } = null!;

    public string TransactionStatus { get; set; } = null!;

    public virtual DepositAccount DepositAccount { get; set; } = null!;

    public virtual User Employee { get; set; } = null!;
}
