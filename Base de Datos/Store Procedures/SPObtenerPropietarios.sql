--SP para obtener los propietarios
use FacturacionMunicipal
go
Create procedure spObtenerPropietarios
as
Begin
	select ID, Nombre, IdTipoDocumento, ValorDocumento 
	from [dbo].Propietario


End