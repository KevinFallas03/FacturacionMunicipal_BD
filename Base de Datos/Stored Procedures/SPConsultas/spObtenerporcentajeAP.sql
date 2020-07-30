USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerporcentajeAP]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].spObtenerporcentajeAP 
as 	
	BEGIN 
		BEGIN TRY
			SELECT Valor FROM ValoresConfiguracion WHERE ID = 1
		END TRY
		BEGIN CATCH
			THROW 60000,'Error: No se ha podido buscar porcentaje',1;
		END CATCH
	END