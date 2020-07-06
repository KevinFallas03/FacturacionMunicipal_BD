USE [FacturacionMunicipal]
GO
/****** Object:  Table [dbo].[BitacoraCambios]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraCambios](
	[ID] [int] NOT NULL,
	[IdEntityType] [int] NOT NULL,
	[EntityId] [int] NOT NULL,
	[jsonAntes] [varchar](500) NULL,
	[jsonDespues] [varchar](500) NULL,
	[insertedAt] [datetime] NULL,
	[insertedBy] [varchar](20) NULL,
	[insertedIn] [varchar](20) NULL,
 CONSTRAINT [PK_BitacoraCambios_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCobro]    Script Date: 6/7/2020 17:21:44 ******/
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
	[EsImpuesto] [varchar](10) NULL,
	[EsRecurrente] [varchar](10) NULL,
	[EsFijo] [varchar](10) NULL,
	[TipoCC] [varchar](30) NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Concepto Cobro] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCobro_ConsumoAgua]    Script Date: 6/7/2020 17:21:44 ******/
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
/****** Object:  Table [dbo].[CCobro_InteresMoratorio]    Script Date: 6/7/2020 17:21:44 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCobro_MontoFijo]    Script Date: 6/7/2020 17:21:44 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CCobro_PNP]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCobro_PNP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdCCobbro] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[FechaInic] [date] NOT NULL,
	[FechaFin] [date] NULL,
 CONSTRAINT [PK_CCobro_PNP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobantePago]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobantePago](
	[ID] [int] NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[MontoTotal] [money] NOT NULL,
 CONSTRAINT [PK_ComprobantePago] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Corte]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corte](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdReciboReconexion] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Corte] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntityType]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityType](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EntityType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientoConsumo]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoConsumo](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdTipoMovimiento] [int] NOT NULL,
	[FechaMov] [datetime] NOT NULL,
	[MontoM3] [money] NOT NULL,
	[LecturaConsumo] [int] NOT NULL,
	[NuevoM3Consumo] [int] NOT NULL,
 CONSTRAINT [PK_MovimientoConsumo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prop_Prop]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prop_Prop](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdPropietario] [int] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Prop_Prop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Propiedad]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propiedad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NumFinca] [int] NOT NULL,
	[Valor] [money] NOT NULL,
	[Direccion] [varchar](150) NOT NULL,
	[M3Acumulados] [int] NOT NULL,
	[M3AcumuladosUltimoRecibo] [int] NOT NULL,
	[FechaIngreso] [datetime] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Propiedad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Propietario]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propietario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[ValorDocumento] [varchar](30) NOT NULL,
	[FechaIngreso] [datetime] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Propietario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropietarioJuridico]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropietarioJuridico](
	[ID] [int] NOT NULL,
	[NombrePersonaResponsable] [varchar](100) NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[ValorDocumento] [varchar](30) NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_PropietarioJuridico] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recibo]    Script Date: 6/7/2020 17:21:44 ******/
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
 CONSTRAINT [PK_Recibo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReciboPagado]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReciboPagado](
	[ID] [int] NOT NULL,
	[IdRecibo] [int] NOT NULL,
	[IdComprobante] [int] NOT NULL,
 CONSTRAINT [PK_ReciboPagado] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReciboReconexion]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReciboReconexion](
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_ReciboReconexion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reconexion]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reconexion](
	[ID] [int] NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdReciboReconexion] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Reconexion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocumentoId]    Script Date: 6/7/2020 17:21:44 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoMovimiento]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimiento](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TipoMovimiento] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[TipoUsuario] [varchar](50) NOT NULL,
	[FechaIngreso] [datetime] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Prop]    Script Date: 6/7/2020 17:21:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Prop](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdPropiedad] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[EstaBorrado] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario_Prop] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BitacoraCambios]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraCambios_EntityType] FOREIGN KEY([IdEntityType])
