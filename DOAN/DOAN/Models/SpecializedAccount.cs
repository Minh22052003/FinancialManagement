using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class SpecializedAccount
{
    public string AccountId { get; set; } = null!;

    public string AccountHolder { get; set; } = null!;

    public decimal Balance { get; set; }

    public string AccountType { get; set; } = null!;

    public string Branch { get; set; } = null!;

    public DateTime CreateAt { get; set; }

    public virtual ICollection<DepositAccount> DepositAccounts { get; set; } = new List<DepositAccount>();

    public virtual ICollection<LoanAccount> LoanAccounts { get; set; } = new List<LoanAccount>();

    public virtual ICollection<TransactionHistory> TransactionHistories { get; set; } = new List<TransactionHistory>();
}
