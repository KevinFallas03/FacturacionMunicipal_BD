--SP para obtener los usuarios
use FacturacionMunicipal
go
Create procedure spObtenerPropiedades
as
Begin
	select ID, NumFinca, Valor, Direccion 
	from [dbo].Propiedad
End
