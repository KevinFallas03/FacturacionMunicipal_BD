--SP para insertar Propietarios
use FacturacionMunicipal
go
Create or Alter procedure spInsertarPropietario
(
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30),
	@UsuarioACargo varchar(20), 
	@IPusuario varchar(20)
)
as
Begin
	BEGIN TRY 
	declare @jsonDespues varchar(500), @idModified int, @insertedAt DATETIME
	Insert into [dbo].Propietario (Nombre, IdTipoDocumento, ValorDocumento, EstaBorrado)
	Values (@Nombre, @IdTipoDocumento, @ValorDocumento, 0)
	select ID from Propietario where @Nombre=Nombre and @IdTipoDocumento=IdTipoDocumento and @ValorDocumento=ValorDocumento and 0=EstaBorrado
	SET @jsonDespues =( SELECT ID, Nombre, IdTipoDocumento, ValorDocumento
	FROM [dbo].Propietario WHERE [nombre] = @Nombre and ValorDocumento = @ValorDocumento
	FOR JSON PATH)
	SET @idModified = (SELECT [ID] FROM [dbo].Propietario WHERE [Nombre] = @Nombre and ValorDocumento = @ValorDocumento)
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
		THROW 50001, 'Error, no se pudo borrar', 1
	END CATCH
End