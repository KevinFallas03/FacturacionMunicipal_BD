USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE dbo.spProcesaConsumo @MovConsumo MovConsumoType READONLY
AS 
BEGIN
	BEGIN TRY
		DECLARE @Low  int, @High int
		DECLARE @ultimoRecibo int, @monto int, @NuevoAcumM3 int, @inLecturaM3 int
		
		SELECT @Low = min(sec) , @High = max(sec) 
		FROM @MovConsumo 

		BEGIN TRANSACTION
		WHILE @Low <= @High
		BEGIN
			
			SELECT @ultimoRecibo = P.M3AcumuladosUltimoRecibo, @inLecturaM3 = C.M3
			FROM dbo.Propiedad P
			INNER JOIN @MovConsumo C ON C.NumFinca = P.NumFinca
			WHERE C.sec = @Low
					 
			SET @monto = (@InLecturaM3 - @ultimoRecibo)
			SET @NuevoAcumM3 = (SELECT P.M3Acumulados 
								FROM [dbo].[Propiedad] as P
								INNER JOIN @MovConsumo C ON C.NumFinca = P.NumFinca 
								WHERE C.sec = @Low) + @monto --SUMAMOS EL MONTO
			

			INSERT INTO dbo.MovimientoConsumo(IdPropiedad, IdTipoMovimiento, Descripcion, MontoM3, LecturaConsumo, NuevoM3Consumo, FechaMov)
			SELECT Prop.ID
				, Cons.TipoMov 
				, Cons.Descripcion
				, CASE WHEN (Cons.TipoMov = 1) THEN @monto --Nuevo monto de la lectura
				  ELSE @InLecturaM3
				  END
				, CASE WHEN (Cons.TipoMov = 1) THEN Cons.M3 
				  ELSE 0 
				  END
				, CASE WHEN (Cons.TipoMov = 1) THEN @NuevoAcumM3
				  WHEN (Cons.TipoMov = 2) THEN Prop.M3Acumulados + @InLecturaM3 --Suma porque fue una lectura erronea
				  WHEN (Cons.TipoMov = 3) THEN Prop.M3Acumulados - @InLecturaM3 --Resta porque fue un reclamo de cliente
				  END
				, Cons.Fecha
 			FROM dbo.Propiedad Prop
			INNER JOIN @MovConsumo Cons ON Cons.NumFinca = Prop.NumFinca
			WHERE Cons.sec = @Low

			UPDATE dbo.Propiedad
			SET M3Acumulados = 
				CASE WHEN (C.TipoMov = 1) THEN @NuevoAcumM3
				WHEN (C.TipoMov = 2) THEN P.M3Acumulados + @InLecturaM3 --dudas
				WHEN (C.TipoMov = 3) THEN P.M3Acumulados - @InLecturaM3 --dudas
				END
			FROM dbo.Propiedad P 
			INNER JOIN @MovConsumo C ON C.NumFinca = P.NumFinca
			WHERE C.sec = @Low

			SET @Low = @Low + 1
		END
		COMMIT
	END TRY
	BEGIN CATCH
		If @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW 50001, 'Error en la transaccion de Consumos', 1
	END CATCH;
END