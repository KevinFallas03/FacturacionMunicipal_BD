--SP para obtener los propietarios
use FacturacionMunicipal
go

Create or Alter procedure spObtenerPropietarios
as
Begin
	select ID, Nombre, IdTipoDocumento, ValorDocumento 
	from [dbo].Propietario
	where EstaBorrado = 0 and EstaBorrado = 0
End