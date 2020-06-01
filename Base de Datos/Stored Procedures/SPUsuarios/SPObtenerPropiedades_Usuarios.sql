--SP para obtener los usuarios de propiedades
use FacturacionMunicipal
go
create procedure spObtenerUsuarios_Propiedades
(
	@id int
)
as
	SELECT Usuario_Prop.ID, Usuario.Nombre, Usuario.Password, Usuario.TipoUsuario
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Propiedad.ID = @id and Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado = 0 and Propiedad.EstaBorrado=0

go