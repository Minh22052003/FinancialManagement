
CREATE DATABASE [HeThongTaiChinhDB]

USE [HeThongTaiChinhDB]
GO
/****** Object:  Table [dbo].[ApprovalHistory]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApprovalHistory](
	[approval_id] [int] IDENTITY(1,1) NOT NULL,
	[reference_type] [varchar](50) NOT NULL,
	[reference_id] [int] NOT NULL,
	[approved_by] [int] NOT NULL,
	[approval_date] [datetime] NOT NULL,
	[approval_status] [varchar](50) NOT NULL,
	[notes] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[approval_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [nvarchar](100) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[date_of_birth] [date] NULL,
	[address] [nvarchar](255) NULL,
	[phone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[identity_number] [varchar](50) NULL,
	[status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Customer__CD65CB853133D025] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepositAccounts]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepositAccounts](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [nvarchar](100) NOT NULL,
	[account_number] [varchar](20) NOT NULL,
	[account_type] [varchar](50) NOT NULL,
	[balance] [decimal](18, 2) NOT NULL,
	[term] [int] NULL,
	[interest_rate] [decimal](5, 2) NULL,
	[created_at] [datetime] NOT NULL,
	[maturity_date] [date] NULL,
	[status] [varchar](50) NOT NULL,
	[branch] [nvarchar](250) NULL,
	[SpecializedAccountID] [nvarchar](50) NULL,
 CONSTRAINT [PK__DepositA__46A222CD4BFB454C] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__DepositA__AF91A6AD04AC356C] UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialTransactions]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinancialTransactions](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[deposit_account_id] [int] NOT NULL,
	[transaction_type] [varchar](50) NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[transaction_date] [datetime] NOT NULL,
	[employee_id] [int] NOT NULL,
	[transaction_method] [varchar](50) NOT NULL,
	[transaction_status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanAccounts]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanAccounts](
	[loan_id] [varchar](50) NOT NULL,
	[customer_id] [nvarchar](100) NOT NULL,
	[linked_deposit_account_id] [int] NULL,
	[loan_amount] [decimal](18, 2) NOT NULL,
	[approved_amount] [decimal](18, 2) NULL,
	[interest_rate] [decimal](5, 2) NULL,
	[loan_status] [nvarchar](250) NOT NULL,
	[payment_method] [nvarchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[due_date] [date] NULL,
	[specialized_account_id] [nvarchar](50) NULL,
	[LoanProfileID] [nvarchar](50) NULL,
	[disbursement_status] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoanAccounts] PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanProfile]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanProfile](
	[ProfileID] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[CitizenID] [nvarchar](50) NOT NULL,
	[IsApproved] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__LoanProf__290C888483C04338] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentHistory]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentHistory](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[loan_id] [int] NOT NULL,
	[payment_amount] [decimal](18, 2) NOT NULL,
	[payment_date] [datetime] NOT NULL,
	[payment_status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpecializedAccounts]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecializedAccounts](
	[AccountId] [nvarchar](50) NOT NULL,
	[AccountHolder] [nvarchar](255) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[AccountType] [nvarchar](50) NOT NULL,
	[Branch] [nvarchar](100) NOT NULL,
	[CreateAt] [datetime] NOT NULL,
 CONSTRAINT [PK__Speciali__349DA5A6772B2DCC] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionHistory]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionHistory](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[DepositAccountId] [int] NULL,
	[SpecialAccountId] [nvarchar](50) NULL,
	[TransactionAmount] [decimal](18, 2) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[Transactor] [nvarchar](255) NOT NULL,
	[TransactionStatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Transact__55433A6B1A490E08] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/28/2025 12:05:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password_hash] [varchar](256) NOT NULL,
	[role] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LoanAccounts]    Script Date: 3/28/2025 12:05:40 PM ******/
