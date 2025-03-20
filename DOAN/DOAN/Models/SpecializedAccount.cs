using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class SpecializedAccount
{
    public int AccountId { get; set; }

    public string AccountHolder { get; set; } = null!;

    public decimal Balance { get; set; }

    public string AccountType { get; set; } = null!;

    public virtual ICollection<DepositAccount> DepositAccounts { get; set; } = new List<DepositAccount>();
}
