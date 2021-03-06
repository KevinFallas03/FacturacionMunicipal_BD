Use FacturacionMunicipal
Go

Create or Alter procedure [dbo].[spObtenerUsuarios_Propiedades]
(
	@id int
)
as
BEGIN
	If @id is null
	BEGIN
		return -1
	END 
	SELECT DISTINCT Usuario_Prop.ID, Usuario.Nombre, Usuario.Password, Usuario.TipoUsuario
	FROM Usuario_Prop
	INNER JOIN Propiedad ON Usuario_Prop.IdPropiedad=Propiedad.ID
	INNER JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where Propiedad.ID = @id and Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado=0 and Propiedad.EstaBorrado=0
END
Go
