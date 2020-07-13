Use FacturacionMunicipal
Go
CREATE OR ALTER PROCEDURE spBorradoLogUsuario
(
	@ID int,
	@UsuarioACargo varchar(20), 
	@IPusuario varchar(20)
)
AS 
BEGIN 
	BEGIN TRY
	declare @jsonAntes varchar(500), @idModified int, @insertedAt DATETIME
	SET @insertedAt = GETDATE()
	SET @idModified = (SELECT [ID] FROM [dbo].[PropietarioJuridico] WHERE [ID] = @id)
	-- Se crea el primer JSON
	SET @jsonAntes = (SELECT [ID], [NombrePersonaResponsable], [IdTipoDocumento], [ValorDocumento]
	FROM [dbo].[PropietarioJuridico] WHERE [ID] = @id
	FOR JSON PATH)
	UPDATE dbo.Usuario
	SET EstaBorrado=1
	WHERE ID = @ID
    EXEC [dbo].spInsertarBitacoraCambios @inIdEntityType = 6,
										@inEntityID = @idModified, 
										@inJsonAntes = @jsonAntes,
										@inJsonDespues = NULL, 
										@inInsertedBy = @UsuarioACargo, 
										@inInsertedIn = @IPusuario, 
										@inInsertedAt = @insertedAt
	 END TRY
	 BEGIN CATCH
		If @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW 50001, 'Error, no se pudo borrar', 1
	 END CATCH
END 