-- SP para crear enlaces entre propiedades y usuarios

Create or alter procedure [dbo].[spCreatePropiedad_Usuario]
(
	@idU int,
	@idP int
)
as
Begin
	If @idU is NULL and @idP is NULL
	BEGIN
		Return -1 --ocurrio un error
	END
	Insert into [dbo].Usuario_Prop(IdUsuario, IdPropiedad, EstaBorrado)
	Values (@idU, @idP, 0)
End