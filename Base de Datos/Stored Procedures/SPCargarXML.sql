-- =================================================================================================
-- Autores:		<Kevin Fallas y Johel Mora>
-- Fecha de creacion: <31/5/2020>
-- Fecha de Ultima Modification: <>
-- Descripcion:	<SP para cargar datos de tablas [TipoDocumentoId], >
-- =================================================================================================

USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO

CREATE OR ALTER PROCEDURE [dbo].[spCargarDatos]

AS
BEGIN
	SET NOCOUNT ON;

	-- VARIABLES --
	DECLARE @DocHandle int, @temp xml, @TipoDocumento xml, @CCobro xml
	
	DECLARE @TiposDocumentos TABLE
	(
		codigoDoc int,
		descripcion varchar(100)
	)
	BEGIN TRY
		--Insercion de los tipos de documentos de identificacion
		SELECT @TipoDocumento = TD
		FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\TipoDocumentoIdentidad.xml', Single_BLOB) AS TipoDocumento(TD)

		INSERT INTO TipoDocumentoId(ID, Nombre)
		SELECT td.value('@codigoDoc', 'VARCHAR(10)')
		, td.value('@descripcion', 'VARCHAR(100)')
		FROM @TipoDocumento.nodes('/TipoDocIdentidad/TipoDocId') AS t(td)

	END TRY

	BEGIN CATCH
		return @@ERROR * -1
	END CATCH
END
GO

exec spCargarDatos
exec ReiniciarTablas