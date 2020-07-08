USE [FacturacionMunicipal]
GO

/****** Object:  StoredProcedure [dbo].[spProcesaCambioValorPropiedad]    Script Date: 8/7/2020 00:51:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].spProcesaCambioValorPropiedad @PropiedadCambio CambioValorPropiedadType READONLY   
AS
BEGIN
	
	-- Variables para controlar la iteración
	declare @Lo1 int, @Hi1 int
	
	BEGIN TRY 
		SELECT @Lo1 = min(sec), @Hi1=max(sec) 
		FROM @PropiedadCambio
		--iteramos del menor al mayor cambio
		WHILE @Lo1<=@Hi1
			BEGIN
				UPDATE dbo.Propiedad
				SET dbo.Propiedad.Valor = PC.nuevoValor
				FROM [dbo].[Propiedad] P
				INNER JOIN @PropiedadCambio PC ON PC.numFinca = P.NumFinca
				WHERE PC.sec = @Lo1
				SET @Lo1 = @Lo1+1 
			END
	END TRY
	BEGIN CATCH
		return @@Error * -1
	END CATCH
End

GO


