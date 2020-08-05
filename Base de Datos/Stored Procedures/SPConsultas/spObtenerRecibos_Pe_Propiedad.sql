USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerRecibosPedePropiedad]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].spObtenerRecibosPedePropiedad @id int, @estado int as 	
BEGIN
BEGIN TRY
	SELECT R.ID, R.FechaEmision, CC.Nombre, R.Monto
	FROM Recibo AS R
	INNER JOIN CCobro AS CC ON R.IdCCobro = CC.ID
	WHERE R.Estado=@estado AND @id=R.IdPropiedad
	ORDER BY R.FechaEmision DESC
END TRY
BEGIN CATCH
	THROW 60000,'Error: No se ha podido buscar Recibos',1;
END CATCH
END
