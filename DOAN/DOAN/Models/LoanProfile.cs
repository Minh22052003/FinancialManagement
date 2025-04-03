using System;
using System.Collections.Generic;

namespace DOAN.Models;

public partial class LoanProfile
{
    public string ProfileId { get; set; } = null!;

    public string? Notes { get; set; }

    public string CustomerName { get; set; } = null!;

    public string CitizenId { get; set; } = null!;

    public string? IsApproved { get; set; } = null!;
}
