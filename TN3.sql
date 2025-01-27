USE [TN]
GO
/****** Object:  User [HTKN]    Script Date: 11/21/2019 4:57:37 PM ******/
CREATE USER [HTKN] FOR LOGIN [HTKN] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [TH101]    Script Date: 11/21/2019 4:57:37 PM ******/
CREATE USER [TH101] FOR LOGIN [TH101] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Coso]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [Coso]
GO
/****** Object:  DatabaseRole [Giangvien]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [Giangvien]
GO
/****** Object:  DatabaseRole [MSmerge_1EEBFCB6EA4E41799F849035FD41F42B]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_1EEBFCB6EA4E41799F849035FD41F42B]
GO
/****** Object:  DatabaseRole [MSmerge_81463FEA6F724321AB59E4249DE40B2E]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_81463FEA6F724321AB59E4249DE40B2E]
GO
/****** Object:  DatabaseRole [MSmerge_AA7672B33B1A4F27862302996161D57A]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_AA7672B33B1A4F27862302996161D57A]
GO
/****** Object:  DatabaseRole [MSmerge_B1BDAFB005B64885A335492DF1C133DF]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_B1BDAFB005B64885A335492DF1C133DF]
GO
/****** Object:  DatabaseRole [MSmerge_D889CD27DCCF41B4BD6CFDCE7EEF0D84]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_D889CD27DCCF41B4BD6CFDCE7EEF0D84]
GO
/****** Object:  DatabaseRole [MSmerge_F7E836B1E2C94792ADAAB2556846CA54]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_F7E836B1E2C94792ADAAB2556846CA54]
GO
/****** Object:  DatabaseRole [MSmerge_PAL_role]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [MSmerge_PAL_role]
GO
/****** Object:  DatabaseRole [Sinhvien]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [Sinhvien]
GO
/****** Object:  DatabaseRole [Truong]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE ROLE [Truong]
GO
ALTER ROLE [db_owner] ADD MEMBER [HTKN]
GO
ALTER ROLE [Giangvien] ADD MEMBER [TH101]
GO
ALTER ROLE [db_owner] ADD MEMBER [TH101]
GO
ALTER ROLE [db_owner] ADD MEMBER [Coso]
GO
ALTER ROLE [db_owner] ADD MEMBER [Giangvien]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_1EEBFCB6EA4E41799F849035FD41F42B]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_81463FEA6F724321AB59E4249DE40B2E]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_AA7672B33B1A4F27862302996161D57A]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_B1BDAFB005B64885A335492DF1C133DF]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_D889CD27DCCF41B4BD6CFDCE7EEF0D84]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_F7E836B1E2C94792ADAAB2556846CA54]
GO
ALTER ROLE [db_owner] ADD MEMBER [Sinhvien]
GO
/****** Object:  Schema [MSmerge_PAL_role]    Script Date: 11/21/2019 4:57:38 PM ******/
CREATE SCHEMA [MSmerge_PAL_role]
GO
/****** Object:  UserDefinedFunction [dbo].[checkMH]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[checkMH](@maMH nchar(5))

RETURNS VARCHAR(50) 
AS

BEGIN



DECLARE @checked VARCHAR(50);
DECLARE  @len INT = 0;

 SELECT @len = COUNT(*) FROM BANGDIEM WHERE BANGDIEM.DIEM IS NOT NULL AND BANGDIEM.MAMH=@maMH;

IF @len > 0
 SET @checked = 'X';
 ELSE
 SET @checked = '';

RETURN @checked;

END;
GO
/****** Object:  UserDefinedFunction [dbo].[Num2Text]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Num2Text](@Number float)
RETURNS nvarchar(4000) AS 
BEGIN
	DECLARE @sNumber nvarchar(4000)
	DECLARE @Return	nvarchar(4000)
	DECLARE @mLen int
	DECLARE @i int

	DECLARE @mDigit char(1)
	DECLARE @mTemp nvarchar(4000)
	DECLARE @mNumText nvarchar(4000)

	SELECT @sNumber=LTRIM(cast(@Number as nvarchar))
	SELECT @mLen = Len(@sNumber)

	if @mLen =2
		BEGIN
			SELECT @Return = N'Mười'
			RETURN @Return
		END
	SELECT @i=1
	SELECT @mTemp=''

	WHILE @i <= @mLen
		BEGIN

		SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)

		IF @mDigit='0' SELECT @mNumText=N'không'
		ELSE
			BEGIN
			IF @mDigit='1' SELECT @mNumText=N'một'
			ELSE
			IF @mDigit='2' SELECT @mNumText=N'hai'
			ELSE
			IF @mDigit='3' SELECT @mNumText=N'ba'
			ELSE
			IF @mDigit='4' SELECT @mNumText=N'bốn'
			ELSE
			IF @mDigit='5' SELECT @mNumText=N'năm'
			ELSE
			IF @mDigit='6' SELECT @mNumText=N'sáu'
			ELSE
			IF @mDigit='7' SELECT @mNumText=N'bảy'
			ELSE
			IF @mDigit='8' SELECT @mNumText=N'tám'
			ELSE
			IF @mDigit='9' SELECT @mNumText=N'chín'
			ELSE 
			IF @mDigit='.' SELECT @mNumText=N'phẩy'
			END

		SELECT @mTemp = @mTemp + ' ' + @mNumText

		IF (@mLen = @i) BREAK
		
		IF @i =3
			SELECT @mTemp = @mTemp + N' mươi'
		SELECT @i=@i+1
		END


	SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'không ')

	SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')

	SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi lăm')

	--'Fix trường hợp x1, x>=2

	SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')

	--'Fix trường hợp x15

	SELECT @mTemp = Replace(@mTemp, N'mười năm', N'mười lăm')

	--'Bỏ ký tự space

	SELECT @mTemp = LTrim(@mTemp)

	--'Ucase ký tự đầu tiên

	SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)

	RETURN @Return
END
GO
/****** Object:  Table [dbo].[BAITHI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAITHI](
	[CauHoi] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CauSo] [int] NOT NULL,
	[NoiDung] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DapAn] [nchar](1) NOT NULL,
	[DaChon] [nchar](1) NULL,
	[MaBD] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_6CFAB7D3B00E43EEBBFBEB5F847FE53E]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BAITHI] PRIMARY KEY CLUSTERED 
(
	[CauHoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BANGDIEM]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGDIEM](
	[MASV] [nchar](8) NOT NULL,
	[MAMH] [nchar](5) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[NGAYTHI] [datetime] NULL CONSTRAINT [DF_BANGDIEM_NGAYTHI]  DEFAULT (getdate()),
	[DIEM] [float] NULL,
	[MABD] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_40242051F2B04786B3A2B3F7BC57EA7E]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BANGDIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BODE]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BODE](
	[CAUHOI] [int] NOT NULL,
	[MAMH] [nchar](5) NOT NULL,
	[TRINHDO] [nchar](1) NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [nchar](1) NOT NULL,
	[MAGV] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_4B49D320214344E6A9F712A29CD24220]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_BODE] PRIMARY KEY CLUSTERED 
(
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COSO]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSO](
	[MACS] [nchar](3) NOT NULL,
	[TENCS] [nvarchar](50) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_B0C9F4296BD14087B40A17ED86D0003D]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_COSO] PRIMARY KEY CLUSTERED 
(
	[MACS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAGV] [nchar](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MAKH] [nchar](8) NOT NULL,
	[HOCVI] [nvarchar](40) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_31BBB59829C0445697F6A2058F24C76F]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIAOVIEN_DANGKY]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DANGKY](
	[MAGV] [nchar](8) NULL,
	[MAMH] [nchar](5) NOT NULL,
	[MALOP] [nchar](8) NOT NULL,
	[TRINHDO] [nchar](1) NULL,
	[NGAYTHI] [datetime] NULL CONSTRAINT [DF_GIAOVIEN_DANGKY_NGAYTHI]  DEFAULT (getdate()),
	[LAN] [smallint] NOT NULL,
	[SOCAUTHI] [smallint] NULL,
	[THOIGIAN] [smallint] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_5766417EE1564B7E885EACABA092929E]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_GIAOVIEN_DANGKY] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MALOP] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [nchar](8) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[MACS] [nchar](3) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_92FB5F3DD6C3465CA7FDA3086DFE9C78]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LOP]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [nchar](8) NOT NULL,
	[TENLOP] [nvarchar](50) NOT NULL,
	[MAKH] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_BBABA3B5B1A3479A9AD064809A55ABC9]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [nchar](5) NOT NULL,
	[TENMH] [varchar](40) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_9FF65A81B881496AAD383CA861C2E25A]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_TENMH] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [nchar](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[NGAYSINH] [datetime] NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MALOP] [nchar](8) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [MSmerge_df_rowguid_E2C1E0BD8DF244869DBD06719FFB1756]  DEFAULT (newsequentialid()),
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[V_DS_COSO]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DS_COSO]
AS
SELECT        dbo.COSO.MACS, PUBS.description AS TENCS, SUBS.subscriber_server AS TENSERVER
FROM            dbo.COSO INNER JOIN
                         dbo.sysmergepublications AS PUBS INNER JOIN
                         dbo.sysmergesubscriptions AS SUBS ON PUBS.pubid = SUBS.pubid AND PUBS.publisher <> SUBS.subscriber_server ON dbo.COSO.TENCS = PUBS.description
WHERE        (PUBS.description <> N'TRACUU')

GO
/****** Object:  View [dbo].[V_DSLOP]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DSLOP]
AS
SELECT        MALOP, TENLOP, MAKH
FROM            dbo.LOP

GO
SET IDENTITY_INSERT [dbo].[BAITHI] ON 

INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25473, 225, N'Cháu lên ba cháu vô mẫu giáo, cô khen cháu cháu không khóc nhè.', N'1', N'2', N'3', N'4', N'C', N'A', 25044, N'08ab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25474, 57, N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'A', 25044, N'09ab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25475, 23, N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N'A', 25044, N'0aab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25476, 29, N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N'A', 25044, N'0bab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25477, 22, N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'A', 25044, N'0cab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25478, 56, N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N'A', 25044, N'0dab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25479, 52, N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N'A', 25044, N'0eab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25480, 55, N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'A', 25044, N'0fab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25481, 51, N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'A', 25044, N'10ab501b-450c-ea11-8d37-c8ff2829626a')
INSERT [dbo].[BAITHI] ([CauHoi], [CauSo], [NoiDung], [A], [B], [C], [D], [DapAn], [DaChon], [MaBD], [rowguid]) VALUES (25482, 58, N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N'A', 25044, N'11ab501b-450c-ea11-8d37-c8ff2829626a')
SET IDENTITY_INSERT [dbo].[BAITHI] OFF
SET IDENTITY_INSERT [dbo].[BANGDIEM] ON 

INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABD], [rowguid]) VALUES (N'001     ', N'AVCB ', 2, CAST(N'2019-11-27 00:00:00.000' AS DateTime), 1, 25044, N'07ab501b-450c-ea11-8d37-c8ff2829626a')
SET IDENTITY_INSERT [dbo].[BANGDIEM] OFF
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (1, N'MMTCB', N'A', N'mạng máy tính(compute netword) so với hệ thống tập trung multi-user', N'dễ phát triển hệ thống', N'tăng độ tin cậy', N'tiết kiệm chi phí', N'tất cả đều đúng', N'D', N'TH657   ', N'c419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (3, N'MMTCB', N'A', N'để một máy tính truyền dữ liệu cho một số máy khác trong mạng, ta dùng loại địa chỉ', N'Broadcast', N'Broadband', N'multicast', N'multiple access', N'C', N'TH123   ', N'c519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (4, N'MMTCB', N'A', N'thứ tự phân loại mạng theo chiều dài đường truyền', N'internet, lan, man, wan', N'internet, wan, man, lan', N'lan, wan, man, internet', N'man, lan, wan, internet', N'B', N'TH123   ', N'c619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (5, N'MMTCB', N'A', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N'TH123   ', N'c719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (6, N'MMTCB', N'A', N'thuật ngữ man được viết tắt bởi:', N'middle area network', N'metropolitan area network', N'medium area network', N'multiple access network', N'D', N'TH123   ', N'c819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (7, N'MMTCB', N'A', N'mạng man không kết nối theo sơ đồ:', N'bus', N'ring', N'star', N'tree', N'D', N'TH123   ', N'c919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (8, N'MMTCB', N'A', N'kiến trúc mạng (network architechture) là:', N'tập các chức năng trong mạng', N'tập các cấp và các protocol trong mỗi cấp', N'tập các dịch vụ trong mạng', N'tập các protocol trong mạng', N'B', N'TH123   ', N'ca19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (9, N'MMTCB', N'A', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N'TH123   ', N'cb19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (10, N'MMTCB', N'A', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N'TH123   ', N'cc19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (11, N'MMTCB', N'A', N'dịch vụ không xác nhận (unconfirmed) chỉ sử dụng 2 phép toán cơ bản:', N'response and confirm', N'confirm and request', N'request and indication', N'indication and response', N'C', N'TH123   ', N'cd19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (12, N'MMTCB', N'A', N'Chọn câu sai trong các nguyên lý phân cấp của mô hình OSI', N'Mỗi cấp thực hiện 1 chức năng rõ ràng', N'Mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'Mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'Mỗi cấp phải cung cấp cùng 1 kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'ce19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (13, N'MMTCB', N'A', N'Chức năng của cấp vật lý(physical)', N'Qui định truyền 1 hay 2 chiều', N'Quản lý lỗi sai', N'Xác định thời gian truyền 1 bit dữ liệu', N'Quản lý địa chỉ vật lý', N'C', N'TH123   ', N'cf19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (14, N'MMTCB', N'A', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N'TH123   ', N'd019bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (15, N'MMTCB', N'A', N'Chức năng cấp mạng (network)', N'Quản lý lưu lượng đường truyền', N'Điều khiển hoạt động subnet', N'Nén dữ liệu', N'Chọn điện áp trên kênh truyền', N'B', N'TH123   ', N'd119bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (16, N'MMTCB', N'A', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N'TH123   ', N'd219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (17, N'MMTCB', N'A', N'Cáp xoắn đôi trong mạng LAN dùng đầu nối', N'AUI', N'BNC', N'RJ11', N'RJ45', N'D', N'TH123   ', N'd319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (18, N'MMTCB', N'A', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N'TH123   ', N'd419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (19, N'MMTCB', N'A', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'd519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (20, N'AVCB ', N'A', N'The publishers suggested that the envelopes be sent to ...... by courier so that the film can be developed as soon as possible', N'they', N'their', N'theirs', N'them', N'D', N'TH234   ', N'd619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (21, N'AVCB ', N'A', N'Board members ..... carefully define their goals and objectives for the agency before the monthly meeting next week.', N'had', N'should', N'used ', N'have', N'B', N'TH234   ', N'd719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (22, N'AVCB ', N'A', N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'TH234   ', N'd819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (23, N'AVCB ', N'A', N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N'TH234   ', N'd919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (24, N'AVCB ', N'A', N'Making advance arrangements for audiovisual equipment is....... recommended for all seminars.', N'sternly', N'strikingly', N'stringently', N'strongly', N'A', N'TH234   ', N'da19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (25, N'AVCB ', N'A', N'Two assistants will be required to ...... reporter''s names when they arrive at the press conference', N'remark', N'check', N'notify', N'ensure', N'B', N'TH234   ', N'db19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (26, N'AVCB ', N'A', N'The present government has an excellent ......to increase exports', N'popularity', N'regularity', N'celebrity', N'opportunity', N'D', N'TH234   ', N'dc19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (27, N'AVCB ', N'A', N'While you are in the building, please wear your identification badge at all times so that you are ....... as a company employee.', N'recognize', N'recognizing', N'recognizable', N'recognizably', N'D', N'TH234   ', N'dd19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (28, N'AVCB ', N'A', N'Our studies show that increases in worker productivity have not been adequately .......rewarded by significant increases in ......', N'compensation', N'commodity', N'compilation', N'complacency', N'B', N'TH234   ', N'de19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (29, N'AVCB ', N'A', N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N'TH234   ', N'df19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (30, N'AVCB ', N'B', N'Battery-operated reading lamps......very well right now', N'sale', N'sold', N'are selling', N'were sold', N'C', N'TH234   ', N'e019bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (31, N'AVCB ', N'B', N'In order to place a call outside the office, you have to .......nine first. ', N'tip', N'make', N'dial', N'number', N'D', N'TH234   ', N'e119bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (32, N'AVCB ', N'B', N'We are pleased to inform...... that the missing order has been found.', N'you', N'your', N'yours', N'yourseld', N'A', N'TH234   ', N'e219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (33, N'AVCB ', N'B', N'Unfortunately, neither Mr.Sachs....... Ms Flynn will be able to attend the awards banquet this evening', N'but', N'and', N' nor', N'either', N'C', N'TH234   ', N'e319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (34, N'AVCB ', N'B', N'According to the manufacturer, the new generatir is capable of....... the amount of power consumed by our facility by nearly ten percent.', N'reduced', N'reducing', N'reduce', N'reduces', N'B', N'TH234   ', N'e419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (35, N'AVCB ', N'B', N'After the main course, choose from our wide....... of homemade deserts', N'varied', N'various', N'vary', N'variety', N'D', N'TH234   ', N'e519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (36, N'AVCB ', N'B', N'One of the most frequent complaints among airline passengers is that there is not ...... legroom', N'enough', N'many', N'very', N'plenty', N'A', N'TH234   ', N'e619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (37, N'AVCB ', N'B', N'Faculty members are planning to..... a party in honor of Dr.Walker, who will retire at the end of the semester', N'carry', N'do', N'hold', N'take', N'D', N'TH234   ', N'e719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (38, N'AVCB ', N'B', N'Many employees seem more ....... now about how to use the new telephone system than they did before they attended the workshop', N'confusion', N'confuse', N'confused', N'confusing', N'C', N'TH234   ', N'e819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (39, N'AVCB ', N'B', N'.........our production figures improve in the near future, we foresee having to hire more people between now and July', N'During', N'Only', N'Unless', N'Because', N'D', N'TH234   ', N'e919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (40, N'AVCB ', N'C', N'Though their performance was relatively unpolished, the actors held the audience''s ........for the duration of the play.', N'attentive', N'attentively', N'attention', N'attentiveness', N'C', N'TH234   ', N'ea19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (41, N'AVCB ', N'C', N'Dr. Abernathy''s donation to Owstion College broke the record for the largest private gift...... give to the campus', N'always', N'rarely', N'once', N'ever', N'C', N'TH234   ', N'eb19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (42, N'AVCB ', N'C', N'Savat Nation Park is ....... by train,bus, charter plane, and rental car.', N'accessible', N'accessing', N'accessibility', N'accesses', N'A', N'TH234   ', N'ec19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (43, N'AVCB ', N'C', N'In Piazzo''s lastest architectural project, he hopes to......his flare for blending contemporary and traditional ideals.', N'demonstrate', N'appear', N'valve', N'position', N'A', N'TH234   ', N'ed19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (44, N'AVCB ', N'C', N'Replacing the offic equipment that the company purchased only three years ago seems quite.....', N'waste', N'wasteful', N'wasting', N'wasted', N'C', N'TH234   ', N'ee19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (45, N'AVCB ', N'C', N'On........, employees reach their peak performance level when they have been on the job for at least two years.', N'common', N'standard', N'average', N'general', N'D', N'TH234   ', N'ef19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (46, N'AVCB ', N'C', N'We were........unaware of the problems with the air-conidtioning units in the hotel rooms until this week.', N'complete ', N'completely', N'completed', N'completing', N'D', N'TH234   ', N'f019bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (47, N'AVCB ', N'C', N'If you send in an order ....... mail, we recommend that you phone our sales division directly to confirm the order.', N'near', N'by', N'for', N'on', N'A', N'TH234   ', N'f119bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (48, N'AVCB ', N'C', N'A recent global survey suggests.......... demand for aluminum and tin will remain at its current level for the next five to ten years.', N'which', N'it ', N'that', N'both', N'C', N'TH234   ', N'f219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (49, N'AVCB ', N'C', N'Rates for the use of recreational facilities do not include ta and are subject to change without.........', N'signal', N'cash', N'report', N'notice', N'A', N'TH234   ', N'f319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (50, N'AVCB ', N'A', N'Aswering telephone calls is the..... of an operator', N'responsible', N'responsibly', N'responsive', N'responsibility', N'D', N'TH234   ', N'f419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (51, N'AVCB ', N'A', N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'TH234   ', N'f519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (52, N'AVCB ', N'A', N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N'TH234   ', N'f619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (53, N'AVCB ', N'A', N'Because we value your business, we have .......for card members like you to receive one thousand  dollars of complimentary life insurance', N'arrange', N'arranged', N'arranges', N'arranging', N'B', N'TH234   ', N'f719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (54, N'AVCB ', N'A', N'Employees are........that due to the new government regulations. there is to be no smoking in the factory', N'reminded', N'respected', N'remembered', N'reacted', N'A', N'TH234   ', N'f819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (55, N'AVCB ', N'A', N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'TH234   ', N'f919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (56, N'AVCB ', N'A', N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N'TH234   ', N'fa19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (57, N'AVCB ', N'A', N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'TH234   ', N'fb19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (58, N'AVCB ', N'A', N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N'TH234   ', N'fc19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (59, N'AVCB ', N'A', N'The sales representive''s presentation was difficult to understand ........ he spoke very quickly', N'because', N'althought', N'so that', N'than', N'A', N'TH234   ', N'fd19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (60, N'AVCB ', N'B', N'It has been predicted that an.......weak dollar will stimulate tourism in the United States', N'increased', N'increasingly', N'increases', N'increase', N'B', N'TH234   ', N'fe19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (61, N'AVCB ', N'B', N'The firm is not liable for damage resulting from circumstances.........its control.', N'beyond', N'above', N'inside', N'around', N'A', N'TH234   ', N'ff19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (62, N'AVCB ', N'B', N'Because of.......weather conditions, California has an advantage in the production of fruits and vegetables', N'favorite', N'favor', N'favorable', N'favorably', N'C', N'TH234   ', N'001abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (63, N'AVCB ', N'B', N'On international shipments, all duties and taxes are paid by the..........', N'recipient', N'receiving', N'receipt', N'receptive', N'A', N'TH234   ', N'011abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (64, N'AVCB ', N'B', N'Although the textbook gives a definitive answer,wise managers will look for........ own creative solutions', N'them', N'their', N'theirs', N'they', N'B', N'TH234   ', N'021abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (65, N'AVCB ', N'B', N'Initial ....... regarding the merger of the companies took place yesterday at the Plaza Conference Center.', N'negotiations', N'dedications', N'propositions', N'announcements', N'A', N'TH234   ', N'031abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (66, N'AVCB ', N'B', N'Please......... photocopies of all relevant docunments to this office ten days prior to your performance review date', N'emerge', N'substantiate', N'adapt', N'submit', N'D', N'TH234   ', N'041abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (67, N'AVCB ', N'B', N'The auditor''s results for the five year period under study were .........the accountant''s', N'same', N'same as', N'the same', N'the same as', N'D', N'TH234   ', N'051abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (68, N'AVCB ', N'B', N'.........has the marketing environment been more complex and subject to change', N'Totally', N'Negatively', N'Decidedly', N'Rarely', N'D', N'TH234   ', N'061abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (69, N'AVCB ', N'B', N'All full-time staff are eligible to participate in the revised health plan, which becomes effective the first ......... the month.', N'of', N'to', N'from', N'for', N'A', N'TH234   ', N'071abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (70, N'AVCB ', N'C', N'Contracts must be read........ before they are signed.', N'thoroughness', N'more thorough', N'thorough', N'thoroughly', N'D', N'TH234   ', N'081abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (71, N'AVCB ', N'C', N'Passengers should allow for...... travel time to the airport in rush hour traffic', N'addition', N'additive', N'additionally', N'additional', N'D', N'TH234   ', N'091abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (72, N'AVCB ', N'C', N'This fiscal year, the engineering team has worked well together on all phases ofproject.........', N'development', N'developed', N'develops', N'developer', N'A', N'TH234   ', N'0a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (73, N'AVCB ', N'C', N'Mr.Dupont had no ....... how long it would take to drive downtown', N'knowledge', N'thought', N'idea', N'willingness', N'C', N'TH234   ', N'0b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (74, N'AVCB ', N'C', N'Small company stocks usually benefit..........the so called January effect that cause the price of these stocks to rise between November and January', N'unless', N'from', N'to ', N'since', N'B', N'TH234   ', N'0c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (75, N'AVCB ', N'C', N'It has been suggested that employees ........to work in their current positions until the quarterly review is finished.', N'continuity', N'continue', N'continuing', N'continuous', N'B', N'TH234   ', N'0d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (76, N'AVCB ', N'C', N'It is admirable that Ms.Jin wishes to handle all transactions by........, but it might be better if several people shared the responsibility', N'she', N'herself', N'her', N'hers', N'B', N'TH234   ', N'0e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (77, N'AVCB ', N'C', N'This new highway construction project will help the company.........', N'diversity', N'clarify', N'intensify', N'modify', N'A', N'TH234   ', N'0f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (78, N'AVCB ', N'C', N'Ms.Patel has handed in an ........business plan to the director', N'anxious', N'evident', N'eager', N'outstanding', N'D', N'TH234   ', N'101abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (79, N'AVCB ', N'C', N'Recent changes in heating oil costs have affected..........production of turniture', N'local', N'locality', N'locally', N'location', N'A', N'TH234   ', N'111abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (80, N'MMTCB', N'A', N'Termiator là linh kiện dùng trong loại cáp mạng', N'Cáp quang', N'UTP và STP ', N'Xoắn đôi', N'Đồng trục', N'D', N'TH123   ', N'121abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (81, N'MMTCB', N'A', N'Mạng không dây dùng loại sóng nào không bị ảnh hưởng bởi khoảng cách địa lý', N'Sóng radio', N'Sống hồng ngoại', N'Sóng viba', N'Song cực ngắn', N'A', N'TH123   ', N'131abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (82, N'MMTCB', N'A', N'Đường truyền E1 gồm 32 kênh, trong đó sử dụng cho dữ liệu là:', N'32 kênh', N'31 kênh', N'30 kênh', N'24 kênh', N'C', N'TH123   ', N'141abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (83, N'MMTCB', N'A', N'Mạng máy tính thường sử dụng loại chuyển mach', N'Gói (packet switch)', N'Kênh (Circuit switch)', N'Thông báo(message switch)', N'Tất cả đều đúng', N'A', N'TH123   ', N'151abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (84, N'MMTCB', N'A', N'Cáp UTP hỗ trợ tôc độ truyền 100MBps là loại', N'Cat 3', N'Cat 4', N'Cat 5', N'Cat 6', N'C', N'TH123   ', N'161abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (85, N'MMTCB', N'A', N'Thiết bị nào làm việc trong cấp vật lý (physical) ', N'Terminator', N'Hub', N'Repeater', N'Tất cả đều đúng', N'D', N'TH123   ', N'171abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (86, N'MMTCB', N'A', N'Phương pháp dồn kênh phân chia tần số gọi là', N'FDM', N'WDM', N'TDM', N'CSMA', N'A', N'TH123   ', N'181abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (87, N'MMTCB', N'A', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N'TH123   ', N'191abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (88, N'MMTCB', N'A', N'Nguyên nhân gây sai sót khi gửi/nhận dữ liệu trên mạng', N'Mất đồng bộ trong khi truyền', N'Nhiễu từ môi trường', N'Lỗi phần cứng hoặc phần mềm', N'Tất cả đều đúng ', N'D', N'TH123   ', N'1a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (89, N'MMTCB', N'A', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N'TH123   ', N'1b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (90, N'MMTCB', N'A', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N'TH123   ', N'1c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (91, N'MMTCB', N'A', N'Hoạt động của protocol Stop and Wait', N'Chờ một khoảng thời gian time-out rồi gửi tiếp frame kế', N'Chờ 1 khoảng thời gian time-out rồi gửi lại frame trước', N'Chờ nhận được ACK của frame trước mới gửi tiếp frame kế', N'Không chờ mà gửi liên tiếp các frame kế nhau', N'C', N'TH123   ', N'1d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (92, N'MMTCB', N'A', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N'TH123   ', N'1e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (93, N'MMTCB', N'A', N'Phương pháp nào được dủng trong việc phát hiện lỗi', N'Timer', N'Ack', N'Checksum', N'Tất cả đều đúng', N'C', N'TH123   ', N'1f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (94, N'MMTCB', N'A', N'Kiểm soát lưu lượng (flow control) có nghĩa là', N'Thay đổi thứ tự truyền frame', N'Điều tiết tốc độ truyền frame', N'Thay đổi thời gian chờ time-out', N'Điều chỉnh kích thước frame', N'B', N'TH123   ', N'201abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (95, N'MMTCB', N'A', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N'TH123   ', N'211abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (96, N'MMTCB', N'A', N'Mạng nào không có khả năng nhận biết tình trạng đường truyền (carrier sence)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng ', N'A', N'TH123   ', N'221abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (97, N'MMTCB', N'A', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N'TH123   ', N'231abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (98, N'MMTCB', N'A', N'Chuẩn mạng nào có khả năng pkhát hiện xung đột (collision) trong khi truyền', N'1-persistent CSMA', N'p-persistent CSMA', N'Non-persistent CSMA', N'CSMA/CD', N'D', N'TH123   ', N'241abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (99, N'MMTCB', N'A', N'Loại mạng cục bộ nào dùng chuẩn CSMA/CD', N'Token-ring', N'Token-bus', N'Ethernet', N'ArcNet', N'C', N'TH123   ', N'251abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (100, N'MMTCB', N'A', N'Mạng Ethernet được IEEE đưa vào chuẩn', N'IEEE 802.2', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'B', N'TH123   ', N'261abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (101, N'MMTCB', N'A', N'Chuẩn nào không dùng trong mạng cục bộ (LAN )', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'IEEE 802.6', N'D', N'TH123   ', N'271abed3-b7e5-e911-8d30-caff28296269')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (102, N'MMTCB', N'A', N'Loại mạng nào dùng 1 máy tính làm Monitor để bảo trì mạng', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'B', N'TH123   ', N'281abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (103, N'MMTCB', N'A', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N'TH123   ', N'291abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (104, N'MMTCB', N'A', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N'TH123   ', N'2a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (105, N'MMTCB', N'A', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N'TH123   ', N'2b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (106, N'MMTCB', N'A', N'Chọn câu sai:" Cầu nối (bridge) có thể kết nối các mạng có...."', N'Chiều dài frame khác nhau', N'Cấu trúc frame khác nhau', N'Tốc độ truyền khác nhau', N'Chuẩn khác nhau', N'A', N'TH123   ', N'2c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (107, N'MMTCB', N'A', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N'TH123   ', N'2d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (108, N'MMTCB', N'A', N'Mạng Ethernet sử dụng được loại cáp', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúgn', N'D', N'TH123   ', N'2e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (109, N'MMTCB', N'A', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N'TH123   ', N'2f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (110, N'MMTCB', N'A', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N'TH123   ', N'301abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (111, N'MMTCB', N'A', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N'TH123   ', N'311abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (112, N'MMTCB', N'A', N'Kiểu datagram trong cấp network', N'Chỉ tìm đường 1 lần khi tạo kết nối', N'Phải tìm đường riêng cho từng packet', N'THông tin có sẵn trong packet, không cần tìm đường', N'Thông tin có sẵn trong router , không cần tìm đường', N'B', N'TH123   ', N'321abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (113, N'MMTCB', N'A', N'Kiểm soát tắc nghẽn (congestion) là nhiệm vụ của cấp', N'Physical', N'Transport', N'Data link', N'Network', N'D', N'TH123   ', N'331abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (114, N'MMTCB', N'A', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N'TH123   ', N'341abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (115, N'MMTCB', N'A', N'Cấp appliation trong mô hình TCP/IP tương đương với cấp nào trong mô hình OSI', N'Session', N'Application', N'Presentation', N'Tất cả đều đúng', N'D', N'TH123   ', N'351abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (116, N'MMTCB', N'A', N'Cấp nào trong mô hình mạng OSI tương đương với cấp Internet trong mô hình TCP/IP ', N'Network', N'Transport', N'Physical', N'Data link', N'A', N'TH123   ', N'361abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (117, N'MMTCB', N'A', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N'TH123   ', N'371abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (118, N'MMTCB', N'A', N'Kỹ thuật Multiplexing được dùng khi', N'Có nhiều kênh truyền hơn đường truyền', N'Có nhiều đường truyền hơn kênh truyền', N'Truyền dữ liệu số trên mạng điện thoại', N'Truyền dữ liệu tương tự trên mạng điện thọai', N'A', N'TH123   ', N'381abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (119, N'MMTCB', N'A', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N'TH123   ', N'391abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (120, N'MMTCB', N'A', N'Địa chỉ IP lớp B nằm trong phạm vi nào', N'192.0.0.0 - 223.0.0.0', N'127.0.0.0 - 191.0.0.0', N'128.0.0.0 - 191.0.0.0 ', N'1.0.0.0 - 126.0.0.0', N'C', N'TH123   ', N'3a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (121, N'MMTCB', N'A', N'Subnet Mask nào sau đây chỉ cho tối đa 2 địa chỉ host', N'255.255.255.252', N'255.255.255.254', N'255.255.255.248', N'255.255.255.240', N'A', N'TH123   ', N'3b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (122, N'MMTCB', N'A', N'Thành phần nào không thuộc socket', N'Port', N'Địa chỉ IP', N'Địa chỉ cấp MAC', N'Protocol cấp Transport', N'C', N'TH123   ', N'3c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (123, N'MMTCB', N'A', N'Mục đích của Subnet Mask trong địa chỉ IP là', N'Xác định host của địa chỉ IP', N'Xác định vùng network của địa chỉ IP', N'Lấy các bit trong vùng subnet làm địa chỉ host', N'Lấy các bit trong vùng địa chỉ host làm subnet', N'A', N'TH123   ', N'3d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (124, N'MMTCB', N'A', N'Bước đầu tiên cần thực hiện để truyền dữ liệu theo ALOHA là', N'Chờ 1 thời gian ngẫu nhiên', N'Gửi tín hiệu tạo kết nối', N'Kiểm tra tình trạng đường truyền', N'Lập tức truyền dữ liệu', N'D', N'TH123   ', N'3e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (125, N'MMTCB', N'A', N'Cầu nối trong suốt hoạt động trong cấp nào', N'Data link', N'Physical', N'Network', N'Transport', N'A', N'TH123   ', N'3f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (126, N'MMTCB', N'A', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N'TH123   ', N'401abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (127, N'MMTCB', N'A', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N'TH123   ', N'411abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (128, N'MMTCB', N'A', N'Loại frame nào được sử dụng trong mạng Token-ring', N'Monitor', N'Token', N'Data', N'Token và Data', N'D', N'TH123   ', N'421abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (129, N'MMTCB', N'A', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N'TH123   ', N'431abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (130, N'MMTCB', N'A', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N'TH123   ', N'441abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (131, N'MMTCB', N'A', N'Trong mạng cục bộ, để xác định 1 máy trong mạng ta dùng địa chỉ', N'MAC', N'Socket', N'Domain', N'Port', N'A', N'TH123   ', N'451abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (132, N'MMTCB', N'A', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N'TH123   ', N'461abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (133, N'MMTCB', N'A', N'Cấp vật lý (physical) không quản lý', N'Mức điện áp', N'Địa chỉ vật lý', N'Mạch giao tiếp vật lý', N'Truyền các bit dữ liêu', N'B', N'TH123   ', N'471abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (134, N'MMTCB', N'A', N'TCP sử dụng loại dịch vụ', N'Có kết nối, độ tin cậy cao', N'Có kết nối, độ tin cậy thấp', N'Không kết nối, độ tin cậy cao', N'Không kết nối, độ tin cậy thấp', N'A', N'TH123   ', N'481abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (135, N'MMTCB', N'A', N'Địa chỉ IP bao gồm', N'Địa chỉ Network và địa chỉ host', N'Địa chỉ physical và địa chỉ logical', N'Địa chỉ cấp MAC và và địa chỉ LLC', N'Địa chỉ hardware và địa chỉ software', N'A', N'TH123   ', N'491abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (136, N'MMTCB', N'A', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N'TH123   ', N'4a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (137, N'MMTCB', N'A', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N'TH123   ', N'4b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (138, N'MMTCB', N'A', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N'TH123   ', N'4c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (139, N'MMTCB', N'A', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N'TH123   ', N'4d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (140, N'MMTCB', N'A', N'Chức năng của cấp Network là', N'Tìm đường', N'Mã hóa dữ liệu', N'Tạo địa chỉ vật lý', N'Kiểm soát lưu lượng', N'A', N'TH123   ', N'4e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (141, N'MMTCB', N'B', N'Sự khác nhau giữa địa chỉ cấp Data link và Network là', N'Địa chỉ cấp Data link có kích thước nhỏ hơn địa chỉ cấp Network', N'Địa chỉ cấp Data link là đia chỉ Physic, địa chỉ cấp Network là địa chỉ Logic', N'Địa chỉ cấp Data Link là địa chỉ Logic, địa chỉ câp Network là địa chỉ Physic', N'Địa chỉ Data link cấu hình theo mạng, địa chỉ cấp Network xác định theo IEEE', N'B', N'TH123   ', N'4f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (142, N'MMTCB', N'B', N'Kỹ thuật nào không sử dụng được trong việc kiểm soát lưu lượng(flow control)', N'Ack', N'Buffer', N'Windowing', N'Multiplexing', N'D', N'TH123   ', N'501abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (143, N'MMTCB', N'B', N'Cấp cao nhất trong mô hình mạng OSI là', N'Transport', N'Physical', N'Network', N'Application', N'D', N'TH123   ', N'511abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (144, N'MMTCB', N'B', N'Tại sao mạng máy tình dùng mô hình phân cấp', N'Để mọi người sử dụng cùng 1 ứng dụng mạng', N'Để phân biệt giữa chuẩn mạng và ứng dụng mạng', N'Giảm độ phức tạp trong việc thiết kế và cài đặt', N'Các cấp khác không cần sửa đổi khi thay đổi 1 cấp mạng', N'D', N'TH123   ', N'521abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (145, N'MMTCB', N'B', N'Router làm gì để giảm tăc nghẽn (congestion)', N'Nén dữ liệu', N'Lọc bớt dữ liệu theo địa chỉ vật lý', N'Lọc bớt dữ liệu theo địa chỉ logic', N'Cấm truyền dữ liệu broadcasr', N'D', N'TH123   ', N'531abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (146, N'MMTCB', N'B', N'Byte đầu của 1 IP có giá trị 222, địa chỉ này thuộc lớp địa chỉ nào', N'Lớp A', N'Lớp B', N'Lớp C', N'Lớp D', N'C', N'TH123   ', N'541abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (147, N'MMTCB', N'B', N'Chọn câu đúng đối với switch của mạng LAN', N'Là 1 cầu nối tốc độ cao', N'Nhận data từ 1 cổng và xuất ra mọi cổng còn lại', N'Nhận data từ 1 cổng và xuất ra  cổng đích tùy theo địa chỉ cấp IP', N'Nhận data từ 1 cổng và xuất ra 1 cổng đích tùy theo địa chỉ cấp MAC', N'D', N'TH123   ', N'551abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (148, N'MMTCB', N'B', N'Thuật ngữ nào cho biết loại mạng chỉ truyền được  chiều tại 1 thời điểm', N'Half duplex', N'Full duplex', N'Simplex', N'Monoplex', N'A', N'TH123   ', N'561abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (149, N'MMTCB', N'B', N'Protocol nghĩa là', N'Tập các chuẩn truyền dữ liệu', N'Tập các cấp mạng trong mô hình OSI', N'Tập các chức năng của từng cấp trong mạng', N'Tập các qui tắc và cấu trúc dữ liệu để truyền thông giữa các cấp mạng', N'D', N'TH123   ', N'571abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (150, N'MMTCB', N'B', N'Truyền dữ liệu theo kiểu có kết nối không cần thực hiện việc', N'Hủy kết nối', N'Tạo kết nối', N'Truyền dữ liệu', N'Tìm đường cho từng gói tin', N'D', N'TH123   ', N'581abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (151, N'MMTCB', N'B', N'Byte đầu của địa chỉ IP lớp E nằm trong phạm vi', N'128 - 191', N'192 - 232 ', N'224 - 239 ', N'240 - 247', N'D', N'TH123   ', N'591abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (152, N'MMTCB', N'B', N'Khi truyền đi chuỗi "VIET NAM" nhưng nhận được chuỗi"MAN TEIV ". Cần phải hiệu chỉnh các protocol trong cấp nào để truyền chính xác', N'Session', N'Transport', N'Application', N'Presentation', N'B', N'TH123   ', N'5a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (153, N'MMTCB', N'B', N'Tên cáp UTP dùng torng mạng Fast Ethernet là', N'100BaseF', N'100Base2', N'100BaseT', N'100Base5', N'C', N'TH123   ', N'5b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (154, N'MMTCB', N'B', N'Tốc độ truyền của mạng Ethernet là', N'1 Mbps', N'10 Mbps', N'100 Mbps', N'1000 Mbps', N'B', N'TH123   ', N'5c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (155, N'MMTCB', N'B', N'Dịch vụ mạng thường được phân chia thành', N'Dịch vụ không kết nối và có kết nối', N'Dich vụ có xác nhận và không xác nhận', N'Dịch vụ có độ tin cậy cao và có độ tin cậy thấp', N'Tất cả đều đúng', N'D', N'TH123   ', N'5d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (156, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu trong cấp Network gọi là', N'Bit', N'Frame', N'Packet', N'Segment', N'C', N'TH123   ', N'5e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (157, N'MMTCB', N'B', N'Protocol nào trong mạng TCP/IP chuyển đổi địa chỉ vật lý thành địa chỉ IP', N'IP', N'ARP', N'ICMP', N'RARP', N'D', N'TH123   ', N'5f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (158, N'MMTCB', N'B', N'Đầu nới AUI dùng cho loại cáp nào?', N'Đồng trục', N'Xoắn đôi', N'Cáp quang', N'Tất cả đều đúng', N'A', N'TH123   ', N'601abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (159, N'MMTCB', N'B', N'Subnet mask chuẩn của địa chỉ IP lớp B là', N'255.0.0.0', N'255.255.0.0', N'255.255.255.0', N'255.255.255.255', N'B', N'TH123   ', N'611abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (160, N'MMTCB', N'B', N'Lý do nào khiến người ta chọn protocol TCP hơn là UDP', N'Không ACK', N'Dễ sử dụng', N'Độ tin cậy', N'Không kết nối', N'C', N'TH123   ', N'621abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (161, N'MMTCB', N'B', N'Nhược điểm của dịch vụ có kết nối so với không kết nối', N'Độ tin cậy', N'Thứ tự nhận dữ liệu không đúng', N'Đường truyền không thay đổi', N'Đường truyền thay đổi liên tục', N'C', N'TH123   ', N'631abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (162, N'MMTCB', N'B', N'Cấp Data link không thực hiện chức năng nào?', N'Kiểm soát lỗi', N'Địa chỉ vật lý', N'Kiểm soát lưu lượng', N'Thiết lập kết nối', N'D', N'TH123   ', N'641abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (163, N'MMTCB', N'B', N'Cầu nối (bridge)dựa vào thông tin nào để truyền tiếp hoặc hủy bỏ 1 frame', N'Điạ chỉ nguồn', N'Địa chỉ đích', N'Địa chỉ mạng', N'Tất cả đều đúng', N'C', N'TH123   ', N'651abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (164, N'MMTCB', N'B', N'Chuẩn nào sử dụng trong cấp presentation?', N'UTP và STP', N'SMTP và HTTP', N'ASCII và EBCDIC', N'TCP và UDP', N'C', N'TH123   ', N'661abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (165, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu giữa các cấp trong mạng theo thứ tự', N'bit,frame,packet,data', N'bit,packet,frame,data', N'data,frame,packet,bit', N'data,bit,packet,frame', N'A', N'TH123   ', N'671abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (166, N'MMTCB', N'B', N'Mạng Ethernet do cơ quan nào phát minh', N'ANSI', N'ISO', N'IEEE', N'XEROX', N'D', N'TH123   ', N'681abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (167, N'MMTCB', N'B', N'Chiều dài loại cáp nào tối đa 100 m? ', N'10Base2', N'10Base5', N'10BaseT', N'10BaseF', N'C', N'TH123   ', N'691abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (168, N'MMTCB', N'B', N'Địa chỉ IP 100.150.200.250 có nghĩa là', N'Địa chỉ network 100, địa chỉ host 150.200.250', N'Địa chỉ network 100.150, địa chỉ host 200.250', N'Địa chỉ network 100.150.200, địa chỉ host 250', N'Tất cả đều sai', N'D', N'TH123   ', N'6a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (169, N'MMTCB', N'B', N'Switching hun khác hub thông thường ở chỗ nó làm', N'Giảm collision trên mạng', N'Tăng collision trên mạng', N'Giảm congestion trên mạng', N'Tăng congestion trên mạng', N'A', N'TH123   ', N'6b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (170, N'MMTCB', N'B', N'Loại cáp nào chỉ truyền dữ liệu 1 chiều', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúng', N'A', N'TH123   ', N'6c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (171, N'MMTCB', N'B', N'Thiết bị Modem dùng để', N'Tách và ghép tín hiệu', N'Nén và gải nén tín hiệu', N'Mã hóa và giải mã tín hiệu', N'Điều chế và giải điều chế tín hiệu', N'D', N'TH123   ', N'6d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (172, N'MMTCB', N'B', N'Việc cấp phát kênh truyền áp dụng cho loại mạng', N'Peer to peer', N'Point to point', N'Broadcast', N'Multiple Access', N'C', N'TH123   ', N'6e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (173, N'MMTCB', N'B', N'Mạng nào dùng phương pháp mã hóa Manchester Encoding', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều đúng ', N'D', N'TH123   ', N'6f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (174, N'MMTCB', N'B', N'Phương pháp tìm đường có tính đến thời gian trễ', N'Tìm đường theo chiều sâu', N'Tìm đường theo chiều rộng', N'Tìm đường theo vector khoảng cách', N'Tìm đường theo trạng thái đường truyền', N'D', N'TH123   ', N'701abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (175, N'MMTCB', N'B', N'Chuẩn mạng nào khi có dữ liệu không truyền ngay mà chờ 1 thời gian ngẫu nhiên?', N'1-presistent CSMA', N'p-presistent CSMA', N'Non-presistent CSMA', N'CSMA/CD', N'C', N'TH123   ', N'711abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (176, N'MMTCB', N'B', N'Phương pháp chèn bit (bit stuffing) được dùng để', N'Phân biệt đầu và cuối frame', N'Bổ sung cho đủ kích thước frame tối thiểu', N'Phân cách nhiều bit 0 bằng bit 1', N'Biến đổi dạng dữ liệu 8 bit ra 16 bit', N'A', N'TH123   ', N'721abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (177, N'MMTCB', N'B', N'Để chống nhiễu trên đường truyền tốt nhất, nên dùng loại cáp:', N'Xoắn đôi', N'Đồng trục', N'Cáp quang', N'Mạng không dây', N'C', N'TH123   ', N'731abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (178, N'MMTCB', N'B', N'Phần mềm gửi/nhận thư điện tử thuộc cấp nào trong mô hình OSI', N'Data link', N'Network', N'Application', N'Presentation', N'C', N'TH123   ', N'741abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (179, N'MMTCB', N'B', N'Chức năng của thiết bị Hub trong mạng LAN', N'Mã hóa tín hiệu', N'Triệt tiêu tín hiệu', N'Phân chia tín hiệu', N'Điều chế tín hiếu', N'C', N'TH123   ', N'751abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (180, N'MMTCB', N'B', N'Switch là thiết bị mạng làm việc tương tự như', N'Hub', N'Repeater', N'Router', N'Bridge', N'D', N'TH123   ', N'761abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (181, N'MMTCB', N'C', N'Thiết bị nào làm việc trong cấp Network', N'Bridge', N'Repeater', N'Router', N'Gateway', N'C', N'TH123   ', N'771abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (182, N'MMTCB', N'C', N'Thiết bị nào cần có bộ nhớ làm buffer', N'Hub', N'Switch', N'Repeater', N'Router', N'D', N'TH123   ', N'781abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (183, N'MMTCB', N'C', N'Luật 5-4-3 cho phép tối đa', N'5 segment trong 1 mạng', N'5 repeater trong 1 mạng', N'5 máy tính trong 1 mạng', N'5 máy tính trong 1 segment', N'A', N'TH123   ', N'791abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (184, N'MMTCB', N'C', N'Thiết bị nào có thể thêm vào mạng LAN mà không sợ vi phạm luật 5-4-3', N'Router', N'Repeater', N'Máy tính', N'Tất cả đều đúng', N'A', N'TH123   ', N'7a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (185, N'MMTCB', N'C', N'Thêm thiết bị nào vào mạng có thể qui phạm luật 5-4-3', N'Router', N'Repeater', N'Bridge', N'Tất cả đều đúng', N'B', N'TH123   ', N'7b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (186, N'MMTCB', N'C', N'Mạng nào cóxảy ra xung đột (collision) trên đường truyền', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'A', N'TH123   ', N'7c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (187, N'MMTCB', N'C', N'Từ "Broad" trong tên cáp 10Broad36 viết tắt bởi', N'Broadcast', N'Broadbase', N'Broadband', N'Broadway', N'C', N'TH123   ', N'7d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (188, N'MMTCB', N'C', N'Protocol nào sử dụng trong cấp Network', N'IP', N'TCP', N'UDP', N'FTP', N'A', N'TH123   ', N'7e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (189, N'MMTCB', N'C', N'Protocol nào torng cấp Transport cung cấp dịch vụ không kết nối', N'IP', N'TCP', N'UDP', N'FTP', N'C', N'TH123   ', N'7f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (190, N'MMTCB', N'C', N'Protocol nào trong cấp Transport dùng kiểu dịch vụ có kết nối?', N'IP', N'TCP', N'UDP', N'FTP', N'B', N'TH123   ', N'801abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (191, N'MMTCB', N'C', N'Địa chỉ IP được chia làm mấy lớp', N'2', N'3', N'4', N'5', N'D', N'TH123   ', N'811abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (192, N'MMTCB', N'C', N'Chức năng nào không phải của cấp Network', N'Tìm đường', N'Địa chỉ logic', N'Kiểm soát tắc nghẽn', N'Chất lượng dịch vụ', N'B', N'TH123   ', N'821abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (193, N'MMTCB', N'C', N'Phương pháp chèn kí tự dùng để', N'Phân cách các frame', N'Phân biệt dữ liệu và ký tự điều khiển', N'Nhận diện đầu cuối frame', N'Bổ sung cho đủ kich thước frame tối thiểu', N'B', N'TH123   ', N'831abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (194, N'MMTCB', N'C', N'Kỹ thuật truyền nào mã hóa trực tiếp dữ liệu ra đường truyền không cần sóng mang', N'Broadcast', N'Digital', N'Baseband', N'Broadband', N'C', N'TH123   ', N'841abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (195, N'MMTCB', N'C', N'Sóng viba sử dụng băng tần', N'SHF', N'LF và MF', N'UHF và VHF', N'Tất cả đều đúng', N'D', N'TH123   ', N'851abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (196, N'MMTCB', N'C', N'Sóng viba bị ảnh hưởng bời', N'Trời mưa', N'Sấm chớp', N'Giông bão', N'Ánh sáng mặt trời', N'A', N'TH123   ', N'861abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (197, N'MMTCB', N'C', N'Đường dây trung kế trong mạng điện thoại sử dụng', N'Tín hiệu số', N'Kỹ thuật dồn kênh', N'Cáp quang, cáp đồng và viba', N'Tất cả đêu đúng', N'D', N'TH123   ', N'871abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (198, N'MMTCB', N'C', N'Cáp quang dùng công nghệ dồn kênh nào', N'TDM', N'FDM', N'WDM', N'CDMA', N'C', N'TH123   ', N'881abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (199, N'MMTCB', N'C', N'Nhược điểm của phương pháp chèn ký tự', N'Giảm tốc độ đường truyền', N'Tăng phí tổn đường truyền', N'Mất đồng bộ frame', N'Không nhận diện được frame', N'B', N'TH123   ', N'891abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (200, N'MMTCB', N'C', N'Mất đồng bộ frame xảy ra đối với phương pháp', N'Chèn bit', N'Đếm ký tự', N'Chèn ký tự', N'Tất cả đều đúng', N'B', N'TH123   ', N'8a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (201, N'MMTCB', N'C', N'Mạng nào dùng công nghệ Token-bus', N'FDDI', N'CDDI', N'Fast Ethernet', N'100VG-AnyLAN', N'D', N'TH123   ', N'8b1abed3-b7e5-e911-8d30-caff28296269')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (202, N'MMTCB', N'C', N'Thiết bị nào tự trao đổi thông tin lẫn nhau để quản lý mạng', N'Hub', N'Bridge', N'Router', N'Repeater', N'C', N'TH123   ', N'8c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (203, N'MMTCB', N'C', N'Tần số sóng điện từ dùng trong mạng vô tuyến sắp theo thứ tự tăng dần', N'Radio,viba,hồng ngoại', N'Radio,hồng ngoại,viba', N'Hồng ngoại,viba,radio', N'Viba,radio,hồng ngoại', N'A', N'TH123   ', N'8d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (204, N'MMTCB', N'C', N'Đường dây hạ kế (local loop) trong mạch điện thoại dùng tín hiệu', N'Digital', N'Analog', N'Manchester', N'T1 hoặc E1', N'B', N'TH123   ', N'8e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (205, N'MMTCB', N'C', N'Để tránh nhận trùng dữ liệu người ta dùng phương pháp', N'Đánh số thứ tự các frame', N'Quy định kích thước frame cố định', N'Chờ nhận ACK mới gửi frame kế tiếp', N'So sánh và loại bỏ các frame giống nhau', N'A', N'TH123   ', N'8f1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (206, N'MMTCB', N'C', N'Cơ chế Timer dùng để', N'Đo thời gian chơ frame', N'Tránh tình trạng mất frame', N'Chọn thời điểm truyền frame', N'Kiểm soát thòi gian truyền frame', N'A', N'TH123   ', N'901abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (207, N'MMTCB', N'C', N'Cấp nào trong mô hình OSI quan tâm tới topology mạng', N'Transport', N'Network', N'Data link', N'Physical', N'B', N'TH123   ', N'911abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (208, N'MMTCB', N'C', N'Loại mạng nào sử dụng trên WAN', N'Ethernet và Token-bus', N'ISDN và Frame relay', N'Token-ring và FDDI', N'SDLC và HDLC', N'A', N'TH123   ', N'921abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (209, N'MMTCB', N'C', N'Repeater nhiều port là tên gọi của', N'Hub', N'Host', N'Bridge', N'Router', N'A', N'TH123   ', N'931abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (210, N'MMTCB', N'C', N'Đơn vị đo tốc độ đường truyền', N'bps(bit per second)', N'Bps(Byte per second)', N'mps(meter per second)', N'hertz (ccle per second)', N'A', N'TH123   ', N'941abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (211, N'MMTCB', N'C', N'Repeater dùng để', N'Lọc bớt dữ liệu trên mạng', N'Tăng tốc độ lưu thông trên mạng', N'Tăng thời gian trễ trên mạng', N'Mở rộng chiều dài đường truyền', N'D', N'TH123   ', N'951abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (212, N'MMTCB', N'C', N'Cáp đồng trục (coaxial)', N'Có 4 đôi dây', N'Không cần repeater', N'Truyền tín hiệu ánh sáng', N'Chống nhiễu tốt hơn UTP', N'D', N'TH123   ', N'961abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (213, N'MMTCB', N'C', N'Câp Data link ', N'Truyền dữ liệu cho các cấp khác trong mạng', N'Cung cấp dịch vụ cho chương trình ứng dụng', N'Nhận tín hiệu yếu,lọc,khuếch đại và phát lại trên mạng', N'Bảo đảm đường truyền dữ liệu tin cậy giữa 2 đầu đường truyền', N'D', N'TH123   ', N'971abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (214, N'MMTCB', N'C', N'Địa chỉ IP còn gọi là', N'Địa chĩ vật lý', N'Địa chỉ luận lý', N'Địa chỉ thập phân', N'Địa chỉ thập lục phân', N'B', N'TH123   ', N'981abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (215, N'MMTCB', N'C', N'Cấp Presentation', N'Thiết lập, quản lý và kết thúc các ứng dụng', N'Hướng dẫn cách mô tả hình ảnh, âm thanh, tiếng nói', N'Cung cấp dịch vụ truyền dữ liệu từ nguồn đến đích', N'Hỗ trợ việc truyền thông trong các ứng dụng như web, mail...', N'C', N'TH123   ', N'991abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (216, N'MMTCB', N'C', N'Tập các luật để định dạng và truyền dữ liệu gọi là', N'Qui luật (rule)', N'Nghi thức (protocol)', N'Tiêu chuẩn (standard)', N'Mô hình (model)', N'B', N'TH123   ', N'9a1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (217, N'MMTCB', N'C', N'Tại sao cần có tiêu chuẩn về mang', N'Định hướng phát triển phần cứng và phần mềm mới', N'LAN,MAN và WAN sử dụng các thiết bị khác nhau', N'Kết nối mạng giữa các quôc gia khác nhau', N'Tương thích về công nghệ để truyền thông được lẫn nhau', N'D', N'TH123   ', N'9b1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (218, N'MMTCB', N'C', N'Dữ liệu truyền trên mạng bằng', N'Mã ASCII', N'Số nhị phân', N'Không và một', N'Xung điện áp', N'D', N'TH123   ', N'9c1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (219, N'MMTCB', N'C', N'Mạng CSMA/CD', N'Kiểm tra để bảo đảm dữ liệu truyền đến đích', N'Kiểm tra đường truyền nếu rảnh mới truyền dữ liệu', N'Chờ 1 thời gian ngẫu nhiên rồi truyền  dữ liệu kế tiếp', N'Tất cả đều đúng', N'B', N'TH123   ', N'9d1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (220, N'MMTCB', N'C', N'Địa chỉ MAC ', N'Gồm có 32 bit', N'Còn gọi là địa chỉ logic', N'Nằm trong cấp Network', N'Dùng để phân biệt các máy trong mạng', N'D', N'TH123   ', N'9e1abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (224, N'LTW  ', N'A', N'kjck', N'kjdks', N'kdjfhsk', N'jdhf', N'kxjdfk', N'C', N'TH123   ', N'a01abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (225, N'AVCB ', N'A', N'Cháu lên ba cháu vô mẫu giáo, cô khen cháu cháu không khóc nhè.', N'1', N'2', N'3', N'4', N'C', N'TH123   ', N'a11abed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (256, N'AVCB ', N'B', N'a', N'c', N's', N'a', N'a', N'B', N'GV1     ', N'996fc514-4308-ea11-8d35-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (258, N'MMTCB', N'A', N'a', N'a', N'a', N'ãcc', N'a', N'A', N'ahy     ', N'2580fa55-300a-ea11-8d35-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (277, N'AVCB ', NULL, N'a', N'a', N'a', N'a', N'a', N'C', N'ahy     ', N'37bac67d-310a-ea11-8d35-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (278, N'AVCB ', NULL, N'a', N'a', N'a', N'a', N'a', N'A', N'ahy     ', N'696384ab-310a-ea11-8d35-caff28296269')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (279, N'LTMCB', N'A', N'sa', N'ss', N's', N's', N's', N'A', N'TH101   ', N'8371a378-760a-ea11-8d35-caff28296269')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS1', N'CO SO 1 ', N'11 Nguyễn Đình Chiểu Phường Đakao Q1', N'a219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS2', N'CO SO 2', N'Số 9 Man Thiện , quận 9', N'a319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'ahy     ', N'ahy', N'ahy', N'ahy', N'VT      ', N'ahy', N'dc4b2078-2c05-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'c       ', N'c', N'c', N'c', N'VT      ', N'c', N'1b6cf93d-2705-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'GV05    ', N'phạm', N'thùy', N'97 man thien', N'VT      ', NULL, N'690d9772-2405-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'GV1     ', N'Lê Thị', N'Thu', N'97 man thiện', N'VT      ', NULL, N'4b1aba44-1e05-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'gv2     ', N'aa', N'aaa', N'aaa', N'VT      ', N'aa', N'be7344b4-1e05-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'gv3     ', N'Phung Van', N'Khoa', N'97, man thien', N'CNTT    ', NULL, N'ea21f7e5-5107-ea11-8d35-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N't       ', N't', N't', N't', N'VT      ', N't', N'714eecad-2a05-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'TH101   ', N'KIEU DAC NGOC', N'THIEN', N'9,3A, Q.BINH TAN', N'VT      ', N'Tiến sĩ khoa học', N'af19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'th111   ', N'1', N'1', N'1', N'VT      ', N'1', N'0e6c7165-2805-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'TH123   ', N'PHAN VAN ', N'HAI', N'15/72 LE VAN THO F8 GO VAP', N'CNTT    ', N'Nghiên cứu sinh', N'b019bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'TH234   ', N'DAO VAN', N'TUYET', N'14/7 BUI DINH TUY TAN BINH', N'VT      ', NULL, N'b119bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'TH657   ', N'PHAN HONG', N'NGOC', N'TTTTT', N'VT      ', NULL, N'b219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'thuy123 ', N'Phạm Thị', N'Thủy', N'97, mam Thiện', N'VT      ', NULL, N'0e6499fc-2305-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'vv      ', N'v', N'v', N'v', N'VT      ', NULL, N'a3e87d40-5007-ea11-8d35-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'xx      ', N'xx', N'xx', N'xx', N'VT      ', N'x', N'ea617db0-2505-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [HOCVI], [rowguid]) VALUES (N'z       ', N'z', N'Thủy', N'z', N'VT      ', N'Thạc sĩ', N'68cf8ed6-3505-ea11-8d34-caff28296269')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'ahy     ', N'AVCB ', N'TH04    ', N'B', CAST(N'2019-11-20 12:00:00.000' AS DateTime), 1, 15, 15, N'2c15825d-f108-ea11-8d35-caff28296269')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'ahy     ', N'AVCB ', N'TH04    ', N'A', CAST(N'2019-11-27 00:00:00.000' AS DateTime), 2, 10, 20, N'5b7fa04f-5a08-ea11-8d35-caff28296269')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'LTMCB', N'TH04    ', N'A', CAST(N'2019-10-04 00:00:00.000' AS DateTime), 1, 10, 55, N'fb1ae52f-e509-ea11-8d35-caff28296269')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'ahyhy   ', N'abc', N'CS1', N'ab0937e9-af04-ea11-8d33-c8ff2829626a')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'CNTT    ', N'Công nghệ thông tin', N'CS1', N'ad19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'DPT     ', N'Đa phương tiện', N'CS1', N'000c052e-4f07-ea11-8d35-caff28296269')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'VT      ', N'Viễn thông', N'CS2', N'ae19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH04    ', N'TIN HOC 2004', N'CNTT    ', N'b419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH05    ', N'TIN HOC 2005', N'CNTT    ', N'b519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH06    ', N'TIN HOC 2006', N'CNTT    ', N'b619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH07    ', N'TIN HOC 2007', N'CNTT    ', N'b719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH08    ', N'TIN HOC 2008', N'CNTT    ', N'b819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'THCS    ', N'Tin học cơ sở 1', N'CNTT    ', N'3c3214ec-0907-ea11-8d34-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'VT04    ', N'DET MAY 2004', N'VT      ', N'b319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'VT11    ', N'Cong nghe pm', N'VT      ', N'a346a115-a803-ea11-8d33-c8ff2829626a')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'AVCB ', N'ANH VAN CAN BAN', N'a419bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDL ', N'CO SO DU LIEU 1', N'a619bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CTDL ', N'CAU TRUC DU LIEU', N'a519bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'HQT  ', N'HE QUAN TRI CSDL', N'a719bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'KTTSL', N'KY THUAT TRUYEN SO LIEU', N'a819bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'LTMCB', N'LAP TRINH MANG CO BAN', N'a919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'LTW  ', N'LAP TRINH TREN WINDOW', N'aa19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'MMTCB', N'MANG MAY TINH CAN BAN', N'ab19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'001     ', N'LE VAN ', N'THANH', CAST(N'1985-03-06 00:00:00.000' AS DateTime), N'23/5 PHUNG KHAC KHOAN F3 Q3', N'TH04    ', N'b919bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'002     ', N'DAO TRONG', N'KHAI', CAST(N'1979-08-19 00:00:00.000' AS DateTime), N'15/72 LE VAN THO F8 GOVAP', N'TH04    ', N'ba19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'003     ', N'CAO TUAN', N'KHA', CAST(N'1985-12-06 00:00:00.000' AS DateTime), N'12/5 LE QUANG DINH F5 GO VAP', N'TH04    ', N'bb19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'004     ', N'TRINH THANH ', N'BINH', CAST(N'1984-03-24 00:00:00.000' AS DateTime), N'23/4 HOANG HOA THAM', N'TH04    ', N'bc19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'005     ', N'NGUYEN THUY ', N'VAN', CAST(N'1987-11-06 00:00:00.000' AS DateTime), N'7 HUYNH THUC KHANG', N'TH05    ', N'bd19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'006     ', N'NGUYEN NGOC ', N'YEN', CAST(N'1980-11-23 00:00:00.000' AS DateTime), N'3/5 AN DUONG VUONG', N'TH05    ', N'be19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'007     ', N'NGUYEN THUY ', N'DUNG', CAST(N'1988-05-23 00:00:00.000' AS DateTime), N'8 HUYNH VAN BANH f1 q binh thanh', N'TH05    ', N'bf19bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'008     ', N'TRINH', N'PHONG', CAST(N'1985-12-10 00:00:00.000' AS DateTime), N'GGG', N'TH08    ', N'c019bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'009     ', N'TRAN THANH', N'HUNG', CAST(N'1985-03-28 00:00:00.000' AS DateTime), N'jhjhj', N'TH05    ', N'c119bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'010     ', N'SDFSD', N'SDFSDF', CAST(N'1985-03-26 00:00:00.000' AS DateTime), N'dfsd', N'TH05    ', N'c219bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'011     ', N'PHAN HONG', N'NGOC', CAST(N'1986-01-17 00:00:00.000' AS DateTime), N'PHAN VAN HAN BINH THANH', N'TH05    ', N'c319bed3-b7e5-e911-8d30-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'012     ', N'Phạm Thị', N'Thủy', CAST(N'1998-06-06 00:00:00.000' AS DateTime), N'Phạm Thị Thủy', N'VT04    ', N'c2c9fa25-c502-ea11-8d33-c8ff2829626a')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'013     ', N'Lê Thị Hồng', N'Sương', CAST(N'1998-03-04 00:00:00.000' AS DateTime), N'97, Man Thiện', N'VT04    ', N'0e5208cc-6105-ea11-8d34-caff28296269')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [rowguid]) VALUES (N'014     ', N'Hồ Phương', N'Thanh', CAST(N'1998-02-02 00:00:00.000' AS DateTime), N'97, Man Thiện', N'TH05    ', N'd862cc08-6205-ea11-8d34-caff28296269')
/****** Object:  Index [UK_MABD]    Script Date: 11/21/2019 4:57:38 PM ******/
ALTER TABLE [dbo].[BANGDIEM] ADD  CONSTRAINT [UK_MABD] UNIQUE NONCLUSTERED 
(
	[MABD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_TENCS]    Script Date: 11/21/2019 4:57:38 PM ******/
ALTER TABLE [dbo].[COSO] ADD  CONSTRAINT [UK_TENCS] UNIQUE NONCLUSTERED 
(
	[TENCS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_TENKH]    Script Date: 11/21/2019 4:57:38 PM ******/
ALTER TABLE [dbo].[KHOA] ADD  CONSTRAINT [UK_TENKH] UNIQUE NONCLUSTERED 
(
	[TENKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENLOP]    Script Date: 11/21/2019 4:57:38 PM ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [UN_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UN_TENMH]    Script Date: 11/21/2019 4:57:38 PM ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [UN_TENMH] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_BAITHI_BANGDIEM] FOREIGN KEY([MaBD])
REFERENCES [dbo].[BANGDIEM] ([MABD])
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [FK_BAITHI_BANGDIEM]
GO
ALTER TABLE [dbo].[BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_BAITHI_BODE] FOREIGN KEY([CauSo])
REFERENCES [dbo].[BODE] ([CAUHOI])
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [FK_BAITHI_BODE]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_MONHOC]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_SINHVIEN1] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_SINHVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_KHOA]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1]
GO
ALTER TABLE [dbo].[KHOA]  WITH CHECK ADD  CONSTRAINT [FK_KHOA_COSO] FOREIGN KEY([MACS])
REFERENCES [dbo].[COSO] ([MACS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHOA] CHECK CONSTRAINT [FK_KHOA_COSO]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
ALTER TABLE [dbo].[BAITHI]  WITH NOCHECK ADD  CONSTRAINT [repl_identity_range_E4F15693_856B_44E3_BDE9_48CE3454A89C] CHECK NOT FOR REPLICATION (([CauHoi]>(11) AND [CauHoi]<=(1011) OR [CauHoi]>(1011) AND [CauHoi]<=(2011)))
GO
ALTER TABLE [dbo].[BAITHI] CHECK CONSTRAINT [repl_identity_range_E4F15693_856B_44E3_BDE9_48CE3454A89C]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_DIEM]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_LANTHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_LANTHI]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [repl_identity_range_37AA6655_5164_421C_BAAA_4A83CF7ADB8A] CHECK NOT FOR REPLICATION (([MABD]>(1004) AND [MABD]<=(2004) OR [MABD]>(46004) AND [MABD]<=(47004)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [repl_identity_range_37AA6655_5164_421C_BAAA_4A83CF7ADB8A]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_BODE] CHECK  (([TRINHDO]='A' OR [TRINHDO]='B' OR [TRINHDO]='C'))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_BODE]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN] CHECK  (([DAP_AN]='D' OR ([DAP_AN]='C' OR ([DAP_AN]='B' OR [DAP_AN]='A'))))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_DAPAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_LAN] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_LAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_SOCAUTHI] CHECK  (([SOCAUTHI]>=(10) AND [SOCAUTHI]<=(100)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_SOCAUTHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_THOIGIAN] CHECK  (([THOIGIAN]>=(15) AND [THOIGIAN]<=(60)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_THOIGIAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_TRINHDO] CHECK  (([TRINHDO]='C' OR ([TRINHDO]='B' OR [TRINHDO]='A')))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_TRINHDO]
GO
/****** Object:  StoredProcedure [dbo].[SP_BAITHI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BAITHI] @maLop nchar(8) , @maSV nchar(8), @maMH nchar(5), @lan smallint

AS 
	DECLARE @ngayThi datetime, @soCauThi int, @trinhDo nchar(1), @maBD int, @res int, @subRes int

	
	-- res: so cau tim duoc trong BO DE
	SET XACT_ABORT ON
	BEGIN TRANSACTION

	BEGIN TRY
		create table #temp1 
		(idCauHoi int,cauhoi int, noidung ntext, a ntext, b ntext, c ntext, d ntext, dap_an char(1), ma_BD int)
	
	   -- select GIAOVIEN_DANGKI
		SELECT  @ngayThi = NGAYTHI, @soCauThi = SOCAUTHI, @trinhDo = TRINHDO FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @maLop AND LAN = @lan
		--insert bang diem
		SAVE TRANSACTION _BANGDIEM

		INSERT INTO BANGDIEM(MASV, MAMH, LAN, NGAYTHI)
		VALUES (@maSV, @maMH, @lan, @ngayThi);
		SELECT @maBD = SCOPE_IDENTITY()

		-- random cau hoi + insert bai thi
		SELECT @res = COUNT(CAUHOI) FROM BODE 
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  

		if(@res > @soCauThi)
			BEGIN
				INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DapAn, MaBD)
				SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN, @maBD FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				ORDER BY  NEWID()

				-- return ket qua
				insert into #temp1 (idCauHoi ,cauhoi, noidung, a , b , c , d , dap_an , ma_BD )
				SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DapAn, MaBD FROM BAITHI
				WHERE MaBD = @maBD

				select * from #temp1


			END
		else if(@res < @soCauThi)
			BEGIN
				SELECT @subRes = COUNT(CAUHOI) FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				
				if(@subRes < @soCauThi - @res)
					BEGIN
						 ROLLBACK TRANSACTION _BANGDIEM
						RAISERROR('Không đủ số câu để tạo đề!', 16, 1)
					END
				else if(@subRes >= @soCauThi - @res)
					BEGIN 
						INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DapAn, MaBD)
						SELECT TOP (@res) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
		
						INSERT INTO BAITHI (CauSo, NoiDung, A, B, C, D,DapAn, MaBD)
						SELECT TOP (@soCauThi - @res) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN,@maBD FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()
					
						-- reurn ket qua
						insert into #temp1 (idCauHoi ,cauhoi, noidung, a , b , c , d , dap_an , ma_BD )
						SELECT CauHoi,CauSo,NoiDung, A,B,C,D, DapAn, MaBD FROM BAITHI
						WHERE MaBD = @maBD
						
						select * from #temp1
					END
			END
COMMIT
	END TRY
	BEGIN CATCH
	   ROLLBACK
	   DECLARE @ErrorMessage VARCHAR(2000)
	   SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
	   RAISERROR(@ErrorMessage, 16, 1)
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[sp_chuyenKhoa]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_chuyenKhoa](@MAKH nchar(8),
							   @MAGV nchar(8))
    AS
    BEGIN
        UPDATE dbo.GIAOVIEN 
		SET MAKH = @MAKH
		WHERE MAGV = @MAGV
	IF  exists(SELECT * from  dbo.GIAOVIEN where MAGV = @MAGV AND MAKH = @MAKH)
   		raiserror ('Chuyển khoa thành công',16,1)
	ELSE
        raiserror ('Chuyển khoa thất bại',16,1)
    END;
GO
/****** Object:  StoredProcedure [dbo].[SP_CHUYENLOP]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHUYENLOP]
	(@MALOP nchar(8),
	 @MASV nchar(8))
    AS
    BEGIN
        UPDATE dbo.SINHVIEN 
		SET MALOP = @MALOP
		WHERE MASV = @MASV
	IF  exists(SELECT * from  dbo.SINHVIEN where MASV = @MASV AND MALOP = @MALOP)
   		raiserror ('Chuyển lớp thành công',16,1)
	ELSE
        raiserror ('Chuyển lớp thất bại',16,1)
    END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSach_DK_Thi]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DanhSach_DK_Thi]
@fromDate datetime,
@toDate datetime
AS

	SELECT DISTINCT LOP.TENLOP, MONHOC.TENMH, CONCAT(GIAOVIEN.HO,' ',GIAOVIEN.TEN) AS HOTEN, GVDK.SOCAUTHI, CONVERT(DATE, GVDK.NGAYTHI) AS NGAYTHI, dbo.checkMH(MONHOC.MAMH) AS DATHI  FROM GIAOVIEN_DANGKY GVDK 
	inner join LOP ON ( (GVDK.NGAYTHI BETWEEN @fromDate AND @toDate) AND lOP.MALOP = GVDK.MALOP)
	inner join MONHOC ON (GVDK.MAMH = MONHOC.MAMH)
	inner join GIAOVIEN ON (GVDK.MAGV = GIAOVIEN.MAGV)

	ORDER BY NGAYTHI ASC
GO
/****** Object:  StoredProcedure [dbo].[SP_DSBODE]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_DSBODE]
  @MAMH nchar(5)
AS
BEGIN
	SELECT * FROM dbo.BODE WHERE MAMH = @MAMH
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DSLanThi]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DSLanThi]
@maSV nchar(8),
@maMH nchar(5)

AS 
	BEGIN
		SELECT LAN FROM BANGDIEM WHERE BANGDIEM.MASV = @maSV AND BANGDIEM.MAMH =@maMH AND BANGDIEM.DIEM IS NULL
	END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DSLanThiDK]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DSLanThiDK]
@maMH nchar(5),
@maLop nchar(8)
AS
BEGIN
		SELECT DISTINCT  GVDK.LAN FROM GIAOVIEN_DANGKY GVDK INNER JOIN MONHOC ON  (GVDK.MALOP=@maLop AND GVDK.MAMH=@maMH AND GVDK.MAMH=MONHOC.MAMH)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DSLanThiThuGV]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DSLanThiThuGV]
@maMH nchar(5),
@maLop nchar(8)

AS 
	
BEGIN
		SELECT DISTINCT  GVDK.LAN FROM GIAOVIEN_DANGKY GVDK 
		INNER JOIN MONHOC ON  (GVDK.MALOP=@maLop AND GVDK.MAMH=@maMH AND GVDK.MAMH=MONHOC.MAMH)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DSMHDK]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DSMHDK]
@maLop nchar(8)
AS
BEGIN
		SELECT DISTINCT  MONHOC.MAMH, MONHOC.TENMH FROM GIAOVIEN_DANGKY GVDK INNER JOIN MONHOC ON  (GVDK.MALOP=@maLop AND GVDK.MAMH=MONHOC.MAMH)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INBAITHI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INBAITHI]
@maSV nchar(8),
@maMH nchar(5),
@lan smallint

AS 
 BEGIN
	DECLARE @maBD int;

	SELECT @maBD =  BANGDIEM.MABD FROM BANGDIEM WHERE BANGDIEM.MASV = @maSV AND BANGDIEM.MAMH = @maMH AND BANGDIEM.LAN = @lan;
	SELECT BAITHI.CauSo, BAITHI.NoiDung, CONCAT(N'A. ' , CONVERT(NVARCHAR(MAX),BAITHI.A)) AS A ,CONCAT( N'B. ' , CONVERT(NVARCHAR(MAX),BAITHI.B)) AS B ,CONCAT( N'C. ' , CONVERT(NVARCHAR(MAX),BAITHI.C) ) AS C ,CONCAT(N'D. ' , CONVERT(NVARCHAR(MAX),BAITHI.D))  AS D , BAITHI.DapAn, BAITHI.DaChon FROM BAITHI WHERE BAITHI.MaBD = @maBD
 END;
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_GVDK]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_GVDK]
  @MAMH nchar(5),
  @MALOP nchar(8),
  @LAN smallint
AS

IF exists(select * from dbo.GIAOVIEN_DANGKY where MAMH =@MAMH AND MALOP =@MALOP AND LAN= @LAN)
	raiserror ('Môn học này lớp này và lần thi này đã tồn tại, vui lòng nhập lại',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_KT_LOP_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_LOP_TONTAI]
  @MALOP nchar(8),
  @TenLop nvarchar(50)
AS

IF exists(select MALOP from LINK2.TN.dbo.LOP where MALOP =@MALOP)
	raiserror ('Mã lớp đã tồn tại, vui lòng nhập lại',16,1)

ELSE IF exists(SELECT TENLOP from LINK2.TN.dbo.LOP where TENLOP =@TenLop)
	raiserror ('Tên lớp đã tồn tại, vui lòng nhập lại',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KT_MA_BO_DE]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_MA_BO_DE]
  @MACAUHOI INT
AS

IF exists(select * from dbo.BODE where CAUHOI = @MACAUHOI)
	raiserror ('Mã câu hỏi đã tồn tại, vui lòng nhập lại',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KT_MONHOC_TON_TAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_KT_MONHOC_TON_TAI]
  @MAMH nchar(8),
  @TENMH varchar(40)
AS
	If  exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @MAMH)
   		raiserror ('Mã môn học đã tồn tại, vui lòng nhập mã khác',16,1)

	If  exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TENMH)
		raiserror ('Tên môn học đã tồn tại, vui lòng nhập tên khác',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KT_TEN_Khoa_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_TEN_Khoa_TONTAI]
	@MAKH nchar(8),
	@TENKH nvarchar(50)

AS

BEGIN
	IF exists(select TENKH from LINK2.TN.dbo.khoa where TENKH =@TENKH AND MAKH != @MAKH)
		raiserror ('Tên khoa đã tồn tại, vui lòng đặt tên khác',16,1)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_KT_TEN_MONHOC_TON_TAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_KT_TEN_MONHOC_TON_TAI]
  @MAMH nchar(8),
  @TENMH varchar(40)
AS
	IF  exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TENMH AND MAMH!= @MAMH)
		raiserror ('Tên môn học đã tồn tại, vui lòng nhập tên khác',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KT_XOA_GVDK]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KT_XOA_GVDK]
  @MAMH nchar(5),
  @MALOP nchar(8),
  @LAN smallint
AS
BEGIN
	
	SELECT BANGDIEM.MASV INTO ##tb_tamSV FROM dbo.SINHVIEN JOIN dbo.BANGDIEM ON BANGDIEM.MASV = SINHVIEN.MASV WHERE LAN = @LAN AND MAMH =@MAMH

	SELECT dbo.SINHVIEN.MALOP INTO ##tamLop FROM ##tb_tamSV JOIN dbo.SINHVIEN ON SINHVIEN.MASV = ##tb_tamSV.MASV GROUP BY MALOP

	IF exists(select * FROM ##tamLop WHERE MALOP = @MALOP)
		raiserror ('Thông tin của giảng viên đăng ký này đã tồn tại trong bảng bảng điểm, Không thể xóa',16,1)

	DROP TABLE ##tb_tamSV;
	DROP TABLE ##tamLop;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KTGV_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_KTGV_TONTAI]
  @MAGV nchar(8)
AS
 
  
If  exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV =@MAGV)
   	raiserror ('Mã GV đã tồn tại, vui lòng chọn mã khác',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KTKhoa_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KTKhoa_TONTAI]
  @MAKH nchar(8),
  @TENKH nvarchar(50)
AS

BEGIN
	IF exists(select MAKH from LINK2.TN.dbo.khoa where MAKH =@MAKH)
		raiserror ('Mã khoa đã tồn tại, vui lòng đặt mã khác',16,1)

	IF exists(select TENKH from LINK2.TN.dbo.khoa where TENKH =@TENKH)
		raiserror ('Tên khoa đã tồn tại, vui lòng đặt tên khác',16,1)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_KTLANTHI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KTLANTHI]
@MASV CHAR(8), @MAMH CHAR(5), @LAN INT
AS

IF EXISTS (SELECT * FROM BANGDIEM WHERE MASV= @MASV AND MAMH =@MAMH AND LAN =@LAN)
	raiserror ('Sinh viên đã thi lần này, không được thi lại',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KTMALop_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KTMALop_TONTAI]
  @MALOP nchar(8),
  @TenLop nvarchar(50)
AS
	IF exists(SELECT TENLOP from LINK2.TN.dbo.LOP where TENLOP =@TenLop AND MALOP!=@MALOP)
		RAISERROR ('Tên lớp đã tồn tại, vui lòng nhập lại',16,1)


GO
/****** Object:  StoredProcedure [dbo].[SP_KTSV_DANGNHAP]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_KTSV_DANGNHAP]
  @MASV  nchar(8)
AS
	IF exists(select masv from dbo.sinhvien where masv =@MASV)
		SELECT * FROM dbo.SINHVIEN where masv =@MASV
	else
		raiserror ('Mã Sinh Viên không tồn tại trong danh sách, vui lòng kiểm tra lại',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_KTSV_TONTAI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KTSV_TONTAI] @X nchar(8)
AS
IF exists(select masv from LINK2.TN.dbo.sinhvien where masv =@X)
		raiserror ('Mã Sinh Viên đã tồn tại, vui lòng nhập lại',16,1)

GO
/****** Object:  StoredProcedure [dbo].[SP_LanThiSV]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LanThiSV]
@maSV nchar(8),
@maMH nchar(5)

AS 
	BEGIN
		SELECT LAN FROM BANGDIEM WHERE BANGDIEM.MASV = @maSV AND BANGDIEM.MAMH =@maMH AND BANGDIEM.DIEM IS NOT NULL
	END;


GO
/****** Object:  StoredProcedure [dbo].[SP_LAY_TT_DANGNHAP]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LAY_TT_DANGNHAP]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM dbo.GIAOVIEN  WHERE MAGV = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))



GO
/****** Object:  StoredProcedure [dbo].[SP_LAY_TT_DANGNHAP_SV]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LAY_TT_DANGNHAP_SV]
@TENLOGIN NVARCHAR (50),
@maSV nchar(8)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM dbo.SINHVIEN  WHERE MASV = @maSV ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= (SELECT UID FROM sys.sysusers 
                                      WHERE NAME=@TENUSER))
GO
/****** Object:  StoredProcedure [dbo].[SP_MA_GV_CHUA_TAO_TK]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_MA_GV_CHUA_TAO_TK]
AS
BEGIN
	SELECT name as MAGV,
		   type_desc as type
		   INTO  ##Users
	FROM sys.database_principals
	WHERE type not in ('A', 'G', 'R', 'X')
		  and sid is not null
		  and name != 'guest'
	ORDER BY MAGV;

	SELECT GIAOVIEN.MAGV , HO +' '+TEN AS TEN
		FROM dbo.GIAOVIEN LEFT JOIN ##Users 
			ON GIAOVIEN.MAGV =##Users.MAGV
		where ##Users.MAGV IS NULL; 
		--GROUP BY dbo.GIAOVIEN.MAGV

	DROP TABLE ##Users
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_MonHocSV]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MonHocSV]
	@maSV NCHAR(8)
AS
	BEGIN
		SELECT DISTINCT MONHOC.MAMH, MONHOC.TENMH FROM BANGDIEM INNER JOIN MONHOC ON (BANGDIEM.MASV = @maSV AND BANGDIEM.MAMH = MONHOC.MAMH) 
	END;
	

GO
/****** Object:  StoredProcedure [dbo].[sp_TaoTaiKhoan]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_TaoTaiKhoan]
	@LGNAME VARCHAR(50),
	@PASS VARCHAR(50),
	@USERNAME VARCHAR(50),
	@ROLE VARCHAR(50)
AS
BEGIN
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS,'TN'                     

  IF (@RET =1)  -- LOGIN NAME BI TRUNG
     RETURN 1

  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME
  IF (@RET =1)  -- USER  NAME BI TRUNG

  BEGIN
       EXEC SP_DROPLOGIN @LGNAME
       RETURN 2
  END

  EXEC sp_addrolemember @ROLE, @USERNAME

  IF @ROLE= 'Truong'  OR @ROLE ='Coso'
	BEGIN
		EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END

  ELSE IF @ROLE= 'Giangvien'
	BEGIN  
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END

	RETURN 0  -- THANH CONG
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ThiThu]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ThiThu] @maLop nchar(8) , @maMH nchar(5), @lan smallint

AS 
	DECLARE @soCauThi int, @trinhDo nchar(1), @maBD int, @res int, @subRes int
	-- res: so cau tim duoc trong BO DE
	SET XACT_ABORT ON
	
	BEGIN TRY
		create table #temp1 
		(cauhoi int, noidung ntext, a ntext, b ntext, c ntext, d ntext, dap_an char(1))
		
	   -- select GIAOVIEN_DANGKI
		SELECT  @soCauThi = SOCAUTHI, @trinhDo = TRINHDO FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @maLop AND LAN = @lan
	
		-- random cau hoi 
		SELECT @res = COUNT(CAUHOI) FROM BODE 
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  

		if(@res > @soCauThi)
			BEGIN
				-- return ket qua
				SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				ORDER BY  NEWID()
			END
		else if(@res < @soCauThi)
			BEGIN
				SELECT @subRes = COUNT(CAUHOI) FROM BODE 
				WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
				
				if(@subRes < @soCauThi - @res)
					RAISERROR('Không đủ số câu để tạo đề!' , 16, 1)
				else if(@subRes >= @soCauThi - @res)
					BEGIN 
						-- reurn ket qua
						insert into #temp1 (cauhoi , noidung, a , b , c , d , dap_an  )
						SELECT TOP (@res) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()

						insert into #temp1 (cauhoi , noidung, a , b , c , d , dap_an  )
						SELECT TOP (@soCauThi - @res) CAUHOI, NOIDUNG, A,B,C,D,DAP_AN FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))  
						ORDER BY  NEWID()

						select * from #temp1 
					
					END
			END
			
	END TRY
	BEGIN CATCH
	   DECLARE @ErrorMessage VARCHAR(2000)
	   SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
	   RAISERROR(@ErrorMessage, 16, 1)
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_THONGTINLANTHI]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_THONGTINLANTHI]
@MALOP CHAR(8), @MAMH CHAR(5), @LAN INT
AS

BEGIN
	IF EXISTS (SELECT * FROM GIAOVIEN_DANGKY WHERE MALOP=@MALOP AND MAMH=@MAMH AND LAN=@LAN )
		SELECT TRINHDO, SOCAUTHI, THOIGIAN,NGAYTHI FROM GIAOVIEN_DANGKY
		WHERE MALOP=@MALOP AND MAMH=@MAMH AND LAN=@LAN

	ELSE 
		RAISERROR ('Không tìm thấy thông tin thi',16,1)
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_XemKetQuaSV]    Script Date: 11/21/2019 4:57:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XemKetQuaSV]

@MaLop nchar(8),
@MaMH nchar(5),
@LanThi smallint

AS
	SELECT SV.MASV, SV.HO, SV.TEN, BD.DIEM, dbo.Num2Text(BD.DIEM) AS DIEMCHU FROM GIAOVIEN_DANGKY GVDK 
	JOIN BANGDIEM BD ON ( GVDK.MALOP=@MaLop AND GVDK.MAMH=@MaMH AND GVDK.LAN=@LanThi AND BD.MAMH = GVDK.MAMH AND BD.LAN = GVDK.LAN)
	JOIN SINHVIEN SV ON(SV.MASV = BD.MASV)

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PUBS"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SUBS"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "COSO"
            Begin Extent = 
               Top = 6
               Left = 360
               Bottom = 136
               Right = 530
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DS_COSO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DS_COSO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LOP"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DSLOP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DSLOP'
GO
