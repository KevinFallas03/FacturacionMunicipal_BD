--SP para eliminar los usuarios de Propiedades

create PROCEDURE [dbo].[spBorradoLogUsuario_Propiedad]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	FROM Usuario
	INNER JOIN Prop_Prop ON Prop_Prop.IdPropiedad=Usuario.ID
	WHERE Usuario.ID = @ID
END 