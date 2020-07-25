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
			SELECT TasaInteresMoratorio FROM CCobro WHERE ID = 12
		END TRY
		BEGIN CATCH
		If @@TRANCOUNT > 0 
			ROLLBACK TRAN;
			THROW 60000,'Error: No se ha podido buscar porcentaje moratorio',1;
		END CATCH
	END