
USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO

CREATE OR ALTER PROCEDURE [dbo].[spCargarDatosCC]
AS
BEGIN
    SET NOCOUNT ON;

    -- VARIABLES --
    DECLARE @CCobro xml, @Monto MONEY, @ValorM3 MONEY, @ValorPorcentaje REAL

    BEGIN TRY
        --Insercion de los tipos de documentos de identificacion
        SELECT @CCobro = CC
        FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\Concepto_de_Cobro.xml', Single_BLOB) AS CCobro(CC)

        INSERT INTO CCobro (ID, Nombre, TasaInteresMoratorio, DiaEmisionRecibo, QDiasVencimiento, EsImpuesto, EsRecurrente, EsFijo, TipoCC, Activo)
        SELECT c.value('@id','INT') AS ID
            , c.value('@Nombre','VARCHAR(100)') AS Nombre
            , c.value('@TasaInteresMoratoria','DECIMAL(10,2)') AS TasaInteresMoratorio
            , c.value('@DiaCobro','TINYINT') AS DiaEmisionRecibo
            , c.value('@QDiasVencimiento','TINYINT') AS QDiasVencimiento
            , c.value('@EsImpuesto','VARCHAR(10)') AS EsImpuesto 
            , c.value('@EsRecurrente','VARCHAR(10)') AS EsRecurrente  
            , c.value('@EsFijo','VARCHAR(10)') AS EsFijo  
            , c.value('@TipoCC','VARCHAR(10)') AS TipoCC
            , 1 AS Activo
        FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(c);

		;WITH rs AS
		(
			SELECT c.value('@id','INT') AS ID
				, c.value('@Monto','MONEY') AS MontoFijo
			FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(c)
		)
		INSERT INTO CCobro_MontoFijo (ID, MontoFijo)
		SELECT ID, MontoFijo FROM rs
		WHERE rs.MontoFijo > 0;


    END TRY

    BEGIN CATCH
        return @@ERROR * -1
    END CATCH
 END

exec spCargarDatosCC