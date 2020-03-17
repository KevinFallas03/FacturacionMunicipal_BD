/** Query Tablas de la base de datos del Municipio**/
USE [master]
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

/****** Object:  Table [dbo].[CC Fijo]    Script Date: 14/3/2020 04:45:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC Fijo](
	[ID] [int] NOT NULL,
	[Monto] [money] NOT NULL,
 CONSTRAINT [PK_CC Fijo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CC Fijo]  WITH CHECK ADD  CONSTRAINT [FK_CC Fijo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[Concepto Cobro] ([ID])
GO

ALTER TABLE [dbo].[CC Fijo] CHECK CONSTRAINT [FK_CC Fijo_Concepto Cobro]
GO

/****** Object:  Table [dbo].[CC Porcentaje]    Script Date: 14/3/2020 04:46:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC Porcentaje](
	[ID] [int] NOT NULL,
	[Valor_Porcentual] [float] NOT NULL,
 CONSTRAINT [PK_CC Porcentaje] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CC Porcentaje]  WITH CHECK ADD  CONSTRAINT [FK_CC Porcentaje_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[Concepto Cobro] ([ID])
GO

ALTER TABLE [dbo].[CC Porcentaje] CHECK CONSTRAINT [FK_CC Porcentaje_Concepto Cobro]
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

/****** Object:  Table [dbo].[Int_Mor]    Script Date: 14/3/2020 04:47:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Int_Mor](
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_Int_Mor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Int_Mor]  WITH CHECK ADD  CONSTRAINT [FK_Int_Mor_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[Concepto Cobro] ([ID])
GO

ALTER TABLE [dbo].[Int_Mor] CHECK CONSTRAINT [FK_Int_Mor_Concepto Cobro]
GO