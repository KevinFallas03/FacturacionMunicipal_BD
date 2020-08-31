USE [FacturacionMunicipal]
GO
IF OBJECT_ID('[dbo].[spCancelarPagosUsuario]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[spCancelarPagosUsuario]  
END 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCancelarPagosUsuario]
AS 
BEGIN 
	
		BEGIN TRY 
			--ANULA LOS RECIBOS MORATORIOS QUE ESTABAN EN LA TABLA
			UPDATE [dbo].[Recibo]
			SET estado = 2
			FROM [dbo].[Recibo] R
			INNER JOIN IdRecibosPorPagar RP ON R.id = RP.sec
			WHERE R.IdCCobro = 11 AND R.estado = 3;
		
			--ELIMINA LOS ID DE LA TABLA PORQUE FUERON CANCELADOS
			DELETE dbo.[IdRecibosPorPagar]
		END TRY
		BEGIN CATCH
			THROW 92039, 'Error: no se ha podido completar el pago de los recibos.',1
		END CATCH;

END