﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace DOAN.Models;

public partial class DatabaseConnection : DbContext
{
    public DatabaseConnection()
    {
    }

    public DatabaseConnection(DbContextOptions<DatabaseConnection> options)
        : base(options)
    {
    }

    public virtual DbSet<ApprovalHistory> ApprovalHistories { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<DepositAccount> DepositAccounts { get; set; }

    public virtual DbSet<FinancialTransaction> FinancialTransactions { get; set; }

    public virtual DbSet<LoanAccount> LoanAccounts { get; set; }

    public virtual DbSet<LoanDocument> LoanDocuments { get; set; }

    public virtual DbSet<PaymentHistory> PaymentHistories { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-CNFI749\\SQLEXPRESS01;Initial Catalog=HeThongTaiChinhDB;Integrated Security=True;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ApprovalHistory>(entity =>
        {
            entity.HasKey(e => e.ApprovalId).HasName("PK__Approval__C94AE61A1573F1C5");

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
            entity.HasKey(e => e.CustomerId).HasName("PK__Customer__CD65CB85D3FF96E0");

            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
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
        });

        modelBuilder.Entity<DepositAccount>(entity =>
        {
            entity.HasKey(e => e.AccountId).HasName("PK__DepositA__46A222CDBE9B4DD3");

            entity.HasIndex(e => e.AccountNumber, "UQ__DepositA__AF91A6ADEC7BE6FB").IsUnique();

            entity.Property(e => e.AccountId).HasColumnName("account_id");
            entity.Property(e => e.AccountNumber)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("account_number");
            entity.Property(e => e.AccountType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("account_type");
            entity.Property(e => e.Balance)
                .HasDefaultValue(0m)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("balance");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.InterestRate)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("interest_rate");

            entity.HasOne(d => d.Customer).WithMany(p => p.DepositAccounts)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DepositAccounts_Customers");
        });

        modelBuilder.Entity<FinancialTransaction>(entity =>
        {
            entity.HasKey(e => e.TransactionId).HasName("PK__Financia__85C600AFA12421A9");

            entity.Property(e => e.TransactionId).HasColumnName("transaction_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.DepositAccountId).HasColumnName("deposit_account_id");
            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .HasColumnName("description");
            entity.Property(e => e.LoanId).HasColumnName("loan_id");
            entity.Property(e => e.TransactionDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("transaction_date");
            entity.Property(e => e.TransactionType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("transaction_type");

            entity.HasOne(d => d.DepositAccount).WithMany(p => p.FinancialTransactions)
                .HasForeignKey(d => d.DepositAccountId)
                .HasConstraintName("FK_FinancialTransactions_DepositAccounts");

            entity.HasOne(d => d.Loan).WithMany(p => p.FinancialTransactions)
                .HasForeignKey(d => d.LoanId)
                .HasConstraintName("FK_FinancialTransactions_LoanAccounts");
        });

        modelBuilder.Entity<LoanAccount>(entity =>
        {
            entity.HasKey(e => e.LoanId).HasName("PK__LoanAcco__A1F795541E2C528B");

            entity.Property(e => e.LoanId).HasColumnName("loan_id");
            entity.Property(e => e.ApprovedAmount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("approved_amount");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.DueDate).HasColumnName("due_date");
            entity.Property(e => e.InterestRate)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("interest_rate");
            entity.Property(e => e.LinkedDepositAccountId).HasColumnName("linked_deposit_account_id");
            entity.Property(e => e.LoanAmount)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("loan_amount");
            entity.Property(e => e.LoanStatus)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("loan_status");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("payment_method");

            entity.HasOne(d => d.Customer).WithMany(p => p.LoanAccounts)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LoanAccounts_Customers");

            entity.HasOne(d => d.LinkedDepositAccount).WithMany(p => p.LoanAccounts)
                .HasForeignKey(d => d.LinkedDepositAccountId)
                .HasConstraintName("FK_LoanAccounts_DepositAccounts");
        });

        modelBuilder.Entity<LoanDocument>(entity =>
        {
            entity.HasKey(e => e.DocumentId).HasName("PK__LoanDocu__9666E8AC84157B3D");

            entity.Property(e => e.DocumentId).HasColumnName("document_id");
            entity.Property(e => e.DocumentDetails)
                .HasMaxLength(255)
                .HasColumnName("document_details");
            entity.Property(e => e.LoanId).HasColumnName("loan_id");
            entity.Property(e => e.SubmittedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("submitted_date");

            entity.HasOne(d => d.Loan).WithMany(p => p.LoanDocuments)
                .HasForeignKey(d => d.LoanId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LoanDocuments_LoanAccounts");
        });

        modelBuilder.Entity<PaymentHistory>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__PaymentH__ED1FC9EA5F4BADD0");

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

            entity.HasOne(d => d.Loan).WithMany(p => p.PaymentHistories)
                .HasForeignKey(d => d.LoanId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PaymentHistory_LoanAccounts");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__B9BE370FAF43911A");

            entity.HasIndex(e => e.Username, "UQ__Users__F3DBC57217809719").IsUnique();

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
