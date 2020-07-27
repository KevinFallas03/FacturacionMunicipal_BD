USE [FacturacionMunicipal]
GO

/****** Object:  StoredProcedure [dbo].[IniciarSimulacion]    Script Date: 4/6/2020 10:20:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[IniciarSimulacion]
AS
BEGIN
	IF OBJECT_ID('dbo.ValoresConfiguracion', 'U') IS NULL AND OBJECT_ID('dbo.Tipos', 'U') IS NULL
	BEGIN	
		EXEC spCargarConfiguracion
	END
	EXEC ReiniciarTablas
	
	EXEC spCargarDatos
	EXEC spCargarDatosAdmin
	EXEC spCargarDatosCC
	EXEC Simulacion
END

GO

EXEC IniciarSimulacion