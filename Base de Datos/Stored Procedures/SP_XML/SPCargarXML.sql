USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spCargarDatos]    Script Date: 7/7/2020 22:54:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create or ALTER   PROCEDURE [dbo].[spCargarDatos]

AS
BEGIN
	SET NOCOUNT ON;

	-- VARIABLES --
	DECLARE @TipoDocumento xml, @TipoEntidad xml, @TipoConsumo xml
	
	BEGIN TRY
		--Insercion de los tipos de documentos de identificacion
		SELECT @TipoDocumento = TD
		FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\TipoDocumentoIdentidad.xml', Single_BLOB) AS TipoDocumento(TD)

		INSERT INTO dbo.TipoDocumentoId(ID, Nombre)
		SELECT td.value('@codigoDoc', 'VARCHAR(10)')
		, td.value('@descripcion', 'VARCHAR(100)')
		FROM @TipoDocumento.nodes('/TipoDocIdentidad/TipoDocId') AS t(td)

		--Insercion de los tipos de entidad
		SELECT @TipoEntidad = TE
		FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\EntityType.xml', Single_BLOB) AS TipoEntidad(TE)
		INSERT INTO dbo.EntityType(ID, Nombre)
		SELECT te.value('@id', 'INT')
		, te.value('@Nombre', 'VARCHAR(100)')
		FROM @TipoEntidad.nodes('/TipoEntidades/Entidad') AS t(te)

		--Insercion de los tipos de consumo
		SELECT @TipoConsumo = TC
		FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\TipoTransConsumo.xml', Single_BLOB) AS TipoConsumo(TC)
		INSERT INTO dbo.TipoMovimiento(ID, Nombre)
		SELECT tc.value('@id', 'INT')
		, tc.value('@Nombre', 'VARCHAR(100)')
		FROM @TipoConsumo.nodes('/TipoTransConsumo/TransConsumo') AS t(tc)

	END TRY

	BEGIN CATCH
		return @@ERROR * -1
	END CATCH

END

--Exec ReiniciarTablas

--Exec spCargarDatos