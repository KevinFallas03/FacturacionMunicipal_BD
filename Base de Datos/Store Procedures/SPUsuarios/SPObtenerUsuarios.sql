--SP para obtener los usuarios
use FacturacionMunicipal
go
Create procedure spObtenerUsuarios
as
Begin
	select ID, Nombre, Password, TipoUsuario 
	from [dbo].Usuario
End
