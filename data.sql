
CREATE DATABASE [HeThongTaiChinhDB]


USE [HeThongTaiChinhDB]
GO
/****** Object:  Table [dbo].[ApprovalHistory]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[DepositAccounts]    Script Date: 3/28/2025 12:04:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialTransactions]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[LoanAccounts]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[LoanProfile]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[PaymentHistory]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[SpecializedAccounts]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[TransactionHistory]    Script Date: 3/28/2025 12:04:44 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 3/28/2025 12:04:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'0', N'minh', NULL, NULL, N'0912345610', NULL, N'030203007958', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'210321', N'Nguyễn Văn V', CAST(N'1983-10-22' AS Date), N'103 Điện Biên Phủ, Hà Nội', N'0920202020', N'nguyenvanv@example.com', N'111122233344', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'210322', N'Trần Thị W', CAST(N'1990-04-19' AS Date), N'104 Hoàng Quốc Việt, TP.HCM', N'0930303030', N'tranthiw@example.com', N'122233344455', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'210323', N'Lê Văn X', CAST(N'1992-06-29' AS Date), N'105 Phạm Ngọc Thạch, Đà Nẵng', N'0940404040', N'levanx@example.com', N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'210324', N'Phạm Thị Y', CAST(N'1989-09-07' AS Date), N'106 Nguyễn Xiển, Hải Phòng', N'0950505050', N'phamthiy@example.com', N'144455566677', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'210325', N'Hoàng Văn Z', CAST(N'1993-02-11' AS Date), N'107 Xã Đàn, Cần Thơ', N'0960606060', N'hoangvanz@example.com', N'155566677788', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240313', N'Lê Văn N', CAST(N'1995-05-05' AS Date), N'345 Lý Tự Trọng, Đà Nẵng', N'0933333333', N'levann@example.com', N'033344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240314', N'Phạm Thị O', CAST(N'1989-09-12' AS Date), N'456 Bà Triệu, Hải Phòng', N'0944444444', N'phamthio@example.com', N'044455566677', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240315', N'Hoàng Văn P', CAST(N'1992-11-30' AS Date), N'567 Nguyễn Trãi, Cần Thơ', N'0955555555', N'hoangvanp@example.com', N'055566677788', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240316', N'Bùi Thị Q', CAST(N'1987-06-21' AS Date), N'678 Trần Phú, Huế', N'09666665555', N'buithiq@example.com', N'066677788899', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240317', N'Đỗ Văn R', CAST(N'1991-03-18' AS Date), N'789 Quang Trung, Đà Lạt', N'0977777777', N'dovanr@example.con', N'077788899900', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240318', N'Vũ Thị S', CAST(N'1985-12-09' AS Date), N'890 Nguyễn Huệ, Nha Trang', N'0988888888', N'vuthis@example.com', N'088899900011', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240319', N'Ngô Văn T', CAST(N'1996-01-25' AS Date), N'901 Hùng Vương, Vũng Tàu', N'0999999999', N'ngovant@example.com', N'099900011122', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240320', N'Đặng Thị U', CAST(N'1984-08-15' AS Date), N'102 Trần Quang Khải, Bình Dương', N'0910101010', N'dangthiu@example.com', N'100011122233', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240329', N'Nguyễn Văn L', CAST(N'1983-02-14' AS Date), N'123 Cách Mạng Tháng Tám, Hà Nội', N'0911111111', N'nguyenvanl@example.com', N'011122233344', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'240330', N'Trần Thị M', CAST(N'1990-07-23' AS Date), N'234 Nguyễn Văn Cừ, TP.HCM', N'0922222222', N'tranthim@example.com', N'022233344455', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250301', N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, Hà Nội', N'0912345678', N'nguyenvana@example.com', N'012345678901', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250302', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Trần Hưng Đạo, TP.HCM', N'0987654321', N'tranthib@example.com', N'123456789012', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250303', N'Lê Văn C', CAST(N'1992-11-30' AS Date), N'789 Hoàng Diệu, Đà Nẵng', N'0901122334', N'levanc@example.com', N'234567890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250304', N'Phạm Thị D', CAST(N'1995-03-25' AS Date), N'101 Phan Chu Trinh, Hải Phòng', N'0966778899', N'phamthid@example.com', N'345678901234', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250305', N'Hoàng Văn E', CAST(N'1988-07-15' AS Date), N'202 Nguyễn Du, Cần Thơ', N'0977554466', N'hoangvane@example.com', N'456789012345', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250306', N'Bùi Thị F', CAST(N'1993-09-10' AS Date), N'303 Hai Bà Trưng, Huế', N'0944332211', N'buithif@example.com', N'567890123456', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250307', N'Đỗ Văn G', CAST(N'1991-12-22' AS Date), N'404 Bạch Đằng, Đà Lạt', N'0933221100', N'dovang@example.com', N'678901234567', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250308', N'Vũ Thị H', CAST(N'1987-06-05' AS Date), N'505 Lý Thường Kiệt, Nha Trang', N'0922110099', N'vuthih@example.com', N'7890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250309', N'Ngô Văn I', CAST(N'1996-04-18' AS Date), N'606 Trường Chinh, Vũng Tàu', N'0911002233', N'ngovanii@example.com', N'890123456789', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250310', N'minh', NULL, NULL, N'0912345696', NULL, N'901234567890', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250311', N'minh', NULL, NULL, N'0912345610', NULL, N'030203007958', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250312', N'minh', NULL, N'21232sadsdsdasdas', N'0912345610', N'sdasdsada', N'030203007958', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250313', N'Phạm Minh1', CAST(N'2003-05-22' AS Date), N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'111111', N'alanpham2224@gmail.com', N'7890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250314', N'Nguyễn Văn V', NULL, NULL, N'0912345610', NULL, N'030203007958', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250315', N'Lê Văn X', NULL, NULL, N'0912345610', NULL, N'901234567890', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250316', N'Lê Văn X', NULL, NULL, N'0940404040', NULL, N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250317', N'Lê Văn X', NULL, NULL, N'0940404040', NULL, N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250318', N'Lê Văn X', NULL, NULL, N'0940404040', NULL, N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250319', N'Lê Văn X', NULL, NULL, N'0940404040', NULL, N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250320', N'Phạm Minh', NULL, N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250321', N'Phạm Minh', NULL, N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250322', N'Phạm Minh', NULL, N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250323', N'Lê Văn X', NULL, NULL, N'0940404040', NULL, N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250401', N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, Hà Nội', N'0912345678', N'nguyenvana@example.com', N'012345678901', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250402', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Trần Hưng Đạo, TP.HCM', N'0987654321', N'tranthib@example.com', N'123456789012', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250403', N'Lê Văn C', CAST(N'1992-11-30' AS Date), N'789 Hoàng Diệu, Đà Nẵng', N'0901122334', N'levanc@example.com', N'234567890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250404', N'Phạm Thị D', CAST(N'1995-03-25' AS Date), N'101 Phan Chu Trinh, Hải Phòng', N'0966778899', N'phamthid@example.com', N'345678901234', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250405', N'Hoàng Văn E', CAST(N'1988-07-15' AS Date), N'202 Nguyễn Du, Cần Thơ', N'0977554466', N'hoangvane@example.com', N'456789012345', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250406', N'Bùi Thị F', CAST(N'1993-09-10' AS Date), N'303 Hai Bà Trưng, Huế', N'0944332211', N'buithif@example.com', N'567890123456', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250407', N'Đỗ Văn G', CAST(N'1991-12-22' AS Date), N'404 Bạch Đằng, Đà Lạt', N'0933221100', N'dovang@example.com', N'678901234567', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250408', N'Vũ Thị H', CAST(N'1987-06-05' AS Date), N'505 Lý Thường Kiệt, Nha Trang', N'0922110099', N'vuthih@example.com', N'789012345678', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250409', N'Ngô Văn I', CAST(N'1996-04-18' AS Date), N'606 Trường Chinh, Vũng Tàu', N'0911002233', N'ngovanii@example.com', N'890123456789', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250410', N'Đặng Thị K', CAST(N'1984-10-07' AS Date), N'707 Nguyễn Thái Học, Bình Dương', N'0909090909', N'dangthik@example.com', N'901234567890', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250411', N'Phan Văn M', CAST(N'1990-02-14' AS Date), N'808 Điện Biên Phủ, Đà Nẵng', N'0912233445', N'phanvanm@example.com', N'112233445566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250412', N'Lý Thị N', CAST(N'1982-09-22' AS Date), N'909 Võ Văn Kiệt, TP.HCM', N'0988112233', N'lythin@example.com', N'223344556677', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250413', N'Tống Văn O', CAST(N'1994-06-30' AS Date), N'100 Nguyễn Huệ, Huế', N'0933445566', N'tongvano@example.com', N'334455667788', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250414', N'Cao Thị P', CAST(N'1986-12-10' AS Date), N'111 Hùng Vương, Hà Nội', N'0977223344', N'caothip@example.com', N'445566778899', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250415', N'Dương Văn Q', CAST(N'1997-05-08' AS Date), N'222 Cách Mạng Tháng 8, Đà Lạt', N'0909888777', N'duongvanq@example.com', N'556677889900', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250416', N'Huỳnh Thị R', CAST(N'1989-08-14' AS Date), N'333 Nguyễn Trãi, Hải Phòng', N'0922778899', N'huynhthir@example.com', N'667788990011', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250417', N'Kiều Văn S', CAST(N'1993-04-28' AS Date), N'444 Lê Văn Sỹ, Cần Thơ', N'0911667788', N'kieuvans@example.com', N'778899001122', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250418', N'Mai Thị T', CAST(N'1985-07-19' AS Date), N'555 Phạm Ngũ Lão, Bình Dương', N'0933556677', N'maithit@example.com', N'889900112233', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250419', N'Nguyễn Văn U', CAST(N'1991-03-05' AS Date), N'666 Tô Hiến Thành, Nha Trang', N'0955667788', N'nguyenvanu@example.com', N'990011223344', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250420', N'Phạm Thị V', CAST(N'1998-11-02' AS Date), N'777 Đinh Tiên Hoàng, Vũng Tàu', N'0966778899', N'phamthiv@example.com', N'001122334455', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250421', N'Trịnh Văn W', CAST(N'1990-06-25' AS Date), N'888 Lạc Long Quân, Hà Nội', N'0944556677', N'trinhvanw@example.com', N'112233445566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250422', N'Lê Thị X', CAST(N'1992-09-13' AS Date), N'999 Hoàng Quốc Việt, TP.HCM', N'0911778899', N'lethix@example.com', N'223344556677', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250423', N'Vũ Văn Y', CAST(N'1987-10-01' AS Date), N'1000 Nguyễn Văn Cừ, Hải Phòng', N'0900998877', N'vuvany@example.com', N'334455667788', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250424', N'Đặng Thị Z', CAST(N'1984-07-22' AS Date), N'1100 Trần Phú, Cần Thơ', N'0988776655', N'dangthiz@example.com', N'445566778899', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250425', N'Bùi Văn AA', CAST(N'1993-05-09' AS Date), N'1200 Lý Chính Thắng, Đà Lạt', N'0977665544', N'buivanaa@example.com', N'556677889900', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'V001', N'Nguyễn Văn A', CAST(N'1990-05-15' AS Date), N'123 Đường A, Hà Nội', N'0987654321', N'vana@example.com', N'123456789', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'V002', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Đường B, TP.HCM', N'0912345678', N'thib@example.com', N'234567890', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'V003', N'Phạm Hữu C', CAST(N'1992-03-10' AS Date), N'789 Đường C, Đà Nẵng', N'0934567890', N'huuc@example.com', N'345678901', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'V004', N'Lê Hoàng D', CAST(N'1995-12-25' AS Date), N'159 Đường D, Hải Phòng', N'0978901234', N'hoangd@example.com', N'456789012', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'V005', N'Đặng Minh E', CAST(N'1988-07-30' AS Date), N'753 Đường E, Cần Thơ', N'0956789012', N'minhe@example.com', N'567890123', N'Active')
GO
SET IDENTITY_INSERT [dbo].[DepositAccounts] ON 

INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (1, N'250312', N'970412250001', N'tietkiem', CAST(1111111.00 AS Decimal(18, 2)), NULL, CAST(11.00 AS Decimal(5, 2)), CAST(N'2025-11-11T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (2, N'210321', N'100001', N'Ti?t ki?m k? h?n', CAST(4876667.00 AS Decimal(18, 2)), 12, CAST(5.50 AS Decimal(5, 2)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-01-01' AS Date), N'Active', N'Hà Nội', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (3, N'210322', N'100002', N'Ti?t ki?m không k? h?n', CAST(9876667.00 AS Decimal(18, 2)), 0, CAST(1.20 AS Decimal(5, 2)), CAST(N'2023-02-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Hồ Chí Minh', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (4, N'210323', N'100003', N'Ti?t ki?m k? h?n', CAST(15000000.00 AS Decimal(18, 2)), 6, CAST(4.00 AS Decimal(5, 2)), CAST(N'2023-03-01T00:00:00.000' AS DateTime), CAST(N'2023-09-01' AS Date), N'Active', N'Đà Nẵng', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (5, N'210324', N'100004', N'Ti?t ki?m có k? h?n', CAST(20000000.00 AS Decimal(18, 2)), 24, CAST(6.00 AS Decimal(5, 2)), CAST(N'2022-12-01T00:00:00.000' AS DateTime), CAST(N'2024-12-01' AS Date), N'Active', N'Hải Phòng', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (6, N'210325', N'100005', N'Ti?t ki?m không k? h?n', CAST(7500000.00 AS Decimal(18, 2)), 0, CAST(1.00 AS Decimal(5, 2)), CAST(N'2023-04-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Dương', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (7, N'240313', N'100006', N'Ti?t ki?m k? h?n', CAST(8000000.00 AS Decimal(18, 2)), 9, CAST(4.80 AS Decimal(5, 2)), CAST(N'2023-05-01T00:00:00.000' AS DateTime), CAST(N'2024-02-01' AS Date), N'Active', N'Đồng Nai', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (8, N'240314', N'100007', N'Ti?t ki?m có k? h?n', CAST(25000000.00 AS Decimal(18, 2)), 36, CAST(6.50 AS Decimal(5, 2)), CAST(N'2023-06-01T00:00:00.000' AS DateTime), CAST(N'2026-06-01' AS Date), N'Active', N'Cần Thơ', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (9, N'240315', N'100008', N'Ti?t ki?m không k? h?n', CAST(3000000.00 AS Decimal(18, 2)), 0, CAST(1.30 AS Decimal(5, 2)), CAST(N'2023-07-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Quảng Ninh', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (10, N'240316', N'100009', N'Ti?t ki?m k? h?n', CAST(12500000.00 AS Decimal(18, 2)), 12, CAST(5.20 AS Decimal(5, 2)), CAST(N'2023-08-01T00:00:00.000' AS DateTime), CAST(N'2024-08-01' AS Date), N'Active', N'Hà Nam', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (11, N'240317', N'100010', N'Ti?t ki?m có k? h?n', CAST(2000000.00 AS Decimal(18, 2)), 3, CAST(3.50 AS Decimal(5, 2)), CAST(N'2023-09-01T00:00:00.000' AS DateTime), CAST(N'2023-12-01' AS Date), N'Active', N'Bắc Giang', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (12, N'240318', N'100011', N'Ti?t ki?m k? h?n', CAST(9000000.00 AS Decimal(18, 2)), 6, CAST(4.30 AS Decimal(5, 2)), CAST(N'2023-10-01T00:00:00.000' AS DateTime), CAST(N'2024-04-01' AS Date), N'Active', N'Nam Định', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (13, N'240319', N'100012', N'Ti?t ki?m không k? h?n', CAST(18000000.00 AS Decimal(18, 2)), 0, CAST(1.10 AS Decimal(5, 2)), CAST(N'2023-11-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Thuận', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (14, N'240320', N'100013', N'Ti?t ki?m có k? h?n', CAST(27500000.00 AS Decimal(18, 2)), 24, CAST(6.20 AS Decimal(5, 2)), CAST(N'2023-12-01T00:00:00.000' AS DateTime), CAST(N'2025-12-01' AS Date), N'Active', N'Thái Bình', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (15, N'240329', N'100014', N'Ti?t ki?m k? h?n', CAST(4000000.00 AS Decimal(18, 2)), 9, CAST(4.90 AS Decimal(5, 2)), CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2024-10-01' AS Date), N'Active', N'Hà Tĩnh', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (16, N'240330', N'100015', N'Ti?t ki?m không k? h?n', CAST(10500000.00 AS Decimal(18, 2)), 0, CAST(1.40 AS Decimal(5, 2)), CAST(N'2024-02-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Phú Thọ', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (17, N'250301', N'100016', N'Ti?t ki?m k? h?n', CAST(22000000.00 AS Decimal(18, 2)), 18, CAST(5.80 AS Decimal(5, 2)), CAST(N'2024-03-01T00:00:00.000' AS DateTime), CAST(N'2025-09-01' AS Date), N'Active', N'Thanh Hóa', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (18, N'250302', N'100017', N'Ti?t ki?m có k? h?n', CAST(1200000.00 AS Decimal(18, 2)), 3, CAST(3.80 AS Decimal(5, 2)), CAST(N'2024-04-01T00:00:00.000' AS DateTime), CAST(N'2024-07-01' AS Date), N'Active', N'Nghệ An', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (19, N'250303', N'100018', N'Ti?t ki?m k? h?n', CAST(6000000.00 AS Decimal(18, 2)), 12, CAST(5.40 AS Decimal(5, 2)), CAST(N'2024-05-01T00:00:00.000' AS DateTime), CAST(N'2025-05-01' AS Date), N'Active', N'Hải Dương', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (20, N'250304', N'100019', N'Ti?t ki?m có k? h?n', CAST(15500000.00 AS Decimal(18, 2)), 30, CAST(6.80 AS Decimal(5, 2)), CAST(N'2024-06-01T00:00:00.000' AS DateTime), CAST(N'2026-12-01' AS Date), N'Active', N'Quảng Ngãi', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (21, N'250305', N'100020', N'Ti?t ki?m không k? h?n', CAST(4512143.00 AS Decimal(18, 2)), 0, CAST(1.50 AS Decimal(5, 2)), CAST(N'2024-07-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Bắc Ninh', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (22, N'250315', N'970420250001', N'cokyhan', CAST(9988778.00 AS Decimal(18, 2)), 12, CAST(5.00 AS Decimal(5, 2)), CAST(N'2003-05-22T00:00:00.000' AS DateTime), CAST(N'2004-05-22' AS Date), N'Active', N'Bình Gia Branch', N'1')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (23, N'250316', N'970423250001', N'cokyhan', CAST(10000000000.00 AS Decimal(18, 2)), 12, CAST(6.00 AS Decimal(5, 2)), CAST(N'2002-02-20T00:00:00.000' AS DateTime), CAST(N'2003-02-20' AS Date), N'Active', N'Bình Gia Branch', N'22')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (24, N'250317', N'970423250002', N'cokyhan', CAST(2121212.00 AS Decimal(18, 2)), 12, CAST(9.00 AS Decimal(5, 2)), CAST(N'2025-03-23T00:00:00.000' AS DateTime), CAST(N'2026-03-23' AS Date), N'Active', N'Bình Gia Branch', N'0')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (25, N'250318', N'970423250003', N'cokyhan', CAST(22222222.00 AS Decimal(18, 2)), 12, CAST(2.00 AS Decimal(5, 2)), CAST(N'2025-03-23T00:00:00.000' AS DateTime), CAST(N'2026-03-23' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (26, N'250319', N'970423250004', N'cokyhan', CAST(22222222222.00 AS Decimal(18, 2)), 12, CAST(2.00 AS Decimal(5, 2)), CAST(N'2025-03-23T00:00:00.000' AS DateTime), CAST(N'2026-03-23' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (27, N'250320', N'970423250005', N'cokyhan', CAST(12121212143.00 AS Decimal(18, 2)), 12, CAST(3.00 AS Decimal(5, 2)), CAST(N'2003-05-22T00:00:00.000' AS DateTime), CAST(N'2004-05-22' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (28, N'250321', N'970423250006', N'cokyhan', CAST(1222341223.00 AS Decimal(18, 2)), 12, CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-23T00:00:00.000' AS DateTime), CAST(N'2026-03-23' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (29, N'250322', N'970423250007', N'cokyhan', CAST(222222222.00 AS Decimal(18, 2)), 12, CAST(2.00 AS Decimal(5, 2)), CAST(N'2222-02-22T00:00:00.000' AS DateTime), CAST(N'2223-02-22' AS Date), N'Active', N'Bình Gia Branch', N'1898387950')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (30, N'250323', N'970423250008', N'cokyhan', CAST(1111111111.00 AS Decimal(18, 2)), 12, CAST(4.00 AS Decimal(5, 2)), CAST(N'2222-02-22T00:00:00.000' AS DateTime), CAST(N'2223-02-22' AS Date), N'Active', N'Bình Gia Branch', N'2083311053')
SET IDENTITY_INSERT [dbo].[DepositAccounts] OFF
GO
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'1', N'210323', NULL, CAST(120000.00 AS Decimal(18, 2)), NULL, NULL, N'Chờ giải ngân', N'Counter', CAST(N'2025-03-17T23:46:49.230' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'2', N'240317', NULL, CAST(160000.00 AS Decimal(18, 2)), NULL, NULL, N'Đã giải ngân', N'Counter', CAST(N'2025-03-17T23:54:22.003' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'3', N'210323', NULL, CAST(100000.00 AS Decimal(18, 2)), NULL, NULL, N'Chờ giải ngân', N'Auto', CAST(N'2025-03-18T22:39:26.313' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'4', N'210323', NULL, CAST(10000000.00 AS Decimal(18, 2)), NULL, NULL, N'Đã giải ngân', N'Auto', CAST(N'2025-03-20T21:45:40.133' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'5', N'210323', NULL, CAST(12000000.00 AS Decimal(18, 2)), NULL, NULL, N'Chờ giải ngân', N'Auto', CAST(N'2025-03-27T00:40:23.017' AS DateTime), NULL, N'435345646', N'211234234', NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'6', N'210323', NULL, CAST(1223321.00 AS Decimal(18, 2)), NULL, NULL, N'Đã giải ngân', N'Auto', CAST(N'2025-03-27T12:23:12.370' AS DateTime), CAST(N'2025-03-11' AS Date), N'3234343', N'211234234', NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'7', N'210323', NULL, CAST(12000000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Auto', CAST(N'2025-03-27T22:20:39.713' AS DateTime), CAST(N'2027-03-27' AS Date), N'3432423', N'211234234', NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'HSVV202503008', N'210323', NULL, CAST(23422.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-27T23:02:36.183' AS DateTime), CAST(N'2029-03-27' AS Date), N'202503008', N'211234234', N'Đã tất toán')
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status]) VALUES (N'HSVV202503009', N'210323', NULL, CAST(3234234.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-27T23:38:22.647' AS DateTime), CAST(N'2025-09-27' AS Date), NULL, N'211234234', NULL)
GO
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved]) VALUES (N'21123423', N'Đầy đủ giấy tờ vay', N'Minh ', N'030203007958', N'0')
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved]) VALUES (N'211234234', N'đủ', N'dsfsdfsdfcd ', N'4532454645', N'Đã phê duyệt')
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved]) VALUES (N'211234236', N'sdfsdfdsfsd dfsdfds ', N'Minh', N'030203007958', N'Đã từ chối')
GO
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'0', N'Minh22', CAST(0.00 AS Decimal(18, 2)), N'NhanLai', N'Bình Gia Branch', CAST(N'2025-03-23T11:22:13.693' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1', N'Minh', CAST(999988.00 AS Decimal(18, 2)), N'NhanLai', N'Binh Gia Branch', CAST(N'2025-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'10', N'Vu Van I', CAST(16000.75 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-09T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'11', N'Phan Th? J', CAST(18000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'12', N'Ð?ng Van K', CAST(25000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-11T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'13', N'Cao Th? L', CAST(14000.50 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-12T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'14', N'Tr?nh Van M', CAST(23000.25 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-13T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'15', N'Lê Th? N', CAST(17000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-14T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'16', N'Nguy?n Van O', CAST(26000.75 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-15T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'17', N'Tr?n Th? P', CAST(12000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-16T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'18', N'Ð? Van Q', CAST(24000.50 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-17T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1898387950', N'32', CAST(1000000.00 AS Decimal(18, 2)), N'NhanLai', N'Bình Gia Branch', CAST(N'2025-03-23T21:31:06.863' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'19', N'Ph?m Th? R', CAST(15500.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-18T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'2', N'Nguy?n Van A', CAST(10000.50 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'20', N'Hoàng Van S', CAST(19500.25 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-19T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503008', N'MinhDER', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T23:02:36.187' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'2083311053', N'453453', CAST(0.00 AS Decimal(18, 2)), N'NhanLai', N'Bình Gia Branch', CAST(N'2025-03-23T21:39:18.640' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'21', N'Nguy?n Th? T', CAST(20500.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-20T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'22', N'Minh', CAST(0.00 AS Decimal(18, 2)), N'NhanLai', N'Bình Gia Branch', CAST(N'2025-03-23T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'3', N'Tr?n Th? B', CAST(15000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'32343', N'fgfgdfgdff', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T22:47:42.493' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'3234343', N'minh', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T12:23:12.373' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'3432324', N'fgfvfvdfs', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T22:44:01.607' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'3432423', N'43434grfgdfsfdsf', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T22:20:59.283' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'343432332', N'MinhDER', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T12:29:05.653' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'4', N'Lê Van C', CAST(20000.75 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'435345646', N'MinhDER', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-27T00:40:23.017' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'5', N'Ph?m Th? D', CAST(17500.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-04T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'6', N'Ð? Van E', CAST(22000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-05T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'7', N'Ngô Th? F', CAST(13000.25 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'8', N'Bùi Van G', CAST(20000.50 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-07T00:00:00.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'9', N'Hoàng Th? H', CAST(21000.00 AS Decimal(18, 2)), N'Chuyên d?ng', N'Binh Gia Branch', CAST(N'2025-03-08T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TransactionHistory] ON 

INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (1, NULL, N'2083311053', CAST(1235433.00 AS Decimal(18, 2)), CAST(N'2025-03-23T22:35:31.427' AS DateTime), N'453453', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (2, NULL, N'2083311053', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2025-03-23T22:39:13.053' AS DateTime), N'453453', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (3, NULL, N'1898387950', CAST(1000000.00 AS Decimal(18, 2)), CAST(N'2025-03-23T23:06:58.747' AS DateTime), N'32', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (4, 21, NULL, CAST(12.00 AS Decimal(18, 2)), CAST(N'2025-03-23T23:40:16.320' AS DateTime), N'Hoàng Văn E', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (5, 21, NULL, CAST(1.00 AS Decimal(18, 2)), CAST(N'2025-03-23T23:40:46.790' AS DateTime), N'Minh', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (6, NULL, N'8', CAST(1000.00 AS Decimal(18, 2)), CAST(N'2025-03-24T00:01:44.457' AS DateTime), N'Bùi Van G', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (7, 21, NULL, CAST(12000.00 AS Decimal(18, 2)), CAST(N'2025-03-24T00:02:47.750' AS DateTime), N'Hoàng Văn E', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (8, 21, NULL, CAST(130.00 AS Decimal(18, 2)), CAST(N'2025-03-24T00:03:20.217' AS DateTime), N'MinhGui', N'Completed')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (9, 22, NULL, CAST(111.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:36:40.130' AS DateTime), N'Lê Văn X', N'Success')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (10, 2, NULL, CAST(123333.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:47:08.807' AS DateTime), N'Nguyễn Văn V', N'Success')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (11, 22, NULL, CAST(11111.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:49:06.320' AS DateTime), N'Lê Văn X', N'Success')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (12, 3, NULL, CAST(123333.00 AS Decimal(18, 2)), CAST(N'2025-03-26T00:01:29.710' AS DateTime), N'Trần Thị W', N'Success')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus]) VALUES (13, NULL, N'1', CAST(12.00 AS Decimal(18, 2)), CAST(N'2025-03-26T00:04:34.400' AS DateTime), N'Minh', N'Success')
SET IDENTITY_INSERT [dbo].[TransactionHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'admin', N'1111', N'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DepositA__AF91A6AD04AC356C]    Script Date: 3/28/2025 12:04:44 PM ******/
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [UQ__DepositA__AF91A6AD04AC356C] UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LoanAccounts]    Script Date: 3/28/2025 12:04:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_LoanAccounts] ON [dbo].[LoanAccounts]
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572509CA5EA]    Script Date: 3/28/2025 12:04:44 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
