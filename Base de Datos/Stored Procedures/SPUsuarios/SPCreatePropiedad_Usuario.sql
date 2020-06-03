-- SP para crear enlaces entre propiedades y usuarios

alter procedure [dbo].[spCreatePropiedad_Usuario]
(
	@idU int,
	@idP int
)
as
Begin
	Insert into [dbo].Usuario_Prop(IdUsuario, IdPropiedad, EstaBorrado)
	Values (@idU, @idP, 0)
End