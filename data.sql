USE [master]
GO
/****** Object:  Database [HeThongTaiChinhDB]    Script Date: 3/20/2025 11:22:17 PM ******/
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
/****** Object:  Table [dbo].[ApprovalHistory]    Script Date: 3/20/2025 11:22:17 PM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 3/20/2025 11:22:17 PM ******/
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
 CONSTRAINT [PK__Customer__CD65CB853133D025] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepositAccounts]    Script Date: 3/20/2025 11:22:17 PM ******/
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
	[SpecializedAccountID] [int] NULL,
 CONSTRAINT [PK__DepositA__46A222CD4BFB454C] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinancialTransactions]    Script Date: 3/20/2025 11:22:17 PM ******/
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
/****** Object:  Table [dbo].[LoanAccounts]    Script Date: 3/20/2025 11:22:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoanAccounts](
	[loan_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [nvarchar](100) NOT NULL,
	[linked_deposit_account_id] [int] NULL,
	[loan_amount] [decimal](18, 2) NOT NULL,
	[approved_amount] [decimal](18, 2) NULL,
	[interest_rate] [decimal](5, 2) NULL,
	[loan_status] [varchar](50) NOT NULL,
	[payment_method] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[due_date] [date] NULL,
 CONSTRAINT [PK__LoanAcco__A1F7955431CB2F7E] PRIMARY KEY CLUSTERED 
(
	[loan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoanDocuments]    Script Date: 3/20/2025 11:22:17 PM ******/
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
/****** Object:  Table [dbo].[PaymentHistory]    Script Date: 3/20/2025 11:22:17 PM ******/
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
/****** Object:  Table [dbo].[SpecializedAccounts]    Script Date: 3/20/2025 11:22:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecializedAccounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountHolder] [nvarchar](100) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[AccountType] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/20/2025 11:22:17 PM ******/
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
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'0', N'minh', NULL, NULL, N'0912345610', NULL, N'030203007958')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'210321', N'Nguyễn Văn V', CAST(N'1983-10-22' AS Date), N'103 Điện Biên Phủ, Hà Nội', N'0920202020', N'nguyenvanv@example.com', N'111122233344')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'210322', N'Trần Thị W', CAST(N'1990-04-19' AS Date), N'104 Hoàng Quốc Việt, TP.HCM', N'0930303030', N'tranthiw@example.com', N'122233344455')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'210323', N'Lê Văn X', CAST(N'1992-06-29' AS Date), N'105 Phạm Ngọc Thạch, Đà Nẵng', N'0940404040', N'levanx@example.com', N'133344455566')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'210324', N'Phạm Thị Y', CAST(N'1989-09-07' AS Date), N'106 Nguyễn Xiển, Hải Phòng', N'0950505050', N'phamthiy@example.com', N'144455566677')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'210325', N'Hoàng Văn Z', CAST(N'1993-02-11' AS Date), N'107 Xã Đàn, Cần Thơ', N'0960606060', N'hoangvanz@example.com', N'155566677788')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240313', N'Lê Văn N', CAST(N'1995-05-05' AS Date), N'345 Lý Tự Trọng, Đà Nẵng', N'0933333333', N'levann@example.com', N'033344455566')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240314', N'Phạm Thị O', CAST(N'1989-09-12' AS Date), N'456 Bà Triệu, Hải Phòng', N'0944444444', N'phamthio@example.com', N'044455566677')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240315', N'Hoàng Văn P', CAST(N'1992-11-30' AS Date), N'567 Nguyễn Trãi, Cần Thơ', N'0955555555', N'hoangvanp@example.com', N'055566677788')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240316', N'Bùi Thị Q', CAST(N'1987-06-21' AS Date), N'678 Trần Phú, Huế', N'0966666666', N'buithiq@example.com', N'066677788899')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240317', N'Đỗ Văn R', CAST(N'1991-03-18' AS Date), N'789 Quang Trung, Đà Lạt', N'0977777777', N'dovanr@example.com', N'077788899900')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240318', N'Vũ Thị S', CAST(N'1985-12-09' AS Date), N'890 Nguyễn Huệ, Nha Trang', N'0988888888', N'vuthis@example.com', N'088899900011')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240319', N'Ngô Văn T', CAST(N'1996-01-25' AS Date), N'901 Hùng Vương, Vũng Tàu', N'0999999999', N'ngovant@example.com', N'099900011122')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240320', N'Đặng Thị U', CAST(N'1984-08-15' AS Date), N'102 Trần Quang Khải, Bình Dương', N'0910101010', N'dangthiu@example.com', N'100011122233')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240329', N'Nguyễn Văn L', CAST(N'1983-02-14' AS Date), N'123 Cách Mạng Tháng Tám, Hà Nội', N'0911111111', N'nguyenvanl@example.com', N'011122233344')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'240330', N'Trần Thị M', CAST(N'1990-07-23' AS Date), N'234 Nguyễn Văn Cừ, TP.HCM', N'0922222222', N'tranthim@example.com', N'022233344455')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250301', N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, Hà Nội', N'0912345678', N'nguyenvana@example.com', N'012345678901')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250302', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Trần Hưng Đạo, TP.HCM', N'0987654321', N'tranthib@example.com', N'123456789012')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250303', N'Lê Văn C', CAST(N'1992-11-30' AS Date), N'789 Hoàng Diệu, Đà Nẵng', N'0901122334', N'levanc@example.com', N'234567890123')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250304', N'Phạm Thị D', CAST(N'1995-03-25' AS Date), N'101 Phan Chu Trinh, Hải Phòng', N'0966778899', N'phamthid@example.com', N'345678901234')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250305', N'Hoàng Văn E', CAST(N'1988-07-15' AS Date), N'202 Nguyễn Du, Cần Thơ', N'0977554466', N'hoangvane@example.com', N'456789012345')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250306', N'Bùi Thị F', CAST(N'1993-09-10' AS Date), N'303 Hai Bà Trưng, Huế', N'0944332211', N'buithif@example.com', N'567890123456')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250307', N'Đỗ Văn G', CAST(N'1991-12-22' AS Date), N'404 Bạch Đằng, Đà Lạt', N'0933221100', N'dovang@example.com', N'678901234567')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250308', N'Vũ Thị H', CAST(N'1987-06-05' AS Date), N'505 Lý Thường Kiệt, Nha Trang', N'0922110099', N'vuthih@example.com', N'7890123')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250309', N'Ngô Văn I', CAST(N'1996-04-18' AS Date), N'606 Trường Chinh, Vũng Tàu', N'0911002233', N'ngovanii@example.com', N'890123456789')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250310', N'minh', NULL, NULL, N'0912345696', NULL, N'901234567890')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250311', N'minh', NULL, NULL, N'0912345610', NULL, N'030203007958')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250312', N'minh', NULL, N'21232sadsdsdasdas', N'0912345610', N'sdasdsada', N'030203007958')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250313', N'Phạm Minh1', CAST(N'2003-05-22' AS Date), N'Tòa Gemek 2, đường Lê Trọng Tấn, xã An Khánh', N'111111', N'alanpham2224@gmail.com', N'7890123')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250314', N'Nguyễn Văn V', NULL, NULL, N'0912345610', NULL, N'030203007958')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250315', N'Lê Văn X', NULL, NULL, N'0912345610', NULL, N'901234567890')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250401', N'Nguyễn Văn A', CAST(N'1990-05-12' AS Date), N'123 Lê Lợi, Hà Nội', N'0912345678', N'nguyenvana@example.com', N'012345678901')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250402', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Trần Hưng Đạo, TP.HCM', N'0987654321', N'tranthib@example.com', N'123456789012')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250403', N'Lê Văn C', CAST(N'1992-11-30' AS Date), N'789 Hoàng Diệu, Đà Nẵng', N'0901122334', N'levanc@example.com', N'234567890123')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250404', N'Phạm Thị D', CAST(N'1995-03-25' AS Date), N'101 Phan Chu Trinh, Hải Phòng', N'0966778899', N'phamthid@example.com', N'345678901234')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250405', N'Hoàng Văn E', CAST(N'1988-07-15' AS Date), N'202 Nguyễn Du, Cần Thơ', N'0977554466', N'hoangvane@example.com', N'456789012345')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250406', N'Bùi Thị F', CAST(N'1993-09-10' AS Date), N'303 Hai Bà Trưng, Huế', N'0944332211', N'buithif@example.com', N'567890123456')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250407', N'Đỗ Văn G', CAST(N'1991-12-22' AS Date), N'404 Bạch Đằng, Đà Lạt', N'0933221100', N'dovang@example.com', N'678901234567')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250408', N'Vũ Thị H', CAST(N'1987-06-05' AS Date), N'505 Lý Thường Kiệt, Nha Trang', N'0922110099', N'vuthih@example.com', N'789012345678')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250409', N'Ngô Văn I', CAST(N'1996-04-18' AS Date), N'606 Trường Chinh, Vũng Tàu', N'0911002233', N'ngovanii@example.com', N'890123456789')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250410', N'Đặng Thị K', CAST(N'1984-10-07' AS Date), N'707 Nguyễn Thái Học, Bình Dương', N'0909090909', N'dangthik@example.com', N'901234567890')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250411', N'Phan Văn M', CAST(N'1990-02-14' AS Date), N'808 Điện Biên Phủ, Đà Nẵng', N'0912233445', N'phanvanm@example.com', N'112233445566')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250412', N'Lý Thị N', CAST(N'1982-09-22' AS Date), N'909 Võ Văn Kiệt, TP.HCM', N'0988112233', N'lythin@example.com', N'223344556677')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250413', N'Tống Văn O', CAST(N'1994-06-30' AS Date), N'100 Nguyễn Huệ, Huế', N'0933445566', N'tongvano@example.com', N'334455667788')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250414', N'Cao Thị P', CAST(N'1986-12-10' AS Date), N'111 Hùng Vương, Hà Nội', N'0977223344', N'caothip@example.com', N'445566778899')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250415', N'Dương Văn Q', CAST(N'1997-05-08' AS Date), N'222 Cách Mạng Tháng 8, Đà Lạt', N'0909888777', N'duongvanq@example.com', N'556677889900')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250416', N'Huỳnh Thị R', CAST(N'1989-08-14' AS Date), N'333 Nguyễn Trãi, Hải Phòng', N'0922778899', N'huynhthir@example.com', N'667788990011')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250417', N'Kiều Văn S', CAST(N'1993-04-28' AS Date), N'444 Lê Văn Sỹ, Cần Thơ', N'0911667788', N'kieuvans@example.com', N'778899001122')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250418', N'Mai Thị T', CAST(N'1985-07-19' AS Date), N'555 Phạm Ngũ Lão, Bình Dương', N'0933556677', N'maithit@example.com', N'889900112233')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250419', N'Nguyễn Văn U', CAST(N'1991-03-05' AS Date), N'666 Tô Hiến Thành, Nha Trang', N'0955667788', N'nguyenvanu@example.com', N'990011223344')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250420', N'Phạm Thị V', CAST(N'1998-11-02' AS Date), N'777 Đinh Tiên Hoàng, Vũng Tàu', N'0966778899', N'phamthiv@example.com', N'001122334455')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250421', N'Trịnh Văn W', CAST(N'1990-06-25' AS Date), N'888 Lạc Long Quân, Hà Nội', N'0944556677', N'trinhvanw@example.com', N'112233445566')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250422', N'Lê Thị X', CAST(N'1992-09-13' AS Date), N'999 Hoàng Quốc Việt, TP.HCM', N'0911778899', N'lethix@example.com', N'223344556677')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250423', N'Vũ Văn Y', CAST(N'1987-10-01' AS Date), N'1000 Nguyễn Văn Cừ, Hải Phòng', N'0900998877', N'vuvany@example.com', N'334455667788')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250424', N'Đặng Thị Z', CAST(N'1984-07-22' AS Date), N'1100 Trần Phú, Cần Thơ', N'0988776655', N'dangthiz@example.com', N'445566778899')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'250425', N'Bùi Văn AA', CAST(N'1993-05-09' AS Date), N'1200 Lý Chính Thắng, Đà Lạt', N'0977665544', N'buivanaa@example.com', N'556677889900')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'V001', N'Nguyễn Văn A', CAST(N'1990-05-15' AS Date), N'123 Đường A, Hà Nội', N'0987654321', N'vana@example.com', N'123456789')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'V002', N'Trần Thị B', CAST(N'1985-08-20' AS Date), N'456 Đường B, TP.HCM', N'0912345678', N'thib@example.com', N'234567890')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'V003', N'Phạm Hữu C', CAST(N'1992-03-10' AS Date), N'789 Đường C, Đà Nẵng', N'0934567890', N'huuc@example.com', N'345678901')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'V004', N'Lê Hoàng D', CAST(N'1995-12-25' AS Date), N'159 Đường D, Hải Phòng', N'0978901234', N'hoangd@example.com', N'456789012')
INSERT [dbo].[Customers] ([customer_id], [full_name], [date_of_birth], [address], [phone], [email], [identity_number]) VALUES (N'V005', N'Đặng Minh E', CAST(N'1988-07-30' AS Date), N'753 Đường E, Cần Thơ', N'0956789012', N'minhe@example.com', N'567890123')
GO
SET IDENTITY_INSERT [dbo].[DepositAccounts] ON 

INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (1, N'250312', N'970412250001', N'tietkiem', CAST(1111111.00 AS Decimal(18, 2)), NULL, CAST(11.00 AS Decimal(5, 2)), CAST(N'2025-11-11T00:00:00.000' AS DateTime), NULL, N'Active', N'Bình Gia Branch', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (2, N'210321', N'100001', N'Ti?t ki?m k? h?n', CAST(5000000.00 AS Decimal(18, 2)), 12, CAST(5.50 AS Decimal(5, 2)), CAST(N'2023-01-01T00:00:00.000' AS DateTime), CAST(N'2024-01-01' AS Date), N'Active', N'Hà Nội', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (3, N'210322', N'100002', N'Ti?t ki?m không k? h?n', CAST(10000000.00 AS Decimal(18, 2)), 0, CAST(1.20 AS Decimal(5, 2)), CAST(N'2023-02-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Hồ Chí Minh', NULL)
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
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (21, N'250305', N'100020', N'Ti?t ki?m không k? h?n', CAST(4500000.00 AS Decimal(18, 2)), 0, CAST(1.50 AS Decimal(5, 2)), CAST(N'2024-07-01T00:00:00.000' AS DateTime), NULL, N'Active', N'Bắc Ninh', NULL)
INSERT [dbo].[DepositAccounts] ([account_id], [customer_id], [account_number], [account_type], [balance], [term], [interest_rate], [created_at], [maturity_date], [status], [branch], [SpecializedAccountID]) VALUES (22, N'250315', N'970420250001', N'cokyhan', CAST(10000000.00 AS Decimal(18, 2)), 12, CAST(5.00 AS Decimal(5, 2)), CAST(N'2003-05-22T00:00:00.000' AS DateTime), CAST(N'2004-05-22' AS Date), N'Active', N'Bình Gia Branch', 1)
SET IDENTITY_INSERT [dbo].[DepositAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[LoanAccounts] ON 

INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date]) VALUES (1, N'210323', NULL, CAST(120000.00 AS Decimal(18, 2)), NULL, NULL, N'Pending', N'Counter', CAST(N'2025-03-17T23:46:49.230' AS DateTime), NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date]) VALUES (2, N'240317', NULL, CAST(160000.00 AS Decimal(18, 2)), NULL, NULL, N'Pending', N'Counter', CAST(N'2025-03-17T23:54:22.003' AS DateTime), NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date]) VALUES (3, N'210323', NULL, CAST(100000.00 AS Decimal(18, 2)), NULL, NULL, N'Pending', N'Auto', CAST(N'2025-03-18T22:39:26.313' AS DateTime), NULL)
INSERT [dbo].[LoanAccounts] ([loan_id], [customer_id], [linked_deposit_account_id], [loan_amount], [approved_amount], [interest_rate], [loan_status], [payment_method], [created_at], [due_date]) VALUES (4, N'210323', NULL, CAST(10000000.00 AS Decimal(18, 2)), NULL, NULL, N'Pending', N'Auto', CAST(N'2025-03-20T21:45:40.133' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LoanAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[SpecializedAccounts] ON 

INSERT [dbo].[SpecializedAccounts] ([AccountId], [AccountHolder], [Balance], [AccountType]) VALUES (1, N'Minh', CAST(0.00 AS Decimal(18, 2)), N'NhanLai')
SET IDENTITY_INSERT [dbo].[SpecializedAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password_hash], [role], [created_at]) VALUES (1, N'admin', N'1111', N'Dealer', CAST(N'2025-11-03T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DepositA__AF91A6AD04AC356C]    Script Date: 3/20/2025 11:22:17 PM ******/
ALTER TABLE [dbo].[DepositAccounts] ADD  CONSTRAINT [UQ__DepositA__AF91A6AD04AC356C] UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572509CA5EA]    Script Date: 3/20/2025 11:22:17 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApprovalHistory] ADD  DEFAULT (getdate()) FOR [approval_date]
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
ALTER TABLE [dbo].[LoanDocuments] ADD  DEFAULT (getdate()) FOR [submitted_date]
GO
ALTER TABLE [dbo].[PaymentHistory] ADD  DEFAULT (getdate()) FOR [payment_date]
GO
ALTER TABLE [dbo].[SpecializedAccounts] ADD  DEFAULT ((0)) FOR [Balance]
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
