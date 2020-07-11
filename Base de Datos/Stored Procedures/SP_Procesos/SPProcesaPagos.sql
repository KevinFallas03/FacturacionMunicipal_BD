USE [FacturacionMunicipal]
GO

CREATE OR ALTER PROC [dbo].[spProcesaPagos] @PagosHoy PagosHoyType READONLY
AS   
	BEGIN
		--BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON
			DECLARE @idMenor INT, @idMayor INT, @fechaVence DATE, @fechaOperacion DATE, @montoMoratorio MONEY, @contador INT,
					@idComprobante INT, @tasaMoratoria FLOAT, @montoRecibo MONEY, @tipoCC int, @idPropiedad INT
			--TABLA DE IDS DE RECIBOS POR CONCEPTO DE COBRO DE CADA PROPIEDAD 
			DECLARE @idRecibosPagar TABLE(id INT IDENTITY(1,1),idRecibo INT)
			--CONTADOR PARA ITERAR TABLA DE RECIBOS DE CADA PROPIEDAD Y SABER DONDE QUEDE LA ULTIMA VEZ
			SET @contador = 1
			SELECT @idMenor = min([sec]), @idMayor=max([sec]) FROM @PagosHoy--SACA ID MAYOR Y MENOR PARA ITERAR LA TABLA
			--BEGIN TRAN
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
							INSERT INTO @idRecibosPagar(idRecibo)
							SELECT R.ID
							FROM @PagosHoy P
							INNER JOIN dbo.Propiedad AS PR ON PR.NumFinca = P.NumFinca 
							INNER JOIN dbo.Recibo AS R ON R.IdPropiedad = PR.ID
							WHERE P.sec = @idMenor AND R.Estado = 0
							AND (R.IdCCobro = 1	  --GUARDA TODOS LOS RECIBOS DE AGUA PENDIENTES (1)
								OR R.IdCCobro = 11 --GUARDA TODOS LOS RECIBOS MORATORIOS PENDIENTES (11)
								OR R.IdCCobro = 10)--GUARDA TODOS LOS RECIBOS DE RECONEXION PENDIENTES (10)
						END
					ELSE--SI ES OTRO CONCEPTO DE COBRO
						BEGIN
							INSERT INTO @idRecibosPagar(idRecibo)
							SELECT R.ID
							FROM @PagosHoy P
							INNER JOIN [dbo].[Propiedad] AS PR ON PR.NumFinca = P.NumFinca 
							INNER JOIN [dbo].[Recibo] AS R ON R.IdPropiedad = PR.ID
							--WHERE P.sec = @idMenor AND R.[Estado] = 0
							--AND (R.IdCCobro = 11			--GUARDA TODOS LOS RECIBOS MORATORIOS PENDIENTES (11)
							--	OR	R.IdCCobro = @tipoCC)--GUARDA TODOS LOS RECIBOS DE DE ESE CONCEPTO DE COBRO PENDIENTES (@TIPOCC)
						END
					

					/*
					--MIENTRAS EXISTA UN CONCEPTO DE COBRO SIN PAGAR, RECORRA LOS RECIBOS
					WHILE EXISTS(SELECT idRP.id FROM @idRecibosPagar idRP INNER JOIN [dbo].[Recibo] AS R ON R.ID = idRP.idRecibo WHERE R.Estado = 0)
					BEGIN
						--ESTABLECE EL MONTO DEL RECIBO
						SET @montoRecibo = (SELECT R.Monto FROM [dbo].[Recibo] AS R
											INNER JOIN @idRecibosPagar idRP ON R.id = idRP.idRecibo
											WHERE idRP.id = @contador)

						--INSERTA UNA RELACION ENTRE RECIBO Y COMPROBANTE DE PAGO
						INSERT INTO [dbo].[ReciboPagado](IdRecibo, IdComprobante)
						SELECT idRP.idRecibo, @idComprobante
						FROM @idRecibosPagar idRP
						WHERE idRP.id = @contador

						--PAGA EL RECIBO ACTUALIZANDO SU ESTADO A PAGADO
						UPDATE [dbo].[Recibo]
						SET [estado] = 1
						FROM @idRecibosPagar idRP
						WHERE idRP.idRecibo = [dbo].[Recibo].[ID] AND idRP.id = @contador

						--VERIFICA SI SE DEBE CREAR RECIBO MORATORIO
						--SACA LA FECHA EN LA QUE VENCE EL RECIBO
						SET @fechaVence = (SELECT FechaMaximaPago FROM [dbo].[Recibo] R
										   INNER JOIN @idRecibosPagar idRP ON idRP.idRecibo = R.id
										   WHERE @contador = idRP.id)
						--SI LA FECHA EN LA QUE VENCE ES MENOR A LA FECHA EN LA QUE SE ESTA PAGANDO EL RECIBO
						IF @fechaVence < @fechaOperacion
						BEGIN
							--SACA LA TASA MORATORIA DE ESE RECIBO
							SET @tasaMoratoria = (SELECT CC.TasaInteresMoratorio FROM [dbo].[CCobro] CC
													INNER JOIN [dbo].[Recibo] AS R ON R.IdCCobro = CC.ID 
													INNER JOIN  @idRecibosPagar AS idRP ON idRP.idRecibo = R.id
													WHERE idRP.id = @contador)
							--AQUI CAMBIA EL MONTO MORATORIO YA QUE SI SE DEBE CREAR RECIBO MORATORIO
							SET @montoMoratorio = (@montoRecibo*@tasaMoratoria/365)*ABS(DATEDIFF(day, @fechaVence, @fechaOperacion))
							
							--CREA UN RECIBO RE TIPO MORATORIO Y LO PAGA
							INSERT INTO [dbo].[Recibo](IdPropiedad,IdCCobro,Monto,Estado,FechaEmision,FechaMaximaPago)
							SELECT @idPropiedad, CC.ID,@montoMoratorio, 1, @fechaOperacion, DATEADD(day, CC.QDiasVencimiento, @fechaOperacion)
							FROM [dbo].[CCobro] AS CC
							WHERE CC.ID = 11
							
							--INSERTAR UNA RELACION ENTRE EL RECIBO MORATORIO PAGADO Y EL COMPROBANTE DE PAGO
							INSERT INTO [dbo].[ReciboPagado](IdComprobante,IdRecibo)
							SELECT @idComprobante, IDENT_CURRENT('[dbo].[Recibo]')	
						END
						--AL FINAL ACTUALIZA EL MONTO DEL COMPROBANTE DE PAGO
						UPDATE [dbo].[ComprobantePago]
						SET MontoTotal = MontoTotal+@montoRecibo+@montoMoratorio--SI NO HUBO RECIBO MORATORIO SUMA 0 MAS EL MONTO POR LOS DEMAS RECIBOS
						WHERE ID = @idComprobante
						SET @contador = @contador+1--INCREMENTA EL CONTADOR
					END*/

					SET @idMenor = @idMenor+1
				END
				select * from @idRecibosPagar
			--COMMIT
		/*END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50003, 'Error: No se ha podido crear los pago.', 1;
		END CATCH*/

		
	END

	EXEC ReiniciarTablas
	EXEC IniciarSimulacion