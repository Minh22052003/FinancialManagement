using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class LoanAccount
{
    public int LoanId { get; set; }

    public string CustomerId { get; set; } = null!;

    public int? LinkedDepositAccountId { get; set; }

    public decimal LoanAmount { get; set; }

    public decimal? ApprovedAmount { get; set; }

    public decimal? InterestRate { get; set; }

    public string LoanStatus { get; set; } = null!;

    public string PaymentMethod { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateOnly? DueDate { get; set; }

    public int? SpecializedAccountId { get; set; }

    public virtual Customer Customer { get; set; } = null!;

    public virtual DepositAccount? LinkedDepositAccount { get; set; }

    public virtual ICollection<LoanDocument> LoanDocuments { get; set; } = new List<LoanDocument>();

    public virtual ICollection<PaymentHistory> PaymentHistories { get; set; } = new List<PaymentHistory>();

    public virtual SpecializedAccount? SpecializedAccount { get; set; }
}
