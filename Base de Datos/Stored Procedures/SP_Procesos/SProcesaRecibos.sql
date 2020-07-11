USE [FacturacionMunicipal]
GO

CREATE OR ALTER PROC [dbo].[spProcesaRecibos] @FechaActual DATE
AS 
BEGIN
	
	BEGIN TRY
		SET NOCOUNT ON 
		SET XACT_ABORT ON
			DECLARE @dia int
			SET @dia  = DAY(@FechaActual)
			BEGIN TRAN
				INSERT INTO dbo.Recibo(IdPropiedad,IdCCobro,Monto,Estado,FechaEmision,FechaMaximaPago)
				SELECT
					P.ID,
					CC.ID,
					CASE WHEN (CC.esFijo = 'Si' AND CC.id != 1) THEN CCM.MontoFijo 
					WHEN (CC.esImpuesto = 'Si') THEN P.valor/100*CCI.Valor_Porcentual
					WHEN (CC.id = 1) THEN 
						CASE WHEN (P.M3acumulados - P.M3AcumuladosUltimoRecibo)*CCC.ConsumoM3 > CCC.MontoMinimoRecibo
						THEN (P.M3acumulados - P.M3AcumuladosUltimoRecibo)*CCC.ConsumoM3
						ELSE CCC.montoMinimoRecibo 
						END
					END,
					0,
					@FechaActual,
					DATEADD(day,CC.QDiasVencimiento, @FechaActual)
				FROM [dbo].[CCobro_PNP] CCP 
				INNER JOIN [dbo].[CCobro] CC ON CCP.IdCCobbro = CC.id
				INNER JOIN [dbo].[Propiedad] P ON CCP.idPropiedad = P.id
				FULL OUTER JOIN [dbo].[CCobro_InteresMoratorio] CCI ON CCI.ID = CC.ID
				FULL OUTER JOIN [dbo].[CCobro_ConsumoAgua] CCC ON CCC.id = CC.ID
				FULL OUTER JOIN [dbo].[CCobro_MontoFijo] CCM ON CCM.ID = CC.ID
				WHERE CC.DiaEmisionRecibo = @dia

				UPDATE [dbo].[Propiedad]
				SET M3AcumuladosUltimoRecibo = M3acumulados
				FROM [dbo].[Propiedad] P
				INNER JOIN [dbo].[CCobro_PNP] CCP ON CCP.IdPropiedad = P.id
				INNER JOIN [dbo].[CCobro] CC ON CC.ID = CCP.IdCCobbro
				WHERE CC.id = 1 AND CC.DiaEmisionRecibo = @dia AND P.M3AcumuladosUltimoRecibo != P.M3acumulados
			COMMIT
		END TRY
		BEGIN CATCH
			If @@TRANCOUNT > 0 
				ROLLBACK TRAN;
			THROW 50004,'Error: No se ha podido generar los recibos',1;
		END CATCH

END