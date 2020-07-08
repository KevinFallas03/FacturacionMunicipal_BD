--=================================================
--  Trigger para los cambios en la tabla propiedad 
--=================================================

USE [FacturacionMunicipal]
GO


CREATE OR ALTER TRIGGER [dbo].[TRCambioPropiedad]
ON [dbo].[Propiedad]
AFTER  INSERT, UPDATE, DELETE
AS

DECLARE @jsonAntes varchar(500), @jsonDespues varchar(500), @idMenor int, @idMayor int,
				 @insertedAt DATETIME, @estaborrado bit, @ip varchar(255), @name varchar(255)


SELECT @idMenor = min(ID), @idMayor=max(ID) FROM inserted

SET @insertedAt = (SELECT FechaIngreso FROM inserted WHERE ID = @idMenor)

WHILE @idMenor<=@idMayor
BEGIN
	
    SET @jsonAntes = (SELECT ID, NumFinca, Valor, Direccion, M3Acumulados,M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado
                    FROM deleted WHERE [id] = @idMenor
                    FOR JSON PATH)

	SET @estaborrado = (select EstaBorrado FROM inserted where ID = @idMenor)

	IF @estaborrado=0
		SET @jsonDespues = (SELECT ID, NumFinca, Valor, Direccion, M3Acumulados,M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado
						FROM inserted WHERE [id] = @idMenor
						FOR JSON PATH)
	else
		SET @jsonDespues = NULL

	
	/*SET @name = host_name
	FROM sys.dm_exec_sessions
	WHERE Session_id = @@SPID*/

	SET @ip =(select (convert (varchar(48), ConnectionProperty('client_net_address'))) as [Style 1, sql_variant to varchar]
	from sys.dm_exec_connections
	WHERE Session_id = @@SPID)

    EXEC [dbo].spInsertarBitacoraCambios 
		@inIdEntityType = 1,--Pasar el tipo de entidad (1 = Propiedad)
		@inEntityID = @idMenor, 
		@inJsonAntes = @jsonAntes,
		@inJsonDespues = @jsonDespues, 
		@inInsertedBy = @name, --VER SI OBTIENE EL USUARIO ADMINISTRADOR QUE HIZO EL CAMBIO
		@inInsertedIn = @ip,    --VER SI SE PUEDE OBTENER LA IP 
		@inInsertedAt = @insertedAt


    SET @idMenor = @idMenor+1

END