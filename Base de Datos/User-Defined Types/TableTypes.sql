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

IF type_id('[dbo].[PagosHoyType]') IS NOT NULL
        DROP TYPE [dbo].[PagosHoyType];

CREATE TYPE PagosHoyType AS TABLE
(
	sec INT IDENTITY(1,1),
	NumFinca INT,
	TipoRecibo INT,
	Fecha DATE
)

IF type_id('[dbo].[APHoyType]') IS NOT NULL
        DROP TYPE [dbo].[APHoyType]; 
CREATE TYPE APHoyType AS TABLE
(
	sec INT IDENTITY(1,1),
	NumFinca INT,
	Plazo INT,
	Fecha DATE
)

IF type_id('[dbo].[MovConsumoType]') IS NOT NULL
        DROP TYPE [dbo].[MovConsumoType]; 

CREATE TYPE MovConsumoType AS TABLE
(
	sec INT IDENTITY(1,1),
	NumFinca INT,
	M3 INT,
	TipoMov INT,
	Descripcion VARCHAR(100),
	Fecha DATE
)