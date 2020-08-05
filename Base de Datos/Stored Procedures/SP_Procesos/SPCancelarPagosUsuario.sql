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
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
		--ANULA LOS RECIBOS MORATORIOS QUE ESTABAN EN LA TABLA
		UPDATE [dbo].[Recibo]
		SET estado = 2
		FROM [dbo].[Recibo] R
		INNER JOIN IdRecibosPorPagar RP ON R.id = RP.sec
		WHERE R.IdCCobro = 11 AND R.estado = 3;
		--ELIMINA LA TABLA YA QUE NO LA NECESITO MAS HACER BORRADO LÓGICO
		delete dbo.[IdRecibosPorPagar]
END