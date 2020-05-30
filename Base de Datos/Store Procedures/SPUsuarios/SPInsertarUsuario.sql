--SP para insertar Propietarios
use FacturacionMunicipal
go
Create procedure spInsertarUsuario
(
	@Nombre VARCHAR(100),
	@Password VARCHAR(100),
	@TipoUsuario VARCHAR(50)
)
as
Begin
	Insert into [dbo].Usuario (Nombre, Password, TipoUsuario)
	Values (@Nombre, @Password, @TipoUsuario)
End