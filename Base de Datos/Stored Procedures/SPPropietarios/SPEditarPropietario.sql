use FacturacionMunicipal
go

Create or Alter procedure spEditarPropietario  
(      
	@id int,
	@Nombre VARCHAR(100),
	@IdTipoDocumento int,
	@ValorDocumento VARCHAR(30),
	@UsuarioACargo varchar(20),
	@IPusuario varchar(20)
)      
as      
begin  
    If @id is NULL
	BEGIN
		Return -1
	END 
	declare @jsonAntes varchar(500), @jsonDespues varchar(500), @idModified int, @insertedAt DATETIME
	   SET @insertedAt = GETDATE()
	   SET @idModified = (SELECT [ID] FROM [dbo].[Propietario] WHERE [ID] = @id)
	   -- Se crea el primer JSON
	   SET @jsonAntes = (SELECT [id], [nombre], [IdTipoDocumento], [ValorDocumento], [FechaIngreso]
	   FROM [dbo].[Propietario] WHERE [ID] = @id
	   FOR JSON PATH)
	   Update [dbo].Propietario
	   set Nombre=@Nombre, IdTipoDocumento=@IdTipoDocumento, ValorDocumento=@ValorDocumento
	   where ID=@id and EstaBorrado = 0   
	   -- Se crea el segundo JSON
	   SET @jsonDespues = (SELECT [ID], [Nombre], [IdTipoDocumento], [ValorDocumento], [FechaIngreso]
	   FROM [dbo].[Propietario] WHERE [ID] = @id
	   FOR JSON PATH)
	   EXEC [dbo].spInsertarBitacoraCambios @inIdEntityType = 2,
											@inEntityID = @idModified, 
											@inJsonAntes = @jsonAntes,
											@inJsonDespues = @jsonDespues, 
											@inInsertedBy = @UsuarioACargo, 
											@inInsertedIn = @IPusuario, 
											@inInsertedAt = @insertedAt
	End

go