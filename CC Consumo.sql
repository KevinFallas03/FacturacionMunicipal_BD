USE [Tarea Programada 1]
GO

/****** Object:  Table [dbo].[CC Consumo]    Script Date: 14/3/2020 04:44:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC Consumo](
	[ID] [int] NOT NULL,
	[Valor_Unidad] [money] NOT NULL,
 CONSTRAINT [PK_CC Consumo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CC Consumo]  WITH CHECK ADD  CONSTRAINT [FK_CC Consumo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[Concepto Cobro] ([ID])
GO

ALTER TABLE [dbo].[CC Consumo] CHECK CONSTRAINT [FK_CC Consumo_Concepto Cobro]
GO

