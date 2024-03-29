--SP para saber que propiedades no están con el usuario

Create or alter procedure [dbo].[spObtenerPropiedades_SinUsuario]
(
	@id int
)
as
BEGIN
	If @id is NULL
	BEGIN
		return -1
	END
	SELECT DISTINCT Propiedad.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Usuario_Prop
	FULL JOIN Propiedad ON Propiedad.ID=Usuario_Prop.IdPropiedad
	FULL JOIN Usuario ON Usuario_Prop.IdUsuario=Usuario.ID
	where (Usuario.ID=@id and Propiedad.ID=Usuario_Prop.ID) or Usuario.ID IS NULL or Usuario.ID <> @id and Propiedad.ID IS NOT NULL and (Usuario_Prop.EstaBorrado = 0 and Usuario.EstaBorrado = 0 and Propiedad.EstaBorrado=0)
	order by Propiedad.ID
END
go
EXEC spObtenerPropiedades_SinUsuario @id=1

