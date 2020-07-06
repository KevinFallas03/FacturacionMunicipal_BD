USE [FacturacionMunicipal]
GO

ALTER TABLE [dbo].[CCobro_ConsumoAgua] DROP CONSTRAINT [FK_CC Consumo_Concepto Cobro]
GO

/****** Object:  Table [dbo].[CCobro_ConsumoAgua]    Script Date: 6/7/2020 13:37:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CCobro_ConsumoAgua]') AND type in (N'U'))
DROP TABLE [dbo].[CCobro_ConsumoAgua]
GO

/****** Object:  Table [dbo].[CCobro_ConsumoAgua]    Script Date: 6/7/2020 13:37:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro_ConsumoAgua](
	[ID] [int] NOT NULL,
	[ConsumoM3] [int] NOT NULL,
	[MontoMinimoRecibo] [int] NOT NULL,
 CONSTRAINT [PK_CC Consumo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CCobro_ConsumoAgua]  WITH CHECK ADD  CONSTRAINT [FK_CC Consumo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[CCobro_ConsumoAgua] CHECK CONSTRAINT [FK_CC Consumo_Concepto Cobro]
GO


