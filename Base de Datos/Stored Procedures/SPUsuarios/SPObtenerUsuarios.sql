--SP para obtener los usuarios
use FacturacionMunicipal
go
Create or Alter procedure spObtenerUsuarios
as
Begin
	select ID, Nombre, Password, TipoUsuario 
	from [dbo].Usuario
	where EstaBorrado = 0 
End
