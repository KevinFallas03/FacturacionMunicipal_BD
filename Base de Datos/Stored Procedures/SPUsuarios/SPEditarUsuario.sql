use FacturacionMunicipal
go

Create or Alter procedure spEditarUsuario
(      
	@id int,
	@Nombre varchar(100),
	@Password varchar(100),
	@TipoUsuario VARCHAR(50),
	@UsuarioACargo varchar(20), 
	@IPusuario varchar(20) 
)      
as      
begin  
	begin try
	declare @jsonAntes varchar(500), @jsonDespues varchar(500), @idModified int, @insertedAt DATETIME
	SET @insertedAt = GETDATE()
	SET @idModified = (SELECT [ID] FROM [dbo].[Usuario] WHERE [ID] = @id)
   -- Se crea el primer JSON
   SET @jsonAntes = (SELECT [id], [nombre], [password], [tipoUsuario], [fechaIngreso]
   FROM [dbo].[Usuario] WHERE [ID] = @id
   FOR JSON PATH)

   Update [dbo].Usuario
   set Nombre=@Nombre, Password=@Password, TipoUsuario=@TipoUsuario
   where ID=@id     
   -- Se crea el segundo JSON
   SET @jsonDespues = (SELECT [ID], [Nombre], [Password], [TipoUsuario], [FechaIngreso]
   FROM [dbo].[Usuario] WHERE [ID] = @id
   FOR JSON PATH)
   EXEC [dbo].spInsertarBitacoraCambios @inIdEntityType = 3,
										@inEntityID = @idModified, 
										@inJsonAntes = @jsonAntes,
										@inJsonDespues = @jsonDespues, 
										@inInsertedBy = @UsuarioACargo, 
										@inInsertedIn = @IPusuario, 
										@inInsertedAt = @insertedAt    
	end try	
	begin catch
		If @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW 50001, 'Error no se pudo editar usuario', 1
	end catch
End

go