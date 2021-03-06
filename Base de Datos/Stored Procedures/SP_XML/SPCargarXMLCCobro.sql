USE [FacturacionMunicipal]
GO
/****** Object:  StoredProcedure [dbo].[spCargarDatosCC]    Script Date: 14/7/2020 00:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   PROCEDURE [dbo].[spCargarDatosCC]
AS
BEGIN
    SET NOCOUNT ON;                                                                                                                                                                                                                                                                                             

    -- VARIABLES --
    DECLARE @CCobro XML

    BEGIN TRY
		declare @jsonDespues varchar(500), @insertedAt DATETIME, @max INT, @min INT, @IP VARCHAR(20)
		SET @insertedAt = GETDATE() 
        --Insercion de los tipos de CCobro
        SELECT @CCobro = CC
        FROM OPENROWSET (Bulk 'D:\Base de datos\FacturacionMunicipal_BD\Base de Datos\XML\Concepto_de_Cobro.xml', Single_BLOB) AS CCobro(CC)

        INSERT INTO dbo.CCobro (ID, Nombre, TasaInteresMoratorio, DiaEmisionRecibo, QDiasVencimiento, EsImpuesto, EsRecurrente, EsFijo, TipoCC, Activo)
        SELECT c.value('@id','INT') AS ID
            , c.value('@Nombre','VARCHAR(100)') AS Nombre
            , c.value('@TasaInteresMoratoria','REAL') AS TasaInteresMoratorio
            , c.value('@DiaCobro','TINYINT') AS DiaEmisionRecibo
            , c.value('@QDiasVencimiento','TINYINT') AS QDiasVencimiento
            , c.value('@EsImpuesto','VARCHAR(10)') AS EsImpuesto
            , c.value('@EsRecurrente','VARCHAR(10)') AS EsRecurrente
            , c.value('@EsFijo','VARCHAR(10)') AS EsFijo  
            , c.value('@TipoCC','VARCHAR(10)') AS TipoCC
            , 1 AS Activo
        FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(c); 		

		WITH cm AS
		(
			SELECT c.value('@id','INT') AS ID
				, c.value('@Monto','MONEY') AS MontoFijo
			FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(c)
		)
		INSERT INTO CCobro_MontoFijo (ID, MontoFijo)
		SELECT ID, MontoFijo FROM cm
		WHERE cm.MontoFijo > 0;

		WITH ci AS
		(
			SELECT cci.value('@id','INT') AS ID
				, cci.value('@ValorPorcentaje','REAL') AS InteresMoratorio
			FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(cci)
		)
		INSERT INTO CCobro_InteresMoratorio(ID, Valor_Porcentual)
		SELECT ID, InteresMoratorio FROM ci
		WHERE ci.InteresMoratorio > 0;

		WITH ca AS
		(
			SELECT cca.value('@id','INT') AS ID
				, cca.value('@ValorM3','INT') AS ConsumoM3
				, cca.value('@MontoMinRecibo', 'INT') AS MontoMinimoRecibo
			FROM @CCobro.nodes('/Conceptos_de_Cobro/conceptocobro') AS t(cca)
		)
		INSERT INTO CCobro_ConsumoAgua(ID, ConsumoM3, MontoMinimoRecibo)
		SELECT ID, ConsumoM3, MontoMinimoRecibo FROM ca
		WHERE ca.ConsumoM3 > 0;

		-- BITACORA
		SELECT @max= MAX(ID), @min=MIN(id) FROM CCobro
		while (@min<=@max)
		Begin
			SET @insertedAt = GETDATE()
			SET @ip =(select (convert (varchar(48), ConnectionProperty('client_net_address'))) as [Style 1, sql_variant to varchar]
			from sys.dm_exec_connections
			WHERE Session_id = @@SPID)
			SET @jsonDespues = (SELECT  ID, Nombre, TasaInteresMoratorio, DiaEmisionRecibo, QDiasVencimiento, EsImpuesto,  EsRecurrente, EsFijo, TipoCC
			FROM CCobro WHERE ID=@min
			FOR JSON PATH)
			EXEC [dbo].spInsertarBitacoraCambios @inIdEntityType = 7,
				   						 @inEntityID = @min, 
										 @inJsonAntes = Null,
										 @inJsonDespues = @jsonDespues, 
										 @inInsertedBy = @IP, 
										 @inInsertedIn = @IP, 
										 @inInsertedAt = @insertedAt
			SET @min=@min+1
		end
		return 1

    END TRY

    BEGIN CATCH
        return @@ERROR * -1
    END CATCH
 END

--exec spCargarDatosCC
