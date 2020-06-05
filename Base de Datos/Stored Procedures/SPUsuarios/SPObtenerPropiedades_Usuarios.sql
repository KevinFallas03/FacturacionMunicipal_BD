--SP para obtener las propiedades de usuarios 
use FacturacionMunicipal
go
Create or Alter procedure spObtenerPropiedades_Usuarios
(
	@id int
)
as
	SELECT Usuario_Prop.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Usuario.ID = @id and Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado = 0 and Propiedad.EstaBorrado=0

go