Use FacturacionMunicipal
GO

IF type_id('[dbo].[CambioValorPropiedadType]') IS NOT NULL
        DROP TYPE [dbo].[CambioValorPropiedadType]; 

CREATE TYPE CambioValorPropiedadType AS TABLE 
(
	sec INT IDENTITY(1,1), 
	NumFinca INT, 
	NuevoValor MONEY
) 