using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class Customer
{
    public string CustomerId { get; set; } = null!;

    public string FullName { get; set; } = null!;

    public DateOnly? DateOfBirth { get; set; }

    public string? Address { get; set; }

    public string? Phone { get; set; }

    public string? Email { get; set; }

    public string? IdentityNumber { get; set; }

    public string Status { get; set; } = null!;

    public virtual ICollection<DepositAccount> DepositAccounts { get; set; } = new List<DepositAccount>();

    public virtual ICollection<LoanAccount> LoanAccounts { get; set; } = new List<LoanAccount>();
}
