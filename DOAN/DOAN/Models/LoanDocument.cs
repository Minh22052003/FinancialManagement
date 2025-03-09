using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class LoanDocument
{
    public int DocumentId { get; set; }

    public int LoanId { get; set; }

    public string? DocumentDetails { get; set; }

    public DateTime? SubmittedDate { get; set; }

    public virtual LoanAccount Loan { get; set; } = null!;
}
