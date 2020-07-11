USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spReconexionAgua]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].[spReconexionAgua] @FechaActual DATE AS  	
	BEGIN
		BEGIN TRY
			DECLARE @idPropiedades TABLE(id INT IDENTITY(1,1),IdPropiedad int)
			DECLARE @idMenor INT, @idMayor INT, @idc INT, @cant INT
			BEGIN TRAN
				INSERT INTO @idPropiedades(idPropiedad)
				SELECT DISTINCT R.IdPropiedad
				FROM Recibo AS R
				WHERE 1 = ALL(SELECT estado FROM Recibo WHERE IdPropiedad = R.IdPropiedad)
				AND NOT EXISTS(SELECT * FROM Reconexion WHERE IdPropiedad = R.IdPropiedad)
				AND EXISTS(SELECT * FROM Corte WHERE IdPropiedad = R.IdPropiedad)
				AND (R.IdCCobro = 1 OR R.IdCCobro = 10)
				SELECT @idMenor = MIN(id), @idMayor = MAX(id) FROM @idPropiedades
				WHILE @idMenor<=@idMayor
				BEGIN
					INSERT INTO Reconexion(IdPropiedad,IdReciboReconexion, Fecha)
					SELECT idP.idPropiedad, R.id, @FechaActual
					FROM @idPropiedades idP
					INNER JOIN Recibo AS R ON R.IdPropiedad = idP.idPropiedad
					WHERE idP.id = @idMenor AND R.IdCCobro = 10
					SET @idMenor = @idMenor+1
				END
				
			COMMIT
		END TRY
		BEGIN CATCH
			If 
			@@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50003,'Error: No se ha podido reconectar',1;
		END CATCH
	END
