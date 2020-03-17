USE [Tarea Programada 1]
GO

/****** Object:  Table [dbo].[Concepto Cobro]    Script Date: 14/3/2020 04:46:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Concepto Cobro](
	[ID] [int] NOT NULL,
	[Nombre] [nchar](100) NOT NULL,
	[Tasa_Int_Mor] [float] NOT NULL,
	[Q_dias_Venc] [int] NOT NULL,
 CONSTRAINT [PK_Concepto Cobro] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

