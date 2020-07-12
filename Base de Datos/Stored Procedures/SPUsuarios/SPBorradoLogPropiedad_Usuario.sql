--SP para eliminar las propiedades de Usuarios 

CREATE OR ALTER PROCEDURE [dbo].[spBorradoLogPropiedad_Usuario]
	@ID int
AS 
BEGIN
	If @ID is NULL
	BEGIN
		Return -1 --ocurrio un error
	END
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 