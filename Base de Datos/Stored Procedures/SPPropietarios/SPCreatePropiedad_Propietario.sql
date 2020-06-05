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
	Insert into [dbo].Prop_Prop(IdPropietario, IdPropiedad, EstaBorrado)
	Values (@idPropietario, @idPropiedad, 0)
End