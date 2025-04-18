
CREATE DATABASE [HeThongTaiChinhDB]
go
USE [HeThongTaiChinhDB]
GO

------ chay


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
	[account_type] [nvarchar](50) NOT NULL,
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

----------chạy tách

INSERT [dbo].[Users] ([username], [password_hash], [role], [created_at]) VALUES ('admin', '1111', 'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))

----------chạy tách

USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[Customers]
           ([customer_id]
           ,[full_name]
           ,[date_of_birth]
           ,[address]
           ,[phone]
           ,[email]
           ,[identity_number]
           ,[status])
     VALUES
(250301, N'Nguyễn Văn A', '1990-05-12', N'123 Lê Lợi, Hà Nội', '0912345678', 'nguyenvana@example.com', '012345678901', N'Active'),
(250302, N'Trần Thị B', '1985-10-25', N'45 Hoàng Diệu, Đà Nẵng', '0923456789', 'tranthib@example.com', '023456789012', N'Inactive'),
(250303, N'Phạm Văn C', '1992-07-18', N'67 Nguyễn Trãi, TP.HCM', '0934567890', 'phamvanc@example.com', '034567890123', N'Active'),
(250304, N'Lê Thị D', '1988-03-09', N'89 Lý Tự Trọng, Cần Thơ', '0945678901', 'lethid@example.com', '045678901234', N'Active'),
(250305, N'Đỗ Mạnh E', '1995-12-30', N'101 Hai Bà Trưng, Hải Phòng', '0956789012', 'domanhee@example.com', '056789012345', N'Inactive'),
(250306, N'Bùi Thị F', '1993-09-15', N'111 Trần Phú, Huế', '0967890123', 'buithif@example.com', '067890123456', N'Active'),
(250307, N'Ngô Văn G', '1991-06-21', N'78 Quang Trung, Hà Nội', '0978901234', 'ngovang@example.com', '078901234567', N'Active'),
(250308, N'Hoàng Thị H', '1987-04-05', N'99 Võ Văn Kiệt, TP.HCM', '0989012345', 'hoangthih@example.com', '089012345678', N'Inactive'),
(250309, N'Vũ Minh I', '1994-11-28', N'22 Nguyễn Huệ, Đà Nẵng', '0990123456', 'vuminhi@example.com', '090123456789', N'Active'),
(250310, N'Phan Văn J', '1996-08-14', N'333 Trường Chinh, Cần Thơ', '0901234567', 'phanvanj@example.com', '101234567890', N'Active'),
(250311, N'Nguyễn Thị K', '1989-02-27', N'14 Phạm Văn Đồng, Hà Nội', '0912345679', 'nguyenthik@example.com', '112345678901', N'Inactive'),
(250312, N'Trương Quốc L', '1997-05-23', N'88 Pasteur, TP.HCM', '0923456780', 'truongquocl@example.com', '123456789012', N'Active'),
(250313, N'Đặng Văn M', '1986-07-09', N'109 Nguyễn Văn Linh, Đà Nẵng', '0934567891', 'dangvanm@example.com', '134567890123', N'Active'),
(250314, N'Lâm Thị N', '1998-10-30', N'256 Lê Văn Sỹ, TP.HCM', '0945678902', 'lamthin@example.com', '145678901234', N'Inactive'),
(250315, N'Huỳnh Văn O', '1993-12-12', N'198 Nguyễn Đình Chiểu, Hà Nội', '0956789013', 'huynhvano@example.com', '156789012345', N'Active'),
(250316, N'Tô Minh P', '1991-09-18', N'300 Điện Biên Phủ, Hải Phòng', '0967890124', 'tominhp@example.com', '167890123456', N'Active'),
(250317, N'Nguyễn Văn Q', '1995-06-05', N'409 Nguyễn Công Trứ, Huế', '0978901235', 'nguyenvanq@example.com', '178901234567', N'Inactive'),
(250318, N'Đỗ Thị R', '1987-01-20', N'120 Hùng Vương, Đà Nẵng', '0989012346', 'dothir@example.com', '189012345678', N'Active'),
(250319, N'Bùi Văn S', '1999-08-29', N'333 Cách Mạng Tháng 8, TP.HCM', '0990123457', 'buivans@example.com', '190123456789', N'Active'),
(250320, N'Trần Quốc T', '1994-04-17', N'15 Lý Thường Kiệt, Cần Thơ', '0901234568', 'tranquoct@example.com', '201234567890', N'Inactive'),
(250321, N'Vũ Thị U', '1985-11-11', N'100 Nguyễn Thị Minh Khai, Hà Nội', '0912345670', 'vuthiu@example.com', '212345678901', N'Active'),
(250322, N'Phan Minh V', '1992-07-08', N'205 Nguyễn Văn Cừ, Hải Phòng', '0923456781', 'phanminhv@example.com', '223456789012', N'Active'),
(250323, N'Lê Văn W', '1989-03-15', N'89 Lê Hồng Phong, TP.HCM', '0934567892', 'levanw@example.com', '234567890123', N'Inactive'),
(250324, N'Trịnh Thị X', '1990-12-25', N'45 Tôn Đức Thắng, Đà Nẵng', '0945678903', 'trinhthix@example.com', '245678901234', N'Active'),
(250325, N'Hoàng Văn Y', '1997-06-30', N'222 Phan Đình Phùng, Cần Thơ', '0956789014', 'hoangvany@example.com', '256789012345', N'Active')
GO


----------chạy tách
USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[SpecializedAccounts]
           ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt])
