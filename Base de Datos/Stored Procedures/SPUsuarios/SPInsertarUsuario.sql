--SP para insertar Usuario
use FacturacionMunicipal
go
Create procedure spInsertarUsuario
(
	@Nombre int,
	@Password VARCHAR(150),
	@TipoUsuario VARCHAR(150)
)
as
Begin
	Insert into [dbo].Usuario(Nombre, Password, TipoUsuario, EstaBorrado )
	Values (@Nombre, @Password, @TipoUsuario, 0)
End
