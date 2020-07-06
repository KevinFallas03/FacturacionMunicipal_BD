USE [FacturacionMunicipal]
GO

/****** Object:  Table [dbo].[Recibo]    Script Date: 6/7/2020 14:36:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Recibo]') AND type in (N'U'))
DROP TABLE [dbo].[Recibo]
GO

/****** Object:  Table [dbo].[Recibo]    Script Date: 6/7/2020 14:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Recibo](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdCCobro] [int] NOT NULL,	
	[Monto] [money] NOT NULL,
	[Estado] [bit] NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[FechaMaximaPago] [datetime] NOT NULL,
) ON [PRIMARY]
GO


