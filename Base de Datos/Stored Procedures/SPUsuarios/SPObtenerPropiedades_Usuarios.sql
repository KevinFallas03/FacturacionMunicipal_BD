--SP para obtener los propiedades de usuarios
use FacturacionMunicipal
go
create procedure spObtenerPropiedades_Usuarios
(
	@id int
)
as
	SELECT Propiedad.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Usuario.ID = @id and Usuario_Prop.EstaBorrado = 0

go