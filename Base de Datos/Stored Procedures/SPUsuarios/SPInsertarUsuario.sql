--SP para insertar Usuario
use FacturacionMunicipal
go
Create or Alter procedure spInsertarUsuario
(
	@Nombre VARCHAR(150),
	@Password VARCHAR(150),
	@TipoUsuario VARCHAR(150)
)
as
Begin
	Insert into [dbo].Usuario(Nombre, Password, TipoUsuario, FechaIngreso, EstaBorrado )
	Values (@Nombre, @Password, @TipoUsuario, CONVERT(DATE,GETDATE()), 0)
End