REFERENCES [dbo].[EntityType] ([ID])
GO
ALTER TABLE [dbo].[BitacoraCambios] CHECK CONSTRAINT [FK_BitacoraCambios_EntityType]
GO
ALTER TABLE [dbo].[CCobro_ConsumoAgua]  WITH CHECK ADD  CONSTRAINT [FK_CC Consumo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO
ALTER TABLE [dbo].[CCobro_ConsumoAgua] CHECK CONSTRAINT [FK_CC Consumo_Concepto Cobro]
GO
ALTER TABLE [dbo].[CCobro_InteresMoratorio]  WITH CHECK ADD  CONSTRAINT [FK_CC Porcentaje_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO
ALTER TABLE [dbo].[CCobro_InteresMoratorio] CHECK CONSTRAINT [FK_CC Porcentaje_Concepto Cobro]
GO
ALTER TABLE [dbo].[CCobro_MontoFijo]  WITH CHECK ADD  CONSTRAINT [FK_CC Fijo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[CCobro] ([ID])
GO
ALTER TABLE [dbo].[CCobro_MontoFijo] CHECK CONSTRAINT [FK_CC Fijo_Concepto Cobro]
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
ALTER TABLE [dbo].[Corte]  WITH CHECK ADD  CONSTRAINT [FK_Corte_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO
ALTER TABLE [dbo].[Corte] CHECK CONSTRAINT [FK_Corte_Propiedad]
GO
ALTER TABLE [dbo].[Corte]  WITH CHECK ADD  CONSTRAINT [FK_Corte_ReciboReconexion] FOREIGN KEY([IdReciboReconexion])
REFERENCES [dbo].[ReciboReconexion] ([ID])
GO
ALTER TABLE [dbo].[Corte] CHECK CONSTRAINT [FK_Corte_ReciboReconexion]
GO
ALTER TABLE [dbo].[MovimientoConsumo]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoConsumo_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO
ALTER TABLE [dbo].[MovimientoConsumo] CHECK CONSTRAINT [FK_MovimientoConsumo_Propiedad]
GO
ALTER TABLE [dbo].[MovimientoConsumo]  WITH CHECK ADD  CONSTRAINT [FK_MovimientoConsumo_TipoMovimiento] FOREIGN KEY([IdTipoMovimiento])
REFERENCES [dbo].[TipoMovimiento] ([ID])
GO
ALTER TABLE [dbo].[MovimientoConsumo] CHECK CONSTRAINT [FK_MovimientoConsumo_TipoMovimiento]
GO
ALTER TABLE [dbo].[Prop_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Prop_Prop_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO
ALTER TABLE [dbo].[Prop_Prop] CHECK CONSTRAINT [FK_Prop_Prop_Propiedad]
GO
ALTER TABLE [dbo].[Prop_Prop]  WITH CHECK ADD  CONSTRAINT [FK_Prop_Prop_Propietario] FOREIGN KEY([IdPropietario])
REFERENCES [dbo].[Propietario] ([ID])
GO
ALTER TABLE [dbo].[Prop_Prop] CHECK CONSTRAINT [FK_Prop_Prop_Propietario]
GO
ALTER TABLE [dbo].[Propietario]  WITH CHECK ADD  CONSTRAINT [FK_Propietario_TipoDocumentoId] FOREIGN KEY([IdTipoDocumento])
REFERENCES [dbo].[TipoDocumentoId] ([ID])
GO
ALTER TABLE [dbo].[Propietario] CHECK CONSTRAINT [FK_Propietario_TipoDocumentoId]
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
ALTER TABLE [dbo].[Recibo]  WITH CHECK ADD  CONSTRAINT [FK_Recibo_CCobro] FOREIGN KEY([IdCCobro])
REFERENCES [dbo].[CCobro] ([ID])
GO
ALTER TABLE [dbo].[Recibo] CHECK CONSTRAINT [FK_Recibo_CCobro]
GO
ALTER TABLE [dbo].[Recibo]  WITH CHECK ADD  CONSTRAINT [FK_Recibo_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO
ALTER TABLE [dbo].[Recibo] CHECK CONSTRAINT [FK_Recibo_Propiedad]
GO
ALTER TABLE [dbo].[ReciboPagado]  WITH CHECK ADD  CONSTRAINT [FK_ReciboPagado_ComprobantePago] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[ComprobantePago] ([ID])
GO
ALTER TABLE [dbo].[ReciboPagado] CHECK CONSTRAINT [FK_ReciboPagado_ComprobantePago]
GO
ALTER TABLE [dbo].[ReciboPagado]  WITH CHECK ADD  CONSTRAINT [FK_ReciboPagado_Recibo] FOREIGN KEY([IdRecibo])
REFERENCES [dbo].[Recibo] ([ID])
GO
ALTER TABLE [dbo].[ReciboPagado] CHECK CONSTRAINT [FK_ReciboPagado_Recibo]
GO
ALTER TABLE [dbo].[ReciboReconexion]  WITH CHECK ADD  CONSTRAINT [FK_ReciboReconexion_Recibo] FOREIGN KEY([ID])
REFERENCES [dbo].[Recibo] ([ID])
GO
ALTER TABLE [dbo].[ReciboReconexion] CHECK CONSTRAINT [FK_ReciboReconexion_Recibo]
GO
ALTER TABLE [dbo].[Reconexion]  WITH CHECK ADD  CONSTRAINT [FK_Reconexion_Propiedad] FOREIGN KEY([IdPropiedad])
REFERENCES [dbo].[Propiedad] ([ID])
GO
ALTER TABLE [dbo].[Reconexion] CHECK CONSTRAINT [FK_Reconexion_Propiedad]
GO
ALTER TABLE [dbo].[Reconexion]  WITH CHECK ADD  CONSTRAINT [FK_Reconexion_ReciboReconexion] FOREIGN KEY([IdReciboReconexion])
REFERENCES [dbo].[ReciboReconexion] ([ID])
GO
ALTER TABLE [dbo].[Reconexion] CHECK CONSTRAINT [FK_Reconexion_ReciboReconexion]
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