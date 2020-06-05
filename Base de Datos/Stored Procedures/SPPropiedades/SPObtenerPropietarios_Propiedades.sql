--SP para obtener los propietarios de propiedades
use FacturacionMunicipal
go

Create or Alter procedure spObtenerPropietarios_Propiedades
(
	@id int
)
as
	SELECT Prop_Prop.ID, Propietario.Nombre, Propietario.IdTipoDocumento, Propietario.ValorDocumento
	FROM Prop_Prop
	INNER JOIN Propiedad ON Prop_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Propietario ON Prop_Prop.IdPropietario=Propietario.ID
	where Propiedad.ID = @id and Prop_Prop.EstaBorrado = 0 and Propiedad.EstaBorrado =0 and Propietario.EstaBorrado=0

go