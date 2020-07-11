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
			DECLARE @idPropiedades TABLE(ID INT IDENTITY(1,1),IdPropiedad int,IdCCobro INT)
			DECLARE @idMenor INT, @idMayor INT, @id int, @idc int, @cant int
			BEGIN TRANSACTION
				INSERT INTO @idPropiedades(IdPropiedad,IdCCobro)
				SELECT R.IdPropiedad, R.IdCCobro
				FROM Recibo AS R
				WHERE R.Estado = 0 AND R.IdCCobro = 1 AND NOT EXISTS (SELECT ID FROM [dbo].[Recibo] WHERE IdCCobro = 10)
				GROUP BY IdPropiedad, IdCCobro
				HAVING COUNT(*) > 1
				 
				SELECT @idMenor = MIN(ID), @idMayor = MAX(ID) FROM @idPropiedades

				WHILE @idMenor<=@idMayor
				BEGIN
					INSERT INTO Recibo (IdCCobro,Monto,Estado,IdPropiedad,FechaEmision,FechaMaximaPago)
					SELECT 10, CM.MontoFijo, 0, P.idPropiedad, @FechaActual, DATEADD(DAY,CC.QDiasVencimiento,@FechaActual)
					FROM @idPropiedades AS P
					INNER JOIN CCobro_MontoFijo AS CM ON CM.ID = 10
					INNER JOIN CCobro AS CC ON CC.ID = 10
					WHERE P.id = @idMenor

					SET @id = IDENT_CURRENT('Recibo')
					INSERT INTO ReciboReconexion(id)
					SELECT @id

					/* HACER IDENTITY
					SELECT @idc = MAX(ID) + 1 FROM Corte
					SELECT @cant = (COUNT(*)) FROM Corte
					IF  @cant = 0 
						BEGIN
							SELECT @idc=1
						END
					*/

					INSERT INTO Corte(ID, IdPropiedad,IdReciboReconexion,Fecha)
					SELECT @idc, idp.idPropiedad, @id, @FechaActual
					FROM @idPropiedades as idP
					WHERE idP.id =	@idMenor
					
					SET @idMenor = @idMenor+1
				END
				
			COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN;
			THROW -1,'Error: No se ha podido cortar el agua', 1;
		END CATCH
		
	END
