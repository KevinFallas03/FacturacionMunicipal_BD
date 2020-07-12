-- SP para crear enlaces entre propiedades y propietarios
Use FacturacionMunicipal
Go

Create or Alter procedure [dbo].[spCreatePropiedad_Propietario]
(
	@idPropietario int,
	@idPropiedad int
)
as
Begin
	If @idPropietario is NULL and @idPropiedad is NULL
	BEGIN
		Return -1
	END
	Insert into [dbo].Prop_Prop(IdPropietario, IdPropiedad, EstaBorrado)
	Values (@idPropietario, @idPropiedad, 0)
End