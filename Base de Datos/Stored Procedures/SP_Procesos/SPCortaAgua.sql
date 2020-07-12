USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spCortaAgua]    Script Date: 10/7/2020 08:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].[spCortaAgua] @FechaActual DATE
AS  	
	BEGIN
		BEGIN TRY
			DECLARE @idPropiedades TABLE(ID int IDENTITY(1,1),IdPropiedad int,IdCCobro INT)
			DECLARE @idMenor INT, @idMayor INT, @cant int = IDENT_CURRENT('Recibo')
			BEGIN TRANSACTION
				INSERT INTO @idPropiedades(IdPropiedad, IdCCobro)
				SELECT R.IdPropiedad, R.IdCCobro
				FROM Recibo AS R
				WHERE R.Estado = 0 AND R.IdCCobro = 1 AND NOT EXISTS (SELECT ID FROM [dbo].[Recibo] WHERE IdCCobro = 10)
				GROUP BY IdPropiedad, IdCCobro
				HAVING COUNT(*) > 1
				 
				INSERT INTO Recibo (IdCCobro,Monto,Estado,IdPropiedad,FechaEmision,FechaMaximaPago)
				SELECT 10, CM.MontoFijo, 0, P.idPropiedad, @FechaActual, DATEADD(DAY,CC.QDiasVencimiento,@FechaActual)
				FROM @idPropiedades AS P
				INNER JOIN CCobro_MontoFijo AS CM ON CM.ID = 10
				INNER JOIN CCobro AS CC ON CC.ID = 10					

				INSERT INTO ReciboReconexion(id)
				SELECT R.ID
				FROM Recibo AS R
				JOIN @idPropiedades AS P ON 10 = R.IdCCobro AND P.IdPropiedad = R.IdPropiedad 

				INSERT INTO Corte(IdPropiedad,IdReciboReconexion,Fecha)
				SELECT P.IdPropiedad, R.ID, @FechaActual
				FROM @idPropiedades AS P 
				JOIN Recibo AS R ON P.IdPropiedad = R.IdPropiedad
				JOIN ReciboReconexion AS RR ON RR.ID = R.ID
				
			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN;
			THROW 50002,'Error: No se ha podido cortar el agua', 1;
		END CATCH
		
	END
