--=================================================
--  Trigger para los cambios en la tabla propiedad 
--=================================================

USE [FacturacionMunicipal]
GO


CREATE OR ALTER TRIGGER [dbo].[TRCambioPropiedad]
ON [dbo].[Propiedad]
AFTER  INSERT, UPDATE --VER SI SE HACE UNO SOLO PARA EL INSERT CON JSONDESPUES = NULL
AS

DECLARE @jsonAntes varchar(500), @jsonDespues varchar(500), @idMenor int, @idMayor int, @insertedAt DATE

SELECT @idMenor = min(ID), @idMayor=max(ID) FROM inserted

SET @insertedAt = (SELECT FechaIngreso FROM inserted WHERE ID = @idMenor)

WHILE @idMenor<=@idMayor
BEGIN
    SET @jsonAntes = (SELECT ID, NumFinca, Valor, Direccion, M3Acumulados,M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado
                    FROM deleted WHERE [id] = @idMenor
                    FOR JSON PATH)
    SET @jsonDespues = (SELECT ID, NumFinca, Valor, Direccion, M3Acumulados,M3AcumuladosUltimoRecibo, FechaIngreso, EstaBorrado
                    FROM inserted WHERE [id] = @idMenor
                    FOR JSON PATH)

    EXEC [dbo].spInsertarBitacoraCambios 
		@inIdEntityType = 1,--Pasar el tipo de entidad (1 = Propiedad)
		@inEntityID = @idMenor, 
		@inJsonAntes = @jsonAntes,
		@inJsonDespues = @jsonDespues, 
		@inInsertedBy = 'usuario1', --VER SI OBTIENE EL USUARIO ADMINISTRADOR QUE HIZO EL CAMBIO
		@inInsertedIn = 123,    --VER SI SE PUEDE OBTENER LA IP 
		@inInsertedAt = @insertedAt

    SET @idMenor = @idMenor+1

END