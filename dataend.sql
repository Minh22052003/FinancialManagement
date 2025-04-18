USE [master]
GO
/****** Object:  Database [HeThongTaiChinhDB]    Script Date: 4/9/2025 11:04:25 PM ******/
CREATE DATABASE [HeThongTaiChinhDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HeThongTaiChinhDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\HeThongTaiChinhDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HeThongTaiChinhDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\HeThongTaiChinhDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HeThongTaiChinhDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HeThongTaiChinhDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET  MULTI_USER 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HeThongTaiChinhDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HeThongTaiChinhDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HeThongTaiChinhDB] SET QUERY_STORE = OFF
GO
USE [HeThongTaiChinhDB]
GO
/****** Object:  Table [dbo].[ApprovalHistory]    Script Date: 4/9/2025 11:04:25 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 4/9/2025 11:04:25 PM ******/
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
/****** Object:  Table [dbo].[DepositAccounts]    Script Date: 4/9/2025 11:04:25 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialTransactions]    Script Date: 4/9/2025 11:04:25 PM ******/
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
/****** Object:  Table [dbo].[LoanAccounts]    Script Date: 4/9/2025 11:04:25 PM ******/
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
	[is_fully_paid] [bit] NOT NULL,
	[fully_paid_at] [datetime] NULL,
 CONSTRAINT [PK_LoanAccounts] PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanProfile]    Script Date: 4/9/2025 11:04:25 PM ******/
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
	[LoanAmount] [decimal](18, 2) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ApprovedAt] [datetime] NULL,
	[RejectedAt] [datetime] NULL,
 CONSTRAINT [PK__LoanProf__290C888483C04338] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentHistory]    Script Date: 4/9/2025 11:04:25 PM ******/
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
/****** Object:  Table [dbo].[SpecializedAccounts]    Script Date: 4/9/2025 11:04:25 PM ******/
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
/****** Object:  Table [dbo].[TransactionHistory]    Script Date: 4/9/2025 11:04:25 PM ******/
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
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK__Transact__55433A6B1A490E08] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/9/2025 11:04:25 PM ******/
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
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250301', N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, HN', N'0912345678', N'nguyenvana@example.com', N'012345678901', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250302', N'Trần Thị B', CAST(N'1985-10-25' AS Date), N'45 Hoàng Diệu, Đà Nẵng', N'0923456789', N'tranthib@example.com', N'023456789012', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250303', N'Phạm Văn C', CAST(N'1992-07-18' AS Date), N'67 Nguyễn Trãi, TP.HCM', N'0934567890', N'phamvanc@example.com', N'034567890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250304', N'Lê Thị D', CAST(N'1988-03-09' AS Date), N'89 Lý Tự Trọng, Cần Thơ', N'0945678901', N'lethid@example.com', N'045678901234', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250305', N'Đỗ Mạnh E', CAST(N'1995-12-30' AS Date), N'101 Hai Bà Trưng, Hải Phòng', N'0956789012', N'domanhee@example.com', N'056789012345', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250306', N'Bùi Thị F', CAST(N'1993-09-15' AS Date), N'111 Trần Phú, Huế', N'0967890123', N'buithif@example.com', N'067890123456', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250307', N'Ngô Văn G', CAST(N'1991-06-21' AS Date), N'78 Quang Trung, Hà Nội', N'0978901234', N'ngovang@example.com', N'078901234567', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250308', N'Hoàng Thị H', CAST(N'1987-04-05' AS Date), N'99 Võ Văn Kiệt, TP.HCM', N'0989012345', N'hoangthih@example.com', N'089012345678', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250309', N'Vũ Minh I', CAST(N'1994-11-28' AS Date), N'22 Nguyễn Huệ, Đà Nẵng', N'0990123456', N'vuminhi@example.com', N'090123456789', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250310', N'Phan Văn J', CAST(N'1996-08-14' AS Date), N'333 Trường Chinh, Cần Thơ', N'0901234567', N'phanvanj@example.com', N'101234567890', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250311', N'Nguyễn Thị K', CAST(N'1989-02-27' AS Date), N'14 Phạm Văn Đồng, Hà Nội', N'0912345679', N'nguyenthik@example.com', N'112345678901', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250312', N'Trương Quốc L', CAST(N'1997-05-23' AS Date), N'88 Pasteur, TP.HCM', N'0923456780', N'truongquocl@example.com', N'123456789012', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250313', N'Đặng Văn M', CAST(N'1986-07-09' AS Date), N'109 Nguyễn Văn Linh, Đà Nẵng', N'0934567891', N'dangvanm@example.com', N'134567890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250314', N'Lâm Thị N', CAST(N'1998-10-30' AS Date), N'256 Lê Văn Sỹ, TP.HCM', N'0945678902', N'lamthin@example.com', N'145678901234', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250315', N'Huỳnh Văn O', CAST(N'1993-12-12' AS Date), N'198 Nguyễn Đình Chiểu, Hà Nội', N'0956789013', N'huynhvano@example.com', N'156789012345', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250316', N'Tô Minh P', CAST(N'1991-09-18' AS Date), N'300 Điện Biên Phủ, Hải Phòng', N'0967890124', N'tominhp@example.com', N'167890123456', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250317', N'Nguyễn Văn Q', CAST(N'1995-06-05' AS Date), N'409 Nguyễn Công Trứ, Huế', N'0978901235', N'nguyenvanq@example.com', N'178901234567', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250318', N'Đỗ Thị R', CAST(N'1987-01-20' AS Date), N'120 Hùng Vương, Đà Nẵng', N'0989012346', N'dothir@example.com', N'189012345678', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250319', N'Bùi Văn S', CAST(N'1999-08-29' AS Date), N'333 Cách Mạng Tháng 8, TP.HCM', N'0990123457', N'buivans@example.com', N'190123456789', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250320', N'Trần Quốc T', CAST(N'1994-04-17' AS Date), N'15 Lý Thường Kiệt, Cần Thơ', N'0901234568', N'tranquoct@example.com', N'201234567890', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250321', N'Vũ Thị U', CAST(N'1985-11-11' AS Date), N'100 Nguyễn Thị Minh Khai, Hà Nội', N'0912345670', N'vuthiu@example.com', N'212345678901', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250322', N'Phan Minh V', CAST(N'1992-07-08' AS Date), N'205 Nguyễn Văn Cừ, Hải Phòng', N'0923456781', N'phanminhv@example.com', N'223456789012', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250323', N'Lê Văn W', CAST(N'1989-03-15' AS Date), N'89 Lê Hồng Phong, TP.HCM', N'0934567892', N'levanw@example.com', N'234567890123', N'Inactive')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250324', N'Trịnh Thị X', CAST(N'1990-12-25' AS Date), N'45 Tôn Đức Thắng, Đà Nẵng', N'0945678903', N'trinhthix@example.com', N'245678901234', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250325', N'Hoàng Văn Y', CAST(N'1997-06-30' AS Date), N'222 Phan Đình Phùng, Cần Thơ', N'0956789014', N'hoangvany@example.com', N'256789012345', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250401', N'Phạm Minh', CAST(N'2003-05-22' AS Date), N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'133344455566', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250402', N'Lê Văn X', NULL, NULL, N'0382205343', NULL, N'030203007958', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250403', N'Phạm Minh', CAST(N'2003-05-22' AS Date), N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'7890123', N'Active')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number], [status]) VALUES (N'250404', N'Bùi Thị F', NULL, NULL, N'0967890123', NULL, N'067890123456', N'Active')
GO
SET IDENTITY_INSERT [dbo].[DepositAccounts] ON 

INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (1, N'250306', N'250305', N'Tiết kiệm không kỳ hạn', CAST(1300000012.00 AS Decimal(18, 2)), NULL, CAST(5.50 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (2, N'250307', N'250303', N'Tiết kiệm có kỳ hạn', CAST(800000000.00 AS Decimal(18, 2)), 12, CAST(7.20 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2026-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503026')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (3, N'250308', N'250304', N'Tiết kiệm có kỳ hạn', CAST(950000000.00 AS Decimal(18, 2)), 6, CAST(6.50 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2025-09-30' AS Date), N'Active', N'Bình Gia Branch', N'202503038')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (4, N'250309', N'250302', N'Tiết kiệm không kỳ hạn', CAST(670000000.00 AS Decimal(18, 2)), NULL, CAST(4.75 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (5, N'250301', N'250309', N'Tiết kiệm có kỳ hạn', CAST(1200000000.00 AS Decimal(18, 2)), 24, CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2027-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503026')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (6, N'250311', N'250301', N'Tiết kiệm không kỳ hạn', CAST(550000000.00 AS Decimal(18, 2)), NULL, CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (7, N'250312', N'250311', N'Tiết kiệm có kỳ hạn', CAST(890000000.00 AS Decimal(18, 2)), 12, CAST(7.30 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2026-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503016')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (8, N'250313', N'250307', N'Tiết kiệm không kỳ hạn', CAST(740000000.00 AS Decimal(18, 2)), NULL, CAST(4.90 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (9, N'250314', N'250310', N'Tiết kiệm có kỳ hạn', CAST(1020000000.00 AS Decimal(18, 2)), 36, CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2028-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503012')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (10, N'250315', N'250306', N'Tiết kiệm không kỳ hạn', CAST(920000000.00 AS Decimal(18, 2)), NULL, CAST(5.20 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (11, N'250316', N'250308', N'Tiết kiệm có kỳ hạn', CAST(870000000.00 AS Decimal(18, 2)), 18, CAST(7.75 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2026-09-30' AS Date), N'Active', N'Bình Gia Branch', N'202503028')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (12, N'250317', N'250331', N'Tiết kiệm không kỳ hạn', CAST(648130210.00 AS Decimal(18, 2)), NULL, CAST(4.60 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (13, N'250318', N'250336', N'Tiết kiệm có kỳ hạn', CAST(1150000000.00 AS Decimal(18, 2)), 12, CAST(7.40 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2026-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503036')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (14, N'250319', N'250333', N'Tiết kiệm không kỳ hạn', CAST(790000000.00 AS Decimal(18, 2)), NULL, CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (15, N'250320', N'250332', N'Tiết kiệm có kỳ hạn', CAST(1340000000.00 AS Decimal(18, 2)), 24, CAST(8.20 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2027-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503010')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (16, N'250321', N'250339', N'Tiết kiệm không kỳ hạn', CAST(710000000.00 AS Decimal(18, 2)), NULL, CAST(4.80 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (17, N'250322', N'250337', N'Tiết kiệm có kỳ hạn', CAST(890000000.00 AS Decimal(18, 2)), 6, CAST(6.60 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2025-09-30' AS Date), N'Active', N'Bình Gia Branch', N'202503020')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (18, N'250323', N'250334', N'Tiết kiệm không kỳ hạn', CAST(620000000.00 AS Decimal(18, 2)), NULL, CAST(4.55 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (19, N'250324', N'250321', N'Tiết kiệm có kỳ hạn', CAST(970000000.00 AS Decimal(18, 2)), 36, CAST(8.30 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2028-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503026')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (20, N'250325', N'250324', N'Tiết kiệm không kỳ hạn', CAST(880000000.00 AS Decimal(18, 2)), NULL, CAST(5.15 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (21, N'250325', N'250327', N'Tiết kiệm có kỳ hạn', CAST(1100000000.00 AS Decimal(18, 2)), 12, CAST(7.50 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), CAST(N'2026-03-30' AS Date), N'Active', N'Bình Gia Branch', N'202503036')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (22, N'250325', N'250322', N'Tiết kiệm không kỳ hạn', CAST(780000000.00 AS Decimal(18, 2)), NULL, CAST(5.10 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (23, N'250402', N'970403250001', N'Tiết kiệm có kỳ hạn', CAST(124356523.00 AS Decimal(18, 2)), 3, CAST(2.50 AS Decimal(5, 2)), CAST(N'2025-05-22T00:00:00.000' AS DateTime), CAST(N'2025-08-22' AS Date), N'Active', N'Bình Gia Branch', N'1409741983')
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (24, N'250306', N'970407250001', N'Thanh toán', CAST(53453523452.00 AS Decimal(18, 2)), NULL, CAST(0.20 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (25, N'250306', N'970407250002', N'Thanh toán', CAST(452345234.00 AS Decimal(18, 2)), NULL, CAST(0.20 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (26, N'250306', N'970407250003', N'Tiết kiệm có kỳ hạn', CAST(343243534.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (27, N'250306', N'970407250004', N'Tiết kiệm có kỳ hạn', CAST(343243534.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (28, N'250306', N'970407250005', N'Tiết kiệm có kỳ hạn', CAST(343243534.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (29, N'250306', N'970407250006', N'Tiết kiệm có kỳ hạn', CAST(5434564565464.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (30, N'250306', N'970407250007', N'Tiết kiệm có kỳ hạn', CAST(45465465346534.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (31, N'250306', N'970407250008', N'Thanh toán', CAST(12321.00 AS Decimal(18, 2)), NULL, CAST(0.20 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (32, N'250306', N'970407250009', N'Tiết kiệm có kỳ hạn', CAST(43245353.00 AS Decimal(18, 2)), 12, CAST(4.70 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), CAST(N'2026-04-07' AS Date), N'Active', N'Bình Gia Branch', NULL)
SET IDENTITY_INSERT [dbo].[DepositAccounts] OFF
GO
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503008', N'250303', NULL, CAST(23422.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-27T23:02:36.183' AS DateTime), CAST(N'2026-03-27' AS Date), N'202503009', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503009', N'250303', NULL, CAST(3234234.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Counter', CAST(N'2025-03-27T23:38:22.647' AS DateTime), CAST(N'2025-09-27' AS Date), NULL, N'211234234', NULL, 1, CAST(N'2025-04-01T23:52:18.567' AS DateTime))
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503010', N'250304', NULL, CAST(50000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T00:10:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503010', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503011', N'250304', NULL, CAST(750000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T00:15:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503012', N'250305', NULL, CAST(1250000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T01:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503012', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503013', N'250305', NULL, CAST(980000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T01:05:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503014', N'250306', NULL, CAST(450000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T02:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503014', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503015', N'250306', NULL, CAST(1120000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T02:10:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503016', N'250307', NULL, CAST(250000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T03:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503016', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503017', N'250307', NULL, CAST(9800000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T03:15:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503018', N'250308', NULL, CAST(432200.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T04:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503018', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503019', N'250308', NULL, CAST(7654321.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T04:20:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503020', N'250309', NULL, CAST(120000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T05:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503020', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503021', N'250309', NULL, CAST(650000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T05:10:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503022', N'250310', NULL, CAST(45000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T06:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503022', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503023', N'250310', NULL, CAST(2345678.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T06:15:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503024', N'250311', NULL, CAST(987654.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T07:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503024', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503025', N'250311', NULL, CAST(765432.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T07:10:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503026', N'250312', NULL, CAST(543210.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T08:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503026', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503027', N'250312', NULL, CAST(1234567.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T08:15:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503028', N'250313', NULL, CAST(654321.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T09:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503028', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503029', N'250313', NULL, CAST(234567.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T09:10:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503030', N'250314', NULL, CAST(98765.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T10:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503030', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503031', N'250314', NULL, CAST(876543.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-28T10:15:00.000' AS DateTime), CAST(N'2025-09-28' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503032', N'250315', NULL, CAST(5432100.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-28T11:00:00.000' AS DateTime), CAST(N'2026-03-28' AS Date), N'202503032', N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503100', N'250310', NULL, CAST(1500000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-20T10:00:00.000' AS DateTime), CAST(N'2027-03-20' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503101', N'250311', NULL, CAST(2000000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-18T14:30:00.000' AS DateTime), CAST(N'2030-03-18' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503102', N'250312', NULL, CAST(750000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Auto', CAST(N'2025-03-15T08:45:00.000' AS DateTime), CAST(N'2025-09-15' AS Date), N'202503030', N'211234234', NULL, 0, CAST(N'2025-04-01T23:35:48.643' AS DateTime))
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503103', N'250313', NULL, CAST(3200000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-03-17T11:20:00.000' AS DateTime), CAST(N'2027-03-17' AS Date), NULL, N'211234234', NULL, 0, NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202503104', N'250314', NULL, CAST(1800000.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Đã giải ngân', N'Auto', CAST(N'2025-03-16T16:10:00.000' AS DateTime), CAST(N'2027-03-16' AS Date), N'202503030', N'211234234', NULL, 1, CAST(N'2025-04-01T23:35:48.673' AS DateTime))
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date], [specialized_account_id], [LoanProfileID], [disbursement_status], [is_fully_paid], [fully_paid_at]) VALUES (N'HSVV202504001', N'250307', NULL, CAST(120004.00 AS Decimal(18, 2)), NULL, CAST(9.00 AS Decimal(5, 2)), N'Chờ giải ngân', N'Counter', CAST(N'2025-04-07T21:44:27.407' AS DateTime), CAST(N'2027-04-07' AS Date), NULL, N'211234264', NULL, 0, NULL)
GO
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234237', N'Đầy đủ giấy tờ vay', N'Nguyễn Văn A', N'012345678901', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234238', N'Đủ giấy đề nghị vay', N'Trần Thị B', N'023456789012', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234239', N'Hợp đồng lao động', N'Lê Văn C', N'034567890123', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234240', N'Bảng lương 3 tháng gần nhất', N'Phạm Thị D', N'045678901234', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234241', N'Xác nhận thu nhập', N'Hoàng Văn E', N'056789012345', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234242', N'Chứng minh nhân dân hoặc CCCD', N'Đặng Thị F', N'067890123456', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234243', N'Sổ hộ khẩu photo', N'Bùi Văn G', N'078901234567', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234244', N'Hợp đồng vay tín dụng', N'Võ Thị H', N'089012345678', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234245', N'Xác nhận công tác', N'Ngô Văn I', N'090123456789', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234246', N'Bảng kê tài khoản ngân hàng', N'Phan Thị J', N'101234567890', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234247', N'Giấy phép kinh doanh', N'Trịnh Văn K', N'112345678901', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234248', N'Hợp đồng bảo hiểm nhân thọ', N'Lương Thị L', N'123456789012', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234249', N'Giấy xác nhận cư trú', N'Hoàng Thị M', N'134567890123', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234250', N'Bảng kê thu nhập', N'Nguyễn Văn N', N'145678901234', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234251', N'Giấy tờ xe (nếu có thế chấp)', N'Trần Thị O', N'156789012345', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234252', N'Hợp đồng thuê nhà', N'Lê Văn P', N'167890123456', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234253', N'Xác nhận tình trạng hôn nhân', N'Phạm Thị Q', N'178901234567', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234254', N'Xác nhận nợ xấu', N'Hoàng Văn R', N'189012345678', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234255', N'Giấy ủy quyền (nếu có)', N'Đặng Thị S', N'190123456789', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234256', N'Chứng nhận quyền sử dụng đất', N'Bùi Văn T', N'201234567890', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234257', N'Hợp đồng tín dụng cá nhân', N'Vũ Thị U', N'212345678901', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234258', N'Bản sao kê lương 6 tháng', N'Ngô Văn V', N'223456789012', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234259', N'Giấy xác nhận công tác', N'Phạm Thị W', N'234567890123', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234260', N'Hóa đơn điện nước 3 tháng gần nhất', N'Lê Văn X', N'245678901234', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234261', N'Bản sao CMND/CCCD công chứng', N'Trần Thị Y', N'256789012345', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234262', N'Đầy đủ giấy tờ vay', N'Nguyễn Văn A', N'012345678901', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234263', N'Đủ giấy đề nghị vay', N'Trần Thị B', N'023456789012', N'Đã từ chối', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234264', N'Hợp đồng lao động', N'Lê Văn C', N'034567890123', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234265', N'Bảng lương 3 tháng gần nhất', N'Phạm Thị D', N'045678901234', N'Đã phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), CAST(N'2025-04-09T22:51:19.310' AS DateTime), NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234266', N'Xác nhận thu nhập', N'Hoàng Văn E', N'056789012345', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234267', N'Chứng minh nhân dân hoặc CCCD', N'Đặng Thị F', N'067890123456', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234268', N'Sổ hộ khẩu photo', N'Bùi Văn G', N'078901234567', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234269', N'Hợp đồng vay tín dụng', N'Võ Thị H', N'089012345678', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234270', N'Xác nhận công tác', N'Ngô Văn I', N'090123456789', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234271', N'Bảng kê tài khoản ngân hàng', N'Phan Thị J', N'101234567890', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234272', N'Giấy phép kinh doanh', N'Trịnh Văn K', N'112345678901', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234273', N'Hợp đồng bảo hiểm nhân thọ', N'Lương Thị L', N'123456789012', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234274', N'Giấy xác nhận cư trú', N'Hoàng Thị M', N'134567890123', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234275', N'Bảng kê thu nhập', N'Nguyễn Văn N', N'145678901234', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234276', N'Giấy tờ xe (nếu có thế chấp)', N'Trần Thị O', N'156789012345', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234277', N'Hợp đồng thuê nhà', N'Lê Văn P', N'167890123456', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234278', N'Xác nhận tình trạng hôn nhân', N'Phạm Thị Q', N'178901234567', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234279', N'Xác nhận nợ xấu', N'Hoàng Văn R', N'189012345678', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234280', N'Giấy ủy quyền (nếu có)', N'Đặng Thị S', N'190123456789', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'211234281', N'Chứng nhận quyền sử dụng đất', N'Bùi Văn T', N'201234567890', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'LP1234282', N'đủ giấy test', N'minh', N'030203007958', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
INSERT [dbo].[LoanProfile] ([ProfileID], [Notes], [CustomerName], [CitizenID], [IsApproved], [LoanAmount], [CreatedAt], [ApprovedAt], [RejectedAt]) VALUES (N'LP1234283', N'Đủ', N'Nguyễn Văn V', N'030203007958', N'Chưa phê duyệt', CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-04-08T22:10:46.953' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1052421243', N'Minh22', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-04-07T23:08:31.877' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1089388516', N'Minh22', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-04-07T23:27:59.467' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1409741983', N'Minh22', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-04-03T23:35:24.063' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'1726597900', N'123Minyh', CAST(0.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-04-07T23:12:14.670' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503009', N'Nguyễn Văn A', CAST(125000.50 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', CAST(N'2025-03-01T08:15:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503010', N'Trần Thị B', CAST(950000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', CAST(N'2025-03-02T12:45:10.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503011', N'Lê Minh C', CAST(72000.75 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', CAST(N'2025-03-03T15:30:45.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503012', N'Phạm Thị D', CAST(502500.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', CAST(N'2025-03-04T18:20:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503013', N'Hoàng Văn E', CAST(315600.25 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', CAST(N'2025-03-05T09:10:20.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503014', N'Đinh Thị F', CAST(86000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-03-06T14:55:40.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503015', N'Bùi Thanh G', CAST(215000.80 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', CAST(N'2025-03-07T11:30:10.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503016', N'Võ Thị H', CAST(125600.90 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', CAST(N'2025-03-08T16:45:25.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503017', N'Ngô Văn I', CAST(99000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', CAST(N'2025-03-09T20:10:50.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503018', N'Huỳnh Thị K', CAST(780500.60 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', CAST(N'2025-03-10T07:25:15.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503019', N'Tôn Nữ L', CAST(360000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-11T13:40:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503020', N'Lâm Văn M', CAST(995000.90 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', CAST(N'2025-03-12T17:55:45.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503021', N'Mai Thị N', CAST(51000.25 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', CAST(N'2025-03-13T22:15:10.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503022', N'Châu Văn O', CAST(204000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', CAST(N'2025-03-14T10:30:20.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503023', N'Dương Thị P', CAST(610500.80 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', CAST(N'2025-03-15T15:45:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503024', N'Trịnh Văn Q', CAST(380000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-03-16T18:55:40.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503025', N'Hà Thị R', CAST(999999.99 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', CAST(N'2025-03-17T07:10:50.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503026', N'Kiều Văn S', CAST(87000.50 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', CAST(N'2025-03-18T12:30:10.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503027', N'Giang Thị T', CAST(450000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', CAST(N'2025-03-19T16:45:25.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503028', N'Cao Văn U', CAST(750500.70 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', CAST(N'2025-03-20T22:10:50.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503029', N'Vương Thị V', CAST(123000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-21T08:20:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503030', N'Liêu Văn X', CAST(975043482.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hồ Chí Minh Branch', CAST(N'2025-03-22T13:40:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503031', N'Đoàn Thị Y', CAST(315000.25 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hải Phòng Branch', CAST(N'2025-03-23T17:55:45.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503032', N'Tống Văn Z', CAST(750000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Đà Nẵng Branch', CAST(N'2025-03-24T20:10:50.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503033', N'Lý Minh Đ', CAST(620500.30 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hà Nội Branch', CAST(N'2025-03-25T10:30:20.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503034', N'Chử Văn Â', CAST(395000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Bình Gia Branch', CAST(N'2025-03-26T15:45:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503035', N'Quách Thị Bê', CAST(985000.90 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Hồ Chí Minh Branch', CAST(N'2025-03-27T18:55:40.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503036', N'Tạ Văn Cê', CAST(51000.25 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hải Phòng Branch', CAST(N'2025-03-28T22:15:10.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503037', N'Đinh Thị Đê', CAST(270000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Đà Nẵng Branch', CAST(N'2025-03-29T10:30:20.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503038', N'Nguyễn Văn Ê', CAST(910500.80 AS Decimal(18, 2)), N'Tài khoản chuyên dụng nhận lãi gửi', N'Hà Nội Branch', CAST(N'2025-03-30T15:45:30.000' AS DateTime))
INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType], [Branch], [CreateAt]) VALUES (N'202503039', N'Trương Văn Gê', CAST(340000.00 AS Decimal(18, 2)), N'Tài khoản chuyên dụng trả lãi vay', N'Bình Gia Branch', CAST(N'2025-03-31T18:55:40.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TransactionHistory] ON 

INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (4, 21, NULL, CAST(12.00 AS Decimal(18, 2)), CAST(N'2025-03-23T23:40:16.320' AS DateTime), N'Hoàng Văn E', N'Completed', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (5, 21, NULL, CAST(1.00 AS Decimal(18, 2)), CAST(N'2025-03-23T23:40:46.790' AS DateTime), N'Minh', N'Completed', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (7, 21, NULL, CAST(12000.00 AS Decimal(18, 2)), CAST(N'2025-03-24T00:02:47.750' AS DateTime), N'Hoàng Văn E', N'Completed', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (8, 21, NULL, CAST(130.00 AS Decimal(18, 2)), CAST(N'2025-03-24T00:03:20.217' AS DateTime), N'MinhGui', N'Completed', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (9, 22, NULL, CAST(111.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:36:40.130' AS DateTime), N'Lê Văn X', N'Success', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (10, 2, NULL, CAST(123333.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:47:08.807' AS DateTime), N'Nguyễn Văn V', N'Success', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (11, 22, NULL, CAST(11111.00 AS Decimal(18, 2)), CAST(N'2025-03-25T23:49:06.320' AS DateTime), N'Lê Văn X', N'Success', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (12, 3, NULL, CAST(123333.00 AS Decimal(18, 2)), CAST(N'2025-03-26T00:01:29.710' AS DateTime), N'Trần Thị W', N'Success', NULL)
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (14, 12, NULL, CAST(4323243.00 AS Decimal(18, 2)), CAST(N'2025-03-31T23:13:37.373' AS DateTime), N'Nguyễn Văn Q', N'Success', N'Rút tiền từ tài khoản tiền gửi')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (15, 12, NULL, CAST(12453453.00 AS Decimal(18, 2)), CAST(N'2025-03-31T23:13:52.870' AS DateTime), N'Nguyễn Văn Q', N'Completed', N'Gửi tiền vào tài khoản thanh toán')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (16, NULL, N'202503030', CAST(1000003482.00 AS Decimal(18, 2)), CAST(N'2025-04-01T23:30:32.983' AS DateTime), N'Liêu Văn X', N'Completed', N'Gửi tiền vào tài khoản chuyên dụng')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (17, NULL, N'202503030', CAST(7500000.00 AS Decimal(18, 2)), CAST(N'2025-04-01T23:35:48.643' AS DateTime), N'Tự động', N'Success', N'Tự động trừ nợ giao dịch')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (18, NULL, N'202503030', CAST(18000000.00 AS Decimal(18, 2)), CAST(N'2025-04-01T23:35:48.673' AS DateTime), N'Tự động', N'Success', N'Tự động trừ nợ giao dịch')
INSERT [dbo].[TransactionHistory] ([TransactionId], [DepositAccountId], [SpecialAccountId], [TransactionAmount], [TransactionDate], [Transactor], [TransactionStatus], [Description]) VALUES (19, 1, NULL, CAST(12.00 AS Decimal(18, 2)), CAST(N'2025-04-07T21:45:24.440' AS DateTime), N'Bùi Thị F', N'Completed', N'Gửi tiền vào tài khoản thanh toán')
SET IDENTITY_INSERT [dbo].[TransactionHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'giaodichvien', N'1111', N'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (3, N'giamdoc', N'1111', N'Dealer', CAST(N'2025-04-02T00:00:26.577' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (4, N'admin', N'1111', N'Dealer', CAST(N'2025-04-09T23:03:51.457' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (5, N'truongphong', N'1111', N'Dealer', CAST(N'2025-04-09T23:03:51.460' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DepositA__AF91A6AD04AC356C]    Script Date: 4/9/2025 11:04:25 PM ******/
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [UQ__DepositA__AF91A6AD04AC356C] UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LoanAccounts]    Script Date: 4/9/2025 11:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_LoanAccounts] ON [dbo].[LoanAccounts]
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572247A31FC]    Script Date: 4/9/2025 11:04:25 PM ******/
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
ALTER TABLE [dbo].[LoanAccounts] ADD  DEFAULT ((0)) FOR [is_fully_paid]
GO
ALTER TABLE [dbo].[LoanProfile] ADD  CONSTRAINT [DF_LoanProfile_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[LoanProfile] ADD  DEFAULT ((0)) FOR [LoanAmount]
GO
ALTER TABLE [dbo].[LoanProfile] ADD  DEFAULT (getdate()) FOR [CreatedAt]
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