VALUES
    (202503009, N'Nguyễn Văn A', 125000.50, N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', '2025-03-01 08:15:30'),
    (202503010, N'Trần Thị B', 950000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', '2025-03-02 12:45:10'),
    (202503011, N'Lê Minh C', 72000.75, N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', '2025-03-03 15:30:45'),
    (202503012, N'Phạm Thị D', 502500.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', '2025-03-04 18:20:30'),
    (202503013, N'Hoàng Văn E', 315600.25, N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', '2025-03-05 09:10:20'),
    (202503014, N'Đinh Thị F', 86000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', '2025-03-06 14:55:40'),
    (202503015, N'Bùi Thanh G', 215000.80, N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', '2025-03-07 11:30:10'),
    (202503016, N'Võ Thị H', 125600.90, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', '2025-03-08 16:45:25'),
    (202503017, N'Ngô Văn I', 99000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', '2025-03-09 20:10:50'),
    (202503018, N'Huỳnh Thị K', 780500.60, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', '2025-03-10 07:25:15'),
    (202503019, N'Tôn Nữ L', 360000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', '2025-03-11 13:40:30'),
    (202503020, N'Lâm Văn M', 995000.90, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', '2025-03-12 17:55:45'),
    (202503021, N'Mai Thị N', 51000.25, N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', '2025-03-13 22:15:10'),
    (202503022, N'Châu Văn O', 204000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', '2025-03-14 10:30:20'),
    (202503023, N'Dương Thị P', 610500.80, N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', '2025-03-15 15:45:30'),
    (202503024, N'Trịnh Văn Q', 380000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', '2025-03-16 18:55:40'),
    (202503025, N'Hà Thị R', 999999.99, N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', '2025-03-17 07:10:50'),
    (202503026, N'Kiều Văn S', 87000.50, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', '2025-03-18 12:30:10'),
    (202503027, N'Giang Thị T', 450000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', '2025-03-19 16:45:25'),
    (202503028, N'Cao Văn U', 750500.70, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', '2025-03-20 22:10:50'),
    (202503029, N'Vương Thị V', 123000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', '2025-03-21 08:20:30'),
    (202503030, N'Liêu Văn X', 540000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', '2025-03-22 13:40:30'),
    (202503031, N'Đoàn Thị Y', 315000.25, N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', '2025-03-23 17:55:45'),
    (202503032, N'Tống Văn Z', 750000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', '2025-03-24 20:10:50'),
    (202503033, N'Lý Minh Đ', 620500.30, N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', '2025-03-25 10:30:20'),
    (202503034, N'Chử Văn Â', 395000.00, N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', '2025-03-26 15:45:30'),
    (202503035, N'Quách Thị Bê', 985000.90, N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', '2025-03-27 18:55:40'),
    (202503036, N'Tạ Văn Cê', 51000.25, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', '2025-03-28 22:15:10'),
    (202503037, N'Đinh Thị Đê', 270000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', '2025-03-29 10:30:20'),
    (202503038, N'Nguyễn Văn Ê', 910500.80, N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', '2025-03-30 15:45:30'),
    (202503039, N'Trương Văn Gê', 340000.00, N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', '2025-03-31 18:55:40');

GO

----------chạy tách

USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[DepositAccounts]
           ([customer_id]
           ,[account_number]
           ,[account_type]
           ,[balance]
           ,[term]
           ,[interest_rate]
           ,[created_at]
           ,[maturity_date]
           ,[status]
           ,[branch]
           ,[SpecializedAccountID])
     VALUES
           (250306, '250305', N'Tiết kiệm không kỳ hạn', 1300000000.00, NULL, 5.50, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250307, '250303', N'Tiết kiệm có kỳ hạn', 800000000.00, 12, 7.20, '2025-03-30', '2026-03-30', N'Active', N'Bình Gia Branch', 202503026),
           (250308, '250304', N'Tiết kiệm có kỳ hạn', 950000000.00, 6, 6.50, '2025-03-30', '2025-09-30', N'Active', N'Bình Gia Branch', 202503038),
           (250309, '250302', N'Tiết kiệm không kỳ hạn', 670000000.00, NULL, 4.75, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250301, '250309', N'Tiết kiệm có kỳ hạn', 1200000000.00, 24, 8.00, '2025-03-30', '2027-03-30', N'Active', N'Bình Gia Branch', 202503026),
           (250311, '250301', N'Tiết kiệm không kỳ hạn', 550000000.00, NULL, 5.00, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250312, '250311', N'Tiết kiệm có kỳ hạn', 890000000.00, 12, 7.30, '2025-03-30', '2026-03-30', N'Active', N'Bình Gia Branch', 202503016),
           (250313, '250307', N'Tiết kiệm không kỳ hạn', 740000000.00, NULL, 4.90, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250314, '250310', N'Tiết kiệm có kỳ hạn', 1020000000.00, 36, 8.50, '2025-03-30', '2028-03-30', N'Active', N'Bình Gia Branch', 202503012),
           (250315, '250306', N'Tiết kiệm không kỳ hạn', 920000000.00, NULL, 5.20, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250316, '250308', N'Tiết kiệm có kỳ hạn', 870000000.00, 18, 7.75, '2025-03-30', '2026-09-30', N'Active', N'Bình Gia Branch', 202503028),
           (250317, '250331', N'Tiết kiệm không kỳ hạn', 640000000.00, NULL, 4.60, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250318, '250336', N'Tiết kiệm có kỳ hạn', 1150000000.00, 12, 7.40, '2025-03-30', '2026-03-30', N'Active', N'Bình Gia Branch', 202503036),
           (250319, '250333', N'Tiết kiệm không kỳ hạn', 790000000.00, NULL, 5.00, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250320, '250332', N'Tiết kiệm có kỳ hạn', 1340000000.00, 24, 8.20, '2025-03-30', '2027-03-30', N'Active', N'Bình Gia Branch', 202503010),
           (250321, '250339', N'Tiết kiệm không kỳ hạn', 710000000.00, NULL, 4.80, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250322, '250337', N'Tiết kiệm có kỳ hạn', 890000000.00, 6, 6.60, '2025-03-30', '2025-09-30', N'Active', N'Bình Gia Branch', 202503020),
           (250323, '250334', N'Tiết kiệm không kỳ hạn', 620000000.00, NULL, 4.55, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250324, '250321', N'Tiết kiệm có kỳ hạn', 970000000.00, 36, 8.30, '2025-03-30', '2028-03-30', N'Active', N'Bình Gia Branch', 202503026),
           (250325, '250324', N'Tiết kiệm không kỳ hạn', 880000000.00, NULL, 5.15, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL),
           (250325, '250327', N'Tiết kiệm có kỳ hạn', 1100000000.00, 12, 7.50, '2025-03-30', '2026-03-30', N'Active', N'Bình Gia Branch', 202503036),
           (250325, '250322', N'Tiết kiệm không kỳ hạn', 780000000.00, NULL, 5.10, '2025-03-30', NULL, N'Active', N'Bình Gia Branch', NULL)
GO

----------chạy tách
USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[LoanProfile]
           ([ProfileID]
           ,[Notes]
           ,[CustomerName]
           ,[CitizenID]
           ,[IsApproved])
VALUES
           (211234237, N'Đầy đủ giấy tờ vay', N'Nguyễn Văn A', '012345678901', N'Đã phê duyệt'),
           (211234238, N'Đủ giấy đề nghị vay', N'Trần Thị B', '023456789012', N'Đã từ chối'),
           (211234239, N'Hợp đồng lao động', N'Lê Văn C', '034567890123', N'Đã phê duyệt'),
           (211234240, N'Bảng lương 3 tháng gần nhất', N'Phạm Thị D', '045678901234', N'Đã từ chối'),
           (211234241, N'Xác nhận thu nhập', N'Hoàng Văn E', '056789012345', N'Đã phê duyệt'),
           (211234242, N'Chứng minh nhân dân hoặc CCCD', N'Đặng Thị F', '067890123456', N'Đã phê duyệt'),
           (211234243, N'Sổ hộ khẩu photo', N'Bùi Văn G', '078901234567', N'Đã từ chối'),
           (211234244, N'Hợp đồng vay tín dụng', N'Võ Thị H', '089012345678', N'Đã phê duyệt'),
           (211234245, N'Xác nhận công tác', N'Ngô Văn I', '090123456789', N'Đã từ chối'),
           (211234246, N'Bảng kê tài khoản ngân hàng', N'Phan Thị J', '101234567890', N'Đã phê duyệt'),
           (211234247, N'Giấy phép kinh doanh', N'Trịnh Văn K', '112345678901', N'Đã từ chối'),
           (211234248, N'Hợp đồng bảo hiểm nhân thọ', N'Lương Thị L', '123456789012', N'Đã phê duyệt'),
           (211234249, N'Giấy xác nhận cư trú', N'Hoàng Thị M', '134567890123', N'Đã từ chối'),
           (211234250, N'Bảng kê thu nhập', N'Nguyễn Văn N', '145678901234', N'Đã phê duyệt'),
           (211234251, N'Giấy tờ xe (nếu có thế chấp)', N'Trần Thị O', '156789012345', N'Đã từ chối'),
           (211234252, N'Hợp đồng thuê nhà', N'Lê Văn P', '167890123456', N'Đã phê duyệt'),
           (211234253, N'Xác nhận tình trạng hôn nhân', N'Phạm Thị Q', '178901234567', N'Đã từ chối'),
           (211234254, N'Xác nhận nợ xấu', N'Hoàng Văn R', '189012345678', N'Đã phê duyệt'),
           (211234255, N'Giấy ủy quyền (nếu có)', N'Đặng Thị S', '190123456789', N'Đã từ chối'),
           (211234256, N'Chứng nhận quyền sử dụng đất', N'Bùi Văn T', '201234567890', N'Đã phê duyệt'),
           (211234257, N'Hợp đồng tín dụng cá nhân', N'Vũ Thị U', '212345678901', N'Đã từ chối'),
           (211234258, N'Bản sao kê lương 6 tháng', N'Ngô Văn V', '223456789012', N'Đã phê duyệt'),
           (211234259, N'Giấy xác nhận công tác', N'Phạm Thị W', '234567890123', N'Đã từ chối'),
           (211234260, N'Hóa đơn điện nước 3 tháng gần nhất', N'Lê Văn X', '245678901234', N'Đã phê duyệt'),
           (211234261, N'Bản sao CMND/CCCD công chứng', N'Trần Thị Y', '256789012345', N'Đã từ chối')
GO

USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[LoanProfile]
           ([ProfileID]
           ,[Notes]
           ,[CustomerName]
           ,[CitizenID]
           ,[IsApproved])
VALUES
           (211234262, N'Đầy đủ giấy tờ vay', N'Nguyễn Văn A', '012345678901', N'Chưa phê duyệt'),
           (211234263, N'Đủ giấy đề nghị vay', N'Trần Thị B', '023456789012', N'Chưa phê duyệt'),
           (211234264, N'Hợp đồng lao động', N'Lê Văn C', '034567890123', N'Chưa phê duyệt'),
           (211234265, N'Bảng lương 3 tháng gần nhất', N'Phạm Thị D', '045678901234', N'Chưa phê duyệt'),
           (211234266, N'Xác nhận thu nhập', N'Hoàng Văn E', '056789012345', N'Chưa phê duyệt'),
           (211234267, N'Chứng minh nhân dân hoặc CCCD', N'Đặng Thị F', '067890123456', N'Chưa phê duyệt'),
           (211234268, N'Sổ hộ khẩu photo', N'Bùi Văn G', '078901234567', N'Chưa phê duyệt'),
           (211234269, N'Hợp đồng vay tín dụng', N'Võ Thị H', '089012345678', N'Chưa phê duyệt'),
           (211234270, N'Xác nhận công tác', N'Ngô Văn I', '090123456789', N'Chưa phê duyệt'),
           (211234271, N'Bảng kê tài khoản ngân hàng', N'Phan Thị J', '101234567890', N'Chưa phê duyệt'),
           (211234272, N'Giấy phép kinh doanh', N'Trịnh Văn K', '112345678901', N'Chưa phê duyệt'),
           (211234273, N'Hợp đồng bảo hiểm nhân thọ', N'Lương Thị L', '123456789012', N'Chưa phê duyệt'),
           (211234274, N'Giấy xác nhận cư trú', N'Hoàng Thị M', '134567890123', N'Chưa phê duyệt'),
           (211234275, N'Bảng kê thu nhập', N'Nguyễn Văn N', '145678901234', N'Chưa phê duyệt'),
           (211234276, N'Giấy tờ xe (nếu có thế chấp)', N'Trần Thị O', '156789012345', N'Chưa phê duyệt'),
           (211234277, N'Hợp đồng thuê nhà', N'Lê Văn P', '167890123456', N'Chưa phê duyệt'),
           (211234278, N'Xác nhận tình trạng hôn nhân', N'Phạm Thị Q', '178901234567', N'Chưa phê duyệt'),
           (211234279, N'Xác nhận nợ xấu', N'Hoàng Văn R', '189012345678', N'Chưa phê duyệt'),
           (211234280, N'Giấy ủy quyền (nếu có)', N'Đặng Thị S', '190123456789', N'Chưa phê duyệt'),
           (211234281, N'Chứng nhận quyền sử dụng đất', N'Bùi Văn T', '201234567890', N'Chưa phê duyệt')
GO


----------chạy tách
USE [HeThongTaiChinhDB]
GO

INSERT INTO [dbo].[LoanAccounts]
           ([loan_id]
           ,[customer_id]
           ,[linked_deposit_account_id]
           ,[loan_amount]
           ,[approved_amount]
           ,[interest_rate]
           ,[loan_status]
           ,[payment_method]
           ,[created_at]
           ,[due_date]
           ,[specialized_account_id]
           ,[LoanProfileID]
           ,[disbursement_status])
VALUES
('HSVV202503008', '250303', NULL, 23422.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-27 23:02:36.183', '2026-03-27', '202503009', '211234234', NULL),
('HSVV202503009', '250303', NULL, 3234234.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-27 23:38:22.647', '2025-09-27', NULL, '211234234', NULL),
					
('HSVV202503010', '250304', NULL, 50000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 00:10:00.000', DATEADD(YEAR, 1, '2025-03-28 00:10:00.000'), '202503010', '211234234', NULL),
('HSVV202503011', '250304', NULL, 750000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 00:15:00.000', DATEADD(MONTH, 6, '2025-03-28 00:15:00.000'), NULL, '211234234', NULL),
('HSVV202503012', '250305', NULL, 1250000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 01:00:00.000', DATEADD(YEAR, 1, '2025-03-28 01:00:00.000'), '202503012', '211234234', NULL),
('HSVV202503013', '250305', NULL, 980000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 01:05:00.000', DATEADD(MONTH, 6, '2025-03-28 01:05:00.000'), NULL, '211234234', NULL),
('HSVV202503014', '250306', NULL, 450000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 02:00:00.000', DATEADD(YEAR, 1, '2025-03-28 02:00:00.000'), '202503014', '211234234', NULL),
('HSVV202503015', '250306', NULL, 1120000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 02:10:00.000', DATEADD(MONTH, 6, '2025-03-28 02:10:00.000'), NULL, '211234234', NULL),
('HSVV202503016', '250307', NULL, 250000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 03:00:00.000', DATEADD(YEAR, 1, '2025-03-28 03:00:00.000'), '202503016', '211234234', NULL),
('HSVV202503017', '250307', NULL, 9800000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 03:15:00.000', DATEADD(MONTH, 6, '2025-03-28 03:15:00.000'), NULL, '211234234', NULL),
('HSVV202503018', '250308', NULL, 432200.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 04:00:00.000', DATEADD(YEAR, 1, '2025-03-28 04:00:00.000'), '202503018', '211234234', NULL),
('HSVV202503019', '250308', NULL, 7654321.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 04:20:00.000', DATEADD(MONTH, 6, '2025-03-28 04:20:00.000'), NULL, '211234234', NULL),
('HSVV202503020', '250309', NULL, 120000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 05:00:00.000', DATEADD(YEAR, 1, '2025-03-28 05:00:00.000'), '202503020', '211234234', NULL),
('HSVV202503021', '250309', NULL, 650000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 05:10:00.000', DATEADD(MONTH, 6, '2025-03-28 05:10:00.000'), NULL, '211234234', NULL),
('HSVV202503022', '250310', NULL, 45000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 06:00:00.000', DATEADD(YEAR, 1, '2025-03-28 06:00:00.000'), '202503022', '211234234', NULL),
('HSVV202503023', '250310', NULL, 2345678.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 06:15:00.000', DATEADD(MONTH, 6, '2025-03-28 06:15:00.000'), NULL, '211234234', NULL),
('HSVV202503024', '250311', NULL, 987654.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 07:00:00.000', DATEADD(YEAR, 1, '2025-03-28 07:00:00.000'), '202503024', '211234234', NULL),
('HSVV202503025', '250311', NULL, 765432.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 07:10:00.000', DATEADD(MONTH, 6, '2025-03-28 07:10:00.000'), NULL, '211234234', NULL),
('HSVV202503026', '250312', NULL, 543210.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 08:00:00.000', DATEADD(YEAR, 1, '2025-03-28 08:00:00.000'), '202503026', '211234234', NULL),
('HSVV202503027', '250312', NULL, 1234567.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 08:15:00.000', DATEADD(MONTH, 6, '2025-03-28 08:15:00.000'), NULL, '211234234', NULL),
('HSVV202503028', '250313', NULL, 654321.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 09:00:00.000', DATEADD(YEAR, 1, '2025-03-28 09:00:00.000'), '202503028', '211234234', NULL),
('HSVV202503029', '250313', NULL, 234567.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 09:10:00.000', DATEADD(MONTH, 6, '2025-03-28 09:10:00.000'), NULL, '211234234', NULL),
('HSVV202503030', '250314', NULL, 98765.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 10:00:00.000', DATEADD(YEAR, 1, '2025-03-28 10:00:00.000'), '202503030', '211234234', NULL),
('HSVV202503031', '250314', NULL, 876543.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-28 10:15:00.000', DATEADD(MONTH, 6, '2025-03-28 10:15:00.000'), NULL, '211234234', NULL),
('HSVV202503032', '250315', NULL, 5432100.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-28 11:00:00.000', DATEADD(YEAR, 1, '2025-03-28 11:00:00.000'), '202503032', '211234234', NULL)
GO

USE [HeThongTaiChinhDB]
GO

-- Chèn dữ liệu mẫu cho các khoản vay đến hạn (overdue) với due_date < ngày hiện tại
INSERT INTO [dbo].[LoanAccounts]
           ([loan_id]
           ,[customer_id]
           ,[linked_deposit_account_id]
           ,[loan_amount]
           ,[approved_amount]
           ,[interest_rate]
           ,[loan_status]
           ,[payment_method]
           ,[created_at]
           ,[due_date]
           ,[specialized_account_id]
           ,[LoanProfileID]
           ,[disbursement_status])
VALUES
('HSVV202503100', '250310', NULL, 1500000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-20 10:00:00.000', '2025-03-27', NULL, '211234234', NULL),
('HSVV202503101', '250311', NULL, 2000000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-18 14:30:00.000', '2025-03-25', NULL, '211234234', NULL),
('HSVV202503102', '250312', NULL, 750000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-15 08:45:00.000', '2025-03-15', '202503030', '211234234', NULL),
('HSVV202503103', '250313', NULL, 3200000.00, NULL, 9.00, N'Chờ giải ngân', 'Counter', '2025-03-17 11:20:00.000', '2025-03-24', NULL, '211234234', NULL),
('HSVV202503104', '250314', NULL, 1800000.00, NULL, 9.00, N'Đã giải ngân', 'Auto', '2025-03-16 16:10:00.000', '2025-03-16', '202503030', '211234234', NULL)
GO


