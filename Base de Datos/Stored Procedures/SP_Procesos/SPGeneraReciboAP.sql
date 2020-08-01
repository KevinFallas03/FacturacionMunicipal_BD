USE [FacturacionMunicipal]
GO

CREATE OR ALTER PROC [dbo].[spGeneraReciboAP] 
@FechaActual date
AS 
BEGIN
	/*BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON*/
			DECLARE @dia int,
			@interesm MONEY,
			@montoamort MONEY,
			@idMenor INT,
			@idMayor INT,
			@idRecibo INT,
			@TasaInteresAnual FLOAT,
			@plazoRestante INT,
			@nuevoSaldo MONEY,
			@idMov INT
			DECLARE @aps TABLE (sec INT IDENTITY(1,1),idap int)

			SET @TasaInteresAnual = CONVERT(decimal(5,2),(SELECT Valor FROM ValoresConfiguracion WHERE ID = 1))
			SET @dia = DAY(@FechaActual)

			--Todos los AP que generan recibos este día 
			INSERT INTO @aps(idap)
			SELECT id 
			FROM ArregloPago
			WHERE DAY(insertedAt) = @dia AND PlazoResta > 0

			SELECT @idMenor = MIN(sec), @idMayor = MAX(sec) FROM @aps

			--BEGIN TRAN
				WHILE (@idMenor<=@idMayor)
				BEGIN 
					--Se obtienen los datos de intereses y monto de amortización
					SElECT @interesm =  A.Saldo*(@TasaInteresAnual/12) / 100, @montoamort = A.Cuota
					FROM ArregloPago AS A
					INNER JOIN @aps AS IA ON A.ID = IA.idap
					WHERE IA.sec = @idMenor
					
					--Se actualiza el saldo del AP
					UPDATE ArregloPago
					SET Saldo = Saldo - @montoamort,
					PlazoResta = PlazoResta-1
					FROM ArregloPago AS AP 
					INNER JOIN @aps AS IA ON AP.id = IA.idap
					WHERE IA.sec = @idMenor

					--Se obtienen los datos del plazo restante y saldo nuevo
					SELECT @plazoRestante = A.PlazoResta, @nuevoSaldo =  A.Saldo
					FROM ArregloPago AS A
					INNER JOIN @aps AS IA ON A.id = IA.idap
					WHERE IA.sec = @idMenor 

					--Se crea el Movimiento del AP
					INSERT INTO MovimientoAP (IdArregloPago,IdTipoMovAP,Monto,InteresesDelMes,plazoResta,nuevoSaldo,fecha,insertedAt)
					SELECT AP.id,2,@montoamort,@interesm,@plazoRestante,@nuevoSaldo,@FechaActual,@FechaActual
					FROM [dbo].[ArregloPago] AP
					INNER JOIN @aps AS IA ON AP.id = IA.idap
					WHERE IA.sec = @idMenor
					SET @idMov = IDENT_CURRENT('[dbo].[MovimientosAP]')

					--Se crea el recibo del AP
					INSERT INTO Recibo (IdCCobro,Monto,Estado,IdPropiedad,FechaEmision,FechaMaximaPago)
					SELECT C.ID,A.Cuota,0,A.IdPropiedad,@FechaActual,DATEADD(D,C.QDiasVencimiento,@FechaActual)
					FROM @aps IA 
					INNER JOIN CCobro AS C ON C.ID = 12
					INNER JOIN ArregloPago AS A ON A.ID = IA.idap
					WHERE IA.sec = @idMenor
					SET @idRecibo = IDENT_CURRENT('[dbo].[Recibos]')

					INSERT INTO Recibo_AP(ID,Descripcion,IdMovimientoAP)
					SELECT @idRecibo
						,'Interes mensual:'+CAST(@interesm AS VARCHAR(30))
						+', amortizacion:'+CAST(@montoamort AS VARCHAR(30))
						+', plazo resta:'+CAST(@plazoRestante AS VARCHAR(30))
						,@idMov
					SET @idMenor += 1
				END

			/*COMMIT
		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50004,'Error: No se ha podido generar el recibo de AP',1;
		END CATCH*/
		return 0
END