USE [HRMS40]
GO

/****** Object:  Table [dbo].[aml_ars_ssis_tbl]    Script Date: 9/18/2017 11:27:50 AM ******/
DROP TABLE [dbo].[aml_ars_ssis_tbl]
GO

/****** Object:  Table [dbo].[aml_ars_ssis_tbl]    Script Date: 9/18/2017 11:27:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[aml_ars_ssis_tbl](
	[employee_code] [varchar](200) NULL,
	[attendance_date] [varchar](200) NULL,
	[attendance_time] [varchar](200) NULL,
	[io_flag] [varchar](200) NULL,
	[file_name1] [varchar](200) NULL,
	[session_id] [dbo].[udd_guid] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


