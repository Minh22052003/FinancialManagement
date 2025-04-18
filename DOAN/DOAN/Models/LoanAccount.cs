﻿using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class LoanAccount
{
    public string LoanId { get; set; } = null!;

    public string CustomerId { get; set; } = null!;

    public int? LinkedDepositAccountId { get; set; }

    public decimal LoanAmount { get; set; }

    public decimal? ApprovedAmount { get; set; }

    public decimal? InterestRate { get; set; }

    public string LoanStatus { get; set; } = null!;

    public string PaymentMethod { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateOnly? DueDate { get; set; }

    public string? SpecializedAccountId { get; set; }

    public string? LoanProfileId { get; set; }

    public string? DisbursementStatus { get; set; }

    public bool IsFullyPaid { get; set; }

    public DateTime? FullyPaidAt { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual DepositAccount? LinkedDepositAccount { get; set; }

    public virtual SpecializedAccount? SpecializedAccount { get; set; }
}
