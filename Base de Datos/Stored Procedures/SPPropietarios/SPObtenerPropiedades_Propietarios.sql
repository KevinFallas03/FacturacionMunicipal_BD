--SP para obtener los propiedades de propietarios
use FacturacionMunicipal
go
create procedure spObtenerPropiedades_Propietarios
(
	@id int
)
as
	SELECT Propiedad.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Prop_Prop
	INNER JOIN Propiedad ON Prop_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Propietario ON Prop_Prop.IdPropietario=Propietario.ID
	where Propietario.ID = @id and Prop_Prop.EstaBorrado = 0

go
