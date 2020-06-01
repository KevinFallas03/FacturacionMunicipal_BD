--SP para eliminar las propiedades de Usuarios 

create PROCEDURE [dbo].[spBorradoLogPropiedad_Usuario]
	@ID int
AS 
BEGIN 
	UPDATE dbo.Usuario_Prop
	SET EstaBorrado=1
	FROM Propiedad
	INNER JOIN Usuario_Prop ON Usuario_Prop.IdPropiedad=Propiedad.ID
	WHERE Propiedad.ID = @ID
END 