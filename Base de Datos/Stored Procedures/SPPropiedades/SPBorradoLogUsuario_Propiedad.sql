--SP para eliminar los usuarios de Propiedades

create PROCEDURE [dbo].[spBorradoLogUsuario_Propiedad]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	WHERE ID = @ID
END 