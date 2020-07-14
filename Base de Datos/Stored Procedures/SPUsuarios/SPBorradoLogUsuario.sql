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
	declare @jsonAntes varchar(500), @insertedAt DATETIME
	SET @insertedAt = GETDATE()
	-- Se crea el primer JSON
	SET @jsonAntes = (SELECT [ID], [Nombre], [Password], [FechaIngreso]
	FROM [dbo].[Usuario] WHERE [ID] = @id
	FOR JSON PATH)
	UPDATE dbo.Usuario
	SET EstaBorrado=1
	WHERE ID = @ID
    EXEC [dbo].spInsertarBitacoraCambios @inIdEntityType = 3,
										@inEntityID = @ID, 
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