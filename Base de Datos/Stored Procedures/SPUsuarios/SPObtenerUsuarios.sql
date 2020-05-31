--SP para obtener los usuarios
use FacturacionMunicipal
go
Create procedure spObtenerUsuarios
as
Begin
	select Nombre, Password, TipoUsuario 
	from [dbo].Usuario
	where EstaBorrado = 0 
End
