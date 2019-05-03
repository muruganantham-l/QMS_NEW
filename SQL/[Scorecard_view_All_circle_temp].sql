USE [tomms_prod]
GO

/****** Object:  Table [dbo].[PRM_Scorecard_view_All_circle_temp]    Script Date: 2/4/2019 7:21:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Scorecard_view_All_circle_temp](
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


