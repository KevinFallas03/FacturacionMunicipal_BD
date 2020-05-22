/** Query Tablas de la base de datos del Municipio**/
USE [Tarea Programada 1]
GO

/****** Object:  Table [dbo].[CCobro_ConsumoAgua]    Script Date: 22/5/2020 01:03:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro_ConsumoAgua](
	[ID] [int] NOT NULL,
	[ConsumoM3] [int] NOT NULL,
 CONSTRAINT [PK_CC Consumo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CCobro_ConsumoAgua]  WITH CHECK ADD  CONSTRAINT [FK_CC Consumo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[CCobro_ConsumoAgua] CHECK CONSTRAINT [FK_CC Consumo_Concepto Cobro]
GO

/****** Object:  Table [dbo].[CCobro_MontoFijo]    Script Date: 22/5/2020 01:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro_MontoFijo](
	[ID] [int] NOT NULL,
	[MontoFijo] [money] NOT NULL,
 CONSTRAINT [PK_CC Fijo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CCobro_MontoFijo]  WITH CHECK ADD  CONSTRAINT [FK_CC Fijo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[CCobro_MontoFijo] CHECK CONSTRAINT [FK_CC Fijo_Concepto Cobro]
GO

/****** Object:  Table [dbo].[CCobro_InteresMoratorio]    Script Date: 22/5/2020 01:05:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro_InteresMoratorio](
	[ID] [int] NOT NULL,
	[Valor_Porcentual] [float] NOT NULL,
 CONSTRAINT [PK_CC Porcentaje] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CCobro_InteresMoratorio]  WITH CHECK ADD  CONSTRAINT [FK_CC Porcentaje_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[CCobro_InteresMoratorio] CHECK CONSTRAINT [FK_CC Porcentaje_Concepto Cobro]
GO

/****** Object:  Table [dbo].[CCobro]    Script Date: 22/5/2020 01:07:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[TasaInteresMoratorio] [real] NOT NULL,
	[DiaEmisionRecibo] [tinyint] NOT NULL,
	[QDiasVencimiento] [tinyint] NOT NULL,
	[EsImpuesto] [bit] NOT NULL,
	[EsRecurrente] [bit] NOT NULL,
	[EsFijo] [bit] NOT NULL,
	[TipoCC] [varchar](30) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Concepto Cobro] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CCobro_PNP]    Script Date: 22/5/2020 00:45:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CCobro_PNP](
	[ID] [int] NOT NULL,
	[IdCCobbro] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[FechaInic] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
 CONSTRAINT [PK_CCobro_PNP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CCobro_PNP]  WITH CHECK ADD  CONSTRAINT [FK_CCobro_PNP_CCobro] FOREIGN KEY([IdCCobbro])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[CCobro_PNP] CHECK CONSTRAINT [FK_CCobro_PNP_CCobro]
GO

ALTER TABLE [dbo].[CCobro_PNP]  WITH CHECK ADD  CONSTRAINT [FK_CCobro_PNP_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO

ALTER TABLE [dbo].[CCobro_PNP] CHECK CONSTRAINT [FK_CCobro_PNP_Propiedad]
GO

/****** Object:  Table [dbo].[ComprobantePago]    Script Date: 22/5/2020 00:46:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComprobantePago](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_ComprobantePago] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ComprobantePago]  WITH CHECK ADD  CONSTRAINT [FK_ComprobantePago_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO

ALTER TABLE [dbo].[ComprobantePago] CHECK CONSTRAINT [FK_ComprobantePago_Propiedad]
GO

/****** Object:  Table [dbo].[Prop_Prop]    Script Date: 22/5/2020 00:47:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Prop_Prop](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdPropietario] [int] NOT NULL,
 CONSTRAINT [PK_Prop_Prop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Prop_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Prop_Prop_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO

ALTER TABLE [dbo].[Prop_Prop] CHECK CONSTRAINT [FK_Prop_Prop_Propiedad]
GO

ALTER TABLE [dbo].[Prop_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Prop_Prop_Propietario] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propietario] ([ID])
GO

ALTER TABLE [dbo].[Prop_Prop] CHECK CONSTRAINT [FK_Prop_Prop_Propietario]
GO

/****** Object:  Table [dbo].[Propiedad]    Script Date: 22/5/2020 00:48:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Propiedad](
	[ID] [int] NOT NULL,
	[NumFinca] [int] NOT NULL,
	[Valor] [money] NOT NULL,
	[Direccion] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Propiedad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Propietario]    Script Date: 22/5/2020 00:49:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Propietario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[ValorDocumento] [varchar](30) NULL,
 CONSTRAINT [PK_Propietario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Propietario]  WITH CHECK ADD  CONSTRAINT [FK_Propietario_TipoDocumentoId] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TipoDocumentoId] ([ID])
GO

ALTER TABLE [dbo].[Propietario] CHECK CONSTRAINT [FK_Propietario_TipoDocumentoId]
GO

/****** Object:  Table [dbo].[PropietarioJuridico]    Script Date: 22/5/2020 00:50:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PropietarioJuridico](
	[ID] [int] NOT NULL,
	[NombrePersonaResponsable] [varchar](100) NOT NULL,
	[IdTipoDocumento] [int] NULL,
	[ValorDocumento] [varchar](30) NULL,
 CONSTRAINT [PK_PropietarioJuridico] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PropietarioJuridico]  WITH CHECK ADD  CONSTRAINT [FK_PropietarioJuridico_Propietario] FOREIGN KEY([ID])
REFERENCES [dbo].[Propietario] ([ID])
GO

ALTER TABLE [dbo].[PropietarioJuridico] CHECK CONSTRAINT [FK_PropietarioJuridico_Propietario]
GO

ALTER TABLE [dbo].[PropietarioJuridico]  WITH CHECK ADD  CONSTRAINT [FK_PropietarioJuridico_TipoDocumentoId] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TipoDocumentoId] ([ID])
GO

ALTER TABLE [dbo].[PropietarioJuridico] CHECK CONSTRAINT [FK_PropietarioJuridico_TipoDocumentoId]
GO

/****** Object:  Table [dbo].[Recibos]    Script Date: 22/5/2020 00:51:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Recibos](
	[ID] [int] NOT NULL,
	[IdCCobro] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdComprPago] [int] NOT NULL,
	[Fecha] [date] NOT NULL,
	[FechaVencimiento] [date] NOT NULL,
	[Monto] [money] NOT NULL,
	[EsPendiente] [bit] NOT NULL,
 CONSTRAINT [PK_Recibos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Recibos]  WITH CHECK ADD  CONSTRAINT [FK_Recibos_CCobro] FOREIGN KEY([IdCCobro])
REFERENCES [dbo].[CCobro] ([ID])
GO

ALTER TABLE [dbo].[Recibos] CHECK CONSTRAINT [FK_Recibos_CCobro]
GO

ALTER TABLE [dbo].[Recibos]  WITH CHECK ADD  CONSTRAINT [FK_Recibos_ComprobantePago] FOREIGN KEY([IdComprPago])
REFERENCES [dbo].[ComprobantePago] ([ID])
GO

ALTER TABLE [dbo].[Recibos] CHECK CONSTRAINT [FK_Recibos_ComprobantePago]
GO

ALTER TABLE [dbo].[Recibos]  WITH CHECK ADD  CONSTRAINT [FK_Recibos_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO

ALTER TABLE [dbo].[Recibos] CHECK CONSTRAINT [FK_Recibos_Propiedad]
GO

/****** Object:  Table [dbo].[TipoDocumentoId]    Script Date: 22/5/2020 00:52:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoDocumentoId](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoDocumentoId] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Usuario]    Script Date: 22/5/2020 00:52:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Usuario](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[TipoUsuario] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Usuario_Prop]    Script Date: 22/5/2020 00:53:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Usuario_Prop](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Usuario_Prop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Usuario_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Prop_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO

ALTER TABLE [dbo].[Usuario_Prop] CHECK CONSTRAINT [FK_Usuario_Prop_Propiedad]
GO

ALTER TABLE [dbo].[Usuario_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Prop_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([ID])
GO

ALTER TABLE [dbo].[Usuario_Prop] CHECK CONSTRAINT [FK_Usuario_Prop_Usuario]
GO