CREATE NONCLUSTERED INDEX [IX_LoanAccounts] ON [dbo].[LoanAccounts]
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApprovalHistory] ADD  DEFAULT (getdate()) FOR [approval_date]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ('Active') FOR [status]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [DF__DepositAc__balan__2E1BDC42]  DEFAULT ((0)) FOR [balance]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [DF__DepositAc__creat__2F10007B]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [DF__DepositAc__statu__300424B4]  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[FinancialTransactions] ADD  DEFAULT (getdate()) FOR [transaction_date]
GO
ALTER TABLE [dbo].[LoanAccounts] ADD  CONSTRAINT [DF__LoanAccou__creat__35BCFE0A]  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[LoanProfile] ADD  CONSTRAINT [DF_LoanProfile_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[PaymentHistory] ADD  DEFAULT (getdate()) FOR [payment_date]
GO
ALTER TABLE [dbo].[TransactionHistory] ADD  CONSTRAINT [DF__Transacti__Trans__778AC167]  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ApprovalHistory]  WITH CHECK ADD  CONSTRAINT [FK_ApprovalHistory_Users] FOREIGN KEY([approved_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ApprovalHistory] CHECK CONSTRAINT [FK_ApprovalHistory_Users]
GO
ALTER TABLE [dbo].[DepositAccounts]  WITH CHECK ADD  CONSTRAINT [FK_DepositAccounts_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[DepositAccounts] CHECK CONSTRAINT [FK_DepositAccounts_Customers]
GO
ALTER TABLE [dbo].[DepositAccounts]  WITH CHECK ADD  CONSTRAINT [FK_DepositAccounts_SpecializedAccounts] FOREIGN KEY([SpecializedAccountID])
REFERENCES [dbo].[SpecializedAccounts] ([AccountId])
GO
ALTER TABLE [dbo].[DepositAccounts] CHECK CONSTRAINT [FK_DepositAccounts_SpecializedAccounts]
GO
ALTER TABLE [dbo].[FinancialTransactions]  WITH CHECK ADD  CONSTRAINT [FK_FinancialTransactions_DepositAccounts] FOREIGN KEY([deposit_account_id])
REFERENCES [dbo].[DepositAccounts] ([account_id])
GO
ALTER TABLE [dbo].[FinancialTransactions] CHECK CONSTRAINT [FK_FinancialTransactions_DepositAccounts]
GO
ALTER TABLE [dbo].[FinancialTransactions]  WITH CHECK ADD  CONSTRAINT [FK_FinancialTransactions_Users] FOREIGN KEY([employee_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[FinancialTransactions] CHECK CONSTRAINT [FK_FinancialTransactions_Users]
GO
ALTER TABLE [dbo].[LoanAccounts]  WITH CHECK ADD  CONSTRAINT [FK_LoanAccounts_Customers] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[LoanAccounts] CHECK CONSTRAINT [FK_LoanAccounts_Customers]
GO
ALTER TABLE [dbo].[LoanAccounts]  WITH CHECK ADD  CONSTRAINT [FK_LoanAccounts_DepositAccounts] FOREIGN KEY([linked_deposit_account_id])
REFERENCES [dbo].[DepositAccounts] ([account_id])
GO
ALTER TABLE [dbo].[LoanAccounts] CHECK CONSTRAINT [FK_LoanAccounts_DepositAccounts]
GO
ALTER TABLE [dbo].[LoanAccounts]  WITH CHECK ADD  CONSTRAINT [FK_LoanAccounts_SpecializedAccounts] FOREIGN KEY([specialized_account_id])
REFERENCES [dbo].[SpecializedAccounts] ([AccountId])
GO
ALTER TABLE [dbo].[LoanAccounts] CHECK CONSTRAINT [FK_LoanAccounts_SpecializedAccounts]
GO
ALTER TABLE [dbo].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_TransactionHistory_DepositAccounts] FOREIGN KEY([DepositAccountId])
REFERENCES [dbo].[DepositAccounts] ([account_id])
GO
ALTER TABLE [dbo].[TransactionHistory] CHECK CONSTRAINT [FK_TransactionHistory_DepositAccounts]
GO
ALTER TABLE [dbo].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_TransactionHistory_SpecialAccount] FOREIGN KEY([SpecialAccountId])
REFERENCES [dbo].[SpecializedAccounts] ([AccountId])
GO
ALTER TABLE [dbo].[TransactionHistory] CHECK CONSTRAINT [FK_TransactionHistory_SpecialAccount]
GO
USE [master]
GO
ALTER DATABASE [HeThongTaiChinhDB] SET  READ_WRITE 
GO

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'admin', N'1111', N'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))