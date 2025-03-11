USE [master]
GO
/****** Object:  Database [HeThongTaiChinhDB]    Script Date: 3/11/2025 10:10:08 PM ******/
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
/****** Object:  Table [dbo].[ApprovalHistory]    Script Date: 3/11/2025 10:10:09 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 3/11/2025 10:10:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[date_of_birth] [date] NULL,
	[address] [nvarchar](255) NULL,
	[phone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[identity_number] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepositAccounts]    Script Date: 3/11/2025 10:10:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepositAccounts](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[account_number] [varchar](20) NOT NULL,
	[account_type] [varchar](50) NOT NULL,
	[balance] [decimal](18, 2) NOT NULL,
	[term] [int] NULL,
	[interest_rate] [decimal](5, 2) NULL,
	[created_at] [datetime] NOT NULL,
	[maturity_date] [date] NULL,
	[status] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialTransactions]    Script Date: 3/11/2025 10:10:09 PM ******/
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
/****** Object:  Table [dbo].[LoanAccounts]    Script Date: 3/11/2025 10:10:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanAccounts](
	[loan_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[linked_deposit_account_id] [int] NULL,
	[loan_amount] [decimal](18, 2) NOT NULL,
	[approved_amount] [decimal](18, 2) NULL,
	[interest_rate] [decimal](5, 2) NULL,
	[loan_status] [varchar](50) NOT NULL,
	[payment_method] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[due_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanDocuments]    Script Date: 3/11/2025 10:10:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanDocuments](
	[document_id] [int] IDENTITY(1,1) NOT NULL,
	[loan_id] [int] NOT NULL,
	[document_details] [nvarchar](255) NULL,
	[submitted_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentHistory]    Script Date: 3/11/2025 10:10:09 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 3/11/2025 10:10:09 PM ******/
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
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250301, N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, Hà Nội', N'0912345678', N'nguyenvana@example.com', N'012345678901')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250302, N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Trần Hưng Đạo, TP.HCM', N'0987654321', N'tranthib@example.com', N'123456789012')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250303, N'Lê Văn C', CAST(N'1992-11-30' AS Date), N'789 Hoàng Diệu, Đà Nẵng', N'0901122334', N'levanc@example.com', N'234567890123')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250304, N'Phạm Thị D', CAST(N'1995-03-25' AS Date), N'101 Phan Chu Trinh, Hải Phòng', N'0966778899', N'phamthid@example.com', N'345678901234')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250305, N'Hoàng Văn E', CAST(N'1988-07-15' AS Date), N'202 Nguyễn Du, Cần Thơ', N'0977554466', N'hoangvane@example.com', N'456789012345')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250306, N'Bùi Thị F', CAST(N'1993-09-10' AS Date), N'303 Hai Bà Trưng, Huế', N'0944332211', N'buithif@example.com', N'567890123456')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250307, N'Đỗ Văn G', CAST(N'1991-12-22' AS Date), N'404 Bạch Đằng, Đà Lạt', N'0933221100', N'dovang@example.com', N'678901234567')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250308, N'Vũ Thị H', CAST(N'1987-06-05' AS Date), N'505 Lý Thường Kiệt, Nha Trang', N'0922110099', N'vuthih@example.com', N'789012345678')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250309, N'Ngô Văn I', CAST(N'1996-04-18' AS Date), N'606 Trường Chinh, Vũng Tàu', N'0911002233', N'ngovanii@example.com', N'890123456789')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250310, N'Đặng Thị K', CAST(N'1984-10-07' AS Date), N'707 Nguyễn Thái Học, Bình Dương', N'0909090909', N'dangthik@example.com', N'901234567890')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (250311, N'Phạm Minh', CAST(N'2003-05-22' AS Date), N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'0382205343', N'alanpham2224@gmail.com', N'030203007958')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'admin', N'1111', N'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DepositA__AF91A6AD04AC356C]    Script Date: 3/11/2025 10:10:09 PM ******/
ALTER TABLE [dbo].[DepositAccounts] ADD UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572509CA5EA]    Script Date: 3/11/2025 10:10:09 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApprovalHistory] ADD  DEFAULT (getdate()) FOR [approval_date]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  DEFAULT ((0)) FOR [balance]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[DepositAccounts] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[FinancialTransactions] ADD  DEFAULT (getdate()) FOR [transaction_date]
GO
ALTER TABLE [dbo].[LoanAccounts] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[LoanDocuments] ADD  DEFAULT (getdate()) FOR [submitted_date]
GO
ALTER TABLE [dbo].[PaymentHistory] ADD  DEFAULT (getdate()) FOR [payment_date]
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
ALTER TABLE [dbo].[LoanDocuments]  WITH CHECK ADD  CONSTRAINT [FK_LoanDocuments_LoanAccounts] FOREIGN KEY([loan_id])
REFERENCES [dbo].[LoanAccounts] ([loan_id])
GO
ALTER TABLE [dbo].[LoanDocuments] CHECK CONSTRAINT [FK_LoanDocuments_LoanAccounts]
GO
ALTER TABLE [dbo].[PaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_PaymentHistory_LoanAccounts] FOREIGN KEY([loan_id])
REFERENCES [dbo].[LoanAccounts] ([loan_id])
GO
ALTER TABLE [dbo].[PaymentHistory] CHECK CONSTRAINT [FK_PaymentHistory_LoanAccounts]
GO
USE [master]
GO
ALTER DATABASE [HeThongTaiChinhDB] SET  READ_WRITE 
GO
