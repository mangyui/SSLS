USE [master]
GO
/****** Object:  Database [Library]    Script Date: 12/24/2018 22:35:20 ******/
CREATE DATABASE [Library] ON  PRIMARY 
( NAME = N'Library', FILENAME = N'D:\database\mydata.mdf' , SIZE = 3072KB , MAXSIZE = 6144KB , FILEGROWTH = 2048KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'D:\database\mydata_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048KB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Library] SET ARITHABORT OFF
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Library] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Library] SET  READ_WRITE
GO
ALTER DATABASE [Library] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Library] SET  MULTI_USER
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF
GO
USE [Library]
GO
/****** Object:  Table [dbo].[Reader]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reader](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Reader] ON
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (1, N'123456', N'mangyu', N'计科162', N'123456@qq.com', N'123456', CAST(527.14 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (4, N'112233', N'1号读者', N'A班', N'112233@qq.com', N'112233', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (5, N'445566', N'Mike', N'计算机162', N'445566@qq.com', N'445566', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (6, N'181215', N'星期六', N'计算机162', N'181215@qq.com', N'181215', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (7, N'181221', N'周五先生', N'计算机162', N'181221@qq.com', N'181221', CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (8, N'181222', N'一修', N'计算机162', N'181222@qq.com', N'181222', CAST(0.48 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (9, N'181223', N'盲鱼', N'计算机162', N'181223@qq.com', N'181223', CAST(1000.00 AS Decimal(18, 2)))
INSERT [dbo].[Reader] ([Id], [Code], [Name], [Class], [Email], [Password], [Price]) VALUES (10, N'181224', N'老六', N'计算机', N'181224@qq.com', N'181224', CAST(32.10 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Reader] OFF
/****** Object:  Table [dbo].[Admin]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON
INSERT [dbo].[Admin] ([Id], [UserName], [Password]) VALUES (1, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[Admin] OFF
/****** Object:  Table [dbo].[Category]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (1, N'10001', N'文学', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (2, N'10002', N'励志', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (3, N'10003', N'小说', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (4, N'10004', N'少儿', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (5, N'10005', N'历史', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (6, N'10006', N'技术', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (7, N'10007', N'期刊', NULL)
INSERT [dbo].[Category] ([Id], [Code], [Name], [Description]) VALUES (9, N'112233', N'测试', N'bndasda')
SET IDENTITY_INSERT [dbo].[Category] OFF
/****** Object:  Table [dbo].[Borrow]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reader_ID] [int] NOT NULL,
	[Book_ID] [int] NOT NULL,
	[BorrowDate] [datetime] NOT NULL,
	[ShouldDate] [datetime] NOT NULL,
	[ReturnDate] [datetime] NULL,
	[Renew] [nvarchar](100) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Borrow] ON
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (11, 1, 38, CAST(0x0000A99B00E5684C AS DateTime), CAST(0x0000A9B900E5684C AS DateTime), CAST(0x0000A99B0130848B AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (12, 1, 41, CAST(0x0000A99B00E5685B AS DateTime), CAST(0x0000A9D800E5685B AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (13, 5, 30, CAST(0x0000A99B0163E6BF AS DateTime), CAST(0x0000A9B90163E6BF AS DateTime), CAST(0x0000A9BF01592E7C AS DateTime), N'否', N'超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (14, 1, 42, CAST(0x0000A99D01676593 AS DateTime), CAST(0x0000A9BB01676593 AS DateTime), CAST(0x0000A99D016E2ED2 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (15, 1, 37, CAST(0x0000A99D01735F34 AS DateTime), CAST(0x0000A9BB01735F34 AS DateTime), CAST(0x0000A99E01676CC3 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (16, 1, 25, CAST(0x0000A99D01735F38 AS DateTime), CAST(0x0000A9BB01735F38 AS DateTime), CAST(0x0000A99E0168C674 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (17, 1, 16, CAST(0x0000A99E01682B2C AS DateTime), CAST(0x0000A9DB01682B2C AS DateTime), CAST(0x0000A99E0177AE29 AS DateTime), N'是', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (18, 1, 31, CAST(0x0000A99E01682B2F AS DateTime), CAST(0x0000A9BC01682B2F AS DateTime), CAST(0x0000A99E01694596 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (19, 1, 10, CAST(0x0000A99E0169589A AS DateTime), CAST(0x0000A9BC0169589A AS DateTime), CAST(0x0000A99E016C7AD6 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (20, 1, 42, CAST(0x0000A99E016B299B AS DateTime), CAST(0x0000A9BC016B299B AS DateTime), CAST(0x0000A99E016CA79D AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (21, 1, 9, CAST(0x0000A99E016B29AA AS DateTime), CAST(0x0000A9BC016B29AA AS DateTime), CAST(0x0000A99E016C7FA8 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (22, 1, 23, CAST(0x0000A961016CEFB9 AS DateTime), CAST(0x0000A97F016CEFB9 AS DateTime), CAST(0x0000A99F01563F8E AS DateTime), N'否', N'超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (23, 1, 18, CAST(0x0000A99E016CEFB9 AS DateTime), CAST(0x0000A9BC016CEFB9 AS DateTime), CAST(0x0000A99E0171BD29 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (24, 1, 39, CAST(0x0000A99E01772F9B AS DateTime), CAST(0x0000A9BC01772F9B AS DateTime), CAST(0x0000A99E0177B232 AS DateTime), N'否', N'已归还')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (25, 1, 35, CAST(0x0000A97F01772F9E AS DateTime), CAST(0x0000A99E01772F9E AS DateTime), CAST(0x0000A9A901396429 AS DateTime), N'否', N'超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (26, 1, 32, CAST(0x0000A99F0175B1B6 AS DateTime), CAST(0x0000A9BD0175B1B6 AS DateTime), CAST(0x0000A9A101665F69 AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (27, 1, 15, CAST(0x0000A99F0175B1BB AS DateTime), CAST(0x0000A9800175B1BB AS DateTime), CAST(0x0000A9AC01444343 AS DateTime), N'是', N'超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (28, 1, 42, CAST(0x0000A9A101643BAA AS DateTime), CAST(0x0000A9DE01643BAA AS DateTime), CAST(0x0000A9BE012E1EC6 AS DateTime), N'是', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (29, 1, 38, CAST(0x0000A9A101643BB2 AS DateTime), CAST(0x0000A9BF01643BB2 AS DateTime), CAST(0x0000A9A10167BD45 AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (30, 1, 14, CAST(0x0000A9AC01553572 AS DateTime), CAST(0x0000A9E901553572 AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (31, 4, 28, CAST(0x0000A9B5015865C2 AS DateTime), CAST(0x0000A9D4015865C2 AS DateTime), NULL, N'否', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (32, 4, 34, CAST(0x0000A9B5015865CB AS DateTime), CAST(0x0000A9D4015865CB AS DateTime), NULL, N'否', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (33, 6, 29, CAST(0x0000A9B7018857FA AS DateTime), CAST(0x0000A9D6018857FA AS DateTime), NULL, N'否', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (34, 6, 33, CAST(0x0000A9B701885802 AS DateTime), CAST(0x0000A9D601885802 AS DateTime), CAST(0x0000A9B80000803F AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (35, 6, 18, CAST(0x0000A9B701885804 AS DateTime), CAST(0x0000A9D601885804 AS DateTime), NULL, N'否', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (36, 7, 9, CAST(0x0000A9BD0169AC5C AS DateTime), CAST(0x0000A9DB0169AC5C AS DateTime), CAST(0x0000A9BD0169ECBA AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (37, 7, 8, CAST(0x0000A9BD0169AC5E AS DateTime), CAST(0x0000A9F90169AC5E AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (38, 8, 22, CAST(0x0000A9BF0117B3D0 AS DateTime), CAST(0x0000A9DD0117B3D0 AS DateTime), CAST(0x0000A9BF0117C7D4 AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (39, 8, 11, CAST(0x0000A9BF0117B3D0 AS DateTime), CAST(0x0000A9FB0117B3D0 AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (40, 9, 22, CAST(0x0000A9BF011D46CC AS DateTime), CAST(0x0000A9DD011D46CC AS DateTime), CAST(0x0000A9BF011D5A2C AS DateTime), N'否', N'未超期')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (41, 9, 16, CAST(0x0000A9BF011D46CC AS DateTime), CAST(0x0000A9FB011D46CC AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (42, 10, 36, CAST(0x0000A9C0017200A0 AS DateTime), CAST(0x0000A9FC017200A0 AS DateTime), NULL, N'是', N'在借')
INSERT [dbo].[Borrow] ([Id], [Reader_ID], [Book_ID], [BorrowDate], [ShouldDate], [ReturnDate], [Renew], [State]) VALUES (43, 10, 9, CAST(0x0000A9C0017200A1 AS DateTime), CAST(0x0000A9DE017200A1 AS DateTime), CAST(0x0000A9C00172122E AS DateTime), N'否', N'未超期')
SET IDENTITY_INSERT [dbo].[Borrow] OFF
/****** Object:  Table [dbo].[Fine]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Borrow_ID] [int] NOT NULL,
	[Reader_ID] [int] NOT NULL,
	[OverDays] [int] NOT NULL,
	[Payment] [decimal](18, 2) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Fine] ON
INSERT [dbo].[Fine] ([Id], [Borrow_ID], [Reader_ID], [OverDays], [Payment], [State]) VALUES (1, 22, 1, 31, CAST(31.00 AS Decimal(18, 2)), N'已缴纳')
INSERT [dbo].[Fine] ([Id], [Borrow_ID], [Reader_ID], [OverDays], [Payment], [State]) VALUES (2, 25, 1, 10, CAST(10.00 AS Decimal(18, 2)), N'已缴纳')
INSERT [dbo].[Fine] ([Id], [Borrow_ID], [Reader_ID], [OverDays], [Payment], [State]) VALUES (3, 27, 1, 43, CAST(43.00 AS Decimal(18, 2)), N'已缴纳')
INSERT [dbo].[Fine] ([Id], [Borrow_ID], [Reader_ID], [OverDays], [Payment], [State]) VALUES (4, 13, 5, 5, CAST(5.00 AS Decimal(18, 2)), N'待缴纳')
SET IDENTITY_INSERT [dbo].[Fine] OFF
/****** Object:  Table [dbo].[Book]    Script Date: 12/24/2018 22:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Authors] [nvarchar](100) NOT NULL,
	[Press] [nvarchar](100) NULL,
	[ImageUrl] [nvarchar](1000) NULL,
	[Description] [nvarchar](2000) NULL,
	[PublishDate] [datetime] NULL,
	[Price] [decimal](18, 2) NULL,
	[Status] [nvarchar](100) NULL,
	[Category_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (1, N'21001', N'浮生六记', N'沈复', N' 辽宁大学出版社', N'/PImages/wx_fslj.jpg', N'我们要学会用美的眼光，去发现周遭的一切”著名主持人汪涵念念不忘反复在节目中向观众推荐的一本书！本版白话精心译述，民国本精', CAST(0x0000A4E700000000 AS DateTime), CAST(21.00 AS Decimal(18, 2)), N'未在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (2, N'21002', N'平凡的世界（全三册）', N'路遥', N' 北京十月文艺出版社', N'/PImages/wx_pfdsj.jpg', N'这是一部现实主义小说，也是小说化的家族史。作家高度浓缩了中国西北农村的历史变迁过程，作品达到了思想性与艺术性的高度统一，特别是主人公面对困境艰苦奋斗的精神，对今天的大学生朋友仍有启迪。', CAST(0x0000A28700000000 AS DateTime), CAST(45.00 AS Decimal(18, 2)), N'在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (3, N'21003', N'假如给我3天光明', N'凯勒', N'北方文艺出版社', N'/PImages/wx_jrgw3tgm.jpg', N'假如给我3天光明(全译本) 原著 无删减 海伦凯勒著 世界文学名著 青少年版学生版世界名著 初高中生课外书籍', CAST(0x0000A14300000000 AS DateTime), CAST(18.00 AS Decimal(18, 2)), N'在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (4, N'21004', N'鲁滨逊漂流记', N'(英)丹尼尔·笛福', N'陕西师范大学出版社', N'/PImages/wx_lbxplj.jpg', N'震撼欧洲文学史的惊世作品，倾注了梦想与勇气的冒险之旅，充满理想与拼搏精神的孤胆勇士。', CAST(0x0000A10600000000 AS DateTime), CAST(15.50 AS Decimal(18, 2)), N'在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (5, N'21005', N'朝花夕拾', N'鲁迅', N'中国文联出版社', N'/PImages/wx_zhxs.jpg', N'朝花夕拾 鲁迅作品 含朝花夕拾、野草及生平年表 鲁迅散文集 鲁迅散文诗集 教育部新课标推荐数目 中国现当代文学名著', CAST(0x0000A5C600000000 AS DateTime), CAST(14.50 AS Decimal(18, 2)), N'在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (6, N'21006', N'围城', N' 钱钟书', N'人民文学出版社', N'/PImages/wx_wc.jpg', N'钱锺书所著的《围城》是一幅栩栩如生的世井百态图，人生的酸甜苦辣千般滋味均在其中得到了淋漓尽致的体现。', CAST(0x000081FE00000000 AS DateTime), CAST(23.80 AS Decimal(18, 2)), N'未在库', 1)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (7, N'22001', N'羊皮卷全集', N'曼狄诺编', N'中国妇女出版社', N'/PImages/lz_ypjqj.jpg', N'成功圣经，每一个积极向上的人都应该要读的书，它揭示了希望、财富、成功...', CAST(0x0000A41300000000 AS DateTime), CAST(25.20 AS Decimal(18, 2)), N'在库', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (8, N'22002', N'人性的弱点', N' 戴尔·卡耐基著', N'浙江文艺出版社', N'/PImages/lz_rxdld.jpg', N'帮你迅速提升情商和谈话技巧的经典！全新畅销译本，未作任何增删！完整囊括人际关系的... ', CAST(0x0000A6EE00000000 AS DateTime), CAST(31.80 AS Decimal(18, 2)), N'外借', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (9, N'22003', N'厚黑学正版全集', N'李宗吾', N' 九州出版社', N'/PImages/lz_hhxqj.jpg', N'厚黑学正版全集 李宗吾原著成功学说话办事经商职场管理厚黑学全集 鬼谷子塔木德正能量人际关系小说创业书籍励志成功书籍', CAST(0x00009B8E00000000 AS DateTime), CAST(35.20 AS Decimal(18, 2)), N'在库', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (10, N'22004', N'钢铁是怎样炼成的', N'列夫托尔斯泰著', N'中国文联出版社', N'/PImages/lz_gtszylcd.jpg', N'世界经典文学名著小说畅销书籍', CAST(0x0000A10600000000 AS DateTime), CAST(16.80 AS Decimal(18, 2)), N'在库', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (11, N'22005', N'将来的你', N'黎芫', N'天津人民出版社', N'/PImages/lz_jldn.jpg', N'将来的你一定会感谢现在拼命的自己 青少年成功正能量青春励志文学小说心灵鸡汤人生哲学女性汤木畅销书籍', CAST(0x0000A72900000000 AS DateTime), CAST(29.80 AS Decimal(18, 2)), N'外借', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (12, N'22006', N'摆渡人', N'[英]克莱儿·麦克福尔', N'百花洲文艺出版社', N'/PImages/lz_bdr.jpg', N'如果命运是一条孤独的河流，谁会是你灵魂的摆渡人？', CAST(0x0000A4AA00000000 AS DateTime), CAST(25.80 AS Decimal(18, 2)), N'在库', 2)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (13, N'23001', N'从你的全世界路过', N' 张嘉佳', N' 湖南文艺出版社', N'/PImages/xs_cndqsjlg.jpg', N'让所有人心动的故事...', CAST(0x0000A26900000000 AS DateTime), CAST(23.80 AS Decimal(18, 2)), N'在库', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (14, N'23002', N'活着', N'余华', N'作家出版社', N'/PImages/xs_hz.jpg', N'《活着》讲述了农村人福贵悲惨的人生遭遇。福贵本是个阔少爷，可他嗜赌如命，终于赌光了家业，一贫如洗... ', CAST(0x0000A0A000000000 AS DateTime), CAST(31.80 AS Decimal(18, 2)), N'外借', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (15, N'23003', N'了不起的盖茨比', N'菲茨杰拉德', N'北方文艺出版社', N'/PImages/xs_lbqdgcb.jpg', N'小说通过完美的艺术形式，描写了20年代贩酒暴 发户盖茨比所追求的“美国梦”的幻灭，揭示了美国社会的悲剧。', CAST(0x00009FD500000000 AS DateTime), CAST(35.20 AS Decimal(18, 2)), N'在库', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (16, N'23004', N'解忧杂货店', N'东野圭吾', N'作者出版社', N'/PImages/xs_jyzhd.jpg', N'他们将困惑写成信投进杂货店，奇妙的事情随即不断发生。生命中的一次偶然交会，将如何演绎出截然不同的人生？', CAST(0x0000A31E00000000 AS DateTime), CAST(37.80 AS Decimal(18, 2)), N'外借', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (17, N'23005', N'人生', N'路遥', N'北京十月文艺出版社', N'/PImages/xs_rs.jpg', N'改革时期陕北高原的城乡生活为时空背景，叙述了高中毕业生高加林回到土地又离开土地，再回到土地这样人生的变化过程。', CAST(0x0000A00700000000 AS DateTime), CAST(17.00 AS Decimal(18, 2)), N'在库', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (18, N'23006', N'假面前夜', N'东野圭吾', N'作者出版社', N'/PImages/xs_jmqy.jpg', N'是保护假面，还是揭开假面，尚是职场新人的酒店前台山岸尚美和年轻的刑警新田浩介会如何应对？4个发人深省的故事将给出答案。', CAST(0x0000A5BB00000000 AS DateTime), CAST(30.50 AS Decimal(18, 2)), N'外借', 3)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (19, N'24001', N'蚯蚓的日记', N'(美)朵琳·克罗宁著', N'明天出版社', N'/PImages/sr_qydrj.jpg', N'蚯蚓的日记绘本信谊绘本蚯蚓日记儿童绘本0-3-4-6周岁幼儿书籍图书幼儿园图画书宝宝启蒙故事书', CAST(0x0000A19300000000 AS DateTime), CAST(16.80 AS Decimal(18, 2)), N'在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (20, N'24002', N'格林童话', N'[德]雅各布·格林', N'外语教学与研究出版社', N'/PImages/sr_glth.jpg', N'这些童话故事语言质朴，情节明快，含义深刻。孩子们在阅读这些童话的时候，就像在聆听老奶奶讲故事一样，能从中感受到19世纪人们的精神世界。', CAST(0x00009FCB00000000 AS DateTime), CAST(11.80 AS Decimal(18, 2)), N'在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (21, N'24003', N'童谣三百首', N'匿名', N'安徽少年儿童出版社', N'/PImages/sr_ty300s.jpg', N'童谣文字简单、富含韵律、易学易记、朗朗上口，是非常符合儿童阅读特点和审美心理的文学形式。', CAST(0x0000A43200000000 AS DateTime), CAST(17.80 AS Decimal(18, 2)), N'未在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (22, N'24004', N'安徒生童话', N'安徒生', N'新世纪出版社', N'/PImages/sr_atsth.jpg', N'为孩子营造属于他们的童话世界 ', CAST(0x0000A39900000000 AS DateTime), CAST(18.80 AS Decimal(18, 2)), N'在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (23, N'24005', N'一千零一夜', N'佚名', N'新世纪出版社', N'/PImages/sr_1001y.jpg', N'为孩子营造属于他们的童话世界 ', CAST(0x0000A39900000000 AS DateTime), CAST(18.80 AS Decimal(18, 2)), N'在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (24, N'24006', N'伊索寓言', N'伊索', N'新世纪出版社', N'/PImages/sr_ysyy.jpg', N'为孩子营造属于他们的童话世界 ', CAST(0x0000A39900000000 AS DateTime), CAST(18.80 AS Decimal(18, 2)), N'在库', 4)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (25, N'25001', N'第二次世界大战全史', N'白虹', N'中国华侨出版社', N'/PImages/ls_2z.jpg', N'回顾战争，重温那段血与火的历史，不仅可以丰富历史知识，还能够以史为鉴，吸取教训，继而深入探讨战争与和平这一人类历史的永恒主题。', CAST(0x0000A58000000000 AS DateTime), CAST(21.50 AS Decimal(18, 2)), N'在库', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (26, N'25002', N'中国通史', N'梦华', N'中国华侨出版社', N'/PImages/ls_zgts.jpg', N'这是一本讲述中国历史的读物，全面反映了从传说时代到清朝灭亡的历史全景，同时书中还设置了中国大事记、世界大事记等多个知识板块。', CAST(0x0000A58000000000 AS DateTime), CAST(21.50 AS Decimal(18, 2)), N'在库', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (27, N'25003', N'资治通鉴', N'司马光', N'北方妇女儿童出版社', N'/PImages/ls_zztj.jpg', N'《资治通鉴》是我国古代著名历史学家、政治家司马光和他的助手历时十九年编纂的一部规模空前的编年体通史巨著。', CAST(0x0000A41300000000 AS DateTime), CAST(14.80 AS Decimal(18, 2)), N'在库', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (28, N'25004', N'这个历史挺靠谱', N'袁腾飞', N'湖南人民出版社', N'/PImages/ls_zglstkp.jpg', N'《历史是个什么玩意儿》系列的升级珍藏版。本系列开启全民读史新潮流，自问世以来畅销至今', CAST(0x0000A1EE00000000 AS DateTime), CAST(62.70 AS Decimal(18, 2)), N'外借', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (29, N'25005', N'史记', N'司马迁', N'中国华侨出版社', N'/PImages/ls_sj.jpg', N'精选了其中*具代表性且*精彩的篇章辑录成书，并绘制了大量精美插图，力求更加真实、直观、全面地将中国历史的丰富与精彩呈现在读者面前', CAST(0x0000A3B700000000 AS DateTime), CAST(29.80 AS Decimal(18, 2)), N'外借', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (30, N'25006', N'一本书读完历代趣闻轶事', N'张平', N'北京联合出版公司', N'/PImages/ls_ybs.jpg', N'以知识性和趣味性为宗旨，全方位、多角度地展示了先秦到民国时期*有研究价值和*为人们所关注的趣闻轶事', CAST(0x0000A3D600000000 AS DateTime), CAST(26.80 AS Decimal(18, 2)), N'在库', 5)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (31, N'26001', N'机器学习项目开发实践', N' [美]马蒂亚斯·布兰德温德尔', N'人民邮电出版社', N'/PImages/js_jqxx.jpg', N'对本书的阅读，读者无须接触枯燥的数学知识，便可快速上手，为日后的开发工作打下坚实的基础', CAST(0x0000A58000000000 AS DateTime), CAST(21.50 AS Decimal(18, 2)), N'在库', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (32, N'26002', N'深度学习-方法及应用', N'谢磊', N'技术出版社', N'/PImages/js_sdxx.jpg', N'这本书对深度学习方法以及它在各种信号与信息处理任务中的应用进行了概述', CAST(0x0000A5DB00000000 AS DateTime), CAST(31.80 AS Decimal(18, 2)), N'在库', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (33, N'26003', N'编程珠玑', N'[美]乔恩·本特利', N'人民邮电出版社', N'/PImages/js_bczj.jpg', N'本书的特色是通过一些精心设计的有趣而又颇具指导意义的程序，对实用程序设计技巧及基本设计原则进行了透彻而睿智的描述。', CAST(0x0000A41300000000 AS DateTime), CAST(37.40 AS Decimal(18, 2)), N'在库', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (34, N'26004', N'Java从入门到精通', N'明日科技', N'清华大学出版社', N'/PImages/js_java.jpg', N'从初学者角度出发，通过通俗易懂的语言、丰富多彩的实例，详细介绍了使用Java语言进行程序开发需要掌握的知识。', CAST(0x0000A0BF00000000 AS DateTime), CAST(52.60 AS Decimal(18, 2)), N'外借', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (35, N'26005', N'从应用到创新', N'陈皓', N'电子工业出版社', N'/PImages/js_cyydcx.jpg', N'手机硬件研发与设计 本书是由一线工程师撰写的详细阐述手机硬件研发与设计的专业图书', CAST(0x0000A69200000000 AS DateTime), CAST(78.20 AS Decimal(18, 2)), N'在库', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (36, N'26006', N'从0到1', N' 彼得蒂尔|布莱克马斯特斯', N'中信出版社', N'/PImages/js_c0d1.jpg', N'开启商业与未来的秘密 一位传奇的创投教父，一部开启秘密的商业之作，一部事关所有人的生存哲学 ', CAST(0x0000A42F00000000 AS DateTime), CAST(27.00 AS Decimal(18, 2)), N'外借', 6)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (37, N'27001', N'读懂互联网+', N'马云|曾鸣|高红冰', N'中信出版社', N'/PImages/qk_ddhlw.jpg', N'由马云、曾鸣、高红冰、金建杭、周其仁等著,集合了国内**的企业家、学者 从其自身长期从事的行业、研究出发，结合实践经验 和理论研究，描绘出清晰而全面的经济发展趋势。一 本书读懂“互联网+”。', CAST(0x0000A4C800000000 AS DateTime), CAST(35.50 AS Decimal(18, 2)), N'在库', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (38, N'27002', N'枪炮、病菌与钢铁', N'戴蒙德', N'上海译文出版社', N'/PImages/qk_qbg.jpg', N'在这部开创性的著作中，演化生物学家、人类学家贾雷德戴蒙德揭示了事实上有助于形成历史最广泛模式的环境因素，从而以震撼人心的力量摧毁了以种族主义为基础的人类史理论。', CAST(0x0000A63600000000 AS DateTime), CAST(31.80 AS Decimal(18, 2)), N'在库', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (39, N'27003', N'影响力', N' (美)罗伯特', N'北京联合出版公司', N'/PImages/qk_yxl.jpg', N'隐藏在冲动地顺从他人行为背后的6大心理秘笈，正是这一切的根源。那些劝说高手们，总是熟练地运用它们，让我们就范。', CAST(0x0000A67400000000 AS DateTime), CAST(49.00 AS Decimal(18, 2)), N'在库', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (40, N'27004', N'阿米巴经营', N'(日)森田直行', N'机械工业出版社', N'/PImages/qk_ambjy.jpg', N'介绍了阿米巴经营的实战方法和案例，帮助企业将人的潜力无限地激发出来。', CAST(0x0000A4C800000000 AS DateTime), CAST(23.00 AS Decimal(18, 2)), N'未在库', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (41, N'27005', N'岁月静好,不忘初心', N'林清玄', N'北京联合出版公司', N'/PImages/qk_syjh.jpg', N'本书是著名作家林清玄的一本哲理散文集。单纯的文字，高远的思想，字里行间中充满着人生感悟。作者借日常生活中平淡无奇的小事向读者展示出平等无私的大智慧。', CAST(0x0000A6CF00000000 AS DateTime), CAST(27.20 AS Decimal(18, 2)), N'外借', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (42, N'4564564', N'销售就是要玩转情商', N'科林斯坦利', N'武汉出版社', N'/PImages/2018122306121866E5.jpg', N'99%的人都不知道的销售软技巧,本书从情商出发，将销售行业中常见的销售渠道、客户心理、客户维护、谈判技巧、团队管理等问题都做了详尽的阐述，并给出了行之有效的指导方法。', CAST(0x0000A51100000000 AS DateTime), CAST(25.80 AS Decimal(18, 2)), N'在库', 7)
INSERT [dbo].[Book] ([Id], [Code], [Name], [Authors], [Press], [ImageUrl], [Description], [PublishDate], [Price], [Status], [Category_ID]) VALUES (44, N'121519', N'测试图书15', N'测试', N'测试出版社', N'/PImages/201812150733366353.jpg', N'测试时阿斯顿', CAST(0x0000A9BD00000000 AS DateTime), CAST(66.00 AS Decimal(18, 2)), N'未在库', 9)
SET IDENTITY_INSERT [dbo].[Book] OFF
/****** Object:  Default [DF__Reader__Price__0AD2A005]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Reader] ADD  CONSTRAINT [DF__Reader__Price__0AD2A005]  DEFAULT ((0.00)) FOR [Price]
GO
/****** Object:  Check [CK__Borrow__Renew__060DEAE8]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD CHECK  (([Renew]='否' OR [Renew]='是'))
GO
/****** Object:  ForeignKey [FK_Category_Category]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([Id])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
/****** Object:  ForeignKey [FK__Borrow__Book_ID__0519C6AF]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Book] ([Id])
GO
/****** Object:  ForeignKey [FK__Borrow__Reader_I__0425A276]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD FOREIGN KEY([Reader_ID])
REFERENCES [dbo].[Reader] ([Id])
GO
/****** Object:  ForeignKey [FK__Fine__Borrow_ID__08EA5793]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Fine]  WITH CHECK ADD FOREIGN KEY([Borrow_ID])
REFERENCES [dbo].[Borrow] ([Id])
GO
/****** Object:  ForeignKey [FK__Fine__Reader_ID__09DE7BCC]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Fine]  WITH CHECK ADD FOREIGN KEY([Reader_ID])
REFERENCES [dbo].[Reader] ([Id])
GO
/****** Object:  ForeignKey [FK__Book__Category_I__7F60ED59]    Script Date: 12/24/2018 22:35:21 ******/
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([Category_ID])
REFERENCES [dbo].[Category] ([Id])
GO
