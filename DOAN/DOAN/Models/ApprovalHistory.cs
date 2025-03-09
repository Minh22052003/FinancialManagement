using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class ApprovalHistory
{
    public int ApprovalId { get; set; }

    public string ReferenceType { get; set; } = null!;

    public int ReferenceId { get; set; }

    public int ApprovedBy { get; set; }

    public DateTime? ApprovalDate { get; set; }

    public string ApprovalStatus { get; set; } = null!;

    public string? Notes { get; set; }

    public virtual User ApprovedByNavigation { get; set; } = null!;
}
