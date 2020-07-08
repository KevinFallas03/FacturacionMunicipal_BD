USE [FacturacionMunicipal]
GO
IF OBJECT_ID('[dbo].[spInsertarBitacoraCambios]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[spInsertarBitacoraCambios] 
END

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
	@inInsertedAt DATE --Fecha del cambio
AS   
BEGIN 
	BEGIN TRY
		DECLARE @IdUsuario int
		SET @IdUsuario = (SELECT [ID] FROM [dbo].[Usuario] WHERE [Nombre] = @inInsertedBy)
		INSERT INTO [dbo].[BitacoraCambios] ([idEntityType], [EntityId], [jsonAntes],[jsonDespues],
											 [insertedAt],[insertedBy],[insertedIn])
		SELECT @inIdEntityType, @inEntityID, @inJsonAntes, @inJsonDespues, @inInsertedAt, @IdUsuario, @inInsertedIn
	END TRY
	BEGIN CATCH
		THROW 762839,'Error: No se realizó el cambio en la bitacora',1; --REVISAR CODIGOS
	END CATCH
END
