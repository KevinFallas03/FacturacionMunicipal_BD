USE [FacturacionMunicipal]
GO
IF OBJECT_ID('[dbo].[spProcesarPagosUsuario]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[spProcesarPagosUsuario]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spProcesarPagosUsuario] @jsonRecibos varchar(MAX) -- [{"id":45},{"id":8}]
AS 
	BEGIN 
		BEGIN TRY 
		SET NOCOUNT ON 
		SET XACT_ABORT ON  
			
			
			--Variables para actualizaciones e inserts
			DECLARE @idMenor INT, 
					@idMayor INT, 
					@FechaMaxPago DATE, 
					@fechaOperacion DATE, 
					@montoMoratorio MONEY, 
					@tasaMoratoria FLOAT, 
					@montoRecibo MONEY, 
					@tipoCC int, 
					@idPropiedad INT;
			
			DECLARE @IdRecibosPagar TABLE
			(
				ID INT PRIMARY KEY
			);

			Declare @PagosHoy TABLE
			(
				sec INT PRIMARY KEY,
				NumFinca INT,
				TipoRecibo INT,
				Fecha DATE
			);

			INSERT INTO dbo.IdRecibosPorPagar(sec)
			SELECT id
			FROM OPENJSON (@jsonRecibos)
			WITH(
				id int '$.id'
			);

			
			--Obtenemos las id para iterar sobre los recibos por pagar desde la pagina del usuario
			SELECT @idMenor = MIN(RP.sec), @idMayor = MAX(RP.sec)
			FROM dbo.IdRecibosPorPagar as RP
			
			BEGIN TRAN
				WHILE @idMenor<=@idMayor--RECORRE LOS RECIBOS
				BEGIN

					SET @montoMoratorio = 0 --MONTO MORATORIO SE CAMBIA SI ES QUE HAY RECIBO MORATORIO, SINO ES 0

					SET @FechaOperacion =  GETDATE()

					SET @idPropiedad = (SELECT R.ID FROM [Recibo] R 
										INNER JOIN IdRecibosPorPagar idRP ON idRP.sec = R.ID
										WHERE @idMenor = idRP.sec		
									    )
					
					
					SET @FechaMaxPago = (SELECT R.FechaMaximaPago FROM [dbo].[Recibo] R
										 INNER JOIN dbo.IdRecibosPorPagar idRP ON idRP.sec = R.id
										 WHERE idRP.sec = @idMenor AND R.Estado = 0);
											
					SET @montoRecibo = (SELECT R.Monto FROM [dbo].[Recibo] R
										INNER JOIN dbo.IdRecibosPorPagar idRP ON R.id = idRP.sec
										WHERE idRP.sec = @idMenor);

					--Se crean intereses moratorios para aquellos que se pasaron de la fecha
					IF @FechaMaxPago < @FechaOperacion
					BEGIN
						--SACA LA TASA MORATORIA DEL RECIBO
						SET @tasaMoratoria = (	SELECT CC.TasaInteresMoratorio FROM [dbo].[CCobro] CC
												INNER JOIN [dbo].[Recibo] AS R ON R.IdCCobro = CC.ID 
												INNER JOIN  dbo.IdRecibosPorPagar AS RP ON Rp.sec = R.id
												WHERE Rp.sec = @idMenor
											  );

						--AQUI CAMBIA EL MONTO MORATORIO YA QUE SI SE DEBE CREAR RECIBO MORATORIO
						SET @montoMoratorio = (@montoRecibo * @tasaMoratoria/ 365) * ABS( DATEDIFF(d, @FechaMaxPago, @FechaOperacion) )
						
						
						--CREA UN RECIBO TIPO MORATORIO Y LO ESTABLECE COMO PENDIENTE
						INSERT INTO [dbo].[Recibo](IdPropiedad,IdCCobro,Monto,Estado,FechaEmision,FechaMaximaPago)
						SELECT	@idPropiedad, 
								CC.ID,
								@montoMoratorio, 
								0, --Estado pendiente
								@FechaOperacion, 
								DATEADD(day, CC.QDiasVencimiento, @FechaOperacion)
						FROM [dbo].[CCobro] AS CC
						WHERE CC.ID = 11 --Recibo de Agua
						
						--GUARDA ADEMAS LOS RECIBOS MORATORIOS A PAGAR
						INSERT INTO IdRecibosPorPagar(sec)
						SELECT IDENT_CURRENT('[dbo].[Recibo]')
						
						
					END
					
					SET @idMenor += 1
				END
			
			--HACER SP PARA ESTE PROCESO
			
			SELECT R.ID, CC.Nombre, R.Monto
			FROM Recibo AS R
			INNER JOIN IdRecibosPorPagar RP ON R.id = RP.sec
			INNER JOIN CCobro AS CC ON R.IdCCobro = CC.ID
			--REVISAR PORQUE HAY PROPIEDADES MALAS

			
			COMMIT

		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50003, 'No se ha podido crear los pago.', 1;
		END CATCH
END

DELETE FROM [FacturacionMunicipal].[dbo].[IdRecibosPorPagar]

EXEC spProcesarPagosUsuario @jsonRecibos = '[{"id":1},{"id":7}]'

EXEC IniciarSimulacion
