USE [tomms_prod]
GO

/****** Object:  Table [dbo].[Tsd_penalty_report_tab]    Script Date: 18/01/2018 12:29:40 PM ******/
IF Exists (SELECT '*' FROM SYS.tables (NOLOCK)
			WHERE NAME = 'Tsd_Uptime_Detail_tab')
BEGIN
	DROP TABLE [dbo].[Tsd_Uptime_Detail_tab]
END
GO

/****** Object:  Table [dbo].[Tsd_penalty_report_tab]    Script Date: 18/01/2018 12:29:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Tsd_Uptime_Detail_tab](
	[GUID] [varchar](100) NULL,
	[WO Number] [varchar](100) NULL,
	[WR Number] [varchar](100) NULL,
	[Assign To] [varchar](100) NULL,
	[Employee Name] [varchar](100) NULL,
	[WO Date && Time] [datetime] NULL,
	[Wr Datetime] [datetime] NULL,
	[Response Date && Time] [datetime] NULL,
	[Completion Date && Time] [datetime] NULL,
	[Asset_no] [varchar](100) NULL,
	[BE_Category] [varchar](500) NULL,
	[Asset_Cost] [numeric](30, 4) NULL,
	[BeGroup] [varchar](100) NULL,
	[MonthStart] [datetime] NULL,
	[MonthEnd] [datetime] NULL,
	[AgeofBE] [int] NULL,
	[BE Status] [varchar](100) NULL,
	[Zone] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[Circle] [varchar](100) NULL,
	[District] [varchar](100) NULL,
	[clinic_code] [varchar](100) NULL,
	[clinic_name] [varchar](500) NULL,
	[clinic_category] [varchar](100) NULL,
	[Remarks] [varchar](1000) NULL,
	[ClinicType] [varchar](100) NULL,
	[WO Status] [varchar](100) NULL,
	[Ownership] [varchar](100) NULL,
	[WR Status] [varchar](100) NULL,
	[WR Month] [varchar](100) NULL,
	[Actual Downtime] [int] NULL,
	[Total Downtime] [int] NULL,
	[Total Uptime] [int] NULL,
	[Actual Working Days Year] [int] NULL,
	[Actual Working Days Month] [int] NULL,
	[No Days Month] [int] NULL,
	[No Days Up Month]  [int] NULL,
	[Total No Days Up]  [int] NULL,
	[Holidays&Weekends] [int] NULL,
	[First Level Days] [int] NULL,
	[Second Level Days] [int] NULL,
	[First Level Status] [varchar](100) NULL,
	[Second Level Status] [varchar](100) NULL,
	[penalty_cost] [numeric](30, 4) NULL,
	[Uptime_penalty_cost] [numeric](30, 4) NULL,
	[Total_penalty_cost] [numeric](30, 4) NULL,
	[Period_Status] [varchar](100) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

IF Exists (SELECT '*' FROM SYS.tables (NOLOCK)
			WHERE NAME = 'Tsd_Uptime_report_tab')
BEGIN
	DROP TABLE [dbo].[Tsd_Uptime_report_tab]
END
GO

CREATE TABLE [dbo].[Tsd_Uptime_report_tab](
	[GUID] [varchar](100) NULL,
	[Asset_no] [varchar](100) NULL,
	[BE_Category] [varchar](500) NULL,
	[Asset_Cost] [numeric](30, 4) NULL,
	[BeGroup] [varchar](100) NULL,
	[MonthStart] [datetime] NULL,
	[MonthEnd] [datetime] NULL,
	[AgeofBE] [int] NULL,
	[BE Status] [varchar](100) NULL,
	[Zone] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[Circle] [varchar](100) NULL,
	[District] [varchar](100) NULL,
	[clinic_code] [varchar](100) NULL,
	[clinic_name] [varchar](500) NULL,
	[clinic_category] [varchar](100) NULL,
	[Remarks] [varchar](1000) NULL,
	[ClinicType] [varchar](100) NULL,
	[Ownership] [varchar](100) NULL,
	[Month Name] [varchar](100) NULL,
	[Actual Downtime] [int] NULL,
	[Total Downtime] [int] NULL,
	[Total Uptime] [int] NULL,
	[Actual Working Days Year] [int] NULL,
	[Actual Working Days Month] [int] NULL,
	[No Days Month] [int] NULL,
	[No Days Up Month]  [int] NULL,
	[Total No Days Up]  [int] NULL,
	[Holidays&Weekends] [int] NULL,
	[First Level Days] [int] NULL,
	[Second Level Days] [int] NULL,
	[First Level Status] [varchar](100) NULL,
	[Second Level Status] [varchar](100) NULL,
	[penalty_cost] [numeric](30, 4) NULL,
	[Uptime_penalty_cost] [numeric](30, 4) NULL,
	[Total_penalty_cost] [numeric](30, 4) NULL,
	[Period_Status] [varchar](100) NULL
) ON [PRIMARY]

GO