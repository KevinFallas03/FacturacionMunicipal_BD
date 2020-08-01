USE [FacturacionMunicipal]
GO

CREATE OR ALTER PROC [dbo].[spCreateAP] 
@IdP int, 
@MontoO money, 
@Plazo int,
@Cuota money,
@Fecha date,
@TasaA decimal
AS 
BEGIN
	BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON
			DECLARE @IdC int,
					@idA int,
					@interesm decimal (10, 2),
					@amortizacion money,
					@fechaend date
			SET @interesm = @MontoO*(@TasaA/100/12)
			SET @amortizacion = @Cuota - @interesm
			SET @fechaend =  DATEADD(MONTH, @Plazo, @Fecha)
			
			BEGIN TRAN
			
			--Se crea el comprobante
			INSERT INTO ComprobantePago(FechaPago, MontoTotal, MedioPago)
			VALUES (@Fecha, @MontoO, 'AP #')
			SET @idC = IDENT_CURRENT('ComprobantePago')

			--Se agregan a la tabla de recibos pagados
			INSERT INTO ReciboPagado (IdRecibo,IdComprobante)
			SELECT R.ID, @IdC
			FROM Recibo AS R
			WHERE IdPropiedad = @IdP and Estado = 0

			--Se cambia el estado de los recibos pendientes a pagados
			UPDATE Recibo 
			SET Estado = 1
			WHERE IdPropiedad = @IdP and Estado = 0

			--Se crea el AP
			INSERT INTO ArregloPago (IdPropiedad,IdComprobante, MontoOriginal, 
				Saldo, TasaInteresAnual, PlazoResta, Cuota, InsertedAt, UpdateAt)
				VALUES(@IdP, @IdC, @MontoO, @MontoO, @TasaA, @Plazo, @Cuota, @Fecha, @Fecha)
			SET @idA = IDENT_CURRENT('ArregloPago')

			--Se actualiza el medio de pago del AP
			UPDATE ComprobantePago
			SET MedioPago += +CAST(@idA AS VARCHAR)
			WHERE ID=@IdC

			--Se crea el movimiento de debito del AP
			INSERT INTO MovimientoAP(IdArregloPago, IdTipoMovAP, Monto, InteresesDelMes, PlazoResta, NuevoSaldo, Fecha, InsertedAt)
			VALUES (@idA, 1, @MontoO, @interesm, @Plazo, @MontoO, @Fecha, @Fecha)

			--Se crea la relación entre propiedad y CCobro
			INSERT INTO CCobro_PNP (IdCCobbro, IdPropiedad, FechaInic, FechaFin)
			VALUES (12, @IdP, @Fecha, @fechaend)


			COMMIT
		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50004,'Error: No se ha podido generar el AP',1;
		END CATCH
		return 0
END
