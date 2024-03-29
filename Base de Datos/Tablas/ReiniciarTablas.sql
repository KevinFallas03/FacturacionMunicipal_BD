USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[ReiniciarTablas]    Script Date: 4/6/2020 20:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[ReiniciarTablas]
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_MontoFijo]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_ConsumoAgua]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_InteresMoratorio]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro_PNP]

	DELETE FROM [FacturacionMunicipal].[dbo].[CCobro]

	DELETE FROM [FacturacionMunicipal].[dbo].[Prop_Prop]

	DELETE FROM [FacturacionMunicipal].[dbo].[Propiedad]
		DBCC CHECKIDENT ('Propiedad', RESEED, 0) --para los identity
	
	DELETE FROM [FacturacionMunicipal].[dbo].[PropietarioJuridico]

	DELETE FROM [FacturacionMunicipal].[dbo].[Propietario]
		DBCC CHECKIDENT ('Propietario', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Usuario_Prop]
		DBCC CHECKIDENT ('Usuario_Prop', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[Usuario]
		DBCC CHECKIDENT ('Usuario', RESEED, 0) --para los identity

	DELETE FROM [FacturacionMunicipal].[dbo].[TipoDocumentoId]

END

exec ReiniciarTablas
