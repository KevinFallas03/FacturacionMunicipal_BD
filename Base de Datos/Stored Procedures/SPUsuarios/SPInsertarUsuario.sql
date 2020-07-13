--SP para insertar Usuario
use FacturacionMunicipal
go
Create or Alter procedure spInsertarUsuario
(
	@Nombre VARCHAR(150),
	@Password VARCHAR(150),
	@TipoUsuario VARCHAR(150), 
	@UsuarioACargo varchar(20), 
	@IPusuario varchar(20)
)
as
Begin
	BEGIN TRY
	declare @jsonDespues varchar(500), @idModified int, @insertedAt DATETIME
	Insert into [dbo].Usuario(Nombre, Password, TipoUsuario, FechaIngreso, EstaBorrado )
	Values (@Nombre, @Password, @TipoUsuario, CONVERT(DATE,GETDATE()), 0)
	SET @jsonDespues = (SELECT [id], [Nombre], [Password], [TipoUsuario], [FechaIngreso]
	FROM [dbo].[Usuario] WHERE [nombre] = @Nombre and [Password] = @Password
	FOR JSON PATH)
	SET @idModified = (SELECT [ID] FROM [dbo].[Usuario] WHERE [Nombre] = @Nombre and [Password] = @Password)
	SET @insertedAt = CONVERT(DATETIME, GETDATE())
	EXEC [dbo].[spInsertarBitacoraCambios] @inIdEntityType = 3,
										 @inEntityID = @idModified, 
										 @inJsonAntes = NULL,
										 @inJsonDespues = @jsonDespues, 
										 @inInsertedBy = @UsuarioACargo, 
										 @inInsertedIn = @IPusuario, 
										 @inInsertedAt = @insertedAt
	END TRY
	BEGIN CATCH
		If @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW 50000, 'Error no se pudo insertar usuario', 1
	END CATCH
End
