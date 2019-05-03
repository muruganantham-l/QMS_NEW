USE [tomms_prod]
GO

/****** Object:  Table [dbo].[PRM_score_card_circle_tbl]    Script Date: 20/3/2019 3:49:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PRM_score_card_circle_tbl](
	[circlename] [varchar](100) NULL,
	[equipment_type] [varchar](50) NULL,
	[wkr_mst_org_date] [datetime] NULL,
	[year_wo] [int] NULL,
	[month_wo] [varchar](50) NULL,
	[wko_mst_status] [varchar](50) NULL,
	[ast_det_varchar22] [varchar](50) NULL,
	[wo_type] [varchar](50) NULL,
	[ast_mst_asset_no] [varchar](50) NULL,
	[ast_mst_parent_id] [varchar](50) NULL,
	[mr_no] [varchar](50) NULL,
	[wo_no] [varchar](50) NULL,
	[wko_mst_ast_cod] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


