--SP para obtener los usuarios
use FacturacionMunicipal
go
Create procedure spObtenerPropiedades
as
Begin
	select NumFinca, Valor, Direccion 
	from [dbo].Propiedad
	where EstaBorrado = 0
End
