USE [FacturacionMunicipal]
GO

/****** Object:  Table [dbo].[Propiedad]    Script Date: 6/7/2020 15:04:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Propiedad]') AND type in (N'U'))
DROP TABLE [dbo].[Propiedad]
GO

/****** Object:  Table [dbo].[Propiedad]    Script Date: 6/7/2020 15:04:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Propiedad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NumFinca] [int] NOT NULL,
	[Valor] [money] NOT NULL,
	[Direccion] [varchar](150) NOT NULL,
	[FechaIngreso] [datetime] NOT NULL,
	[M3Acumulados] [int] NOT NULL,
	[M3AcumuladosUltimoRecibo] [int] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Propiedad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


