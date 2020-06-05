--SP para eliminar las propiedades de Usuarios 

CREATE OR ALTER PROCEDURE [dbo].[spBorradoLogPropiedad_Usuario]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 