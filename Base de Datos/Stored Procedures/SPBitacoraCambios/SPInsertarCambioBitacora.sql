USE [FacturacionMunicipal]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[spInsertarBitacoraCambios] 
	@inIdEntityType int, --referencia a table EntityType
	@inEntityID int,	 --Id de la entidad siendo actualizada
	@inJsonAntes VARCHAR(500), --Datos antes de ser cambiados
	@inJsonDespues VARCHAR(500), --Datos despues del cambio
	@inInsertedBy varchar(20),  --Insertado por
	@inInsertedIn varchar(20),  --Ip desde donde se insertó
	@inInsertedAt DATETIME --Fecha del cambio
AS   
BEGIN
	If (@inIdEntityType IS Null and @inEntityID is NUll)
    BEGIN
        Return -1 --ocurrio un error
    END
	BEGIN TRY
		INSERT INTO [dbo].[BitacoraCambios] ([idEntityType], [EntityId], [jsonAntes],[jsonDespues],
											 [insertedBy],[insertedIn],[insertedAt])
		SELECT @inIdEntityType, @inEntityID, @inJsonAntes, @inJsonDespues, @inInsertedBy, @inInsertedIn, @inInsertedAt
	END TRY
	BEGIN CATCH
		THROW 50001,'Error: No se realizó el cambio en la bitacora',1;
	END CATCH
END
