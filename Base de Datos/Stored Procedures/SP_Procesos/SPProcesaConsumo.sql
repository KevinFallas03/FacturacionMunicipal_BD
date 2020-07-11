USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE dbo.spProcesaConsumo @MovConsumo MovConsumoType READONLY
AS 
BEGIN
	--BEGIN TRY
		DECLARE @Low  int, @High int
		SELECT @Low = min(sec) , @High = max(sec) 
		FROM @MovConsumo 

		BEGIN TRANSACTION
		WHILE @Low <= @High
		BEGIN
			INSERT INTO dbo.MovimientoConsumo(IdPropiedad, IdTipoMovimiento, FechaMov, MontoM3, LecturaConsumo, NuevoM3Consumo)
			SELECT Prop.ID
				, Cons.TipoMov 
				, Cons.Fecha
				, CASE WHEN (Cons.TipoMov = 1) THEN Cons.M3-Prop.M3Acumulados
				  ELSE Cons.M3
				  END
				, CASE WHEN (Cons.TipoMov = 1) THEN Cons.M3 
				  ELSE NULL 
				  END
				, CASE WHEN (Cons.TipoMov = 1) THEN Cons.M3 
				  WHEN (Cons.TipoMov = 2) THEN Prop.M3Acumulados - Cons.M3
				  WHEN (Cons.TipoMov = 3) THEN Prop.M3Acumulados + Cons.M3
				  END
 			FROM dbo.Propiedad Prop
			INNER JOIN @MovConsumo Cons ON Cons.NumFinca = Prop.NumFinca
			WHERE Cons.sec = @Low

			UPDATE dbo.Propiedad
			SET M3Acumulados = 
				CASE WHEN (Cons.TipoMov = 1) THEN Cons.M3
				WHEN (Cons.TipoMov = 2) THEN M3Acumulados - Cons.M3
				WHEN (Cons.TipoMov = 3) THEN M3Acumulados + Cons.M3
				END
			FROM dbo.Propiedad Prop 
			INNER JOIN @MovConsumo Cons ON Cons.NumFinca = Prop.NumFinca
			WHERE Cons.sec = @Low

			SET @Low = @Low + 1
		END
		COMMIT
	/*END TRY
	BEGIN CATCH
		If @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW 50001, 'Error en la transaccion de Consumos', 1
	END CATCH;*/
END