USE [tomms_prod]
GO
DROP	table [sm_penalty_monthly_report_tbl]
go
/****** Object:  Table [dbo].[sm_penalty_monthly_report_tbl]    Script Date: 13/9/2018 5:59:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sm_penalty_monthly_report_tbl](
	[month_year] [varchar](250) NULL,
	[clinic_name] [varchar](250) NULL,
	[clinic_category] [varchar](250) NULL,
	[district] [varchar](250) NULL,
	[state] [varchar](250) NULL,
	[no] [varchar](250) NULL,
	[be_number] [varchar](250) NULL,
	[be_category] [varchar](250) NULL,
	[be_group] [varchar](250) NULL,
	[equipment_cost] numeric(28,2),
	[sm_type] [varchar](250) NULL,
	[wo_number] [varchar](250) NULL,
	[wo_start_datetime] [varchar](250) NULL,
	[wo_cmpl_datetime] [varchar](250) NULL,
	[sm_penalty_rate_month] numeric(28,2),
	[vcm_proposed_amount] numeric(28,2),
	[disputed] [varchar](250) NULL,
	[vcm_agreed_amount] numeric(28,2),
	[status] [varchar](250) NULL,
	[remarks] [varchar](250) NULL,
	[session_id] [varchar](300) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
