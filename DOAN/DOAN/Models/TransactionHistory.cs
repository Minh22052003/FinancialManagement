using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class TransactionHistory
{
    public int TransactionId { get; set; }

    public int? DepositAccountId { get; set; }

    public int? SpecialAccountId { get; set; }

    public decimal TransactionAmount { get; set; }

    public DateTime TransactionDate { get; set; }

    public string Transactor { get; set; } = null!;

    public string TransactionStatus { get; set; } = null!;

    public virtual DepositAccount? DepositAccount { get; set; }

    public virtual SpecializedAccount? SpecialAccount { get; set; }
}
