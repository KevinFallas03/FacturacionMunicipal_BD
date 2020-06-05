--SP para insertar Usuario
use FacturacionMunicipal
go
Create or Alter procedure spInsertarUsuario
(
	@ID int,
	@Nombre VARCHAR(150),
	@Password VARCHAR(150),
	@TipoUsuario VARCHAR(150)
)
as
Begin
	Insert into [dbo].Usuario(ID, Nombre, Password, TipoUsuario, EstaBorrado )
	Values (@ID, @Nombre, @Password, @TipoUsuario, 0)
End
