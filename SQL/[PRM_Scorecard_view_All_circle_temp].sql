USE [tomms_prod]
GO

/****** Object:  Table [dbo].[PRM_Scorecard_view_All_circle_temp]    Script Date: 20/3/2019 3:48:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PRM_Scorecard_view_All_circle_temp](
	[circle Name] [varchar](30) NULL,
	[Equip.Type] [varchar](14) NULL,
	[Year OF WO] [int] NULL,
	[Month OF WO] [nvarchar](66) NULL,
	[Types] [varchar](50) NULL,
	[NumberOf WO] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


