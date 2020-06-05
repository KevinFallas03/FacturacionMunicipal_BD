--SP para saber que propiedades no están con el propietario
Use FacturacionMunicipal
Go 

Create or Alter procedure [dbo].[spObtenerPropiedades_SinPropietario]
(
	@id int
)
as
	SELECT DISTINCT Propiedad.ID, Propiedad.NumFinca, Propiedad.Valor, Propiedad.Direccion
	FROM Prop_Prop
	FULL JOIN Propiedad ON Propiedad.ID=Prop_Prop.IdPropiedad
	FULL JOIN Propietario ON Prop_Prop.IdPropietario=Propietario.ID
	where Propietario.ID IS NULL or Propietario.ID <> @id and Propiedad.ID IS NOT NULL and Propietario.EstaBorrado = 0 and Propietario.EstaBorrado = 0 and Propiedad.EstaBorrado=0
	order by Propiedad.ID
	
go
