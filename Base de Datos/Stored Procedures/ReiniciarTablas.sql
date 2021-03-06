USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[ReiniciarTablas]    Script Date: 7/6/2020 14:07:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[ReiniciarTablas]
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [FacturacionMunicipal].[dbo].[IdRecibosPorPagar]

	DELETE FROM [FacturacionMunicipal].[dbo].[Recibo_AP]

	DELETE FROM [FacturacionMunicipal].[dbo].[ReciboPagado]
		DBCC CHECKIDENT ('[ReciboPagado]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Recibo]
		DBCC CHECKIDENT ('[Recibo]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[MovimientoAP]
		DBCC CHECKIDENT ('[MovimientoAP]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[ArregloPago]
		DBCC CHECKIDENT ('[ArregloPago]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[ComprobantePago]		
		DBCC CHECKIDENT ('[ComprobantePago]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Reconexion]
		DBCC CHECKIDENT ('[Reconexion]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Corte]
		DBCC CHECKIDENT ('[Corte]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[ReciboReconexion]

	

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_MontoFijo]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_ConsumoAgua]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_InteresMoratorio]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_PNP]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro]

	DELETE FROM [FacturacionMunicipal].[dbo].[MovimientoConsumo]
		DBCC CHECKIDENT ('[MovimientoConsumo]', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Usuario_Prop]
		DBCC CHECKIDENT ('Usuario_Prop', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Prop_Prop]

	DELETE FROM [FacturacionMunicipal].[dbo].[Propiedad]
		DBCC CHECKIDENT ('Propiedad', RESEED, 0) --para los identity
	
	DELETE FROM [FacturacionMunicipal].[dbo].[PropietarioJuridico]

	DELETE FROM [FacturacionMunicipal].[dbo].[Propietario]
		DBCC CHECKIDENT ('Propietario', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Usuario]
		DBCC CHECKIDENT ('Usuario', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[BitacoraCambios]
		DBCC CHECKIDENT ('BitacoraCambios', RESEED, 0) --para los identity
	
	DELETE FROM [FacturacionMunicipal].[dbo].[EntityType]

	DELETE FROM [FacturacionMunicipal].[dbo].[TipoMovimiento]

	DELETE FROM [FacturacionMunicipal].[dbo].[TipoDocumentoId]

	DELETE FROM [FacturacionMunicipal].[dbo].[ValoresConfiguracion]

	DELETE FROM [FacturacionMunicipal].[dbo].[Tipos]

END

/*
EXEC ReiniciarTablas
EXEC IniciarSimulacion*/