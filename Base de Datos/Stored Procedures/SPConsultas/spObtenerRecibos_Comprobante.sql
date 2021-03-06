USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].['spObtenerRecibos_Comprobante']    Script Date: 5/8/2020 05:26:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Johel y Kevin>
-- Create date: <20/05/2020>
-- Description:	<SP para ver detalles de Comprobantes>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[spObtenerRecibos_Comprobante]
	@idC int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT R.ID, FechaEmision, FechaMaximaPago, CC.Nombre, Monto
		FROM Recibo AS R
		INNER JOIN CCobro AS CC ON CC.ID = R.IdCCobro
		INNER JOIN ReciboPagado AS RP ON R.ID = RP.IdRecibo
		WHERE @idC = RP.IdComprobante
		ORDER BY R.FechaEmision, CC.Nombre ASC
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
	RETURN 1
END
