using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace DOAN.Models;

public partial class HeThongTaiChinhDbContext : DbContext
{
    public HeThongTaiChinhDbContext()
    {
    }

    public HeThongTaiChinhDbContext(DbContextOptions<HeThongTaiChinhDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<ApprovalHistory> ApprovalHistories { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<DepositAccount> DepositAccounts { get; set; }

    public virtual DbSet<FinancialTransaction> FinancialTransactions { get; set; }

    public virtual DbSet<LoanAccount> LoanAccounts { get; set; }

    public virtual DbSet<LoanProfile> LoanProfiles { get; set; }

    public virtual DbSet<PaymentHistory> PaymentHistories { get; set; }

    public virtual DbSet<SpecializedAccount> SpecializedAccounts { get; set; }

    public virtual DbSet<TransactionHistory> TransactionHistories { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-CNFI749\\SQLEXPRESS01;Initial Catalog=HeThongTaiChinhDB;Integrated Security=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ApprovalHistory>(entity =>
        {
            entity.HasKey(e => e.ApprovalId).HasName("PK__Approval__C94AE61A964FD990");

            entity.ToTable("ApprovalHistory");

            entity.Property(e => e.ApprovalId).HasColumnName("approval_id");
            entity.Property(e => e.ApprovalDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("approval_date");
            entity.Property(e => e.ApprovalStatus)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("approval_status");
            entity.Property(e => e.ApprovedBy).HasColumnName("approved_by");
            entity.Property(e => e.Notes)
                .HasMaxLength(255)
                .HasColumnName("notes");
            entity.Property(e => e.ReferenceId).HasColumnName("reference_id");
            entity.Property(e => e.ReferenceType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("reference_type");

            entity.HasOne(d => d.ApprovedByNavigation).WithMany(p => p.ApprovalHistories)
                .HasForeignKey(d => d.ApprovedBy)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ApprovalHistory_Users");
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.CustomerId).HasName("PK__Customer__CD65CB853133D025");

            entity.Property(e => e.CustomerId)
                .HasMaxLength(100)
                .HasColumnName("customer_id");
            entity.Property(e => e.Address)
                .HasMaxLength(255)
                .HasColumnName("address");
            entity.Property(e => e.DateOfBirth).HasColumnName("date_of_birth");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.FullName)
                .HasMaxLength(100)
                .HasColumnName("full_name");
            entity.Property(e => e.IdentityNumber)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("identity_number");
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("phone");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasDefaultValue("Active")
                .HasColumnName("status");
        });

        modelBuilder.Entity<DepositAccount>(entity =>
        {
            entity.HasKey(e => e.AccountId).HasName("PK__DepositA__46A222CD4BFB454C");

            entity.HasIndex(e => e.AccountNumber, "UQ__DepositA__AF91A6AD04AC356C").IsUnique();

            entity.Property(e => e.AccountId).HasColumnName("account_id");
            entity.Property(e => e.AccountNumber)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("account_number");
            entity.Property(e => e.AccountType)
                .HasMaxLength(50)
                .HasColumnName("account_type");
            entity.Property(e => e.Balance)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("balance");
            entity.Property(e => e.Branch)
                .HasMaxLength(250)
                .HasColumnName("branch");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CustomerId)
                .HasMaxLength(100)
                .HasColumnName("customer_id");
            entity.Property(e => e.InterestRate)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("interest_rate");
            entity.Property(e => e.MaturityDate).HasColumnName("maturity_date");
            entity.Property(e => e.SpecializedAccountId)
                .HasMaxLength(50)
                .HasColumnName("SpecializedAccountID");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasDefaultValue("active")
                .HasColumnName("status");
            entity.Property(e => e.Term).HasColumnName("term");

            entity.HasOne(d => d.Customer).WithMany(p => p.DepositAccounts)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DepositAccounts_Customers");

            entity.HasOne(d => d.SpecializedAccount).WithMany(p => p.DepositAccounts)
                .HasForeignKey(d => d.SpecializedAccountId)
                .HasConstraintName("FK_DepositAccounts_SpecializedAccounts");
        });

        modelBuilder.Entity<FinancialTransaction>(entity =>
        {
            entity.HasKey(e => e.TransactionId).HasName("PK__Financia__85C600AF4D6EBC6B");

            entity.Property(e => e.TransactionId).HasColumnName("transaction_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.DepositAccountId).HasColumnName("deposit_account_id");
            entity.Property(e => e.EmployeeId).HasColumnName("employee_id");
            entity.Property(e => e.TransactionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("transaction_date");
            entity.Property(e => e.TransactionMethod)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("transaction_method");
            entity.Property(e => e.TransactionStatus)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("transaction_status");
            entity.Property(e => e.TransactionType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("transaction_type");

            entity.HasOne(d => d.DepositAccount).WithMany(p => p.FinancialTransactions)
                .HasForeignKey(d => d.DepositAccountId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FinancialTransactions_DepositAccounts");

            entity.HasOne(d => d.Employee).WithMany(p => p.FinancialTransactions)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_FinancialTransactions_Users");
        });

        modelBuilder.Entity<LoanAccount>(entity =>
        {
            entity.HasKey(e => e.LoanId);

            entity.HasIndex(e => e.CustomerId, "IX_LoanAccounts");

            entity.Property(e => e.LoanId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("loan_id");
            entity.Property(e => e.ApprovedAmount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("approved_amount");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CustomerId)
                .HasMaxLength(100)
                .HasColumnName("customer_id");
            entity.Property(e => e.DisbursementStatus)
                .HasMaxLength(50)
                .HasColumnName("disbursement_status");
            entity.Property(e => e.DueDate).HasColumnName("due_date");
            entity.Property(e => e.InterestRate)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("interest_rate");
            entity.Property(e => e.LinkedDepositAccountId).HasColumnName("linked_deposit_account_id");
            entity.Property(e => e.LoanAmount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("loan_amount");
            entity.Property(e => e.LoanProfileId)
                .HasMaxLength(50)
                .HasColumnName("LoanProfileID");
            entity.Property(e => e.LoanStatus)
                .HasMaxLength(250)
                .HasColumnName("loan_status");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .HasColumnName("payment_method");
            entity.Property(e => e.SpecializedAccountId)
                .HasMaxLength(50)
                .HasColumnName("specialized_account_id");

            entity.HasOne(d => d.Customer).WithMany(p => p.LoanAccounts)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LoanAccounts_Customers");

            entity.HasOne(d => d.LinkedDepositAccount).WithMany(p => p.LoanAccounts)
                .HasForeignKey(d => d.LinkedDepositAccountId)
                .HasConstraintName("FK_LoanAccounts_DepositAccounts");

            entity.HasOne(d => d.SpecializedAccount).WithMany(p => p.LoanAccounts)
                .HasForeignKey(d => d.SpecializedAccountId)
                .HasConstraintName("FK_LoanAccounts_SpecializedAccounts");
        });

        modelBuilder.Entity<LoanProfile>(entity =>
        {
            entity.HasKey(e => e.ProfileId).HasName("PK__LoanProf__290C888483C04338");

            entity.ToTable("LoanProfile");

            entity.Property(e => e.ProfileId)
                .HasMaxLength(50)
                .HasColumnName("ProfileID");
            entity.Property(e => e.CitizenId)
                .HasMaxLength(50)
                .HasColumnName("CitizenID");
            entity.Property(e => e.CustomerName).HasMaxLength(100);
            entity.Property(e => e.IsApproved)
                .HasMaxLength(50)
                .HasDefaultValueSql("((0))");
        });

        modelBuilder.Entity<PaymentHistory>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__PaymentH__ED1FC9EA2AE15A4A");

            entity.ToTable("PaymentHistory");

            entity.Property(e => e.PaymentId).HasColumnName("payment_id");
            entity.Property(e => e.LoanId).HasColumnName("loan_id");
            entity.Property(e => e.PaymentAmount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("payment_amount");
            entity.Property(e => e.PaymentDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("payment_date");
            entity.Property(e => e.PaymentStatus)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("payment_status");
        });

        modelBuilder.Entity<SpecializedAccount>(entity =>
        {
            entity.HasKey(e => e.AccountId).HasName("PK__Speciali__349DA5A6772B2DCC");

            entity.Property(e => e.AccountId).HasMaxLength(50);
            entity.Property(e => e.AccountHolder).HasMaxLength(255);
            entity.Property(e => e.AccountType).HasMaxLength(50);
            entity.Property(e => e.Balance).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.Branch).HasMaxLength(100);
            entity.Property(e => e.CreateAt).HasColumnType("datetime");
        });

        modelBuilder.Entity<TransactionHistory>(entity =>
        {
            entity.HasKey(e => e.TransactionId).HasName("PK__Transact__55433A6B1A490E08");

            entity.ToTable("TransactionHistory");

            entity.Property(e => e.SpecialAccountId).HasMaxLength(50);
            entity.Property(e => e.TransactionAmount).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.TransactionStatus).HasMaxLength(50);
            entity.Property(e => e.Transactor).HasMaxLength(255);

            entity.HasOne(d => d.DepositAccount).WithMany(p => p.TransactionHistories)
                .HasForeignKey(d => d.DepositAccountId)
                .HasConstraintName("FK_TransactionHistory_DepositAccounts");

            entity.HasOne(d => d.SpecialAccount).WithMany(p => p.TransactionHistories)
                .HasForeignKey(d => d.SpecialAccountId)
                .HasConstraintName("FK_TransactionHistory_SpecialAccount");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__B9BE370FA46127B7");

            entity.HasIndex(e => e.Username, "UQ__Users__F3DBC572509CA5EA").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(256)
                .IsUnicode(false)
                .HasColumnName("password_hash");
            entity.Property(e => e.Role)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("role");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
