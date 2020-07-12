USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spVerReciboPedePropiedad]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].spVerReciboPedePropiedad @id int, @estado int as 	
	BEGIN
	BEGIN TRY
		SELECT R.ID, R.FechaEmision, R.FechaMaximaPago, P.NumFinca, CC.Nombre, R.Monto, R.IdPropiedad
		FROM Recibo AS R
		INNER JOIN CCobro AS CC ON R.IdCCobro = CC.ID
		INNER JOIN Propiedad AS P ON R.IdPropiedad = P.ID
		WHERE R.Estado=@estado AND @id=R.ID
		ORDER BY R.FechaEmision DESC
	END TRY
	BEGIN CATCH
	If @@TRANCOUNT > 0 
		ROLLBACK TRAN;
		THROW 60001,'Error: No se ha podido buscar Recibo',1;
	END CATCH
	END