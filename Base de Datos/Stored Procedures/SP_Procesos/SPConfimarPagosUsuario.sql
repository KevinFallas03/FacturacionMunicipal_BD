USE [FacturacionMunicipal]
GO
IF OBJECT_ID('[dbo].[SP_completarPagoRecibos]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[SP_completarPagoRecibos]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spConfirmarPagosUsuario]
AS 
BEGIN 
	BEGIN TRY 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
		DECLARE @montoComprobante MONEY
		--GUARDA EL MONTO TOTAL
		SET @montoComprobante = (	SELECT SUM(Monto) 
									FROM [dbo].[Recibo] R 
									INNER JOIN dbo.[IdRecibosPorPagar] RP ON R.ID = RP.sec
								)
				
		BEGIN TRAN
			--CREA UN COMPROBANTE DE PAGO
			INSERT INTO [dbo].[ComprobantePago](FechaPago, MontoTotal) --Verificar Medio de Pago
			SELECT GETDATE(), @montoComprobante
				
			--INSERTA LOS RECIBOS EN RECIBOS PAGADOS
			INSERT INTO [dbo].[ReciboPagado](IdRecibo,IdComprobante)
			SELECT RP.sec, IDENT_CURRENT('[dbo].[ComprobantePago]')
			FROM dbo.[IdRecibosPorPagar] RP

			--ACTUALIZA EL ESTADO A PAGADOS
			UPDATE [dbo].[Recibo]
			SET Estado = 1 --Se pagó
			FROM [dbo].[Recibo] R
			INNER JOIN [dbo].[IdRecibosPorPagar] RP ON R.id = RP.sec
				
				
			--ELIMINA LA TABLA YA QUE SE PAGARON LOS RECIBOS LOGICO --HACER BORRADO LOGICO
			DELETE IdRecibosPorPagar

		COMMIT

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
			ROLLBACK TRAN;
		THROW 92039, 'Error: no se ha podido completar el pago de los recibos.',1
	END CATCH;
END