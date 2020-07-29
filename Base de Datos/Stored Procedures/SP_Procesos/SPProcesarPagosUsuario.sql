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
					@FechaMax DATE, 
					@fechaOperacion DATE, 
					@montoMoratorio MONEY, 
					@inRecibo  INT,
					@idComprobante INT, 
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

			INSERT INTO @IdRecibosPagar(ID)
			SELECT id
			FROM OPENJSON (@jsonRecibos)
			WITH(
				id int '$.id'
			);

			INSERT INTO @PagosHoy(sec, NumFinca, TipoRecibo, Fecha)
			SELECT RP.ID, P.NumFinca, R.IdCCobro, CONVERT(DATE, GETDATE())
			FROM Recibo R
			INNER JOIN Propiedad P ON P.ID=R.IdPropiedad
			INNER JOIN @IdRecibosPagar RP ON RP.ID = R.ID;



			/* PRUEBAS ELIMINAR LUEGO LAS TABLAS
			INSERT INTO dbo.PruebaIDRecibosPagar
			SELECT * FROM @IdRecibosPagar

			INSERT INTO dbo.TablaPruebaPago
			SELECT * FROM @PagosHoy

			*/

			/*
			--Tabla de id por concepto de cobro de cada propiedad 
			DECLARE @ReciboPagar TABLE
			(
				id INT IDENTITY(1,1),
				idRecibo INT
			)

			--@inRecibo itera sobre la tabla recibo
			SET @inRecibo = 1
			SELECT @idMenor = min([sec]), @idMayor=max([sec]) FROM @PagosHoy--SACA ID MAYOR Y MENOR PARA ITERAR LA TABLA
			
			BEGIN TRANSACTION
				--RECORRE LOS PAGOS DE FINCAS
				WHILE @idMenor<=@idMayor
				BEGIN
					SET @montoMoratorio = 0 --MONTO MORATORIO SE CAMBIA SI ES QUE HAY RECIBO MORATORIO, SINO ES 0
					SET @fechaOperacion = (SELECT Fecha FROM @PagosHoy WHERE sec = @idMenor)
					SET @tipoCC = (SELECT TipoRecibo FROM @PagosHoy WHERE sec = @idMenor)--TIPO CC EN EL PAGO
					SET @idPropiedad = (SELECT PR.ID FROM Propiedad AS PR --PROPIEDAD A LA QUE SE LE HACE EL PAGO
										INNER JOIN @PagosHoy AS P ON P.NumFinca = PR.NumFinca 
										WHERE P.sec = @idMenor)
					
					--VERIFICA SI EXISTE EL COMPROBANTE DE PAGO PARA ESA PROPIEDAD, ESE MISMO DIA
					SET @idComprobante = (SELECT CP.ID FROM ComprobantePago AS CP 
										  INNER JOIN ReciboPagado AS RP ON RP.IdComprobante = CP.ID
										  INNER JOIN Recibo R ON R.ID = RP.IdRecibo
										  WHERE R.IdPropiedad = @idPropiedad AND CP.FechaPago = @fechaOperacion)
				
					--SI NO EXISTE ENTONCES LO CREA
					IF @idComprobante IS NULL
					BEGIN
						INSERT INTO ComprobantePago(FechaPago, MontoTotal)
						SELECT @fechaOperacion, 0
						SET @idComprobante = IDENT_CURRENT('ComprobantePago')
					END
					
					--SE INSERTAN LOS RECIBOS DE LA PROPIEDAD EN LA TABLA VARIABLE, Y SE VAN ACUMULANDO, PARA ESO SE USA EL CONTADOR
					--SI ES CONCEPTO DE COBRO 10 (RECONEXION)
					IF @tipoCC = 10
						BEGIN
							INSERT INTO @ReciboPagar(idRecibo)
							SELECT R.ID
							FROM @PagosHoy PH
							INNER JOIN dbo.Propiedad AS PR ON PR.NumFinca = PH.NumFinca 
							INNER JOIN dbo.Recibo AS R ON R.IdPropiedad = PR.ID
							WHERE PH.sec = @idMenor AND R.Estado = 0
							AND (R.IdCCobro = 1	  --GUARDA TODOS LOS RECIBOS DE AGUA PENDIENTES (1)
								OR R.IdCCobro = 11 --GUARDA TODOS LOS RECIBOS MORATORIOS PENDIENTES (11)
								OR R.IdCCobro = 10)--GUARDA TODOS LOS RECIBOS DE RECONEXION PENDIENTES (10)
						END
					ELSE--SI ES OTRO CONCEPTO DE COBRO
						BEGIN
							INSERT INTO @ReciboPagar(idRecibo)
							SELECT R.ID
							FROM @PagosHoy PH
							INNER JOIN [dbo].[Propiedad] AS PR ON PR.NumFinca = PH.NumFinca 
							INNER JOIN [dbo].[Recibo] AS R ON R.IdPropiedad = PR.ID
							WHERE PH.sec = @idMenor AND R.[Estado] = 0
							AND (R.IdCCobro = 11			--GUARDA TODOS LOS RECIBOS MORATORIOS PENDIENTES (11)
								OR	R.IdCCobro = @tipoCC)--GUARDA TODOS LOS RECIBOS DE DE ESE CONCEPTO DE COBRO PENDIENTES (@TIPOCC)
						END
					

					--MIENTRAS EXISTA UN CONCEPTO DE COBRO SIN PAGAR, RECORRA LOS RECIBOS
					WHILE EXISTS(SELECT Rp.id FROM @ReciboPagar Rp INNER JOIN [dbo].[Recibo] AS R ON R.ID = Rp.idRecibo WHERE R.Estado = 0)
					BEGIN
						--ESTABLECE EL MONTO DEL RECIBO
						SET @montoRecibo = (SELECT R.Monto FROM [dbo].[Recibo] AS R
											INNER JOIN @ReciboPagar Rp ON R.id = Rp.idRecibo
											WHERE Rp.id = @inRecibo)

						--INSERTA UNA RELACION ENTRE RECIBO Y COMPROBANTE DE PAGO
						INSERT INTO [dbo].[ReciboPagado](IdRecibo, IdComprobante)
						SELECT Rp.idRecibo, @idComprobante
						FROM @ReciboPagar Rp
						WHERE Rp.id = @inRecibo 

						--PAGA EL RECIBO ACTUALIZANDO SU ESTADO A PAGADO
						UPDATE [dbo].[Recibo]
						SET [estado] = 1
						FROM @ReciboPagar Rp
						WHERE Rp.idRecibo = [dbo].[Recibo].[ID] AND Rp.id = @inRecibo

						--VERIFICA SI SE DEBE CREAR RECIBO MORATORIO
						--SACA LA FECHA EN LA QUE VENCE EL RECIBO
						SET @FechaMax = (SELECT FechaMaximaPago FROM [dbo].[Recibo] R
										   INNER JOIN @ReciboPagar Rp ON Rp.idRecibo = R.id
										   WHERE @inRecibo = Rp.id)
						--SI LA FECHA EN LA QUE VENCE ES MENOR A LA FECHA EN LA QUE SE ESTA PAGANDO EL RECIBO
						IF @FechaMax < @fechaOperacion
						BEGIN
							--SACA LA TASA MORATORIA DE ESE RECIBO
							SET @tasaMoratoria = (SELECT CC.TasaInteresMoratorio FROM [dbo].[CCobro] CC
													INNER JOIN [dbo].[Recibo] AS R ON R.IdCCobro = CC.ID 
													INNER JOIN  @ReciboPagar AS Rp ON Rp.idRecibo = R.id
													WHERE Rp.id = @inRecibo)
							--AQUI CAMBIA EL MONTO MORATORIO YA QUE SI SE DEBE CREAR RECIBO MORATORIO
							SET @montoMoratorio = (@montoRecibo*@tasaMoratoria/365)*ABS(DATEDIFF(day, @FechaMax, @fechaOperacion)) --cuenta del monto del interes moratorio
							
							--CREA UN RECIBO TIPO MORATORIO Y LO PAGA
							INSERT INTO [dbo].[Recibo](IdPropiedad,IdCCobro,Monto,Estado,FechaEmision,FechaMaximaPago)
							SELECT @idPropiedad, CC.ID,@montoMoratorio, 1, @fechaOperacion, DATEADD(day, CC.QDiasVencimiento, @fechaOperacion)
							FROM [dbo].[CCobro] AS CC
							WHERE CC.ID = 11
							
							--RELACION ENTRE EL RECIBO MORATORIO PAGADO Y EL COMPROBANTE DE PAGO
							INSERT INTO [dbo].[ReciboPagado](IdComprobante, IdRecibo)
							SELECT @idComprobante, IDENT_CURRENT('[dbo].[Recibo]')	
						END
						
						--SE ACTUALIZA EL MONTO DEL COMPROBANTE DE PAGO
						UPDATE [dbo].[ComprobantePago]
						SET MontoTotal = MontoTotal+@montoRecibo+@montoMoratorio--SI NO HUBO RECIBO MORATORIO SUMA 0 MAS EL MONTO POR LOS DEMAS RECIBOS
						WHERE ID = @idComprobante
						
						SET @inRecibo = @inRecibo+1
					END
					--PRINT @idMenor
					SET @idMenor = @idMenor+1
				END
				
				COMMIT*/
		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50003, 'No se ha podido crear los pago.', 1;
		END CATCH
END

	EXEC IniciarSimulacion

CREATE TABLE dbo.TablaPruebaPago(
	sec INT PRIMARY KEY,
	NumFinca INT,
	TipoRecibo INT,
	Fecha DATE
)

CREATE TABLE  dbo.PruebaIDRecibosPagar 
(
	ID INT PRIMARY KEY
)