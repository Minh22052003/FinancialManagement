using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class PaymentHistory
{
    public int PaymentId { get; set; }

    public int LoanId { get; set; }

    public decimal PaymentAmount { get; set; }

    public DateTime? PaymentDate { get; set; }

    public string? PaymentStatus { get; set; }

    public virtual LoanAccount Loan { get; set; } = null!;
}
